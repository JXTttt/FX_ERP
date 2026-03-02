import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { PurchaseVO, PurchaseForm, PurchaseQuery } from '@/api/erp/purchase/types';

/**
 * 查询采购管理列表
 * @param query
 * @returns {*}
 */

export const listPurchase = (query?: PurchaseQuery): AxiosPromise<PurchaseVO[]> => {
  return request({
    url: '/erp/purchase/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询采购管理详细
 * @param id
 */
export const getPurchase = (id: string | number): AxiosPromise<PurchaseVO> => {
  return request({
    url: '/erp/purchase/' + id,
    method: 'get'
  });
};

/**
 * 新增采购管理
 * @param data
 */
export const addPurchase = (data: PurchaseForm) => {
  return request({
    url: '/erp/purchase',
    method: 'post',
    data: data
  });
};

/**
 * 修改采购管理
 * @param data
 */
export const updatePurchase = (data: PurchaseForm) => {
  return request({
    url: '/erp/purchase',
    method: 'put',
    data: data
  });
};

/**
 * 删除采购管理
 * @param id
 */
export const delPurchase = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/purchase/' + id,
    method: 'delete'
  });
};
