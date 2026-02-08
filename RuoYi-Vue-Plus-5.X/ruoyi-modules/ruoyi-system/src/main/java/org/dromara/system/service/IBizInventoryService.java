package org.dromara.system.service;

import org.dromara.system.domain.vo.BizInventoryVo;
import org.dromara.system.domain.bo.BizInventoryBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 库存管理Service接口
 *
 * @author JXTttt
 * @date 2026-02-08
 */
public interface IBizInventoryService {

    /**
     * 查询库存管理
     *
     * @param id 主键
     * @return 库存管理
     */
    BizInventoryVo queryById(Long id);

    /**
     * 分页查询库存管理列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 库存管理分页列表
     */
    TableDataInfo<BizInventoryVo> queryPageList(BizInventoryBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的库存管理列表
     *
     * @param bo 查询条件
     * @return 库存管理列表
     */
    List<BizInventoryVo> queryList(BizInventoryBo bo);

    /**
     * 新增库存管理
     *
     * @param bo 库存管理
     * @return 是否新增成功
     */
    Boolean insertByBo(BizInventoryBo bo);

    /**
     * 修改库存管理
     *
     * @param bo 库存管理
     * @return 是否修改成功
     */
    Boolean updateByBo(BizInventoryBo bo);

    /**
     * 校验并批量删除库存管理信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
