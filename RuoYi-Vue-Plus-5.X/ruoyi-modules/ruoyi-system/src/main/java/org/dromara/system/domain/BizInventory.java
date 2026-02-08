package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

import java.io.Serial;

/**
 * 库存管理对象 biz_inventory
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_inventory")
public class BizInventory extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
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
    private String itemName;

    /**
     * 规格
     */
    private String spec;

    /**
     * 当前库存量
     */
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

    /**
     * 
     */
    @TableLogic
    private String delFlag;


}
