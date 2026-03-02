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

        org.dromara.system.domain.BizInventory inv = new org.dromara.system.domain.BizInventory();
        inv.setUniqueCode(schedule.getWorkOrderNo());
        inv.setItemType("成品");
        inv.setItemName(schedule.getItemName());

        // 设置初始入库数量
        java.math.BigDecimal initialQty = new java.math.BigDecimal(schedule.getQuantity());
        inv.setCurrentQty(initialQty);

        // 尝试从原工单产品表中拉取该产品的“规格”、“单位”和“单价”
        org.dromara.system.domain.BizWoProduct product = woProductMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizWoProduct>()
                .eq(org.dromara.system.domain.BizWoProduct::getWorkOrderId, schedule.getWorkOrderId())
                .eq(org.dromara.system.domain.BizWoProduct::getProductName, schedule.getItemName())
                .last("limit 1")
        );

        if (product != null) {
            inv.setSpec(product.getSpec());
            inv.setUnit(product.getUnit());

            // 👉 终极修复：不再判断类型，直接转成 String 再转 BigDecimal，绝不报错！
            if (product.getUnitPrice() != null) {
                java.math.BigDecimal unitPrice = new java.math.BigDecimal(String.valueOf(product.getUnitPrice()));

                inv.setPurchasePrice(unitPrice); // 存入单价
                inv.setTotalAmount(initialQty.multiply(unitPrice)); // 数量 * 单价
            }
        } else {
            inv.setUnit("个");
        }

        // 查询原工单，把客户ID塞入库存记录
        org.dromara.system.domain.BizWorkOrder wo = workOrderMapper.selectById(schedule.getWorkOrderId());
        if (wo != null) {
            inv.setSupplierId(wo.getCustomerId());
        }

        inventoryMapper.insert(inv);
        return baseMapper.deleteById(id) > 0;
    }
}
