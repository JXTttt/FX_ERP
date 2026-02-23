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
import org.dromara.system.domain.vo.BizWoPrintVo;
import org.dromara.system.domain.bo.BizWoPrintBo;
import org.dromara.system.service.IBizWoPrintService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单印刷子
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woPrint")
public class BizWoPrintController extends BaseController {

    private final IBizWoPrintService bizWoPrintService;

    /**
     * 查询工单印刷子列表
     */
    @SaCheckPermission("erp:woPrint:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoPrintVo> list(BizWoPrintBo bo, PageQuery pageQuery) {
        return bizWoPrintService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单印刷子列表
     */
    @SaCheckPermission("erp:woPrint:export")
    @Log(title = "工单印刷子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoPrintBo bo, HttpServletResponse response) {
        List<BizWoPrintVo> list = bizWoPrintService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单印刷子", BizWoPrintVo.class, response);
    }

    /**
     * 获取工单印刷子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woPrint:query")
    @GetMapping("/{id}")
    public R<BizWoPrintVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoPrintService.queryById(id));
    }

    /**
     * 新增工单印刷子
     */
    @SaCheckPermission("erp:woPrint:add")
    @Log(title = "工单印刷子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoPrintBo bo) {
        return toAjax(bizWoPrintService.insertByBo(bo));
    }

    /**
     * 修改工单印刷子
     */
    @SaCheckPermission("erp:woPrint:edit")
    @Log(title = "工单印刷子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoPrintBo bo) {
        return toAjax(bizWoPrintService.updateByBo(bo));
    }

    /**
     * 删除工单印刷子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woPrint:remove")
    @Log(title = "工单印刷子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoPrintService.deleteWithValidByIds(List.of(ids), true));
    }
}
