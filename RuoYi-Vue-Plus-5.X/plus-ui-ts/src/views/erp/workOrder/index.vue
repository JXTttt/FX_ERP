<template>
  <div class="p-2 app-container">
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
            <el-button type="success" icon="Connection" @click="openSalesOrderList">从销售订单提取</el-button>
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
        <el-table-column label="总交货期" align="center" prop="deliveryDate" width="120">
          <template #default="scope">
            <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right" width="360">
          <template #default="scope">
            <el-tooltip content="查看" placement="top"><el-button link type="success" icon="View" @click="handleView(scope.row)" v-hasPermi="['erp:workOrder:query']" /></el-tooltip>
            <el-tooltip content="修改" placement="top"><el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-if="scope.row.auditStatus !== '2'" v-hasPermi="['erp:workOrder:edit']" /></el-tooltip>
            <el-tooltip content="审批" placement="top"><el-button link type="primary" icon="Stamp" @click="handleAudit(scope.row)" v-if="scope.row.auditStatus === '1'" v-hasPermi="['erp:workOrder:audit']" /></el-tooltip>
            <el-button link type="warning" icon="Printer" @click="handlePrintOutsourcing(scope.row)" v-hasPermi="['erp:workOrder:query']">委外单</el-button>
            <el-button link type="success" icon="Tickets" @click="handlePrintFull(scope.row)" v-hasPermi="['erp:workOrder:query']">工程单</el-button>
            <el-button link type="primary" icon="Position" @click="handlePushAllOutsourcing(scope.row)" v-if="scope.row.auditStatus === '2'">委外发货</el-button>
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-if="scope.row.auditStatus !== '2'" v-hasPermi="['erp:workOrder:remove']">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog title="提取待排产的销售订单" v-model="fetchSoDialog.visible" width="1000px" append-to-body>
      <el-table v-loading="fetchSoDialog.loading" :data="fetchSoDialog.list" border size="small">
        <el-table-column label="订单编号" prop="orderNo" width="140" />
        <el-table-column label="客户名称" prop="customerName" />
        <el-table-column label="交货日期" prop="deliveryDate" width="110">
          <template #default="scope">
            <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160" align="center">
          <template #default="scope">
            <el-button type="primary" size="small" icon="MagicStick" @click="initWorkOrderWhole(scope.row)">提取整单并生成</el-button>
          </template>
        </el-table-column>
        <el-table-column type="expand" width="50">
          <template #default="props">
            <div style="padding: 10px 20px; background-color: #f8f8f9;">
              <el-table :data="props.row.detailList" border size="small">
                <el-table-column label="产品名称" prop="productName" />
                <el-table-column label="尺寸规格" prop="spec" width="120" />
                <el-table-column label="材质需求" prop="materialReq" />
                <el-table-column label="数量" prop="quantity" width="80" />
              </el-table>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="fetchSoDialog.total > 0" :total="fetchSoDialog.total" v-model:page="fetchSoDialog.pageNum" v-model:limit="fetchSoDialog.pageSize" @pagination="fetchPendingSalesOrders" />
    </el-dialog>

    <canvas id="barcodeCanvas" style="display:none;"></canvas>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="95%" append-to-body style="overflow: hidden;">
      <div style="width: 100%; overflow-x: hidden;">
        <el-form ref="workOrderFormRef" :model="form" :rules="rules" label-width="110px" :disabled="isView">
          
          <el-divider content-position="left">一、基础业务信息</el-divider>
          <el-row :gutter="20">
            <el-col :span="8">
              <el-form-item label="选择客户" prop="customerId">
                <el-select v-model="form.customerId" placeholder="请选择客户(必填)" filterable style="width: 100%" @change="handleCustomerChange">
                  <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="默认总交期" prop="deliveryDate">
                <el-date-picker clearable v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="设定整批产品的默认统一交货日期" style="width: 100%" />
              </el-form-item>
            </el-col>
             <el-col :span="8">
              <el-form-item label="包装要求" prop="packRequirement">
                <el-input v-model="form.packRequirement" placeholder="请输入整单包装要求" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="24">
              <el-form-item label="总单备注" prop="remark">
                <el-input v-model="form.remark" placeholder="填写其他补充信息或特殊说明" />
              </el-form-item>
            </el-col>
          </el-row>

          <el-divider content-position="left">二、产品清单与工艺配置 (多产品隔离)</el-divider>
          
          <el-tabs v-model="activeProductTab" type="card" editable @edit="handleProductTabsEdit" style="border: 1px solid #dcdfe6; padding: 10px; background: #fafafa;">
            
            <el-tab-pane 
              v-for="(product, pIndex) in form.productList" 
              :key="product.uid" 
              :label="product.productName || `未命名产品 ${Number(pIndex) + 1}`" 
              :name="product.uid"
            >
              <el-card shadow="never" style="margin-bottom: 15px; border-top: 3px solid #409EFF;">
                <template #header><span style="font-weight: bold;">{{ product.productName || '请输入产品名称' }} - 基本属性</span></template>
                <el-row :gutter="15">
                  <el-col :span="6">
                    <el-form-item label="产品名称(必填)" label-width="120px">
                      <el-input v-model="product.productName" placeholder="如：中秋月饼盒" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="专属交期" label-width="80px">
                      <el-date-picker clearable v-model="product.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="为空用总交期" style="width: 100%" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="客户PO号" label-width="80px">
                      <el-input v-model="product.customerPo" placeholder="PO号" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="客户物料号" label-width="90px">
                      <el-input v-model="product.customerMaterialNo" placeholder="物料号" />
                    </el-form-item>
                  </el-col>
                </el-row>
                <el-row :gutter="15">
                  <el-col :span="6">
                    <el-form-item label="规格" label-width="120px">
                      <el-input v-model="product.spec" placeholder="长x宽x高" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="刀版号" label-width="80px">
                      <el-input v-model="product.knifePlateNo" placeholder="系统生成" disabled />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="单位" label-width="90px">
                      <el-input v-model="product.unit" placeholder="个" />
                    </el-form-item>
                  </el-col>
                </el-row>
                <el-row :gutter="15">
                  <el-col :span="6">
                    <el-form-item label="订单数量" label-width="120px">
                      <el-input-number v-model="product.orderQuantity" :min="1" style="width: 100%" :controls="false" @change="(val: any) => handleOrderQtyChange(val, product)" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="生产数量" label-width="80px">
                      <el-input-number v-model="product.produceQuantity" :min="1" style="width: 100%" :controls="false" @change="() => calcProductTotal(product)" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="单价" label-width="80px">
                      <el-input-number v-model="product.unitPrice" :precision="4" :step="0.1" :min="0" :controls="false" style="width: 100%" @change="() => calcProductTotal(product)" />
                    </el-form-item>
                  </el-col>
                  <el-col :span="6">
                    <el-form-item label="总金额" label-width="90px">
                      <el-input v-model="product.totalAmount" disabled />
                    </el-form-item>
                  </el-col>
                </el-row>
                <el-row :gutter="15">
                  <el-col :span="8">
                    <el-form-item label="包装需求" label-width="120px">
                      <el-autocomplete
                        v-model="product.packRequirement"
                        :fetch-suggestions="querySearchPack"
                        placeholder="如: 平装, 精装"
                        clearable
                        style="width: 100%"
                      />
                    </el-form-item>
                  </el-col>
                  <el-col :span="8">
                    <el-form-item label="物流要求" label-width="80px">
                      <el-autocomplete
                        v-model="product.logisticsReq"
                        :fetch-suggestions="querySearchLogistics"
                        placeholder="如: 快递, 自提"
                        clearable
                        style="width: 100%"
                      />
                    </el-form-item>
                  </el-col>
                </el-row>
              </el-card>

              <el-tabs type="border-card">
                <el-tab-pane label="1. 材料清单">
                  <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine(pIndex, 'materialList')">添加材料</el-button></div>
                  <el-table :data="product.materialList" border size="small" style="width: 100%;">
                    <el-table-column label="部件(必填)" width="140">
                      <template #default="scope">
                        <el-autocomplete
                          v-model="scope.row.partName"
                          :fetch-suggestions="querySearchPart"
                          placeholder="纸张/配件"
                          clearable
                          style="width: 100%"
                        />
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
                        <el-autocomplete
                          v-model="scope.row.paperName"
                          :fetch-suggestions="querySearchMaterial"
                          placeholder="选库存/自填"
                          clearable
                          style="width: 100%"
                          @select="(item: any) => handleMaterialChange(item.value, scope.row)"
                        >
                          <template #default="{ item }">
                            <div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                              <span>{{ item.value }}</span>
                              <span style="color: #8492a6; font-size: 12px;">
                                库存: <span style="color:#F56C6C;font-weight:bold;">{{ item.currentQty || 0 }}</span> | {{ item.spec || '无规格' }}
                              </span>
                            </div>
                          </template>
                        </el-autocomplete>
                      </template>
                    </el-table-column>
                    <el-table-column label="尺寸/规格" width="150">
                      <template #default="scope">
                        <el-input v-model="scope.row.paperSize" placeholder="自动带出或手填" :disabled="scope.row.sourceType === '本厂'" />
                      </template>
                    </el-table-column>
                    <el-table-column label="数量" width="160">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.requireQty" :min="0" :controls="false" style="width: 100%" @change="(val: any) => checkMaterialQty(val, scope.row)" />
                      </template>
                    </el-table-column>
                    <el-table-column label="版次" width="100">
                      <template #default="scope"><el-input v-model="scope.row.edition" placeholder="版次" /></template>
                    </el-table-column>
                    <el-table-column label="切成" width="160">
                      <template #default="scope"><el-input v-model="scope.row.cutMethod" /></template>
                    </el-table-column>
                    <el-table-column label="操作" width="130" align="center" fixed="right" v-if="!isView">
                      <template #default="scope">
                        <el-button v-if="scope.row.sourceType === '订购'" link type="primary" icon="Position" @click="handleToExtraPurchase(scope.row)">转订购</el-button>
                        <el-button link type="danger" icon="Delete" @click="removeLine(pIndex, 'materialList', scope.$index)">移除</el-button>
                      </template>
                    </el-table-column>
                  </el-table>
                </el-tab-pane>

                <el-tab-pane label="2. 印刷及工艺明细">
                  <div class="mb-2" v-if="!isView" style="display: flex; align-items: center; gap: 10px;">
                    <el-button type="primary" plain icon="Plus" size="small" @click="addLine(pIndex, 'processList')">添加空行</el-button>
                    <el-cascader v-model="batchProcessSelection" :options="processTreeData" :props="{ multiple: true, emitPath: false }" collapse-tags clearable filterable placeholder="批量添加工艺/印刷(支持多选)" style="width: 280px" popper-class="hide-first-level-checkbox" />
                    <el-button type="success" size="small" @click="confirmBatchAddProcess(pIndex)">批量添加至下方</el-button>
                    <el-button type="warning" size="small" icon="Select" @click="transferSelectedToOutsourcing(pIndex)" style="margin-left: auto;">将勾选项转委外</el-button>
                    <el-button type="danger" size="small" icon="Position" @click="handleBatchToOutsourcing(pIndex)">一键全部转委外</el-button>
                  </div>
                  <el-table
                    :data="product.processList"
                    border size="small" style="width: 100%;"
                    @selection-change="(rows: any) => handleProcessSelectionChange(pIndex, rows)"
                    ref="processTableRefs"
                  >
                    <el-table-column type="selection" width="40" v-if="!isView" />
                    <el-table-column label="工序名称" width="280">
                      <template #default="scope">
                        <el-select v-if="!isView" v-model="scope.row.processName" filterable allow-create default-first-option placeholder="选填工序" style="width: 100%">
                          <el-option v-for="dict in allOutsourcingProjects" :key="dict.value" :label="dict.label" :value="dict.label" />
                        </el-select>
                        <span v-else>{{ scope.row.processName }}</span>
                      </template>
                    </el-table-column>
                    <el-table-column label="加工细则" width="120">
                      <template #default="scope">
                        <el-select v-if="!isView" v-model="scope.row.processDetail" filterable clearable placeholder="工序细则" style="width: 100%">
                          <el-option v-for="opt in getProcessDetailOptions(scope.row.processName)" :key="opt.value" :label="opt.label" :value="opt.label" />
                        </el-select>
                        <span v-else>{{ scope.row.processDetail }}</span>
                      </template>
                    </el-table-column>
                    <el-table-column label="具体要求/机器要求/备注" min-width="200">
                      <template #default="scope"><el-input v-model="scope.row.remark" placeholder="如：正反印、机器名、尺寸说明" /></template>
                    </el-table-column>
                    <el-table-column label="操作" width="180" align="center" fixed="right" v-if="!isView">
                      <template #default="scope">
                        <el-button type="primary" link icon="Position" @click="handleToOutsourcing(pIndex, scope.row)">转委外</el-button>
                        <el-button type="danger" link icon="Delete" @click="removeLine(pIndex, 'processList', scope.$index)">移除</el-button>
                      </template>
                    </el-table-column>
                  </el-table>
                </el-tab-pane>

                <el-tab-pane label="3. 委外加工单">
                  <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine(pIndex, 'outsourcingList')">手动加外发</el-button></div>
                  <el-table :data="product.outsourcingList" border size="small" style="width: 100%;" overflow-x="auto">
                    
                    <el-table-column label="针对材料" width="130">
                      <template #default="scope">
                        <el-select v-model="scope.row.materialName" filterable allow-create placeholder="选择本单材料">
                           <el-option v-for="mat in product.materialList" :key="mat.paperName" :label="mat.paperName" :value="mat.paperName" />
                        </el-select>
                      </template>
                    </el-table-column>

                    <el-table-column label="加工工序" width="130">
                      <template #default="scope">
                        <el-select v-if="!isView" v-model="scope.row.processProject" filterable allow-create placeholder="选/填" style="width: 100%">
                          <el-option v-for="dict in allOutsourcingProjects" :key="dict.value" :label="dict.label" :value="dict.label" />
                        </el-select>
                        <span v-else>{{ scope.row.processProject }}</span>
                      </template>
                    </el-table-column>

                    <el-table-column label="加工细则" width="120">
                      <template #default="scope">
                        <el-select v-if="!isView" v-model="scope.row.processDetail" filterable clearable placeholder="工序细则" style="width: 100%">
                          <el-option v-for="opt in getProcessDetailOptions(scope.row.processProject)" :key="opt.value" :label="opt.label" :value="opt.label" />
                        </el-select>
                        <span v-else>{{ scope.row.processDetail }}</span>
                      </template>
                    </el-table-column>

                    <el-table-column label="印刷颜色" width="100">
                      <template #default="scope">
                        <el-select v-if="!isView" v-model="scope.row.printColor" filterable clearable placeholder="颜色" style="width: 100%" :disabled="!isPrintRow(scope.row)">
                          <el-option v-for="dict in erp_print_color" :key="dict.value" :label="dict.label" :value="dict.label" />
                        </el-select>
                        <span v-else>{{ scope.row.printColor }}</span>
                      </template>
                    </el-table-column>
                    <el-table-column label="模数" width="80">
                      <template #default="scope">
                        <el-input v-if="!isView" v-model="scope.row.printImpression" placeholder="3+3" :disabled="!isPrintRow(scope.row)" />
                        <span v-else>{{ scope.row.printImpression }}</span>
                      </template>
                    </el-table-column>
                    <el-table-column label="印刷机号" width="100">
                      <template #default="scope">
                        <el-input v-if="!isView" v-model="scope.row.printMachine" placeholder="机号" :disabled="!isPrintRow(scope.row)" />
                        <span v-else>{{ scope.row.printMachine }}</span>
                      </template>
                    </el-table-column>

                    <el-table-column label="加工商/供应商" width="140">
                      <template #default="scope">
                        <el-select v-model="scope.row.supplierId" placeholder="选择加工商" filterable>
                          <el-option v-for="item in getFilteredSuppliers(scope.row.processProject)" :key="String(item.id)" :label="item.shortName || item.companyName" :value="String(item.id)">
                            <span style="float: left">{{ item.shortName || item.companyName }}</span>
                          </el-option>
                        </el-select>
                      </template>
                    </el-table-column>

                    <el-table-column label="长(mm)" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.length" :controls="false" style="width: 100%" @change="() => calcTotalPrice(scope.row)"/>
                      </template>
                    </el-table-column>
                    <el-table-column label="宽(mm)" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.width" :controls="false" style="width: 100%" @change="() => calcTotalPrice(scope.row)"/>
                      </template>
                    </el-table-column>
                    <el-table-column label="高(mm)" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.height" :controls="false" style="width: 100%" />
                      </template>
                    </el-table-column>
                    
                    <el-table-column label="数量" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.processQty" :controls="false" style="width: 100%" @change="() => calcTotalPrice(scope.row)" />
                      </template>
                    </el-table-column>
                    <el-table-column label="良品数" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.goodQty" :controls="false" style="width: 100%"/>
                      </template>
                    </el-table-column>
                    
                    <el-table-column label="算价方式" width="80">
                      <template #default="scope">
                        <el-select v-model="scope.row.unit" @change="() => calcTotalPrice(scope.row)">
                          <el-option label="平方米" value="平方米"/><el-option label="张" value="张"/><el-option label="套" value="套"/>
                        </el-select>
                      </template>
                    </el-table-column>
                    <el-table-column label="单价" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.unitPrice" :min="0" :precision="4" :controls="false" style="width: 100%" @change="() => calcTotalPrice(scope.row)"/>
                      </template>
                    </el-table-column>
                    <el-table-column label="金额" width="80">
                      <template #default="scope">
                        <el-input-number v-model="scope.row.totalPrice" :min="0" :precision="2" :controls="false" style="width: 100%" disabled/>
                      </template>
                    </el-table-column>
                    <el-table-column label="操作" width="60" align="center" fixed="right" v-if="!isView">
                      <template #default="scope">
                        <el-button link type="danger" @click="removeLine(pIndex, 'outsourcingList', scope.$index)">移除</el-button>
                      </template>
                    </el-table-column>
                  </el-table>
                </el-tab-pane>

                <el-tab-pane label="4. 模具与制版 (CTP)">
                  <div class="mb-2" v-if="!isView"><el-button type="primary" plain icon="Plus" size="small" @click="addLine(pIndex, 'ctpList')">添加模具</el-button></div>
                  <el-table :data="product.ctpList" border size="small" style="width: 100%;">
                    <el-table-column label="部件" min-width="150"><template #default="scope"><el-input v-model="scope.row.partName" /></template></el-table-column>
                    <el-table-column label="开数" width="120"><template #default="scope"><el-input-number v-model="scope.row.openNum" :min="1" :max="9" style="width: 100%" :controls="false" /></template></el-table-column>
                    <el-table-column label="排版方式" width="150">
                      <template #default="scope">
                        <el-select v-model="scope.row.printType" allow-create filterable>
                          <el-option label="单面" value="单面" /><el-option label="正反" value="正反" />
                          <el-option label="自反" value="自反" /><el-option label="天地反" value="天地反" />
                        </el-select>
                      </template>
                    </el-table-column>
                    <el-table-column label="版数/套数" width="120"><template #default="scope"><el-input-number v-model="scope.row.plateCount" :min="1" style="width: 100%" :controls="false"/></template></el-table-column>
                    <el-table-column label="操作" width="70" align="center" fixed="right" v-if="!isView"><template #default="scope"><el-button link type="danger" @click="removeLine(pIndex, 'ctpList', scope.$index)">移除</el-button></template></el-table-column>
                  </el-table>
                </el-tab-pane>

              </el-tabs>
            </el-tab-pane>
          </el-tabs>

        </el-form>
      </div>
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
      <div id="printArea" class="print-wrapper" style="font-family: 'SimSun', 'Microsoft YaHei', sans-serif; color: #000;">
        <div class="print-page" v-for="(group, index) in printData.groups" :key="index" style="page-break-after: always; margin-bottom: 40px;">
          
          <div class="print-header" style="text-align: center; margin-bottom: 15px;">
            <h1 style="margin: 0; font-size: 24px; font-weight: bold; letter-spacing: 2px;">中山市梵熙创意纸品有限公司——委外加工单</h1>
          </div>
          
          <table class="print-table" :id="'excelTable_' + index" border="1" cellspacing="0" cellpadding="6" style="width: 100%; border-collapse: collapse; font-size: 12px; text-align: center; border-color: #000;">
            <colgroup>
              <col width="45">  <col width="180"> <col width="150"> <col width="100"> <col width="70">  <col width="60">  <col width="100"> <col width="80">  <col width="70">  <col width="60">  <col width="80">  <col width="90">  <col width="120"> </colgroup>
            <tbody>
              <tr class="info-row">
                <td colspan="6" style="text-align: left;"><strong>加工商名称/联系人及电话：</strong>{{ group.supplierName }}</td>
                <td colspan="5" style="text-align: left;"><strong>委托方联系人：</strong>谭生/18823054545  廖小姐/15015007628</td>
                <td colspan="1" style="background-color: #e8e8e8; font-weight: bold; text-align: center;">下单日期</td>
                <td colspan="1" style="text-align: center;">{{ printData.orderDate }}</td>
              </tr>
              <tr class="info-row">
                <td colspan="6" style="text-align: left;"><strong>加工商地址：</strong>{{ group.supplierAddress || '详见系统记录' }}</td>
                <td colspan="5" style="text-align: left;"><strong>委托方地址：</strong>中山市小榄镇西区社区太乐路23号5栋3楼</td>
                <td colspan="1" style="background-color: #e8e8e8; font-weight: bold; text-align: center;">加工单号</td>
                <td colspan="1" style="text-align: center; mso-number-format: '\@';">{{ printData.workOrderNo }}</td>
              </tr>
              
              <tr class="list-header" style="background-color: #e8e8e8; font-weight: bold; text-align: center;">
                <td>序号</td>
                <td>产品名称</td>
                <td>材料名称</td>
                <td>尺寸(mm)</td>
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

              <tr style="text-align: center;" v-for="(item, i) in group.items" :key="i">
                <td>{{ Number(i) + 1 }}</td>
                <td>{{ item.productName }}</td>
                <td>{{ item.materialName || item.paperName || '' }}</td>
                <td>{{ item.length && item.width ? `${item.length}*${item.width}${item.height ? '*' + item.height : ''}` : (item.finishSize || '') }}</td>
                <td>{{ item.processQty || '' }}</td>
                <td>张</td>
                <td>{{ item.processProject }}</td>
                <td>{{ item.goodQty || item.processQty }}</td>
                <td>{{ item.unit }}</td>
                <td>{{ item.unitPrice || '' }}</td>
                <td>{{ item.totalPrice || '' }}</td>
                <td>{{ parseTime(item.deliveryDate, '{y}-{m}-{d}') || '' }}</td>
                <td>{{ item.remark || '' }}</td>
              </tr>

              <tr class="total-row">
                <td colspan="3" style="text-align: center; font-weight: bold;">合计 (人民币大写)</td>
                <td colspan="5" style="text-align: center; font-weight: bold; font-size: 14px;">{{ digitUppercase(Number(group.totalAmount)) }}</td>
                <td colspan="2" style="text-align: center; font-weight: bold;">合计 (人民币小写)</td>
                <td colspan="1" style="text-align: center; font-weight: bold; color: red;">{{ Number(group.totalAmount).toFixed(2) }}</td>
                <td colspan="2"></td>
              </tr>

              <tr class="footer-row">
                <td colspan="1" style="text-align: center; font-weight: bold;">备注</td>
                <td colspan="7" style="text-align: left; line-height: 1.5; font-size: 11px; padding: 10px;">
                  1、税/运方式：不含税，我司自提。<br>
                  2、结算方式：月结30天。<br>
                  3、请贵单位收到订单4小时内确认并回复交期，未及时回复视为默认。
                </td>
                <td colspan="5" style="text-align: left; font-weight: bold; font-size: 14px; vertical-align: top; padding-top: 15px; padding-bottom: 35px;">
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

    <el-dialog title="工程单预览" v-model="fullPrintDialog.visible" width="1050px" append-to-body>
      <div v-if="fullPrintDialog.loading" v-loading="fullPrintDialog.loading" style="min-height: 200px;"></div>
      <div v-else-if="fullPrintData" style="font-family: 'SimSun', 'Microsoft YaHei', sans-serif; color: #000; font-size: 13px;">
        <!-- 题头栏：二维码左 | 标题中 | 条形码右，在 fullPrintArea 外面 -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; padding-bottom: 8px; border-bottom: 2px solid #000;">
          <div style="width:70px; flex-shrink:0;">
            <img v-if="fullPrintQrcode" :src="fullPrintQrcode" style="width:65px; height:65px;" title="扫二维码" />
          </div>
          <div style="flex:1; text-align: center;">
            <h2 style="margin: 0; font-size: 20px; font-weight: bold; letter-spacing: 3px;">{{ fullPrintData.companyName }}——工程单</h2>
          </div>
          <div style="width:auto; flex-shrink:0; text-align:right;">
            <img v-if="fullPrintBarcode" :src="fullPrintBarcode" style="max-height:50px;" title="扫条形码" />
          </div>
        </div>
        <div id="fullPrintArea">
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="10%"><col width="23%"><col width="10%"><col width="23%"><col width="10%"><col width="24%"></colgroup>
          <tbody>
          <tr>
            <td class="fp-label">订单编号</td><td>{{ fullPrintData.orderNo || '' }}</td>
            <td class="fp-label">客户名称</td><td>{{ fullPrintData.customerName || '' }}</td>
            <td class="fp-label">工单号</td><td>{{ fullPrintData.workOrderNo || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">产品编号</td><td>{{ fullPrintData.productNos || '' }}</td>
            <td class="fp-label">品名</td><td>{{ fullPrintData.productNames || '' }}</td>
            <td class="fp-label">交货日期</td><td>{{ parseTime(fullPrintData.deliveryDate, '{y}-{m}-{d}') || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">数量</td><td colspan="3">{{ fullPrintData.quantities || '' }}</td>
            <td class="fp-label">产品描述</td><td>{{ fullPrintData.productDesc || '' }}</td>
          </tr>
          </tbody>
        </table>

        <!-- 一、材质 -->
        <div class="fp-section-title">一、材质</div>
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="8%"><col width="25%"><col width="20%"><col width="10%"><col></colgroup>
          <tbody>
          <tr class="fp-header-row"><td>版次</td><td>用料</td><td>开支尺寸mm</td><td>数量</td><td>备注</td></tr>
          <tr v-for="(item, i) in (fullPrintData.materialList && fullPrintData.materialList.length ? fullPrintData.materialList : [{}])" :key="'m'+i">
            <td style="text-align:center;">{{ item.edition || '' }}</td>
            <td>{{ item.paperName || '' }}</td>
            <td style="text-align:center;">{{ item.paperSize || '' }}</td>
            <td style="text-align:center;">{{ item.requireQty || '' }}</td>
            <td>{{ item.remark || '' }}</td>
          </tr>
          </tbody>
        </table>

        <!-- 二、印刷+表面处理 -->
        <div class="fp-section-title">二、印刷+表面处理</div>
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="12%"><col width="12%"><col width="18%"><col width="10%"><col width="10%"><col width="10%"></colgroup>
          <tbody>
          <tr class="fp-header-row"><td>印刷机号</td><td>印刷颜色</td><td>印刷尺寸</td><td>模数</td><td>订单数</td><td>良品数</td></tr>
          <tr v-for="(item, i) in (fullPrintData.printSurfaceList && fullPrintData.printSurfaceList.length ? fullPrintData.printSurfaceList : [{}])" :key="'ps'+i">
            <td style="text-align:center;">{{ item.printMachine || '' }}</td>
            <td style="text-align:center;">{{ item.printColor || '' }}</td>
            <td style="text-align:center;">{{ formatSize(item) }}</td>
            <td style="text-align:center;">{{ item.printImpression || '' }}</td>
            <td style="text-align:center;">{{ item.processQty || '' }}</td>
            <td style="text-align:center;">{{ item.goodQty || '' }}</td>
          </tr>
          </tbody>
        </table>

        <!-- 三、后续加工 -->
        <div class="fp-section-title">三、后续加工</div>
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="18%"><col width="20%"><col width="18%"><col></colgroup>
          <tbody>
          <tr class="fp-header-row"><td>供应商</td><td>成品尺寸</td><td>项目内容</td><td>备注</td></tr>
          <tr v-for="(item, i) in (fullPrintData.postProcessList && fullPrintData.postProcessList.length ? fullPrintData.postProcessList : [{}])" :key="'pp'+i">
            <td style="text-align:center;">{{ getSupplierName(item.supplierId) }}</td>
            <td style="text-align:center;">{{ formatSize(item) || item.finishSize || '' }}</td>
            <td style="text-align:center;">{{ item.processProject || '' }}</td>
            <td>{{ item.remark || '' }}</td>
          </tr>
          </tbody>
        </table>

        <!-- 四、其他订料 -->
        <div class="fp-section-title">四、其他订料</div>
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="18%"><col width="22%"><col width="10%"><col></colgroup>
          <tbody>
          <tr class="fp-header-row"><td>项目</td><td>内容/规格</td><td>数量</td><td>备注</td></tr>
          <tr v-for="(item, i) in (fullPrintData.extraPurchaseList && fullPrintData.extraPurchaseList.length ? fullPrintData.extraPurchaseList : [{}])" :key="'ep'+i">
            <td>{{ item.itemContent || '' }}</td>
            <td style="text-align:center;">{{ item.spec || '' }}</td>
            <td style="text-align:center;">{{ item.quantity || '' }}</td>
            <td>{{ item.remark || '' }}</td>
          </tr>
          </tbody>
        </table>

        <!-- 底部 -->
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000;">
          <colgroup><col width="10%"><col width="40%"><col width="10%"><col width="40%"></colgroup>
          <tbody>
          <tr>
            <td class="fp-label">包装要求</td><td>{{ fullPrintData.packRequirement || '' }}</td>
            <td class="fp-label">物流要求</td><td>{{ fullPrintData.logisticsReq || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">备注</td><td colspan="3">{{ fullPrintData.remark || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">制单员</td><td>{{ fullPrintData.preparedBy || '' }}</td>
            <td class="fp-label">审核</td><td>{{ fullPrintData.auditBy || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">批准</td><td colspan="3">{{ fullPrintData.approvedBy || '' }}</td>
          </tr>
          </tbody>
        </table>
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="warning" icon="Download" @click="exportFullPrintExcel">下载 Excel</el-button>
          <el-button type="success" icon="Printer" @click="doFullPrint">执 行 打 印</el-button>
          <el-button @click="fullPrintDialog.visible = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="WorkOrder" lang="ts">
import { listWorkOrder, getWorkOrder, getPrintWorkOrder, delWorkOrder, addWorkOrder, updateWorkOrder, auditWorkOrder } from '@/api/erp/workOrder';
import { listSalesOrder } from '@/api/erp/salesOrder/index';
import { listCustomer } from '@/api/erp/customer';
import { listInventory } from '@/api/erp/inventory'; 
import { ComponentInternalInstance, computed, onMounted, reactive, ref, toRefs, watch, getCurrentInstance, nextTick } from 'vue';
import request from '@/utils/request'; 
import JsBarcode from 'jsbarcode';
import QRCode from 'qrcode';
import { getDicts } from '@/api/system/dict/data';
import { useRoute } from 'vue-router';
import { ElMessage } from 'element-plus';

type ElFormInstance = InstanceType<typeof import('element-plus').ElForm>;

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const {
  erp_item_type, erp_process_name, erp_processor_category,
  erp_print_type, erp_print_color, erp_mold_name,
  erp_process_detail, erp_pack_type, erp_logistics_type
} = toRefs<any>(proxy?.useDict(
  'erp_item_type', 'erp_process_name', 'erp_processor_category',
  'erp_print_type', 'erp_print_color', 'erp_mold_name',
  'erp_process_detail', 'erp_pack_type', 'erp_logistics_type'
));

const workOrderList = ref([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const isView = ref(false);
const isDataLoading = ref(false); 
const rawProcessDictOptions = ref<any[]>([]);
const rawProcessDetailOptions = ref<any[]>([]);
const route = useRoute();

const activeProductTab = ref<string>('0');
const customerOptions = ref<any[]>([]); 
const inventoryOptions = ref<any[]>([]);
const rawInventoryList = ref<any[]>([]);

const queryFormRef = ref<ElFormInstance>();
const workOrderFormRef = ref<ElFormInstance>();
const dialog = reactive({ visible: false, title: '' });

const auditDialog = reactive({ visible: false });
const auditForm = ref<any>({ id: undefined, auditStatus: '2' });

const fetchSoDialog = reactive({ visible: false, loading: false, list: [] as any[], total: 0, pageNum: 1, pageSize: 10 });
const printDialog = reactive({ visible: false });
const printData = ref({ workOrderNo: '', orderDate: '', groups: [] as any[] });

const fullPrintDialog = reactive({ visible: false, loading: false });
const fullPrintData = ref<any>({});
const fullPrintBarcode = ref('');
const fullPrintQrcode = ref('');
const initFormData: any = {
  id: undefined, salesOrderId: undefined, customerId: undefined, customerName: undefined,
  deliveryDate: undefined, packRequirement: undefined, remark: undefined, preparedBy: undefined,
  productList: []
};

const data = reactive<any>({
  form: { ...initFormData },
  queryParams: { pageNum: 1, pageSize: 50, workOrderNo: '', customerName: '', productName: '' },
  rules: {
    customerId: [{ required: true, message: "客户必须选择", trigger: "change" }]
  }
});
const { queryParams, form, rules } = toRefs(data);

const createNewProduct = () => {
  return {
    uid: Date.now().toString() + Math.random().toString().substring(2, 6),
    productName: '', customerPo: '', customerMaterialNo: '', spec: '',
    knifePlateNo: '', orderQuantity: undefined, produceQuantity: undefined, unit: '个', unitPrice: undefined, totalAmount: 0.00,
    deliveryDate: undefined,
    packRequirement: '', logisticsReq: '',
    materialList: [], processList: [], outsourcingList: [], ctpList: [], extraPurchaseList: []
  };
};

const handleProductTabsEdit = (targetName: any, action: any) => {
  if (action === 'add') {
    const newProd = createNewProduct();
    form.value.productList.push(newProd);
    activeProductTab.value = newProd.uid;
  } else if (action === 'remove') {
    if (form.value.productList.length <= 1) {
       ElMessage.warning("工单至少需要保留一个产品！");
       return;
    }
    form.value.productList = form.value.productList.filter((p: any) => p.uid !== targetName);
    activeProductTab.value = form.value.productList[0].uid;
  }
};

const addProductLine = () => {
  const newProd = createNewProduct();
  form.value.productList.push(newProd);
  activeProductTab.value = newProd.uid;
};

// TS 放宽，防止 $index 类型推断报错
const addLine = (pIndex: any, listName: string) => { 
    form.value.productList[pIndex][listName].push({}); 
};
const removeLine = (pIndex: any, listName: string, index: any) => { 
    form.value.productList[pIndex][listName].splice(index, 1); 
};

const openSalesOrderList = () => { fetchSoDialog.visible = true; fetchPendingSalesOrders(); };
const fetchPendingSalesOrders = async () => {
  fetchSoDialog.loading = true;
  try {
    const res = await listSalesOrder({ pageNum: fetchSoDialog.pageNum, pageSize: fetchSoDialog.pageSize, status: 0 });
    fetchSoDialog.list = res.rows; fetchSoDialog.total = res.total;
  } catch (e) { console.error(e); } finally { fetchSoDialog.loading = false; }
};

const initWorkOrderWhole = (soMaster: any) => {
  fetchSoDialog.visible = false;
  isView.value = false;
  form.value = JSON.parse(JSON.stringify(initFormData));
  
  form.value.salesOrderId = soMaster.id;
  form.value.customerId = String(soMaster.customerId);
  form.value.customerName = soMaster.customerName;
  if(soMaster.deliveryDate) form.value.deliveryDate = String(soMaster.deliveryDate).split(' ')[0].split('T')[0];
  
  const details = soMaster.detailList || [];
  if (details.length === 0) {
      addProductLine();
      proxy?.$modal.msgWarning("该订单无产品明细，已开启空白工单");
  } else {
      details.forEach((soDetail: any) => {
          const newProd = createNewProduct();
          newProd.productName = soDetail.productName;
          newProd.customerPo = soMaster.customerPo;
          newProd.customerMaterialNo = soDetail.customerMaterialNo;
          newProd.spec = soDetail.spec;
          newProd.orderQuantity = soDetail.quantity;
          newProd.produceQuantity = soDetail.quantity;
          newProd.deliveryDate = form.value.deliveryDate;
          newProd.packRequirement = soDetail.packReq || '';
          newProd.logisticsReq = soDetail.logisticsReq || '';

          if (soDetail.printReq) newProd.processList.push({ processName: soDetail.printReq, processDetail: '', remark: '[销售印刷要求]' });
          if (soDetail.craftReq) {
              const crafts = soDetail.craftReq.split(',').filter(Boolean);
              crafts.forEach((c: string) => newProd.processList.push({ processName: c, processDetail: '', remark: '[销售工艺要求]' }));
          }
          form.value.productList.push(newProd);
      });
      activeProductTab.value = form.value.productList[0].uid;
      proxy?.$modal.msgSuccess(`成功提取 ${details.length} 个产品！`);
  }
  dialog.title = "提取并新增多产品生产单";
  dialog.visible = true; 
};

const loadFormData = async (id: number) => {
  isDataLoading.value = true; 
  try {
    const res = await getWorkOrder(id);
    const woData = res.data as any; 
    
    form.value.id = woData.id;
    form.value.workOrderNo = woData.workOrderNo;
    form.value.customerId = String(woData.customerId);
    form.value.customerName = woData.customerName;
    form.value.deliveryDate = woData.deliveryDate;
    form.value.remark = woData.remark;
    form.value.packRequirement = woData.packRequirement;

    const flatProducts = woData.productList || woData.bizWoProductList || [];
    const flatMaterials = woData.materialList || woData.bizWoMaterialList || [];
    const flatProcesses = woData.processList || woData.bizWoProcessList || [];
    const flatOutsourcings = woData.outsourcingList || woData.bizWoOutsourcingList || [];
    const flatCtps = woData.ctpList || woData.bizWoCtpList || [];
    const flatExtras = woData.extraPurchaseList || woData.bizWoExtraPurchaseList || [];

    const nestedProducts: any[] = [];
    flatProducts.forEach((p: any) => {
       const newP = createNewProduct();
       Object.assign(newP, p);
       newP.materialList = flatMaterials.filter((m: any) => m.productName === p.productName);
       newP.processList = flatProcesses.filter((m: any) => m.productName === p.productName);
       newP.outsourcingList = flatOutsourcings.filter((m: any) => m.productName === p.productName);
       newP.ctpList = flatCtps.filter((m: any) => m.productName === p.productName);
       newP.extraPurchaseList = flatExtras.filter((m: any) => m.productName === p.productName);
       nestedProducts.push(newP);
    });

    if (nestedProducts.length === 0) nestedProducts.push(createNewProduct());
    form.value.productList = nestedProducts;
    activeProductTab.value = nestedProducts[0].uid;
    
  } finally {
    nextTick(() => { isDataLoading.value = false; });
  }
}

const submitForm = () => {
  workOrderFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      const submitData = JSON.parse(JSON.stringify(form.value));
      
      const flatMats: any[] = [];
      const flatProcs: any[] = [];
      const flatOuts: any[] = [];
      const flatCtps: any[] = [];
      const flatExtras: any[] = [];
      const productNames: string[] = [];

      for (const prod of submitData.productList) {
          if (!prod.productName) continue;
          productNames.push(prod.productName);
          
          prod.materialList.forEach((m: any) => { m.productName = prod.productName; flatMats.push(m); });
          prod.processList.forEach((m: any) => { m.productName = prod.productName; flatProcs.push(m); });
          prod.outsourcingList.forEach((m: any) => { m.productName = prod.productName; flatOuts.push(m); });
          prod.ctpList.forEach((m: any) => { m.productName = prod.productName; flatCtps.push(m); });
          prod.extraPurchaseList.forEach((m: any) => { m.productName = prod.productName; flatExtras.push(m); });
      }

      if (productNames.length === 0) {
          proxy?.$modal.msgError("请至少填写一个产品的名称！");
          buttonLoading.value = false;
          return;
      }

      submitData.productName = productNames.join(','); 
      submitData.materialList = flatMats;
      submitData.processList = flatProcs;
      submitData.outsourcingList = flatOuts;
      submitData.ctpList = flatCtps;
      submitData.extraPurchaseList = flatExtras;

      if (submitData.id) await updateWorkOrder(submitData).finally(() => buttonLoading.value = false);
      else await addWorkOrder(submitData).finally(() => buttonLoading.value = false);
      
      proxy?.$modal.msgSuccess("保存成功");
      dialog.visible = false;
      await getList();
    }
  });
};

const handleBatchToOutsourcing = (pIndex: any) => {
    const product = form.value.productList[pIndex];
    if (!product.processList || product.processList.length === 0) {
        proxy?.$modal.msgWarning("当前没有工序可以转委外！");
        return;
    }
    let transferCount = 0;
    const firstMat = product.materialList.length > 0 ? product.materialList[0] : null;

    product.processList.forEach((proc: any) => {
        if (!proc.processName) return;
        const exists = product.outsourcingList.find((item: any) => item.processProject === proc.processName);
        if (!exists) {
            product.outsourcingList.push({
                productName: product.productName,
                materialName: firstMat ? (firstMat.paperName || '') : '',
                length: firstMat ? parseSize(firstMat.paperSize, 'L') : undefined,
                width: firstMat ? parseSize(firstMat.paperSize, 'W') : undefined,
                height: undefined,
                processQty: product.produceQuantity,
                processProject: proc.processName,
                processDetail: proc.processDetail || '',
                unit: '平方米',
                unitPrice: undefined,
                totalPrice: 0,
                remark: proc.remark
            });
            transferCount++;
        }
    });

    if (transferCount > 0) {
        proxy?.$modal.msgSuccess(`神级按钮触发成功！已将 ${transferCount} 条工序全部批量转入委外！`);
    } else {
        proxy?.$modal.msgWarning("当前工序均已转过委外。");
    }
};

const handleToOutsourcing = (pIndex: any, processRow: any) => {
  const product = form.value.productList[pIndex];
  if (!processRow.processName) { proxy?.$modal.msgWarning("请先填写名称！"); return; }
  const exists = product.outsourcingList.find((item: any) => item.processProject === processRow.processName);
  if (exists) { proxy?.$modal.msgWarning(`【${processRow.processName}】已转过委外！`); return; }

  const firstMat = product.materialList.length > 0 ? product.materialList[0] : null;
  product.outsourcingList.push({
    productName: product.productName,
    materialName: firstMat ? (firstMat.paperName || '') : '',
    length: firstMat ? parseSize(firstMat.paperSize, 'L') : undefined,
    width: firstMat ? parseSize(firstMat.paperSize, 'W') : undefined,
    height: undefined,
    processQty: product.produceQuantity,
    processProject: processRow.processName,
    processDetail: processRow.processDetail || '',
    unit: '平方米',
    unitPrice: undefined,
    totalPrice: 0,
    remark: processRow.remark
  });
  proxy?.$modal.msgSuccess(`单条转委外成功！`);
};

const handleToExtraPurchase = (row: any) => {
  if (!row.paperName) { proxy?.$modal.msgWarning("请先选择或输入物料！"); return; }
  const combinedContent = `${row.partName || '材料'} - ${row.paperName}`;
  const exists = form.value.extraPurchaseList?.find((item: any) => item.itemContent === combinedContent && item.spec === row.paperSize);
  if (exists) { proxy?.$modal.msgWarning(`已存在于其它订料！`); return; }

  form.value.extraPurchaseList?.push({ itemContent: combinedContent, spec: row.paperSize || '', quantity: row.requireQty || 1, remark: '转入生成' });
  proxy?.$modal.msgSuccess("已成功转入其它订料！");
};

// 💡 修复：全方位保护数值运算的闭包
const calcTotalPrice = (row: any) => {
  const up = Number(row.unitPrice || 0); 
  const gq = Number(row.processQty || 0);
  if (!up || !gq) { row.totalPrice = 0; return; }
  if (row.unit === '平方米' && row.length && row.width) {
    const lNum = Number(row.length || 0); 
    const wNum = Number(row.width || 0);
    row.totalPrice = Number(((lNum * wNum / 1000000) * gq * up).toFixed(2));
  } else {
    row.totalPrice = Number((gq * up).toFixed(2));
  }
};

const handleOrderQtyChange = (val: any, row: any) => {
  if (val && !row.produceQuantity) { row.produceQuantity = val; calcProductTotal(row); }
};

const calcProductTotal = (prod: any) => {
  const pq = Number(prod.orderQuantity || 0);
  const up = Number(prod.unitPrice || 0);
  prod.totalAmount = (pq && up) ? Number((pq * up).toFixed(2)) : 0.00;
};

const parseSize = (sizeStr: string, type: 'L' | 'W') => {
  if (!sizeStr) return 0;
  const parts = sizeStr.toLowerCase().split(/[x*×]/);
  if (parts.length >= 2) return type === 'L' ? parseFloat(parts[0]) : parseFloat(parts[1]);
  return 0;
};

const getFilteredSuppliers = (processProject: string | undefined | null) => {
  const toArray = (val: any): string[] => { return val ? (Array.isArray(val) ? val.map(String) : String(val).split(',')) : []; };
  const options: any[] = customerOptions.value || [];
  if (!processProject) return options.filter((c: any) => { const t = toArray(c.customerType); return t.includes('2') || t.includes('3'); });
  let dictItem = rawProcessDictOptions.value.find((d: any) => d.dictLabel === processProject || d.dictValue === processProject);
  const targetCatId = dictItem?.remark?.trim(); 
  if (!targetCatId) return options.filter((c: any) => { const t = toArray(c.customerType); return t.includes('2') || t.includes('3'); });
  return options.filter((c: any) => {
    const types = toArray(c.customerType);
    let matchSupplier = types.includes('2') && toArray(c.supplierCategory || c.supplierType).includes(targetCatId);
    let matchProcessor = types.includes('3') && toArray(c.processorCategory || c.processorType).includes(targetCatId);
    return matchSupplier || matchProcessor;
  });
};

const handleMaterialChange = (val: string, row: any) => {
  if (row.sourceType === '本厂') {
    const found = rawInventoryList.value.find(i => i.itemName === val);
    if (found) {
      row.paperSize = found.spec; 
      if (row.requireQty && row.requireQty > Number(found.currentQty)) proxy?.$modal.msgWarning(`库存仅剩 ${found.currentQty}！`);
    }
  } else {
    const found = rawInventoryList.value.find(i => i.itemName === val);
    if (found && !row.paperSize) row.paperSize = found.spec;
  }
};
const checkMaterialQty = (val: any, row: any) => {
  if (row.sourceType === '本厂' && row.paperName) {
    const found = rawInventoryList.value.find(i => i.itemName === row.paperName);
    if (found) {
      const maxQty = Number(found.currentQty || 0);
      const totalRequested = form.value.productList.reduce((sum: number, p: any) => { return sum + p.materialList.filter((m: any) => m.sourceType === '本厂' && m.paperName === row.paperName).reduce((mSum: number, m: any) => mSum + Number(m.requireQty || 0), 0); }, 0);
      if (totalRequested > maxQty) proxy?.$modal.msgError(`库存不足预警！总库存为 ${maxQty}，累计需求已达 ${totalRequested}！`);
    }
  }
};

const getProcessDetailOptions = (processName: string) => {
  if (!processName) return [];
  return (rawProcessDetailOptions.value || [])
    .filter((d: any) => d.remark && d.remark.split(',').map((s: string) => s.trim()).includes(processName))
    .map((d: any) => ({ label: d.dictLabel, value: d.dictValue }));
};

const createQuerySearch = (dictRef: any) => {
  return (queryString: string, cb: any) => {
    const dict = dictRef.value || [];
    const results = queryString
      ? dict.filter((item: any) => item.label.toLowerCase().includes(queryString.toLowerCase()))
      : dict;
    cb(results.map((item: any) => ({ value: item.label })));
  };
};

const querySearchPack = createQuerySearch(erp_pack_type);
const querySearchLogistics = createQuerySearch(erp_logistics_type);
const querySearchPart = createQuerySearch(erp_item_type);

const querySearchMaterial = (queryString: string, cb: any) => {
  const list = rawInventoryList.value || [];
  const results = queryString
    ? list.filter((item: any) => item.itemName.toLowerCase().includes(queryString.toLowerCase()))
    : list;
  const seen = new Set<string>();
  const deduped = results.filter((item: any) => {
    const key = `${item.itemName}||${item.spec || ''}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
  cb(deduped.map((item: any) => ({
    value: item.itemName,
    spec: item.spec || '',
    currentQty: item.currentQty || 0
  })));
};

const getAllPrintProcessNames = () => {
  const names: string[] = [];
  (erp_print_type.value || []).forEach((d: any) => names.push(d.label));
  const categories = erp_processor_category.value || [];
  const printCategoryValues = categories
    .filter((c: any) => c.label.includes('印刷'))
    .map((c: any) => String(c.value));
  (rawProcessDictOptions.value || []).forEach((proc: any) => {
    if (proc.remark && printCategoryValues.includes(proc.remark.trim())) {
      names.push(proc.dictLabel);
    }
  });
  return names;
};

const hasPrintProcessInOutsourcing = (pIndex: any) => {
  const product = form.value.productList[pIndex];
  if (!product || !product.outsourcingList) return false;
  const printNames = getAllPrintProcessNames();
  return product.outsourcingList.some((row: any) => printNames.includes(row.processProject));
};

const isPrintRow = (row: any) => {
  if (!row || !row.processProject) return false;
  return getAllPrintProcessNames().includes(row.processProject);
};

const allOutsourcingProjects = computed(() => { const prints = erp_print_type.value || []; const processes = erp_process_name.value || []; return [...prints, ...processes]; });
const processTreeData = computed(() => {
  const tree: any[] = []; const categories = erp_processor_category.value || []; const processes = rawProcessDictOptions.value || []; const prints = erp_print_type.value || [];
  if (prints.length > 0) tree.push({ value: '印刷车间(并入)', label: '印刷车间(并入)', children: prints.map((p: any) => ({ value: p.label, label: p.label })) });
  categories.forEach((cat: any) => {
    const parentNode = { value: cat.label, label: cat.label, children: [] as any[] };
    processes.forEach((proc: any) => { if (proc.remark && proc.remark.trim() === String(cat.value)) parentNode.children.push({ value: proc.dictLabel, label: proc.dictLabel }); });
    if (parentNode.children.length > 0) tree.push(parentNode);
  });
  const unclassifiedNode = { value: '其他未分类', label: '其他工艺(未配置关联)', children: [] as any[] };
  processes.forEach((proc: any) => { if (!proc.remark || !categories.find((c: any) => String(c.value) === proc.remark.trim())) unclassifiedNode.children.push({ value: proc.dictLabel, label: proc.dictLabel }); });
  if (unclassifiedNode.children.length > 0) tree.push(unclassifiedNode);
  return tree;
});

const processTableRefs = ref<any>({});

const selectedProcessRows = reactive<Record<string, any[]>>({});

const handleProcessSelectionChange = (pIndex: any, rows: any[]) => {
  selectedProcessRows[String(pIndex)] = rows;
};

const batchProcessSelection = ref<string[]>([]);
const confirmBatchAddProcess = (pIndex: any) => {
  const product = form.value.productList[pIndex];
  if (!batchProcessSelection.value || batchProcessSelection.value.length === 0) { proxy?.$modal.msgWarning("请勾选至少一项！"); return; }
  let addedCount = 0;
  batchProcessSelection.value.forEach(processName => {
    const exists = product.processList.find((p: any) => p.processName === processName);
    if (!exists) { product.processList.push({ processName: processName, processDetail: '', remark: '' }); addedCount++; }
  });
  if (addedCount > 0) proxy?.$modal.msgSuccess(`批量生成 ${addedCount} 项明细！`);
  batchProcessSelection.value = [];
};

const transferSelectedToOutsourcing = (pIndex: any) => {
  const product = form.value.productList[pIndex];
  const rows = selectedProcessRows[String(pIndex)] || [];
  if (rows.length === 0) { proxy?.$modal.msgWarning("请先在表格左侧勾选要转委外的工序！"); return; }
  const firstMat = product.materialList.length > 0 ? product.materialList[0] : null;
  let count = 0;
  rows.forEach((proc: any) => {
    if (!proc.processName) return;
    const exists = product.outsourcingList.find((item: any) => item.processProject === proc.processName);
    if (!exists) {
      product.outsourcingList.push({
        productName: product.productName,
        materialName: firstMat ? (firstMat.paperName || '') : '',
        length: firstMat ? parseSize(firstMat.paperSize, 'L') : undefined,
        width: firstMat ? parseSize(firstMat.paperSize, 'W') : undefined,
        height: undefined,
        processQty: product.produceQuantity,
        processProject: proc.processName,
        processDetail: proc.processDetail || '',
        unit: '平方米',
        unitPrice: undefined,
        totalPrice: 0,
        remark: proc.remark
      });
      count++;
    }
  });
  if (count > 0) {
    proxy?.$modal.msgSuccess(`已将勾选的 ${count} 条工序转入委外！`);
  } else {
    proxy?.$modal.msgWarning("勾选的工序均已转过委外。");
  }
};

const handleCustomerChange = (val: any) => { const selected = customerOptions.value.find(item => String(item.id) === String(val)); if (selected) form.value.customerName = selected.companyName; };
const getCustomerList = async () => { const res = await listCustomer({ pageNum: 1, pageSize: 1000 } as any); customerOptions.value = res.rows; };
const getList = async () => { loading.value = true; const res = await listWorkOrder(queryParams.value); workOrderList.value = res.rows; total.value = res.total; loading.value = false; };
const handleAdd = () => { isView.value = false; form.value = JSON.parse(JSON.stringify(initFormData)); addProductLine(); dialog.visible = true; dialog.title = "新建生产总单"; };
const handleUpdate = async (row?: any) => { isView.value = false; await loadFormData(row.id); dialog.visible = true; dialog.title = "修改生产总单"; };
const handleView = async (row: any) => { isView.value = true; await loadFormData(row.id); dialog.visible = true; dialog.title = "查看生产总单 - " + row.workOrderNo; };
const handleDelete = async (row?: any) => { await proxy?.$modal.confirm('确认删除工单？'); await delWorkOrder(row.id); proxy?.$modal.msgSuccess("删除成功"); await getList(); };


const cancel = () => { dialog.visible = false; };
const handleAudit = (row: any) => { auditForm.value = { id: row.id, auditStatus: '2' }; auditDialog.visible = true; };
const submitAudit = async () => { await auditWorkOrder(auditForm.value); proxy?.$modal.msgSuccess("审批成功"); auditDialog.visible = false; getList(); };
const handleExportList = () => { proxy?.download('erp/workOrder/export', { ...queryParams.value }, `工单列表_${new Date().getTime()}.xlsx`) };
const handleQuery = () => { queryParams.value.pageNum = 1; getList(); };
const resetQuery = () => { queryFormRef.value?.resetFields(); handleQuery(); };

const handlePushAllOutsourcing = async (row: any) => {
  try {
    const checkRes = await request({ url: '/erp/outsourcingReceipt/list', method: 'get', params: { workOrderNo: row.workOrderNo, pageNum: 1, pageSize: 1 } }) as any;
    if (checkRes.rows && checkRes.rows.length > 0) { proxy?.$modal.msgWarning("该工单已下发过委外任务！请前往收货页查看。"); return; }
    proxy?.$modal.confirm(`确认一键下发工单【${row.workOrderNo}】？`).then(async () => {
      loading.value = true;
      const res = await getWorkOrder(row.id); const woDetail = res.data as any; const outList = woDetail.outsourcingList || woDetail.bizWoOutsourcingList || [];
      if (outList.length === 0) { proxy?.$modal.msgWarning("没有有效委外数据！"); loading.value = false; return; }
      let pushedCount = 0;
      for (const item of outList) {
        if (!item.supplierId || !item.processProject) continue; 
        const receiptData = { workOrderNo: row.workOrderNo, productName: item.productName, materialName: item.materialName, processProject: item.processProject, processDetail: item.processDetail, supplierId: item.supplierId, sentQty: item.processQty || 0, receivedQty: item.processQty || 0, priceMethod: item.unit || '张', unitPrice: item.unitPrice, totalFee: item.totalPrice, receiptDate: proxy?.parseTime(new Date(), '{y}-{m}-{d} {h}:{i}:{s}') };
        await request({ url: '/erp/workOrder/pushOutsourcing', method: 'post', data: receiptData }); pushedCount++;
      }
      loading.value = false;
      if (pushedCount > 0) proxy?.$modal.msgSuccess(`成功下发 ${pushedCount} 条委外记录！`); else proxy?.$modal.msgWarning("无数据下发。");
    }).catch(() => {});
  } catch (error) { console.error(error); loading.value = false; }
};

const digitUppercase = (n: any) => {
  let num = Number(n);
  if (num === null || num === undefined || isNaN(num)) return '零元整';
  const fraction = ['角', '分']; const digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖']; const unit = [['元', '万', '亿'], ['', '拾', '佰', '仟']]; let head = num < 0 ? '欠' : ''; num = Math.abs(num); let s = '';
  for (let i = 0; i < fraction.length; i++) { s += (digit[Math.floor(num * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, ''); } s = s || '整'; num = Math.floor(num);
  for (let i = 0; i < unit[0].length && num > 0; i++) { let p = ''; for (let j = 0; j < unit[1].length && num > 0; j++) { p = digit[num % 10] + unit[1][j] + p; num = Math.floor(num / 10); } s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s; }
  return head + s.replace(/(零.)*零元/, '元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');
};

const handlePrintFull = async (row: any) => {
  fullPrintDialog.visible = true; fullPrintDialog.loading = true;
  try {
    const res = await getPrintWorkOrder(row.id);
    fullPrintData.value = res.data;
    // 生成条形码和二维码
    await nextTick();
    const woNo = fullPrintData.value.workOrderNo || '';
    const canvas = document.getElementById('barcodeCanvas') as HTMLCanvasElement;
    JsBarcode(canvas, woNo, { format: "CODE128", displayValue: true, fontSize: 16, height: 45, margin: 0 });
    fullPrintBarcode.value = canvas.toDataURL("image/png");
    const qrText = [
      `工单号: ${woNo}`,
      `客户: ${fullPrintData.value.customerName || ''}`,
      `品名: ${fullPrintData.value.productNames || ''}`,
      `数量: ${fullPrintData.value.quantities || ''}`,
      `交期: ${fullPrintData.value.deliveryDate || ''}`
    ].join('\n');
    fullPrintQrcode.value = await QRCode.toDataURL(qrText, { width: 80, margin: 1 });
  } catch (e) { console.error(e); proxy?.$modal.msgError("加载工程单数据失败"); }
  finally { fullPrintDialog.loading = false; }
};

const formatSize = (item: any) => {
  if (!item) return '';
  if (item.length || item.width) {
    const parts = [item.length, item.width].filter(v => v !== null && v !== undefined && v !== '' && Number(v) !== 0);
    if (item.height && Number(item.height) !== 0) parts.push(item.height);
    return parts.join('*');
  }
  return item.finishSize || '';
};

const getSupplierName = (supplierId: any) => {
  if (!supplierId) return '';
  const supplier = customerOptions.value.find(c => String(c.id) === String(supplierId));
  return supplier ? (supplier.shortName || supplier.companyName) : String(supplierId);
};

const exportFullPrintExcel = () => {
  const content = document.getElementById('fullPrintArea')?.innerHTML;
  if (!content) return;
  const html = `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><meta charset="UTF-8"><style>.full-print-table { width:100%; border-collapse:collapse; font-family:"SimSun"; font-size:12px; } .full-print-table td { border:1px solid #000000; padding:4px; } .fp-label { font-weight:bold; text-align:center; background-color:#f0f0f0; } .fp-header-row { background-color:#e8e8e8; font-weight:bold; text-align:center; } .fp-section-title { font-weight:bold; font-size:14px; margin:10px 0 5px; }</style></head><body>${content}</body></html>`;
  const blob = new Blob([html], { type: 'application/vnd.ms-excel' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url; a.download = `工程单_${fullPrintData.value.workOrderNo || 'unknown'}.xls`;
  a.click(); URL.revokeObjectURL(url);
};

const doFullPrint = () => {
  const content = document.getElementById('fullPrintArea')?.innerHTML;
  if (!content) return;

  const woNo = fullPrintData.value.workOrderNo || '';
  const qrImg = fullPrintQrcode.value;
  const barcodeImg = fullPrintBarcode.value;

  const w = window.open('', '_blank');
  w?.document.write(`<html><head><title>工程单 - ${woNo}</title><style>
    body { font-family: "SimSun","Microsoft YaHei",sans-serif; padding:15px; color:#000; -webkit-print-color-adjust:exact; print-color-adjust:exact; }
    .print-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; padding-bottom:8px; border-bottom:2px solid #000; }
    .print-header .qr { width:70px; flex-shrink:0; }
    .print-header .title { flex:1; text-align:center; }
    .print-header .barcode { flex-shrink:0; text-align:right; }
    .full-print-table { width:100%; border-collapse:collapse; font-size:12px; }
    .full-print-table td { border:1px solid #000; padding:4px; }
    .fp-label { font-weight:bold; text-align:center; background-color:#f0f0f0; }
    .fp-header-row { background-color:#e8e8e8; font-weight:bold; text-align:center; }
    .fp-section-title { font-weight:bold; font-size:14px; margin:10px 0 5px; }
    @media print { body { padding:5px; } }
  </style></head><body>
    <div class="print-header">
      <div class="qr">${qrImg ? `<img src="${qrImg}" style="width:65px; height:65px;"/>` : ''}</div>
      <div class="title"><h2 style="margin:0; font-size:20px; font-weight:bold; letter-spacing:3px;">${fullPrintData.value.companyName || ''}——工程单</h2></div>
      <div class="barcode">${barcodeImg ? `<img src="${barcodeImg}" style="max-height:50px;"/>` : ''}</div>
    </div>
    ${content}
  </body></html>`);
  w?.document.close();
  setTimeout(() => { w?.print(); w?.close(); }, 300);
};

const handlePrintOutsourcing = async (row: any) => {
  try {
    const res = await getWorkOrder(row.id); const woDetail = res.data as any;
    if (!woDetail) return;
    const outList = woDetail.outsourcingList || woDetail.bizWoOutsourcingList || [];
    if (outList.length === 0) { proxy?.$modal.msgWarning("该工单暂无委外数据"); return; }

    printData.value.workOrderNo = woDetail.workOrderNo || '未知单号';
    let safeDate = '未定';
    if (woDetail.createTime) safeDate = String(woDetail.createTime).split(' ')[0].replace(/-/g, '/');
    else if (woDetail.orderDate) safeDate = String(woDetail.orderDate).split(' ')[0].replace(/-/g, '/');
    printData.value.orderDate = safeDate;
    
    const groupsMap = new Map();
    outList.forEach((item: any) => {
      const supplier = customerOptions.value.find(c => String(c.id) === String(item.supplierId));
      const supplierName = supplier ? supplier.companyName : '未知加工商';
      if (!groupsMap.has(supplierName)) groupsMap.set(supplierName, { supplierName: supplierName, supplierAddress: supplier?.companyAddress || '详见系统记录', items: [], totalAmount: 0 });
      const group = groupsMap.get(supplierName);
      group.items.push(item);
      group.totalAmount += (Number(item.totalPrice) || 0);
    });
    printData.value.groups = Array.from(groupsMap.values());
    printDialog.visible = true;
  } catch (error) { console.error(error); }
};

const exportExcel = () => {
  const printContent = document.getElementById('printArea')?.innerHTML; if (!printContent) return;
  const html = `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><meta charset="UTF-8"><style>.print-table { width: 100%; border-collapse: collapse; font-family: "SimSun"; font-size: 12px; } .print-table td { border: 1px solid #000000; text-align: center; vertical-align: middle; } .left-align { text-align: left !important; } .font-bold { font-weight: bold; } .grey-bg { background-color: #e8e8e8; } .print-page { margin-bottom: 40px; } .center-align { text-align: center; mso-number-format:"\\@"; }</style></head><body>${printContent}</body></html>`;
  const blob = new Blob([html], { type: 'application/vnd.ms-excel' }); const url = URL.createObjectURL(blob); const a = document.createElement('a');
  a.href = url; a.download = `委外单_${printData.value.workOrderNo}.xls`; a.click(); URL.revokeObjectURL(url);
};

const doPrint = () => {
  const printContent = document.getElementById('printArea')?.innerHTML; if (!printContent) return;
  const newWindow = window.open('', '_blank');
  newWindow?.document.write(`<html><head><title>打印委外加工单</title><style>body { font-family: "SimSun", "Microsoft YaHei", sans-serif; padding: 20px; } .print-page { page-break-after: always; margin-bottom: 50px; } .print-header { text-align: center; margin-bottom: 10px; position: relative; } .print-header h1 { margin: 0; font-size: 24px; padding-bottom: 10px;} .print-table { width: 100%; border-collapse: collapse; font-size: 12px; } .print-table td, .print-table th { border: 1px solid #00; padding: 6px 4px; word-break: break-all; } .grey-bg { background-color: #e8e8e8 !important; -webkit-print-color-adjust: exact; color-adjust: exact; } .center-align { text-align: center; } .left-align { text-align: left !important; } .font-bold { font-weight: bold; } .text-lg { font-size: 16px; } .memo-text { line-height: 1.5; font-size: 11px; }</style></head><body>${printContent}</body></html>`);
  newWindow?.document.close(); setTimeout(() => { newWindow?.print(); newWindow?.close(); }, 200);
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
      if (!groups[typeLabel]) groups[typeLabel] = [];
      if (!groups[typeLabel].find(i => i.itemName === item.itemName && i.spec === item.spec)) {
        groups[typeLabel].push(item);
      }
    });
    inventoryOptions.value = Object.keys(groups).map(key => ({ label: key, options: groups[key] }));
  } catch (e) { console.error(e); }
};

onMounted(() => { 
  getList(); getCustomerList(); loadInventoryData(); 
  getDicts('erp_process_name').then((res: any) => { rawProcessDictOptions.value = res.data || []; });
  getDicts('erp_process_detail').then((res: any) => { rawProcessDetailOptions.value = res.data || []; });
  if (route.query.action === 'add') { handleAdd(); }
});
</script>

<style scoped>
.hide-first-level-checkbox .el-cascader-menu:first-child .el-checkbox {
  display: none !important;
}

.full-print-table td {
  vertical-align: middle;
}
.full-print-table .fp-label {
  font-weight: bold;
  text-align: center;
  background-color: #f0f0f0;
}
.full-print-table .fp-header-row td {
  background-color: #e8e8e8;
  font-weight: bold;
  text-align: center;
}
.fp-section-title {
  font-weight: bold;
  font-size: 14px;
  margin: 12px 0 5px;
  padding: 2px 0 2px 8px;
  border-left: 3px solid #409EFF;
}
</style>