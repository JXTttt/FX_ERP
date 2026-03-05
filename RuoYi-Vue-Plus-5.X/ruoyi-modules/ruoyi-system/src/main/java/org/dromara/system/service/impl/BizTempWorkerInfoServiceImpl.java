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
import org.dromara.system.domain.bo.BizTempWorkerInfoBo;
import org.dromara.system.domain.vo.BizTempWorkerInfoVo;
import org.dromara.system.domain.BizTempWorkerInfo;
import org.dromara.system.mapper.BizTempWorkerInfoMapper;
import org.dromara.system.service.IBizTempWorkerInfoService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 临时工档案台账Service业务层处理
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizTempWorkerInfoServiceImpl implements IBizTempWorkerInfoService {

    private final BizTempWorkerInfoMapper baseMapper;

    /**
     * 查询临时工档案台账
     *
     * @param id 主键
     * @return 临时工档案台账
     */
    @Override
    public BizTempWorkerInfoVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询临时工档案台账列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 临时工档案台账分页列表
     */
    @Override
    public TableDataInfo<BizTempWorkerInfoVo> queryPageList(BizTempWorkerInfoBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizTempWorkerInfo> lqw = buildQueryWrapper(bo);
        Page<BizTempWorkerInfoVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的临时工档案台账列表
     *
     * @param bo 查询条件
     * @return 临时工档案台账列表
     */
    @Override
    public List<BizTempWorkerInfoVo> queryList(BizTempWorkerInfoBo bo) {
        LambdaQueryWrapper<BizTempWorkerInfo> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizTempWorkerInfo> buildQueryWrapper(BizTempWorkerInfoBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizTempWorkerInfo> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizTempWorkerInfo::getId);
        lqw.like(StringUtils.isNotBlank(bo.getWorkerName()), BizTempWorkerInfo::getWorkerName, bo.getWorkerName());
        lqw.eq(StringUtils.isNotBlank(bo.getPhone()), BizTempWorkerInfo::getPhone, bo.getPhone());
        lqw.eq(StringUtils.isNotBlank(bo.getIdCard()), BizTempWorkerInfo::getIdCard, bo.getIdCard());
        lqw.eq(StringUtils.isNotBlank(bo.getSkills()), BizTempWorkerInfo::getSkills, bo.getSkills());
        lqw.eq(bo.getDefaultPrice() != null, BizTempWorkerInfo::getDefaultPrice, bo.getDefaultPrice());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), BizTempWorkerInfo::getStatus, bo.getStatus());
        return lqw;
    }

    /**
     * 新增临时工档案台账
     *
     * @param bo 临时工档案台账
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizTempWorkerInfoBo bo) {
        BizTempWorkerInfo add = MapstructUtils.convert(bo, BizTempWorkerInfo.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改临时工档案台账
     *
     * @param bo 临时工档案台账
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizTempWorkerInfoBo bo) {
        BizTempWorkerInfo update = MapstructUtils.convert(bo, BizTempWorkerInfo.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizTempWorkerInfo entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除临时工档案台账信息
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
