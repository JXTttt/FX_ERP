export interface TempWorkerVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 临时工姓名
   */
  workerName: string;

  /**
   * 工作日期
   */
  workDate: string;

  /**
   * 关联工单号(可为空)
   */
  relatedWoNo: string;

  /**
   * 计费方式: 1-计时, 2-计件
   */
  workType: string;

  /**
   * 数量/时长
   */
  workQty: number;

  /**
   * 单价
   */
  unitPrice: number;

  /**
   * 总薪资
   */
  totalAmount: number;

  /**
   * 支付状态: 0-未付, 1-已付
   */
  payStatus: string;

  /**
   * 工作内容描述
   */
  remark: string;

}

export interface TempWorkerForm extends BaseEntity {
  /**
   * 主键ID
   */
  id?: string | number;

  /**
   * 临时工姓名
   */
  workerName?: string;

  /**
   * 工作日期
   */
  workDate?: string;

  /**
   * 关联工单号(可为空)
   */
  relatedWoNo?: string;

  /**
   * 计费方式: 1-计时, 2-计件
   */
  workType?: string;

  /**
   * 数量/时长
   */
  workQty?: number;

  /**
   * 单价
   */
  unitPrice?: number;

  /**
   * 总薪资
   */
  totalAmount?: number;

  /**
   * 支付状态: 0-未付, 1-已付
   */
  payStatus?: string;

  /**
   * 工作内容描述
   */
  remark?: string;

}

export interface TempWorkerQuery extends PageQuery {

  /**
   * 临时工姓名
   */
  workerName?: string;

  /**
   * 工作日期
   */
  workDate?: string;

  /**
   * 关联工单号(可为空)
   */
  relatedWoNo?: string;

  /**
   * 计费方式: 1-计时, 2-计件
   */
  workType?: string;

  /**
   * 数量/时长
   */
  workQty?: number;

  /**
   * 单价
   */
  unitPrice?: number;

  /**
   * 总薪资
   */
  totalAmount?: number;

  /**
   * 支付状态: 0-未付, 1-已付
   */
  payStatus?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
