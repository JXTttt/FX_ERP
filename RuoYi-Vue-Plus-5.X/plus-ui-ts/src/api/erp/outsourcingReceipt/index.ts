import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { OutsourcingReceiptVO, OutsourcingReceiptForm, OutsourcingReceiptQuery } from '@/api/erp/outsourcingReceipt/types';

/**
 * 查询委外收货与结算列表
 * @param query
 * @returns {*}
 */

export const listOutsourcingReceipt = (query?: OutsourcingReceiptQuery): AxiosPromise<OutsourcingReceiptVO[]> => {
  return request({
    url: '/erp/outsourcingReceipt/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询委外收货与结算详细
 * @param id
 */
export const getOutsourcingReceipt = (id: string | number): AxiosPromise<OutsourcingReceiptVO> => {
  return request({
    url: '/erp/outsourcingReceipt/' + id,
    method: 'get'
  });
};

/**
 * 新增委外收货与结算
 * @param data
 */
export const addOutsourcingReceipt = (data: OutsourcingReceiptForm) => {
  return request({
    url: '/erp/outsourcingReceipt',
    method: 'post',
    data: data
  });
};

/**
 * 修改委外收货与结算
 * @param data
 */
export const updateOutsourcingReceipt = (data: OutsourcingReceiptForm) => {
  return request({
    url: '/erp/outsourcingReceipt',
    method: 'put',
    data: data
  });
};

/**
 * 删除委外收货与结算
 * @param id
 */
export const delOutsourcingReceipt = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/outsourcingReceipt/' + id,
    method: 'delete'
  });
};
