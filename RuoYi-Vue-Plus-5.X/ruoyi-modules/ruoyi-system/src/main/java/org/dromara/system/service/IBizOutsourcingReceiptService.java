package org.dromara.system.service;

import org.dromara.system.domain.vo.BizOutsourcingReceiptVo;
import org.dromara.system.domain.bo.BizOutsourcingReceiptBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 委外收货与结算Service接口
 *
 * @author JXTttt
 * @date 2026-03-03
 */
public interface IBizOutsourcingReceiptService {

    /**
     * 查询委外收货与结算
     *
     * @param id 主键
     * @return 委外收货与结算
     */
    BizOutsourcingReceiptVo queryById(Long id);

    /**
     * 分页查询委外收货与结算列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 委外收货与结算分页列表
     */
    TableDataInfo<BizOutsourcingReceiptVo> queryPageList(BizOutsourcingReceiptBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的委外收货与结算列表
     *
     * @param bo 查询条件
     * @return 委外收货与结算列表
     */
    List<BizOutsourcingReceiptVo> queryList(BizOutsourcingReceiptBo bo);

    /**
     * 新增委外收货与结算
     *
     * @param bo 委外收货与结算
     * @return 是否新增成功
     */
    Boolean insertByBo(BizOutsourcingReceiptBo bo);

    /**
     * 修改委外收货与结算
     *
     * @param bo 委外收货与结算
     * @return 是否修改成功
     */
    Boolean updateByBo(BizOutsourcingReceiptBo bo);

    /**
     * 校验并批量删除委外收货与结算信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
