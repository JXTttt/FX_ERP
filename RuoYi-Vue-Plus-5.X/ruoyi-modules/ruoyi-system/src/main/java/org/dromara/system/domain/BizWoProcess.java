package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单生产工艺子对象 biz_wo_process
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_process")
public class BizWoProcess extends BaseEntity {

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
     * 工序名称(如:表面处理,裱坑,粘盒)
     */
    private String processName;

    /**
     * 工艺内容
     */
    private String processContent;

    /**
     * 备注
     */
    private String remark;


}
