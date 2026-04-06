package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizCustomer;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.write.style.ColumnWidth;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 客户及供应商视图对象 biz_customer
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@ExcelIgnoreUnannotated // 👉 核心：只导出带有 @ExcelProperty 的字段，底层垃圾数据全部屏蔽！
@AutoMapper(target = BizCustomer.class)
public class BizCustomerVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID (去掉了 @ExcelProperty，完美隐藏)
     */
    private Long id;

    @ExcelProperty(value = "客户/公司全称")
    @ColumnWidth(25)
    private String companyName;

    @ExcelProperty(value = "客户编码")
    @ColumnWidth(15)
    private String customerCode;

    @ExcelProperty(value = "客户简称")
    @ColumnWidth(15)
    private String shortName;

    @ExcelProperty(value = "联系人")
    @ColumnWidth(15)
    private String contactPerson;

    @ExcelProperty(value = "手机号")
    @ColumnWidth(18)
    private String contactPhone;

    /**
     * 核心优化1：利用若依自带的字典转换器，导出时自动把 1/2 翻译成中文
     */
    @ExcelProperty(value = "类型", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_customer_type")
    @ColumnWidth(15)
    private String customerType;

    /**
     * 核心优化2：多选字典的翻译，导出直接变成“模切,光胶”
     */
    @ExcelProperty(value = "供应分类", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_supplier_category", separator = ",")
    @ColumnWidth(20)
    private String supplierCategory;

    private String companyProvince;
    private String companyCity;
    private String companyDistrict;

    @ExcelProperty(value = "公司详细地址")
    @ColumnWidth(35)
    private String companyAddress;

    private String deliveryProvince;
    private String deliveryCity;
    private String deliveryDistrict;

    @ExcelProperty(value = "收货详细地址")
    @ColumnWidth(35)
    private String deliveryAddress;
    private String deliveryUnit;

    @ExcelProperty(value = "银行账户信息")
    @ColumnWidth(30)
    private String bankAccountInfo;

    @ExcelProperty(value = "总交易金额(元)")
    @ColumnWidth(18)
    private BigDecimal totalDealAmount;

    @ExcelProperty(value = "当前欠款/待付(元)")
    @ColumnWidth(18)
    private BigDecimal totalOweAmount;

    @ExcelProperty(value = "备注")
    @ColumnWidth(25)
    private String remark;

    private Long salesManId;
    // 省略了 createBy, createTime 等无用字段，它们再也不会出现在 Excel 里了！
}
