import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { TempWorkerInfoVO, TempWorkerInfoForm, TempWorkerInfoQuery } from '@/api/erp/tempWorkerInfo/types';

/**
 * 查询临时工档案台账列表
 * @param query
 * @returns {*}
 */

export const listTempWorkerInfo = (query?: TempWorkerInfoQuery): AxiosPromise<TempWorkerInfoVO[]> => {
  return request({
    url: '/erp/tempWorkerInfo/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询临时工档案台账详细
 * @param id
 */
export const getTempWorkerInfo = (id: string | number): AxiosPromise<TempWorkerInfoVO> => {
  return request({
    url: '/erp/tempWorkerInfo/' + id,
    method: 'get'
  });
};

/**
 * 新增临时工档案台账
 * @param data
 */
export const addTempWorkerInfo = (data: TempWorkerInfoForm) => {
  return request({
    url: '/erp/tempWorkerInfo',
    method: 'post',
    data: data
  });
};

/**
 * 修改临时工档案台账
 * @param data
 */
export const updateTempWorkerInfo = (data: TempWorkerInfoForm) => {
  return request({
    url: '/erp/tempWorkerInfo',
    method: 'put',
    data: data
  });
};

/**
 * 删除临时工档案台账
 * @param id
 */
export const delTempWorkerInfo = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/tempWorkerInfo/' + id,
    method: 'delete'
  });
};
