package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoProduct;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;



/**
 * 工单产品明细子视图对象 biz_wo_product
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoProduct.class)
public class BizWoProductVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Long id;

    /**
     * 关联工单ID
     */
    @ExcelProperty(value = "关联工单ID")
    private Long workOrderId;

    /**
     * 产品名称
     */
    @ExcelProperty(value = "产品名称")
    private String productName;

    /**
     * 客户PO号
     */
    @ExcelProperty(value = "客户PO号")
    private String customerPo;

    /**
     * 客户物料号
     */
    @ExcelProperty(value = "客户物料号")
    private String customerMaterialNo;

    /**
     * 规格
     */
    @ExcelProperty(value = "规格")
    private String spec;

    /**
     * 层数(单E,BB等)
     */
    @ExcelProperty(value = "层数(单E,BB等)")
    private String layers;

    /**
     * 刀版号
     */
    @ExcelProperty(value = "刀版号")
    private String knifePlateNo;

    /**
     * 订单数量
     */
    @ExcelProperty(value = "订单数量")
    private Long orderQuantity;

    /**
     * 生产数量
     */
    @ExcelProperty(value = "生产数量")
    private Long produceQuantity;

    /**
     * 单位
     */
    @ExcelProperty(value = "单位")
    private String unit;

    /**
     * 单价
     */
    @ExcelProperty(value = "单价")
    private Long unitPrice;

    /**
     * 总金额
     */
    @ExcelProperty(value = "总金额")
    private Long totalAmount;


}
