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
import org.dromara.system.domain.vo.BizWoPostProcessVo;
import org.dromara.system.domain.bo.BizWoPostProcessBo;
import org.dromara.system.service.IBizWoPostProcessService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单后续加工子
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/woPostProcess")
public class BizWoPostProcessController extends BaseController {

    private final IBizWoPostProcessService bizWoPostProcessService;

    /**
     * 查询工单后续加工子列表
     */
    @SaCheckPermission("system:woPostProcess:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoPostProcessVo> list(BizWoPostProcessBo bo, PageQuery pageQuery) {
        return bizWoPostProcessService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单后续加工子列表
     */
    @SaCheckPermission("system:woPostProcess:export")
    @Log(title = "工单后续加工子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoPostProcessBo bo, HttpServletResponse response) {
        List<BizWoPostProcessVo> list = bizWoPostProcessService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单后续加工子", BizWoPostProcessVo.class, response);
    }

    /**
     * 获取工单后续加工子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("system:woPostProcess:query")
    @GetMapping("/{id}")
    public R<BizWoPostProcessVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoPostProcessService.queryById(id));
    }

    /**
     * 新增工单后续加工子
     */
    @SaCheckPermission("system:woPostProcess:add")
    @Log(title = "工单后续加工子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoPostProcessBo bo) {
        return toAjax(bizWoPostProcessService.insertByBo(bo));
    }

    /**
     * 修改工单后续加工子
     */
    @SaCheckPermission("system:woPostProcess:edit")
    @Log(title = "工单后续加工子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoPostProcessBo bo) {
        return toAjax(bizWoPostProcessService.updateByBo(bo));
    }

    /**
     * 删除工单后续加工子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("system:woPostProcess:remove")
    @Log(title = "工单后续加工子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoPostProcessService.deleteWithValidByIds(List.of(ids), true));
    }
}
