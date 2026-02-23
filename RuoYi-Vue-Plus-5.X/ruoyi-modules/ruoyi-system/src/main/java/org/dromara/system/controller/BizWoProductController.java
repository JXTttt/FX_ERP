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
import org.dromara.system.domain.vo.BizWoProductVo;
import org.dromara.system.domain.bo.BizWoProductBo;
import org.dromara.system.service.IBizWoProductService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 工单产品明细子
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/woProduct")
public class BizWoProductController extends BaseController {

    private final IBizWoProductService bizWoProductService;

    /**
     * 查询工单产品明细子列表
     */
    @SaCheckPermission("erp:woProduct:list")
    @GetMapping("/list")
    public TableDataInfo<BizWoProductVo> list(BizWoProductBo bo, PageQuery pageQuery) {
        return bizWoProductService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出工单产品明细子列表
     */
    @SaCheckPermission("erp:woProduct:export")
    @Log(title = "工单产品明细子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizWoProductBo bo, HttpServletResponse response) {
        List<BizWoProductVo> list = bizWoProductService.queryList(bo);
        ExcelUtil.exportExcel(list, "工单产品明细子", BizWoProductVo.class, response);
    }

    /**
     * 获取工单产品明细子详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:woProduct:query")
    @GetMapping("/{id}")
    public R<BizWoProductVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizWoProductService.queryById(id));
    }

    /**
     * 新增工单产品明细子
     */
    @SaCheckPermission("erp:woProduct:add")
    @Log(title = "工单产品明细子", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizWoProductBo bo) {
        return toAjax(bizWoProductService.insertByBo(bo));
    }

    /**
     * 修改工单产品明细子
     */
    @SaCheckPermission("erp:woProduct:edit")
    @Log(title = "工单产品明细子", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizWoProductBo bo) {
        return toAjax(bizWoProductService.updateByBo(bo));
    }

    /**
     * 删除工单产品明细子
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:woProduct:remove")
    @Log(title = "工单产品明细子", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizWoProductService.deleteWithValidByIds(List.of(ids), true));
    }
}
