package org.dromara.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderDetailVo;
import org.dromara.system.service.IBizSalesOrderDetailService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 销售订单明细 控制层 (安全只读版)
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/salesOrderDetail")
public class BizSalesOrderDetailController extends BaseController {

    private final IBizSalesOrderDetailService detailService;

    /**
     * 查询销售订单明细列表
     * 前端传入 salesOrderId 进行关联查询
     */
    @SaCheckPermission("erp:salesOrder:query")
    @GetMapping("/list")
    public TableDataInfo<BizSalesOrderDetailVo> list(BizSalesOrderDetailBo bo, PageQuery pageQuery) {
        // 由于是子表，通常不需要分页，直接返回 List 也可以，但这里保持与框架 TableDataInfo 兼容
        return detailService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取明细单条详细信息
     */
    @SaCheckPermission("erp:salesOrder:query")
    @GetMapping("/{id}")
    public R<BizSalesOrderDetailVo> getInfo(@PathVariable Long id) {
        return R.ok(detailService.queryById(id));
    }

    // =========================================================================
    // 【架构师警告】：
    // 为了保证“静默日志”和“状态防呆死锁”的完整性，明细的修改必须走主 Controller
    // 因此这里特意移除了 @PostMapping, @PutMapping, @DeleteMapping 接口！
    // =========================================================================
}
