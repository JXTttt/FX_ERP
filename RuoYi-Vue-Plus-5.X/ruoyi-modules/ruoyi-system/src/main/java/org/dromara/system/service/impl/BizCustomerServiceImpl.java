package org.dromara.system.service.impl;

import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizCustomerBo;
import org.dromara.system.domain.vo.BizCustomerVo;
import org.dromara.system.domain.BizCustomer;
import org.dromara.system.mapper.BizCustomerMapper;
import org.dromara.system.service.IBizCustomerService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 客户及供应商Service业务层处理
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizCustomerServiceImpl implements IBizCustomerService {

    private final BizCustomerMapper baseMapper;
    private final BizFinanceRecordMapper financeRecordMapper;

    @Override
    public BizCustomerVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizCustomerVo> queryPageList(BizCustomerBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizCustomer> lqw = buildQueryWrapper(bo);
        Page<BizCustomerVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizCustomerVo> queryList(BizCustomerBo bo) {
        LambdaQueryWrapper<BizCustomer> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizCustomer> buildQueryWrapper(BizCustomerBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizCustomer> lqw = Wrappers.lambdaQuery();

        // 基础信息查询
        lqw.eq(bo.getId() != null, BizCustomer::getId, bo.getId());
        lqw.like(StringUtils.isNotBlank(bo.getCompanyName()), BizCustomer::getCompanyName, bo.getCompanyName());
        lqw.eq(StringUtils.isNotBlank(bo.getCustomerCode()), BizCustomer::getCustomerCode, bo.getCustomerCode());
        lqw.like(StringUtils.isNotBlank(bo.getShortName()), BizCustomer::getShortName, bo.getShortName());
        lqw.like(StringUtils.isNotBlank(bo.getContactPerson()), BizCustomer::getContactPerson, bo.getContactPerson());
        lqw.like(StringUtils.isNotBlank(bo.getContactPhone()), BizCustomer::getContactPhone, bo.getContactPhone());

        // 👇================ 核心修改区域 开始 ================👇

        // 1. 客户角色过滤：因为数据库现在存的是逗号分隔的字符串(如 "2,3")，所以必须从 eq 改成 FIND_IN_SET
        lqw.apply(StringUtils.isNotBlank(bo.getCustomerType()), "FIND_IN_SET({0}, customer_type)", bo.getCustomerType());

        // 2. 加工/供应分类过滤：合并查询，生成 AND ( FIND_IN_SET(...) OR FIND_IN_SET(...) ) 安全括号拼接
        if (StringUtils.isNotBlank(bo.getBizCategory())) {
            lqw.and(wrapper -> wrapper
                .apply("FIND_IN_SET({0}, supplier_category)", bo.getBizCategory())
                .or()
                .apply("FIND_IN_SET({0}, processor_category)", bo.getBizCategory())
            );
        }

        // 👆================ 核心修改区域 结束 ================👆

        // 区域/地址等其他信息查询保持不变
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyProvince()), BizCustomer::getCompanyProvince, bo.getCompanyProvince());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyCity()), BizCustomer::getCompanyCity, bo.getCompanyCity());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyDistrict()), BizCustomer::getCompanyDistrict, bo.getCompanyDistrict());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyAddress()), BizCustomer::getCompanyAddress, bo.getCompanyAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryProvince()), BizCustomer::getDeliveryProvince, bo.getDeliveryProvince());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryCity()), BizCustomer::getDeliveryCity, bo.getDeliveryCity());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryDistrict()), BizCustomer::getDeliveryDistrict, bo.getDeliveryDistrict());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryAddress()), BizCustomer::getDeliveryAddress, bo.getDeliveryAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryUnit()), BizCustomer::getDeliveryUnit, bo.getDeliveryUnit());

        // 资金与业务员等字段
        lqw.eq(StringUtils.isNotBlank(bo.getBankAccountInfo()), BizCustomer::getBankAccountInfo, bo.getBankAccountInfo());
        lqw.eq(bo.getTotalDealAmount() != null, BizCustomer::getTotalDealAmount, bo.getTotalDealAmount());
        lqw.eq(bo.getTotalOweAmount() != null, BizCustomer::getTotalOweAmount, bo.getTotalOweAmount());
        lqw.eq(bo.getSalesManId() != null, BizCustomer::getSalesManId, bo.getSalesManId());

        // 审计字段
        lqw.eq(bo.getCreateBy() != null, BizCustomer::getCreateBy, bo.getCreateBy());
        lqw.eq(bo.getCreateTime() != null, BizCustomer::getCreateTime, bo.getCreateTime());
        lqw.eq(bo.getUpdateBy() != null, BizCustomer::getUpdateBy, bo.getUpdateBy());
        lqw.eq(bo.getUpdateTime() != null, BizCustomer::getUpdateTime, bo.getUpdateTime());

        return lqw;
    }

    @Override
    public Boolean insertByBo(BizCustomerBo bo) {
        BizCustomer add = MapstructUtils.convert(bo, BizCustomer.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(BizCustomerBo bo) {
        BizCustomer update = MapstructUtils.convert(bo, BizCustomer.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    private void validEntityBeforeSave(BizCustomer entity){
        //TODO 做一些数据校验,如唯一约束
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public void settleDebt(BizCustomerBo bo) {
        org.dromara.system.domain.BizCustomer customer = baseMapper.selectById(bo.getId());
        if(customer == null) throw new org.dromara.common.core.exception.ServiceException("客户/供应商不存在");

        if(bo.getSettleAmount() == null || bo.getSettleAmount().compareTo(java.math.BigDecimal.ZERO) <= 0) {
            throw new org.dromara.common.core.exception.ServiceException("结清金额必须大于0");
        }

        // 1. 扣减客户表的总欠款
        java.math.BigDecimal currentDebt = customer.getTotalOweAmount() == null ? java.math.BigDecimal.ZERO : customer.getTotalOweAmount();
        java.math.BigDecimal newDebt = currentDebt.subtract(bo.getSettleAmount());
        if(newDebt.compareTo(java.math.BigDecimal.ZERO) < 0) {
            newDebt = java.math.BigDecimal.ZERO;
        }
        customer.setTotalOweAmount(newDebt);

        // 👉 [新增修复逻辑]：累加客户表的交易总额
        java.math.BigDecimal currentDealAmount = customer.getTotalDealAmount() == null ? java.math.BigDecimal.ZERO : customer.getTotalDealAmount();
        customer.setTotalDealAmount(currentDealAmount.add(bo.getSettleAmount()));

        baseMapper.updateById(customer);

        // 2. 自动生成一笔【已结清】的财务手工流水
        org.dromara.system.domain.BizFinanceRecord finance = new org.dromara.system.domain.BizFinanceRecord();
        finance.setRecordNo("FIN-MN-" + System.currentTimeMillis());
        finance.setRecordType("1".equals(customer.getCustomerType()) ? "1" : "2");
        finance.setBusinessType("手工结清");
        finance.setAmount(bo.getSettleAmount());
        finance.setTargetName(customer.getCompanyName());
        finance.setSettlementStatus("2"); // 2-已结清
        finance.setRemark("在客户管理处手动打款结清，备注：" + (bo.getRemark() == null ? "" : bo.getRemark()));

        financeRecordMapper.insert(finance);
    }
}
