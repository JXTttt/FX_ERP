package org.dromara.system.service;

import org.dromara.system.domain.vo.BizWoOutsourcingVo;
import org.dromara.system.domain.bo.BizWoOutsourcingBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 工单委外加工子Service接口
 *
 * @author JXTttt
 * @date 2026-02-14
 */
public interface IBizWoOutsourcingService {

    /**
     * 查询工单委外加工子
     *
     * @param id 主键
     * @return 工单委外加工子
     */
    BizWoOutsourcingVo queryById(Long id);

    /**
     * 分页查询工单委外加工子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单委外加工子分页列表
     */
    TableDataInfo<BizWoOutsourcingVo> queryPageList(BizWoOutsourcingBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的工单委外加工子列表
     *
     * @param bo 查询条件
     * @return 工单委外加工子列表
     */
    List<BizWoOutsourcingVo> queryList(BizWoOutsourcingBo bo);

    /**
     * 新增工单委外加工子
     *
     * @param bo 工单委外加工子
     * @return 是否新增成功
     */
    Boolean insertByBo(BizWoOutsourcingBo bo);

    /**
     * 修改工单委外加工子
     *
     * @param bo 工单委外加工子
     * @return 是否修改成功
     */
    Boolean updateByBo(BizWoOutsourcingBo bo);

    /**
     * 校验并批量删除工单委外加工子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
