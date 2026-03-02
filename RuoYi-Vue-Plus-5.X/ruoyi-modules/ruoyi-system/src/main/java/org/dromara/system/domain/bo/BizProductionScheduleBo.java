package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizProductionSchedule;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 生产排产主业务对象 biz_production_schedule
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizProductionSchedule.class, reverseConvertGenerate = false)
public class BizProductionScheduleBo extends BaseEntity {

    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 工单编号
     */
    @NotBlank(message = "工单编号不能为空", groups = { EditGroup.class })
    private String workOrderNo;

    /**
     * 生产部件/产品名称
     */
    @NotBlank(message = "生产部件/产品名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String itemName;

    /**
     * 生产数量
     */
    @NotNull(message = "生产数量不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long quantity;

    /**
     * 交货日期
     */
    private Date deliveryDate;

    /**
     * 跟单备注(最右侧列)
     */
    private String remark;


}
