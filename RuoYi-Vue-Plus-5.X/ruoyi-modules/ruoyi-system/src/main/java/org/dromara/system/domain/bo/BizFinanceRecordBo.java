package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizFinanceRecord;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 财务收支流水业务对象 biz_finance_record
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizFinanceRecord.class, reverseConvertGenerate = false)
public class BizFinanceRecordBo extends BaseEntity {

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 财务流水号(如 FIN2026...)
     */
    @NotBlank(message = "财务流水号(如 FIN2026...)不能为空", groups = { AddGroup.class, EditGroup.class })
    private String recordNo;

    /**
     * 资金流向: 1-应收/收入, 2-应付/支出
     */
    @NotBlank(message = "资金流向: 1-应收/收入, 2-应付/支出不能为空", groups = { AddGroup.class, EditGroup.class })
    private String recordType;

    /**
     * 业务类型: 销售出货, 采购入库, 委外加工, 临时工费
     */
    @NotBlank(message = "业务类型: 销售出货, 采购入库, 委外加工, 临时工费不能为空", groups = { AddGroup.class, EditGroup.class })
    private String businessType;

    /**
     * 关联单号(出货单号/采购单号/工单号)
     */
    private String relatedNo;

    /**
     * 收付款对象(客户名/供应商名/临时工姓名)
     */
    @NotBlank(message = "收付款对象(客户名/供应商名/临时工姓名)不能为空", groups = { AddGroup.class, EditGroup.class })
    private String targetName;

    /**
     * 发生金额
     */
    @NotNull(message = "发生金额不能为空", groups = { AddGroup.class, EditGroup.class })
    private BigDecimal amount;

    /**
     * 结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清
     */
    private String settlementStatus;

    /**
     * 备注
     */
    private String remark;


}
