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
import org.dromara.system.domain.vo.BizTempWorkerVo;
import org.dromara.system.domain.bo.BizTempWorkerBo;
import org.dromara.system.service.IBizTempWorkerService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 临时工费用登记
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/tempWorker")
public class BizTempWorkerController extends BaseController {

    private final IBizTempWorkerService bizTempWorkerService;

    /**
     * 查询临时工费用登记列表
     */
    @SaCheckPermission("erp:tempWorker:list")
    @GetMapping("/list")
    public TableDataInfo<BizTempWorkerVo> list(BizTempWorkerBo bo, PageQuery pageQuery) {
        return bizTempWorkerService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出临时工费用登记列表
     */
    @SaCheckPermission("erp:tempWorker:export")
    @Log(title = "临时工费用登记", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizTempWorkerBo bo, HttpServletResponse response) {
        List<BizTempWorkerVo> list = bizTempWorkerService.queryList(bo);
        ExcelUtil.exportExcel(list, "临时工费用登记", BizTempWorkerVo.class, response);
    }

    /**
     * 获取临时工费用登记详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:tempWorker:query")
    @GetMapping("/{id}")
    public R<BizTempWorkerVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizTempWorkerService.queryById(id));
    }

    /**
     * 新增临时工费用登记
     */
    @SaCheckPermission("erp:tempWorker:add")
    @Log(title = "临时工费用登记", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizTempWorkerBo bo) {
        return toAjax(bizTempWorkerService.insertByBo(bo));
    }

    /**
     * 修改临时工费用登记
     */
    @SaCheckPermission("erp:tempWorker:edit")
    @Log(title = "临时工费用登记", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizTempWorkerBo bo) {
        return toAjax(bizTempWorkerService.updateByBo(bo));
    }

    /**
     * 删除临时工费用登记
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:tempWorker:remove")
    @Log(title = "临时工费用登记", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizTempWorkerService.deleteWithValidByIds(List.of(ids), true));
    }
}
