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
import org.dromara.system.domain.vo.BizWoMaterialVo;
import org.dromara.system.domain.bo.BizWoMaterialBo;
import org.dromara.system.service.IBizWoMaterialService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单材料子
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woMaterial")
public class BizWoMaterialController extends BaseController {

    private final IBizWoMaterialService bizWoMaterialService;

    /**
     * 查询工单材料子列表
     */
    @SaCheckPermission("erp:woMaterial:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoMaterialVo> list(BizWoMaterialBo bo, PageQuery pageQuery) {
        return bizWoMaterialService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单材料子列表
     */
    @SaCheckPermission("erp:woMaterial:export")
    @Log(title = "工单材料子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoMaterialBo bo, HttpServletResponse response) {
        List<BizWoMaterialVo> list = bizWoMaterialService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单材料子", BizWoMaterialVo.class, response);
    }

    /**
     * 获取工单材料子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woMaterial:query")
    @GetMapping("/{id}")
    public R<BizWoMaterialVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoMaterialService.queryById(id));
    }

    /**
     * 新增工单材料子
     */
    @SaCheckPermission("erp:woMaterial:add")
    @Log(title = "工单材料子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoMaterialBo bo) {
        return toAjax(bizWoMaterialService.insertByBo(bo));
    }

    /**
     * 修改工单材料子
     */
    @SaCheckPermission("erp:woMaterial:edit")
    @Log(title = "工单材料子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoMaterialBo bo) {
        return toAjax(bizWoMaterialService.updateByBo(bo));
    }

    /**
     * 删除工单材料子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woMaterial:remove")
    @Log(title = "工单材料子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoMaterialService.deleteWithValidByIds(List.of(ids), true));
    }
}
