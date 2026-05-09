package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 销售订单主表对象 biz_sales_order
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_sales_order")
public class BizSalesOrder extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID - 指定为 AUTO 匹配 SQL 的 AUTO_INCREMENT
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private String orderNo;
    private Long customerId;
    private String customerName;
    private String customerPo;

    /**
     * 交货日期 - 建议指定格式
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date deliveryDate;

    private BigDecimal totalAmount;
    private Integer status;
    private Long salesManId;
    private String remark;

    @TableLogic
    private String delFlag;
}
