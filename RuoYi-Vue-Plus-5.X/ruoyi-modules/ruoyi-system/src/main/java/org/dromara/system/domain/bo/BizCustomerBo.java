package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizCustomer;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 客户及供应商业务对象 biz_customer
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizCustomer.class, reverseConvertGenerate = false)
public class BizCustomerBo extends BaseEntity {

    /**
     * 主键ID
     * 修正点1：$Group 改为 EditGroup.class
     * 解释：只有在“修改”时，ID 才是必须的。新增时 ID 是空的。
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 客户公司全称
     * 修正点2：增加 AddGroup.class
     * 解释：客户名称在“新增”和“修改”时都不能为空。
     */
    @NotBlank(message = "客户公司全称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String companyName;

    /**
     * 客户编码(唯一标识)
     * 修正点3：增加 AddGroup.class
     */
    @NotBlank(message = "客户编码(唯一标识)不能为空", groups = { AddGroup.class, EditGroup.class })
    private String customerCode;

    /**
     * 客户简称/个人全名
     */
    private String shortName;

    /**
     * 首要联系人名称
     */
    private String contactPerson;

    /**
     * 联系人手机号
     */
    private String contactPhone;

    /**
     * 类型：1-普通客户, 2-供应商
     */
    private String customerType;

    /**
     * 公司所在省
     */
    private String companyProvince;

    /**
     * 公司所在市
     */
    private String companyCity;

    /**
     * 公司所在区
     */
    private String companyDistrict;

    /**
     * 公司详细地址
     */
    private String companyAddress;

    /**
     * 收货省
     */
    private String deliveryProvince;

    /**
     * 收货市
     */
    private String deliveryCity;

    /**
     * 收货区
     */
    private String deliveryDistrict;

    /**
     * 收货详细地址
     */
    private String deliveryAddress;

    /**
     * 收货单位名称
     */
    private String deliveryUnit;

    /**
     * 银行账户信息(例:工行 张三 6212...)
     */
    private String bankAccountInfo;

    /**
     * 总交易金额(出货/采购)
     */
    private BigDecimal totalDealAmount;

    /**
     * 当前欠款/待付金额
     */
    private BigDecimal totalOweAmount;

    /**
     * 业务归属员ID (关联sys_user)
     */
    private Long salesManId;

    /**
     * 供应商分类(1=面纸,2=模切... 逗号分隔)
     */
    private String supplierCategory;

    /**
     * 备注
     */
    private String remark;

}
