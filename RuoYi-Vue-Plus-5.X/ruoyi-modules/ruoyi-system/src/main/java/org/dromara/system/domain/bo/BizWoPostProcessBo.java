package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoPostProcess;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单后续加工子业务对象 biz_wo_post_process
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoPostProcess.class, reverseConvertGenerate = false)
public class BizWoPostProcessBo extends BaseEntity {

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 供应商ID
     */
    private Long supplierId;

    /**
     * 成品尺寸
     */
    private String finishSize;

    /**
     * 形目内容(多选)
     */
    private String processContent;

    /**
     * 备注
     */
    private String remark;


}
