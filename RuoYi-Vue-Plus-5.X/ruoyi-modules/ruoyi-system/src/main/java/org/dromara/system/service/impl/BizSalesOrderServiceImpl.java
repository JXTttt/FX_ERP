package org.dromara.system.service.impl;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.redis.utils.RedisUtils;
import org.dromara.common.satoken.utils.LoginHelper; // 【修复点1：使用 Sa-Token 的 LoginHelper】
import org.dromara.system.domain.BizSalesOrder;
import org.dromara.system.domain.BizSalesOrderChangeLog;
import org.dromara.system.domain.BizSalesOrderDetail;
import org.dromara.system.domain.bo.BizSalesOrderBo;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderDetailVo;
import org.dromara.system.domain.vo.BizSalesOrderVo;
import org.dromara.system.mapper.BizSalesOrderChangeLogMapper;
import org.dromara.system.mapper.BizSalesOrderDetailMapper;
import org.dromara.system.mapper.BizSalesOrderMapper;
import org.dromara.system.service.IBizSalesOrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@RequiredArgsConstructor
@Service
public class BizSalesOrderServiceImpl implements IBizSalesOrderService {

    private final BizSalesOrderMapper baseMapper;
    private final BizSalesOrderDetailMapper detailMapper;
    private final BizSalesOrderChangeLogMapper logMapper;

    @Override
    public BizSalesOrderVo queryById(Long id) {
        BizSalesOrderVo vo = baseMapper.selectVoById(id);
        if (vo != null) {
            // 查询并塞入子表明细，供前端回显
            List<BizSalesOrderDetailVo> detailList = detailMapper.selectVoList(
                new LambdaQueryWrapper<BizSalesOrderDetail>().eq(BizSalesOrderDetail::getSalesOrderId, id)
            );
            vo.setDetailList(detailList);
        }
        return vo;
    }

    @Override
    public TableDataInfo<BizSalesOrderVo> queryPageList(BizSalesOrderBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizSalesOrder> lqw = buildQueryWrapper(bo);
        Page<BizSalesOrderVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);

        // ==========================================
        // 【新增核心修复】：在分页查询时，顺便把订单底下的“产品明细”查出来带给前端
        // ==========================================
        if (result.getRecords() != null && !result.getRecords().isEmpty()) {
            for (BizSalesOrderVo vo : result.getRecords()) {
                List<BizSalesOrderDetailVo> detailList = detailMapper.selectVoList(
                    new LambdaQueryWrapper<BizSalesOrderDetail>().eq(BizSalesOrderDetail::getSalesOrderId, vo.getId())
                );
                vo.setDetailList(detailList);
            }
        }

