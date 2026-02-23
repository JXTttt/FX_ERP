package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWorkOrder;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List; // 引入List

/**
 * 工单管理业务对象 biz_work_order
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWorkOrder.class, reverseConvertGenerate = false)
public class BizWorkOrderBo extends BaseEntity {

    /**
     * 主键ID (🔥 之前缺失的字段，必须补上)
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 工单编号(例:2602030037)
     */
    // 移除了 @NotBlank，因为我们要在后端自动生成，前端传空也没关系
    private String workOrderNo;

    /**
     * 客户ID (关联字段，推荐加上)
     */
    private Long customerId;

    /**
     * 客户名称快照
     */
    private String customerName;

    /**
     * 客户PO号
     */
    private String customerPo;

    /**
     * 客户物料号
     */
    private String customerMaterialNo;

    /**
     * 产品名称
     */
    @NotBlank(message = "产品名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String productName;

    /**
     * 产品编码(拼音+日期)
     */
    private String productCode;

    /**
     * 订单数量
     */
    private Long orderQuantity;

    /**
     * 生产数量
     */
    private Long produceQuantity;

    /**
     * 单位
     */
    private String unit;

    /**
     * 单价
     */
    private BigDecimal unitPrice;

    /**
     * 总金额
     */
    private BigDecimal totalAmount;

    /**
     * 规格
     */
    private String spec;

    /**
     * 层数(单E, BB等)
     */
    private String layers;

    /**
     * 刀版号
     */
    private String knifePlateNo;

    /**
     * 结构类型
     */
    private String structureType;

    /**
     * 开单日期
     */
    private Date orderDate;

    /**
     * 交货日期
     */
    private Date deliveryDate;

    /**
     * 业务员ID
     */
    private Long salesManId;

    /**
     * 开单人ID
     */
    private Long operatorId;

    /**
     * 生产进度
     */
    private String productionStatus;

    /**
     * 审核状态
     */
    private String auditStatus;

    /**
     * 签名
     */
    private String auditBy;

    /**
     * 包装要求
     */
    private String packRequirement;

    /**
     * 备注
     */
    private String remark;

    // ==========================================================================
    // 👇 为了后续实现主子表保存，您必须要把这些列表加上，否则 Service 层也会报错
    // ==========================================================================

    /** 材料子表列表 */
    private List<BizWoMaterialBo> materialList;

    /** CTP子表列表 */
    private List<BizWoCtpBo> ctpList;

    /** 印刷子表列表 */
    private List<BizWoPrintBo> printList;

    /** 后续加工子表列表 */
    private List<BizWoPostProcessBo> postProcessList;

    /** 其他订购子表列表 */
    private List<BizWoExtraPurchaseBo> extraPurchaseList;

}
