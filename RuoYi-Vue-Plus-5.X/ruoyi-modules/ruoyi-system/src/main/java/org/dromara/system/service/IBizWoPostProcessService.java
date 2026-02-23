package org.dromara.system.service;

import org.dromara.system.domain.vo.BizWoPostProcessVo;
import org.dromara.system.domain.bo.BizWoPostProcessBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 工单后续加工子Service接口
 *
 * @author Lion Li
 * @date 2026-02-13
 */
public interface IBizWoPostProcessService {

    /**
     * 查询工单后续加工子
     *
     * @param id 主键
     * @return 工单后续加工子
     */
    BizWoPostProcessVo queryById(Long id);

    /**
     * 分页查询工单后续加工子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单后续加工子分页列表
     */
    TableDataInfo<BizWoPostProcessVo> queryPageList(BizWoPostProcessBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的工单后续加工子列表
     *
     * @param bo 查询条件
     * @return 工单后续加工子列表
     */
    List<BizWoPostProcessVo> queryList(BizWoPostProcessBo bo);

    /**
     * 新增工单后续加工子
     *
     * @param bo 工单后续加工子
     * @return 是否新增成功
     */
    Boolean insertByBo(BizWoPostProcessBo bo);

    /**
     * 修改工单后续加工子
     *
     * @param bo 工单后续加工子
     * @return 是否修改成功
     */
    Boolean updateByBo(BizWoPostProcessBo bo);

    /**
     * 校验并批量删除工单后续加工子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
