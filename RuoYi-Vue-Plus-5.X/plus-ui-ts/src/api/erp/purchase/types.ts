export interface PurchaseVO {
  /**
   * 采购单号
   */
  purchaseNo: string;

  /**
   * 关联工单编号
   */
  relatedWoNo: string;

  /**
   * 供应商ID
   */
  supplierId: string | number;

  /**
   * 采购内容/名称
   */
  itemName: string;

  /**
   * 规格
   */
  spec: string;

  /**
   * 采购数量
   */
  applyQty: number;

  /**
   * 验收数量
   */
  receivedQty: number;

  /**
   * 采购单价
   */
  price: number;

  /**
   * 采购总价
   */
  totalPrice: number;

  /**
   * 状态: 0-待审, 1-已批, 2-已验收, 3-驳回
   */
  status: string;

  /**
   * 申请人ID
   */
  applicantId: string | number;

  /**
   * 验收时间
   */
  verifyTime: string;

  /**
   * 期望交货期
   */
  deliveryDate: string;

}

export interface PurchaseForm extends BaseEntity {
  /**
   * 
   */
  id?: string | number;

  /**
   * 供应商ID
   */
  supplierId?: string | number;

  /**
   * 采购内容/名称
   */
  itemName?: string;

  /**
   * 规格
   */
  spec?: string;

  /**
   * 采购数量
   */
  applyQty?: number;

  /**
   * 验收数量
   */
  receivedQty?: number;

  /**
   * 采购单价
   */
  price?: number;

  /**
   * 采购总价
   */
  totalPrice?: number;

  /**
   * 状态: 0-待审, 1-已批, 2-已验收, 3-驳回
   */
  status?: string;

  /**
   * 申请人ID
   */
  applicantId?: string | number;

  /**
   * 验收时间
   */
  verifyTime?: string;

  /**
   * 期望交货期
   */
  deliveryDate?: string;

}

export interface PurchaseQuery extends PageQuery {

  /**
   * 采购单号
   */
  purchaseNo?: string;

  /**
   * 关联工单编号
   */
  relatedWoNo?: string;

  /**
   * 供应商ID
   */
  supplierId?: string | number;

  /**
   * 采购内容/名称
   */
  itemName?: string;

  /**
   * 规格
   */
  spec?: string;

  /**
   * 采购数量
   */
  applyQty?: number;

  /**
   * 验收数量
   */
  receivedQty?: number;

  /**
   * 采购单价
   */
  price?: number;

  /**
   * 采购总价
   */
  totalPrice?: number;

  /**
   * 状态: 0-待审, 1-已批, 2-已验收, 3-驳回
   */
  status?: string;

  /**
   * 申请人ID
   */
  applicantId?: string | number;

  /**
   * 验收时间
   */
  verifyTime?: string;

  /**
   * 期望交货期
   */
  deliveryDate?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
