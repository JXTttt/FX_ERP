package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizFinanceRecord;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import cn.idev.excel.annotation.write.style.ColumnWidth;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 财务收支流水视图对象 biz_finance_record
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizFinanceRecord.class)
public class BizFinanceRecordVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     * (因为类上有 @ExcelIgnoreUnannotated，去掉 @ExcelProperty 就会在导出时自动隐藏)
     */
    private Long id;

    /**
     * 财务流水号
     */
    @ExcelProperty(value = "财务流水号")
    @ColumnWidth(22)
    private String recordNo;

    /**
     * 产生时间（创建时间）
     * 增加时间格式化和列宽，防止显示为 ######
     */
    @ExcelProperty(value = "产生时间")
    @ColumnWidth(20)
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 资金流向
     * 增加转换器，将 1和2 自动翻译为中文
     */
    @ExcelProperty(value = "资金流向", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "1=收入/应收,2=支出/应付")
    private String recordType;

    /**
     * 业务类型
     */
    @ExcelProperty(value = "业务类型")
    private String businessType;

    /**
     * 关联单号
     */
    @ExcelProperty(value = "关联单号")
    @ColumnWidth(18)
    private String relatedNo;

    /**
     * 收付款对象
     */
    @ExcelProperty(value = "收付款对象")
    @ColumnWidth(20)
    private String targetName;

    /**
     * 发生金额
     */
    @ExcelProperty(value = "发生金额(元)")
    private BigDecimal amount;

    /**
     * 结算状态
     */
    @ExcelProperty(value = "结算状态", converter = ExcelDictConvert.class)
    @ExcelDictFormat(readConverterExp = "0=未结清,1=部分结清,2=已结清")
    private String settlementStatus;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    @ColumnWidth(30)
    private String remark;

}
