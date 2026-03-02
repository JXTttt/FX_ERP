export interface ProductionScheduleVO {
  /**
   * 排产主键ID
   */
  id: string | number;

  /**
   * 关联工单ID
   */
  workOrderId: string | number;

  /**
   * 工单编号
   */
  workOrderNo: string;

  /**
   * 生产部件/产品名称
   */
  itemName: string;

  /**
   * 生产数量
   */
  quantity: number;

  /**
   * 交货日期
   */
  deliveryDate: string;

  /**
   * 跟单备注(最右侧列)
   */
  remark: string;

}

export interface ProductionScheduleForm extends BaseEntity {
  /**
   * 生产部件/产品名称
   */
  itemName?: string;

  /**
   * 生产数量
   */
  quantity?: number;

  /**
   * 交货日期
   */
  deliveryDate?: string;

  /**
   * 跟单备注(最右侧列)
   */
  remark?: string;

}

export interface ProductionScheduleQuery extends PageQuery {

  /**
   * 关联工单ID
   */
  workOrderId?: string | number;

  /**
   * 工单编号
   */
  workOrderNo?: string;

  /**
   * 生产部件/产品名称
   */
  itemName?: string;

  /**
   * 生产数量
   */
  quantity?: number;

  /**
   * 交货日期
   */
  deliveryDate?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
