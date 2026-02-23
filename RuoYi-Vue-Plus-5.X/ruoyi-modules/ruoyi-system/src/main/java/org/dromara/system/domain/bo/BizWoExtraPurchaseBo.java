package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoExtraPurchase;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单其他订购子业务对象 biz_wo_extra_purchase
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoExtraPurchase.class, reverseConvertGenerate = false)
public class BizWoExtraPurchaseBo extends BaseEntity {

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 采购内容
     */
    private String itemContent;

    /**
     * 规格
     */
    private String spec;

    /**
     * 数量
     */
    private Long quantity;

    /**
     * 单价
     */
    private Long unitPrice;

    /**
     * 总价
     */
    private Long totalPrice;

    /**
     * 备注
     */
    private String remark;


}
