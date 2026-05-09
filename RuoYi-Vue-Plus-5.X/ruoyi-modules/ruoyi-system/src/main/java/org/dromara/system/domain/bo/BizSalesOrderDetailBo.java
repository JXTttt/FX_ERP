package org.dromara.system.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.system.domain.BizSalesOrderDetail;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 销售订单明细业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizSalesOrderDetail.class, reverseConvertGenerate = false)
public class BizSalesOrderDetailBo extends BaseEntity {

    private Long id;

    @NotNull(message = "订单ID不能为空")
    private Long salesOrderId;

    @NotBlank(message = "产品名称不能为空")
    private String productName;

    private String customerMaterialNo;
    private String spec;
    private String materialReq;
    private String printReq;
    private String craftReq;
    private String packReq;
    private String logisticsReq;

    private BigDecimal unitPrice;
    private BigDecimal taxPrice;

    @NotNull(message = "数量不能为空")
    private Integer quantity;

    private BigDecimal totalAmount;
}
