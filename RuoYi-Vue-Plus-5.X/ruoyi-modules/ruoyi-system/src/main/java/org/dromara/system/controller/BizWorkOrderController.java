package org.dromara.system.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.dromara.system.domain.BizOutsourcingReceipt;
import org.dromara.system.mapper.BizOutsourcingReceiptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.system.domain.vo.BizWorkOrderVo;
import org.dromara.system.domain.bo.BizWorkOrderBo;
import org.dromara.system.service.IBizWorkOrderService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单管理
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/workOrder")
public class BizWorkOrderController extends BaseController {

    private final IBizWorkOrderService bizWorkOrderService;
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    private org.dromara.system.mapper.BizOutsourcingReceiptMapper outsourcingReceiptMapper;

    /**
     * 查询工单管理列表
     */
    @SaCheckPermission("erp:workOrder:list")
    @GetMapping("/list")
    public TableDataInfo<BizWorkOrderVo> list(BizWorkOrderBo bo, PageQuery pageQuery) {
        return bizWorkOrderService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单管理列表
     */
    @SaCheckPermission("erp:workOrder:export")
    @Log(title = "工单管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWorkOrderBo bo, HttpServletResponse response) {
        List<BizWorkOrderVo> list = bizWorkOrderService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单管理", BizWorkOrderVo.class, response);
    }

    /**
     * 获取工单管理详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:workOrder:query")
    @GetMapping("/{id}")
    public R<BizWorkOrderVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWorkOrderService.queryById(id));
    }

    /**
     * 新增工单管理
     */
    @SaCheckPermission("erp:workOrder:add")
    @Log(title = "工单管理", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWorkOrderBo bo) {
        return toAjax(bizWorkOrderService.insertByBo(bo));
    }

    /**
     * 修改工单管理
     */
    @SaCheckPermission("erp:workOrder:edit")
    @Log(title = "工单管理", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWorkOrderBo bo) {
        return toAjax(bizWorkOrderService.updateByBo(bo));
    }

    /**
     * 删除工单管理
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:workOrder:remove")
    @Log(title = "工单管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWorkOrderService.deleteWithValidByIds(List.of(ids), true));
    }

    /**
     * 审核工单 (只有拥有 erp:workOrder:audit 权限的人才能看到和调用)
     */
    @SaCheckPermission("erp:workOrder:audit")
    @Log(title = "工单管理-审批", businessType = BusinessType.UPDATE)
    @PutMapping("/audit")
    public R<Void> audit(@RequestBody BizWorkOrderBo bo) {
        return toAjax(bizWorkOrderService.auditWorkOrder(bo));
    }

    /**
     * 一键推送委外加工单到收货表
     */
    @SaCheckPermission("erp:workOrder:edit")
    @Log(title = "委外发货推送", businessType = BusinessType.INSERT)
    @PostMapping("/pushOutsourcing")
    public R<Void> pushOutsourcing(@RequestBody org.dromara.system.domain.BizOutsourcingReceipt receipt) {
        // 生成唯一的收货单号
        receipt.setReceiptNo("OSR" + System.currentTimeMillis());
        // 强制设置初始状态为 "0-待入库"
        receipt.setStatus("0");

        // 避免前端传过来的 null 值导致保存报错
        if (receipt.getUnitPrice() == null) {
            receipt.setUnitPrice(java.math.BigDecimal.ZERO);
        }
        if (receipt.getTotalFee() == null) {
            receipt.setTotalFee(java.math.BigDecimal.ZERO);
        }

        outsourcingReceiptMapper.insert(receipt);
        return R.ok();
    }
}

