package org.dromara.system.domain.bo;

import org.dromara.system.domain.BizScheduleNode;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

/**
 * 排产工序节点状态业务对象 biz_schedule_node
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = BizScheduleNode.class, reverseConvertGenerate = false)
public class BizScheduleNodeBo extends BaseEntity {


    private Long id;

    /**
     * 关联排产主表ID
     */
    /**
     * 关联排产主表ID
     */
    @NotNull(message = "关联排产主表ID不能为空", groups = { AddGroup.class })
    private Long scheduleId;

    /**
     * 工序编码
     */
    @NotBlank(message = "工序编码不能为空", groups = { AddGroup.class })
    private String nodeCode;

    /**
     * 工序名称
     */
    @NotBlank(message = "工序名称不能为空", groups = { AddGroup.class })
    private String nodeName;

    /**
     * 状态颜色(red, yellow, green, white)
     */
    private String statusColor;

    /**
     * 格子填写的具体内容(日期/文字)
     */
    private String content;


}
