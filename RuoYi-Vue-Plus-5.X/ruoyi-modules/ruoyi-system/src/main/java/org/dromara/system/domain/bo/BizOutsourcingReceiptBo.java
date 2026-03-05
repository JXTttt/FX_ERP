package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizOutsourcingReceipt;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 委外收货与结算业务对象 biz_outsourcing_receipt
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizOutsourcingReceipt.class, reverseConvertGenerate = false)
public class BizOutsourcingReceiptBo extends BaseEntity {

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 收货单号(如 OSR2026...)
     */
    @NotBlank(message = "收货单号(如 OSR2026...)不能为空", groups = { AddGroup.class, EditGroup.class })
    private String receiptNo;

    /**
     * 关联工单号
     */
    @NotBlank(message = "关联工单号不能为空", groups = { AddGroup.class, EditGroup.class })
    private String workOrderNo;

    /**
     * 产品/材料名称
     */
    private String productName;

    /**
     * 加工工序
     */
    @NotBlank(message = "加工工序不能为空", groups = { AddGroup.class, EditGroup.class })
    private String processProject;

    /**
     * 加工商ID
     */
    @NotNull(message = "加工商ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long supplierId;

    /**
     * 发出数量
     */
    private BigDecimal sentQty;

    /**
     * 实际验收数量
     */
    @NotNull(message = "实际验收数量不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal receivedQty;

    /**
     * 算价方式(张/平方米/套)
     */
    private String priceMethod;

    /**
     * 结算单价
     */
    @NotNull(message = "结算单价不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal unitPrice;

    /**
     * 结算加工费
     */
    @NotNull(message = "结算加工费不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal totalFee;

    /**
     * 收货日期
     */
    @NotNull(message = "收货日期不能为空", groups = { AddGroup.class, EditGroup.class })
    private Date receiptDate;

    /**
     * 状态: 0-待入库, 1-已验收结算
     */
    private String status;

    /**
     * 备注
     */
    private String remark;


}
