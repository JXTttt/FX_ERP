package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizTempWorker;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 临时工费用登记业务对象 biz_temp_worker
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizTempWorker.class, reverseConvertGenerate = false)
public class BizTempWorkerBo extends BaseEntity {

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
     * 工作日期
     */
    @NotNull(message = "工作日期不能为空", groups = { AddGroup.class, EditGroup.class })
    private Date workDate;

    /**
     * 关联工单号(可为空)
     */
    private String relatedWoNo;

    /**
     * 计费方式: 1-计时, 2-计件
     */
    @NotBlank(message = "计费方式: 1-计时, 2-计件不能为空", groups = { AddGroup.class, EditGroup.class })
    private String workType;

    /**
     * 数量/时长
     */
    @NotNull(message = "数量/时长不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal workQty;

    /**
     * 单价
     */
    @NotNull(message = "单价不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal unitPrice;

    /**
     * 总薪资
     */
    @NotNull(message = "总薪资不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal totalAmount;

    /**
     * 支付状态: 0-未付, 1-已付
     */
    private String payStatus;

    /**
     * 工作内容描述
     */
    private String remark;


}
