package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoMaterial;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单材料子业务对象 biz_wo_material
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoMaterial.class, reverseConvertGenerate = false)
public class BizWoMaterialBo extends BaseEntity {



    /**
     *
     */
    @NotNull(message = "不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
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
