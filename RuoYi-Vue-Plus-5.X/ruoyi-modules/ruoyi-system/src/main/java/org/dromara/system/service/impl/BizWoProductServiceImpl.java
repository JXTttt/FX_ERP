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
import org.dromara.system.domain.bo.BizWoProductBo;
import org.dromara.system.domain.vo.BizWoProductVo;
import org.dromara.system.domain.BizWoProduct;
import org.dromara.system.mapper.BizWoProductMapper;
import org.dromara.system.service.IBizWoProductService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单产品明细子Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoProductServiceImpl implements IBizWoProductService {

    private final BizWoProductMapper baseMapper;

    /**
     * 查询工单产品明细子
     *
     * @param id 主键
     * @return 工单产品明细子
     */
    @Override
    public BizWoProductVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单产品明细子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单产品明细子分页列表
     */
    @Override
    public TableDataInfo<BizWoProductVo> queryPageList(BizWoProductBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoProduct> lqw = buildQueryWrapper(bo);
        Page<BizWoProductVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单产品明细子列表
     *
     * @param bo 查询条件
     * @return 工单产品明细子列表
     */
    @Override
    public List<BizWoProductVo> queryList(BizWoProductBo bo) {
        LambdaQueryWrapper<BizWoProduct> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoProduct> buildQueryWrapper(BizWoProductBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoProduct> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoProduct::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoProduct::getWorkOrderId, bo.getWorkOrderId());
        lqw.like(StringUtils.isNotBlank(bo.getProductName()), BizWoProduct::getProductName, bo.getProductName());
        lqw.eq(StringUtils.isNotBlank(bo.getCustomerPo()), BizWoProduct::getCustomerPo, bo.getCustomerPo());
        lqw.eq(StringUtils.isNotBlank(bo.getCustomerMaterialNo()), BizWoProduct::getCustomerMaterialNo, bo.getCustomerMaterialNo());
        lqw.eq(StringUtils.isNotBlank(bo.getSpec()), BizWoProduct::getSpec, bo.getSpec());
        lqw.eq(StringUtils.isNotBlank(bo.getLayers()), BizWoProduct::getLayers, bo.getLayers());
        lqw.eq(StringUtils.isNotBlank(bo.getKnifePlateNo()), BizWoProduct::getKnifePlateNo, bo.getKnifePlateNo());
        lqw.eq(bo.getOrderQuantity() != null, BizWoProduct::getOrderQuantity, bo.getOrderQuantity());
        lqw.eq(bo.getProduceQuantity() != null, BizWoProduct::getProduceQuantity, bo.getProduceQuantity());
        lqw.eq(StringUtils.isNotBlank(bo.getUnit()), BizWoProduct::getUnit, bo.getUnit());
        lqw.eq(bo.getUnitPrice() != null, BizWoProduct::getUnitPrice, bo.getUnitPrice());
        lqw.eq(bo.getTotalAmount() != null, BizWoProduct::getTotalAmount, bo.getTotalAmount());
        return lqw;
    }

    /**
     * 新增工单产品明细子
     *
     * @param bo 工单产品明细子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoProductBo bo) {
        BizWoProduct add = MapstructUtils.convert(bo, BizWoProduct.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单产品明细子
     *
     * @param bo 工单产品明细子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoProductBo bo) {
        BizWoProduct update = MapstructUtils.convert(bo, BizWoProduct.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoProduct entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单产品明细子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
