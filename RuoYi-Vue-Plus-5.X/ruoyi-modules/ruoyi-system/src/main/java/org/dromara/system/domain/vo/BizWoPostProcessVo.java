package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoPostProcess;
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
 * 工单后续加工子视图对象 biz_wo_post_process
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoPostProcess.class)
public class BizWoPostProcessVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 关联工单ID
     */
    @ExcelProperty(value = "关联工单ID")
    private Long workOrderId;

    /**
     * 供应商ID
     */
    @ExcelProperty(value = "供应商ID")
    private Long supplierId;

    /**
     * 成品尺寸
     */
    @ExcelProperty(value = "成品尺寸")
    private String finishSize;

    /**
     * 形目内容(多选)
     */
    @ExcelProperty(value = "形目内容(多选)")
    private String processContent;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
