import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { ScheduleNodeVO, ScheduleNodeForm, ScheduleNodeQuery } from '@/api/erp/scheduleNode/types';

/**
 * 查询排产工序节点状态列表
 * @param query
 * @returns {*}
 */

export const listScheduleNode = (query?: ScheduleNodeQuery): AxiosPromise<ScheduleNodeVO[]> => {
  return request({
    url: '/erp/scheduleNode/list',
    method: 'get',
    params: query
  });
};

/**
 * 查询排产工序节点状态详细
 * @param id
 */
export const getScheduleNode = (id: string | number): AxiosPromise<ScheduleNodeVO> => {
  return request({
    url: '/erp/scheduleNode/' + id,
    method: 'get'
  });
};

/**
 * 新增排产工序节点状态
 * @param data
 */
export const addScheduleNode = (data: ScheduleNodeForm) => {
  return request({
    url: '/erp/scheduleNode',
    method: 'post',
    data: data
  });
};

/**
 * 修改排产工序节点状态
 * @param data
 */
export const updateScheduleNode = (data: ScheduleNodeForm) => {
  return request({
    url: '/erp/scheduleNode',
    method: 'put',
    data: data
  });
};

/**
 * 删除排产工序节点状态
 * @param id
 */
export const delScheduleNode = (id: string | number | Array<string | number>) => {
  return request({
    url: '/erp/scheduleNode/' + id,
    method: 'delete'
  });
};
