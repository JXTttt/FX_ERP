package org.dromara.system.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.domain.bo.BizSalesOrderChangeLogBo;
import org.dromara.system.domain.vo.BizSalesOrderChangeLogVo;

import java.util.List;

/**
 * 销售订单变更日志 Service 接口
 */
public interface IBizSalesOrderChangeLogService {

    /**
     * 查询日志详情
     */
    BizSalesOrderChangeLogVo queryById(Long id);

    /**
     * 分页查询订单的变更日志列表
     */
    TableDataInfo<BizSalesOrderChangeLogVo> queryPageList(BizSalesOrderChangeLogBo bo, PageQuery pageQuery);

    /**
     * 查询订单的变更日志列表
     */
    List<BizSalesOrderChangeLogVo> queryList(BizSalesOrderChangeLogBo bo);

    /**
     * 新增变更日志 (虽然内部静默生成，但保留标准接口)
     */
    Boolean insertByBo(BizSalesOrderChangeLogBo bo);
}
