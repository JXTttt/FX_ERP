package org.dromara.system.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import org.dromara.common.core.utils.StringUtils;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.dromara.system.domain.bo.BizCustomerBo;
import org.dromara.system.domain.vo.BizCustomerVo;
import org.dromara.system.domain.BizCustomer;
import org.dromara.system.mapper.BizCustomerMapper;
import org.dromara.system.service.IBizCustomerService;

import java.util.List;
import java.util.Map;
import java.util.Collection;

/**
 * 客户及供应商Service业务层处理
 *
 * @author Lion Li
 * @date 2026-02-07
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class BizCustomerServiceImpl implements IBizCustomerService {

    private final BizCustomerMapper baseMapper;

    /**
     * 查询客户及供应商
     *
     * @param id 主键
     * @return 客户及供应商
     */
    @Override
    public BizCustomerVo queryById(Long id){
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询客户及供应商列表
     *
     * @param bo        查询条件
     * @param pageQuery 分页参数
     * @return 客户及供应商分页列表
     */
    @Override
    public TableDataInfo<BizCustomerVo> queryPageList(BizCustomerBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<BizCustomer> lqw = buildQueryWrapper(bo);
        Page<BizCustomerVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询符合条件的客户及供应商列表
     *
     * @param bo 查询条件
     * @return 客户及供应商列表
     */
    @Override
    public List<BizCustomerVo> queryList(BizCustomerBo bo) {
        LambdaQueryWrapper<BizCustomer> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<BizCustomer> buildQueryWrapper(BizCustomerBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<BizCustomer> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getId() != null, BizCustomer::getId, bo.getId());
        lqw.orderByAsc(BizCustomer::getId);
        lqw.like(StringUtils.isNotBlank(bo.getCompanyName()), BizCustomer::getCompanyName, bo.getCompanyName());
        lqw.eq(StringUtils.isNotBlank(bo.getCustomerCode()), BizCustomer::getCustomerCode, bo.getCustomerCode());
        lqw.like(StringUtils.isNotBlank(bo.getShortName()), BizCustomer::getShortName, bo.getShortName());
        lqw.like(StringUtils.isNotBlank(bo.getContactPerson()), BizCustomer::getContactPerson, bo.getContactPerson());
        lqw.like(StringUtils.isNotBlank(bo.getContactPhone()), BizCustomer::getContactPhone, bo.getContactPhone());
        lqw.eq(StringUtils.isNotBlank(bo.getCustomerType()), BizCustomer::getCustomerType, bo.getCustomerType());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyProvince()), BizCustomer::getCompanyProvince, bo.getCompanyProvince());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyCity()), BizCustomer::getCompanyCity, bo.getCompanyCity());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyDistrict()), BizCustomer::getCompanyDistrict, bo.getCompanyDistrict());
        lqw.eq(StringUtils.isNotBlank(bo.getCompanyAddress()), BizCustomer::getCompanyAddress, bo.getCompanyAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryProvince()), BizCustomer::getDeliveryProvince, bo.getDeliveryProvince());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryCity()), BizCustomer::getDeliveryCity, bo.getDeliveryCity());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryDistrict()), BizCustomer::getDeliveryDistrict, bo.getDeliveryDistrict());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryAddress()), BizCustomer::getDeliveryAddress, bo.getDeliveryAddress());
        lqw.eq(StringUtils.isNotBlank(bo.getDeliveryUnit()), BizCustomer::getDeliveryUnit, bo.getDeliveryUnit());
        lqw.eq(StringUtils.isNotBlank(bo.getBankAccountInfo()), BizCustomer::getBankAccountInfo, bo.getBankAccountInfo());
        lqw.eq(bo.getTotalDealAmount() != null, BizCustomer::getTotalDealAmount, bo.getTotalDealAmount());
        lqw.eq(bo.getTotalOweAmount() != null, BizCustomer::getTotalOweAmount, bo.getTotalOweAmount());
        lqw.eq(bo.getSalesManId() != null, BizCustomer::getSalesManId, bo.getSalesManId());
        lqw.eq(StringUtils.isNotBlank(bo.getCreateBy()), BizCustomer::getCreateBy, bo.getCreateBy());
        lqw.eq(bo.getCreateTime() != null, BizCustomer::getCreateTime, bo.getCreateTime());
        lqw.eq(StringUtils.isNotBlank(bo.getUpdateBy()), BizCustomer::getUpdateBy, bo.getUpdateBy());
        lqw.eq(bo.getUpdateTime() != null, BizCustomer::getUpdateTime, bo.getUpdateTime());
        return lqw;
    }

    /**
     * 新增客户及供应商
     *
     * @param bo 客户及供应商
     * @return 是否新增成功
     */
    @Override
    public Boolean insertByBo(BizCustomerBo bo) {
        BizCustomer add = MapstructUtils.convert(bo, BizCustomer.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setId(add.getId());
        }
        return flag;
    }

    /**
     * 修改客户及供应商
     *
     * @param bo 客户及供应商
     * @return 是否修改成功
     */
    @Override
    public Boolean updateByBo(BizCustomerBo bo) {
        BizCustomer update = MapstructUtils.convert(bo, BizCustomer.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(BizCustomer entity){
        //TODO 做一些数据校验,如唯一约束
    }

    /**
     * 校验并批量删除客户及供应商信息
     *
     * @param ids     待删除的主键集合
     * @param isValid 是否进行有效性校验
     * @return 是否删除成功
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            //TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
