package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.system.domain.BizSalesOrder;
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
import java.util.List;

/**
 * 销售订单主表视图对象 biz_sales_order
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizSalesOrder.class)
public class BizSalesOrderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;

    @ExcelProperty(value = "销售订单编号")
    private String orderNo;

    private Long customerId;

    @ExcelProperty(value = "客户名称")
    private String customerName;

    @ExcelProperty(value = "客户PO号")
    private String customerPo;

    @ExcelProperty(value = "交货日期")
    private Date deliveryDate;

    @ExcelProperty(value = "订单总金额")
    private BigDecimal totalAmount;

    @ExcelProperty(value = "状态")
    private Integer status;

    private Long salesManId;

    @ExcelProperty(value = "备注")
    private String remark;

    // ===================================
    // 【新增】用于回显给前端的产品明细列表
    // ===================================
    private List<BizSalesOrderDetailVo> detailList;
}
