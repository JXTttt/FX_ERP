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
import org.dromara.system.mapper.BizTempWorkerMapper;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizFinanceRecordBo;
import org.dromara.system.domain.vo.BizFinanceRecordVo;
import org.dromara.system.domain.BizFinanceRecord;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.dromara.system.service.IBizFinanceRecordService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Collection;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizFinanceRecordServiceImpl implements IBizFinanceRecordService {

    private final BizFinanceRecordMapper baseMapper;
    private final BizTempWorkerMapper tempWorkerMapper;
    private final BizCustomerMapper customerMapper;

    @Override
    public BizFinanceRecordVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizFinanceRecordVo> queryPageList(BizFinanceRecordBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizFinanceRecord> lqw = buildQueryWrapper(bo);
        Page<BizFinanceRecordVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizFinanceRecordVo> queryList(BizFinanceRecordBo bo) {
        LambdaQueryWrapper<BizFinanceRecord> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizFinanceRecord> buildQueryWrapper(BizFinanceRecordBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizFinanceRecord> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getRecordNo()), BizFinanceRecord::getRecordNo, bo.getRecordNo());
        lqw.eq(StringUtils.isNotBlank(bo.getRecordType()), BizFinanceRecord::getRecordType, bo.getRecordType());
        lqw.eq(StringUtils.isNotBlank(bo.getBusinessType()), BizFinanceRecord::getBusinessType, bo.getBusinessType());
        lqw.eq(StringUtils.isNotBlank(bo.getRelatedNo()), BizFinanceRecord::getRelatedNo, bo.getRelatedNo());
        lqw.like(StringUtils.isNotBlank(bo.getTargetName()), BizFinanceRecord::getTargetName, bo.getTargetName());
        lqw.eq(StringUtils.isNotBlank(bo.getSettlementStatus()), BizFinanceRecord::getSettlementStatus, bo.getSettlementStatus());

        if (params != null && params.get("beginTime") != null && params.get("endTime") != null) {
            String beginTime = params.get("beginTime").toString();
            String endTime = params.get("endTime").toString();
            if (StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
                lqw.between(BizFinanceRecord::getCreateTime, beginTime, endTime);
            }
        }

        return lqw;
    }

    @Override
    public Boolean insertByBo(BizFinanceRecordBo bo) {
        BizFinanceRecord add = MapstructUtils.convert(bo, BizFinanceRecord.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizFinanceRecordBo bo) {
        BizFinanceRecord oldData = baseMapper.selectById(bo.getId());
        if (oldData == null) return false;

        // 1. 结清锁
        if ("2".equals(oldData.getSettlementStatus()) && "2".equals(bo.getSettlementStatus())) {
            throw new org.dromara.common.core.exception.ServiceException("该财务账单已核销结清，作为正式凭证严禁任何修改！");
        }

        // 2. 源单锁
        if (oldData.getRecordNo() != null && !oldData.getRecordNo().startsWith("FIN-MN-")) {
            bo.setAmount(oldData.getAmount());
            bo.setRecordType(oldData.getRecordType());
            bo.setBusinessType(oldData.getBusinessType());
            bo.setRelatedNo(oldData.getRelatedNo());
            bo.setTargetName(oldData.getTargetName());
        }

        BizFinanceRecord update = MapstructUtils.convert(bo, BizFinanceRecord.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        // 3. 业财反向联动
        if (flag && "2".equals(bo.getSettlementStatus()) && !"2".equals(oldData.getSettlementStatus())) {

            if ("临时工费".equals(oldData.getBusinessType()) && oldData.getRecordNo() != null && oldData.getRecordNo().startsWith("FIN-TW-")) {
                String twIdStr = oldData.getRecordNo().replace("FIN-TW-", "");
                try {
                    Long twId = Long.parseLong(twIdStr);
                    org.dromara.system.domain.BizTempWorker tw = tempWorkerMapper.selectById(twId);
                    if (tw != null && !"1".equals(tw.getPayStatus())) {
                        tw.setPayStatus("1");
                        tempWorkerMapper.updateById(tw);
                    }
                } catch (Exception e) {
                    log.error("反向核销临时工状态失败", e);
                }
            }

            // 针对供应商/客户的核销，扣减对方总欠款并增加交易总额
            if (org.dromara.common.core.utils.StringUtils.isNotBlank(oldData.getTargetName())) {
                com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizCustomer> custLqw = com.baomidou.mybatisplus.core.toolkit.Wrappers.lambdaQuery();
                custLqw.eq(org.dromara.system.domain.BizCustomer::getCompanyName, oldData.getTargetName());
                java.util.List<org.dromara.system.domain.BizCustomer> customers = customerMapper.selectList(custLqw);

                if(customers != null && !customers.isEmpty()){
                    org.dromara.system.domain.BizCustomer customer = customers.get(0);

                    // 扣减欠款
                    java.math.BigDecimal currentDebt = customer.getTotalOweAmount() == null ? java.math.BigDecimal.ZERO : customer.getTotalOweAmount();
                    java.math.BigDecimal newDebt = currentDebt.subtract(oldData.getAmount());
                    if (newDebt.compareTo(java.math.BigDecimal.ZERO) < 0) {
                        newDebt = java.math.BigDecimal.ZERO;
                    }
                    customer.setTotalOweAmount(newDebt);

                    // 👉 [新增修复逻辑]：累加交易总额
                    java.math.BigDecimal currentDealAmount = customer.getTotalDealAmount() == null ? java.math.BigDecimal.ZERO : customer.getTotalDealAmount();
                    customer.setTotalDealAmount(currentDealAmount.add(oldData.getAmount()));

                    customerMapper.updateById(customer);
                }
            }
        }

        return flag;
    }

    private void validEntityBeforeSave(BizFinanceRecord entity){
        // TODO 做一些数据校验
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        for (Long id : ids) {
            BizFinanceRecord oldData = baseMapper.selectById(id);
            if (oldData != null) {
                if ("2".equals(oldData.getSettlementStatus())) {
                    throw new org.dromara.common.core.exception.ServiceException("删除失败：包含已结清的财务凭证，严禁删除！");
                }
                if (oldData.getRecordNo() != null && !oldData.getRecordNo().startsWith("FIN-MN-")) {
                    throw new org.dromara.common.core.exception.ServiceException("拦截删除：业务系统自动生成的财务流水，必须由源单据撤销操作，严禁在财务总账直接删除！");
                }
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
