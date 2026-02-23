package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单其他订购子对象 biz_wo_extra_purchase
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_extra_purchase")
public class BizWoExtraPurchase extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联工单ID
     */
    private Long workOrderId;

    /**
     * 采购内容
     */
    private String itemContent;

    /**
     * 规格
     */
    private String spec;

    /**
     * 数量
     */
    private Long quantity;

    /**
     * 单价
     */
    private Long unitPrice;

    /**
     * 总价
     */
    private Long totalPrice;

    /**
     * 备注
     */
    private String remark;


}
