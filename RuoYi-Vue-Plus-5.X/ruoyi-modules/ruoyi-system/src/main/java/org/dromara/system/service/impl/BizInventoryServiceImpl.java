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
import org.dromara.system.domain.bo.BizInventoryBo;
import org.dromara.system.domain.vo.BizInventoryVo;
import org.dromara.system.domain.BizInventory;
import org.dromara.system.mapper.BizInventoryMapper;
import org.dromara.system.service.IBizInventoryService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 库存管理Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizInventoryServiceImpl implements IBizInventoryService {

    private final BizInventoryMapper baseMapper;

    /**
     * 查询库存管理
     *
     * @param id 主键
     * @return 库存管理
     */
    @Override
    public BizInventoryVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询库存管理列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 库存管理分页列表
     */
    @Override
    public TableDataInfo<BizInventoryVo> queryPageList(BizInventoryBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizInventory> lqw = buildQueryWrapper(bo);
        Page<BizInventoryVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的库存管理列表
     *
     * @param bo 查询条件
     * @return 库存管理列表
     */
    @Override
    public List<BizInventoryVo> queryList(BizInventoryBo bo) {
        LambdaQueryWrapper<BizInventory> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizInventory> buildQueryWrapper(BizInventoryBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizInventory> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getId() != null, BizInventory::getId, bo.getId());
        lqw.orderByAsc(BizInventory::getId);
        lqw.eq(StringUtils.isNotBlank(bo.getUniqueCode()), BizInventory::getUniqueCode, bo.getUniqueCode());
        lqw.eq(StringUtils.isNotBlank(bo.getItemType()), BizInventory::getItemType, bo.getItemType());
        lqw.like(StringUtils.isNotBlank(bo.getItemName()), BizInventory::getItemName, bo.getItemName());
        lqw.eq(StringUtils.isNotBlank(bo.getSpec()), BizInventory::getSpec, bo.getSpec());
        lqw.eq(bo.getCurrentQty() != null, BizInventory::getCurrentQty, bo.getCurrentQty());
        lqw.eq(StringUtils.isNotBlank(bo.getUnit()), BizInventory::getUnit, bo.getUnit());
        lqw.eq(bo.getSupplierId() != null, BizInventory::getSupplierId, bo.getSupplierId());
        lqw.eq(bo.getPurchasePrice() != null, BizInventory::getPurchasePrice, bo.getPurchasePrice());
        lqw.eq(bo.getTotalAmount() != null, BizInventory::getTotalAmount, bo.getTotalAmount());
        lqw.eq(StringUtils.isNotBlank(bo.getCreateBy()), BizInventory::getCreateBy, bo.getCreateBy());
        lqw.eq(bo.getCreateTime() != null, BizInventory::getCreateTime, bo.getCreateTime());
        lqw.eq(StringUtils.isNotBlank(bo.getUpdateBy()), BizInventory::getUpdateBy, bo.getUpdateBy());
        lqw.eq(bo.getUpdateTime() != null, BizInventory::getUpdateTime, bo.getUpdateTime());
        return lqw;
    }

    /**
     * 新增库存管理
     *
     * @param bo 库存管理
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizInventoryBo bo) {
        BizInventory add = MapstructUtils.convert(bo, BizInventory.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改库存管理
     *
     * @param bo 库存管理
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizInventoryBo bo) {
        BizInventory update = MapstructUtils.convert(bo, BizInventory.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizInventory entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除库存管理信息
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
