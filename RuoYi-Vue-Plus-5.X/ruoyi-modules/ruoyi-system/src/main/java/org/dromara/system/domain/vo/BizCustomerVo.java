package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import org.dromara.system.domain.BizCustomer;
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
 * 客户及供应商视图对象 biz_customer
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizCustomer.class)
public class BizCustomerVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 客户公司全称
     */
    @ExcelProperty(value = "客户公司全称")
    private String companyName;

    /**
     * 客户编码(唯一标识)
     */
    @ExcelProperty(value = "客户编码(唯一标识)")
    private String customerCode;

    /**
     * 客户简称/个人全名
     */
    @ExcelProperty(value = "客户简称/个人全名")
    private String shortName;

    /**
     * 首要联系人名称
     */
    @ExcelProperty(value = "首要联系人名称")
    private String contactPerson;

    /**
     * 联系人手机号
     */
    @ExcelProperty(value = "联系人手机号")
    private String contactPhone;

    /**
     * 类型：1-普通客户, 2-供应商
     */
    @ExcelProperty(value = "类型：1-普通客户, 2-供应商", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_customer_type")
    private String customerType;

    /**
     * 供应商分类
     */
    @ExcelProperty(value = "供应商分类", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "erp_supplier_category") // 加上这个，导出时自动变中文
    private String supplierCategory;

    /**
     * 公司所在省
     */
    @ExcelProperty(value = "公司所在省")
    private String companyProvince;

    /**
     * 公司所在市
     */
    @ExcelProperty(value = "公司所在市")
    private String companyCity;

    /**
     * 公司所在区
     */
    @ExcelProperty(value = "公司所在区")
    private String companyDistrict;

    /**
     * 公司详细地址
     */
    @ExcelProperty(value = "公司详细地址")
    private String companyAddress;

    /**
     * 收货省
     */
    @ExcelProperty(value = "收货省")
    private String deliveryProvince;

    /**
     * 收货市
     */
    @ExcelProperty(value = "收货市")
    private String deliveryCity;

    /**
     * 收货区
     */
    @ExcelProperty(value = "收货区")
    private String deliveryDistrict;

    /**
     * 收货详细地址
     */
    @ExcelProperty(value = "收货详细地址")
    private String deliveryAddress;

    /**
     * 收货单位名称
     */
    @ExcelProperty(value = "收货单位名称")
    private String deliveryUnit;

    /**
     * 银行账户信息(例:工行 张三 6212...)
     */
    @ExcelProperty(value = "银行账户信息(例:工行 张三 6212...)")
    private String bankAccountInfo;

    /**
     * 总交易金额(出货/采购)
     */
    @ExcelProperty(value = "总交易金额(出货/采购)")
    private BigDecimal totalDealAmount;

    /**
     * 当前欠款/待付金额
     */
    @ExcelProperty(value = "当前欠款/待付金额")
    private BigDecimal totalOweAmount;

    /**
     * 业务归属员ID (关联sys_user)
     */
    @ExcelProperty(value = "业务归属员ID (关联sys_user)")
    private Long salesManId;

    /**
     * 创建者
     */
    @ExcelProperty(value = "创建者")
    private String createBy;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 更新者
     */
    @ExcelProperty(value = "更新者")
    private String updateBy;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private Date updateTime;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;


}
