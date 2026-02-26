import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { WorkOrderVO, WorkOrderForm, WorkOrderQuery } from '@/api/erp/workOrder/types';

/**
 * 查询工单管理列表
 * @param query
 * @returns {*}
 */

export const listWorkOrder = (query?: WorkOrderQuery): AxiosPromise<WorkOrderVO[]> => {
  return request({
    url: '/erp/workOrder/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询工单管理详细
 * @param id
 */
export const getWorkOrder = (id: string | number): AxiosPromise<WorkOrderVO> => {
  return request({
    url: '/erp/workOrder/' + id,
    method: 'get'
  });
};

/**
 * 新增工单管理
 * @param data
 */
export const addWorkOrder = (data: WorkOrderForm) => {
  return request({
    url: '/erp/workOrder',
    method: 'post',
    data: data
  });
};

/**
 * 修改工单管理
 * @param data
 */
export const updateWorkOrder = (data: WorkOrderForm) => {
  return request({
    url: '/erp/workOrder',
    method: 'put',
    data: data
  });
};

/**
 * 删除工单管理
 * @param id
 */
export const delWorkOrder = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/workOrder/' + id,
    method: 'delete'
  });
};

// 审核工单
export const auditWorkOrder = (data: any) => {
  return request({
    url: '/erp/workOrder/audit',
    method: 'put',
    data: data
  });
};
