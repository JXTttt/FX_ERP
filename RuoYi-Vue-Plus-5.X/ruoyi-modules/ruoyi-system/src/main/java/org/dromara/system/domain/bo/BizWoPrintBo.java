package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizWoPrint;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 工单印刷子业务对象 biz_wo_print
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizWoPrint.class, reverseConvertGenerate = false)
public class BizWoPrintBo extends BaseEntity {

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
     * 印刷机号
     */
    private String machineNo;

    /**
     * 印刷颜色(4C, 1C等)
     */
    private String printColor;

    /**
     * 印刷尺寸
     */
    private String printSize;

    /**
     * 印刷方式
     */
    private String printMethod;

    /**
     * 模数(3+1等)
     */
    private String moldNum;

    /**
     * 印刷实数
     */
    private Long actualPrintQty;

    /**
     * 损耗数
     */
    private Long lossQty;

    /**
     * 备注
     */
    private String remark;


}
