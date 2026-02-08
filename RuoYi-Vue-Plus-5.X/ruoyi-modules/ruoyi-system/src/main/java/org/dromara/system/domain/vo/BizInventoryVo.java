package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizInventory;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;



/**
 * 库存管理视图对象 biz_inventory
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizInventory.class)
public class BizInventoryVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 专用码
     */
    @ExcelProperty(value = "专用码")
    private String uniqueCode;

    /**
     * 类型
     */
    @ExcelProperty(value = "类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_item_type")
    private String itemType;

    /**
     * 物料名称
     */
    @ExcelProperty(value = "物料名称")
    private String itemName;

    /**
     * 规格
     */
    @ExcelProperty(value = "规格")
    private String spec;

    /**
     * 当前库存量
     */
    @ExcelProperty(value = "当前库存量")
    private BigDecimal currentQty;

    /**
     * 单位
     */
    @ExcelProperty(value = "单位", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_item_unit")
    private String unit;

    /**
     * 供应商ID
     */
    @ExcelProperty(value = "供应商ID")
    private Long supplierId;

    /**
     * 采购单价
     */
    @ExcelProperty(value = "采购单价")
    private BigDecimal purchasePrice;

    /**
     * 总金额
     */
    @ExcelProperty(value = "总金额")
    private BigDecimal totalAmount;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private String createBy;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date createTime;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private String updateBy;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date updateTime;


}
