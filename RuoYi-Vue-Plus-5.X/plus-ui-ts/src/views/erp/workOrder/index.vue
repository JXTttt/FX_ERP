<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="工单编号" prop="workOrderNo">
              <el-input v-model="queryParams.workOrderNo" placeholder="请输入工单编号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="客户名称" prop="customerName">
              <el-input v-model="queryParams.customerName" placeholder="请输入客户名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="包含产品" prop="productName">
              <el-input v-model="queryParams.productName" placeholder="请输入产品名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="never">
      <template #header>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:workOrder:add']">新增工单</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExportList" v-hasPermi="['erp:workOrder:export']">导出列表</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>
      <el-table v-loading="loading" border :data="workOrderList">
        <el-table-column type="index" width="55" align="center" label="序号" />
        <el-table-column label="工单编号" align="center" prop="workOrderNo" width="130" />
        <el-table-column label="客户名称" align="center" prop="customerName" width="120" :show-overflow-tooltip="true" />
        <el-table-column label="包含产品" align="center" prop="productName" min-width="120" :show-overflow-tooltip="true"/>
        <el-table-column label="审核状态" align="center" prop="auditStatus" width="100">
          <template #default="scope">
            <el-tag v-if="scope.row.auditStatus === '0'" type="info">未提交</el-tag>
            <el-tag v-else-if="scope.row.auditStatus === '1'" type="warning">待审批</el-tag>
            <el-tag v-else-if="scope.row.auditStatus === '2'" type="success">已通过</el-tag>
            <el-tag v-else-if="scope.row.auditStatus === '3'" type="danger">已驳回</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="交货日期" align="center" prop="deliveryDate" width="120">
          <template #default="scope">
            <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right" width="340">
          <template #default="scope">
            <el-button link type="success" icon="View" @click="handleView(scope.row)" v-hasPermi="['erp:workOrder:query']">查看</el-button>
            <el-button link type="warning" icon="Printer" @click="handlePrintOutsourcing(scope.row)" v-hasPermi="['erp:workOrder:query']">委外单</el-button>
            <el-button link type="primary" icon="Stamp" @click="handleAudit(scope.row)" v-if="scope.row.auditStatus === '1'" v-hasPermi="['erp:workOrder:audit']">审批</el-button>
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-if="scope.row.auditStatus !== '2'" v-hasPermi="['erp:workOrder:edit']">修改</el-button>
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-if="scope.row.auditStatus !== '2'" v-hasPermi="['erp:workOrder:remove']">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="95%" append-to-body>
      <el-form ref="workOrderFormRef" :model="form" :rules="rules" label-width="110px" :disabled="isView">
        
        <el-divider content-position="left">基础业务信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="选择客户" prop="customerId">
              <el-select v-model="form.customerId" placeholder="请选择客户(必填)" filterable style="width: 100%" @change="handleCustomerChange">
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="交货日期" prop="deliveryDate">
              <el-date-picker clearable v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择交货日期" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">产品明细</el-divider>
        <div class="mb-2" v-if="!isView">
          <el-button type="primary" plain icon="Plus" size="small" @click="addProductLine">添加产品</el-button>
        </div>
        <el-table :data="form.productList" border size="small" style="margin-bottom: 20px;">
          <el-table-column type="index" width="50" align="center" label="序号" />
          <el-table-column label="产品名称(必填)" min-width="150">
            <template #default="scope">
              <el-input v-model="scope.row.productName" placeholder="产品名称" />
            </template>
          </el-table-column>
          <el-table-column label="客户PO号" width="120">
            <template #default="scope"><el-input v-model="scope.row.customerPo" placeholder="PO号" /></template>
          </el-table-column>
          <el-table-column label="客户物料号" width="120">
            <template #default="scope"><el-input v-model="scope.row.customerMaterialNo" placeholder="物料号" /></template>
          </el-table-column>
          <el-table-column label="规格" width="120">
            <template #default="scope"><el-input v-model="scope.row.spec" placeholder="长x宽x高" /></template>
          </el-table-column>
          <el-table-column label="层数" width="100">
            <template #default="scope">
              <el-select v-model="scope.row.layers" placeholder="层数" allow-create filterable>
                <el-option label="单E" value="单E" /><el-option label="单B" value="单B" />
                <el-option label="EE" value="EE" /><el-option label="BB" value="BB" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="刀版号" width="120">
            <template #default="scope"><el-input v-model="scope.row.knifePlateNo" placeholder="刀版号" /></template>
          </el-table-column>
          <el-table-column label="订单数量" width="120">
            <template #default="scope">
              <el-input-number v-model="scope.row.orderQuantity" :min="1" style="width: 100%" @change="(val) => handleOrderQtyChange(val as number, scope.row)" />
            </template>
          </el-table-column>
          <el-table-column label="生产数量" width="120">
            <template #default="scope">
              <el-input-number v-model="scope.row.produceQuantity" :min="1" style="width: 100%" @change="calcProductTotal(scope.row)" />
            </template>
          </el-table-column>
          <el-table-column label="单位" width="80">
            <template #default="scope"><el-input v-model="scope.row.unit" placeholder="个" /></template>
          </el-table-column>
          <el-table-column label="单价" width="110">
            <template #default="scope">
              <el-input-number v-model="scope.row.unitPrice" :precision="4" :step="0.1" :min="0" :controls="false" style="width: 100%" @change="calcProductTotal(scope.row)" />
            </template>
          </el-table-column>
          <el-table-column label="总金额" width="100">
            <template #default="scope"><el-input v-model="scope.row.totalAmount" disabled /></template>
          </el-table-column>
          <el-table-column label="操作" width="70" align="center" fixed="right" v-if="!isView">
            <template #default="scope">
              <el-button link type="danger" @click="removeLine('productList', scope.$index)">移除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-tabs type="border-card">
          <el-tab-pane label="材料清单">
            <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('materialList')">添加材料</el-button></div>
            <el-table :data="form.materialList" border size="small">
              
              <el-table-column label="部件(必填)" width="140">
                <template #default="scope">
                  <el-select v-model="scope.row.partName" placeholder="纸张/配件" allow-create filterable default-first-option>
                    <el-option v-for="dict in erp_item_type" :key="dict.value" :label="dict.label" :value="dict.label" />
                  </el-select>
                </template>
              </el-table-column>

              <el-table-column label="来源" width="120">
                <template #default="scope">
                  <el-select v-model="scope.row.sourceType" placeholder="来源">
                    <el-option label="自来" value="自来" /><el-option label="订购" value="订购" /><el-option label="本厂" value="本厂" />
                  </el-select>
                </template>
              </el-table-column>
              
              <el-table-column label="物料名称(必填)" min-width="150">
                <template #default="scope">
                  <el-select
                    v-model="scope.row.paperName"
                    filterable
                    allow-create
                    default-first-option
                    placeholder="选库存"
                    style="width: 100%"
                    @change="(val) => handleMaterialChange(val as string, scope.row)"
                  >
                    <el-option-group v-for="group in inventoryOptions" :key="group.label" :label="group.label">
                      <el-option v-for="item in group.options" :key="item.id || item.itemName" :label="item.itemName" :value="item.itemName">
                        <span style="float: left">{{ item.itemName }}</span>
                        <span style="float: right; color: #8492a6; font-size: 12px">
                          库存: <span style="color:#F56C6C;font-weight:bold;">{{ item.currentQty || 0 }}</span> | {{ item.spec || '无规格' }}
                        </span>
                      </el-option>
                    </el-option-group>
                  </el-select>
                </template>
              </el-table-column>

              <el-table-column label="尺寸/规格" width="150">
                <template #default="scope">
                  <el-input 
                    v-model="scope.row.paperSize" 
                    placeholder="自动带出或手填" 
                    :disabled="scope.row.sourceType === '本厂'"
                  />
                </template>
              </el-table-column>

              <el-table-column label="数量" width="160">
                <template #default="scope">
                  <el-input-number 
                    v-model="scope.row.requireQty" 
                    :min="0" 
                    style="width: 100%" 
                    @change="(val) => checkMaterialQty(val as number, scope.row)"
                  />
                </template>
              </el-table-column>
              
              <el-table-column label="切成" width="160">
                <template #default="scope">
                  <el-input v-model="scope.row.cutMethod" />
                </template>
              </el-table-column>
              
              <el-table-column label="操作" width="70" align="center" v-if="!isView"><template #default="scope"><el-button link type="danger" @click="removeLine('materialList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>

          <el-tab-pane label="印刷加工">
            <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('printList')">添加印刷记录</el-button></div>
            <el-table :data="form.printList" border size="small">
              <el-table-column label="机号" width="120"><template #default="scope"><el-input v-model="scope.row.machineNo" /></template></el-table-column>
              <el-table-column label="颜色" width="120"><template #default="scope"><el-input v-model="scope.row.printColor" placeholder="4C/1C" /></template></el-table-column>
              <el-table-column label="模数" width="120"><template #default="scope"><el-input v-model="scope.row.moldNum" placeholder="3+1等" /></template></el-table-column>
              <el-table-column label="实印数"><template #default="scope"><el-input-number v-model="scope.row.actualPrintQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="损耗数"><template #default="scope"><el-input-number v-model="scope.row.lossQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="操作" width="70" align="center" v-if="!isView"><template #default="scope"><el-button link type="danger" @click="removeLine('printList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>

          <el-tab-pane label="生产工艺明细">
            <div class="mb-2" v-if="!isView">
              <el-button type="primary" plain icon="Plus" size="small" @click="addLine('processList')">添加工艺</el-button>
            </div>
            <el-table :data="form.processList" border size="small">
              <el-table-column label="工序名称" width="280">
                <template #default="scope">
                  <el-select
                    v-if="!isView"
                    v-model="scope.row.processName"
                    filterable allow-create default-first-option
                    placeholder="选择标准工艺或自行输入" style="width: 100%"
                  >
                    <el-option-group v-for="group in processTreeData" :key="group.value" :label="group.label">
                      <el-option v-for="item in group.children" :key="item.value" :label="item.label" :value="group.value + ' - ' + item.value" />
                    </el-option-group>
                  </el-select>
                  <span v-else>{{ scope.row.processName }}</span>
                </template>
              </el-table-column>
              <el-table-column label="工艺要求/备注" min-width="200">
                <template #default="scope"><el-input v-model="scope.row.remark" placeholder="请输入具体要求" /></template>
              </el-table-column>
              <el-table-column label="操作" width="180" align="center" v-if="!isView">
                <template #default="scope">
                  <el-button type="primary" link icon="Position" @click="handleToOutsourcing(scope.row)">一键转委外</el-button>
                  <el-button type="danger" link icon="Delete" @click="removeLine('processList', scope.$index)">移除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-tab-pane>

          <el-tab-pane label="模具制版">
            <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('ctpList')">添加CTP</el-button></div>
            <el-table :data="form.ctpList" border size="small">
              <el-table-column label="部件" width="150"><template #default="scope"><el-input v-model="scope.row.partName" /></template></el-table-column>
              <el-table-column label="开数" width="120"><template #default="scope"><el-input-number v-model="scope.row.openNum" :min="1" :max="9" style="width: 100%" /></template></el-table-column>
              <el-table-column label="印刷方式" width="150">
                <template #default="scope">
                  <el-select v-model="scope.row.printType" allow-create filterable>
                    <el-option label="单面" value="单面" />
                    <el-option label="正反" value="正反" />
                    <el-option label="自反" value="自反" />
                    <el-option label="天地反" value="天地反" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="套数" width="120"><template #default="scope"><el-input-number v-model="scope.row.setNum" :min="1" style="width: 100%"/></template></el-table-column>
              <el-table-column label="CTP版数" width="120"><template #default="scope"><el-input-number v-model="scope.row.plateCount" :min="1" style="width: 100%"/></template></el-table-column>
              <el-table-column label="操作" width="70" align="center" v-if="!isView"><template #default="scope"><el-button link type="danger" @click="removeLine('ctpList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>
          
          <el-tab-pane label="委外加工单">
            <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('outsourcingList')">手动添加外发</el-button></div>
            <el-table :data="form.outsourcingList" border size="small" style="width: 100%;" overflow-x="auto">
              <el-table-column label="产品名称" width="150" fixed="left"><template #default="scope"><el-input v-model="scope.row.productName" /></template></el-table-column>
              <el-table-column label="材料名称" width="150"><template #default="scope"><el-input v-model="scope.row.materialName" /></template></el-table-column>
              <el-table-column label="长(mm)" width="100"><template #default="scope"><el-input-number v-model="scope.row.length" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              <el-table-column label="宽(mm)" width="100"><template #default="scope"><el-input-number v-model="scope.row.width" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              <el-table-column label="材料数量" width="110"><template #default="scope"><el-input-number v-model="scope.row.materialQty" :controls="false" style="width: 100%" /></template></el-table-column>
              
              <el-table-column label="加工工序" width="200">
                <template #default="scope">
                  <el-select
                    v-if="!isView"
                    v-model="scope.row.processProject"
                    filterable allow-create default-first-option
                    placeholder="选择或输入加工工序" style="width: 100%"
                  >
                    <el-option-group v-for="group in processTreeData" :key="group.value" :label="group.label">
                      <el-option v-for="item in group.children" :key="item.value" :label="item.label" :value="group.value + ' - ' + item.value" />
                    </el-option-group>
                  </el-select>
                  <span v-else>{{ scope.row.processProject }}</span>
                </template>
              </el-table-column>
              
              <el-table-column label="加工商" width="160">
                <template #default="scope">
                  <el-select v-model="scope.row.supplierId" placeholder="智能匹配" filterable>
                    <el-option v-for="item in getFilteredSuppliers(scope.row.processProject)" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
                  </el-select>
                </template>
              </el-table-column>

              <el-table-column label="需良品数" width="110"><template #default="scope"><el-input-number v-model="scope.row.goodQty" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              <el-table-column label="算价方式" width="110">
                <template #default="scope">
                  <el-select v-model="scope.row.priceMethod" @change="calcTotalPrice(scope.row)">
                    <el-option label="平方米" value="平方米"/><el-option label="张" value="张"/><el-option label="套" value="套"/>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="加工单价" width="100"><template #default="scope"><el-input-number v-model="scope.row.unitPrice" :min="0" :precision="4" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              <el-table-column label="加工金额" width="100"><template #default="scope"><el-input-number v-model="scope.row.totalPrice" :min="0" :precision="2" :controls="false" style="width: 100%" disabled/></template></el-table-column>
              <el-table-column label="交货期" width="140"><template #default="scope"><el-date-picker v-model="scope.row.deliveryDate" type="date" value-format="YYYY-MM-DD" style="width: 100%" /></template></el-table-column>
              <el-table-column label="备注" min-width="150"><template #default="scope"><el-input v-model="scope.row.remark" /></template></el-table-column>
              <el-table-column label="操作" width="70" align="center" fixed="right" v-if="!isView"><template #default="scope"><el-button link type="danger" @click="removeLine('outsourcingList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>
        </el-tabs>

        <el-row class="mt-4">
           <el-col :span="24">
            <el-form-item label="包装要求" prop="packRequirement">
              <el-input v-model="form.packRequirement" type="textarea" :rows="2" placeholder="请输入包装要求" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="工单备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>

      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button v-if="!isView" :loading="buttonLoading" type="primary" @click="submitForm">确 定 保 存</el-button>
          <el-button @click="cancel">{{ isView ? '关 闭' : '取 消' }}</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="工单审批" v-model="auditDialog.visible" width="400px" append-to-body>
      <el-form ref="auditFormRef" :model="auditForm" label-width="80px">
        <el-form-item label="审批结果" prop="auditStatus">
          <el-radio-group v-model="auditForm.auditStatus">
            <el-radio label="2">通过</el-radio>
            <el-radio label="3">驳回</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAudit">确 定</el-button>
          <el-button @click="auditDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="委外加工单预览与下载" v-model="printDialog.visible" width="1150px" append-to-body>
      <div id="printArea" class="print-wrapper">
        <div class="print-page" v-for="(group, index) in printData.groups" :key="index">
          <div class="print-header">
            <h1>中山市梵熙创意纸品有限公司——委外加工单</h1>
          </div>
          <table class="print-table" :id="'excelTable_' + index">
            <colgroup>
              <col width="45">  <col width="200"> <col width="150"> <col width="45">  <col width="20">  <col width="45">  <col width="70">  <col width="60">  <col width="100"> <col width="80">  <col width="80">  <col width="60">  <col width="80">  <col width="80">  <col width="150"> </colgroup>
            <tbody>
              <tr class="info-row">
                <td colspan="7" class="left-align"><strong>加工商名称/联系人及电话：</strong>{{ group.supplierName }}</td>
                <td colspan="6" class="left-align"><strong>委托方联系人：</strong>谭生/18823054545  廖小姐/15015007628</td>
                <td colspan="1" class="grey-bg center-align font-bold">下单日期</td>
                <td colspan="1" class="center-align">{{ printData.orderDate }}</td>
              </tr>
              <tr class="info-row">
                <td colspan="7" class="left-align"><strong>加工商地址：</strong>{{ group.supplierAddress || '详见系统' }}</td>
                <td colspan="6" class="left-align"><strong>委托方地址：</strong>中山市小榄镇西区社区太乐路23号5栋3楼</td>
                <td colspan="1" class="grey-bg center-align font-bold">加工单号</td>
                <td colspan="1" class="center-align">{{ printData.workOrderNo }}</td>
              </tr>
              
              <tr class="list-header grey-bg center-align font-bold">
                <td>序号</td>
                <td>产品名称</td>
                <td>材料名称</td>
                <td>长</td>
                <td></td>
                <td>宽</td>
                <td>材料数量</td>
                <td>计算单位</td>
                <td>加工工序</td>
                <td>需生产<br>良品数量</td>
                <td>计算方式</td>
                <td>单价</td>
                <td>加工金额</td>
                <td>交货期</td>
                <td>备注</td>
              </tr>

              <tr class="center-align" v-for="(item, i) in group.items" :key="i">
                <td>{{ Number(i) + 1 }}</td>
                <td>{{ item.productName }}</td>
                <td>{{ item.materialName }}</td>
                <td>{{ item.length }}</td>
                <td>*</td>
                <td>{{ item.width }}</td>
                <td>{{ item.materialQty }}</td>
                <td>张</td>
                <td>{{ item.processProject }}</td>
                <td>{{ item.goodQty }}</td>
                <td>{{ item.priceMethod }}</td>
                <td>{{ item.unitPrice }}</td>
                <td>{{ item.totalPrice }}</td>
                <td>{{ item.deliveryDate }}</td>
                <td>{{ item.remark }}</td>
              </tr>

              <tr class="total-row">
                <td colspan="3" class="center-align font-bold">合计 (人民币大写)</td>
                <td colspan="7" class="center-align font-bold text-lg">{{ digitUppercase(group.totalAmount) }}</td>
                <td colspan="2" class="center-align font-bold">合计 (人民币小写)</td>
                <td colspan="1" class="center-align font-bold">{{ group.totalAmount.toFixed(2) }}</td>
                <td colspan="2"></td>
              </tr>

              <tr class="footer-row">
                <td colspan="1" class="center-align font-bold">备注</td>
                <td colspan="9" class="left-align memo-text">
                  1、税/运方式：不含税，我司自提。<br>
                  2、结算方式：月结30天。<br>
                  3、请贵单位收到订单4小时内确认并回复交期，未及时回复视为默认。
                </td>
                <td colspan="5" class="signature-box left-align font-bold text-lg" style="vertical-align: top; padding-top: 10px;">
                  加工商确认 (签名/盖章) ：
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      
      <template #footer>
        <div class="dialog-footer">
          <el-button type="warning" icon="Download" @click="exportExcel">下 载 Excel</el-button>
          <el-button type="success" icon="Printer" @click="doPrint">执 行 打 印</el-button>
          <el-button @click="printDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup name="WorkOrder" lang="ts">
