package org.dromara.system.service;

import org.dromara.system.domain.vo.BizScheduleNodeVo;
import org.dromara.system.domain.bo.BizScheduleNodeBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 排产工序节点状态Service接口
 *
 * @author JXTttt
 * @date 2026-03-02
 */
public interface IBizScheduleNodeService {

    /**
     * 查询排产工序节点状态
     *
     * @param id 主键
     * @return 排产工序节点状态
     */
    BizScheduleNodeVo queryById(Long id);

    /**
     * 分页查询排产工序节点状态列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 排产工序节点状态分页列表
     */
    TableDataInfo<BizScheduleNodeVo> queryPageList(BizScheduleNodeBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的排产工序节点状态列表
     *
     * @param bo 查询条件
     * @return 排产工序节点状态列表
     */
    List<BizScheduleNodeVo> queryList(BizScheduleNodeBo bo);

    /**
     * 新增排产工序节点状态
     *
     * @param bo 排产工序节点状态
     * @return 是否新增成功
     */
    Boolean insertByBo(BizScheduleNodeBo bo);

    /**
     * 修改排产工序节点状态
     *
     * @param bo 排产工序节点状态
     * @return 是否修改成功
     */
    Boolean updateByBo(BizScheduleNodeBo bo);

    /**
     * 校验并批量删除排产工序节点状态信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
