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
@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizPurchaseServiceImpl implements IBizPurchaseService {

    private final BizPurchaseMapper baseMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizInventoryMapper inventoryMapper;

    @Override
    public BizPurchaseVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizPurchaseVo> queryPageList(BizPurchaseBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizPurchase> lqw = buildQueryWrapper(bo);
        Page<BizPurchaseVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizPurchaseVo> queryList(BizPurchaseBo bo) {
        LambdaQueryWrapper<BizPurchase> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizPurchase> buildQueryWrapper(BizPurchaseBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizPurchase> lqw = Wrappers.lambdaQuery();
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

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizPurchaseBo bo) {
        // 1. 先查出修改前的老数据
        BizPurchase oldData = baseMapper.selectById(bo.getId());
        if (oldData == null) return false;

        BizPurchase update = MapstructUtils.convert(bo, BizPurchase.class);
        validEntityBeforeSave(update);

        boolean flag = baseMapper.updateById(update) > 0;

        // 2. 状态机流转：如果状态【变成了已验收】，且之前【不是已验收】，则执行入库逻辑！
        if (flag && "2".equals(bo.getStatus()) && !"2".equals(oldData.getStatus())) {
            handleInventoryInbound(bo);
        }

        return flag;
    }

    /**
     * 自动转入库存逻辑
     */
    private void handleInventoryInbound(BizPurchaseBo bo) {
        // 根据物品名称和规格，在库存中寻找是否已有该材料
        LambdaQueryWrapper<org.dromara.system.domain.BizInventory> lqw = new LambdaQueryWrapper<>();
        lqw.eq(org.dromara.system.domain.BizInventory::getItemName, bo.getItemName());
        if (StringUtils.isNotBlank(bo.getSpec())) {
            lqw.eq(org.dromara.system.domain.BizInventory::getSpec, bo.getSpec());
        }
        lqw.last("limit 1");

        org.dromara.system.domain.BizInventory inv = inventoryMapper.selectOne(lqw);

        // 提取本次真实验收的数量
        java.math.BigDecimal incomingQty = bo.getReceivedQty() != null ? bo.getReceivedQty() : bo.getApplyQty();

        // 👉 安全提取单价：使用终极 String 转换法彻底断绝格式报错
        java.math.BigDecimal safePrice = java.math.BigDecimal.ZERO;
        if (bo.getPrice() != null) {
            safePrice = new java.math.BigDecimal(String.valueOf(bo.getPrice()));
        }

        if (inv != null) {
            // 如果仓库里已有该材料 -> 累加库存，并覆盖最新价格
            inv.setCurrentQty(inv.getCurrentQty().add(incomingQty));
            inv.setPurchasePrice(safePrice);
            inv.setTotalAmount(inv.getCurrentQty().multiply(safePrice));
            inventoryMapper.updateById(inv);
        } else {
            // 如果仓库里没有该材料 -> 新建一条库存记录
            inv = new org.dromara.system.domain.BizInventory();
            inv.setItemName(bo.getItemName());
            inv.setSpec(bo.getSpec());
            inv.setItemType("纸张"); // 默认归类为纸张原材料
            inv.setCurrentQty(incomingQty);
            inv.setUnit("张");
            inv.setSupplierId(bo.getSupplierId());
            inv.setPurchasePrice(safePrice);
            inv.setTotalAmount(incomingQty.multiply(safePrice));
            inventoryMapper.insert(inv);
        }
    }

    private void validEntityBeforeSave(BizPurchase entity){
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
