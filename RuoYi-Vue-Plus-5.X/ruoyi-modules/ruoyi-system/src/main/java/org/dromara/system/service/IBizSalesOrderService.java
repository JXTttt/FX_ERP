package org.dromara.system.service;

import org.dromara.common.mybatis.core.page.PageQuery;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.system.domain.bo.BizSalesOrderBo;
import org.dromara.system.domain.bo.BizSalesOrderDetailBo;
import org.dromara.system.domain.vo.BizSalesOrderVo;
import java.util.Collection;
import java.util.List;

/**
 * 销售订单接口
 */
public interface IBizSalesOrderService {

    BizSalesOrderVo queryById(Long id);

    TableDataInfo<BizSalesOrderVo> queryPageList(BizSalesOrderBo bo, PageQuery pageQuery);

    List<BizSalesOrderVo> queryList(BizSalesOrderBo bo);

    Boolean insertByBo(BizSalesOrderBo bo);

    Boolean updateByBo(BizSalesOrderBo bo);

    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 核心业务：修改明细并静默留痕
     */
    void updateDetailWithSilencedLog(BizSalesOrderDetailBo detailBo);

    /**
     * 核心业务：确认发货并锁定
     */
    void confirmDelivery(Long orderId);
}
