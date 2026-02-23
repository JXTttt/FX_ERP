package org.dromara.system.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizWoOutsourcingBo;
import org.dromara.system.domain.vo.BizWoOutsourcingVo;
import org.dromara.system.domain.BizWoOutsourcing;
import org.dromara.system.mapper.BizWoOutsourcingMapper;
import org.dromara.system.service.IBizWoOutsourcingService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单委外加工子Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoOutsourcingServiceImpl implements IBizWoOutsourcingService {

    private final BizWoOutsourcingMapper baseMapper;

    /**
     * 查询工单委外加工子
     *
     * @param id 主键
     * @return 工单委外加工子
     */
    @Override
    public BizWoOutsourcingVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单委外加工子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单委外加工子分页列表
     */
    @Override
    public TableDataInfo<BizWoOutsourcingVo> queryPageList(BizWoOutsourcingBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoOutsourcing> lqw = buildQueryWrapper(bo);
        Page<BizWoOutsourcingVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单委外加工子列表
     *
     * @param bo 查询条件
     * @return 工单委外加工子列表
     */
    @Override
    public List<BizWoOutsourcingVo> queryList(BizWoOutsourcingBo bo) {
        LambdaQueryWrapper<BizWoOutsourcing> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoOutsourcing> buildQueryWrapper(BizWoOutsourcingBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoOutsourcing> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoOutsourcing::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoOutsourcing::getWorkOrderId, bo.getWorkOrderId());
        lqw.like(StringUtils.isNotBlank(bo.getProductName()), BizWoOutsourcing::getProductName, bo.getProductName());
        lqw.eq(bo.getSupplierId() != null, BizWoOutsourcing::getSupplierId, bo.getSupplierId());
        lqw.eq(StringUtils.isNotBlank(bo.getProcessProject()), BizWoOutsourcing::getProcessProject, bo.getProcessProject());
        lqw.eq(StringUtils.isNotBlank(bo.getFinishSize()), BizWoOutsourcing::getFinishSize, bo.getFinishSize());
        lqw.eq(bo.getProcessQty() != null, BizWoOutsourcing::getProcessQty, bo.getProcessQty());
        lqw.eq(StringUtils.isNotBlank(bo.getUnit()), BizWoOutsourcing::getUnit, bo.getUnit());
        lqw.eq(bo.getUnitPrice() != null, BizWoOutsourcing::getUnitPrice, bo.getUnitPrice());
        lqw.eq(bo.getTotalPrice() != null, BizWoOutsourcing::getTotalPrice, bo.getTotalPrice());
        lqw.eq(bo.getExtraFee() != null, BizWoOutsourcing::getExtraFee, bo.getExtraFee());
        lqw.eq(bo.getDeliveryDate() != null, BizWoOutsourcing::getDeliveryDate, bo.getDeliveryDate());
        return lqw;
    }

    /**
     * 新增工单委外加工子
     *
     * @param bo 工单委外加工子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoOutsourcingBo bo) {
        BizWoOutsourcing add = MapstructUtils.convert(bo, BizWoOutsourcing.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单委外加工子
     *
     * @param bo 工单委外加工子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoOutsourcingBo bo) {
        BizWoOutsourcing update = MapstructUtils.convert(bo, BizWoOutsourcing.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoOutsourcing entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单委外加工子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
