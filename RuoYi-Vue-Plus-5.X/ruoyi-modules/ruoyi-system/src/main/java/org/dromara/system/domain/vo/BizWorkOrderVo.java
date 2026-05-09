package org.dromara.system.domain.vo;

import java.util.Date;
import java.util.List;
import org.dromara.system.domain.BizWorkOrder;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 工单管理视图对象
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWorkOrder.class)
public class BizWorkOrderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;

    @ExcelProperty(value = "工单编号")
    private String workOrderNo;

    // ===================================
    // 【新增】关联销售订单的字段
    // ===================================
    private Long salesOrderId;
    private Long salesOrderDetailId;

    private Long customerId;

    @ExcelProperty(value = "客户名称")
    private String customerName;

    @ExcelProperty(value = "产品名称")
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

    // --- 子表对象集合 (保留你在 ServiceImpl 里调用的列表) ---
    private List<BizWoProductVo> productList;
    private List<BizWoMaterialVo> materialList;
    private List<BizWoCtpVo> ctpList;
    private List<BizWoPrintVo> printList;
    private List<BizWoPostProcessVo> postProcessList;
    private List<BizWoExtraPurchaseVo> extraPurchaseList;
    private List<BizWoProcessVo> processList;
    private List<BizWoOutsourcingVo> outsourcingList;
}
