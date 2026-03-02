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
import org.dromara.system.domain.vo.BizScheduleNodeVo;
import org.dromara.system.domain.bo.BizScheduleNodeBo;
import org.dromara.system.service.IBizScheduleNodeService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 排产工序节点状态
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/scheduleNode")
public class BizScheduleNodeController extends BaseController {

    private final IBizScheduleNodeService bizScheduleNodeService;

    /**
     * 查询排产工序节点状态列表
     */
    @SaCheckPermission("erp:scheduleNode:list")
    @GetMapping("/list")
    public TableDataInfo<BizScheduleNodeVo> list(BizScheduleNodeBo bo, PageQuery pageQuery) {
        return bizScheduleNodeService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出排产工序节点状态列表
     */
    @SaCheckPermission("erp:scheduleNode:export")
    @Log(title = "排产工序节点状态", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizScheduleNodeBo bo, HttpServletResponse response) {
        List<BizScheduleNodeVo> list = bizScheduleNodeService.queryList(bo);
        ExcelUtil.exportExcel(list, "排产工序节点状态", BizScheduleNodeVo.class, response);
    }

    /**
     * 获取排产工序节点状态详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:scheduleNode:query")
    @GetMapping("/{id}")
    public R<BizScheduleNodeVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizScheduleNodeService.queryById(id));
    }

    /**
     * 新增排产工序节点状态
     */
    @SaCheckPermission("erp:scheduleNode:add")
    @Log(title = "排产工序节点状态", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizScheduleNodeBo bo) {
        return toAjax(bizScheduleNodeService.insertByBo(bo));
    }

    /**
     * 修改排产工序节点状态
     */
    @SaCheckPermission("erp:scheduleNode:edit")
    @Log(title = "排产工序节点状态", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizScheduleNodeBo bo) {
        return toAjax(bizScheduleNodeService.updateByBo(bo));
    }

    /**
     * 删除排产工序节点状态
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:scheduleNode:remove")
    @Log(title = "排产工序节点状态", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizScheduleNodeService.deleteWithValidByIds(List.of(ids), true));
    }
}
