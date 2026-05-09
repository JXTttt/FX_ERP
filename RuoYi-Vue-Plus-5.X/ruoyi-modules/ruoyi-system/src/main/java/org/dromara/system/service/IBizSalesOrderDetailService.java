package org.dromara.system.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderDetailVo;

import java.util.Collection;
import java.util.List;

/**
 * 销售订单明细 Service 接口
 */
public interface IBizSalesOrderDetailService {

    /**
     * 查询销售订单明细
     */
    BizSalesOrderDetailVo queryById(Long id);

    /**
     * 分页查询销售订单明细列表
     */
    TableDataInfo<BizSalesOrderDetailVo> queryPageList(BizSalesOrderDetailBo bo, PageQuery pageQuery);

    /**
     * 查询销售订单明细列表
     */
    List<BizSalesOrderDetailVo> queryList(BizSalesOrderDetailBo bo);

    /**
     * 新增销售订单明细
     */
    Boolean insertByBo(BizSalesOrderDetailBo bo);

    /**
     * 修改销售订单明细
     */
    Boolean updateByBo(BizSalesOrderDetailBo bo);

    /**
     * 校验并批量删除销售订单明细信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
