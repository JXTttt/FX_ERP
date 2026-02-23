package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizInventory;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 库存管理业务对象 biz_inventory
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizInventory.class, reverseConvertGenerate = false)
public class BizInventoryBo extends BaseEntity {

    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 专用码
     */
    private String uniqueCode;

    /**
     * 类型
     */
    private String itemType;

    /**
     * 物料名称
     */
    @NotBlank(message = "物料名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String itemName;

    /**
     * 规格
     */
    private String spec;

    /**
     * 当前库存量
     */
    @NotNull(message = "当前库存量不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal currentQty;

    /**
     * 单位
     */
    private String unit;

    /**
     * 供应商ID
     */
    private Long supplierId;

    /**
     * 采购单价
     */
    private BigDecimal purchasePrice;

    /**
     * 总金额
     */
    private BigDecimal totalAmount;

}
