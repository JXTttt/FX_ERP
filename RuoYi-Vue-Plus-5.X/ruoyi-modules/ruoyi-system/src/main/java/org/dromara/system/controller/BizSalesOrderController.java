package org.dromara.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.web.core.BaseController;
import org.dromara.system.domain.bo.BizSalesOrderBo;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderVo;
import org.dromara.system.service.IBizSalesOrderService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 销售订单管理
 * * @author fx_erp
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/salesOrder")
public class BizSalesOrderController extends BaseController {

    private final IBizSalesOrderService salesOrderService;

    /**
     * 查询销售订单列表 (职员A/B/C/D 都能看，但权限标识不同)
     */
    @SaCheckPermission("erp:salesOrder:list")
    @GetMapping("/list")
    public TableDataInfo<BizSalesOrderVo> list(BizSalesOrderBo bo, PageQuery pageQuery) {
        return salesOrderService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出销售订单列表
     */
    @SaCheckPermission("erp:salesOrder:export")
    @Log(title = "销售订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizSalesOrderBo bo, HttpServletResponse response) {
        List<BizSalesOrderVo> list = salesOrderService.queryList(bo);
        ExcelUtil.exportExcel(list, "销售订单数据", BizSalesOrderVo.class, response);
    }

    /**
     * 获取销售订单详细信息 (包含主表和对应的明细)
     */
    @SaCheckPermission("erp:salesOrder:query")
    @GetMapping("/{id}")
    public R<BizSalesOrderVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(salesOrderService.queryById(id));
    }

    /**
     * 新增销售订单 (职员A录入需求)
     */
    @SaCheckPermission("erp:salesOrder:add")
    @Log(title = "销售订单", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizSalesOrderBo bo) {
        return toAjax(salesOrderService.insertByBo(bo));
    }

    /**
     * 修改销售订单基础信息 (主要指主表抬头信息)
     */
    @SaCheckPermission("erp:salesOrder:edit")
    @Log(title = "销售订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizSalesOrderBo bo) {
        return toAjax(salesOrderService.updateByBo(bo));
    }

    /**
     * 删除销售订单 (通常只能删除状态为0的草稿单)
     */
    @SaCheckPermission("erp:salesOrder:remove")
    @Log(title = "销售订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(salesOrderService.deleteWithValidByIds(List.of(ids), true));
    }

    // ==========================================
    // 核心业务：价格/需求微调与状态锁定
    // ==========================================

    /**
     * 修改订单产品明细 (职员B核价、修改工艺，系统会自动对比并生成日志)
     */
    @SaCheckPermission("erp:salesOrder:edit")
    @Log(title = "订单核价", businessType = BusinessType.UPDATE)
    @PutMapping("/updateDetail")
    public R<Void> updateDetail(@Validated @RequestBody BizSalesOrderDetailBo detailBo) {
        salesOrderService.updateDetailWithSilencedLog(detailBo);
        return R.ok();
    }

    /**
     * 确认发货 (终极节点：将状态改为3并死锁所有金额)
     */
    @SaCheckPermission("erp:salesOrder:deliver")
    @Log(title = "订单确认发货", businessType = BusinessType.UPDATE)
    @PostMapping("/confirmDelivery/{id}")
    public R<Void> confirmDelivery(@PathVariable Long id) {
        salesOrderService.confirmDelivery(id);
        return R.ok();
    }
}
