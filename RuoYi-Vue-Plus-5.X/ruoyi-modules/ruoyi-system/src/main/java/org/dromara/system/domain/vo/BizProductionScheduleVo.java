package org.dromara.system.domain.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizProductionSchedule;
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
 * 生产排产主视图对象 biz_production_schedule
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizProductionSchedule.class)
public class BizProductionScheduleVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 排产主键ID
     */
    @ExcelProperty(value = "排产主键ID")
    private Long id;

    /**
     * 关联工单ID
     */
    @ExcelProperty(value = "关联工单ID")
    private Long workOrderId;

    /**
     * 工单编号
     */
    @ExcelProperty(value = "工单编号")
    private String workOrderNo;

    /**
     * 生产部件/产品名称
     */
    @ExcelProperty(value = "生产部件/产品名称")
    private String itemName;

    /**
     * 生产数量
     */
    @ExcelProperty(value = "生产数量")
    private Long quantity;

    /**
     * 交货日期
     */
    @ExcelProperty(value = "交货日期")
    private Date deliveryDate;

    /**
     * 跟单备注(最右侧列)
     */
    @ExcelProperty(value = "跟单备注(最右侧列)")
    private String remark;


}
