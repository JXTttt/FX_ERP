import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { CustomerVO, CustomerForm, CustomerQuery } from '@/api/erp/customer/types';

/**
 * 查询客户及供应商列表
 * @param query
 * @returns {*}
 */

export const listCustomer = (query?: CustomerQuery): AxiosPromise<CustomerVO[]> => {
  return request({
    url: '/erp/customer/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询客户及供应商详细
 * @param id
 */
export const getCustomer = (id: string | number): AxiosPromise<CustomerVO> => {
  return request({
    url: '/erp/customer/' + id,
    method: 'get'
  });
};

/**
 * 新增客户及供应商
 * @param data
 */
export const addCustomer = (data: CustomerForm) => {
  return request({
    url: '/erp/customer',
    method: 'post',
    data: data
  });
};

/**
 * 修改客户及供应商
 * @param data
 */
export const updateCustomer = (data: CustomerForm) => {
  return request({
    url: '/erp/customer',
    method: 'put',
    data: data
  });
};

/**
 * 删除客户及供应商
 * @param id
 */
export const delCustomer = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/customer/' + id,
    method: 'delete'
  });
};
