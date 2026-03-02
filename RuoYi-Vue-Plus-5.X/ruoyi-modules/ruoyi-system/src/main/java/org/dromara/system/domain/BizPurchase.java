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
 * 采购管理对象 biz_purchase
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_purchase")
public class BizPurchase extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 采购单号
     */
    private String purchaseNo;

    /**
     * 关联工单编号
     */
    private String relatedWoNo;

    /**
     * 供应商ID
     */
    private Long supplierId;

    /**
     * 采购内容/名称
     */
    private String itemName;

    /**
     * 规格
     */
    private String spec;

    /**
     * 采购数量
     */
    private BigDecimal applyQty;

    /**
     * 验收数量
     */
    private BigDecimal receivedQty;

    /**
     * 采购单价
     */
    private BigDecimal price;

    /**
     * 采购总价
     */
    private BigDecimal totalPrice;

    /**
     * 状态: 0-待审, 1-已批, 2-已验收, 3-驳回
     */
    private String status;

    /**
     * 申请人ID
     */
    private Long applicantId;

    /**
     * 验收时间
     */
    private Date verifyTime;

    /**
     * 期望交货期
     */
    private Date deliveryDate;

    /**
     * 
     */
    @TableLogic
    private String delFlag;


}
