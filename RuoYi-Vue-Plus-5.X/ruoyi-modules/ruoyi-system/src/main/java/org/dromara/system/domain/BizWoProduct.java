package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单产品明细子对象 biz_wo_product
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_product")
public class BizWoProduct extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 客户PO号
     */
    private String customerPo;

    /**
     * 客户物料号
     */
    private String customerMaterialNo;

    /**
     * 规格
     */
    private String spec;

    /**
     * 层数(单E,BB等)
     */
    private String layers;

    /**
     * 刀版号
     */
    private String knifePlateNo;

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
    private Long unitPrice;

    /**
     * 总金额
     */
    private Long totalAmount;


}
