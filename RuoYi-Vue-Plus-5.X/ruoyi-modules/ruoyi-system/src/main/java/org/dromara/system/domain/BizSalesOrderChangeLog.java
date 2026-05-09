package org.dromara.system.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 销售订单变更日志对象 biz_sales_order_change_log
 */
@Data
@TableName("biz_sales_order_change_log")
public class BizSalesOrderChangeLog implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /** 订单ID */
    private Long salesOrderId;

    /** 订单明细ID */
    private Long detailId;

    /** 变更字段 */
    private String changeField;

    /** 旧值 */
    private String oldValue;

    /** 新值 */
    private String newValue;

    /** 操作人账号 */
    private String operateBy;

    /** 操作人姓名 */
    private String operateName;

    /** 操作时间 */
    private Date operateTime;
}
