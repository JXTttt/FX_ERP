package org.dromara.system.service;

import org.dromara.system.domain.vo.BizCustomerVo;
import org.dromara.system.domain.bo.BizCustomerBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 客户及供应商Service接口
 *
 * @author Lion Li
 * @date 2026-02-07
 */
public interface IBizCustomerService {

    /**
     * 查询客户及供应商
     *
     * @param id 主键
     * @return 客户及供应商
     */
    BizCustomerVo queryById(Long id);

    /**
     * 分页查询客户及供应商列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 客户及供应商分页列表
     */
    TableDataInfo<BizCustomerVo> queryPageList(BizCustomerBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的客户及供应商列表
     *
     * @param bo 查询条件
     * @return 客户及供应商列表
     */
    List<BizCustomerVo> queryList(BizCustomerBo bo);

    /**
     * 新增客户及供应商
     *
     * @param bo 客户及供应商
     * @return 是否新增成功
     */
    Boolean insertByBo(BizCustomerBo bo);

    /**
     * 修改客户及供应商
     *
     * @param bo 客户及供应商
     * @return 是否修改成功
     */
    Boolean updateByBo(BizCustomerBo bo);

    /**
     * 校验并批量删除客户及供应商信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    void settleDebt(BizCustomerBo bo);
}
