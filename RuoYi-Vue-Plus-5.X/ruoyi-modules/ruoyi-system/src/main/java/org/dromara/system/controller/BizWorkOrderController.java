package org.dromara.system.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
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
}
