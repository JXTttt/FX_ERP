package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoCtp;
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
 * 工单CTP子视图对象 biz_wo_ctp
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoCtp.class)
public class BizWoCtpVo implements Serializable {

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
     * 来源(本厂CTP等)
     */
    @ExcelProperty(value = "来源(本厂CTP等)")
    private String sourceType;

    /**
     * 开数(1-9)
     */
    @ExcelProperty(value = "开数(1-9)")
    private Long openNum;

    /**
     * 印刷方式(自反, 天地反等)
     */
    @ExcelProperty(value = "印刷方式(自反, 天地反等)")
    private String printType;

    /**
     * 套数
     */
    @ExcelProperty(value = "套数")
    private Long setNum;

    /**
     * CTP版张数
     */
    @ExcelProperty(value = "CTP版张数")
    private Long plateCount;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
