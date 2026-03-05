export interface OutsourcingReceiptVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 收货单号(如 OSR2026...)
   */
  receiptNo: string;

  /**
   * 关联工单号
   */
  workOrderNo: string;

  /**
   * 产品/材料名称
   */
  productName: string;

  /**
   * 加工工序
   */
  processProject: string;

  /**
   * 加工商ID
   */
  supplierId: string | number;

  /**
   * 发出数量
   */
  sentQty: number;

  /**
   * 实际验收数量
   */
  receivedQty: number;

  /**
   * 算价方式(张/平方米/套)
   */
  priceMethod: string;

  /**
   * 结算单价
   */
  unitPrice: number;

  /**
   * 结算加工费
   */
  totalFee: number;

  /**
   * 收货日期
   */
  receiptDate: string;

  /**
   * 状态: 0-待入库, 1-已验收结算
   */
  status: string;

  /**
   * 备注
   */
  remark: string;

}

export interface OutsourcingReceiptForm extends BaseEntity {
  /**
   * 收货单号(如 OSR2026...)
   */
  receiptNo?: string;

  /**
   * 关联工单号
   */
  workOrderNo?: string;

  /**
   * 产品/材料名称
   */
  productName?: string;

  /**
   * 加工工序
   */
  processProject?: string;

  /**
   * 加工商ID
   */
  supplierId?: string | number;

  /**
   * 发出数量
   */
  sentQty?: number;

  /**
   * 实际验收数量
   */
  receivedQty?: number;

  /**
   * 算价方式(张/平方米/套)
   */
  priceMethod?: string;

  /**
   * 结算单价
   */
  unitPrice?: number;

  /**
   * 结算加工费
   */
  totalFee?: number;

  /**
   * 收货日期
   */
  receiptDate?: string;

  /**
   * 状态: 0-待入库, 1-已验收结算
   */
  status?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface OutsourcingReceiptQuery extends PageQuery {

  /**
   * 收货单号(如 OSR2026...)
   */
  receiptNo?: string;

  /**
   * 关联工单号
   */
  workOrderNo?: string;

  /**
   * 产品/材料名称
   */
  productName?: string;

  /**
   * 加工工序
   */
  processProject?: string;

  /**
   * 加工商ID
   */
  supplierId?: string | number;

  /**
   * 发出数量
   */
  sentQty?: number;

  /**
   * 实际验收数量
   */
  receivedQty?: number;

  /**
   * 算价方式(张/平方米/套)
   */
  priceMethod?: string;

  /**
   * 结算单价
   */
  unitPrice?: number;

  /**
   * 结算加工费
   */
  totalFee?: number;

  /**
   * 收货日期
   */
  receiptDate?: string;

  /**
   * 状态: 0-待入库, 1-已验收结算
   */
  status?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
