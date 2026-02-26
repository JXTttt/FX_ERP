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
 * 工单管理对象 biz_work_order
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_work_order")
public class BizWorkOrder extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 工单编号(例:2602030037)
     */
    private String workOrderNo;

    /**
     * 客户ID
     */
    private Long customerId;

    /**
     * 客户名称快照
     */
    private String customerName;

    /**
     * 客户PO号
     */
    //private String customerPo;

    /**
     * 客户物料号
     */
    //private String customerMaterialNo;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品编码(拼音+日期)
     */
    //private String productCode;

    /**
     * 订单数量
     */
    //private Long orderQuantity;

    /**
     * 生产数量
     */
    //private Long produceQuantity;

    /**
     * 单位
     */
    //private String unit;

    /**
     * 单价
     */
    //private BigDecimal unitPrice;

    /**
     * 总金额
     */
    //private BigDecimal totalAmount;

    /**
     * 规格
     */
    //private String spec;

    /**
     * 层数(单E, BB等)
     */
    //private String layers;

    /**
     * 刀版号
     */
    //private String knifePlateNo;

    /**
     * 结构类型
     */
    //private String structureType;

    /**
     * 开单日期
     */
    private Date orderDate;

    /**
     * 交货日期
     */
    private Date deliveryDate;

    /**
     * 业务员ID
     */
    private Long salesManId;

    /**
     * 开单人ID
     */
    private Long operatorId;

    /**
     * 生产进度: 完成,未完成,已排产,异常
     */
    private String productionStatus;

    /**
     * 审核状态
     */
    private String auditStatus;

    /**
     * 签名
     */
    private String auditBy;

    /**
     * 包装要求
     */
    private String packRequirement;

    /**
     * 备注
     */
    private String remark;

    /**
     *
     */
    @TableLogic
    private String delFlag;


}
