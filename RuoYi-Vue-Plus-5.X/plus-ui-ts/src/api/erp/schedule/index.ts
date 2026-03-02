import request from '@/utils/request';

// 获取排产矩阵大表数据
export function listMatrix(query: any) {
  return request({
    url: '/erp/productionSchedule/matrixList', // 对应我们之前在 Controller 写的自定义接口
    method: 'get',
    params: query
  });
}

// 修改排产工序节点状态 (RuoYi 代码生成器默认生成的接口)
export function updateScheduleNode(data: any) {
  return request({
    url: '/erp/scheduleNode', // 请确保这个前缀和你代码生成的一致（如果模块名不同，可能叫 /system/scheduleNode 等）
    method: 'put',
    data: data
  });
}