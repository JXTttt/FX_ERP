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
import org.dromara.system.domain.bo.BizTempWorkerBo;
import org.dromara.system.domain.vo.BizTempWorkerVo;
import org.dromara.system.domain.BizTempWorker;
import org.dromara.system.mapper.BizTempWorkerMapper;
import org.dromara.system.service.IBizTempWorkerService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Slf4j
@RequiredArgsConstructor
@Service
public class BizTempWorkerServiceImpl implements IBizTempWorkerService {

    private final BizTempWorkerMapper baseMapper;

    // 👉 1. 注入财务流水Mapper
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizFinanceRecordMapper financeRecordMapper;

    @Override
    public BizTempWorkerVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    @Override
    public TableDataInfo<BizTempWorkerVo> queryPageList(BizTempWorkerBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizTempWorker> lqw = buildQueryWrapper(bo);
        Page<BizTempWorkerVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizTempWorkerVo> queryList(BizTempWorkerBo bo) {
        LambdaQueryWrapper<BizTempWorker> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizTempWorker> buildQueryWrapper(BizTempWorkerBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizTempWorker> lqw = Wrappers.lambdaQuery();
        // ... (保留生成器原来的查询条件不变)
        return lqw;
    }

    // 👉 2. 重写新增方法，登记成功后立刻抛账到财务中心
    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(BizTempWorkerBo bo) {
        BizTempWorker add = MapstructUtils.convert(bo, BizTempWorker.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;

        if (flag) {
            bo.setId(add.getId());

            // ================= 业财联动核心逻辑 =================
            // 自动推送到财务表，形成“应付临时工工资”流水
            org.dromara.system.domain.BizFinanceRecord finance = new org.dromara.system.domain.BizFinanceRecord();
            // 用临时工单的ID作为唯一前缀，方便后期追溯
            finance.setRecordNo("FIN-TW-" + add.getId());
            finance.setRecordType("2"); // 2-代表“支出/应付款”
            finance.setBusinessType("临时工费"); // 业务类型
            finance.setRelatedNo(bo.getRelatedWoNo()); // 挂在哪个工单上
            finance.setTargetName(bo.getWorkerName()); // 收款人
            finance.setAmount(bo.getTotalAmount()); // 要给多少钱
            finance.setSettlementStatus(bo.getPayStatus()); // 同步支付状态

            // --- 开始组装详细的财务对账备注 ---
            String workTypeStr = "1".equals(bo.getWorkType()) ? "计时" : "计件";
            String unitStr = "1".equals(bo.getWorkType()) ? "小时" : "件";
            String dateStr = "未知日期";
            if (bo.getWorkDate() != null) {
                dateStr = new java.text.SimpleDateFormat("MM月dd日").format(bo.getWorkDate());
            }
            String content = org.dromara.common.core.utils.StringUtils.isNotBlank(bo.getRemark()) ? bo.getRemark() : "无";
            String detailRemark = String.format("日期:%s | %s: %s%s × 单价:￥%s | 内容:%s",
                dateStr, workTypeStr, bo.getWorkQty(), unitStr, bo.getUnitPrice(), content);

            finance.setRemark(detailRemark);
            // --- 组装结束 ---

            financeRecordMapper.insert(finance);
            // ===================================================
        }
        return flag;
    }

    // 👉 3. 重写修改方法，如果业务员修改了工时/单价，必须同步刷新财务总账！
    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizTempWorkerBo bo) {
        BizTempWorker update = MapstructUtils.convert(bo, BizTempWorker.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        if (flag) {
            // ================= 业财同步更新逻辑 =================
            // 拿着这笔临时工单的专属 ID 去财务表里找对应的账单
            com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizFinanceRecord> lqw =
                com.baomidou.mybatisplus.core.toolkit.Wrappers.lambdaQuery();
            lqw.eq(org.dromara.system.domain.BizFinanceRecord::getRecordNo, "FIN-TW-" + bo.getId());

            org.dromara.system.domain.BizFinanceRecord finance = financeRecordMapper.selectOne(lqw);

            // 如果找到了财务账单，并且财务还没给钱（未结清），那就同步更新它！
            if (finance != null && !"2".equals(finance.getSettlementStatus())) {
                finance.setRelatedNo(bo.getRelatedWoNo());
                finance.setTargetName(bo.getWorkerName());
                finance.setAmount(bo.getTotalAmount());

                // --- 重新组装最新的详细财务对账备注 ---
                String workTypeStr = "1".equals(bo.getWorkType()) ? "计时" : "计件";
                String unitStr = "1".equals(bo.getWorkType()) ? "小时" : "件";
                String dateStr = "未知日期";
                if (bo.getWorkDate() != null) {
                    dateStr = new java.text.SimpleDateFormat("MM月dd日").format(bo.getWorkDate());
                }
                String content = org.dromara.common.core.utils.StringUtils.isNotBlank(bo.getRemark()) ? bo.getRemark() : "无";
                String detailRemark = String.format("日期:%s | %s: %s%s × 单价:￥%s | 内容:%s",
                    dateStr, workTypeStr, bo.getWorkQty(), unitStr, bo.getUnitPrice(), content);

                finance.setRemark(detailRemark);
                // --- 组装结束 ---

                financeRecordMapper.updateById(finance);
            }
            // ===================================================
        }
        return flag;
    }

    private void validEntityBeforeSave(BizTempWorker entity){
        // 数据校验
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        return baseMapper.deleteByIds(ids) > 0;
    }
}
