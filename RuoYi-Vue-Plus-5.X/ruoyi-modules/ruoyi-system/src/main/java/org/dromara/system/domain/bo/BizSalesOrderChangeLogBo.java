package org.dromara.system.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.system.domain.BizSalesOrderChangeLog;

import java.util.Date;

/**
 * 销售订单变更日志业务对象 biz_sales_order_change_log
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizSalesOrderChangeLog.class, reverseConvertGenerate = false)
public class BizSalesOrderChangeLogBo extends BaseEntity {

    /**
     * 日志ID
     */
    private Long id;

    /**
     * 订单ID (通常作为必传查询参数)
     */
    private Long salesOrderId;

    /**
     * 订单明细ID
     */
    private Long detailId;

    /**
     * 变更字段
     */
    private String changeField;

    /**
     * 旧值
     */
    private String oldValue;

    /**
     * 新值
     */
    private String newValue;

    /**
     * 操作人账号
     */
    private String operateBy;

    /**
     * 操作人姓名
     */
    private String operateName;

    /**
     * 操作时间
     */
    private Date operateTime;
}