import { listWorkOrder, getWorkOrder, delWorkOrder, addWorkOrder, updateWorkOrder, auditWorkOrder } from '@/api/erp/workOrder';
import { listCustomer } from '@/api/erp/customer';
import { listInventory } from '@/api/erp/inventory'; 
import { ComponentInternalInstance, computed, onMounted, reactive, ref, toRefs, watch, getCurrentInstance, nextTick } from 'vue';
import { ElForm, ElMessage } from 'element-plus';

type ElFormInstance = InstanceType<typeof ElForm>;

interface DialogOption {
  visible: boolean;
  title: string;
}

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { erp_item_type } = toRefs<any>(proxy?.useDict('erp_item_type'));

const workOrderList = ref([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const isView = ref(false);
const isDataLoading = ref(false); 

const customerOptions = ref<any[]>([]); 
const inventoryOptions = ref<any[]>([]);
const rawInventoryList = ref<any[]>([]);

const queryFormRef = ref<ElFormInstance>();
const workOrderFormRef = ref<ElFormInstance>();
const dialog = reactive<DialogOption>({ visible: false, title: '' });

const auditDialog = reactive({ visible: false });
const auditForm = ref({ id: undefined, auditStatus: '2' });

const processTreeData = [
  { 
    value: '表面处理', label: '表面处理', supplierCat: '2', 
    children: [ 
      {value: '过哑胶', label: '过哑胶'}, {value: '过光胶', label: '过光胶'}, 
      {value: '烫金', label: '烫金'}, {value: '击凸', label: '击凸'},
      {value: '压凹', label: '压凹'}, {value: '压纹', label: '压纹'},
      {value: 'UV', label: 'UV'}, {value: '覆膜', label: '覆膜'},
      {value: '局部UV', label: '局部UV'}, {value: '哑油', label: '哑油'},
      {value: '光油（普通）', label: '光油（普通）'}, {value: '高光油', label: '高光油'}
    ]
  },
  { 
    value: '模切', label: '模切(啤机)', supplierCat: '3', 
    children: [ {value: '普通模切', label: '普通模切'}, {value: '手工排废', label: '排废'} ]
  },
  { 
    value: '裱坑', label: '裱坑', supplierCat: '1', 
    children: [ {value: '对裱', label: '对裱'} ]
  },
  { 
    value: '粘盒', label: '粘盒', supplierCat: '4', 
    children: [ {value: '机粘', label: '机粘'}, {value: '手工粘', label: '手工粘'} ]
  }
];

const initFormData: any = {
  id: undefined, 
  customerId: undefined, 
  customerName: undefined,
  productName: undefined, 
  deliveryDate: undefined,
  packRequirement: undefined, 
  remark: undefined,
  productList: [],    
  materialList: [], 
  ctpList: [], 
  processList: [], 
  outsourcingList: [], 
  printList: []
};

const data = reactive<any>({
  form: { ...initFormData },
  queryParams: { pageNum: 1, pageSize: 10, workOrderNo: '', customerName: '', productName: '' },
  rules: {
    customerId: [{ required: true, message: "客户必须选择", trigger: "change" }]
  }
});
const { queryParams, form, rules } = toRefs(data);

const getCustomerList = async () => {
  const res = await listCustomer({ pageNum: 1, pageSize: 1000 } as any);
  customerOptions.value = res.rows;
};

const loadInventoryData = async () => {
  try {
    const res = await listInventory({ pageNum: 1, pageSize: 2000 } as any);
    const list = res.rows || [];
    rawInventoryList.value = list; 
    
    const groups: Record<string, any[]> = {};
    list.forEach((item: any) => {
      const dictItem = erp_item_type.value?.find((d: any) => String(d.value) === String(item.itemType) || String(d.label) === String(item.itemType));
      const typeLabel = dictItem ? dictItem.label : (item.itemType || '其他');
      
      if (!groups[typeLabel]) {
        groups[typeLabel] = [];
      }
      if (!groups[typeLabel].find(i => i.itemName === item.itemName && i.spec === item.spec)) {
        groups[typeLabel].push(item);
      }
    });

    inventoryOptions.value = Object.keys(groups).map(key => {
      return { label: key, options: groups[key] };
    });
  } catch (e) {
    console.error("加载库存数据失败", e);
  }
};

const handleMaterialChange = (val: string, row: any) => {
  if (row.sourceType === '本厂') {
    const found = rawInventoryList.value.find(i => i.itemName === val);
    if (found) {
      row.paperSize = found.spec; 
      if (row.requireQty && row.requireQty > Number(found.currentQty)) {
        ElMessage.warning(`注意：当前【${val}】库存仅剩 ${found.currentQty}！`);
      }
    }
  } else {
    const found = rawInventoryList.value.find(i => i.itemName === val);
    if (found && !row.paperSize) {
      row.paperSize = found.spec;
    }
  }
};

// 👉 终极防御：全局库存累加超限拦截与动态回退
const checkMaterialQty = (val: number, row: any) => {
  if (row.sourceType === '本厂' && row.paperName) {
    const found = rawInventoryList.value.find(i => i.itemName === row.paperName);
    if (found) {
      const maxQty = Number(found.currentQty || 0);

      // 计算整个列表中，当前选中的“本厂”材料的【累计总需求量】
      const totalRequested = form.value.materialList
        .filter((m: any) => m.sourceType === '本厂' && m.paperName === row.paperName)
        .reduce((sum: number, m: any) => sum + Number(m.requireQty || 0), 0);

      if (totalRequested > maxQty) {
        ElMessage.error(`库存不足预警！【${row.paperName}】当前总库存为 ${maxQty}，但列表中累计需求已达 ${totalRequested}！`);
        // 强制回退当前单元格的数量，确保累计和刚好等于最大库存
        const safeVal = Math.max(0, maxQty - (totalRequested - Number(val)));
        row.requireQty = safeVal;
      }
    }
  }
};

const handleCustomerChange = (val: any) => {
  const selected = customerOptions.value.find(item => String(item.id) === String(val));
  if (selected) form.value.customerName = selected.companyName;
};

const calcProductTotal = (row: any) => {
  const pq = Number(row.produceQuantity || 0);
  const up = Number(row.unitPrice || 0);
  if (pq && up) {
    row.totalAmount = Number((pq * up).toFixed(2));
  } else {
    row.totalAmount = 0.00;
  }
};

const handleOrderQtyChange = (val: number, row: any) => {
  if (val && !row.produceQuantity) {
    row.produceQuantity = val;
    calcProductTotal(row);
  }
};

const totalOrderQty = computed(() => {
  if (!form.value.productList) return 0;
  return form.value.productList.reduce((sum: number, item: any) => sum + Number(item.orderQuantity || 0), 0);
});

const totalProduceQty = computed(() => {
  if (!form.value.productList) return 0;
  return form.value.productList.reduce((sum: number, item: any) => sum + Number(item.produceQuantity || 0), 0);
});

const combinedProductNames = computed(() => {
  if (!form.value.productList) return '';
  return form.value.productList.map((p: any) => p.productName).filter(Boolean).join(',');
});

const parseSize = (sizeStr: string, type: 'L' | 'W') => {
  if (!sizeStr) return 0;
  const parts = sizeStr.toLowerCase().split(/[x*×]/);
  if (parts.length >= 2) return type === 'L' ? parseFloat(parts[0]) : parseFloat(parts[1]);
  return 0;
};

const calcTotalPrice = (row: any) => {
  const up = Number(row.unitPrice || 0);
  const gq = Number(row.goodQty || 0);
  if (!up || !gq) { row.totalPrice = 0; return; }
  
  if (row.priceMethod === '平方米' && row.length && row.width) {
    const l = Number(row.length);
    const w = Number(row.width);
    row.totalPrice = Number(((l * w / 1000000) * gq * up).toFixed(2));
  } else {
    row.totalPrice = Number((gq * up).toFixed(2));
  }
};

const getFilteredSuppliers = (processProject: string) => {
  if (!processProject) return customerOptions.value.filter(c => c.customerType === '2');
  const majorCategory = processProject.split(' - ')[0];
  const treeNode = processTreeData.find(item => item.value === majorCategory);
  if (!treeNode || !treeNode.supplierCat) return customerOptions.value.filter(c => c.customerType === '2');
  const reqCat = treeNode.supplierCat;
  return customerOptions.value.filter(c => {
    if (c.customerType !== '2' || !c.supplierCategory) return false; 
    const catArray = typeof c.supplierCategory === 'string' ? c.supplierCategory.split(',') : c.supplierCategory;
    return catArray.includes(reqCat);
  });
};

watch(() => totalOrderQty.value, (newVal) => {
  if (isDataLoading.value) return; 
  if (!newVal || Number(newVal) === 0) return;
  if (form.value.materialList.length === 0) {
    const valNum = Number(newVal);
    let extraFace = Math.floor((valNum - 1) / 66);
    let faceQty = valNum + 101 + extraFace;
    let extraPit = Math.floor((valNum - 1) / 100);
    let pitQty = valNum + 1 + extraPit;

    form.value.materialList.push({ partName: '面纸', sourceType: '自来', requireQty: faceQty });
    form.value.materialList.push({ partName: '坑纸', sourceType: '自来', requireQty: pitQty });
  }
});

const handleToOutsourcing = (processRow: any) => {
  if (!processRow.processName) {
    proxy?.$modal.msgWarning("请先选择或输入工序名称！");
    return;
  }
  const exists = form.value.outsourcingList.find((item: any) => item.processProject === processRow.processName);
  if (exists) { proxy?.$modal.msgWarning(`【${processRow.processName}】已转过委外！`); return; }

  const firstMat = form.value.materialList.length > 0 ? form.value.materialList[0] : null;
  form.value.outsourcingList.push({
    productName: combinedProductNames.value, 
    materialName: firstMat ? firstMat.paperName : '',
    length: firstMat ? parseSize(firstMat.paperSize, 'L') : 0,
    width: firstMat ? parseSize(firstMat.paperSize, 'W') : 0,
    materialQty: firstMat ? firstMat.requireQty : 0,
    processProject: processRow.processName,
    goodQty: totalProduceQty.value, 
    priceMethod: '平方米', 
    unitPrice: undefined,
    totalPrice: 0,
    remark: processRow.remark
  });
  proxy?.$modal.msgSuccess(`转委外成功！已自动匹配供应商库，请填写加工单细节。`);
};

const addProductLine = () => {
  form.value.productList.push({
    productName: '', customerPo: '', customerMaterialNo: '', spec: '', layers: '', knifePlateNo: '',
    orderQuantity: undefined, produceQuantity: undefined, unit: '个', unitPrice: undefined, totalAmount: 0.00
  });
};
const addLine = (listName: string) => { form.value[listName].push({}); };
const removeLine = (listName: string, index: number) => { form.value[listName].splice(index, 1); };

const getList = async () => {
  loading.value = true;
  const res = await listWorkOrder(queryParams.value);
  workOrderList.value = res.rows;
  total.value = res.total;
  loading.value = false;
};
const cancel = () => { form.value = JSON.parse(JSON.stringify(initFormData)); dialog.visible = false; };
const handleQuery = () => { queryParams.value.pageNum = 1; getList(); };
const resetQuery = () => { queryFormRef.value?.resetFields(); handleQuery(); };

const handleAdd = () => {
  isView.value = false;
  form.value = JSON.parse(JSON.stringify(initFormData));
  addProductLine();
  dialog.visible = true; 
  dialog.title = "新建生产工单";
};

// 👉 修复查看数据时数组丢失的问题：安全合并不丢失响应式数组
const handleView = async (row: any) => {
  isView.value = true; 
  await loadFormData(row.id);
  dialog.visible = true; 
  dialog.title = "查看生产工单 - " + row.workOrderNo;
};

const handleUpdate = async (row?: any) => {
  isView.value = false;
  await loadFormData(row.id);
  dialog.visible = true; 
  dialog.title = "修改生产工单";
};

const handleAudit = (row: any) => {
  auditForm.value = { id: row.id, auditStatus: '2' };
  auditDialog.visible = true;
};

const submitAudit = async () => {
  await auditWorkOrder(auditForm.value);
  proxy?.$modal.msgSuccess("审批操作成功");
  auditDialog.visible = false;
  getList(); 
};

// 👉 优化：确保后端返回的数据结构完美映射到前端的响应式表格中
const loadFormData = async (id: number) => {
  isDataLoading.value = true; 
  try {
    const res = await getWorkOrder(id);
    form.value = { ...initFormData, ...res.data }; // 展开合并保证数据不丢失

    if (form.value.customerId) {
      form.value.customerId = String(form.value.customerId);
    }
    // 强制让所有子表即便是 null 也会变成空数组，防止表格组件报错
    ['productList', 'materialList', 'ctpList', 'printList', 'processList', 'outsourcingList'].forEach(key => { 
      if(!form.value[key]) form.value[key] = []; 
    });
    
    if(form.value.outsourcingList && form.value.outsourcingList.length > 0){
        form.value.outsourcingList.forEach((item: any) => {
           if (item.supplierId) item.supplierId = String(item.supplierId);
        });
    }
  } finally {
    nextTick(() => {
      isDataLoading.value = false;
    });
  }
}

const handleExportRow = (row: any) => {
  proxy?.download('erp/workOrder/export', { id: row.id }, `工单明细_${row.workOrderNo}.xlsx`)
};

const handleExportList = () => {
  proxy?.download('erp/workOrder/export', { ...queryParams.value }, `工单列表_${new Date().getTime()}.xlsx`)
};

const submitForm = () => {
  workOrderFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      // 产品校验
      if (!form.value.productList || form.value.productList.length === 0) {
        proxy?.$modal.msgError("请至少添加一项产品明细");
        return;
      }
      for (let i = 0; i < form.value.productList.length; i++) {
        if (!form.value.productList[i].productName) {
          proxy?.$modal.msgError(`产品明细第 ${i + 1} 行的产品名称不能为空`);
          return;
        }
      }

      // 👉 核心防御：防止材料行未填写完整导致后端丢弃（保存后查看为空的原因）
      if (form.value.materialList && form.value.materialList.length > 0) {
        for (let i = 0; i < form.value.materialList.length; i++) {
          const mat = form.value.materialList[i];
          if (!mat.partName || !mat.paperName) {
            proxy?.$modal.msgError(`材料清单第 ${i + 1} 行的【部件】和【物料名称】必须填写完整！`);
            return;
          }
        }
      }

      // 👉 全局库存二次终极拦截：提交前合并所有行的需求量，查库存余量
      const inHouseMats = form.value.materialList.filter((m: any) => m.sourceType === '本厂' && m.paperName);
      const matSum: Record<string, number> = {};
      for (const m of inHouseMats) {
        matSum[m.paperName] = (matSum[m.paperName] || 0) + Number(m.requireQty || 0);
      }
      for (const [name, qty] of Object.entries(matSum)) {
        const found = rawInventoryList.value.find(i => i.itemName === name);
        const maxQty = found ? Number(found.currentQty || 0) : 0;
        if (qty > maxQty) {
          proxy?.$modal.msgError(`保存失败：本厂材料【${name}】的全局总需求（${qty}）已超过可用库存（${maxQty}）！`);
          return;
        }
      }

      buttonLoading.value = true;
      form.value.productName = combinedProductNames.value;

      if (form.value.id) await updateWorkOrder(form.value).finally(() => buttonLoading.value = false);
      else await addWorkOrder(form.value).finally(() => buttonLoading.value = false);
      
      proxy?.$modal.msgSuccess("保存成功");
      dialog.visible = false;
      await getList();
    }
  });
};

