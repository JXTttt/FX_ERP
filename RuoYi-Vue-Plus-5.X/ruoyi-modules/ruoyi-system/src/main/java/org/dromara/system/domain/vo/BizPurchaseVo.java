package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.system.domain.BizPurchase;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import cn.idev.excel.annotation.write.style.ColumnWidth;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 采购管理视图对象 biz_purchase
 *
 * @author JXTttt
 */
@Data
@ExcelIgnoreUnannotated // 核心：只导出带有 @ExcelProperty 的字段
@AutoMapper(target = BizPurchase.class)
public class BizPurchaseVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID (隐藏)
     */
    private Long id;

    @ExcelProperty(value = "采购单号")
    @ColumnWidth(22)
    private String purchaseNo;

    @ExcelProperty(value = "关联工单编号")
    @ColumnWidth(18)
    private String relatedWoNo;

    /**
     * 供应商ID (去掉 @ExcelProperty，隐藏数字ID)
     */
    private Long supplierId;

    /**
     * 供应商名称 (👉 新增字段：用于导出优雅的中文名称)
     */
    @ExcelProperty(value = "供应商名称")
    @ColumnWidth(25)
    private String supplierName;

    @ExcelProperty(value = "采购内容/名称")
    @ColumnWidth(20)
    private String itemName;

    @ExcelProperty(value = "规格")
    @ColumnWidth(15)
    private String spec;

    @ExcelProperty(value = "采购数量")
    @ColumnWidth(12)
    private BigDecimal applyQty;

    @ExcelProperty(value = "验收数量")
    @ColumnWidth(12)
    private BigDecimal receivedQty;

    @ExcelProperty(value = "采购单价(元)")
    @ColumnWidth(15)
    private BigDecimal price;

    @ExcelProperty(value = "采购总价(元)")
    @ColumnWidth(15)
    private BigDecimal totalPrice;

    /**
     * 状态翻译
     */
    @ExcelProperty(value = "采购状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=待处理,1=已批,2=已验收,3=已驳回")
    @ColumnWidth(15)
    private String status;

    /**
     * 申请人ID (隐藏)
     */
    private Long applicantId;

    @ExcelProperty(value = "验收时间")
    @ColumnWidth(20)
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    private Date verifyTime;

    @ExcelProperty(value = "期望交货期")
    @ColumnWidth(15)
    @DateTimeFormat("yyyy-MM-dd")
    private Date deliveryDate;
}
