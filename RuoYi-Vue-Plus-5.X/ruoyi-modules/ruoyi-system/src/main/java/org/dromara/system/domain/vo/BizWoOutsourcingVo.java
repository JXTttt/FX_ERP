package org.dromara.system.domain.vo;

import java.math.BigDecimal;
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

    @ExcelProperty(value = "")
    private Long id;

    @ExcelProperty(value = "关联工单ID")
    private Long workOrderId;

    @ExcelProperty(value = "关联产品名称")
    private String productName;

    @ExcelProperty(value = "加工商/供应商ID")
    private Long supplierId;

    @ExcelProperty(value = "加工项目")
    private String processProject;

    @ExcelProperty(value = "加工细则")
    private String processDetail;

    @ExcelProperty(value = "成品尺寸")
    private String finishSize;

    @ExcelProperty(value = "加工数量")
    private BigDecimal processQty;

    @ExcelProperty(value = "计算单位")
    private String unit;

    @ExcelProperty(value = "加工单价")
    private BigDecimal unitPrice;

    @ExcelProperty(value = "加工总价")
    private BigDecimal totalPrice;

    @ExcelProperty(value = "附加费用")
    private BigDecimal extraFee;

    @ExcelProperty(value = "交货期")
    private Date deliveryDate;

    @ExcelProperty(value = "备注")
    private String remark;

    @ExcelProperty(value = "印刷颜色")
    private String printColor;

    @ExcelProperty(value = "印刷模数")
    private String printImpression;

    @ExcelProperty(value = "印刷机号")
    private String printMachine;

    @ExcelProperty(value = "印刷尺寸")
    private String printSize;

    @ExcelProperty(value = "材料名称")
    private String materialName;

    @ExcelProperty(value = "长(mm)")
    private BigDecimal length;

    @ExcelProperty(value = "宽(mm)")
    private BigDecimal width;

    @ExcelProperty(value = "高(mm)")
    private BigDecimal height;

    @ExcelProperty(value = "材料数量")
    private Long materialQty;
    
    @ExcelProperty(value = "需生产良品数量")
    private Long goodQty;

    @ExcelProperty(value = "单价计算方式")
    private String priceMethod;
}
