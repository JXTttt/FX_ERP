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
        <el-table-column label="客户名称" align="center" prop="customerName" min-width="150" :show-overflow-tooltip="true" />
        <el-table-column label="包含产品" align="center" prop="productName" min-width="180" :show-overflow-tooltip="true"/>
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
        <el-table-column label="操作" align="center" fixed="right" width="300">
          <template #default="scope">
            <el-button link type="success" icon="View" @click="handleView(scope.row)" v-hasPermi="['erp:workOrder:query']">查看</el-button>
            <el-button link type="warning" icon="Download" @click="handleExportRow(scope.row)" v-hasPermi="['erp:workOrder:export']">导出</el-button>
            
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
          <el-col :span="8">
            <el-form-item label="选择客户" prop="customerId">
              <el-select v-model="form.customerId" placeholder="请选择客户(必填)" filterable style="width: 100%" @change="handleCustomerChange">
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="交货日期" prop="deliveryDate">
              <el-date-picker clearable v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择交货日期" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="生产工艺" prop="processOptions">
              <el-cascader
                v-model="form.processOptions"
                :options="processTreeData"
                :props="{ multiple: true, emitPath: true }"
                clearable
                filterable
                placeholder="请选择所需工艺(支持多级多选)"
                style="width: 100%"
              />
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
              <el-input-number v-model="scope.row.orderQuantity" :min="1" style="width: 100%" @change="(val) => handleOrderQtyChange(val, scope.row)" />
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
              <el-table-column label="部件" width="120"><template #default="scope"><el-input v-model="scope.row.partName" /></template></el-table-column>
              <el-table-column label="来源" width="120">
                <template #default="scope">
                  <el-select v-model="scope.row.sourceType" placeholder="来源">
                    <el-option label="自来" value="自来" /><el-option label="订购" value="订购" /><el-option label="本厂" value="本厂" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="纸张名称" min-width="150"><template #default="scope"><el-input v-model="scope.row.paperName" placeholder="如:300克白卡"/></template></el-table-column>
              <el-table-column label="纸张尺寸" width="150"><template #default="scope"><el-input v-model="scope.row.paperSize" placeholder="如:545*800" /></template></el-table-column>
              <el-table-column label="数量(张)" width="120"><template #default="scope"><el-input-number v-model="scope.row.requireQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="切成" width="120"><template #default="scope"><el-input v-model="scope.row.cutMethod" /></template></el-table-column>
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
            <el-table :data="form.processList" border size="small">
              <el-table-column label="工序名称" width="200">
                <template #default="scope">
                  <el-tag type="info" size="large">{{ scope.row.processName }}</el-tag>
                </template>
              </el-table-column>
              <el-table-column label="工艺要求/备注" min-width="200">
                <template #default="scope"><el-input v-model="scope.row.remark" placeholder="请输入具体要求" /></template>
              </el-table-column>
              <el-table-column label="操作" width="150" align="center" v-if="!isView">
                <template #default="scope">
                  <el-button type="primary" link icon="Position" @click="handleToOutsourcing(scope.row)">一键转委外单</el-button>
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
                    <el-option label="单面" value="单面" /><el-option label="正反" value="正反" /><el-option label="自反" value="自反" /><el-option label="天地反" value="天地反" />
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
              
              <el-table-column label="加工工序" width="150">
                <template #default="scope">
                  <el-cascader v-model="scope.row.processProjectArray" :options="processTreeData" :props="{ emitPath: true }" clearable style="width: 100%" />
                </template>
              </el-table-column>
              
              <el-table-column label="加工商" width="160">
                <template #default="scope">
                  <el-select v-model="scope.row.supplierId" placeholder="智能匹配" filterable>
                    <el-option v-for="item in getFilteredSuppliers(scope.row.processProjectArray)" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
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

  </div>
</template>

<script setup name="WorkOrder" lang="ts">
import { listWorkOrder, getWorkOrder, delWorkOrder, addWorkOrder, updateWorkOrder, auditWorkOrder } from '@/api/erp/workOrder';
import { listCustomer } from '@/api/erp/customer';
import { ComponentInternalInstance, computed, onMounted, reactive, ref, toRefs, watch, getCurrentInstance, nextTick } from 'vue';
import { ElForm } from 'element-plus';

type ElFormInstance = InstanceType<typeof ElForm>;

