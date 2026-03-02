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
import org.dromara.system.domain.bo.BizScheduleNodeBo;
import org.dromara.system.domain.vo.BizScheduleNodeVo;
import org.dromara.system.domain.BizScheduleNode;
import org.dromara.system.mapper.BizScheduleNodeMapper;
import org.dromara.system.service.IBizScheduleNodeService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 排产工序节点状态Service业务层处理
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizScheduleNodeServiceImpl implements IBizScheduleNodeService {

    private final BizScheduleNodeMapper baseMapper;

    /**
     * 查询排产工序节点状态
     *
     * @param id 主键
     * @return 排产工序节点状态
     */
    @Override
    public BizScheduleNodeVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询排产工序节点状态列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 排产工序节点状态分页列表
     */
    @Override
    public TableDataInfo<BizScheduleNodeVo> queryPageList(BizScheduleNodeBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizScheduleNode> lqw = buildQueryWrapper(bo);
        Page<BizScheduleNodeVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的排产工序节点状态列表
     *
     * @param bo 查询条件
     * @return 排产工序节点状态列表
     */
    @Override
    public List<BizScheduleNodeVo> queryList(BizScheduleNodeBo bo) {
        LambdaQueryWrapper<BizScheduleNode> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizScheduleNode> buildQueryWrapper(BizScheduleNodeBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizScheduleNode> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizScheduleNode::getId);
        lqw.eq(bo.getScheduleId() != null, BizScheduleNode::getScheduleId, bo.getScheduleId());
        lqw.eq(StringUtils.isNotBlank(bo.getNodeCode()), BizScheduleNode::getNodeCode, bo.getNodeCode());
        lqw.like(StringUtils.isNotBlank(bo.getNodeName()), BizScheduleNode::getNodeName, bo.getNodeName());
        lqw.eq(StringUtils.isNotBlank(bo.getStatusColor()), BizScheduleNode::getStatusColor, bo.getStatusColor());
        lqw.eq(StringUtils.isNotBlank(bo.getContent()), BizScheduleNode::getContent, bo.getContent());
        return lqw;
    }

    /**
     * 新增排产工序节点状态
     *
     * @param bo 排产工序节点状态
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizScheduleNodeBo bo) {
        BizScheduleNode add = MapstructUtils.convert(bo, BizScheduleNode.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改排产工序节点状态
     *
     * @param bo 排产工序节点状态
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizScheduleNodeBo bo) {
        BizScheduleNode update = MapstructUtils.convert(bo, BizScheduleNode.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizScheduleNode entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除排产工序节点状态信息
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
