package org.dromara.system.service;

import org.dromara.system.domain.vo.BizWoCtpVo;
import org.dromara.system.domain.bo.BizWoCtpBo;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 工单CTP子Service接口
 *
 * @author JXTttt
 * @date 2026-02-13
 */
public interface IBizWoCtpService {

    /**
     * 查询工单CTP子
     *
     * @param id 主键
     * @return 工单CTP子
     */
    BizWoCtpVo queryById(Long id);

    /**
     * 分页查询工单CTP子列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 工单CTP子分页列表
     */
    TableDataInfo<BizWoCtpVo> queryPageList(BizWoCtpBo bo, PageQuery pageQuery);

    /**
     * 查询符合条件的工单CTP子列表
     *
     * @param bo 查询条件
     * @return 工单CTP子列表
     */
    List<BizWoCtpVo> queryList(BizWoCtpBo bo);

    /**
     * 新增工单CTP子
     *
     * @param bo 工单CTP子
     * @return 是否新增成功
     */
    Boolean insertByBo(BizWoCtpBo bo);

    /**
     * 修改工单CTP子
     *
     * @param bo 工单CTP子
     * @return 是否修改成功
     */
    Boolean updateByBo(BizWoCtpBo bo);

    /**
     * 校验并批量删除工单CTP子信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
