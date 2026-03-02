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
import org.dromara.system.domain.vo.BizPurchaseVo;
import org.dromara.system.domain.bo.BizPurchaseBo;
import org.dromara.system.service.IBizPurchaseService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 采购管理
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/purchase")
public class BizPurchaseController extends BaseController {

    private final IBizPurchaseService bizPurchaseService;

    /**
     * 查询采购管理列表
     */
    @SaCheckPermission("erp:purchase:list")
    @GetMapping("/list")
    public TableDataInfo<BizPurchaseVo> list(BizPurchaseBo bo, PageQuery pageQuery) {
        return bizPurchaseService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出采购管理列表
     */
    @SaCheckPermission("erp:purchase:export")
    @Log(title = "采购管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizPurchaseBo bo, HttpServletResponse response) {
        List<BizPurchaseVo> list = bizPurchaseService.queryList(bo);
        ExcelUtil.exportExcel(list, "采购管理", BizPurchaseVo.class, response);
    }

    /**
     * 获取采购管理详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:purchase:query")
    @GetMapping("/{id}")
    public R<BizPurchaseVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizPurchaseService.queryById(id));
    }

    /**
     * 新增采购管理
     */
    @SaCheckPermission("erp:purchase:add")
    @Log(title = "采购管理", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizPurchaseBo bo) {
        return toAjax(bizPurchaseService.insertByBo(bo));
    }

    /**
     * 修改采购管理
     */
    @SaCheckPermission("erp:purchase:edit")
    @Log(title = "采购管理", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizPurchaseBo bo) {
        return toAjax(bizPurchaseService.updateByBo(bo));
    }

    /**
     * 删除采购管理
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:purchase:remove")
    @Log(title = "采购管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizPurchaseService.deleteWithValidByIds(List.of(ids), true));
    }
}
