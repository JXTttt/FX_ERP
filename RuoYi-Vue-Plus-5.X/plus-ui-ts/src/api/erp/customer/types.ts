export interface CustomerVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 客户公司全称
   */
  companyName: string;

  /**
   * 客户编码(唯一标识)
   */
  customerCode: string;

  /**
   * 客户简称/个人全名
   */
  shortName: string;

  /**
   * 首要联系人名称
   */
  contactPerson: string;

  /**
   * 联系人手机号
   */
  contactPhone: string;

  /**
   * 类型：1-普通客户, 2-供应商
   */
  customerType: string;

  /**
   * 公司所在省
   */
  companyProvince: string;

  /**
   * 公司所在市
   */
  companyCity: string;

  /**
   * 公司所在区
   */
  companyDistrict: string;

  /**
   * 公司详细地址
   */
  companyAddress: string;

  /**
   * 收货省
   */
  deliveryProvince: string;

  /**
   * 收货市
   */
  deliveryCity: string;

  /**
   * 收货区
   */
  deliveryDistrict: string;

  /**
   * 收货详细地址
   */
  deliveryAddress: string;

  /**
   * 收货单位名称
   */
  deliveryUnit: string;

  /**
   * 银行账户信息(例:工行 张三 6212...)
   */
  bankAccountInfo: string;

  /**
   * 总交易金额(出货/采购)
   */
  totalDealAmount: number;

  /**
   * 当前欠款/待付金额
   */
  totalOweAmount: number;

  /**
   * 业务归属员ID (关联sys_user)
   */
  salesManId: string | number;

  /**
   * 创建者
   */
  createBy: string;

  /**
   * 创建时间
   */
  createTime: string;

  /**
   * 更新者
   */
  updateBy: string;

  /**
   * 更新时间
   */
  updateTime: string;

  /**
   * 备注
   */
  remark: string;

}

export interface CustomerForm extends BaseEntity {
  id?: string | number;
  /**
   * 客户公司全称
   */
  companyName?: string;

  /**
   * 客户编码(唯一标识)
   */
  customerCode?: string;

  /**
   * 客户简称/个人全名
   */
  shortName?: string;

  /**
   * 首要联系人名称
   */
  contactPerson?: string;

  /**
   * 联系人手机号
   */
  contactPhone?: string;

  /**
   * 类型：1-普通客户, 2-供应商
   */
  customerType?: string;

  /**
   * 公司所在省
   */
  companyProvince?: string;

  /**
   * 公司所在市
   */
  companyCity?: string;

  /**
   * 公司所在区
   */
  companyDistrict?: string;

  /**
   * 公司详细地址
   */
  companyAddress?: string;

  /**
   * 收货省
   */
  deliveryProvince?: string;

  /**
   * 收货市
   */
  deliveryCity?: string;

  /**
   * 收货区
   */
  deliveryDistrict?: string;

  /**
   * 收货详细地址
   */
  deliveryAddress?: string;

  /**
   * 收货单位名称
   */
  deliveryUnit?: string;

  /**
   * 银行账户信息(例:工行 张三 6212...)
   */
  bankAccountInfo?: string;

  /**
   * 业务归属员ID (关联sys_user)
   */
  salesManId?: string | number;

  /**
   * 备注
   */
  remark?: string;

}

export interface CustomerQuery extends PageQuery {

  /**
   * 主键ID
   */
  id?: string | number;

  /**
   * 客户公司全称
   */
  companyName?: string;

  /**
   * 客户编码(唯一标识)
   */
  customerCode?: string;

  /**
   * 客户简称/个人全名
   */
  shortName?: string;

  /**
   * 首要联系人名称
   */
  contactPerson?: string;

  /**
   * 联系人手机号
   */
  contactPhone?: string;

  /**
   * 类型：1-普通客户, 2-供应商
   */
  customerType?: string;

  /**
   * 公司所在省
   */
  companyProvince?: string;

  /**
   * 公司所在市
   */
  companyCity?: string;

  /**
   * 公司所在区
   */
  companyDistrict?: string;

  /**
   * 公司详细地址
   */
  companyAddress?: string;

  /**
   * 收货省
   */
  deliveryProvince?: string;

  /**
   * 收货市
   */
  deliveryCity?: string;

  /**
   * 收货区
   */
  deliveryDistrict?: string;

  /**
   * 收货详细地址
   */
  deliveryAddress?: string;

  /**
   * 收货单位名称
   */
  deliveryUnit?: string;

  /**
   * 银行账户信息(例:工行 张三 6212...)
   */
  bankAccountInfo?: string;

  /**
   * 总交易金额(出货/采购)
   */
  totalDealAmount?: number;

  /**
   * 当前欠款/待付金额
   */
  totalOweAmount?: number;

  /**
   * 业务归属员ID (关联sys_user)
   */
  salesManId?: string | number;

  /**
   * 创建者
   */
  createBy?: string;

  /**
   * 创建时间
   */
  createTime?: string;

  /**
   * 更新者
   */
  updateBy?: string;

  /**
   * 更新时间
   */
  updateTime?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
