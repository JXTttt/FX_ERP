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
import org.dromara.common.satoken.utils.LoginHelper;
import org.dromara.system.domain.vo.BizWoOutsourcingVo;
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
import org.dromara.system.domain.vo.BizPrintWorkOrderVo;
import org.dromara.system.domain.vo.BizWoProductVo;
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

// 【新增】引入订单表
import org.dromara.system.domain.BizSalesOrder;
import org.dromara.system.domain.BizSalesOrderDetail;

import java.util.Collection;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.math.BigDecimal;
import java.util.Date;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import org.dromara.common.core.service.DictService;
import org.dromara.common.core.domain.dto.DictDataDTO;

/**
 * 工单管理Service业务层处理
 *
 * @author fx_erp
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

    // 【新增】注入销售订单相关 Mapper，用于数据桥接
    private final BizSalesOrderMapper salesOrderMapper;
    private final BizSalesOrderDetailMapper salesOrderDetailMapper;

    // 字典服务，用于打印工单分类
    private final DictService dictService;

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

    // ====================================================================
    // 【新增核心业务】：从订单明细一键提取数据初始化工程单 (职员B开单用)
    // 注意：你需要在 IBizWorkOrderService 接口中声明此方法
    // ====================================================================
    public BizWorkOrderVo initFromSalesOrder(Long salesOrderDetailId) {
        BizSalesOrderDetail detail = salesOrderDetailMapper.selectById(salesOrderDetailId);
        if (detail == null) throw new ServiceException("销售订单明细不存在");

        BizSalesOrder order = salesOrderMapper.selectById(detail.getSalesOrderId());
        if (order == null) throw new ServiceException("销售订单主表不存在");

        BizWorkOrderVo wo = new BizWorkOrderVo();
        // 绑定上下游关系
        wo.setSalesOrderId(order.getId());
        wo.setSalesOrderDetailId(detail.getId());

        // 自动填充信息
        wo.setCustomerId(order.getCustomerId());
        wo.setCustomerName(order.getCustomerName());
        wo.setProductName(detail.getProductName());
        wo.setDeliveryDate(order.getDeliveryDate());
        wo.setPackRequirement(detail.getPackReq());
        wo.setRemark(detail.getCraftReq()); // 销售写的工艺需求暂时放入备注供工程参考

        // 初始化 productList，将销售订单明细的包装需求和物流要求带入
        BizWoProductVo product = new BizWoProductVo();
        product.setProductName(detail.getProductName());
        product.setSpec(detail.getSpec());
        product.setCustomerMaterialNo(detail.getCustomerMaterialNo());
        if (detail.getQuantity() != null) {
            product.setOrderQuantity(detail.getQuantity().longValue());
            product.setProduceQuantity(detail.getQuantity().longValue());
        }
        product.setPackRequirement(detail.getPackReq());
        product.setLogisticsReq(detail.getLogisticsReq());
        wo.setProductList(java.util.Collections.singletonList(product));

        return wo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(BizWorkOrderBo bo) {
        if (org.dromara.common.core.utils.StringUtils.isBlank(bo.getWorkOrderNo())) {
            String dateStr = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyMMdd"));
            String redisKey = "erp:work_order_seq:" + dateStr;
            Long currentSeq = org.dromara.common.redis.utils.RedisUtils.incrAtomicValue(redisKey);
            if (currentSeq == 1L) {
                org.dromara.common.redis.utils.RedisUtils.expire(redisKey, java.time.Duration.ofDays(2));
            }
            bo.setWorkOrderNo(dateStr + String.format("%04d", currentSeq));
        }

        bo.setPreparedBy(LoginHelper.getUsername());
        BizWorkOrder add = org.dromara.common.core.utils.MapstructUtils.convert(bo, BizWorkOrder.class);
        validEntityBeforeSave(add);
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
        // 【修复警告】：替换为新版 API deleteByIds
        boolean flag = baseMapper.deleteByIds(ids) > 0;
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
            String prefix = "FX-" + cn.hutool.core.date.DateUtil.format(new java.util.Date(), "yyMM");
            String redisKey = "erp:knife_plate_seq:" + prefix;

            for (org.dromara.system.domain.bo.BizWoProductBo productBo : bo.getProductList()) {
                if (productBo.getId() == null || org.dromara.common.core.utils.StringUtils.isBlank(productBo.getKnifePlateNo())) {
                    Long currentSeq = org.dromara.common.redis.utils.RedisUtils.incrAtomicValue(redisKey);
                    if (currentSeq == 1L) {
                        org.dromara.common.redis.utils.RedisUtils.expire(redisKey, java.time.Duration.ofDays(35));
                    }
                    productBo.setKnifePlateNo(prefix + String.format("%04d", currentSeq));
                }
            }

            List<BizWoProduct> list = org.dromara.common.core.utils.MapstructUtils.convert(bo.getProductList(), BizWoProduct.class);
            list = list.stream().filter(i -> org.dromara.common.core.utils.StringUtils.isNotBlank(i.getProductName())).collect(java.util.stream.Collectors.toList());
            if(!list.isEmpty()) {
                list.forEach(i -> {
                    i.setWorkOrderId(woId);
                    i.setId(null);
                });
                productMapper.insertBatch(list);
            }
        }

        if (bo.getMaterialList() != null && !bo.getMaterialList().isEmpty()) {
            List<BizWoMaterial> list = org.dromara.common.core.utils.MapstructUtils.convert(bo.getMaterialList(), BizWoMaterial.class);
            list = list.stream()
                .filter(i -> org.dromara.common.core.utils.StringUtils.isNotBlank(i.getPartName()) || org.dromara.common.core.utils.StringUtils.isNotBlank(i.getPaperName()))
                .collect(java.util.stream.Collectors.toList());

            if(!list.isEmpty()) {
                list.forEach(i -> {
                    i.setWorkOrderId(woId);
                    i.setId(null);
                    if (org.dromara.common.core.utils.StringUtils.isBlank(i.getPartName())) {
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
        BizWorkOrder workOrder = baseMapper.selectById(bo.getId());
        if (workOrder == null) return false;

        workOrder.setAuditStatus(bo.getAuditStatus());
        workOrder.setAuditBy(LoginHelper.getUsername());

        boolean flag = baseMapper.updateById(workOrder) > 0;

        // 如果审核状态是“2-已通过”且更新成功
        if (flag && "2".equals(bo.getAuditStatus())) {
            generateScheduleTasks(bo.getId());
            generatePurchaseOrders(bo.getId());
            deductInHouseMaterials(bo.getId());

            // 【新增联接】：审批彻底通过后，将工程单中核算的价格回写至销售明细，并将订单推入“待客确”
            syncPriceToSalesOrder(bo.getId());
        }

        return flag;
    }

    // ====================================================================
    // 【新增核心业务】：审批通过后价格反向同步给订单
    // ====================================================================
    private void syncPriceToSalesOrder(Long workOrderId) {
        BizWorkOrder wo = baseMapper.selectById(workOrderId);
        // 如果这个工单没有关联订单数据，则跳过
        if (wo == null || wo.getSalesOrderId() == null) return;

        // 1. 获取该工程单下的主要产品用于核价回传 (如果有关联到具体的销售明细)
        if (wo.getSalesOrderDetailId() != null) {
            List<BizWoProduct> products = woProductMapper.selectList(
                new LambdaQueryWrapper<BizWoProduct>().eq(BizWoProduct::getWorkOrderId, workOrderId)
            );

            if (!products.isEmpty()) {
                BizWoProduct mainProduct = products.get(0); // 假定取第一条产品线单价为准
                BizSalesOrderDetail detail = new BizSalesOrderDetail();
                detail.setId(wo.getSalesOrderDetailId());
                detail.setUnitPrice(mainProduct.getUnitPrice());
                detail.setTotalAmount(mainProduct.getTotalAmount());

                salesOrderDetailMapper.updateById(detail);
            }
        }

        // 2. 核心修复：更新订单主表状态为 1 (待客确)
        BizSalesOrder order = salesOrderMapper.selectById(wo.getSalesOrderId());
        if (order != null && order.getStatus() == 0) { // 只有在“待排单”状态时才推进
            BizSalesOrder updateOrder = new BizSalesOrder();
            updateOrder.setId(wo.getSalesOrderId());
            updateOrder.setStatus(1); // 1 = 待客确

            // 确保更新操作成功执行
            salesOrderMapper.updateById(updateOrder);
        }
    }

    private void generatePurchaseOrders(Long workOrderId) {
        BizWorkOrder wo = baseMapper.selectById(workOrderId);
        if (wo == null) return;

        List<BizWoExtraPurchase> extraPurchases = extraPurchaseMapper.selectList(
            new LambdaQueryWrapper<BizWoExtraPurchase>()
                .eq(BizWoExtraPurchase::getWorkOrderId, workOrderId)
        );

        if (extraPurchases != null && !extraPurchases.isEmpty()) {
            for (BizWoExtraPurchase extra : extraPurchases) {
                BizPurchase purchase = new BizPurchase();
                String purchaseNo = "CG" + DateUtil.format(new Date(), "yyyyMMddHHmmss") + RandomUtil.randomNumbers(2);
                purchase.setPurchaseNo(purchaseNo);
                purchase.setRelatedWoNo(wo.getWorkOrderNo());

                purchase.setItemName(extra.getItemContent());
                purchase.setSpec(extra.getSpec());

                if (extra.getQuantity() != null) {
                    purchase.setApplyQty(new BigDecimal(extra.getQuantity().toString()));
                }

                purchase.setStatus("0");
                purchase.setApplicantId(LoginHelper.getUserId());

                purchaseMapper.insert(purchase);
            }
        }
    }

    private void generateScheduleTasks(Long workOrderId) {
        BizWorkOrder wo = baseMapper.selectById(workOrderId);
        if (wo == null) return;

        List<BizWoProduct> products = woProductMapper.selectList(
            new LambdaQueryWrapper<BizWoProduct>()
                .eq(BizWoProduct::getWorkOrderId, workOrderId)
        );

        if (products == null || products.isEmpty()) return;

        for (BizWoProduct product : products) {
            BizProductionSchedule schedule = new BizProductionSchedule();
            schedule.setWorkOrderId(workOrderId);
            schedule.setWorkOrderNo(wo.getWorkOrderNo());
            schedule.setItemName(product.getProductName());

            Integer qty = Math.toIntExact(product.getProduceQuantity() != null && product.getProduceQuantity() > 0
                ? product.getProduceQuantity() : product.getOrderQuantity());
            schedule.setQuantity(qty != null ? qty.longValue() : 0L);
            schedule.setDeliveryDate(wo.getDeliveryDate());

            scheduleMapper.insert(schedule);
            Long scheduleId = schedule.getId();

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

            for (String[] nodeInfo : standardNodes) {
                BizScheduleNode node = new BizScheduleNode();
                node.setScheduleId(scheduleId);
                node.setNodeCode(nodeInfo[0]);
                node.setNodeName(nodeInfo[1]);
                node.setStatusColor("red");
                node.setContent("");
                scheduleNodeMapper.insert(node);
            }
        }
    }

    private void deductInHouseMaterials(Long workOrderId) {
        List<BizWoMaterial> materials = materialMapper.selectList(
            new LambdaQueryWrapper<BizWoMaterial>()
                .eq(BizWoMaterial::getWorkOrderId, workOrderId)
                .eq(BizWoMaterial::getSourceType, "本厂")
        );

        if (materials == null || materials.isEmpty()) return;

        for (BizWoMaterial material : materials) {
            if (material.getRequireQty() == null || material.getRequireQty() <= 0) continue;

            org.dromara.system.domain.BizInventory inv = inventoryMapper.selectOne(
                new LambdaQueryWrapper<org.dromara.system.domain.BizInventory>()
                    .eq(org.dromara.system.domain.BizInventory::getItemName, material.getPaperName())
                    .last("limit 1")
            );

            if (inv == null) {
                throw new ServiceException("审批失败：仓库中不存在名为【" + material.getPaperName() + "】的本厂材料，请先去库存管理录入！");
            }

            java.math.BigDecimal reqQty = new java.math.BigDecimal(material.getRequireQty());
            if (inv.getCurrentQty().compareTo(reqQty) < 0) {
                throw new ServiceException("审批失败：本厂材料【" + material.getPaperName() + "】库存不足！当前剩余：" + inv.getCurrentQty() + "，工单需要：" + reqQty);
            }

            java.math.BigDecimal newQty = inv.getCurrentQty().subtract(reqQty);
            inv.setCurrentQty(newQty);

            if (inv.getPurchasePrice() != null) {
                inv.setTotalAmount(newQty.multiply(inv.getPurchasePrice()));
            }

            inventoryMapper.updateById(inv);
        }
    }

    // ====================================================================
    // 【新增】打印工单查询
    // ====================================================================
    @Override
    public BizPrintWorkOrderVo queryPrintWorkOrder(Long id) {
        BizWorkOrder wo = baseMapper.selectById(id);
        if (wo == null) {
            throw new ServiceException("工单不存在");
        }

        BizPrintWorkOrderVo vo = new BizPrintWorkOrderVo();
        vo.setCompanyName("中山市梵熙创意纸品有限公司");
        vo.setWorkOrderNo(wo.getWorkOrderNo());
        vo.setCustomerName(wo.getCustomerName());
        vo.setDeliveryDate(wo.getDeliveryDate());
        vo.setProductDesc(wo.getProductName());
        vo.setPackRequirement(wo.getPackRequirement());
        vo.setRemark(wo.getRemark());
        vo.setPreparedBy(wo.getPreparedBy());
        vo.setAuditBy(wo.getAuditBy());
        vo.setApprovedBy(wo.getDAuditor());

        // 销售订单编号
        if (wo.getSalesOrderId() != null) {
            BizSalesOrder order = salesOrderMapper.selectById(wo.getSalesOrderId());
            if (order != null) {
                vo.setOrderNo(order.getOrderNo());
            }
        }

        // 产品列表：拼接题头信息
        List<BizWoProduct> products = productMapper.selectList(
            new LambdaQueryWrapper<BizWoProduct>().eq(BizWoProduct::getWorkOrderId, id));
        if (products != null && !products.isEmpty()) {
            vo.setProductNos(products.stream()
                .map(p -> p.getCustomerMaterialNo() != null ? p.getCustomerMaterialNo() : "")
                .filter(s -> !s.isEmpty())
                .collect(Collectors.joining("，")));
            vo.setProductNames(products.stream()
                .map(p -> p.getProductName() != null ? p.getProductName() : "")
                .filter(s -> !s.isEmpty())
                .collect(Collectors.joining("，")));
            vo.setQuantities(products.stream()
                .map(p -> p.getProductName() + "：" + (p.getProduceQuantity() != null && p.getProduceQuantity() > 0 ? p.getProduceQuantity() : p.getOrderQuantity()))
                .collect(Collectors.joining("。")));
            String logistics = products.stream()
                .map(BizWoProduct::getLogisticsReq)
                .filter(s -> s != null && !s.isEmpty())
                .findFirst().orElse("");
            vo.setLogisticsReq(logistics);
        }

        // 材质
        vo.setMaterialList(materialMapper.selectVoList(
            new LambdaQueryWrapper<BizWoMaterial>().eq(BizWoMaterial::getWorkOrderId, id)));

        // 委外加工：按字典分类拆分为 印刷+表面处理 / 后续加工
        Set<String> printProcessNames = resolvePrintProcessNames();
        List<BizWoOutsourcing> allOutsourcing = outsourcingMapper.selectList(
            new LambdaQueryWrapper<BizWoOutsourcing>().eq(BizWoOutsourcing::getWorkOrderId, id));

        List<BizWoOutsourcingVo> printSurfaceList = new ArrayList<>();
        List<BizWoOutsourcingVo> postProcessList = new ArrayList<>();
        if (allOutsourcing != null) {
            for (BizWoOutsourcing item : allOutsourcing) {
                BizWoOutsourcingVo itemVo = MapstructUtils.convert(item, BizWoOutsourcingVo.class);
                if (item.getProcessProject() != null && printProcessNames.contains(item.getProcessProject())) {
                    printSurfaceList.add(itemVo);
                } else {
                    postProcessList.add(itemVo);
                }
            }
        }
        vo.setPrintSurfaceList(printSurfaceList);
        vo.setPostProcessList(postProcessList);

        // 其他配件
        vo.setExtraPurchaseList(extraPurchaseMapper.selectVoList(
            new LambdaQueryWrapper<BizWoExtraPurchase>().eq(BizWoExtraPurchase::getWorkOrderId, id)));

        return vo;
    }

    /**
     * 从字典解析出印刷类工艺项目名称集合
     * 逻辑：工艺项目(erp_process_name)的 remark 指向 加工商分类(erp_processor_category)的 value，
     *       若加工商分类的 label 含"印刷"，则该工艺项目属于印刷类
     */
    private Set<String> resolvePrintProcessNames() {
        List<DictDataDTO> categories = dictService.getDictData("erp_processor_category");
        Set<String> printCategoryValues = categories.stream()
            .filter(c -> c.getDictLabel() != null && c.getDictLabel().contains("印刷"))
            .map(DictDataDTO::getDictValue)
            .collect(Collectors.toSet());

        List<DictDataDTO> processes = dictService.getDictData("erp_process_name");
        return processes.stream()
            .filter(p -> p.getRemark() != null && printCategoryValues.contains(p.getRemark().trim()))
            .map(DictDataDTO::getDictLabel)
            .collect(Collectors.toSet());
    }
}
