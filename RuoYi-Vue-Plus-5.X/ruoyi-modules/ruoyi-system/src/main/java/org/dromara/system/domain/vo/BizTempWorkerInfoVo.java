package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizTempWorkerInfo;
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
 * 临时工档案台账视图对象 biz_temp_worker_info
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizTempWorkerInfo.class)
public class BizTempWorkerInfoVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 临时工姓名
     */
    @ExcelProperty(value = "临时工姓名")
    private String workerName;

    /**
     * 联系电话
     */
    @ExcelProperty(value = "联系电话")
    private String phone;

    /**
     * 身份证号
     */
    @ExcelProperty(value = "身份证号")
    private String idCard;

    /**
     * 特长/工种
     */
    @ExcelProperty(value = "特长/工种")
    private String skills;

    /**
     * 默认工价(元)
     */
    @ExcelProperty(value = "默认工价(元)")
    private BigDecimal defaultPrice;

    /**
     * 状态: 0-在职, 1-离职
     */
    @ExcelProperty(value = "状态: 0-在职, 1-离职")
    private String status;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
