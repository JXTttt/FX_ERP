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
import org.dromara.system.domain.bo.BizWoProcessBo;
import org.dromara.system.domain.vo.BizWoProcessVo;
import org.dromara.system.domain.BizWoProcess;
import org.dromara.system.mapper.BizWoProcessMapper;
import org.dromara.system.service.IBizWoProcessService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单生产工艺子Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoProcessServiceImpl implements IBizWoProcessService {

    private final BizWoProcessMapper baseMapper;

    /**
     * 查询工单生产工艺子
     *
     * @param id 主键
     * @return 工单生产工艺子
     */
    @Override
    public BizWoProcessVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单生产工艺子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单生产工艺子分页列表
     */
    @Override
    public TableDataInfo<BizWoProcessVo> queryPageList(BizWoProcessBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoProcess> lqw = buildQueryWrapper(bo);
        Page<BizWoProcessVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单生产工艺子列表
     *
     * @param bo 查询条件
     * @return 工单生产工艺子列表
     */
    @Override
    public List<BizWoProcessVo> queryList(BizWoProcessBo bo) {
        LambdaQueryWrapper<BizWoProcess> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoProcess> buildQueryWrapper(BizWoProcessBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoProcess> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoProcess::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoProcess::getWorkOrderId, bo.getWorkOrderId());
        lqw.like(StringUtils.isNotBlank(bo.getProcessName()), BizWoProcess::getProcessName, bo.getProcessName());
        return lqw;
    }

    /**
     * 新增工单生产工艺子
     *
     * @param bo 工单生产工艺子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoProcessBo bo) {
        BizWoProcess add = MapstructUtils.convert(bo, BizWoProcess.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单生产工艺子
     *
     * @param bo 工单生产工艺子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoProcessBo bo) {
        BizWoProcess update = MapstructUtils.convert(bo, BizWoProcess.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoProcess entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单生产工艺子信息
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