const handleDelete = async (row?: any) => {
  await proxy?.$modal.confirm('确认删除工单【' + row.workOrderNo + '】？');
  await delWorkOrder(row.id);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
};

const printDialog = reactive({ visible: false });
const printData = ref({
  workOrderNo: '', orderDate: '', groups: [] as any[]
});

const digitUppercase = (n: number) => {
  const fraction = ['角', '分'];
  const digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];
  const unit = [['元', '万', '亿'], ['', '拾', '佰', '仟']];
  let head = n < 0 ? '欠' : '';
  n = Math.abs(n);
  let s = '';
  for (let i = 0; i < fraction.length; i++) {
    s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');
  }
  s = s || '整';
  n = Math.floor(n);
  for (let i = 0; i < unit[0].length && n > 0; i++) {
    let p = '';
    for (let j = 0; j < unit[1].length && n > 0; j++) {
      p = digit[n % 10] + unit[1][j] + p;
      n = Math.floor(n / 10);
    }
    s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s;
  }
  return head + s.replace(/(零.)*零元/, '元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');
};

const handlePrintOutsourcing = async (row: any) => {
  const res = await getWorkOrder(row.id);
  const woDetail = res.data as any; 
  
  if (!woDetail.outsourcingList || woDetail.outsourcingList.length === 0) {
    proxy?.$modal.msgWarning("该工单暂无委外加工数据");
    return;
  }

  printData.value.workOrderNo = woDetail.workOrderNo;
  printData.value.orderDate = proxy?.parseTime(woDetail.createTime, '{y}/{m}/{d}') || '';
  
  const groupsMap = new Map();
  woDetail.outsourcingList.forEach((item: any) => {
    const supplier = customerOptions.value.find(c => String(c.id) === String(item.supplierId));
    const supplierName = supplier ? supplier.companyName : '未知加工商';
    
    if (!groupsMap.has(supplierName)) {
      groupsMap.set(supplierName, { supplierName: supplierName, supplierAddress: supplier?.companyAddress, items: [], totalAmount: 0 });
    }
    const group = groupsMap.get(supplierName);
    group.items.push(item);
    group.totalAmount += (Number(item.totalPrice) || 0);
  });

  printData.value.groups = Array.from(groupsMap.values());
  printDialog.visible = true;
};

