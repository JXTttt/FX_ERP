package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoProduct;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单产品明细子业务对象 biz_wo_product
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoProduct.class, reverseConvertGenerate = false)
public class BizWoProductBo extends BaseEntity {

    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 产品名称
     */
    @NotBlank(message = "产品名称不能为空", groups = { AddGroup.class, EditGroup.class })
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
