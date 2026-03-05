package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 委外收货与结算对象 biz_outsourcing_receipt
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_outsourcing_receipt")
public class BizOutsourcingReceipt extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 收货单号(如 OSR2026...)
     */
    private String receiptNo;

    /**
     * 关联工单号
     */
    private String workOrderNo;

    /**
     * 产品/材料名称
     */
    private String productName;

    /**
     * 加工工序
     */
    private String processProject;

    /**
     * 加工商ID
     */
    private Long supplierId;

    /**
     * 发出数量
     */
    private BigDecimal sentQty;

    /**
     * 实际验收数量
     */
    private BigDecimal receivedQty;

    /**
     * 算价方式(张/平方米/套)
     */
    private String priceMethod;

    /**
     * 结算单价
     */
    private BigDecimal unitPrice;

    /**
     * 结算加工费
     */
    private BigDecimal totalFee;

    /**
     * 收货日期
     */
    private Date receiptDate;

    /**
     * 状态: 0-待入库, 1-已验收结算
     */
    private String status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;


}
