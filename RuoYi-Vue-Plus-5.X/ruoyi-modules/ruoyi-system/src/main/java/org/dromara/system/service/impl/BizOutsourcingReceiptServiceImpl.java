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
import org.dromara.system.domain.bo.BizOutsourcingReceiptBo;
import org.dromara.system.domain.vo.BizOutsourcingReceiptVo;
import org.dromara.system.domain.BizOutsourcingReceipt;
import org.dromara.system.mapper.BizOutsourcingReceiptMapper;
import org.dromara.system.service.IBizOutsourcingReceiptService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizOutsourcingReceiptServiceImpl implements IBizOutsourcingReceiptService {

    private final BizOutsourcingReceiptMapper baseMapper;

    // 👉 注入财务和客户 Mapper
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizFinanceRecordMapper financeRecordMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizCustomerMapper customerMapper;

    @Override
    public BizOutsourcingReceiptVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizOutsourcingReceiptVo> queryPageList(BizOutsourcingReceiptBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizOutsourcingReceipt> lqw = buildQueryWrapper(bo);
        Page<BizOutsourcingReceiptVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizOutsourcingReceiptVo> queryList(BizOutsourcingReceiptBo bo) {
        LambdaQueryWrapper<BizOutsourcingReceipt> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizOutsourcingReceipt> buildQueryWrapper(BizOutsourcingReceiptBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizOutsourcingReceipt> lqw = Wrappers.lambdaQuery();
        lqw.eq(StringUtils.isNotBlank(bo.getReceiptNo()), BizOutsourcingReceipt::getReceiptNo, bo.getReceiptNo());
        lqw.eq(StringUtils.isNotBlank(bo.getWorkOrderNo()), BizOutsourcingReceipt::getWorkOrderNo, bo.getWorkOrderNo());
        lqw.eq(bo.getSupplierId() != null, BizOutsourcingReceipt::getSupplierId, bo.getSupplierId());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), BizOutsourcingReceipt::getStatus, bo.getStatus());
        return lqw;
    }

    @Override
    public Boolean insertByBo(BizOutsourcingReceiptBo bo) {
        BizOutsourcingReceipt add = MapstructUtils.convert(bo, BizOutsourcingReceipt.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    // 👉 核心逻辑：监听修改操作，如果是“确认结算(状态1)”，就抛账！
    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizOutsourcingReceiptBo bo) {
        // 先查出老数据，判断是不是刚点的结算
        BizOutsourcingReceipt oldData = baseMapper.selectById(bo.getId());
        if (oldData == null) return false;

        BizOutsourcingReceipt update = MapstructUtils.convert(bo, BizOutsourcingReceipt.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        // 如果更新成功，且状态变成了 1 (已结算)，且原来是 0 (待入库)
        if (flag && "1".equals(bo.getStatus()) && "0".equals(oldData.getStatus())) {

            // 兜底补全 bo 中的关键数据（前端点结算时只传了 id 和 status）
            if (bo.getTotalFee() == null) bo.setTotalFee(oldData.getTotalFee());
            if (bo.getWorkOrderNo() == null) bo.setWorkOrderNo(oldData.getWorkOrderNo());
            if (bo.getSupplierId() == null) bo.setSupplierId(oldData.getSupplierId());
            if (bo.getReceiptNo() == null) bo.setReceiptNo(oldData.getReceiptNo());
            if (bo.getProcessProject() == null) bo.setProcessProject(oldData.getProcessProject());

            if (bo.getTotalFee() != null && bo.getTotalFee().compareTo(java.math.BigDecimal.ZERO) > 0) {
                org.dromara.system.domain.BizFinanceRecord finance = new org.dromara.system.domain.BizFinanceRecord();
                finance.setRecordNo("FIN-WW-" + System.currentTimeMillis());
                finance.setRecordType("2"); // 2-支出/应付
                finance.setBusinessType("委外加工");
                finance.setRelatedNo(bo.getWorkOrderNo()); // 关联工单号
                finance.setAmount(bo.getTotalFee());
                finance.setSettlementStatus("0"); // 挂账

                String targetName = String.valueOf(bo.getSupplierId());
                if (bo.getSupplierId() != null) {
                    org.dromara.system.domain.BizCustomer customer = customerMapper.selectById(bo.getSupplierId());
                    if (customer != null && customer.getCompanyName() != null) {
                        targetName = customer.getCompanyName();
                    }
                }
                finance.setTargetName(targetName);
                finance.setRemark("委外收货结算，收货单号: " + bo.getReceiptNo() + "，工序: " + bo.getProcessProject());

                financeRecordMapper.insert(finance);
            }
        }

        return flag;
    }

    private void validEntityBeforeSave(BizOutsourcingReceipt entity){
        // TODO 做一些数据校验,如唯一约束
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        return baseMapper.deleteByIds(ids) > 0;
    }
}
