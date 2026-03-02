package org.dromara.system.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

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
import org.dromara.system.domain.vo.BizProductionScheduleVo;
import org.dromara.system.domain.bo.BizProductionScheduleBo;
import org.dromara.system.service.IBizProductionScheduleService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 生产排产主
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/erp/productionSchedule")
public class BizProductionScheduleController extends BaseController {

    private final IBizProductionScheduleService bizProductionScheduleService;

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizScheduleNodeMapper scheduleNodeMapper;

    // 👉 核心修改 1：新增注入工单 Mapper，用来查询这笔排产对应的客户是谁
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    private final org.dromara.system.mapper.BizWorkOrderMapper workOrderMapper;

    /**
     * 查询生产排产主列表
     */
    @SaCheckPermission("erp:productionSchedule:list")
    @GetMapping("/list")
    public TableDataInfo<BizProductionScheduleVo> list(BizProductionScheduleBo bo, PageQuery pageQuery) {
        return bizProductionScheduleService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出生产排产主列表
     */
    @SaCheckPermission("erp:productionSchedule:export")
    @Log(title = "生产排产主", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(BizProductionScheduleBo bo, HttpServletResponse response) {
        List<BizProductionScheduleVo> list = bizProductionScheduleService.queryList(bo);
        ExcelUtil.exportExcel(list, "生产排产主", BizProductionScheduleVo.class, response);
    }

    /**
     * 获取生产排产主详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission("erp:productionSchedule:query")
    @GetMapping("/{id}")
    public R<BizProductionScheduleVo> getInfo(@NotNull(message = "主键不能为空")
                                              @PathVariable Long id) {
        return R.ok(bizProductionScheduleService.queryById(id));
    }

    /**
     * 新增生产排产主
     */
    @SaCheckPermission("erp:productionSchedule:add")
    @Log(title = "生产排产主", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody BizProductionScheduleBo bo) {
        return toAjax(bizProductionScheduleService.insertByBo(bo));
    }

    /**
     * 修改生产排产主
     */
    @SaCheckPermission("erp:productionSchedule:edit")
    @Log(title = "生产排产主", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody BizProductionScheduleBo bo) {
        return toAjax(bizProductionScheduleService.updateByBo(bo));
    }

    /**
     * 删除生产排产主
     *
     * @param ids 主键串
     */
    @SaCheckPermission("erp:productionSchedule:remove")
    @Log(title = "生产排产主", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ids) {
        return toAjax(bizProductionScheduleService.deleteWithValidByIds(List.of(ids), true));
    }

    /**
     * 获取排产矩阵大表数据
     */
    @GetMapping("/matrixList")
    public TableDataInfo<Map<String, Object>> getMatrixList(BizProductionScheduleBo bo, PageQuery pageQuery) {
        TableDataInfo<BizProductionScheduleVo> tableData = bizProductionScheduleService.queryPageList(bo, pageQuery);
        List<BizProductionScheduleVo> records = tableData.getRows();

        // 👉 核心修改 2：批量提取本页所有的工单号，并去工单表查出对应的客户名称 (避免循环查库变卡)
        List<String> woNos = records.stream().map(BizProductionScheduleVo::getWorkOrderNo).distinct().collect(Collectors.toList());
        Map<String, String> customerMap = new HashMap<>();
        if (!woNos.isEmpty()) {
            List<org.dromara.system.domain.BizWorkOrder> wos = workOrderMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizWorkOrder>()
                    .in(org.dromara.system.domain.BizWorkOrder::getWorkOrderNo, woNos)
            );
            for (org.dromara.system.domain.BizWorkOrder wo : wos) {
                customerMap.put(wo.getWorkOrderNo(), wo.getCustomerName());
            }
        }

        List<Map<String, Object>> resultList = new java.util.ArrayList<>();

        for (BizProductionScheduleVo schedule : records) {
            Map<String, Object> rowMap = new HashMap<>();
            rowMap.put("id", schedule.getId());
            rowMap.put("workOrderNo", schedule.getWorkOrderNo());

            // 👉 把查到的客户名称塞进返回数据里
            rowMap.put("customerName", customerMap.getOrDefault(schedule.getWorkOrderNo(), ""));

            rowMap.put("itemName", schedule.getItemName());
            rowMap.put("quantity", schedule.getQuantity());
            rowMap.put("deliveryDate", schedule.getDeliveryDate());
            rowMap.put("remark", schedule.getRemark());

            // 查询这一行对应的所有工序格子数据
            List<org.dromara.system.domain.BizScheduleNode> nodes = scheduleNodeMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<org.dromara.system.domain.BizScheduleNode>()
                    .eq(org.dromara.system.domain.BizScheduleNode::getScheduleId, schedule.getId())
            );

            // 把格子按 nodeCode 塞进 Map 中
            for (org.dromara.system.domain.BizScheduleNode node : nodes) {
                Map<String, Object> nodeData = new HashMap<>();
                nodeData.put("id", node.getId());
                nodeData.put("color", node.getStatusColor());
                nodeData.put("content", node.getContent());
                rowMap.put(node.getNodeCode(), nodeData);
            }
            resultList.add(rowMap);
        }

        // 重新包装成分页对象返回给前端
        TableDataInfo<Map<String, Object>> rspData = new TableDataInfo<>();
        rspData.setCode(200);
        rspData.setRows(resultList);
        rspData.setTotal(tableData.getTotal());
        return rspData;
    }
}
