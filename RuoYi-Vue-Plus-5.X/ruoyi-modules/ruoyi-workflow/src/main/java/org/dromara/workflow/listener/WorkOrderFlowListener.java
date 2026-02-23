package org.dromara.workflow.listener;

import org.dromara.warm.flow.core.service.InsService;
import org.dromara.warm.flow.core.dto.FlowParams;
import org.dromara.warm.flow.core.entity.Instance;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.system.domain.bo.WorkOrderCreatedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class WorkOrderFlowListener {

    private final InsService insService;

    /**
     * 监听系统模块发出的工单创建事件，自动启动审批流程
     */
    @EventListener
    public void onWorkOrderCreated(WorkOrderCreatedEvent event) {
        Long workOrderId = event.getWorkOrderId();
        log.info("监听到工单新建事件，准备发起审批流程，工单ID: {}", workOrderId);

        try {
            // 在较新的 WarmFlow 版本中，启动流程并绑定业务 ID 的标准做法：

            // 1. 构造基础的流程参数 (可以为空，或设置发起人)
            FlowParams flowParams = FlowParams.build();
            // 如果需要记录发起人，可以加：.handler(String.valueOf(org.dromara.common.satoken.utils.LoginHelper.getUserId()))

            // 2. 发起流程，获取流程实例对象
            Instance instance = insService.start("work_order_approval", flowParams);

            // 3. 将流程实例与业务 ID 进行绑定
            // WarmFlow 会更新流程实例表中的 business_id
            if (instance != null) {
                // 有些版本是通过 update 方法更新，有些是通过 insService 提供的方法
                // 为了兼容性，使用 insService 的特定方法或者实体对象更新
                instance.setBusinessId(String.valueOf(workOrderId));
                insService.updateById(instance);
            }

            log.info("工单审批流程发起成功！流程实例ID: {}", instance.getId());
        } catch (Exception e) {
            log.error("发起工单审批流程异常，工单ID: {}", workOrderId, e);
        }
    }
}
