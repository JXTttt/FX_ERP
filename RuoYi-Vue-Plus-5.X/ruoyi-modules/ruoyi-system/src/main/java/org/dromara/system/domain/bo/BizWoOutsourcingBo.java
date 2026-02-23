package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoOutsourcing;
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
 * 工单委外加工子业务对象 biz_wo_outsourcing
 *
 * @author JXTttt
 * @date 2026-02-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoOutsourcing.class, reverseConvertGenerate = false)
public class BizWoOutsourcingBo extends BaseEntity {


    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 关联工单ID
     */
    @NotNull(message = "关联工单ID不能为空", groups = { EditGroup.class })
    private Long workOrderId;

    /**
     * 关联产品名称
     */
    private String productName;

    /**
     * 加工商/供应商ID
     */
    private Long supplierId;

    /**
     * 加工项目
     */
    private String processProject;

    /**
     * 成品尺寸
     */
    private String finishSize;

    /**
     * 加工数量
     */
    private Long processQty;

    /**
     * 计算单位
     */
    private String unit;

    /**
     * 加工单价
     */
    private Long unitPrice;

    /**
     * 加工总价
     */
    private Long totalPrice;

    /**
     * 附加费用
     */
    private Long extraFee;

    /**
     * 交货期
     */
    private Date deliveryDate;

    /**
     * 备注
     */
    private String remark;


}
