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
import org.dromara.system.mapper.BizCustomerMapper;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizInventoryBo;
import org.dromara.system.domain.vo.BizInventoryVo;
import org.dromara.system.domain.BizInventory;
import org.dromara.system.mapper.BizInventoryMapper;
import org.dromara.system.service.IBizInventoryService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 库存管理Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizInventoryServiceImpl implements IBizInventoryService {

    private final BizInventoryMapper baseMapper;
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final BizFinanceRecordMapper financeRecordMapper;
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final BizCustomerMapper customerMapper;

    /**
     * 查询库存管理
     *
     * @param id 主键
     * @return 库存管理
     */
    @Override
    public BizInventoryVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询库存管理列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 库存管理分页列表
     */
    @Override
    public TableDataInfo<BizInventoryVo> queryPageList(BizInventoryBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizInventory> lqw = buildQueryWrapper(bo);
        Page<BizInventoryVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的库存管理列表
     *
     * @param bo 查询条件
     * @return 库存管理列表
     */
    @Override
    public List<BizInventoryVo> queryList(BizInventoryBo bo) {
        LambdaQueryWrapper<BizInventory> lqw = buildQueryWrapper(bo);
        List<BizInventoryVo> list = baseMapper.selectVoList(lqw);

        // ================= 核心翻译逻辑 =================
        // 遍历所有要导出的数据，把数字 ID 翻译成公司名称
        for (BizInventoryVo vo : list) {
            if (vo.getSupplierId() != null) {
                try {
                    org.dromara.system.domain.BizCustomer customer = customerMapper.selectById(vo.getSupplierId());
                    if (customer != null) {
                        vo.setSupplierName(customer.getCompanyName());
                    } else {
                        vo.setSupplierName("未知或已删除的供应商");
                    }
                } catch (Exception e) {
                    vo.setSupplierName("翻译失败");
                }
            }
        }
        // ===============================================

        return list;
    }

    private LambdaQueryWrapper<BizInventory> buildQueryWrapper(BizInventoryBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizInventory> lqw = Wrappers.lambdaQuery();

        // ID 判空
        lqw.eq(bo.getId() != null, BizInventory::getId, bo.getId());

        // 字符串类型使用 isNotBlank
        lqw.eq(StringUtils.isNotBlank(bo.getUniqueCode()), BizInventory::getUniqueCode, bo.getUniqueCode());
        lqw.eq(StringUtils.isNotBlank(bo.getItemType()), BizInventory::getItemType, bo.getItemType());
        lqw.like(StringUtils.isNotBlank(bo.getItemName()), BizInventory::getItemName, bo.getItemName());
        lqw.eq(StringUtils.isNotBlank(bo.getSpec()), BizInventory::getSpec, bo.getSpec());
        lqw.eq(StringUtils.isNotBlank(bo.getUnit()), BizInventory::getUnit, bo.getUnit());

        // 数值类型 (BigDecimal/Long) 使用 != null
        lqw.eq(bo.getCurrentQty() != null, BizInventory::getCurrentQty, bo.getCurrentQty());
        lqw.eq(bo.getSupplierId() != null, BizInventory::getSupplierId, bo.getSupplierId());
        lqw.eq(bo.getPurchasePrice() != null, BizInventory::getPurchasePrice, bo.getPurchasePrice());
        lqw.eq(bo.getTotalAmount() != null, BizInventory::getTotalAmount, bo.getTotalAmount());

        // --------------------------------------------------------------------------
        // 🛑 修正重点：创建人/更新人是 Long 类型，必须用 != null，不能用 isNotBlank
        // --------------------------------------------------------------------------
        lqw.eq(bo.getCreateBy() != null, BizInventory::getCreateBy, bo.getCreateBy());
        lqw.eq(bo.getCreateTime() != null, BizInventory::getCreateTime, bo.getCreateTime());
        lqw.eq(bo.getUpdateBy() != null, BizInventory::getUpdateBy, bo.getUpdateBy());
        lqw.eq(bo.getUpdateTime() != null, BizInventory::getUpdateTime, bo.getUpdateTime());

        return lqw;
    }

    /**
     * 新增库存管理
     *
     * @param bo 库存管理
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizInventoryBo bo) {
        BizInventory add = MapstructUtils.convert(bo, BizInventory.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改库存管理
     *
     * @param bo 库存管理
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizInventoryBo bo) {
        BizInventory update = MapstructUtils.convert(bo, BizInventory.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizInventory entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除库存管理信息
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

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean outbound(Long id, java.math.BigDecimal outboundQty) {
        org.dromara.system.domain.BizInventory inv = baseMapper.selectById(id);
        if (inv == null) {
            throw new org.dromara.common.core.exception.ServiceException("库存记录不存在！");
        }
        if (inv.getCurrentQty().compareTo(outboundQty) < 0) {
            throw new org.dromara.common.core.exception.ServiceException("出货失败：出货数量不能大于当前库存剩余量！");
        }

        // 👉 进阶修复1：使用 setSql 进行数据库级别的库存安全扣减，防止两人同时出库导致库存变负数！
        boolean flag = baseMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizInventory>lambdaUpdate()
            .eq(org.dromara.system.domain.BizInventory::getId, id)
            .ge(org.dromara.system.domain.BizInventory::getCurrentQty, outboundQty) // 数据库级拦截超卖
            .setSql("current_qty = current_qty - " + outboundQty)
            .setSql(inv.getPurchasePrice() != null, "total_amount = (current_qty - " + outboundQty + ") * " + inv.getPurchasePrice())
        ) > 0;

        if (!flag) {
            throw new org.dromara.common.core.exception.ServiceException("出货异常：库存扣减失败，可能是库存不足或数据正在被其他人修改！");
        }

        // 3. 👉 业财联动：如果是成品出货，自动给客户记一笔“应收账款”
        if ("成品".equals(inv.getItemType()) && inv.getPurchasePrice() != null) {
            java.math.BigDecimal totalMoney = outboundQty.multiply(inv.getPurchasePrice());

            org.dromara.system.domain.BizFinanceRecord finance = new org.dromara.system.domain.BizFinanceRecord();
            finance.setRecordNo("FIN-XS-" + System.currentTimeMillis());
            finance.setRecordType("1"); // 1-收入/应收 (客户欠我们的钱)
            finance.setBusinessType("销售出货");
            finance.setRelatedNo(inv.getUniqueCode()); // 把工单号带过去作为凭证
            finance.setAmount(totalMoney);
            finance.setSettlementStatus("0"); // 未结清(挂账)

            String targetName = String.valueOf(inv.getSupplierId());
            if (inv.getSupplierId() != null) {
                org.dromara.system.domain.BizCustomer customer = customerMapper.selectById(inv.getSupplierId());
                if (customer != null && customer.getCompanyName() != null) {
                    targetName = customer.getCompanyName();

                    // 👉 进阶修复2：同步增加客户欠款 (我们发货了，客户欠我们钱)
                    customerMapper.update(null, com.baomidou.mybatisplus.core.toolkit.Wrappers.<org.dromara.system.domain.BizCustomer>lambdaUpdate()
                        .eq(org.dromara.system.domain.BizCustomer::getId, inv.getSupplierId())
                        .setSql("total_owe_amount = COALESCE(total_owe_amount, 0) + " + totalMoney)
                    );
                }
            }
            finance.setTargetName(targetName);
            finance.setRemark("成品出货自动生成应收账款，出货产品: " + inv.getItemName() + "，出货量: " + outboundQty);

            financeRecordMapper.insert(finance);
        }

        return true;
    }
}
