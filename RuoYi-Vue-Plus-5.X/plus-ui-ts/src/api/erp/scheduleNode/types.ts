export interface ScheduleNodeVO {
  /**
   * 节点主键ID
   */
  id: string | number;

  /**
   * 关联排产主表ID
   */
  scheduleId: string | number;

  /**
   * 工序编码(如:print, gluing等)
   */
  nodeCode: string;

  /**
   * 工序名称(供参考)
   */
  nodeName: string;

  /**
   * 状态颜色(red, yellow, green, white)
   */
  statusColor: string;

  /**
   * 格子填写的具体内容(日期/文字)
   */
  content: string;

}

export interface ScheduleNodeForm extends BaseEntity {
  /**
   * 工序名称(供参考)
   */
  nodeName?: string;

  /**
   * 状态颜色(red, yellow, green, white)
   */
  statusColor?: string;

  /**
   * 格子填写的具体内容(日期/文字)
   */
  content?: string;

}

export interface ScheduleNodeQuery extends PageQuery {

  /**
   * 关联排产主表ID
   */
  scheduleId?: string | number;

  /**
   * 工序编码(如:print, gluing等)
   */
  nodeCode?: string;

  /**
   * 工序名称(供参考)
   */
  nodeName?: string;

  /**
   * 状态颜色(red, yellow, green, white)
   */
  statusColor?: string;

  /**
   * 格子填写的具体内容(日期/文字)
   */
  content?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
