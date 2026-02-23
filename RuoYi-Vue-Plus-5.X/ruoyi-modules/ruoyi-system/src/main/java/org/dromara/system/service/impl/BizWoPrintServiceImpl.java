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
import org.dromara.system.domain.bo.BizWoPrintBo;
import org.dromara.system.domain.vo.BizWoPrintVo;
import org.dromara.system.domain.BizWoPrint;
import org.dromara.system.mapper.BizWoPrintMapper;
import org.dromara.system.service.IBizWoPrintService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 工单印刷子Service业务层处理
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizWoPrintServiceImpl implements IBizWoPrintService {

    private final BizWoPrintMapper baseMapper;

    /**
     * 查询工单印刷子
     *
     * @param id 主键
     * @return 工单印刷子
     */
    @Override
    public BizWoPrintVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询工单印刷子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单印刷子分页列表
     */
    @Override
    public TableDataInfo<BizWoPrintVo> queryPageList(BizWoPrintBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizWoPrint> lqw = buildQueryWrapper(bo);
        Page<BizWoPrintVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的工单印刷子列表
     *
     * @param bo 查询条件
     * @return 工单印刷子列表
     */
    @Override
    public List<BizWoPrintVo> queryList(BizWoPrintBo bo) {
        LambdaQueryWrapper<BizWoPrint> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizWoPrint> buildQueryWrapper(BizWoPrintBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizWoPrint> lqw = Wrappers.lambdaQuery();
        lqw.orderByAsc(BizWoPrint::getId);
        lqw.eq(bo.getWorkOrderId() != null, BizWoPrint::getWorkOrderId, bo.getWorkOrderId());
        lqw.eq(StringUtils.isNotBlank(bo.getMachineNo()), BizWoPrint::getMachineNo, bo.getMachineNo());
        lqw.eq(StringUtils.isNotBlank(bo.getPrintMethod()), BizWoPrint::getPrintMethod, bo.getPrintMethod());
        lqw.eq(StringUtils.isNotBlank(bo.getMoldNum()), BizWoPrint::getMoldNum, bo.getMoldNum());
        lqw.eq(bo.getActualPrintQty() != null, BizWoPrint::getActualPrintQty, bo.getActualPrintQty());
        return lqw;
    }

    /**
     * 新增工单印刷子
     *
     * @param bo 工单印刷子
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizWoPrintBo bo) {
        BizWoPrint add = MapstructUtils.convert(bo, BizWoPrint.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改工单印刷子
     *
     * @param bo 工单印刷子
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizWoPrintBo bo) {
        BizWoPrint update = MapstructUtils.convert(bo, BizWoPrint.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizWoPrint entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除工单印刷子信息
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
