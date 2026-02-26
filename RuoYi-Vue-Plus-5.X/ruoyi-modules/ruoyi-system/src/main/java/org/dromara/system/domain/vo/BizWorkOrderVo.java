package org.dromara.system.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.dromara.system.domain.BizWorkOrder;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * 工单管理视图对象 biz_work_order
 *
 * @author JXTttt
 * @date 2026-02-13
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = BizWorkOrder.class)
public class BizWorkOrderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 工单编号(例:2602030037)
     */
    @ExcelProperty(value = "工单编号(例:2602030037)")
    private String workOrderNo;

    /**
     * 客户名称快照
     */
    @ExcelProperty(value = "客户名称快照")
    private String customerName;

    /**
     * 客户ID (极其重要，前端回显下拉框全靠它)
     */
    private Long customerId;

    /**
     * 客户PO号
     */
//    @ExcelProperty(value = "客户PO号")
//    private String customerPo;
//
//    /**
//     * 客户物料号
//     */
//    @ExcelProperty(value = "客户物料号")
//    private String customerMaterialNo;

    /**
     * 产品名称
     */
    @ExcelProperty(value = "产品名称")
    private String productName;
//
//    /**
//     * 产品编码(拼音+日期)
//     */
//    @ExcelProperty(value = "产品编码(拼音+日期)")
//    private String productCode;
//
//    /**
//     * 订单数量
//     */
//    @ExcelProperty(value = "订单数量")
//    private Long orderQuantity;
//
//    /**
//     * 生产数量
//     */
//    @ExcelProperty(value = "生产数量")
//    private Long produceQuantity;
//
//    /**
//     * 单位
//     */
//    @ExcelProperty(value = "单位")
//    private String unit;
//
//    /**
//     * 单价
//     */
//    @ExcelProperty(value = "单价")
//    private BigDecimal unitPrice;
//
//    /**
//     * 总金额
//     */
//    @ExcelProperty(value = "总金额")
//    private BigDecimal totalAmount;
//
//    /**
//     * 规格
//     */
//    @ExcelProperty(value = "规格")
//    private String spec;
//
//    /**
//     * 层数(单E, BB等)
//     */
//    @ExcelProperty(value = "层数(单E, BB等)")
//    private String layers;
//
//    /**
//     * 刀版号
//     */
//    @ExcelProperty(value = "刀版号")
//    private String knifePlateNo;
//
//    /**
//     * 结构类型
//     */
//    @ExcelProperty(value = "结构类型")
//    private String structureType;

    /**
     * 开单日期
     */
    @ExcelProperty(value = "开单日期")
    private Date orderDate;

    /**
     * 交货日期
     */
    @ExcelProperty(value = "交货日期")
    private Date deliveryDate;

    /**
     * 业务员ID
     */
    @ExcelProperty(value = "业务员ID")
    private Long salesManId;

    /**
     * 开单人ID
     */
    @ExcelProperty(value = "开单人ID")
    private Long operatorId;

    /**
     * 生产进度: 完成,未完成,已排产,异常
     */
    @ExcelProperty(value = "生产进度: 完成,未完成,已排产,异常", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "wf_task_status")
    private String productionStatus;

    /**
     * 审核状态
     */
    @ExcelProperty(value = "审核状态")
    private String auditStatus;

    /**
     * 签名
     */
    @ExcelProperty(value = "签名")
    private String auditBy;

    /**
     * 包装要求
     */
    @ExcelProperty(value = "包装要求")
    private String packRequirement;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

    /**
     * 材料子表列表
     */
    private List<BizWoMaterialVo> materialList;

    /**
     * CTP子表列表
     */
    private List<BizWoCtpVo> ctpList;

    /**
     * 印刷子表列表
     */
    private List<BizWoPrintVo> printList;

    /**
     * 后续加工子表列表
     */
    private List<BizWoPostProcessVo> postProcessList;

    /**
     * 其他订购子表列表
     */
    private List<BizWoExtraPurchaseVo> extraPurchaseList;

    /**
     * 产品明细子表列表
     */
    private List<BizWoProductVo> productList;

    /**
     * 生产工艺子表列表
     */
    private List<BizWoProcessVo> processList;

    /**
     * 委外加工子表列表
     */
    private List<BizWoOutsourcingVo> outsourcingList;

}