interface DialogOption {
  visible: boolean;
  title: string;
}

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const workOrderList = ref([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const isView = ref(false);
const isDataLoading = ref(false); 

const customerOptions = ref<any[]>([]); 
const queryFormRef = ref<ElFormInstance>();
const workOrderFormRef = ref<ElFormInstance>();
const dialog = reactive<DialogOption>({ visible: false, title: '' });

// 审批弹窗变量
const auditDialog = reactive({ visible: false });
const auditForm = ref({ id: undefined, auditStatus: '2' });

const processTreeData = [
  { 
    value: '表面处理', label: '表面处理', supplierCat: '2', 
    children: [ 
      {value: '过哑胶', label: '过哑胶'}, 
      {value: '过光胶', label: '过光胶'}, 
      {value: '烫金', label: '烫金'}, 
      {value: '击凸', label: '击凸'},
      {value: '压凹', label: '压凹'}, 
      {value: '压纹', label: '压纹'},
      {value: 'UV', label: 'UV'},
      {value: '覆膜', label: '覆膜'},
      {value: '局部UV', label: '局部UV'},
      {value: '哑油', label: '哑油'},
      {value: '光油（普通）', label: '光油（普通）'},
      {value: '高光油', label: '高光油'}
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
  processOptions: [], 
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
  const res = await listCustomer({ pageNum: 1, pageSize: 1000 });
  customerOptions.value = res.rows;
};
const handleCustomerChange = (val: any) => {
  const selected = customerOptions.value.find(item => String(item.id) === String(val));
  if (selected) form.value.customerName = selected.companyName;
};

const calcProductTotal = (row: any) => {
  if (row.produceQuantity && row.unitPrice) {
    row.totalAmount = Number((row.produceQuantity * row.unitPrice).toFixed(2));
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
  return form.value.productList.reduce((sum: number, item: any) => sum + (item.orderQuantity || 0), 0);
});

const totalProduceQty = computed(() => {
  if (!form.value.productList) return 0;
  return form.value.productList.reduce((sum: number, item: any) => sum + (item.produceQuantity || 0), 0);
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
  if (!row.unitPrice || !row.goodQty) { row.totalPrice = 0; return; }
  if (row.priceMethod === '平方米' && row.length && row.width) {
    row.totalPrice = Number(((row.length * row.width / 1000000) * row.goodQty * row.unitPrice).toFixed(2));
  } else {
    row.totalPrice = Number((row.goodQty * row.unitPrice).toFixed(2));
  }
};

const getFilteredSuppliers = (processArray: string[]) => {
  if (!processArray || processArray.length === 0) return customerOptions.value.filter(c => c.customerType === '2');
  const majorCategory = processArray[0];
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
  if (!newVal || newVal === 0) return;
  if (form.value.materialList.length === 0) {
    let extraFace = Math.floor((newVal - 1) / 66);
    let faceQty = newVal + 101 + extraFace;
    let extraPit = Math.floor((newVal - 1) / 100);
    let pitQty = newVal + 1 + extraPit;

    form.value.materialList.push({ partName: '面纸', sourceType: '自来', requireQty: faceQty });
    form.value.materialList.push({ partName: '坑纸', sourceType: '自来', requireQty: pitQty });
    proxy?.$modal.msgSuccess("已根据总订单数量自动推算纸张数量！");
  }
});

watch(() => form.value.processOptions, (newVal) => {
  if (isDataLoading.value) return; 
  if (!newVal) return;
  const newSigs = newVal.map((path: string[]) => path.join(' - '));
  form.value.processList = form.value.processList.filter((row: any) => newSigs.includes(row.processName));
  const oldSigs = form.value.processList.map((row: any) => row.processName);
  newVal.forEach((path: string[]) => {
    const sig = path.join(' - ');
    if (!oldSigs.includes(sig)) {
      form.value.processList.push({ processName: sig, processPath: path, remark: '' });
    }
  });
}, { deep: true });

const handleToOutsourcing = (processRow: any) => {
  const exists = form.value.outsourcingList.find((item: any) => item.processProject === processRow.processName);
  if (exists) { proxy?.$modal.msgWarning(`【${processRow.processName}】已转过委外！`); return; }

  const firstMat = form.value.materialList.length > 0 ? form.value.materialList[0] : null;
  form.value.outsourcingList.push({
    productName: combinedProductNames.value, 
    materialName: firstMat ? firstMat.paperName : '',
    length: firstMat ? parseSize(firstMat.paperSize, 'L') : 0,
    width: firstMat ? parseSize(firstMat.paperSize, 'W') : 0,
    materialQty: firstMat ? firstMat.requireQty : 0,
    processProjectArray: processRow.processPath, 
    processProject: processRow.processName, 
    goodQty: totalProduceQty.value, 
    priceMethod: '平方米', 
    unitPrice: undefined,
    totalPrice: 0,
    remark: processRow.remark
  });
  proxy?.$modal.msgSuccess(`转委外成功！已自动智能匹配供应商，请填写加工单价。`);
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

// 打开审批弹窗
const handleAudit = (row: any) => {
  auditForm.value = { id: row.id, auditStatus: '2' };
  auditDialog.visible = true;
};

// 提交审批结果
const submitAudit = async () => {
  await auditWorkOrder(auditForm.value);
  proxy?.$modal.msgSuccess("审批操作成功");
  auditDialog.visible = false;
  getList(); // 刷新列表
};

const loadFormData = async (id: number) => {
  isDataLoading.value = true; 
  try {
    form.value = JSON.parse(JSON.stringify(initFormData));
    const res = await getWorkOrder(id);
    Object.assign(form.value, res.data);

    if (form.value.customerId) {
      form.value.customerId = String(form.value.customerId);
    }

    ['productList', 'materialList', 'ctpList', 'printList', 'processList', 'outsourcingList'].forEach(key => { if(!form.value[key]) form.value[key] = []; });
    
    if(form.value.processList && form.value.processList.length > 0){
        form.value.processOptions = form.value.processList.map((item: any) => {
           return item.processName ? item.processName.split(' - ') : [];
        });
    }

    if(form.value.outsourcingList && form.value.outsourcingList.length > 0){
        form.value.outsourcingList.forEach((item: any) => {
           if (item.processProject) item.processProjectArray = item.processProject.split(' - ');
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

      buttonLoading.value = true;
      form.value.outsourcingList.forEach((item: any) => {
         if(Array.isArray(item.processProjectArray)) {
             item.processProject = item.processProjectArray.join(' - ');
         }
      });

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

onMounted(() => { getList(); getCustomerList(); });
</script>