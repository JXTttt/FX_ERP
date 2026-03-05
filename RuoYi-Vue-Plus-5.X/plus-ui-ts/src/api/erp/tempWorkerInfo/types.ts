export interface TempWorkerInfoVO {
  /**
   * 主键ID
   */
  id: string | number;

  /**
   * 临时工姓名
   */
  workerName: string;

  /**
   * 联系电话
   */
  phone: string;

  /**
   * 身份证号
   */
  idCard: string | number;

  /**
   * 特长/工种
   */
  skills: string;

  /**
   * 默认工价(元)
   */
  defaultPrice: number;

  /**
   * 状态: 0-在职, 1-离职
   */
  status: string;

  /**
   * 备注
   */
  remark: string;

}

export interface TempWorkerInfoForm extends BaseEntity {
  /**
   * 主键ID
   */
  id?: string | number;

  /**
   * 临时工姓名
   */
  workerName?: string;

  /**
   * 联系电话
   */
  phone?: string;

  /**
   * 身份证号
   */
  idCard?: string | number;

  /**
   * 特长/工种
   */
  skills?: string;

  /**
   * 默认工价(元)
   */
  defaultPrice?: number;

  /**
   * 状态: 0-在职, 1-离职
   */
  status?: string;

  /**
   * 备注
   */
  remark?: string;

}

export interface TempWorkerInfoQuery extends PageQuery {

  /**
   * 临时工姓名
   */
  workerName?: string;

  /**
   * 联系电话
   */
  phone?: string;

  /**
   * 身份证号
   */
  idCard?: string | number;

  /**
   * 特长/工种
   */
  skills?: string;

  /**
   * 默认工价(元)
   */
  defaultPrice?: number;

  /**
   * 状态: 0-在职, 1-离职
   */
  status?: string;

  /**
   * 日期范围参数
   */
  params?: any;
}
