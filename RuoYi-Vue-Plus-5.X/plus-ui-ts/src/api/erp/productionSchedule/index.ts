import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { ProductionScheduleVO, ProductionScheduleForm, ProductionScheduleQuery } from '@/api/erp/productionSchedule/types';

/**
 * 查询生产排产主列表
 * @param query
 * @returns {*}
 */

export const listProductionSchedule = (query?: ProductionScheduleQuery): AxiosPromise<ProductionScheduleVO[]> => {
  return request({
    url: '/erp/productionSchedule/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询生产排产主详细
 * @param id
 */
export const getProductionSchedule = (id: string | number): AxiosPromise<ProductionScheduleVO> => {
  return request({
    url: '/erp/productionSchedule/' + id,
    method: 'get'
  });
};

/**
 * 新增生产排产主
 * @param data
 */
export const addProductionSchedule = (data: ProductionScheduleForm) => {
  return request({
    url: '/erp/productionSchedule',
    method: 'post',
    data: data
  });
};

/**
 * 修改生产排产主
 * @param data
 */
export const updateProductionSchedule = (data: ProductionScheduleForm) => {
  return request({
    url: '/erp/productionSchedule',
    method: 'put',
    data: data
  });
};

/**
 * 删除生产排产主
 * @param id
 */
export const delProductionSchedule = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/productionSchedule/' + id,
    method: 'delete'
  });
};
