package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizInventory;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.write.style.ColumnWidth;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 库存管理视图对象 biz_inventory
 *
 * @author JXTttt
 */
@Data
@ExcelIgnoreUnannotated // 👉 核心：只导出带有 @ExcelProperty 的字段
@AutoMapper(target = BizInventory.class)
public class BizInventoryVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID (隐去 @ExcelProperty，完美隐藏)
     */
    private Long id;

    @ExcelProperty(value = "专用码")
    @ColumnWidth(20)
    private String uniqueCode;

    @ExcelProperty(value = "类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_item_type")
    @ColumnWidth(15)
    private String itemType;

    @ExcelProperty(value = "物料名称")
    @ColumnWidth(25)
    private String itemName;

    @ExcelProperty(value = "规格")
    @ColumnWidth(20)
    private String spec;

    @ExcelProperty(value = "当前库存量")
    @ColumnWidth(15)
    private BigDecimal currentQty;

    @ExcelProperty(value = "单位", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_item_unit")
    @ColumnWidth(12)
    private String unit;

    /**
     * 供应商ID (👉 去掉了 @ExcelProperty，不再把数字 ID 暴露给用户)
     */
    private Long supplierId;

    /**
     * 供应商名称 (👉 新增字段，专门用来导出优雅的中文名称)
     */
    @ExcelProperty(value = "供应商/客户")
    @ColumnWidth(25)
    private String supplierName;

    @ExcelProperty(value = "采购单价(元)")
    @ColumnWidth(18)
    private BigDecimal purchasePrice;

    @ExcelProperty(value = "总金额(元)")
    @ColumnWidth(18)
    private BigDecimal totalAmount;

    // 👉 createBy, createTime 等四个毫无用处的底层字段已经被彻底删除！
}
