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
 * 工单委外加工子对象 biz_wo_outsourcing
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_outsourcing")
public class BizWoOutsourcing extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 关联产品名称
     */
    private String productName;

    /**
     * 加工商/供应商ID
     */
    private Long supplierId;

    /**
     * 加工项目
     */
    private String processProject;

    /**
     * 成品尺寸
     */
    private String finishSize;

    /**
     * 加工数量
     */
    private BigDecimal processQty;

    /**
     * 计算单位
     */
    private String unit;

    /**
     * 加工单价
     */
    private BigDecimal unitPrice;

    /**
     * 加工总价
     */
    private BigDecimal totalPrice;

    /**
     * 附加费用
     */
    private BigDecimal extraFee;

    /**
     * 交货期
     */
    private Date deliveryDate;

    /**
     * 备注
     */
    private String remark;


    /**
     * 材料名称
     */
    private String materialName;

    /**
     * 长(mm)
     */
    private BigDecimal length;

    /**
     * 宽(mm)
     */
    private BigDecimal width;

    /**
     * 材料数量
     */
    private Long materialQty;

    /**
     * 需生产良品数量
     */
    private Long goodQty;

    /**
     * 单价计算方式(如:平方米,张,套)
     */
    private String priceMethod;
}
