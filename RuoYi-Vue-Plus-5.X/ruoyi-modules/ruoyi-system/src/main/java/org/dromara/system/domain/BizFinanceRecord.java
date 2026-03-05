package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

import java.io.Serial;

/**
 * 财务收支流水对象 biz_finance_record
 *
 * @author JXTttt
 * @date 2026-03-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_finance_record")
public class BizFinanceRecord extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 财务流水号(如 FIN2026...)
     */
    private String recordNo;

    /**
     * 资金流向: 1-应收/收入, 2-应付/支出
     */
    private String recordType;

    /**
     * 业务类型: 销售出货, 采购入库, 委外加工, 临时工费
     */
    private String businessType;

    /**
     * 关联单号(出货单号/采购单号/工单号)
     */
    private String relatedNo;

    /**
     * 收付款对象(客户名/供应商名/临时工姓名)
     */
    private String targetName;

    /**
     * 发生金额
     */
    private BigDecimal amount;

    /**
     * 结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清
     */
    private String settlementStatus;

    /**
     * 备注
     */
    private String remark;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;


}
