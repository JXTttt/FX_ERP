package org.dromara.system.service;

import org.dromara.system.domain.vo.BizWoProcessVo;
import org.dromara.system.domain.bo.BizWoProcessBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 工单生产工艺子Service接口
 *
 * @author JXTttt
 * @date 2026-02-14
 */
public interface IBizWoProcessService {

    /**
     * 查询工单生产工艺子
     *
     * @param id 主键
     * @return 工单生产工艺子
     */
    BizWoProcessVo queryById(Long id);

    /**
     * 分页查询工单生产工艺子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单生产工艺子分页列表
     */
    TableDataInfo<BizWoProcessVo> queryPageList(BizWoProcessBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的工单生产工艺子列表
     *
     * @param bo 查询条件
     * @return 工单生产工艺子列表
     */
    List<BizWoProcessVo> queryList(BizWoProcessBo bo);

    /**
     * 新增工单生产工艺子
     *
     * @param bo 工单生产工艺子
     * @return 是否新增成功
     */
    Boolean insertByBo(BizWoProcessBo bo);

    /**
     * 修改工单生产工艺子
     *
     * @param bo 工单生产工艺子
     * @return 是否修改成功
     */
    Boolean updateByBo(BizWoProcessBo bo);

    /**
     * 校验并批量删除工单生产工艺子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
