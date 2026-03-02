package org.dromara.system.service;

import org.dromara.system.domain.vo.BizProductionScheduleVo;
import org.dromara.system.domain.bo.BizProductionScheduleBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 生产排产主Service接口
 *
 * @author JXTttt
 * @date 2026-03-02
 */
public interface IBizProductionScheduleService {

    /**
     * 查询生产排产主
     *
     * @param id 主键
     * @return 生产排产主
     */
    BizProductionScheduleVo queryById(Long id);

    /**
     * 分页查询生产排产主列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 生产排产主分页列表
     */
    TableDataInfo<BizProductionScheduleVo> queryPageList(BizProductionScheduleBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的生产排产主列表
     *
     * @param bo 查询条件
     * @return 生产排产主列表
     */
    List<BizProductionScheduleVo> queryList(BizProductionScheduleBo bo);

    /**
     * 新增生产排产主
     *
     * @param bo 生产排产主
     * @return 是否新增成功
     */
    Boolean insertByBo(BizProductionScheduleBo bo);

    /**
     * 修改生产排产主
     *
     * @param bo 生产排产主
     * @return 是否修改成功
     */
    Boolean updateByBo(BizProductionScheduleBo bo);

    /**
     * 校验并批量删除生产排产主信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
