package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoPrint;
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
 * 工单印刷子视图对象 biz_wo_print
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoPrint.class)
public class BizWoPrintVo implements Serializable {

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
     * 印刷机号
     */
    @ExcelProperty(value = "印刷机号")
    private String machineNo;

    /**
     * 印刷颜色(4C, 1C等)
     */
    @ExcelProperty(value = "印刷颜色(4C, 1C等)")
    private String printColor;

    /**
     * 印刷尺寸
     */
    @ExcelProperty(value = "印刷尺寸")
    private String printSize;

    /**
     * 印刷方式
     */
    @ExcelProperty(value = "印刷方式")
    private String printMethod;

    /**
     * 模数(3+1等)
     */
    @ExcelProperty(value = "模数(3+1等)")
    private String moldNum;

    /**
     * 印刷实数
     */
    @ExcelProperty(value = "印刷实数")
    private Long actualPrintQty;

    /**
     * 损耗数
     */
    @ExcelProperty(value = "损耗数")
    private Long lossQty;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
