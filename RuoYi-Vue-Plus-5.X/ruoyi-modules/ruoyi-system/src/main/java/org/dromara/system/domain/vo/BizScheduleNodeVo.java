package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizScheduleNode;
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
 * 排产工序节点状态视图对象 biz_schedule_node
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizScheduleNode.class)
public class BizScheduleNodeVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 节点主键ID
     */
    @ExcelProperty(value = "节点主键ID")
    private Long id;

    /**
     * 关联排产主表ID
     */
    @ExcelProperty(value = "关联排产主表ID")
    private Long scheduleId;

    /**
     * 工序编码(如:print, gluing等)
     */
    @ExcelProperty(value = "工序编码(如:print, gluing等)")
    private String nodeCode;

    /**
     * 工序名称(供参考)
     */
    @ExcelProperty(value = "工序名称(供参考)")
    private String nodeName;

    /**
     * 状态颜色(red, yellow, green, white)
     */
    @ExcelProperty(value = "状态颜色(red, yellow, green, white)")
    private String statusColor;

    /**
     * 格子填写的具体内容(日期/文字)
     */
    @ExcelProperty(value = "格子填写的具体内容(日期/文字)")
    private String content;


}
