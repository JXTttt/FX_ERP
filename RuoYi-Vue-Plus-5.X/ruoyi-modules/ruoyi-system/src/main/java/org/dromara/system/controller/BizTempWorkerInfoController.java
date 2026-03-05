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
import org.dromara.system.domain.vo.BizTempWorkerInfoVo;
import org.dromara.system.domain.bo.BizTempWorkerInfoBo;
import org.dromara.system.service.IBizTempWorkerInfoService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 临时工档案台账
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/tempWorkerInfo")
public class BizTempWorkerInfoController extends BaseController {

    private final IBizTempWorkerInfoService bizTempWorkerInfoService;

    /**
     * 查询临时工档案台账列表
     */
    @SaCheckPermission("erp:tempWorkerInfo:list")
    @GetMapping("/list")
    public TableDataInfo<BizTempWorkerInfoVo> list(BizTempWorkerInfoBo bo, PageQuery pageQuery) {
        return bizTempWorkerInfoService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出临时工档案台账列表
     */
    @SaCheckPermission("erp:tempWorkerInfo:export")
    @Log(title = "临时工档案台账", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizTempWorkerInfoBo bo, HttpServletResponse response) {
        List<BizTempWorkerInfoVo> list = bizTempWorkerInfoService.queryList(bo);
        ExcelUtil.exportExcel(list, "临时工档案台账", BizTempWorkerInfoVo.class, response);
    }

    /**
     * 获取临时工档案台账详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:tempWorkerInfo:query")
    @GetMapping("/{id}")
    public R<BizTempWorkerInfoVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizTempWorkerInfoService.queryById(id));
    }

    /**
     * 新增临时工档案台账
     */
    @SaCheckPermission("erp:tempWorkerInfo:add")
    @Log(title = "临时工档案台账", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizTempWorkerInfoBo bo) {
        return toAjax(bizTempWorkerInfoService.insertByBo(bo));
    }

    /**
     * 修改临时工档案台账
     */
    @SaCheckPermission("erp:tempWorkerInfo:edit")
    @Log(title = "临时工档案台账", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizTempWorkerInfoBo bo) {
        return toAjax(bizTempWorkerInfoService.updateByBo(bo));
    }

    /**
     * 删除临时工档案台账
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:tempWorkerInfo:remove")
    @Log(title = "临时工档案台账", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizTempWorkerInfoService.deleteWithValidByIds(List.of(ids), true));
    }
}
