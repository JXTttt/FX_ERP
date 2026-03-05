package org.dromara.system.service;

import org.dromara.system.domain.vo.BizFinanceRecordVo;
import org.dromara.system.domain.bo.BizFinanceRecordBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 财务收支流水Service接口
 *
 * @author JXTttt
 * @date 2026-03-03
 */
public interface IBizFinanceRecordService {

    /**
     * 查询财务收支流水
     *
     * @param id 主键
     * @return 财务收支流水
     */
    BizFinanceRecordVo queryById(Long id);

    /**
     * 分页查询财务收支流水列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 财务收支流水分页列表
     */
    TableDataInfo<BizFinanceRecordVo> queryPageList(BizFinanceRecordBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的财务收支流水列表
     *
     * @param bo 查询条件
     * @return 财务收支流水列表
     */
    List<BizFinanceRecordVo> queryList(BizFinanceRecordBo bo);

    /**
     * 新增财务收支流水
     *
     * @param bo 财务收支流水
     * @return 是否新增成功
     */
    Boolean insertByBo(BizFinanceRecordBo bo);

    /**
     * 修改财务收支流水
     *
     * @param bo 财务收支流水
     * @return 是否修改成功
     */
    Boolean updateByBo(BizFinanceRecordBo bo);

    /**
     * 校验并批量删除财务收支流水信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
