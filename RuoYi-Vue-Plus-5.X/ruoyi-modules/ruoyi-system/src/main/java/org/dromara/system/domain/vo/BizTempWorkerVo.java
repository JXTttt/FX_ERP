package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizTempWorker;
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
 * 临时工费用登记视图对象 biz_temp_worker
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizTempWorker.class)
public class BizTempWorkerVo implements Serializable {

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
     * 工作日期
     */
    @ExcelProperty(value = "工作日期")
    private Date workDate;

    /**
     * 关联工单号(可为空)
     */
    @ExcelProperty(value = "关联工单号(可为空)")
    private String relatedWoNo;

    /**
     * 计费方式: 1-计时, 2-计件
     */
    @ExcelProperty(value = "计费方式: 1-计时, 2-计件")
    private String workType;

    /**
     * 数量/时长
     */
    @ExcelProperty(value = "数量/时长")
    private BigDecimal workQty;

    /**
     * 单价
     */
    @ExcelProperty(value = "单价")
    private BigDecimal unitPrice;

    /**
     * 总薪资
     */
    @ExcelProperty(value = "总薪资")
    private BigDecimal totalAmount;

    /**
     * 支付状态: 0-未付, 1-已付
     */
    @ExcelProperty(value = "支付状态: 0-未付, 1-已付")
    private String payStatus;

    /**
     * 工作内容描述
     */
    @ExcelProperty(value = "工作内容描述")
    private String remark;


}
