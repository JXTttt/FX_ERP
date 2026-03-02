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
import org.dromara.system.domain.bo.BizPurchaseBo;
import org.dromara.system.domain.vo.BizPurchaseVo;
import org.dromara.system.domain.BizPurchase;
import org.dromara.system.mapper.BizPurchaseMapper;
import org.dromara.system.service.IBizPurchaseService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 采购管理Service业务层处理
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizPurchaseServiceImpl implements IBizPurchaseService {

    private final BizPurchaseMapper baseMapper;

    /**
     * 查询采购管理
     *
     * @param id 主键
     * @return 采购管理
     */
    @Override
    public BizPurchaseVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询采购管理列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 采购管理分页列表
     */
    @Override
    public TableDataInfo<BizPurchaseVo> queryPageList(BizPurchaseBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizPurchase> lqw = buildQueryWrapper(bo);
        Page<BizPurchaseVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的采购管理列表
     *
     * @param bo 查询条件
     * @return 采购管理列表
     */
    @Override
    public List<BizPurchaseVo> queryList(BizPurchaseBo bo) {
        LambdaQueryWrapper<BizPurchase> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizPurchase> buildQueryWrapper(BizPurchaseBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizPurchase> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizPurchase::getId);
        lqw.eq(StringUtils.isNotBlank(bo.getPurchaseNo()), BizPurchase::getPurchaseNo, bo.getPurchaseNo());
        lqw.eq(StringUtils.isNotBlank(bo.getRelatedWoNo()), BizPurchase::getRelatedWoNo, bo.getRelatedWoNo());
        lqw.eq(bo.getSupplierId() != null, BizPurchase::getSupplierId, bo.getSupplierId());
        lqw.like(StringUtils.isNotBlank(bo.getItemName()), BizPurchase::getItemName, bo.getItemName());
        lqw.eq(StringUtils.isNotBlank(bo.getSpec()), BizPurchase::getSpec, bo.getSpec());
        lqw.eq(bo.getApplyQty() != null, BizPurchase::getApplyQty, bo.getApplyQty());
        lqw.eq(bo.getReceivedQty() != null, BizPurchase::getReceivedQty, bo.getReceivedQty());
        lqw.eq(bo.getPrice() != null, BizPurchase::getPrice, bo.getPrice());
        lqw.eq(bo.getTotalPrice() != null, BizPurchase::getTotalPrice, bo.getTotalPrice());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), BizPurchase::getStatus, bo.getStatus());
        lqw.eq(bo.getApplicantId() != null, BizPurchase::getApplicantId, bo.getApplicantId());
        lqw.eq(bo.getVerifyTime() != null, BizPurchase::getVerifyTime, bo.getVerifyTime());
        lqw.eq(bo.getDeliveryDate() != null, BizPurchase::getDeliveryDate, bo.getDeliveryDate());
        return lqw;
    }

    /**
     * 新增采购管理
     *
     * @param bo 采购管理
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizPurchaseBo bo) {
        BizPurchase add = MapstructUtils.convert(bo, BizPurchase.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改采购管理
     *
     * @param bo 采购管理
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizPurchaseBo bo) {
        BizPurchase update = MapstructUtils.convert(bo, BizPurchase.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizPurchase entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除采购管理信息
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
