package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serial;

/**
 * 临时工费用登记对象 biz_temp_worker
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_temp_worker")
public class BizTempWorker extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 临时工姓名
     */
    private String workerName;

    /**
     * 工作日期
     */
    private Date workDate;

    /**
     * 关联工单号(可为空)
     */
    private String relatedWoNo;

    /**
     * 计费方式: 1-计时, 2-计件
     */
    private String workType;

    /**
     * 数量/时长
     */
    private BigDecimal workQty;

    /**
     * 单价
     */
    private BigDecimal unitPrice;

    /**
     * 总薪资
     */
    private BigDecimal totalAmount;

    /**
     * 支付状态: 0-未付, 1-已付
     */
    private String payStatus;

    /**
     * 工作内容描述
     */
    private String remark;

    /**
     * 删除标志
     */
    @TableLogic
    private String delFlag;


}
