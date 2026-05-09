package org.dromara.system.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import java.math.BigDecimal;
import java.io.Serial;

/**
 * 销售订单明细对象 biz_sales_order_detail
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_sales_order_detail")
public class BizSalesOrderDetail extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID - 同样指定为 AUTO
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long salesOrderId;
    private String customerMaterialNo;
    private String productName;
    private String spec;
    private String materialReq;
    private String printReq;

    /**
     * 工艺要求
     * 之前讨论过前端传数组，后端存逗号分隔字符串，这里 String 匹配正确
     */
    private String craftReq;

    private String packReq;
    private String logisticsReq;
    private BigDecimal unitPrice;
    private BigDecimal taxPrice;
    private Integer quantity;
    private BigDecimal totalAmount;

    @TableLogic
    private String delFlag;
}
