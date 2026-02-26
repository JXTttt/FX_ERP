package org.dromara.workflow.listener;

import org.dromara.common.core.utils.SpringUtils;
import org.dromara.system.domain.BizWorkOrder;
import org.dromara.system.mapper.BizWorkOrderMapper;
import org.dromara.warm.flow.core.listener.Listener;
import org.dromara.warm.flow.core.listener.ListenerVariable;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

/**
 * 工单审批通过监听器
 */
@Slf4j
@Component("workOrderPassListener")
public class WorkOrderPassListener implements Listener {

    // 删除了 @RequiredArgsConstructor 和 private final 注入
    // 改为在运行方法中动态获取，完美避开 IDEA 的静态检查报错

    @Override
    public void notify(ListenerVariable variable) {
        log.info("触发工单审批通过监听器...");

        try {
            // 1. 从流程实例中获取业务主键 (工单ID)
            String businessId = variable.getInstance().getBusinessId();

            // 2. 动态获取 Mapper Bean (安全且不报错)
            BizWorkOrderMapper workOrderMapper = SpringUtils.getBean(BizWorkOrderMapper.class);

            // 3. 更新工单状态为：2-已通过
            BizWorkOrder workOrder = new BizWorkOrder();
            workOrder.setId(Long.valueOf(businessId));
            workOrder.setAuditStatus("2");
            workOrderMapper.updateById(workOrder);

            log.info("工单【{}】审批状态已自动更新为：已通过", businessId);
        } catch (Exception e) {
            log.error("更新工单审批状态失败", e);
        }
    }
}
