package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizPurchase;
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
 * 采购管理业务对象 biz_purchase
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizPurchase.class, reverseConvertGenerate = false)
public class BizPurchaseBo extends BaseEntity {

//    /**
//     * 主键ID
//     */
//    private Long id;

    /**
     *
     */
    @NotNull(message = "不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long id;

    /**
     * 采购单号
     */
    @NotBlank(message = "采购单号不能为空", groups = { AddGroup.class, EditGroup.class })
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


}
