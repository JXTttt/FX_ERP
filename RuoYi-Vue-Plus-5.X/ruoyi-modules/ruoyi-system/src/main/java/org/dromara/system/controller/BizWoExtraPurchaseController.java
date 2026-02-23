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
import org.dromara.system.domain.vo.BizWoExtraPurchaseVo;
import org.dromara.system.domain.bo.BizWoExtraPurchaseBo;
import org.dromara.system.service.IBizWoExtraPurchaseService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单其他订购子
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woExtraPurchase")
public class BizWoExtraPurchaseController extends BaseController {

    private final IBizWoExtraPurchaseService bizWoExtraPurchaseService;

    /**
     * 查询工单其他订购子列表
     */
    @SaCheckPermission("erp:woExtraPurchase:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoExtraPurchaseVo> list(BizWoExtraPurchaseBo bo, PageQuery pageQuery) {
        return bizWoExtraPurchaseService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单其他订购子列表
     */
    @SaCheckPermission("erp:woExtraPurchase:export")
    @Log(title = "工单其他订购子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoExtraPurchaseBo bo, HttpServletResponse response) {
        List<BizWoExtraPurchaseVo> list = bizWoExtraPurchaseService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单其他订购子", BizWoExtraPurchaseVo.class, response);
    }

    /**
     * 获取工单其他订购子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woExtraPurchase:query")
    @GetMapping("/{id}")
    public R<BizWoExtraPurchaseVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoExtraPurchaseService.queryById(id));
    }

    /**
     * 新增工单其他订购子
     */
    @SaCheckPermission("erp:woExtraPurchase:add")
    @Log(title = "工单其他订购子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoExtraPurchaseBo bo) {
        return toAjax(bizWoExtraPurchaseService.insertByBo(bo));
    }

    /**
     * 修改工单其他订购子
     */
    @SaCheckPermission("erp:woExtraPurchase:edit")
    @Log(title = "工单其他订购子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoExtraPurchaseBo bo) {
        return toAjax(bizWoExtraPurchaseService.updateByBo(bo));
    }

    /**
     * 删除工单其他订购子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woExtraPurchase:remove")
    @Log(title = "工单其他订购子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoExtraPurchaseService.deleteWithValidByIds(List.of(ids), true));
    }
}
