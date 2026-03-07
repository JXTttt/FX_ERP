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
import org.dromara.system.domain.vo.BizCustomerVo;
import org.dromara.system.domain.bo.BizCustomerBo;
import org.dromara.system.service.IBizCustomerService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 客户及供应商
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/customer")
public class BizCustomerController extends BaseController {

    private final IBizCustomerService bizCustomerService;

    /**
     * 查询客户及供应商列表
     */
    @SaCheckPermission("erp:customer:list")
    @GetMapping("/list")
    public TableDataInfo<BizCustomerVo> list(BizCustomerBo bo, PageQuery pageQuery) {
        return bizCustomerService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出客户及供应商列表
     */
    @SaCheckPermission("erp:customer:export")
    @Log(title = "客户及供应商", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizCustomerBo bo, HttpServletResponse response) {
        List<BizCustomerVo> list = bizCustomerService.queryList(bo);
        ExcelUtil.exportExcel(list, "客户及供应商", BizCustomerVo.class, response);
    }

    /**
     * 获取客户及供应商详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:customer:query")
    @GetMapping("/{id}")
    public R<BizCustomerVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizCustomerService.queryById(id));
    }

    /**
     * 新增客户及供应商
     */
    @SaCheckPermission("erp:customer:add")
    @Log(title = "客户及供应商", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizCustomerBo bo) {
        return toAjax(bizCustomerService.insertByBo(bo));
    }

    /**
     * 修改客户及供应商
     */
    @SaCheckPermission("erp:customer:edit")
    @Log(title = "客户及供应商", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizCustomerBo bo) {
        return toAjax(bizCustomerService.updateByBo(bo));
    }

    /**
     * 删除客户及供应商
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:customer:remove")
    @Log(title = "客户及供应商", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizCustomerService.deleteWithValidByIds(List.of(ids), true));
    }

    /**
     * 手动结清客户/供应商账款
     */
    @PostMapping("/settle")
    public R<Void> settleCustomerDebt(@RequestBody BizCustomerBo bo) {
        // 因为是额外动作，建议你新建一个 SettleBo，或者借用现有的 bo，只要有 id, 结算金额, 备注即可。
        // 这里假设你在 BizCustomerBo 中临时加了 settleAmount 和 remark 字段
        bizCustomerService.settleDebt(bo);
        return R.ok();
    }
}
