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
import org.dromara.system.domain.bo.BizProductionScheduleBo;
import org.dromara.system.domain.vo.BizProductionScheduleVo;
import org.dromara.system.domain.BizProductionSchedule;
import org.dromara.system.mapper.BizProductionScheduleMapper;
import org.dromara.system.service.IBizProductionScheduleService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 生产排产主Service业务层处理
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizProductionScheduleServiceImpl implements IBizProductionScheduleService {

    private final BizProductionScheduleMapper baseMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizInventoryMapper inventoryMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizWoProductMapper woProductMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizWorkOrderMapper workOrderMapper;

    @Override
    public BizProductionScheduleVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizProductionScheduleVo> queryPageList(BizProductionScheduleBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizProductionSchedule> lqw = buildQueryWrapper(bo);
        Page<BizProductionScheduleVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizProductionScheduleVo> queryList(BizProductionScheduleBo bo) {
        LambdaQueryWrapper<BizProductionSchedule> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizProductionSchedule> buildQueryWrapper(BizProductionScheduleBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizProductionSchedule> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizProductionSchedule::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizProductionSchedule::getWorkOrderId, bo.getWorkOrderId());
        lqw.eq(StringUtils.isNotBlank(bo.getWorkOrderNo()), BizProductionSchedule::getWorkOrderNo, bo.getWorkOrderNo());
        lqw.like(StringUtils.isNotBlank(bo.getItemName()), BizProductionSchedule::getItemName, bo.getItemName());
        lqw.eq(bo.getQuantity() != null, BizProductionSchedule::getQuantity, bo.getQuantity());
        lqw.eq(bo.getDeliveryDate() != null, BizProductionSchedule::getDeliveryDate, bo.getDeliveryDate());
        return lqw;
    }

    @Override
    public Boolean insertByBo(BizProductionScheduleBo bo) {
        BizProductionSchedule add = MapstructUtils.convert(bo, BizProductionSchedule.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(BizProductionScheduleBo bo) {
        BizProductionSchedule update = MapstructUtils.convert(bo, BizProductionSchedule.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    private void validEntityBeforeSave(BizProductionSchedule entity){
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean completeProduction(Long id) {
        org.dromara.system.domain.BizProductionSchedule schedule = baseMapper.selectById(id);
        if (schedule == null) return false;

        java.math.BigDecimal incomingQty = new java.math.BigDecimal(schedule.getQuantity());

        // 👉 核心修复1：解决库存重复插入的问题。先根据工单号和产品名，查查有没有建过库存了
        org.dromara.system.domain.BizInventory inv = inventoryMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizInventory>()
                .eq(org.dromara.system.domain.BizInventory::getUniqueCode, schedule.getWorkOrderNo())
                .eq(org.dromara.system.domain.BizInventory::getItemName, schedule.getItemName())
                .last("limit 1")
        );

        // 尝试从原工单产品表中拉取该产品的“规格”、“单位”和“单价”
        org.dromara.system.domain.BizWoProduct product = woProductMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizWoProduct>()
                .eq(org.dromara.system.domain.BizWoProduct::getWorkOrderId, schedule.getWorkOrderId())
                .eq(org.dromara.system.domain.BizWoProduct::getProductName, schedule.getItemName())
                .last("limit 1")
        );

        java.math.BigDecimal unitPrice = java.math.BigDecimal.ZERO;
        String spec = null;
        String unit = "个";

        if (product != null) {
            spec = product.getSpec();
            unit = product.getUnit();
            if (product.getUnitPrice() != null) {
                unitPrice = new java.math.BigDecimal(String.valueOf(product.getUnitPrice()));
            }
        }

        Long customerId = null;
        org.dromara.system.domain.BizWorkOrder wo = workOrderMapper.selectById(schedule.getWorkOrderId());
        if (wo != null) customerId = wo.getCustomerId();

        if (inv != null) {
            // 仓库里已有该产品的库存槽位，直接累加数量（防并发写法）
            inventoryMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizInventory>lambdaUpdate()
                .eq(org.dromara.system.domain.BizInventory::getId, inv.getId())
                .setSql("current_qty = current_qty + " + incomingQty)
                .setSql("total_amount = (current_qty + " + incomingQty + ") * " + unitPrice)
            );
        } else {
            // 首次完工，新建成品库存槽位
            inv = new org.dromara.system.domain.BizInventory();
            inv.setUniqueCode(schedule.getWorkOrderNo());
            inv.setItemType("成品");
            inv.setItemName(schedule.getItemName());
            inv.setCurrentQty(incomingQty);
            inv.setSpec(spec);
            inv.setUnit(unit);
            inv.setPurchasePrice(unitPrice);
            inv.setTotalAmount(incomingQty.multiply(unitPrice));
            inv.setSupplierId(customerId);
            inventoryMapper.insert(inv);
        }

        // 👉 核心修复2：禁止物理删除业务单据！！改为更新状态为 "2" (已完工)
        return baseMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizProductionSchedule>lambdaUpdate()
            .eq(org.dromara.system.domain.BizProductionSchedule::getId, id)
            .setSql("status = '2'") // 请确保数据库存在 status 字段！
        ) > 0;
    }
}
