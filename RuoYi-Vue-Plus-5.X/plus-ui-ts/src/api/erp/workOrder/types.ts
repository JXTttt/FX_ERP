export interface WorkOrderVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 工单编号(例:2602030037)
   */
  workOrderNo: string;

  /**
   * 客户名称快照
   */
  customerName: string;

  /**
   * 客户PO号
   */
  customerPo: string;

  /**
   * 客户物料号
   */
  customerMaterialNo: string;

  /**
   * 产品名称
   */
  productName: string;

  /**
   * 产品编码(拼音+日期)
   */
  productCode: string;

  /**
   * 订单数量
   */
  orderQuantity: number;

  /**
   * 生产数量
   */
  produceQuantity: number;

  /**
   * 单位
   */
  unit: string;

  /**
   * 单价
   */
  unitPrice: number;

  /**
   * 总金额
   */
  totalAmount: number;

  /**
   * 规格
   */
  spec: string;

  /**
   * 层数(单E, BB等)
   */
  layers: string;

  /**
   * 刀版号
   */
  knifePlateNo: string;

  /**
   * 结构类型
   */
  structureType: string;

  /**
   * 开单日期
   */
  orderDate: string;

  /**
   * 交货日期
   */
  deliveryDate: string;

  /**
   * 业务员ID
   */
  salesManId: string | number;

  /**
   * 开单人ID
   */
  operatorId: string | number;

  /**
   * 生产进度: 完成,未完成,已排产,异常
   */
  productionStatus: string;

  /**
   * 审核状态
   */
  auditStatus: string;

  /**
   * 签名
   */
  auditBy: string;

  /**
   * 包装要求
   */
  packRequirement: string;

  /**
   * 备注
   */
  remark: string;

}

export interface WorkOrderForm extends BaseEntity {
  /**
   * 客户名称快照
   */
  customerName?: string;

  /**
   * 客户PO号
   */
  customerPo?: string;

  /**
   * 客户物料号
   */
  customerMaterialNo?: string;

  /**
   * 产品名称
   */
  productName?: string;

  /**
   * 产品编码(拼音+日期)
   */
  productCode?: string;

  /**
   * 订单数量
   */
  orderQuantity?: number;

  /**
   * 生产数量
   */
  produceQuantity?: number;

  /**
   * 单位
   */
  unit?: string;

  /**
   * 单价
   */
  unitPrice?: number;

  /**
   * 规格
   */
  spec?: string;

  /**
   * 层数(单E, BB等)
   */
  layers?: string;

  /**
   * 刀版号
   */
  knifePlateNo?: string;

  /**
   * 结构类型
   */
  structureType?: string;

  /**
   * 开单日期
   */
  orderDate?: string;

  /**
   * 交货日期
   */
  deliveryDate?: string;

  /**
   * 业务员ID
   */
  salesManId?: string | number;

  /**
   * 开单人ID
   */
  operatorId?: string | number;

  /**
   * 生产进度: 完成,未完成,已排产,异常
   */
  productionStatus?: string;

  /**
   * 审核状态
   */
  auditStatus?: string;

  /**
   * 签名
   */
  auditBy?: string;

  /**
   * 包装要求
   */
  packRequirement?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface WorkOrderQuery extends PageQuery {

  /**
   * 工单编号(例:2602030037)
   */
  workOrderNo?: string;

  /**
   * 客户名称快照
   */
  customerName?: string;

  /**
   * 客户PO号
   */
  customerPo?: string;

  /**
   * 客户物料号
   */
  customerMaterialNo?: string;

  /**
   * 产品名称
   */
  productName?: string;

  /**
   * 产品编码(拼音+日期)
   */
  productCode?: string;

  /**
   * 订单数量
   */
  orderQuantity?: number;

  /**
   * 生产数量
   */
  produceQuantity?: number;

  /**
   * 单位
   */
  unit?: string;

  /**
   * 单价
   */
  unitPrice?: number;

  /**
   * 总金额
   */
  totalAmount?: number;

  /**
   * 开单日期
   */
  orderDate?: string;

  /**
   * 交货日期
   */
  deliveryDate?: string;

  /**
   * 业务员ID
   */
  salesManId?: string | number;

  /**
   * 生产进度: 完成,未完成,已排产,异常
   */
  productionStatus?: string;

  /**
   * 审核状态
   */
  auditStatus?: string;

  /**
   * 签名
   */
  auditBy?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
