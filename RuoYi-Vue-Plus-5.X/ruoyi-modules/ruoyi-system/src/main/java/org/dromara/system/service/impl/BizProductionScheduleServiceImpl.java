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
import org.dromara.system.domain.bo.BizProductionScheduleBo;
import org.dromara.system.domain.vo.BizProductionScheduleVo;
import org.dromara.system.domain.BizProductionSchedule;
import org.dromara.system.mapper.BizProductionScheduleMapper;
import org.dromara.system.service.IBizProductionScheduleService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 生产排产主Service业务层处理
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizProductionScheduleServiceImpl implements IBizProductionScheduleService {

    private final BizProductionScheduleMapper baseMapper;

    /**
     * 查询生产排产主
     *
     * @param id 主键
     * @return 生产排产主
     */
    @Override
    public BizProductionScheduleVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询生产排产主列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 生产排产主分页列表
     */
    @Override
    public TableDataInfo<BizProductionScheduleVo> queryPageList(BizProductionScheduleBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizProductionSchedule> lqw = buildQueryWrapper(bo);
        Page<BizProductionScheduleVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的生产排产主列表
     *
     * @param bo 查询条件
     * @return 生产排产主列表
     */
    @Override
    public List<BizProductionScheduleVo> queryList(BizProductionScheduleBo bo) {
        LambdaQueryWrapper<BizProductionSchedule> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizProductionSchedule> buildQueryWrapper(BizProductionScheduleBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizProductionSchedule> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizProductionSchedule::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizProductionSchedule::getWorkOrderId, bo.getWorkOrderId());
        lqw.eq(StringUtils.isNotBlank(bo.getWorkOrderNo()), BizProductionSchedule::getWorkOrderNo, bo.getWorkOrderNo());
        lqw.like(StringUtils.isNotBlank(bo.getItemName()), BizProductionSchedule::getItemName, bo.getItemName());
        lqw.eq(bo.getQuantity() != null, BizProductionSchedule::getQuantity, bo.getQuantity());
        lqw.eq(bo.getDeliveryDate() != null, BizProductionSchedule::getDeliveryDate, bo.getDeliveryDate());
        return lqw;
    }

    /**
     * 新增生产排产主
     *
     * @param bo 生产排产主
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizProductionScheduleBo bo) {
        BizProductionSchedule add = MapstructUtils.convert(bo, BizProductionSchedule.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改生产排产主
     *
     * @param bo 生产排产主
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizProductionScheduleBo bo) {
        BizProductionSchedule update = MapstructUtils.convert(bo, BizProductionSchedule.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizProductionSchedule entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除生产排产主信息
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
