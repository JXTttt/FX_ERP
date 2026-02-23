package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单材料子对象 biz_wo_material
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_material")
public class BizWoMaterial extends BaseEntity {

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
     * 来源
     */
    private String sourceType;

    /**
     * 纸张名称
     */
    private String paperName;

    /**
     * 需求张数
     */
    private Long requireQty;

    /**
     * 纸张尺寸
     */
    private String paperSize;

    /**
     * 切成(如:正度对开)
     */
    private String cutMethod;

    /**
     * 切纸尺寸
     */
    private String cutSize;

    /**
     * 备注
     */
    private String remark;


}
