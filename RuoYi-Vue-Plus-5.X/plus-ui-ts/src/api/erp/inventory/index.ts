import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { InventoryVO, InventoryForm, InventoryQuery } from '@/api/erp/inventory/types';

/**
 * 查询库存管理列表
 * @param query
 * @returns {*}
 */

export const listInventory = (query?: InventoryQuery): AxiosPromise<InventoryVO[]> => {
  return request({
    url: '/erp/inventory/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询库存管理详细
 * @param id
 */
export const getInventory = (id: string | number): AxiosPromise<InventoryVO> => {
  return request({
    url: '/erp/inventory/' + id,
    method: 'get'
  });
};

/**
 * 新增库存管理
 * @param data
 */
export const addInventory = (data: InventoryForm) => {
  return request({
    url: '/erp/inventory',
    method: 'post',
    data: data
  });
};

/**
 * 修改库存管理
 * @param data
 */
export const updateInventory = (data: InventoryForm) => {
  return request({
    url: '/erp/inventory',
    method: 'put',
    data: data
  });
};

/**
 * 删除库存管理
 * @param id
 */
export const delInventory = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/inventory/' + id,
    method: 'delete'
  });
};
