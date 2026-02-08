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
import org.dromara.system.domain.vo.BizInventoryVo;
import org.dromara.system.domain.bo.BizInventoryBo;
import org.dromara.system.service.IBizInventoryService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 库存管理
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/inventory")
public class BizInventoryController extends BaseController {

    private final IBizInventoryService bizInventoryService;

    /**
     * 查询库存管理列表
     */
    @SaCheckPermission("erp:inventory:list")
    @GetMapping("/list")
    public TableDataInfo<BizInventoryVo> list(BizInventoryBo bo, PageQuery pageQuery) {
        return bizInventoryService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出库存管理列表
     */
    @SaCheckPermission("erp:inventory:export")
    @Log(title = "库存管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizInventoryBo bo, HttpServletResponse response) {
        List<BizInventoryVo> list = bizInventoryService.queryList(bo);
        ExcelUtil.exportExcel(list, "库存管理", BizInventoryVo.class, response);
    }

    /**
     * 获取库存管理详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:inventory:query")
    @GetMapping("/{id}")
    public R<BizInventoryVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizInventoryService.queryById(id));
    }

    /**
     * 新增库存管理
     */
    @SaCheckPermission("erp:inventory:add")
    @Log(title = "库存管理", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizInventoryBo bo) {
        return toAjax(bizInventoryService.insertByBo(bo));
    }

    /**
     * 修改库存管理
     */
    @SaCheckPermission("erp:inventory:edit")
    @Log(title = "库存管理", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizInventoryBo bo) {
        return toAjax(bizInventoryService.updateByBo(bo));
    }

    /**
     * 删除库存管理
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:inventory:remove")
    @Log(title = "库存管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizInventoryService.deleteWithValidByIds(List.of(ids), true));
    }
}
