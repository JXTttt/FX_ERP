export interface InventoryVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 专用码
   */
  uniqueCode: string;

  /**
   * 类型
   */
  itemType: string;

  /**
   * 物料名称
   */
  itemName: string;

  /**
   * 规格
   */
  spec: string;

  /**
   * 当前库存量
   */
  currentQty: number;

  /**
   * 单位
   */
  unit: string;

  /**
   * 供应商ID
   */
  supplierId: string | number;

  /**
   * 采购单价
   */
  purchasePrice: number;

  /**
   * 总金额
   */
  totalAmount: number;

  /**
   * 
   */
  createBy: string;

  /**
   * 
   */
  createTime: string;

  /**
   * 
   */
  updateBy: string;

  /**
   * 
   */
  updateTime: string;

}

export interface InventoryForm extends BaseEntity {
  /**
   * 专用码
   */
  uniqueCode?: string;

  /**
   * 类型
   */
  itemType?: string;

  /**
   * 物料名称
   */
  itemName?: string;

  /**
   * 规格
   */
  spec?: string;

  /**
   * 当前库存量
   */
  currentQty?: number;

  /**
   * 单位
   */
  unit?: string;

  /**
   * 供应商ID
   */
  supplierId?: string | number;

  /**
   * 采购单价
   */
  purchasePrice?: number;

}

export interface InventoryQuery extends PageQuery {

  /**
   * 主键ID
   */
  id?: string | number;

  /**
   * 专用码
   */
  uniqueCode?: string;

  /**
   * 类型
   */
  itemType?: string;

  /**
   * 物料名称
   */
  itemName?: string;

  /**
   * 规格
   */
  spec?: string;

  /**
   * 当前库存量
   */
  currentQty?: number;

  /**
   * 单位
   */
  unit?: string;

  /**
   * 供应商ID
   */
  supplierId?: string | number;

  /**
   * 采购单价
   */
  purchasePrice?: number;

  /**
   * 总金额
   */
  totalAmount?: number;

  /**
   * 
   */
  createBy?: string;

  /**
   * 
   */
  createTime?: string;

  /**
   * 
   */
  updateBy?: string;

  /**
   * 
   */
  updateTime?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
