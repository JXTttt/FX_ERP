package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoMaterial;
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
 * 工单材料子视图对象 biz_wo_material
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoMaterial.class)
public class BizWoMaterialVo implements Serializable {

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
     * 部件
     */
    @ExcelProperty(value = "部件")
    private String partName;

    /**
     * 来源
     */
    @ExcelProperty(value = "来源")
    private String sourceType;

    /**
     * 纸张名称
     */
    @ExcelProperty(value = "纸张名称")
    private String paperName;

    /**
     * 需求张数
     */
    @ExcelProperty(value = "需求张数")
    private Long requireQty;

    /**
     * 纸张尺寸
     */
    @ExcelProperty(value = "纸张尺寸")
    private String paperSize;

    /**
     * 切成(如:正度对开)
     */
    @ExcelProperty(value = "切成(如:正度对开)")
    private String cutMethod;

    /**
     * 切纸尺寸
     */
    @ExcelProperty(value = "切纸尺寸")
    private String cutSize;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
