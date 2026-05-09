// 文件路径: plus-ui-ts/src/api/erp/salesOrder/types.ts

export interface SalesOrderVO {
  id: string | number;
  orderNo: string;
  customerId: string | number;
  customerName: string;
  customerPo: string;
  deliveryDate: string;
  totalAmount: number;
  status: number; // 0待排单, 1待客确, 2生产中, 3已交货(锁定), 4已取消
  salesManId: string | number;
  remark: string;
  createTime: string;
  detailList?: SalesOrderDetailBO[]; // 绑定的产品明细
}

export interface SalesOrderDetailBO {
  id?: string | number;
  salesOrderId?: string | number;
  customerMaterialNo?: string;
  productName: string;
  spec?: string;
  craftReq?: string;
  unitPrice?: number;
  taxPrice?: number;
  quantity: number;
  totalAmount?: number;
}