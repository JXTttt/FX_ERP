package org.dromara.system.domain.bo;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.system.domain.BizSalesOrder;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 销售订单主表业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizSalesOrder.class, reverseConvertGenerate = false)
public class BizSalesOrderBo extends BaseEntity {

    private Long id;

    // 注意：这里把 @NotBlank 删掉了，因为这个字段现在由后端 Redis 自动生成
    private String orderNo;

    private Long customerId;
    private String customerName;
    private String customerPo;
    private Date deliveryDate;
    private BigDecimal totalAmount;
    private Integer status;
    private Long salesManId;
    private String remark;

    // ===================================
    // 【新增】接收前端传来的产品明细列表
    // ===================================
    private List<BizSalesOrderDetailBo> detailList;
}
