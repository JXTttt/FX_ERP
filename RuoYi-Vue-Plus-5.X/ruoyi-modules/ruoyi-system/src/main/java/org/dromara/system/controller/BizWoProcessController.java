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
import org.dromara.system.domain.vo.BizWoProcessVo;
import org.dromara.system.domain.bo.BizWoProcessBo;
import org.dromara.system.service.IBizWoProcessService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单生产工艺子
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woProcess")
public class BizWoProcessController extends BaseController {

    private final IBizWoProcessService bizWoProcessService;

    /**
     * 查询工单生产工艺子列表
     */
    @SaCheckPermission("erp:woProcess:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoProcessVo> list(BizWoProcessBo bo, PageQuery pageQuery) {
        return bizWoProcessService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单生产工艺子列表
     */
    @SaCheckPermission("erp:woProcess:export")
    @Log(title = "工单生产工艺子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoProcessBo bo, HttpServletResponse response) {
        List<BizWoProcessVo> list = bizWoProcessService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单生产工艺子", BizWoProcessVo.class, response);
    }

    /**
     * 获取工单生产工艺子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woProcess:query")
    @GetMapping("/{id}")
    public R<BizWoProcessVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoProcessService.queryById(id));
    }

    /**
     * 新增工单生产工艺子
     */
    @SaCheckPermission("erp:woProcess:add")
    @Log(title = "工单生产工艺子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoProcessBo bo) {
        return toAjax(bizWoProcessService.insertByBo(bo));
    }

    /**
     * 修改工单生产工艺子
     */
    @SaCheckPermission("erp:woProcess:edit")
    @Log(title = "工单生产工艺子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoProcessBo bo) {
        return toAjax(bizWoProcessService.updateByBo(bo));
    }

    /**
     * 删除工单生产工艺子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woProcess:remove")
    @Log(title = "工单生产工艺子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoProcessService.deleteWithValidByIds(List.of(ids), true));
    }
}