const exportExcel = () => {
  const printContent = document.getElementById('printArea')?.innerHTML;
  if (!printContent) return;
  
  const html = `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
    <head>
      <meta charset="UTF-8">
      <style>
        .print-table { width: 100%; border-collapse: collapse; font-family: "SimSun"; font-size: 12px; }
        .print-table td { border: 1px solid #000000; text-align: center; vertical-align: middle; }
        .left-align { text-align: left !important; }
        .font-bold { font-weight: bold; }
        .grey-bg { background-color: #e8e8e8; }
        .print-page { margin-bottom: 40px; }
        .center-align { text-align: center; mso-number-format:"\\@"; }
      </style>
    </head>
    <body>${printContent}</body>
  </html>`;
  
  const blob = new Blob([html], { type: 'application/vnd.ms-excel' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `委外单_${printData.value.workOrderNo}.xls`; 
  a.click();
  URL.revokeObjectURL(url);
};

const doPrint = () => {
  const printContent = document.getElementById('printArea')?.innerHTML;
  if (!printContent) return;
  const newWindow = window.open('', '_blank');
  newWindow?.document.write(`
    <html>
      <head>
        <title>打印委外加工单</title>
        <style>
          body { font-family: "SimSun", "Microsoft YaHei", sans-serif; padding: 20px; }
          .print-page { page-break-after: always; margin-bottom: 50px; }
          .print-header { text-align: center; margin-bottom: 10px; position: relative; }
          .print-header h1 { margin: 0; font-size: 24px; padding-bottom: 10px;}
          .print-table { width: 100%; border-collapse: collapse; font-size: 12px; }
          .print-table td, .print-table th { border: 1px solid #000; padding: 6px 4px; word-break: break-all; }
          .grey-bg { background-color: #e8e8e8 !important; -webkit-print-color-adjust: exact; color-adjust: exact; }
          .center-align { text-align: center; }
          .left-align { text-align: left !important; }
          .font-bold { font-weight: bold; }
          .text-lg { font-size: 16px; }
          .memo-text { line-height: 1.5; font-size: 11px; }
        </style>
      </head>
      <body>${printContent}</body>
    </html>
  `);
  newWindow?.document.close();
  setTimeout(() => {
    newWindow?.print();
    newWindow?.close();
  }, 200);
};

onMounted(() => { 
  getList(); 
  getCustomerList(); 
  loadInventoryData(); 
});
</script>

<style lang="scss" scoped>
.print-wrapper {
  background: #fff;
  padding: 20px;
  color: #000;
  overflow-x: auto; 
  
  .print-page {
    margin-bottom: 40px;
    border: 1px dashed #ccc;
    padding: 20px;
    min-width: 1280px; 
  }

  .print-header {
    text-align: center;
    margin-bottom: 15px;
    h1 {
      margin: 0;
      font-size: 22px;
      font-family: "SimSun", serif;
      font-weight: bold;
    }
  }

  .print-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 12px;
    table-layout: fixed; 

    td {
      border: 1px solid #333;
      padding: 6px 4px;
    }

    .grey-bg { background-color: #e8e8e8; }
    .center-align { text-align: center; }
    .left-align { text-align: left !important; }
    .font-bold { font-weight: bold; }
    .text-lg { font-size: 15px; }
    .memo-text { line-height: 1.6; font-size: 11px; }
  }
}
</style>