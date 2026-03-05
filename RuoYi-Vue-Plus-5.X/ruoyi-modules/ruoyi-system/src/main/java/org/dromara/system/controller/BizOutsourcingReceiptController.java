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
import org.dromara.system.domain.vo.BizOutsourcingReceiptVo;
import org.dromara.system.domain.bo.BizOutsourcingReceiptBo;
import org.dromara.system.service.IBizOutsourcingReceiptService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 委外收货与结算
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/outsourcingReceipt")
public class BizOutsourcingReceiptController extends BaseController {

    private final IBizOutsourcingReceiptService bizOutsourcingReceiptService;

    /**
     * 查询委外收货与结算列表
     */
    @SaCheckPermission("erp:outsourcingReceipt:list")
    @GetMapping("/list")
    public TableDataInfo<BizOutsourcingReceiptVo> list(BizOutsourcingReceiptBo bo, PageQuery pageQuery) {
        return bizOutsourcingReceiptService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出委外收货与结算列表
     */
    @SaCheckPermission("erp:outsourcingReceipt:export")
    @Log(title = "委外收货与结算", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizOutsourcingReceiptBo bo, HttpServletResponse response) {
        List<BizOutsourcingReceiptVo> list = bizOutsourcingReceiptService.queryList(bo);
        ExcelUtil.exportExcel(list, "委外收货与结算", BizOutsourcingReceiptVo.class, response);
    }

    /**
     * 获取委外收货与结算详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:outsourcingReceipt:query")
    @GetMapping("/{id}")
    public R<BizOutsourcingReceiptVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizOutsourcingReceiptService.queryById(id));
    }

    /**
     * 新增委外收货与结算
     */
    @SaCheckPermission("erp:outsourcingReceipt:add")
    @Log(title = "委外收货与结算", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizOutsourcingReceiptBo bo) {
        return toAjax(bizOutsourcingReceiptService.insertByBo(bo));
    }

    /**
     * 修改委外收货与结算
     */
    @SaCheckPermission("erp:outsourcingReceipt:edit")
    @Log(title = "委外收货与结算", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizOutsourcingReceiptBo bo) {
        return toAjax(bizOutsourcingReceiptService.updateByBo(bo));
    }

    /**
     * 删除委外收货与结算
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:outsourcingReceipt:remove")
    @Log(title = "委外收货与结算", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizOutsourcingReceiptService.deleteWithValidByIds(List.of(ids), true));
    }
}
