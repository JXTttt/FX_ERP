package org.dromara.system.domain.bo;

import org.springframework.context.ApplicationEvent;

/**
 * 工单已创建事件
 */
public class WorkOrderCreatedEvent extends ApplicationEvent {

    public WorkOrderCreatedEvent(Long workOrderId) {
        super(workOrderId);
    }

    public Long getWorkOrderId() {
        return (Long) getSource();
    }
}
