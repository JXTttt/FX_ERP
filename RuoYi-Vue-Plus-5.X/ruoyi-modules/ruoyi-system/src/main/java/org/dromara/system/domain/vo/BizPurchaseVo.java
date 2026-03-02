package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizPurchase;
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
 * 采购管理视图对象 biz_purchase
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizPurchase.class)
public class BizPurchaseVo implements Serializable {

    /**
     * 主键ID
     */
    private Long id;

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 采购单号
     */
    @ExcelProperty(value = "采购单号")
    private String purchaseNo;

    /**
     * 关联工单编号
     */
    @ExcelProperty(value = "关联工单编号")
    private String relatedWoNo;

    /**
     * 供应商ID
     */
    @ExcelProperty(value = "供应商ID")
    private Long supplierId;

    /**
     * 采购内容/名称
     */
    @ExcelProperty(value = "采购内容/名称")
    private String itemName;

    /**
     * 规格
     */
    @ExcelProperty(value = "规格")
    private String spec;

    /**
     * 采购数量
     */
    @ExcelProperty(value = "采购数量")
    private BigDecimal applyQty;

    /**
     * 验收数量
     */
    @ExcelProperty(value = "验收数量")
    private BigDecimal receivedQty;

    /**
     * 采购单价
     */
    @ExcelProperty(value = "采购单价")
    private BigDecimal price;

    /**
     * 采购总价
     */
    @ExcelProperty(value = "采购总价")
    private BigDecimal totalPrice;

    /**
     * 状态: 0-待审, 1-已批, 2-已验收, 3-驳回
     */
    @ExcelProperty(value = "状态: 0-待审, 1-已批, 2-已验收, 3-驳回")
    private String status;

    /**
     * 申请人ID
     */
    @ExcelProperty(value = "申请人ID")
    private Long applicantId;

    /**
     * 验收时间
     */
    @ExcelProperty(value = "验收时间")
    private Date verifyTime;

    /**
     * 期望交货期
     */
    @ExcelProperty(value = "期望交货期")
    private Date deliveryDate;


}
