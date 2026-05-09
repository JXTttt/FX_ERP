package org.dromara.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.RequiredArgsConstructor;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.system.domain.bo.BizSalesOrderChangeLogBo;
import org.dromara.system.domain.vo.BizSalesOrderChangeLogVo;
import org.dromara.system.service.IBizSalesOrderChangeLogService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 销售订单变更日志
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/salesOrderLog")
public class BizSalesOrderChangeLogController extends BaseController {

    private final IBizSalesOrderChangeLogService logService;

    /**
     * 查询订单变更历史列表
     * 前端调用示例：/erp/salesOrderLog/list?salesOrderId=123
     */
    @SaCheckPermission("erp:salesOrder:query")
    @GetMapping("/list")
    public TableDataInfo<BizSalesOrderChangeLogVo> list(BizSalesOrderChangeLogBo bo, PageQuery pageQuery) {
        return logService.queryPageList(bo, pageQuery);
    }
}
