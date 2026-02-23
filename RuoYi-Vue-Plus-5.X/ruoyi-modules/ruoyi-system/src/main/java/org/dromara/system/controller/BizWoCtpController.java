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
import org.dromara.system.domain.vo.BizWoCtpVo;
import org.dromara.system.domain.bo.BizWoCtpBo;
import org.dromara.system.service.IBizWoCtpService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单CTP子
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woCtp")
public class BizWoCtpController extends BaseController {

    private final IBizWoCtpService bizWoCtpService;

    /**
     * 查询工单CTP子列表
     */
    @SaCheckPermission("erp:woCtp:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoCtpVo> list(BizWoCtpBo bo, PageQuery pageQuery) {
        return bizWoCtpService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单CTP子列表
     */
    @SaCheckPermission("erp:woCtp:export")
    @Log(title = "工单CTP子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoCtpBo bo, HttpServletResponse response) {
        List<BizWoCtpVo> list = bizWoCtpService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单CTP子", BizWoCtpVo.class, response);
    }

    /**
     * 获取工单CTP子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woCtp:query")
    @GetMapping("/{id}")
    public R<BizWoCtpVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoCtpService.queryById(id));
    }

    /**
     * 新增工单CTP子
     */
    @SaCheckPermission("erp:woCtp:add")
    @Log(title = "工单CTP子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoCtpBo bo) {
        return toAjax(bizWoCtpService.insertByBo(bo));
    }

    /**
     * 修改工单CTP子
     */
    @SaCheckPermission("erp:woCtp:edit")
    @Log(title = "工单CTP子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoCtpBo bo) {
        return toAjax(bizWoCtpService.updateByBo(bo));
    }

    /**
     * 删除工单CTP子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woCtp:remove")
    @Log(title = "工单CTP子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoCtpService.deleteWithValidByIds(List.of(ids), true));
    }
}
