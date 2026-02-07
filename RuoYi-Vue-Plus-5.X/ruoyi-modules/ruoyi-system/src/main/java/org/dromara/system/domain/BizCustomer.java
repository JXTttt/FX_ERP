package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

import java.io.Serial;

/**
 * 客户及供应商对象 biz_customer
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_customer")
public class BizCustomer extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 客户公司全称
     */
    private String companyName;

    /**
     * 客户编码(唯一标识)
     */
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
     * 备注
     */
    private String remark;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;


}
