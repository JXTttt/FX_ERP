package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizTempWorkerInfo;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 临时工档案台账业务对象 biz_temp_worker_info
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizTempWorkerInfo.class, reverseConvertGenerate = false)
public class BizTempWorkerInfoBo extends BaseEntity {

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 临时工姓名
     */
    @NotBlank(message = "临时工姓名不能为空", groups = { AddGroup.class, EditGroup.class })
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


}
