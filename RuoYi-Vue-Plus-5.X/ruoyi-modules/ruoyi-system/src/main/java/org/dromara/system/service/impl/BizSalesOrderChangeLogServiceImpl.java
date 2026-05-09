package org.dromara.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.domain.BizSalesOrderChangeLog;
import org.dromara.system.domain.bo.BizSalesOrderChangeLogBo;
import org.dromara.system.domain.vo.BizSalesOrderChangeLogVo;
import org.dromara.system.mapper.BizSalesOrderChangeLogMapper;
import org.dromara.system.service.IBizSalesOrderChangeLogService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 销售订单变更日志 Service 业务层处理
 */
@RequiredArgsConstructor
@Service
public class BizSalesOrderChangeLogServiceImpl implements IBizSalesOrderChangeLogService {

    private final BizSalesOrderChangeLogMapper baseMapper;

    @Override
    public BizSalesOrderChangeLogVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizSalesOrderChangeLogVo> queryPageList(BizSalesOrderChangeLogBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizSalesOrderChangeLog> lqw = buildQueryWrapper(bo);
        Page<BizSalesOrderChangeLogVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizSalesOrderChangeLogVo> queryList(BizSalesOrderChangeLogBo bo) {
        return baseMapper.selectVoList(buildQueryWrapper(bo));
    }

    private LambdaQueryWrapper<BizSalesOrderChangeLog> buildQueryWrapper(BizSalesOrderChangeLogBo bo) {
        LambdaQueryWrapper<BizSalesOrderChangeLog> lqw = Wrappers.lambdaQuery();
        // 核心查询条件：根据主订单ID查
        lqw.eq(bo.getSalesOrderId() != null, BizSalesOrderChangeLog::getSalesOrderId, bo.getSalesOrderId());
        // 可选查询条件：根据具体的某个产品明细查
        lqw.eq(bo.getDetailId() != null, BizSalesOrderChangeLog::getDetailId, bo.getDetailId());

        // 默认按操作时间倒序排列，保证最新的改动在最上面
        lqw.orderByDesc(BizSalesOrderChangeLog::getOperateTime);
        return lqw;
    }

    @Override
    public Boolean insertByBo(BizSalesOrderChangeLogBo bo) {
        BizSalesOrderChangeLog add = MapstructUtils.convert(bo, BizSalesOrderChangeLog.class);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }
}
