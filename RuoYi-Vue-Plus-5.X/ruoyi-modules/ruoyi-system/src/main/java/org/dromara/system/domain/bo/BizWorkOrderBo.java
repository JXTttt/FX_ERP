package org.dromara.system.domain.bo;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.system.domain.BizWorkOrder;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import java.util.List;

/**
 * 工单管理业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWorkOrder.class, reverseConvertGenerate = false)
public class BizWorkOrderBo extends BaseEntity {

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
    private String auditStatus;
    private String auditBy;

    // ===================================
    // 【新增】审批记录字段
    // ===================================
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

    // --- 子表参数集合 ---
    private List<BizWoProductBo> productList;
    private List<BizWoMaterialBo> materialList;
    private List<BizWoCtpBo> ctpList;
    private List<BizWoPrintBo> printList;
    private List<BizWoPostProcessBo> postProcessList;
    private List<BizWoExtraPurchaseBo> extraPurchaseList;
    private List<BizWoProcessBo> processList;
    private List<BizWoOutsourcingBo> outsourcingList;
}
