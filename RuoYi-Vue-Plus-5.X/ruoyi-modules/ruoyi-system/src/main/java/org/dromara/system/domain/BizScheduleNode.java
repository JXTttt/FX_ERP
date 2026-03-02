package org.dromara.system.domain;

import org.dromara.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 排产工序节点状态对象 biz_schedule_node
 *
 * @author JXTttt
 * @date 2026-03-02
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("biz_schedule_node")
public class BizScheduleNode extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 节点主键ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联排产主表ID
     */
    private Long scheduleId;

    /**
     * 工序编码(如:print, gluing等)
     */
    private String nodeCode;

    /**
     * 工序名称(供参考)
     */
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
