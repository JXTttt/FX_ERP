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
import org.dromara.system.domain.bo.BizWoExtraPurchaseBo;
import org.dromara.system.domain.vo.BizWoExtraPurchaseVo;
import org.dromara.system.domain.BizWoExtraPurchase;
import org.dromara.system.mapper.BizWoExtraPurchaseMapper;
import org.dromara.system.service.IBizWoExtraPurchaseService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单其他订购子Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoExtraPurchaseServiceImpl implements IBizWoExtraPurchaseService {

    private final BizWoExtraPurchaseMapper baseMapper;

    /**
     * 查询工单其他订购子
     *
     * @param id 主键
     * @return 工单其他订购子
     */
    @Override
    public BizWoExtraPurchaseVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单其他订购子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单其他订购子分页列表
     */
    @Override
    public TableDataInfo<BizWoExtraPurchaseVo> queryPageList(BizWoExtraPurchaseBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoExtraPurchase> lqw = buildQueryWrapper(bo);
        Page<BizWoExtraPurchaseVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单其他订购子列表
     *
     * @param bo 查询条件
     * @return 工单其他订购子列表
     */
    @Override
    public List<BizWoExtraPurchaseVo> queryList(BizWoExtraPurchaseBo bo) {
        LambdaQueryWrapper<BizWoExtraPurchase> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoExtraPurchase> buildQueryWrapper(BizWoExtraPurchaseBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoExtraPurchase> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoExtraPurchase::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoExtraPurchase::getWorkOrderId, bo.getWorkOrderId());
        lqw.eq(StringUtils.isNotBlank(bo.getItemContent()), BizWoExtraPurchase::getItemContent, bo.getItemContent());
        lqw.eq(StringUtils.isNotBlank(bo.getSpec()), BizWoExtraPurchase::getSpec, bo.getSpec());
        lqw.eq(bo.getQuantity() != null, BizWoExtraPurchase::getQuantity, bo.getQuantity());
        lqw.eq(bo.getUnitPrice() != null, BizWoExtraPurchase::getUnitPrice, bo.getUnitPrice());
        lqw.eq(bo.getTotalPrice() != null, BizWoExtraPurchase::getTotalPrice, bo.getTotalPrice());
        return lqw;
    }

    /**
     * 新增工单其他订购子
     *
     * @param bo 工单其他订购子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoExtraPurchaseBo bo) {
        BizWoExtraPurchase add = MapstructUtils.convert(bo, BizWoExtraPurchase.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单其他订购子
     *
     * @param bo 工单其他订购子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoExtraPurchaseBo bo) {
        BizWoExtraPurchase update = MapstructUtils.convert(bo, BizWoExtraPurchase.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoExtraPurchase entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单其他订购子信息
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
