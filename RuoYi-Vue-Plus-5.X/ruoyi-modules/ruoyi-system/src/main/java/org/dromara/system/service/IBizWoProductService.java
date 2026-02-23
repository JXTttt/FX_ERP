package org.dromara.system.service;

import org.dromara.system.domain.vo.BizWoProductVo;
import org.dromara.system.domain.bo.BizWoProductBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 工单产品明细子Service接口
 *
 * @author JXTttt
 * @date 2026-02-14
 */
public interface IBizWoProductService {

    /**
     * 查询工单产品明细子
     *
     * @param id 主键
     * @return 工单产品明细子
     */
    BizWoProductVo queryById(Long id);

    /**
     * 分页查询工单产品明细子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单产品明细子分页列表
     */
    TableDataInfo<BizWoProductVo> queryPageList(BizWoProductBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的工单产品明细子列表
     *
     * @param bo 查询条件
     * @return 工单产品明细子列表
     */
    List<BizWoProductVo> queryList(BizWoProductBo bo);

    /**
     * 新增工单产品明细子
     *
     * @param bo 工单产品明细子
     * @return 是否新增成功
     */
    Boolean insertByBo(BizWoProductBo bo);

    /**
     * 修改工单产品明细子
     *
     * @param bo 工单产品明细子
     * @return 是否修改成功
     */
    Boolean updateByBo(BizWoProductBo bo);

    /**
     * 校验并批量删除工单产品明细子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
