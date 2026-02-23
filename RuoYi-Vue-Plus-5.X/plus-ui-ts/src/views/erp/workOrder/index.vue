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
            <el-form-item label="产品名称" prop="productName">
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
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>
      <el-table v-loading="loading" border :data="workOrderList">
        <el-table-column type="index" width="55" align="center" label="序号" />
        <el-table-column label="工单编号" align="center" prop="workOrderNo" width="130" />
        <el-table-column label="客户名称" align="center" prop="customerName" min-width="150" :show-overflow-tooltip="true" />
        <el-table-column label="客户PO号" align="center" prop="customerPo" width="120" />
        <el-table-column label="产品名称" align="center" prop="productName" min-width="150" :show-overflow-tooltip="true"/>
        <el-table-column label="订单数量" align="center" prop="orderQuantity" />
        <el-table-column label="生产数量" align="center" prop="produceQuantity" />
        <el-table-column label="交货日期" align="center" prop="deliveryDate" width="120">
          <template #default="scope">
            <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right" width="150">
          <template #default="scope">
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:workOrder:edit']">修改</el-button>
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:workOrder:remove']">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="95%" append-to-body>
      <el-form ref="workOrderFormRef" :model="form" :rules="rules" label-width="110px">
        
        <el-divider content-position="left">基础业务信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="选择客户" prop="customerId">
              <el-select v-model="form.customerId" placeholder="请选择客户(必填)" filterable style="width: 100%" @change="handleCustomerChange">
                <el-option v-for="item in customerOptions" :key="item.id" :label="item.companyName" :value="item.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="客户PO号" prop="customerPo">
              <el-input v-model="form.customerPo" placeholder="请输入客户PO号" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="客户物料号" prop="customerMaterialNo">
              <el-input v-model="form.customerMaterialNo" placeholder="请输入客户物料号" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="产品名称" prop="productName">
              <el-input v-model="form.productName" placeholder="请输入产品名称(必填)" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="规格" prop="spec">
              <el-input v-model="form.spec" placeholder="请输入规格" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
             <el-form-item label="层数" prop="layers">
              <el-select v-model="form.layers" placeholder="请选择层数" style="width: 100%" allow-create filterable>
                <el-option label="单E" value="单E" />
                <el-option label="单B" value="单B" />
                <el-option label="EE" value="EE" />
                <el-option label="BB" value="BB" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="订单数量" prop="orderQuantity">
              <el-input-number v-model="form.orderQuantity" :min="1" style="width: 100%" placeholder="输入触发自动计算" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="生产数量" prop="produceQuantity">
              <el-input-number v-model="form.produceQuantity" :min="1" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="单位" prop="unit">
              <el-input v-model="form.unit" placeholder="例: 个/张/本" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="交货日期" prop="deliveryDate">
              <el-date-picker clearable v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择交货日期" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="单价" prop="unitPrice">
              <el-input-number v-model="form.unitPrice" :precision="4" :step="0.1" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="刀版号" prop="knifePlateNo">
              <el-input v-model="form.knifePlateNo" placeholder="请输入刀版号" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="生产工艺" prop="processOptions">
              <el-cascader
                v-model="form.processOptions"
                :options="processTreeData"
                :props="{ multiple: true, emitPath: true }"
                clearable
                filterable
                placeholder="请选择所需工艺(支持多级多选)，选中自动生成明细"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-tabs type="border-card" class="mt-4">
          <el-tab-pane label="材料清单">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('materialList')">添加材料</el-button></div>
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
              <el-table-column label="操作" width="70" align="center"><template #default="scope"><el-button link type="danger" @click="removeLine('materialList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>

          

          <el-tab-pane label="印刷加工">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('printList')">添加印刷记录</el-button></div>
            <el-table :data="form.printList" border size="small">
              <el-table-column label="机号" width="120"><template #default="scope"><el-input v-model="scope.row.machineNo" /></template></el-table-column>
              <el-table-column label="颜色" width="120"><template #default="scope"><el-input v-model="scope.row.printColor" placeholder="4C/1C" /></template></el-table-column>
              <el-table-column label="模数" width="120"><template #default="scope"><el-input v-model="scope.row.moldNum" placeholder="3+1等" /></template></el-table-column>
              <el-table-column label="实印数"><template #default="scope"><el-input-number v-model="scope.row.actualPrintQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="损耗数"><template #default="scope"><el-input-number v-model="scope.row.lossQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="操作" width="70" align="center"><template #default="scope"><el-button link type="danger" @click="removeLine('printList', scope.$index)">移除</el-button></template></el-table-column>
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
              <el-table-column label="操作" width="150" align="center">
                <template #default="scope">
                  <el-button type="primary" link icon="Position" @click="handleToOutsourcing(scope.row)">一键转委外单</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-tab-pane>

          <el-tab-pane label="模具制版">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('ctpList')">添加CTP</el-button></div>
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
              <el-table-column label="操作" width="70" align="center"><template #default="scope"><el-button link type="danger" @click="removeLine('ctpList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>
          <el-tab-pane label="委外加工单">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addLine('outsourcingList')">手动添加外发</el-button></div>
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
                    <el-option v-for="item in getFilteredSuppliers(scope.row.processProjectArray)" :key="item.id" :label="item.companyName" :value="item.id" />
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
              <el-table-column label="操作" width="70" align="center" fixed="right"><template #default="scope"><el-button link type="danger" @click="removeLine('outsourcingList', scope.$index)">移除</el-button></template></el-table-column>
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
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定 保 存</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="WorkOrder" lang="ts">
import { listWorkOrder, getWorkOrder, delWorkOrder, addWorkOrder, updateWorkOrder } from '@/api/erp/workOrder';
import { listCustomer } from '@/api/erp/customer';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const workOrderList = ref([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const customerOptions = ref<any[]>([]); 
const queryFormRef = ref<ElFormInstance>();
const workOrderFormRef = ref<ElFormInstance>();
const dialog = reactive<DialogOption>({ visible: false, title: '' });

// 树状工艺字典配置 (配置了与客户供应商表中 supplier_category 的对应关系)
const processTreeData = [
  { 
    value: '表面处理', label: '表面处理', supplierCat: '2',
    children: [ {value: '过哑胶', label: '过哑胶'}, {value: '过光胶', label: '过光胶'}, {value: '烫金', label: '烫金'}, {value: '击凸', label: '击凸'} ]
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
  id: undefined, customerId: undefined, customerName: undefined, productName: undefined,
  orderQuantity: undefined, produceQuantity: undefined, deliveryDate: undefined,
  packRequirement: undefined, remark: undefined, // 回归的字段
  unit: '个', customerPo: undefined, customerMaterialNo: undefined, spec: undefined, layers: undefined, knifePlateNo: undefined, unitPrice: undefined,
  processOptions: [], // 级联多选结果
  materialList: [], ctpList: [], processList: [], outsourcingList: [], printList: []
};

const data = reactive<PageData<any, any>>({
  form: { ...initFormData },
  queryParams: { pageNum: 1, pageSize: 10 },
  rules: {
    customerId: [{ required: true, message: "客户必须选择", trigger: "change" }],
    productName: [{ required: true, message: "产品名称不能为空", trigger: "blur" }]
  }
});
const { queryParams, form, rules } = toRefs(data);

const getCustomerList = async () => {
  const res = await listCustomer({ pageNum: 1, pageSize: 1000 });
  customerOptions.value = res.rows;
};
const handleCustomerChange = (val: any) => {
  const selected = customerOptions.value.find(item => item.id === val);
  if (selected) form.value.customerName = selected.companyName;
};

// 解析长宽
const parseSize = (sizeStr: string, type: 'L' | 'W') => {
  if (!sizeStr) return 0;
  const parts = sizeStr.toLowerCase().split(/[x*×]/);
  if (parts.length >= 2) return type === 'L' ? parseFloat(parts[0]) : parseFloat(parts[1]);
  return 0;
};

// 智能算价公式
const calcTotalPrice = (row: any) => {
  if (!row.unitPrice || !row.goodQty) { row.totalPrice = 0; return; }
  if (row.priceMethod === '平方米' && row.length && row.width) {
    row.totalPrice = Number(((row.length * row.width / 1000000) * row.goodQty * row.unitPrice).toFixed(2));
  } else {
    row.totalPrice = Number((row.goodQty * row.unitPrice).toFixed(2));
  }
};

// 智能匹配供应商列表过滤
const getFilteredSuppliers = (processArray: string[]) => {
  if (!processArray || processArray.length === 0) return customerOptions.value.filter(c => c.customerType === '2');
  
  const majorCategory = processArray[0];
  const treeNode = processTreeData.find(item => item.value === majorCategory);
  
  if (!treeNode || !treeNode.supplierCat) return customerOptions.value.filter(c => c.customerType === '2');

  const reqCat = treeNode.supplierCat;
  
  return customerOptions.value.filter(c => {
    if (c.customerType !== '2') return false; 
    if (!c.supplierCategory) return false;
    const catArray = typeof c.supplierCategory === 'string' ? c.supplierCategory.split(',') : c.supplierCategory;
    return catArray.includes(reqCat);
  });
};

// 监听订单数量自动计算纸张
watch(() => form.value.orderQuantity, (newVal) => {
  if (!newVal) return;
  
  if(!form.value.produceQuantity) {
     form.value.produceQuantity = newVal;
  }

  if (form.value.materialList.length === 0) {
    let extraFace = Math.floor((newVal - 1) / 66);
    let faceQty = newVal + 101 + extraFace;

    let extraPit = Math.floor((newVal - 1) / 100);
    let pitQty = newVal + 1 + extraPit;

    form.value.materialList.push({ partName: '面纸', sourceType: '自来', requireQty: faceQty });
    form.value.materialList.push({ partName: '坑纸', sourceType: '自来', requireQty: pitQty });
    
    proxy?.$modal.msgSuccess("已自动推算纸张数量！");
  }
});

// 监听工艺级联框，动态生成工艺表
watch(() => form.value.processOptions, (newVal) => {
  if (!newVal) return;
  const newSigs = newVal.map((path: string[]) => path.join(' - '));
  form.value.processList = form.value.processList.filter(row => newSigs.includes(row.processName));
  const oldSigs = form.value.processList.map(row => row.processName);
  newVal.forEach((path: string[]) => {
    const sig = path.join(' - ');
    if (!oldSigs.includes(sig)) {
      form.value.processList.push({ processName: sig, processPath: path, remark: '' });
    }
  });
}, { deep: true });

// 一键转委外逻辑
const handleToOutsourcing = (processRow: any) => {
  const exists = form.value.outsourcingList.find(item => item.processProject === processRow.processName);
  if (exists) { proxy?.$modal.msgWarning(`【${processRow.processName}】已转过委外！`); return; }

  const firstMat = form.value.materialList.length > 0 ? form.value.materialList[0] : null;

  form.value.outsourcingList.push({
    productName: form.value.productName,
    materialName: firstMat ? firstMat.paperName : '',
    length: firstMat ? parseSize(firstMat.paperSize, 'L') : 0,
    width: firstMat ? parseSize(firstMat.paperSize, 'W') : 0,
    materialQty: firstMat ? firstMat.requireQty : 0,
    processProjectArray: processRow.processPath, 
    processProject: processRow.processName, 
    goodQty: form.value.produceQuantity,
    priceMethod: '平方米', 
    unitPrice: undefined,
    totalPrice: 0,
    remark: processRow.remark
  });
  proxy?.$modal.msgSuccess(`转委外成功！已自动智能匹配供应商，请填写加工单价。`);
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
const cancel = () => { form.value = { ...initFormData }; dialog.visible = false; };
const handleQuery = () => { queryParams.value.pageNum = 1; getList(); };
const resetQuery = () => { queryFormRef.value?.resetFields(); handleQuery(); };

const handleAdd = () => {
  form.value = { ...initFormData };
  form.value.processOptions = []; form.value.materialList = []; form.value.ctpList = []; form.value.printList = []; form.value.processList = []; form.value.outsourcingList = [];
  dialog.visible = true; dialog.title = "新建生产工单";
};

const handleUpdate = async (row?: any) => {
  form.value = { ...initFormData };
  const res = await getWorkOrder(row.id);
  Object.assign(form.value, res.data);
  ['materialList', 'ctpList', 'printList', 'processList', 'outsourcingList'].forEach(key => { if(!form.value[key]) form.value[key] = []; });
  
  if(form.value.processList && form.value.processList.length > 0){
      form.value.processOptions = form.value.processList.map(item => item.processPath || item.processName.split(' - '));
  }
  
  dialog.visible = true; dialog.title = "修改生产工单";
};

const submitForm = () => {
  workOrderFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      form.value.outsourcingList.forEach(item => {
         if(Array.isArray(item.processProjectArray)) {
             item.processProject = item.processProjectArray.join(' - ');
         }
      });

      if (form.value.id) await updateWorkOrder(form.value).finally(() => buttonLoading.value = false);
      else await addWorkOrder(form.value).finally(() => buttonLoading.value = false);
      
      proxy?.$modal.msgSuccess("保存成功");
      dialog.visible = false;
      await getList();
    }
  });
};

const handleDelete = async (row?: any) => {
  await proxy?.$modal.confirm('确认删除？');
  await delWorkOrder(row.id);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
};

onMounted(() => { getList(); getCustomerList(); });
</script>