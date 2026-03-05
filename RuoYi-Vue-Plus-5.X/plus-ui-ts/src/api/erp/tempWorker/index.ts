import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { TempWorkerVO, TempWorkerForm, TempWorkerQuery } from '@/api/erp/tempWorker/types';

/**
 * 查询临时工费用登记列表
 * @param query
 * @returns {*}
 */

export const listTempWorker = (query?: TempWorkerQuery): AxiosPromise<TempWorkerVO[]> => {
  return request({
    url: '/erp/tempWorker/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询临时工费用登记详细
 * @param id
 */
export const getTempWorker = (id: string | number): AxiosPromise<TempWorkerVO> => {
  return request({
    url: '/erp/tempWorker/' + id,
    method: 'get'
  });
};

/**
 * 新增临时工费用登记
 * @param data
 */
export const addTempWorker = (data: TempWorkerForm) => {
  return request({
    url: '/erp/tempWorker',
    method: 'post',
    data: data
  });
};

/**
 * 修改临时工费用登记
 * @param data
 */
export const updateTempWorker = (data: TempWorkerForm) => {
  return request({
    url: '/erp/tempWorker',
    method: 'put',
    data: data
  });
};

/**
 * 删除临时工费用登记
 * @param id
 */
export const delTempWorker = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/tempWorker/' + id,
    method: 'delete'
  });
};
