export interface FinanceRecordVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 财务流水号(如 FIN2026...)
   */
  recordNo: string;

  /**
   * 资金流向: 1-应收/收入, 2-应付/支出
   */
  recordType: string;

  /**
   * 业务类型: 销售出货, 采购入库, 委外加工, 临时工费
   */
  businessType: string;

  /**
   * 关联单号(出货单号/采购单号/工单号)
   */
  relatedNo: string;

  /**
   * 收付款对象(客户名/供应商名/临时工姓名)
   */
  targetName: string;

  /**
   * 发生金额
   */
  amount: number;

  /**
   * 结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清
   */
  settlementStatus: string;

  /**
   * 备注
   */
  remark: string;

}

export interface FinanceRecordForm extends BaseEntity {
  /**
   * 主键ID
   */
  id?: string | number;

  /**
   * 资金流向: 1-应收/收入, 2-应付/支出
   */
  recordType?: string;

  /**
   * 业务类型: 销售出货, 采购入库, 委外加工, 临时工费
   */
  businessType?: string;

  /**
   * 关联单号(出货单号/采购单号/工单号)
   */
  relatedNo?: string;

  /**
   * 收付款对象(客户名/供应商名/临时工姓名)
   */
  targetName?: string;

  /**
   * 发生金额
   */
  amount?: number;

  /**
   * 结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清
   */
  settlementStatus?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface FinanceRecordQuery extends PageQuery {

  /**
   * 财务流水号(如 FIN2026...)
   */
  recordNo?: string;

  /**
   * 资金流向: 1-应收/收入, 2-应付/支出
   */
  recordType?: string;

  /**
   * 业务类型: 销售出货, 采购入库, 委外加工, 临时工费
   */
  businessType?: string;

  /**
   * 关联单号(出货单号/采购单号/工单号)
   */
  relatedNo?: string;

  /**
   * 收付款对象(客户名/供应商名/临时工姓名)
   */
  targetName?: string;

  /**
   * 发生金额
   */
  amount?: number;

  /**
   * 结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清
   */
  settlementStatus?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
