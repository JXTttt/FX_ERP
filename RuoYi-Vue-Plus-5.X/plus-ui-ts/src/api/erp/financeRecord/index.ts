import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { FinanceRecordVO, FinanceRecordForm, FinanceRecordQuery } from '@/api/erp/financeRecord/types';

/**
 * 查询财务收支流水列表
 * @param query
 * @returns {*}
 */

export const listFinanceRecord = (query?: FinanceRecordQuery): AxiosPromise<FinanceRecordVO[]> => {
  return request({
    url: '/erp/financeRecord/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询财务收支流水详细
 * @param id
 */
export const getFinanceRecord = (id: string | number): AxiosPromise<FinanceRecordVO> => {
  return request({
    url: '/erp/financeRecord/' + id,
    method: 'get'
  });
};

/**
 * 新增财务收支流水
 * @param data
 */
export const addFinanceRecord = (data: FinanceRecordForm) => {
  return request({
    url: '/erp/financeRecord',
    method: 'post',
    data: data
  });
};

/**
 * 修改财务收支流水
 * @param data
 */
export const updateFinanceRecord = (data: FinanceRecordForm) => {
  return request({
    url: '/erp/financeRecord',
    method: 'put',
    data: data
  });
};

/**
 * 删除财务收支流水
 * @param id
 */
export const delFinanceRecord = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/financeRecord/' + id,
    method: 'delete'
  });
};
