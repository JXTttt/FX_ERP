package org.dromara.system.domain.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizWoOutsourcing;
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
 * 工单委外加工子视图对象 biz_wo_outsourcing
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoOutsourcing.class)
public class BizWoOutsourcingVo implements Serializable {

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
     * 关联产品名称
     */
    @ExcelProperty(value = "关联产品名称")
    private String productName;

    /**
     * 加工商/供应商ID
     */
    @ExcelProperty(value = "加工商/供应商ID")
    private Long supplierId;

    /**
     * 加工项目
     */
    @ExcelProperty(value = "加工项目")
    private String processProject;

    /**
     * 成品尺寸
     */
    @ExcelProperty(value = "成品尺寸")
    private String finishSize;

    /**
     * 加工数量
     */
    @ExcelProperty(value = "加工数量")
    private Long processQty;

    /**
     * 计算单位
     */
    @ExcelProperty(value = "计算单位")
    private String unit;

    /**
     * 加工单价
     */
    @ExcelProperty(value = "加工单价")
    private Long unitPrice;

    /**
     * 加工总价
     */
    @ExcelProperty(value = "加工总价")
    private Long totalPrice;

    /**
     * 附加费用
     */
    @ExcelProperty(value = "附加费用")
    private Long extraFee;

    /**
     * 交货期
     */
    @ExcelProperty(value = "交货期")
    private Date deliveryDate;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
