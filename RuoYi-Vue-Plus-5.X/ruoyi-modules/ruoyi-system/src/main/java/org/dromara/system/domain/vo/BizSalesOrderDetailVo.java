package org.dromara.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.system.domain.BizSalesOrderDetail;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 销售订单明细视图对象
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizSalesOrderDetail.class)
public class BizSalesOrderDetailVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long salesOrderId;

    @ExcelProperty(value = "产品名称")
    private String productName;

    @ExcelProperty(value = "客户物料号")
    private String customerMaterialNo;

    @ExcelProperty(value = "规格尺寸")
    private String spec;

    @ExcelProperty(value = "材质需求")
    private String materialReq;

    @ExcelProperty(value = "印刷要求")
    private String printReq;

    @ExcelProperty(value = "工艺要求")
    private String craftReq;

    @ExcelProperty(value = "包装需求")
    private String packReq;

    @ExcelProperty(value = "物流要求")
    private String logisticsReq;

    @ExcelProperty(value = "不含税单价")
    private BigDecimal unitPrice;

    @ExcelProperty(value = "含税单价")
    private BigDecimal taxPrice;

    @ExcelProperty(value = "数量")
    private Integer quantity;

    @ExcelProperty(value = "总金额")
    private BigDecimal totalAmount;
}
