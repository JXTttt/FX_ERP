package org.dromara.system.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizFinanceRecordBo;
import org.dromara.system.domain.vo.BizFinanceRecordVo;
import org.dromara.system.domain.BizFinanceRecord;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.dromara.system.service.IBizFinanceRecordService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizFinanceRecordServiceImpl implements IBizFinanceRecordService {

    private final BizFinanceRecordMapper baseMapper;

    // 👉 注入临时工 Mapper，用于实现反向状态联动
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizTempWorkerMapper tempWorkerMapper;

    @Override
    public BizFinanceRecordVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizFinanceRecordVo> queryPageList(BizFinanceRecordBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizFinanceRecord> lqw = buildQueryWrapper(bo);
        Page<BizFinanceRecordVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizFinanceRecordVo> queryList(BizFinanceRecordBo bo) {
        LambdaQueryWrapper<BizFinanceRecord> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizFinanceRecord> buildQueryWrapper(BizFinanceRecordBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizFinanceRecord> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getRecordNo()), BizFinanceRecord::getRecordNo, bo.getRecordNo());
        lqw.eq(StringUtils.isNotBlank(bo.getRecordType()), BizFinanceRecord::getRecordType, bo.getRecordType());
        lqw.eq(StringUtils.isNotBlank(bo.getBusinessType()), BizFinanceRecord::getBusinessType, bo.getBusinessType());
        lqw.eq(StringUtils.isNotBlank(bo.getRelatedNo()), BizFinanceRecord::getRelatedNo, bo.getRelatedNo());
        lqw.like(StringUtils.isNotBlank(bo.getTargetName()), BizFinanceRecord::getTargetName, bo.getTargetName());
        lqw.eq(StringUtils.isNotBlank(bo.getSettlementStatus()), BizFinanceRecord::getSettlementStatus, bo.getSettlementStatus());

        // 👉 终极防御：先判断不为null，再提取为字符串判断不为空串
        if (params != null && params.get("beginTime") != null && params.get("endTime") != null) {
            String beginTime = params.get("beginTime").toString();
            String endTime = params.get("endTime").toString();
            if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
                lqw.between(BizFinanceRecord::getCreateTime, beginTime, endTime);
            }
        }

        return lqw;
    }

    @Override
    public Boolean insertByBo(BizFinanceRecordBo bo) {
        BizFinanceRecord add = MapstructUtils.convert(bo, BizFinanceRecord.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizFinanceRecordBo bo) {
        BizFinanceRecord oldData = baseMapper.selectById(bo.getId());
        if (oldData == null) return false;

        // 1. 结清锁：如果已经是"2-已结清"，严禁一切修改
        if ("2".equals(oldData.getSettlementStatus()) && "2".equals(bo.getSettlementStatus())) {
            throw new org.dromara.common.core.exception.ServiceException("该财务账单已核销结清，作为正式凭证严禁任何修改！");
        }

        // 2. 源单锁：如果不是手工账(不以FIN-MN开头)，强行覆盖前端传来的核心金额和业务数据，保证绝对不被篡改
        if (oldData.getRecordNo() != null && !oldData.getRecordNo().startsWith("FIN-MN-")) {
            bo.setAmount(oldData.getAmount()); // 强行拉回原金额
            bo.setRecordType(oldData.getRecordType());
            bo.setBusinessType(oldData.getBusinessType());
            bo.setRelatedNo(oldData.getRelatedNo());
            bo.setTargetName(oldData.getTargetName());
        }

        BizFinanceRecord update = MapstructUtils.convert(bo, BizFinanceRecord.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        // 👉 3. 业财反向联动：如果本次操作是“核销结清”
        if (flag && "2".equals(bo.getSettlementStatus()) && !"2".equals(oldData.getSettlementStatus())) {
            // 如果是临时工费，反向更新临时工登记表的状态
            if ("临时工费".equals(oldData.getBusinessType()) && oldData.getRecordNo() != null && oldData.getRecordNo().startsWith("FIN-TW-")) {
                String twIdStr = oldData.getRecordNo().replace("FIN-TW-", "");
                try {
                    Long twId = Long.parseLong(twIdStr);
                    org.dromara.system.domain.BizTempWorker tw = tempWorkerMapper.selectById(twId);
                    if (tw != null && !"1".equals(tw.getPayStatus())) {
                        tw.setPayStatus("1"); // 设为 1-已付
                        tempWorkerMapper.updateById(tw);
                    }
                } catch (Exception e) {
                    log.error("反向核销临时工状态失败", e);
                }
            }
            // (未来如果委外加工需要反向联动，也可以写在这里)
        }

        return flag;
    }

    private void validEntityBeforeSave(BizFinanceRecord entity){
        // TODO 做一些数据校验
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        for (Long id : ids) {
            BizFinanceRecord oldData = baseMapper.selectById(id);
            if (oldData != null) {
                if ("2".equals(oldData.getSettlementStatus())) {
                    throw new org.dromara.common.core.exception.ServiceException("删除失败：包含已结清的财务凭证，严禁删除！");
                }
                if (oldData.getRecordNo() != null && !oldData.getRecordNo().startsWith("FIN-MN-")) {
                    throw new org.dromara.common.core.exception.ServiceException("拦截删除：业务系统自动生成的财务流水，必须由源单据撤销操作，严禁在财务总账直接删除！");
                }
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
