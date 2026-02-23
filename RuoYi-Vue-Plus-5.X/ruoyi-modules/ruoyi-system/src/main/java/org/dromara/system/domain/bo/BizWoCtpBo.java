package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoCtp;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单CTP子业务对象 biz_wo_ctp
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoCtp.class, reverseConvertGenerate = false)
public class BizWoCtpBo extends BaseEntity {

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
