package org.dromara.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.domain.BizSalesOrderDetail;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderDetailVo;
import org.dromara.system.mapper.BizSalesOrderDetailMapper;
import org.dromara.system.service.IBizSalesOrderDetailService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

/**
 * 销售订单明细 Service 业务层处理
 */
@RequiredArgsConstructor
@Service
public class BizSalesOrderDetailServiceImpl implements IBizSalesOrderDetailService {

    private final BizSalesOrderDetailMapper baseMapper;

    @Override
    public BizSalesOrderDetailVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizSalesOrderDetailVo> queryPageList(BizSalesOrderDetailBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizSalesOrderDetail> lqw = buildQueryWrapper(bo);
        Page<BizSalesOrderDetailVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizSalesOrderDetailVo> queryList(BizSalesOrderDetailBo bo) {
        LambdaQueryWrapper<BizSalesOrderDetail> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizSalesOrderDetail> buildQueryWrapper(BizSalesOrderDetailBo bo) {
        LambdaQueryWrapper<BizSalesOrderDetail> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getSalesOrderId() != null, BizSalesOrderDetail::getSalesOrderId, bo.getSalesOrderId());
        lqw.like(org.dromara.common.core.utils.StringUtils.isNotBlank(bo.getProductName()), BizSalesOrderDetail::getProductName, bo.getProductName());
        return lqw;
    }

    @Override
    public Boolean insertByBo(BizSalesOrderDetailBo bo) {
        BizSalesOrderDetail add = MapstructUtils.convert(bo, BizSalesOrderDetail.class);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(BizSalesOrderDetailBo bo) {
        BizSalesOrderDetail update = MapstructUtils.convert(bo, BizSalesOrderDetail.class);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        // 【修复警告】：改为 deleteByIds
        return baseMapper.deleteByIds(ids) > 0;
    }
}
