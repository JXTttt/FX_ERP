package org.dromara.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import cn.idev.excel.annotation.write.style.ColumnWidth;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.dromara.system.domain.BizSalesOrderChangeLog;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 销售订单变更日志视图对象 biz_sales_order_change_log
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizSalesOrderChangeLog.class)
public class BizSalesOrderChangeLogVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 日志ID
     */
    private Long id;

    /**
     * 订单ID
     */
    private Long salesOrderId;

    /**
     * 订单明细ID
     */
    private Long detailId;

    /**
     * 变更字段
     */
    @ExcelProperty(value = "变更项")
    @ColumnWidth(20)
    private String changeField;

    /**
     * 旧值
     */
    @ExcelProperty(value = "修改前的内容")
    @ColumnWidth(30)
    private String oldValue;

    /**
     * 新值
     */
    @ExcelProperty(value = "修改后的内容")
    @ColumnWidth(30)
    private String newValue;

    /**
     * 操作人账号
     */
    private String operateBy;

    /**
     * 操作人姓名
     */
    @ExcelProperty(value = "操作人")
    private String operateName;

    /**
     * 操作时间
     */
    @ExcelProperty(value = "操作时间")
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    @ColumnWidth(25)
    private Date operateTime;
}
