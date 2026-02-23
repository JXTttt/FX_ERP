package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 工单后续加工子对象 biz_wo_post_process
 *
 * @author Lion Li
 * @date 2026-02-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_wo_post_process")
public class BizWoPostProcess extends BaseEntity {

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
     * 供应商ID
     */
    private Long supplierId;

    /**
     * 成品尺寸
     */
    private String finishSize;

    /**
     * 形目内容(多选)
     */
    private String processContent;

    /**
     * 备注
     */
    private String remark;


}