        return TableDataInfo.build(result);
    }

    @Override
    public List<BizSalesOrderVo> queryList(BizSalesOrderBo bo) {
        return baseMapper.selectVoList(buildQueryWrapper(bo));
    }

    private LambdaQueryWrapper<BizSalesOrder> buildQueryWrapper(BizSalesOrderBo bo) {
        LambdaQueryWrapper<BizSalesOrder> lqw = Wrappers.lambdaQuery();
        lqw.eq(StringUtils.isNotBlank(bo.getOrderNo()), BizSalesOrder::getOrderNo, bo.getOrderNo());
        lqw.eq(bo.getCustomerId() != null, BizSalesOrder::getCustomerId, bo.getCustomerId());
        lqw.eq(bo.getStatus() != null, BizSalesOrder::getStatus, bo.getStatus());
        return lqw;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(BizSalesOrderBo bo) {
        // 1. 核心：调用 Redis 自动生成销售订单流水号 (如：SO2604280001)
        if (StringUtils.isBlank(bo.getOrderNo())) {
            String dateStr = DateUtil.format(new Date(), "yyMMdd");
            String redisKey = "erp:sales_order_seq:" + dateStr;

            Long currentSeq = RedisUtils.incrAtomicValue(redisKey);
            // 每天的单号独立，保留2天即自动销毁，节省内存
            if (currentSeq == 1L) {
                RedisUtils.expire(redisKey, Duration.ofDays(2));
            }
            bo.setOrderNo("SO" + dateStr + String.format("%04d", currentSeq));
        }

        BizSalesOrder add = MapstructUtils.convert(bo, BizSalesOrder.class);
        // 新创建的订单默认状态：0-待排单
        add.setStatus(0);

        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
            // 插入主表成功后，插入子表
            insertDetail(bo);
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizSalesOrderBo bo) {
        BizSalesOrder update = MapstructUtils.convert(bo, BizSalesOrder.class);
        boolean flag = baseMapper.updateById(update) > 0;
        if (flag) {
            // 简单粗暴且安全的子表更新策略：先删后插
            detailMapper.delete(new LambdaQueryWrapper<BizSalesOrderDetail>().eq(BizSalesOrderDetail::getSalesOrderId, bo.getId()));
            insertDetail(bo);
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        boolean flag = baseMapper.deleteByIds(ids) > 0;
        if (flag) {
            // 主表删除成功后，级联删除所有相关的明细表数据
            for (Long id : ids) {
                detailMapper.delete(new LambdaQueryWrapper<BizSalesOrderDetail>().eq(BizSalesOrderDetail::getSalesOrderId, id));
            }
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateDetailWithSilencedLog(BizSalesOrderDetailBo detailBo) {
        BizSalesOrder order = baseMapper.selectById(detailBo.getSalesOrderId());
        if (order == null || order.getStatus() == 3) {
            throw new ServiceException("订单状态已锁定，禁止修改");
        }

        BizSalesOrderDetail oldDetail = detailMapper.selectById(detailBo.getId());

        // 【修复点2：使用 LoginHelper 获取当前登录信息】
        String currentUsername = LoginHelper.getUsername();
        Date now = new Date();

        // 仅在“待客确(1)”或“生产中(2)”状态记录详细Diff
        if (order.getStatus() == 1 || order.getStatus() == 2) {
            if (!Objects.equals(oldDetail.getUnitPrice(), detailBo.getUnitPrice())) {
                saveChangeLog(order.getId(), detailBo.getId(), "不含税单价",
                    String.valueOf(oldDetail.getUnitPrice()), String.valueOf(detailBo.getUnitPrice()), currentUsername, currentUsername, now);
            }
            if (!StringUtils.equals(oldDetail.getCraftReq(), detailBo.getCraftReq())) {
                saveChangeLog(order.getId(), detailBo.getId(), "工艺要求",
                    oldDetail.getCraftReq(), detailBo.getCraftReq(), currentUsername, currentUsername, now);
            }
        }

        BizSalesOrderDetail updateEntity = MapstructUtils.convert(detailBo, BizSalesOrderDetail.class);
        detailMapper.updateById(updateEntity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void confirmDelivery(Long orderId) {
        BizSalesOrder order = baseMapper.selectById(orderId);
        if (order.getStatus() != 2) {
            throw new ServiceException("只有生产中的订单才能进行发货确认");
        }
        order.setStatus(3);

        // 【修复报错】：使用 getUserId() 获取 Long 类型的操作人ID
        order.setUpdateBy(LoginHelper.getUserId());
        order.setUpdateTime(new Date());

        baseMapper.updateById(order);
    }

    private void saveChangeLog(Long orderId, Long detailId, String field, String oldVal, String newVal, String operatorBy, String operateName, Date time) {
        BizSalesOrderChangeLog log = new BizSalesOrderChangeLog();
        log.setSalesOrderId(orderId);
        log.setDetailId(detailId);
        log.setChangeField(field);
        log.setOldValue(oldVal);
        log.setNewValue(newVal);
        log.setOperateBy(operatorBy);
        log.setOperateName(operateName); // 为了稳妥，姓名这里我也直接塞了账号名，防止没有配置昵称报错
        log.setOperateTime(time);
        logMapper.insert(log);
    }

    /**
     * 【抽取的方法】：批量插入订单明细
     */
    private void insertDetail(BizSalesOrderBo bo) {
        if (bo.getDetailList() != null && !bo.getDetailList().isEmpty()) {
            List<BizSalesOrderDetail> list = MapstructUtils.convert(bo.getDetailList(), BizSalesOrderDetail.class);
            for (BizSalesOrderDetail detail : list) {
                // 强制绑定主表ID
                detail.setSalesOrderId(bo.getId());
                // 强制置空明细ID，防止前端传来脏数据导致主键冲突
                detail.setId(null);
            }
            detailMapper.insertBatch(list);
        }
    }
}
