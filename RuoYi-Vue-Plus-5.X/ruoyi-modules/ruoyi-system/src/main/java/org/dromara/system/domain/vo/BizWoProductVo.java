package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoProduct;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;
import java.io.Serializable;

/**
 * 工单产品明细子视图对象 biz_wo_product
 *
 * @author JXTttt
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoProduct.class)
public class BizWoProductVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 产品名称
     */
    @ExcelProperty(value = "产品名称")
    private String productName;

    /**
     * 客户PO号
     */
    @ExcelProperty(value = "客户PO号")
    private String customerPo;

    /**
     * 客户物料号
     */
    @ExcelProperty(value = "客户物料号")
    private String customerMaterialNo;

    /**
     * 规格
     */
    @ExcelProperty(value = "规格")
    private String spec;

    /**
     * 层数(单E,BB等)
     */
    @ExcelProperty(value = "层数(单E,BB等)")
    private String layers;

    /**
     * 刀版号
     */
    @ExcelProperty(value = "刀版号")
    private String knifePlateNo;

    /**
     * 订单数量
     */
    @ExcelProperty(value = "订单数量")
    private Long orderQuantity;

    /**
     * 生产数量
     */
    @ExcelProperty(value = "生产数量")
    private Long produceQuantity;

    /**
     * 单位
     */
    @ExcelProperty(value = "单位")
    private String unit;

    /**
     * 单价 (👉 必须同步改为 BigDecimal)
     */
    @ExcelProperty(value = "单价")
    private BigDecimal unitPrice;

    /**
     * 总金额 (👉 必须同步改为 BigDecimal)
     */
    @ExcelProperty(value = "总金额")
    private BigDecimal totalAmount;

    /**
     * 专属交货日期 (👉 同步新增)
     */
    @ExcelProperty(value = "专属交货日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date deliveryDate;

}
