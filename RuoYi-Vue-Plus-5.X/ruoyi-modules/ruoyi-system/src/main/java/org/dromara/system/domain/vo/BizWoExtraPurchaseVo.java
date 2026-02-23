package org.dromara.system.domain.vo;

import org.dromara.system.domain.BizWoExtraPurchase;
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
 * 工单其他订购子视图对象 biz_wo_extra_purchase
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWoExtraPurchase.class)
public class BizWoExtraPurchaseVo implements Serializable {

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
     * 采购内容
     */
    @ExcelProperty(value = "采购内容")
    private String itemContent;

    /**
     * 规格
     */
    @ExcelProperty(value = "规格")
    private String spec;

    /**
     * 数量
     */
    @ExcelProperty(value = "数量")
    private Long quantity;

    /**
     * 单价
     */
    @ExcelProperty(value = "单价")
    private Long unitPrice;

    /**
     * 总价
     */
    @ExcelProperty(value = "总价")
    private Long totalPrice;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
