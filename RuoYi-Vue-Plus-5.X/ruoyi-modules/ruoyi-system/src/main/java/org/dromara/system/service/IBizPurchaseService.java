package org.dromara.system.service;

import org.dromara.system.domain.vo.BizPurchaseVo;
import org.dromara.system.domain.bo.BizPurchaseBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 采购管理Service接口
 *
 * @author JXTttt
 * @date 2026-03-02
 */
public interface IBizPurchaseService {

    /**
     * 查询采购管理
     *
     * @param id 主键
     * @return 采购管理
     */
    BizPurchaseVo queryById(Long id);

    /**
     * 分页查询采购管理列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 采购管理分页列表
     */
    TableDataInfo<BizPurchaseVo> queryPageList(BizPurchaseBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的采购管理列表
     *
     * @param bo 查询条件
     * @return 采购管理列表
     */
    List<BizPurchaseVo> queryList(BizPurchaseBo bo);

    /**
     * 新增采购管理
     *
     * @param bo 采购管理
     * @return 是否新增成功
     */
    Boolean insertByBo(BizPurchaseBo bo);

    /**
     * 修改采购管理
     *
     * @param bo 采购管理
     * @return 是否修改成功
     */
    Boolean updateByBo(BizPurchaseBo bo);

    /**
     * 校验并批量删除采购管理信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
