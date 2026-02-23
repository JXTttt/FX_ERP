package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单印刷子对象 biz_wo_print
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_print")
public class BizWoPrint extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
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
