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
import org.dromara.system.domain.BizCustomer;
import org.dromara.system.mapper.BizCustomerMapper;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.dromara.system.mapper.BizInventoryMapper;
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
    private final BizInventoryMapper inventoryMapper;

    // 财务流水 Mapper
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final BizFinanceRecordMapper financeRecordMapper;

    // 注入客户/供应商 Mapper（用来查供应商名字）
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final BizCustomerMapper customerMapper;

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
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<BizPurchase> lqw = buildQueryWrapper(bo);
        List<BizPurchaseVo> list = baseMapper.selectVoList(lqw);

        // ================= 核心翻译逻辑：导出时展示供应商真实名称 =================
        for (BizPurchaseVo vo : list) {
            if (vo.getSupplierId() != null) {
                try {
                    org.dromara.system.domain.BizCustomer customer = customerMapper.selectById(vo.getSupplierId());
                    if (customer != null) {
                        vo.setSupplierName(customer.getCompanyName());
                    } else {
                        vo.setSupplierName("未知供应商");
                    }
                } catch (Exception e) {
                    vo.setSupplierName("解析失败");
                }
            }
        }
        // =====================================================================

        return list;
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
    private void handleInventoryInbound(org.dromara.system.domain.bo.BizPurchaseBo bo) {
        // 根据物品名称和规格，在库存中寻找是否已有该材料
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizInventory> lqw = new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        lqw.eq(org.dromara.system.domain.BizInventory::getItemName, bo.getItemName());
        if (org.dromara.common.core.utils.StringUtils.isNotBlank(bo.getSpec())) {
            lqw.eq(org.dromara.system.domain.BizInventory::getSpec, bo.getSpec());
        }
        lqw.last("limit 1");

        org.dromara.system.domain.BizInventory inv = inventoryMapper.selectOne(lqw);

        // 提取本次真实验收的数量
        java.math.BigDecimal incomingQty = bo.getReceivedQty() != null ? bo.getReceivedQty() : bo.getApplyQty();

        // 安全提取单价
        java.math.BigDecimal safePrice = java.math.BigDecimal.ZERO;
        if (bo.getPrice() != null) {
            safePrice = new java.math.BigDecimal(String.valueOf(bo.getPrice()));
        }

        if (inv != null) {
            // 👉 进阶修复：使用 setSql 交给数据库去累加，彻底断绝高并发下的超卖/少加问题
            inventoryMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizInventory>lambdaUpdate()
                .eq(org.dromara.system.domain.BizInventory::getId, inv.getId())
                .setSql("current_qty = current_qty + " + incomingQty)
                .setSql("total_amount = (current_qty + " + incomingQty + ") * " + safePrice)
                .set(org.dromara.system.domain.BizInventory::getPurchasePrice, safePrice)
            );
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

        // ================= 业财联动：生成应付款，并增加供应商总欠款 =================
        java.math.BigDecimal totalMoney = incomingQty.multiply(safePrice);
        if (totalMoney.compareTo(java.math.BigDecimal.ZERO) > 0) {
            org.dromara.system.domain.BizFinanceRecord finance = new org.dromara.system.domain.BizFinanceRecord();
            finance.setRecordNo("FIN-CG-" + System.currentTimeMillis());
            finance.setRecordType("2"); // 2-支出/应付
            finance.setBusinessType("采购入库");
            finance.setRelatedNo(bo.getPurchaseNo());
            finance.setAmount(totalMoney);
            finance.setSettlementStatus("0"); // 默认未结清(挂账)

            String targetName = String.valueOf(bo.getSupplierId());
            if (bo.getSupplierId() != null) {
                org.dromara.system.domain.BizCustomer customer = customerMapper.selectById(bo.getSupplierId());
                if (customer != null && customer.getCompanyName() != null) {
                    targetName = customer.getCompanyName();

                    // 👉 核心修复：同步增加供应商欠款 (使用 COALESCE 防止 null 值报错，直接交由 SQL 计算)
                    customerMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizCustomer>lambdaUpdate()
                        .eq(org.dromara.system.domain.BizCustomer::getId, bo.getSupplierId())
                        .setSql("total_owe_amount = COALESCE(total_owe_amount, 0) + " + totalMoney)
                    );
                }
            }
            finance.setTargetName(targetName);
            finance.setRemark("采购验收自动产生应付款，物资: " + bo.getItemName() + "，数量: " + incomingQty);

            financeRecordMapper.insert(finance);
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
