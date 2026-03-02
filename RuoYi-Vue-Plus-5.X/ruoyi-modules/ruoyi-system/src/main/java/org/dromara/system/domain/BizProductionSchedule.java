package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 生产排产主对象 biz_production_schedule
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_production_schedule")
public class BizProductionSchedule extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 排产主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 工单编号
     */
    private String workOrderNo;

    /**
     * 生产部件/产品名称
     */
    private String itemName;

    /**
     * 生产数量
     */
    private Long quantity;

    /**
     * 交货日期
     */
    private Date deliveryDate;

    /**
     * 跟单备注(最右侧列)
     */
    private String remark;

    /**
     * 删除标志
     */
    @TableLogic
    private String delFlag;


}
