package org.dromara.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.dromara.common.core.utils.DateUtils;
import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// 引入主表
import org.dromara.system.domain.BizWorkOrder;
import org.dromara.system.domain.bo.BizWorkOrderBo;
import org.dromara.system.domain.vo.BizWorkOrderVo;
import org.dromara.system.mapper.BizWorkOrderMapper;
import org.dromara.system.service.IBizWorkOrderService;

// 引入子表实体
import org.dromara.system.domain.BizWoMaterial;
import org.dromara.system.domain.BizWoCtp;
import org.dromara.system.domain.BizWoPrint;
import org.dromara.system.domain.BizWoPostProcess;
import org.dromara.system.domain.BizWoExtraPurchase;

// 引入子表Mapper
import org.dromara.system.mapper.BizWoMaterialMapper;
import org.dromara.system.mapper.BizWoCtpMapper;
import org.dromara.system.mapper.BizWoPrintMapper;
import org.dromara.system.mapper.BizWoPostProcessMapper;
import org.dromara.system.mapper.BizWoExtraPurchaseMapper;

import java.util.Collection;
import java.util.List;
import java.util.Map;

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

    // 👇 1. 注入 5 个子表的 Mapper
    private final BizWoMaterialMapper materialMapper;
    private final BizWoCtpMapper ctpMapper;
    private final BizWoPrintMapper printMapper;
    private final BizWoPostProcessMapper postProcessMapper;
    private final BizWoExtraPurchaseMapper extraPurchaseMapper;

    /**
     * 查询工单详情 (不仅查主表，还要把5个子表查出来拼进去)
     */
    @Override
    public BizWorkOrderVo queryById(Long id){
        BizWorkOrderVo vo = baseMapper.selectVoById(id);
        if (vo != null) {
            vo.setMaterialList(materialMapper.selectVoList(new LambdaQueryWrapper<BizWoMaterial>().eq(BizWoMaterial::getWorkOrderId, id)));
            vo.setCtpList(ctpMapper.selectVoList(new LambdaQueryWrapper<BizWoCtp>().eq(BizWoCtp::getWorkOrderId, id)));
            vo.setPrintList(printMapper.selectVoList(new LambdaQueryWrapper<BizWoPrint>().eq(BizWoPrint::getWorkOrderId, id)));
            vo.setPostProcessList(postProcessMapper.selectVoList(new LambdaQueryWrapper<BizWoPostProcess>().eq(BizWoPostProcess::getWorkOrderId, id)));
            vo.setExtraPurchaseList(extraPurchaseMapper.selectVoList(new LambdaQueryWrapper<BizWoExtraPurchase>().eq(BizWoExtraPurchase::getWorkOrderId, id)));
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
        // 修正了之前存在的Long类型空指针隐患
        lqw.eq(bo.getId() != null, BizWorkOrder::getId, bo.getId());
        lqw.orderByDesc(BizWorkOrder::getId); // 默认按ID倒序排列，最新的排前面
        lqw.eq(StringUtils.isNotBlank(bo.getWorkOrderNo()), BizWorkOrder::getWorkOrderNo, bo.getWorkOrderNo());
        lqw.like(StringUtils.isNotBlank(bo.getCustomerName()), BizWorkOrder::getCustomerName, bo.getCustomerName());
        lqw.like(StringUtils.isNotBlank(bo.getProductName()), BizWorkOrder::getProductName, bo.getProductName());
        lqw.eq(bo.getOrderDate() != null, BizWorkOrder::getOrderDate, bo.getOrderDate());
        lqw.eq(bo.getDeliveryDate() != null, BizWorkOrder::getDeliveryDate, bo.getDeliveryDate());
        lqw.eq(StringUtils.isNotBlank(bo.getProductionStatus()), BizWorkOrder::getProductionStatus, bo.getProductionStatus());
        return lqw;
    }

    /**
     * 新增工单
     */
    @Override
    @Transactional(rollbackFor = Exception.class) // 开启事务，保证主子表同时成功或失败
    public Boolean insertByBo(BizWorkOrderBo bo) {
        // 自动生成单号逻辑 (YYMMDD + 4位序号)
        if (StringUtils.isBlank(bo.getWorkOrderNo())) {

            String dateStr = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyMMdd"));
            Long count = baseMapper.selectCount(new LambdaQueryWrapper<BizWorkOrder>().likeRight(BizWorkOrder::getWorkOrderNo, dateStr));
            bo.setWorkOrderNo(dateStr + String.format("%04d", count == null ? 0 : count + 1));
        }

        BizWorkOrder add = MapstructUtils.convert(bo, BizWorkOrder.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;

        if (flag) {
            bo.setId(add.getId()); // 获取生成的主键
            insertChildren(bo);    // 插入子表数据
        }
        return flag;
    }

    /**
     * 修改工单
     */
    @Override
    @Transactional(rollbackFor = Exception.class) // 开启事务
    public Boolean updateByBo(BizWorkOrderBo bo) {
        BizWorkOrder update = MapstructUtils.convert(bo, BizWorkOrder.class);
        validEntityBeforeSave(update);
        boolean flag = baseMapper.updateById(update) > 0;

        if (flag) {
            // 先删后插：删除旧的子表数据，插入新的子表数据
            deleteChildren(bo.getId());
            insertChildren(bo);
        }
        return flag;
    }

    /**
     * 删除工单
     */
    @Override
    @Transactional(rollbackFor = Exception.class) // 开启事务
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验
        }
        boolean flag = baseMapper.deleteByIds(ids) > 0;
        if (flag) {
            // 主表删除成功后，一并删除关联的子表数据
            for (Long id : ids) {
                deleteChildren(id);
            }
        }
        return flag;
    }

    /**
     * 辅助方法：保存所有子表数据
     */
    private void insertChildren(BizWorkOrderBo bo) {
        Long woId = bo.getId();

        // 1. 保存材料
        if (bo.getMaterialList() != null && !bo.getMaterialList().isEmpty()) {
            List<BizWoMaterial> list = MapstructUtils.convert(bo.getMaterialList(), BizWoMaterial.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            materialMapper.insertBatch(list);
        }
        // 2. 保存 CTP
        if (bo.getCtpList() != null && !bo.getCtpList().isEmpty()) {
            List<BizWoCtp> list = MapstructUtils.convert(bo.getCtpList(), BizWoCtp.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            ctpMapper.insertBatch(list);
        }
        // 3. 保存印刷
        if (bo.getPrintList() != null && !bo.getPrintList().isEmpty()) {
            List<BizWoPrint> list = MapstructUtils.convert(bo.getPrintList(), BizWoPrint.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            printMapper.insertBatch(list);
        }
        // 4. 保存后续加工
        if (bo.getPostProcessList() != null && !bo.getPostProcessList().isEmpty()) {
            List<BizWoPostProcess> list = MapstructUtils.convert(bo.getPostProcessList(), BizWoPostProcess.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            postProcessMapper.insertBatch(list);
        }
        // 5. 保存其他订购
        if (bo.getExtraPurchaseList() != null && !bo.getExtraPurchaseList().isEmpty()) {
            List<BizWoExtraPurchase> list = MapstructUtils.convert(bo.getExtraPurchaseList(), BizWoExtraPurchase.class);
            list.forEach(i -> { i.setWorkOrderId(woId); i.setId(null); });
            extraPurchaseMapper.insertBatch(list);
        }
    }

    /**
     * 辅助方法：删除所有子表数据
     */
    private void deleteChildren(Long woId) {
        materialMapper.delete(new LambdaQueryWrapper<BizWoMaterial>().eq(BizWoMaterial::getWorkOrderId, woId));
        ctpMapper.delete(new LambdaQueryWrapper<BizWoCtp>().eq(BizWoCtp::getWorkOrderId, woId));
        printMapper.delete(new LambdaQueryWrapper<BizWoPrint>().eq(BizWoPrint::getWorkOrderId, woId));
        postProcessMapper.delete(new LambdaQueryWrapper<BizWoPostProcess>().eq(BizWoPostProcess::getWorkOrderId, woId));
        extraPurchaseMapper.delete(new LambdaQueryWrapper<BizWoExtraPurchase>().eq(BizWoExtraPurchase::getWorkOrderId, woId));
    }

    private void validEntityBeforeSave(BizWorkOrder entity){
        //TODO 做一些数据校验
    }
}
