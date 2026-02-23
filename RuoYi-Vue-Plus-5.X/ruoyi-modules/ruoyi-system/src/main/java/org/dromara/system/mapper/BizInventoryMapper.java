package org.dromara.system.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.dromara.system.domain.BizInventory;
import org.dromara.system.domain.vo.BizInventoryVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

/**
 * 库存管理Mapper接口
 *
 * @author JXTttt
 * @date 2026-02-08
 */
@Mapper
public interface BizInventoryMapper extends BaseMapperPlus<BizInventory, BizInventoryVo> {

}
