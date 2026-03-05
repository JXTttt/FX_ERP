package org.dromara.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.mapper.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// 引入排产表
import org.dromara.system.domain.BizProductionSchedule;
import org.dromara.system.domain.BizScheduleNode;

// 引入主表
import org.dromara.system.domain.BizWorkOrder;
import org.dromara.system.domain.bo.BizWorkOrderBo;
import org.dromara.system.domain.vo.BizWorkOrderVo;
import org.dromara.system.service.IBizWorkOrderService;

// 引入子表实体
import org.dromara.system.domain.BizWoProduct;
import org.dromara.system.domain.BizWoMaterial;
import org.dromara.system.domain.BizWoCtp;
import org.dromara.system.domain.BizWoPrint;
import org.dromara.system.domain.BizWoPostProcess;
import org.dromara.system.domain.BizWoExtraPurchase;
import org.dromara.system.domain.BizWoProcess;
import org.dromara.system.domain.BizWoOutsourcing;
// 引入采购表
import org.dromara.system.domain.BizPurchase;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;
import java.util.Date;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;

/**
 * 工单管理Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Slf4j
@RequiredArgsConstructor
@Service
@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
public class BizWorkOrderServiceImpl implements IBizWorkOrderService {

    private final BizWorkOrderMapper baseMapper;

    // 注入 6 个子表的 Mapper
    private final BizWoProductMapper productMapper;
    private final BizWoMaterialMapper materialMapper;
    private final BizWoCtpMapper ctpMapper;
    private final BizWoPrintMapper printMapper;
    private final BizWoPostProcessMapper postProcessMapper;
    private final BizWoExtraPurchaseMapper extraPurchaseMapper;
    private final BizWoProcessMapper processMapper;
    private final BizWoOutsourcingMapper outsourcingMapper;
    private final BizInventoryMapper inventoryMapper;

    // 排产大表相关
    private final BizProductionScheduleMapper scheduleMapper;
    private final BizScheduleNodeMapper scheduleNodeMapper;
    private final BizWoProductMapper woProductMapper;

    // 注入采购单Mapper
    private final BizPurchaseMapper purchaseMapper;

    @Override
    public BizWorkOrderVo queryById(Long id){
        BizWorkOrderVo vo = baseMapper.selectVoById(id);
        if (vo != null) {
            vo.setProductList(productMapper.selectVoList(new LambdaQueryWrapper<BizWoProduct>().eq(BizWoProduct::getWorkOrderId, id)));
            vo.setMaterialList(materialMapper.selectVoList(new LambdaQueryWrapper<BizWoMaterial>().eq(BizWoMaterial::getWorkOrderId, id)));
            vo.setCtpList(ctpMapper.selectVoList(new LambdaQueryWrapper<BizWoCtp>().eq(BizWoCtp::getWorkOrderId, id)));
            vo.setPrintList(printMapper.selectVoList(new LambdaQueryWrapper<BizWoPrint>().eq(BizWoPrint::getWorkOrderId, id)));
            vo.setPostProcessList(postProcessMapper.selectVoList(new LambdaQueryWrapper<BizWoPostProcess>().eq(BizWoPostProcess::getWorkOrderId, id)));
            vo.setExtraPurchaseList(extraPurchaseMapper.selectVoList(new LambdaQueryWrapper<BizWoExtraPurchase>().eq(BizWoExtraPurchase::getWorkOrderId, id)));
            vo.setProcessList(processMapper.selectVoList(new LambdaQueryWrapper<BizWoProcess>().eq(BizWoProcess::getWorkOrderId, id)));
            vo.setOutsourcingList(outsourcingMapper.selectVoList(new LambdaQueryWrapper<BizWoOutsourcing>().eq(BizWoOutsourcing::getWorkOrderId, id)));
        }
        return vo;
    }

    @Override
    public TableDataInfo<BizWorkOrderVo> queryPageList(BizWorkOrderBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWorkOrder> lqw = buildQueryWrapper(bo);
        Page<BizWorkOrderVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<BizWorkOrderVo> queryList(BizWorkOrderBo bo) {
        LambdaQueryWrapper<BizWorkOrder> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWorkOrder> buildQueryWrapper(BizWorkOrderBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWorkOrder> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getId() != null, BizWorkOrder::getId, bo.getId());
        lqw.orderByDesc(BizWorkOrder::getId);
        lqw.eq(StringUtils.isNotBlank(bo.getWorkOrderNo()), BizWorkOrder::getWorkOrderNo, bo.getWorkOrderNo());
        lqw.like(StringUtils.isNotBlank(bo.getCustomerName()), BizWorkOrder::getCustomerName, bo.getCustomerName());
        lqw.like(StringUtils.isNotBlank(bo.getProductName()), BizWorkOrder::getProductName, bo.getProductName());
        lqw.eq(bo.getOrderDate() != null, BizWorkOrder::getOrderDate, bo.getOrderDate());
        lqw.eq(bo.getDeliveryDate() != null, BizWorkOrder::getDeliveryDate, bo.getDeliveryDate());
        lqw.eq(StringUtils.isNotBlank(bo.getProductionStatus()), BizWorkOrder::getProductionStatus, bo.getProductionStatus());
        return lqw;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(BizWorkOrderBo bo) {
        if (StringUtils.isBlank(bo.getWorkOrderNo())) {
            String dateStr = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyMMdd"));
            Long count = baseMapper.selectCount(new LambdaQueryWrapper<BizWorkOrder>().likeRight(BizWorkOrder::getWorkOrderNo, dateStr));
            bo.setWorkOrderNo(dateStr + String.format("%04d", count == null ? 0 : count + 1));
        }

        BizWorkOrder add = MapstructUtils.convert(bo, BizWorkOrder.class);
        validEntityBeforeSave(add);

        // 核心：新建工单状态默认为 "1-待审批"
        add.setAuditStatus("1");

        boolean flag = baseMapper.insert(add) > 0;

        if (flag) {
            bo.setId(add.getId());
            insertChildren(bo);
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(BizWorkOrderBo bo) {
        BizWorkOrder update = MapstructUtils.convert(bo, BizWorkOrder.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        if (flag) {
            deleteChildren(bo.getId());
            insertChildren(bo);
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验
        }
        boolean flag = baseMapper.deleteBatchIds(ids) > 0;
        if (flag) {
            for (Long id : ids) {
                deleteChildren(id);
            }
        }
        return flag;
    }

    private void insertChildren(BizWorkOrderBo bo) {
        Long woId = bo.getId();

        if (bo.getProductList() != null && !bo.getProductList().isEmpty()) {
            List<BizWoProduct> list = MapstructUtils.convert(bo.getProductList(), BizWoProduct.class);
            list = list.stream().filter(i -> StringUtils.isNotBlank(i.getProductName())).collect(java.util.stream.Collectors.toList());
            if(!list.isEmpty()) {
                list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
                productMapper.insertBatch(list);
            }
        }

        // 保存材料清单：只要部件名或物料名填写了任意一个就不抛弃
        if (bo.getMaterialList() != null && !bo.getMaterialList().isEmpty()) {
            List<BizWoMaterial> list = MapstructUtils.convert(bo.getMaterialList(), BizWoMaterial.class);
            list = list.stream()
                .filter(i -> StringUtils.isNotBlank(i.getPartName()) || StringUtils.isNotBlank(i.getPaperName()))
                .collect(java.util.stream.Collectors.toList());

            if(!list.isEmpty()) {
                list.forEach(i -> {
                    i.setWorkOrderId(woId);
                    i.setId(null);
                    if (StringUtils.isBlank(i.getPartName())) {
                        i.setPartName("默认部件");
                    }
                });
                materialMapper.insertBatch(list);
            }
        }

        if (bo.getCtpList() != null && !bo.getCtpList().isEmpty()) {
            List<BizWoCtp> list = MapstructUtils.convert(bo.getCtpList(), BizWoCtp.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            ctpMapper.insertBatch(list);
        }
        if (bo.getPrintList() != null && !bo.getPrintList().isEmpty()) {
            List<BizWoPrint> list = MapstructUtils.convert(bo.getPrintList(), BizWoPrint.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            printMapper.insertBatch(list);
        }
        if (bo.getPostProcessList() != null && !bo.getPostProcessList().isEmpty()) {
            List<BizWoPostProcess> list = MapstructUtils.convert(bo.getPostProcessList(), BizWoPostProcess.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            postProcessMapper.insertBatch(list);
        }

        // 👉 新增保存其它订料
        if (bo.getExtraPurchaseList() != null && !bo.getExtraPurchaseList().isEmpty()) {
            List<BizWoExtraPurchase> list = MapstructUtils.convert(bo.getExtraPurchaseList(), BizWoExtraPurchase.class);
            list = list.stream().filter(i -> StringUtils.isNotBlank(i.getItemContent())).collect(java.util.stream.Collectors.toList());
            if(!list.isEmpty()) {
                list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
                extraPurchaseMapper.insertBatch(list);
            }
        }

        if (bo.getProcessList() != null && !bo.getProcessList().isEmpty()) {
            List<BizWoProcess> list = MapstructUtils.convert(bo.getProcessList(), BizWoProcess.class);
            list = list.stream().filter(i -> StringUtils.isNotBlank(i.getProcessName())).collect(java.util.stream.Collectors.toList());
            if(!list.isEmpty()) {
                list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
                processMapper.insertBatch(list);
            }
        }
        if (bo.getOutsourcingList() != null && !bo.getOutsourcingList().isEmpty()) {
            List<BizWoOutsourcing> list = MapstructUtils.convert(bo.getOutsourcingList(), BizWoOutsourcing.class);
            list = list.stream().filter(i -> StringUtils.isNotBlank(i.getProcessProject())).collect(java.util.stream.Collectors.toList());
            if(!list.isEmpty()) {
                list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
                outsourcingMapper.insertBatch(list);
            }
        }
    }

    private void deleteChildren(Long woId) {
        productMapper.delete(new LambdaQueryWrapper<BizWoProduct>().eq(BizWoProduct::getWorkOrderId, woId));
        materialMapper.delete(new LambdaQueryWrapper<BizWoMaterial>().eq(BizWoMaterial::getWorkOrderId, woId));
        ctpMapper.delete(new LambdaQueryWrapper<BizWoCtp>().eq(BizWoCtp::getWorkOrderId, woId));
        printMapper.delete(new LambdaQueryWrapper<BizWoPrint>().eq(BizWoPrint::getWorkOrderId, woId));
        postProcessMapper.delete(new LambdaQueryWrapper<BizWoPostProcess>().eq(BizWoPostProcess::getWorkOrderId, woId));
        extraPurchaseMapper.delete(new LambdaQueryWrapper<BizWoExtraPurchase>().eq(BizWoExtraPurchase::getWorkOrderId, woId));
        processMapper.delete(new LambdaQueryWrapper<BizWoProcess>().eq(BizWoProcess::getWorkOrderId, woId));
        outsourcingMapper.delete(new LambdaQueryWrapper<BizWoOutsourcing>().eq(BizWoOutsourcing::getWorkOrderId, woId));
    }

    private void validEntityBeforeSave(BizWorkOrder entity){
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean auditWorkOrder(BizWorkOrderBo bo) {
        BizWorkOrder workOrder = new BizWorkOrder();
        workOrder.setId(bo.getId());
        workOrder.setAuditStatus(bo.getAuditStatus());
        workOrder.setAuditBy(org.dromara.common.satoken.utils.LoginHelper.getUsername());

        boolean flag = baseMapper.updateById(workOrder) > 0;

        // 如果审核状态是“2-已通过”且更新成功
        if (flag && "2".equals(bo.getAuditStatus())) {
            // 1. 自动生成排产大表格子
            generateScheduleTasks(bo.getId());
            // 2. 自动生成采购需求单 (👉 核心修改：只从“其它订料”生成)
            generatePurchaseOrders(bo.getId());

            // 3. 自动扣减本厂原材料库存 (来源: 本厂)
            deductInHouseMaterials(bo.getId());
        }

        return flag;
    }

    /**
     * 【重构】：根据“其它订料”清单统一生成采购需求单，不再读取原先的材料清单
     */
    private void generatePurchaseOrders(Long workOrderId) {
        // 1. 查询工单主表获取工单号
        BizWorkOrder wo = baseMapper.selectById(workOrderId);
        if (wo == null) return;

        // 2. 直接查询该工单下的“其它订购(外发/采购集散地)”列表
        List<BizWoExtraPurchase> extraPurchases = extraPurchaseMapper.selectList(
            new LambdaQueryWrapper<BizWoExtraPurchase>()
                .eq(BizWoExtraPurchase::getWorkOrderId, workOrderId)
        );

        if (extraPurchases != null && !extraPurchases.isEmpty()) {
            for (BizWoExtraPurchase extra : extraPurchases) {
                BizPurchase purchase = new BizPurchase();

                // 自动生成采购单号
                String purchaseNo = "CG" + DateUtil.format(new Date(), "yyyyMMddHHmmss") + RandomUtil.randomNumbers(2);
                purchase.setPurchaseNo(purchaseNo);
                purchase.setRelatedWoNo(wo.getWorkOrderNo()); // 绑定工单号

                // 精准匹配实体类里的 itemContent 字段
                purchase.setItemName(extra.getItemContent());
                // 绑定规格
                purchase.setSpec(extra.getSpec());

                // 转换数量
                if (extra.getQuantity() != null) {
                    purchase.setApplyQty(new BigDecimal(extra.getQuantity()));
                }

                purchase.setStatus("0"); // 生成后默认状态为：待处理
                purchase.setApplicantId(org.dromara.common.satoken.utils.LoginHelper.getUserId());

                purchaseMapper.insert(purchase);
            }
        }
    }

    /**
     * 自动生成排产任务及工序节点格子
     */
    private void generateScheduleTasks(Long workOrderId) {
        // 1. 查询工单主表信息
        BizWorkOrder wo = baseMapper.selectById(workOrderId);
        if (wo == null) return;

        // 2. 查询该工单下的所有产品明细
        List<BizWoProduct> products = woProductMapper.selectList(
            new LambdaQueryWrapper<BizWoProduct>()
                .eq(BizWoProduct::getWorkOrderId, workOrderId)
        );

        if (products == null || products.isEmpty()) return;

        // 👉 新增：为生成的单产品流转单做后缀计数
        int index = 1;

        // 3. 为每个产品生成一行排产记录
        for (BizWoProduct product : products) {
            BizProductionSchedule schedule = new BizProductionSchedule();
            schedule.setWorkOrderId(workOrderId);
            schedule.setWorkOrderNo(wo.getWorkOrderNo());

            // 👉 在排产表存入产品的名称，如果你的排产表有 subOrderNo 字段，请把它存进去
            schedule.setItemName(product.getProductName());

            // 获取数量（优先用生产数量，没有则用订单数量）
            Integer qty = Math.toIntExact(product.getProduceQuantity() != null && product.getProduceQuantity() > 0
                ? product.getProduceQuantity() : product.getOrderQuantity());
            schedule.setQuantity(qty != null ? qty.longValue() : 0L);
            schedule.setDeliveryDate(wo.getDeliveryDate()); // 交期

            // 插入排产主表，MyBatis-Plus 会自动将生成的 ID 赋给 schedule 对象
            scheduleMapper.insert(schedule);
            Long scheduleId = schedule.getId();

            // 4. 定义 Excel 里的标准 10 大工序列 (Code 与 名称)
            String[][] standardNodes = {
                {"purchase", "采购辅料"},
                {"face_paper", "面纸"},
                {"pit_paper", "坑纸"},
                {"print", "印刷"},
                {"surface", "表面处理"},
                {"die_board", "刀模"},
                {"die_cut", "啤"},
                {"mounting", "裱坑"},
                {"gluing", "粘盒"},
                {"packing", "打包"}
            };

            // 5. 为这行排产记录，生成 10 个默认状态的格子
            for (String[] nodeInfo : standardNodes) {
                BizScheduleNode node = new BizScheduleNode();
                node.setScheduleId(scheduleId);
                node.setNodeCode(nodeInfo[0]);
                node.setNodeName(nodeInfo[1]);
                // 默认状态红色(未开始)，内容为空
                node.setStatusColor("red");
                node.setContent("");

                scheduleNodeMapper.insert(node);
            }
        }
    }

    /**
     * 根据工单材料清单，自动扣减“本厂”来源的原材料库存
     */
    private void deductInHouseMaterials(Long workOrderId) {
        // 1. 精准查询该工单下，来源类型为“本厂”的所有材料
        List<BizWoMaterial> materials = materialMapper.selectList(
            new LambdaQueryWrapper<BizWoMaterial>()
                .eq(BizWoMaterial::getWorkOrderId, workOrderId)
                .eq(BizWoMaterial::getSourceType, "本厂")
        );

        if (materials == null || materials.isEmpty()) return;

        // 2. 遍历本厂材料，去库存表里找并扣减
        for (BizWoMaterial material : materials) {
            if (material.getRequireQty() == null || material.getRequireQty() <= 0) {
                continue; // 数量为0的跳过
            }

            // 在库存表中寻找该名称的材料 (这里以物料名称为准进行匹配)
            org.dromara.system.domain.BizInventory inv = inventoryMapper.selectOne(
                new LambdaQueryWrapper<org.dromara.system.domain.BizInventory>()
                    .eq(org.dromara.system.domain.BizInventory::getItemName, material.getPaperName())
                    .last("limit 1")
            );

            // 校验1：仓库里根本没有这种材料
            if (inv == null) {
                throw new ServiceException("审批失败：仓库中不存在名为【" + material.getPaperName() + "】的本厂材料，请先去库存管理录入！");
            }

            // 校验2：库存数量不足
            java.math.BigDecimal reqQty = new java.math.BigDecimal(material.getRequireQty());
            if (inv.getCurrentQty().compareTo(reqQty) < 0) {
                throw new ServiceException("审批失败：本厂材料【" + material.getPaperName() + "】库存不足！当前库存剩余：" + inv.getCurrentQty() + "，工单需要：" + reqQty);
            }

            // 3. 校验通过，执行扣减
            java.math.BigDecimal newQty = inv.getCurrentQty().subtract(reqQty);
            inv.setCurrentQty(newQty);

            // 同步更新剩余库存的总金额
            if (inv.getPurchasePrice() != null) {
                inv.setTotalAmount(newQty.multiply(inv.getPurchasePrice()));
            }

            // 更新数据库
            inventoryMapper.updateById(inv);
        }
    }
}
