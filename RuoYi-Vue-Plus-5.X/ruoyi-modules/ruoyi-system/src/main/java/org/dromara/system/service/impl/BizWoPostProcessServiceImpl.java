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
import org.dromara.system.domain.bo.BizWoPostProcessBo;
import org.dromara.system.domain.vo.BizWoPostProcessVo;
import org.dromara.system.domain.BizWoPostProcess;
import org.dromara.system.mapper.BizWoPostProcessMapper;
import org.dromara.system.service.IBizWoPostProcessService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单后续加工子Service业务层处理
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoPostProcessServiceImpl implements IBizWoPostProcessService {

    private final BizWoPostProcessMapper baseMapper;

    /**
     * 查询工单后续加工子
     *
     * @param id 主键
     * @return 工单后续加工子
     */
    @Override
    public BizWoPostProcessVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单后续加工子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单后续加工子分页列表
     */
    @Override
    public TableDataInfo<BizWoPostProcessVo> queryPageList(BizWoPostProcessBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoPostProcess> lqw = buildQueryWrapper(bo);
        Page<BizWoPostProcessVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单后续加工子列表
     *
     * @param bo 查询条件
     * @return 工单后续加工子列表
     */
    @Override
    public List<BizWoPostProcessVo> queryList(BizWoPostProcessBo bo) {
        LambdaQueryWrapper<BizWoPostProcess> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoPostProcess> buildQueryWrapper(BizWoPostProcessBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoPostProcess> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoPostProcess::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoPostProcess::getWorkOrderId, bo.getWorkOrderId());
        lqw.eq(bo.getSupplierId() != null, BizWoPostProcess::getSupplierId, bo.getSupplierId());
        lqw.eq(StringUtils.isNotBlank(bo.getFinishSize()), BizWoPostProcess::getFinishSize, bo.getFinishSize());
        lqw.eq(StringUtils.isNotBlank(bo.getProcessContent()), BizWoPostProcess::getProcessContent, bo.getProcessContent());
        return lqw;
    }

    /**
     * 新增工单后续加工子
     *
     * @param bo 工单后续加工子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoPostProcessBo bo) {
        BizWoPostProcess add = MapstructUtils.convert(bo, BizWoPostProcess.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单后续加工子
     *
     * @param bo 工单后续加工子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoPostProcessBo bo) {
        BizWoPostProcess update = MapstructUtils.convert(bo, BizWoPostProcess.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoPostProcess entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单后续加工子信息
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
