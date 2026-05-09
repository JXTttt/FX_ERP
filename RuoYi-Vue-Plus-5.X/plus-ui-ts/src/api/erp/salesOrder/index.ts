// 文件路径: plus-ui-ts/src/api/erp/salesOrder/index.ts

import request from '@/utils/request';
import { AxiosPromise } from 'axios';
import { SalesOrderVO, SalesOrderDetailBO } from './types';

// 查询销售订单列表
export function listSalesOrder(query?: any) {
  return request({
    url: '/erp/salesOrder/list',
    method: 'get',
    params: query
  });
}

// 查询销售订单详细 (包含明细表)
export function getSalesOrder(id: string | number): AxiosPromise<SalesOrderVO> {
  return request({
    url: '/erp/salesOrder/' + id,
    method: 'get'
  });
}

// 新增销售订单 (职员A录入)
export function addSalesOrder(data: any) {
  return request({
    url: '/erp/salesOrder',
    method: 'post',
    data: data
  });
}

// 修改销售订单主信息
export function updateSalesOrder(data: any) {
  return request({
    url: '/erp/salesOrder',
    method: 'put',
    data: data
  });
}

// 删除销售订单 (仅限草稿)
export function delSalesOrder(id: string | number | (string | number)[]) {
  return request({
    url: '/erp/salesOrder/' + id,
    method: 'delete'
  });
}

// ==========================================
// 核心业务定制接口
// ==========================================

// 修改明细并记录静默日志 (职员B/销售 核价调工艺)
export function updateOrderDetail(data: SalesOrderDetailBO) {
  return request({
    url: '/erp/salesOrder/updateDetail',
    method: 'put',
    data: data
  });
}

// 确认发货并彻底锁定数据
export function confirmDelivery(id: string | number) {
  return request({
    url: '/erp/salesOrder/confirmDelivery/' + id,
    method: 'post'
  });
}