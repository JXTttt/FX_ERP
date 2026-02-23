package org.dromara.system.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.dromara.system.domain.BizCustomer;
import org.dromara.system.domain.vo.BizCustomerVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

/**
 * 客户及供应商Mapper接口
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Mapper
public interface BizCustomerMapper extends BaseMapperPlus<BizCustomer, BizCustomerVo> {

}
