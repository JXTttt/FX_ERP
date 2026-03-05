package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizOutsourcingReceipt;
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
 * 委外收货与结算视图对象 biz_outsourcing_receipt
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizOutsourcingReceipt.class)
public class BizOutsourcingReceiptVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 收货单号(如 OSR2026...)
     */
    @ExcelProperty(value = "收货单号(如 OSR2026...)")
    private String receiptNo;

    /**
     * 关联工单号
     */
    @ExcelProperty(value = "关联工单号")
    private String workOrderNo;

    /**
     * 产品/材料名称
     */
    @ExcelProperty(value = "产品/材料名称")
    private String productName;

    /**
     * 加工工序
     */
    @ExcelProperty(value = "加工工序")
    private String processProject;

    /**
     * 加工商ID
     */
    @ExcelProperty(value = "加工商ID")
    private Long supplierId;

    /**
     * 发出数量
     */
    @ExcelProperty(value = "发出数量")
    private BigDecimal sentQty;

    /**
     * 实际验收数量
     */
    @ExcelProperty(value = "实际验收数量")
    private BigDecimal receivedQty;

    /**
     * 算价方式(张/平方米/套)
     */
    @ExcelProperty(value = "算价方式(张/平方米/套)")
    private String priceMethod;

    /**
     * 结算单价
     */
    @ExcelProperty(value = "结算单价")
    private BigDecimal unitPrice;

    /**
     * 结算加工费
     */
    @ExcelProperty(value = "结算加工费")
    private BigDecimal totalFee;

    /**
     * 收货日期
     */
    @ExcelProperty(value = "收货日期")
    private Date receiptDate;

    /**
     * 状态: 0-待入库, 1-已验收结算
     */
    @ExcelProperty(value = "状态: 0-待入库, 1-已验收结算")
    private String status;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
