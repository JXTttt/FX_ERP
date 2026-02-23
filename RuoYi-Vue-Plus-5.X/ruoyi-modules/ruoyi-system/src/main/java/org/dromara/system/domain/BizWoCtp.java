package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单CTP子对象 biz_wo_ctp
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_ctp")
public class BizWoCtp extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 部件
     */
    private String partName;

    /**
     * 来源(本厂CTP等)
     */
    private String sourceType;

    /**
     * 开数(1-9)
     */
    private Long openNum;

    /**
     * 印刷方式(自反, 天地反等)
     */
    private String printType;

    /**
     * 套数
     */
    private Long setNum;

    /**
     * CTP版张数
     */
    private Long plateCount;

    /**
     * 备注
     */
    private String remark;


}
