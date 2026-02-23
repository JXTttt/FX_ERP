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
import org.dromara.system.domain.bo.BizWoCtpBo;
import org.dromara.system.domain.vo.BizWoCtpVo;
import org.dromara.system.domain.BizWoCtp;
import org.dromara.system.mapper.BizWoCtpMapper;
import org.dromara.system.service.IBizWoCtpService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单CTP子Service业务层处理
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoCtpServiceImpl implements IBizWoCtpService {

    private final BizWoCtpMapper baseMapper;

    /**
     * 查询工单CTP子
     *
     * @param id 主键
     * @return 工单CTP子
     */
    @Override
    public BizWoCtpVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单CTP子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单CTP子分页列表
     */
    @Override
    public TableDataInfo<BizWoCtpVo> queryPageList(BizWoCtpBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoCtp> lqw = buildQueryWrapper(bo);
        Page<BizWoCtpVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单CTP子列表
     *
     * @param bo 查询条件
     * @return 工单CTP子列表
     */
    @Override
    public List<BizWoCtpVo> queryList(BizWoCtpBo bo) {
        LambdaQueryWrapper<BizWoCtp> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoCtp> buildQueryWrapper(BizWoCtpBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoCtp> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoCtp::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoCtp::getWorkOrderId, bo.getWorkOrderId());
        lqw.like(StringUtils.isNotBlank(bo.getPartName()), BizWoCtp::getPartName, bo.getPartName());
        lqw.eq(StringUtils.isNotBlank(bo.getSourceType()), BizWoCtp::getSourceType, bo.getSourceType());
        lqw.eq(bo.getOpenNum() != null, BizWoCtp::getOpenNum, bo.getOpenNum());
        lqw.eq(StringUtils.isNotBlank(bo.getPrintType()), BizWoCtp::getPrintType, bo.getPrintType());
        lqw.eq(bo.getSetNum() != null, BizWoCtp::getSetNum, bo.getSetNum());
        lqw.eq(bo.getPlateCount() != null, BizWoCtp::getPlateCount, bo.getPlateCount());
        return lqw;
    }

    /**
     * 新增工单CTP子
     *
     * @param bo 工单CTP子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoCtpBo bo) {
        BizWoCtp add = MapstructUtils.convert(bo, BizWoCtp.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单CTP子
     *
     * @param bo 工单CTP子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoCtpBo bo) {
        BizWoCtp update = MapstructUtils.convert(bo, BizWoCtp.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoCtp entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单CTP子信息
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
