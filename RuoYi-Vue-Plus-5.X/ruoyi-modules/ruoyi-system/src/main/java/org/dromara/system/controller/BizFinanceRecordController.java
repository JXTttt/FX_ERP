package org.dromara.system.controller;

import java.util.List;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.extern.slf4j.Slf4j;
import org.dromara.system.mapper.BizFinanceRecordMapper;
import org.dromara.system.mapper.BizTempWorkerMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.dromara.system.domain.vo.BizFinanceRecordVo;
import org.dromara.system.domain.bo.BizFinanceRecordBo;
import org.dromara.system.service.IBizFinanceRecordService;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * 财务收支流水
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/financeRecord")
@Slf4j
public class BizFinanceRecordController extends BaseController {

    private final IBizFinanceRecordService bizFinanceRecordService;
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    private final BizFinanceRecordMapper financeRecordMapper;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    private final BizTempWorkerMapper tempWorkerMapper;

    /**
     * 查询财务收支流水列表
     */
    @SaCheckPermission("erp:financeRecord:list")
    @GetMapping("/list")
    public TableDataInfo<BizFinanceRecordVo> list(BizFinanceRecordBo bo, PageQuery pageQuery) {
        return bizFinanceRecordService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出财务收支流水列表
     */
    @SaCheckPermission("erp:financeRecord:export")
    @Log(title = "财务收支流水", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizFinanceRecordBo bo, HttpServletResponse response) {
        List<BizFinanceRecordVo> list = bizFinanceRecordService.queryList(bo);
        ExcelUtil.exportExcel(list, "财务收支流水", BizFinanceRecordVo.class, response);
    }

    /**
     * 获取财务收支流水详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:financeRecord:query")
    @GetMapping("/{id}")
    public R<BizFinanceRecordVo> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long id) {
        return R.ok(bizFinanceRecordService.queryById(id));
    }

    /**
     * 新增财务收支流水
     */
    @SaCheckPermission("erp:financeRecord:add")
    @Log(title = "财务收支流水", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizFinanceRecordBo bo) {
        return toAjax(bizFinanceRecordService.insertByBo(bo));
    }

    /**
     * 修改财务收支流水
     */
    @SaCheckPermission("erp:financeRecord:edit")
    @Log(title = "财务收支流水", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizFinanceRecordBo bo) {
        return toAjax(bizFinanceRecordService.updateByBo(bo));
    }

    /**
     * 删除财务收支流水
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:financeRecord:remove")
    @Log(title = "财务收支流水", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizFinanceRecordService.deleteWithValidByIds(List.of(ids), true));
    }

    /**
     * 财务批量核销（合并打款）
     */
    @SaCheckPermission("erp:financeRecord:edit")
    @Log(title = "财务流水-批量核销", businessType = BusinessType.UPDATE)
    @PutMapping("/batchSettle")
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public R<Void> batchSettle(@RequestBody java.util.List<Long> ids) {
        for (Long id : ids) {
            org.dromara.system.domain.BizFinanceRecord oldData = financeRecordMapper.selectById(id);
            // 只要不是已结清的状态，就进行结清
            if (oldData != null && !"2".equals(oldData.getSettlementStatus())) {
                oldData.setSettlementStatus("2");
                financeRecordMapper.updateById(oldData);

                // 反向联动：如果是临时工费，追溯并把源头单据改为已付
                if ("临时工费".equals(oldData.getBusinessType()) && oldData.getRecordNo() != null && oldData.getRecordNo().startsWith("FIN-TW-")) {
                    String twIdStr = oldData.getRecordNo().replace("FIN-TW-", "");
                    try {
                        Long twId = Long.parseLong(twIdStr);
                        org.dromara.system.domain.BizTempWorker tw = tempWorkerMapper.selectById(twId);
                        if (tw != null && !"1".equals(tw.getPayStatus())) {
                            tw.setPayStatus("1");
                            tempWorkerMapper.updateById(tw);
                        }
                    } catch (Exception e) {
                        log.error("反向核销临时工状态失败", e);
                    }
                }
            }
        }
        return R.ok();

    }
}
