package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

import java.io.Serial;

/**
 * 临时工档案台账对象 biz_temp_worker_info
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_temp_worker_info")
public class BizTempWorkerInfo extends BaseEntity {

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
     * 联系电话
     */
    private String phone;

    /**
     * 身份证号
     */
    private String idCard;

    /**
     * 特长/工种
     */
    private String skills;

    /**
     * 默认工价(元)
     */
    private BigDecimal defaultPrice;

    /**
     * 状态: 0-在职, 1-离职
     */
    private String status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 删除标志
     */
    @TableLogic
    private String delFlag;


}
