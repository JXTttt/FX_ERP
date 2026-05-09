package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import java.io.Serial;

/**
 * 工单管理对象 biz_work_order
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_work_order")
public class BizWorkOrder extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id")
    private Long id;

    private String workOrderNo;

    // ===================================
    // 【新增】关联销售订单的字段
    // ===================================
    private Long salesOrderId;
    private Long salesOrderDetailId;

    private Long customerId;
    private String customerName;
    private String productName;
    private Date orderDate;
    private Date deliveryDate;
    private Long salesManId;
    private Long operatorId;
    private String productionStatus;

    // ===================================
    // 【新增】轻量级审批流字段
    // ===================================
    private String auditStatus;
    private String auditBy;
    private String cAuditor;
    private Date cAuditTime;
    private String dAuditor;
    private Date dAuditTime;

    private String packRequirement;
    private String remark;

    /**
     * 制单员
     */
    private String preparedBy;

    @TableLogic
    private String delFlag;
}
