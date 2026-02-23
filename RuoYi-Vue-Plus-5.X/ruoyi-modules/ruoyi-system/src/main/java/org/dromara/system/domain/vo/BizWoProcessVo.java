package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoProcess;
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
 * 工单生产工艺子视图对象 biz_wo_process
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoProcess.class)
public class BizWoProcessVo implements Serializable {

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
     * 工序名称(如:表面处理,裱坑,粘盒)
     */
    @ExcelProperty(value = "工序名称(如:表面处理,裱坑,粘盒)")
    private String processName;

    /**
     * 工艺内容
     */
    @ExcelProperty(value = "工艺内容", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_process_name")
    private String processContent;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
