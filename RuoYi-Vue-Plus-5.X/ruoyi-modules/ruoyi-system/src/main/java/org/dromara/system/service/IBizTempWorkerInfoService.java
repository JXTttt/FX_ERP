package org.dromara.system.service;

import org.dromara.system.domain.vo.BizTempWorkerInfoVo;
import org.dromara.system.domain.bo.BizTempWorkerInfoBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 临时工档案台账Service接口
 *
 * @author JXTttt
 * @date 2026-03-03
 */
public interface IBizTempWorkerInfoService {

    /**
     * 查询临时工档案台账
     *
     * @param id 主键
     * @return 临时工档案台账
     */
    BizTempWorkerInfoVo queryById(Long id);

    /**
     * 分页查询临时工档案台账列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 临时工档案台账分页列表
     */
    TableDataInfo<BizTempWorkerInfoVo> queryPageList(BizTempWorkerInfoBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的临时工档案台账列表
     *
     * @param bo 查询条件
     * @return 临时工档案台账列表
     */
    List<BizTempWorkerInfoVo> queryList(BizTempWorkerInfoBo bo);

    /**
     * 新增临时工档案台账
     *
     * @param bo 临时工档案台账
     * @return 是否新增成功
     */
    Boolean insertByBo(BizTempWorkerInfoBo bo);

    /**
     * 修改临时工档案台账
     *
     * @param bo 临时工档案台账
     * @return 是否修改成功
     */
    Boolean updateByBo(BizTempWorkerInfoBo bo);

    /**
     * 校验并批量删除临时工档案台账信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
