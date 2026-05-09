package org.dromara.system.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 打印工单视图对象
 *
 * @author JXTttt
 * @date 2026-05-07
 */
@Data
public class BizPrintWorkOrderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    // ========== 题头 ==========
    private String companyName;
    private String orderNo;
    private String customerName;
    private String productNos;
    private String workOrderNo;
    private Date deliveryDate;
    private String productNames;
    private String quantities;
    private String productDesc;

    // ========== 材质部分 ==========
    private List<BizWoMaterialVo> materialList;

    // ========== 印刷+表面处理部分 ==========
    private List<BizWoOutsourcingVo> printSurfaceList;

    // ========== 后续加工部分 ==========
    private List<BizWoOutsourcingVo> postProcessList;

    // ========== 其他配件部分 ==========
    private List<BizWoExtraPurchaseVo> extraPurchaseList;

    // ========== 底部 ==========
    private String packRequirement;
    private String logisticsReq;
    private String remark;
    private String preparedBy;
    private String auditBy;
    private String approvedBy;
}
