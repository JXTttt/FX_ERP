package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoProcess;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单生产工艺子业务对象 biz_wo_process
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoProcess.class, reverseConvertGenerate = false)
public class BizWoProcessBo extends BaseEntity {


    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 工序名称(如:表面处理,裱坑,粘盒)
     */
    @NotBlank(message = "工序名称(如:表面处理,裱坑,粘盒)不能为空", groups = { AddGroup.class, EditGroup.class })
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
