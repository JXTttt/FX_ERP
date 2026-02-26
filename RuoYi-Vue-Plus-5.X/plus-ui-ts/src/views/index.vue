<template>
  <div class="app-container home-dashboard">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="8" :md="6" :lg="5">
        <div class="left-panel">
          <div class="profile-card">
            <div class="avatar-box">
              <el-avatar :size="100" :src="userStore.avatar" />
            </div>
            <div class="user-info">
              <p>用户昵称: <strong>{{ userStore.nickname }}</strong></p>
            </div>
          </div>

          <div class="digital-clock">
            {{ currentTime }}
          </div>

          <div class="mini-calendar">
            <div class="calendar-header">
              《 {{ currentDateStr }} 》
            </div>
            <el-calendar v-model="currentDate" />
          </div>
        </div>
      </el-col>

      <el-col :xs="24" :sm="16" :md="18" :lg="19">
        <div class="right-panel">
          
          <div class="section-block">
            <div class="section-title">快捷操作</div>
            <div class="shortcut-grid">
              <div class="shortcut-item" @click="openWoDialog">
                <div class="icon-box"><svg-icon icon-class="form" class="svg-icon" /></div>
                <span>添加生产单</span>
              </div>
              <div class="shortcut-item" @click="goTo('/workOrder')">
                <div class="icon-box"><svg-icon icon-class="documentation" class="svg-icon" /></div>
                <span>生产工单</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="chart" class="svg-icon" /></div>
                <span>生产报表</span>
              </div>
              <div class="shortcut-item" @click="goTo('/inventory')">
                <div class="icon-box"><svg-icon icon-class="dict" class="svg-icon" /></div>
                <span>库存管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="money" class="svg-icon" /></div>
                <span>支出开销</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="cascader" class="svg-icon" /></div>
                <span>查看账务</span>
              </div>
              <div class="shortcut-item" @click="openCustomerDialog">
                <div class="icon-box"><svg-icon icon-class="peoples" class="svg-icon" /></div>
                <span>添加新客户</span>
              </div>
              <div class="shortcut-item" @click="goTo('/customer')">
                <div class="icon-box"><svg-icon icon-class="users" class="svg-icon" /></div>
                <span>客户管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/system/user')">
                <div class="icon-box"><svg-icon icon-class="user" class="svg-icon" /></div>
                <span>职员管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/system/notice')">
                <div class="icon-box"><svg-icon icon-class="message" class="svg-icon" /></div>
                <span>新闻动态</span>
              </div>
            </div>
          </div>

          <div class="section-block">
            <div class="section-title">等待处理</div>
            <ul class="task-list">
              <li>
                <span class="dot">•</span>
                <span class="highlight-num">0</span> 笔开立需要审核
                <el-icon class="star-icon"><StarFilled /></el-icon>
              </li>
            </ul>
          </div>

          <div class="section-block">
            <div class="section-title">管理反馈</div>
            <ul class="task-list">
              <li>
                <span class="dot">•</span>
                <span class="highlight-num">0</span> 笔送货单全额为0元
                <el-icon class="star-icon"><StarFilled /></el-icon>
              </li>
            </ul>
          </div>

          <div class="section-block">
            <div class="section-title">新闻动态</div>
            <div class="news-alert">
              <el-alert
                title="暂无最新新闻动态"
                type="info"
                show-icon
                :closable="false"
              />
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-dialog title="添加客户及供应商" v-model="customerDialog.visible" width="800px" append-to-body>
      <el-form ref="customerFormRef" :model="customerForm" :rules="customerRules" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="客户公司全称" prop="companyName">
              <el-input v-model="customerForm.companyName" placeholder="请输入客户公司全称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户编码" prop="customerCode">
              <el-input v-model="customerForm.customerCode" placeholder="系统唯一标识" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="简称/全称" prop="shortName">
              <el-input v-model="customerForm.shortName" placeholder="请输入客户简称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户类型" prop="customerType">
              <el-select v-model="customerForm.customerType" placeholder="请选择类型" style="width: 100%">
                <el-option label="普通客户" value="1" />
                <el-option label="供应商" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系人" prop="contactPerson">
              <el-input v-model="customerForm.contactPerson" placeholder="请输入首要联系人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="customerForm.contactPhone" placeholder="请输入手机号" />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-divider content-position="left">公司地址信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="详细地址" prop="companyAddress">
              <el-input v-model="customerForm.companyAddress" placeholder="请输入街道/门牌号等" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">其他信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-form-item label="银行账户" prop="bankAccountInfo">
              <el-input v-model="customerForm.bankAccountInfo" placeholder="例:工行 张三 6212..." />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitCustomerForm">确 定 保 存</el-button>
          <el-button @click="customerDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="新建生产工单" v-model="woDialog.visible" width="95%" append-to-body>
      <el-form ref="woFormRef" :model="woForm" :rules="woRules" label-width="110px">
        <el-divider content-position="left">基础业务信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="选择客户" prop="customerId">
              <el-select v-model="woForm.customerId" placeholder="请选择客户(必填)" filterable style="width: 100%" @change="handleCustomerChange">
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="交货日期" prop="deliveryDate">
              <el-date-picker clearable v-model="woForm.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择交货日期" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="生产工艺" prop="processOptions">
              <el-cascader
                v-model="woForm.processOptions"
                :options="processTreeData"
                :props="{ multiple: true, emitPath: true }"
                clearable filterable placeholder="请选择所需工艺(支持多级多选)" style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">产品明细</el-divider>
        <div class="mb-2">
          <el-button type="primary" plain icon="Plus" size="small" @click="addWoProductLine">添加产品</el-button>
        </div>
        <el-table :data="woForm.productList" border size="small" style="margin-bottom: 20px;">
          <el-table-column type="index" width="50" align="center" label="序号" />
          <el-table-column label="产品名称(必填)" min-width="150">
            <template #default="scope"><el-input v-model="scope.row.productName" placeholder="产品名称" /></template>
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
          <el-table-column label="单价" width="110">
            <template #default="scope">
              <el-input-number v-model="scope.row.unitPrice" :precision="4" :step="0.1" :min="0" :controls="false" style="width: 100%" @change="calcProductTotal(scope.row)" />
            </template>
          </el-table-column>
          <el-table-column label="总金额" width="100">
            <template #default="scope"><el-input v-model="scope.row.totalAmount" disabled /></template>
          </el-table-column>
          <el-table-column label="操作" width="70" align="center" fixed="right">
            <template #default="scope">
              <el-button link type="danger" @click="removeWoLine('productList', scope.$index)">移除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-tabs type="border-card">
          <el-tab-pane label="材料清单">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addWoLine('materialList')">添加材料</el-button></div>
            <el-table :data="woForm.materialList" border size="small">
              <el-table-column label="部件" width="120"><template #default="scope"><el-input v-model="scope.row.partName" /></template></el-table-column>
              <el-table-column label="来源" width="120">
                <template #default="scope">
                  <el-select v-model="scope.row.sourceType" placeholder="来源">
                    <el-option label="自来" value="自来" /><el-option label="订购" value="订购" /><el-option label="本厂" value="本厂" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="纸张名称" min-width="150"><template #default="scope"><el-input v-model="scope.row.paperName" /></template></el-table-column>
              <el-table-column label="纸张尺寸" width="150"><template #default="scope"><el-input v-model="scope.row.paperSize" /></template></el-table-column>
              <el-table-column label="数量(张)" width="120"><template #default="scope"><el-input-number v-model="scope.row.requireQty" :min="0" style="width: 100%" /></template></el-table-column>
              <el-table-column label="操作" width="70" align="center"><template #default="scope"><el-button link type="danger" @click="removeWoLine('materialList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>

          <el-tab-pane label="生产工艺明细">
            <el-table :data="woForm.processList" border size="small">
              <el-table-column label="工序名称" width="200">
                <template #default="scope"><el-tag type="info" size="large">{{ scope.row.processName }}</el-tag></template>
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

          <el-tab-pane label="委外加工单">
            <div class="mb-2"><el-button type="primary" plain icon="Plus" size="small" @click="addWoLine('outsourcingList')">手动添加外发</el-button></div>
            <el-table :data="woForm.outsourcingList" border size="small" style="width: 100%;" overflow-x="auto">
              <el-table-column label="产品名称" width="150" fixed="left"><template #default="scope"><el-input v-model="scope.row.productName" /></template></el-table-column>
              <el-table-column label="材料名称" width="150"><template #default="scope"><el-input v-model="scope.row.materialName" /></template></el-table-column>
              <el-table-column label="长(mm)" width="100"><template #default="scope"><el-input-number v-model="scope.row.length" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              <el-table-column label="宽(mm)" width="100"><template #default="scope"><el-input-number v-model="scope.row.width" :controls="false" style="width: 100%" @change="calcTotalPrice(scope.row)"/></template></el-table-column>
              
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
              <el-table-column label="操作" width="70" align="center" fixed="right"><template #default="scope"><el-button link type="danger" @click="removeWoLine('outsourcingList', scope.$index)">移除</el-button></template></el-table-column>
            </el-table>
          </el-tab-pane>
        </el-tabs>

        <el-row class="mt-4">
           <el-col :span="24">
            <el-form-item label="包装要求" prop="packRequirement">
              <el-input v-model="woForm.packRequirement" type="textarea" :rows="2" placeholder="请输入包装要求" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="工单备注" prop="remark">
              <el-input v-model="woForm.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitWoForm">确 定 保 存</el-button>
          <el-button @click="woDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup name="Index" lang="ts">
import { ref, onMounted, onUnmounted, computed, reactive, watch, getCurrentInstance } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/store/modules/user';
import { StarFilled } from '@element-plus/icons-vue';
import type { ComponentInternalInstance } from 'vue';
import type { ElForm } from 'element-plus';

// API 导入
import { addWorkOrder } from '@/api/erp/workOrder';
import { listCustomer, addCustomer } from '@/api/erp/customer';

type ElFormInstance = InstanceType<typeof ElForm>;
const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const router = useRouter();
const userStore = useUserStore();
const buttonLoading = ref(false);
const isDataLoading = ref(false); 

// ================= 时间相关 =================
const currentTime = ref('');
const currentDateStr = ref('');
const currentDate = ref(new Date());
let timer: any = null;

const updateTime = () => {
  const now = new Date();
  currentTime.value = now.toLocaleTimeString('en-US', { hour12: false });
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  currentDateStr.value = `${year}年${month}月${day}日`;
};

// ================= 路由跳转 =================
const goTo = (path: string) => {
  router.push(path);
};

// ================= 客户下拉框公用 =================
const customerOptions = ref<any[]>([]); 
const getCustomerList = async () => {
  const res = await listCustomer({ pageNum: 1, pageSize: 1000 });
  customerOptions.value = res.rows;
};

// ================= 添加客户相关逻辑 =================
const customerDialog = reactive({ visible: false });
const customerFormRef = ref<ElFormInstance>();
const customerForm = ref({
  companyName: undefined,
  customerCode: undefined,
  shortName: undefined,
  customerType: '1',
  contactPerson: undefined,
  contactPhone: undefined,
  companyAddress: undefined,
  bankAccountInfo: undefined
});
const customerRules = {
  companyName: [{ required: true, message: "客户公司全称不能为空", trigger: "blur" }],
  customerCode: [{ required: true, message: "客户编码不能为空", trigger: "blur" }]
};

const openCustomerDialog = () => {
  customerForm.value = {
    companyName: undefined, customerCode: undefined, shortName: undefined, customerType: '1',
    contactPerson: undefined, contactPhone: undefined, companyAddress: undefined, bankAccountInfo: undefined
  };
  customerDialog.visible = true;
};

const submitCustomerForm = () => {
  customerFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      try {
        await addCustomer(customerForm.value);
        proxy?.$modal.msgSuccess("客户添加成功");
        customerDialog.visible = false;
        // 修复路由：添加成功后，跳转到顶层的客户列表页
        router.push('/customer');
      } finally {
        buttonLoading.value = false;
      }
    }
  });
};

// ================= 添加工单相关逻辑 =================
const woDialog = reactive({ visible: false });
const woFormRef = ref<ElFormInstance>();

const processTreeData = [
  { value: '表面处理', label: '表面处理', supplierCat: '2', 
    children: [ 
      {value: '过哑胶', label: '过哑胶'}, {value: '过光胶', label: '过光胶'}, 
      {value: '烫金', label: '烫金'}, {value: '击凸', label: '击凸'},
      {value: '压凹', label: '压凹'}, {value: '压纹', label: '压纹'},
      {value: 'UV', label: 'UV'}, {value: '覆膜', label: '覆膜'},
      {value: '局部UV', label: '局部UV'}, {value: '哑油', label: '哑油'},
      {value: '光油（普通）', label: '光油（普通）'}, {value: '高光油', label: '高光油'}
    ]
  },
  { value: '模切', label: '模切(啤机)', supplierCat: '3', children: [ {value: '普通模切', label: '普通模切'}, {value: '手工排废', label: '排废'} ]},
  { value: '裱坑', label: '裱坑', supplierCat: '1', children: [ {value: '对裱', label: '对裱'} ]},
  { value: '粘盒', label: '粘盒', supplierCat: '4', children: [ {value: '机粘', label: '机粘'}, {value: '手工粘', label: '手工粘'} ]}
];

const initWoFormData: any = {
  customerId: undefined, customerName: undefined, productName: undefined, deliveryDate: undefined,
  packRequirement: undefined, remark: undefined, processOptions: [], productList: [],    
  materialList: [], ctpList: [], processList: [], outsourcingList: [], printList: []
};

const woForm = ref<any>({ ...initWoFormData });
const woRules = {
  customerId: [{ required: true, message: "客户必须选择", trigger: "change" }]
};

const openWoDialog = () => {
  isDataLoading.value = true;
  woForm.value = JSON.parse(JSON.stringify(initWoFormData));
  addWoProductLine();
  woDialog.visible = true;
  setTimeout(() => isDataLoading.value = false, 100);
};

const handleCustomerChange = (val: any) => {
  const selected = customerOptions.value.find(item => String(item.id) === String(val));
  if (selected) woForm.value.customerName = selected.companyName;
};

const addWoProductLine = () => {
  woForm.value.productList.push({
    productName: '', customerPo: '', customerMaterialNo: '', spec: '', layers: '', knifePlateNo: '',
    orderQuantity: undefined, produceQuantity: undefined, unit: '个', unitPrice: undefined, totalAmount: 0.00
  });
};
const addWoLine = (listName: string) => { woForm.value[listName].push({}); };
const removeWoLine = (listName: string, index: number) => { woForm.value[listName].splice(index, 1); };

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
  if (!woForm.value.productList) return 0;
  return woForm.value.productList.reduce((sum: number, item: any) => sum + (item.orderQuantity || 0), 0);
});

const totalProduceQty = computed(() => {
  if (!woForm.value.productList) return 0;
  return woForm.value.productList.reduce((sum: number, item: any) => sum + (item.produceQuantity || 0), 0);
});

const combinedProductNames = computed(() => {
  if (!woForm.value.productList) return '';
  return woForm.value.productList.map((p: any) => p.productName).filter(Boolean).join(',');
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
  if (woForm.value.materialList.length === 0) {
    let extraFace = Math.floor((newVal - 1) / 66);
    let faceQty = newVal + 101 + extraFace;
    let extraPit = Math.floor((newVal - 1) / 100);
    let pitQty = newVal + 1 + extraPit;
    woForm.value.materialList.push({ partName: '面纸', sourceType: '自来', requireQty: faceQty });
    woForm.value.materialList.push({ partName: '坑纸', sourceType: '自来', requireQty: pitQty });
    proxy?.$modal.msgSuccess("已根据总订单数量自动推算纸张数量！");
  }
});

watch(() => woForm.value.processOptions, (newVal) => {
  if (isDataLoading.value) return; 
  if (!newVal) return;
  const newSigs = newVal.map((path: string[]) => path.join(' - '));
  woForm.value.processList = woForm.value.processList.filter((row: any) => newSigs.includes(row.processName));
  const oldSigs = woForm.value.processList.map((row: any) => row.processName);
  newVal.forEach((path: string[]) => {
    const sig = path.join(' - ');
    if (!oldSigs.includes(sig)) {
      woForm.value.processList.push({ processName: sig, processPath: path, remark: '' });
    }
  });
}, { deep: true });

const handleToOutsourcing = (processRow: any) => {
  const exists = woForm.value.outsourcingList.find((item: any) => item.processProject === processRow.processName);
  if (exists) { proxy?.$modal.msgWarning(`【${processRow.processName}】已转过委外！`); return; }

  const firstMat = woForm.value.materialList.length > 0 ? woForm.value.materialList[0] : null;
  woForm.value.outsourcingList.push({
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

const submitWoForm = () => {
  woFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      if (!woForm.value.productList || woForm.value.productList.length === 0) {
        proxy?.$modal.msgError("请至少添加一项产品明细");
        return;
      }
      for (let i = 0; i < woForm.value.productList.length; i++) {
        if (!woForm.value.productList[i].productName) {
          proxy?.$modal.msgError(`产品明细第 ${i + 1} 行的产品名称不能为空`);
          return;
        }
      }
      buttonLoading.value = true;
      woForm.value.outsourcingList.forEach((item: any) => {
         if(Array.isArray(item.processProjectArray)) {
             item.processProject = item.processProjectArray.join(' - ');
         }
      });
      woForm.value.productName = combinedProductNames.value;

      try {
        await addWorkOrder(woForm.value);
        proxy?.$modal.msgSuccess("保存成功");
        woDialog.visible = false;
        // 修复路由：添加成功后，跳转到顶层工单列表页
        router.push('/workOrder');
      } finally {
        buttonLoading.value = false;
      }
    }
  });
};

onMounted(() => {
  updateTime();
  timer = setInterval(updateTime, 1000);
  getCustomerList();
});

onUnmounted(() => {
  if (timer) clearInterval(timer);
});
</script>

<style lang="scss" scoped>
.home-dashboard {
  background-color: #ffffff;
  min-height: calc(100vh - 84px);
  padding: 20px;
}

/* ================= 左侧面板样式 ================= */
.left-panel {
  display: flex;
  flex-direction: column;
  gap: 15px;

  /* 个人信息卡片 */
  .profile-card {
    border: 1px solid #dcdfe6;
    background-color: #f7f9fa;
    border-radius: 4px;
    padding: 20px 10px;
    text-align: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);

    .avatar-box {
      margin-bottom: 15px;
      .el-avatar {
        border: 2px solid #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      }
    }

    .user-info {
      text-align: left;
      padding-left: 10%;
      p {
        font-size: 13px;
        color: #333;
        margin: 6px 0;
        strong {
          color: #1f2d3d;
        }
      }
    }
  }

  /* 数字时钟 */
  .digital-clock {
    background-color: #000000;
    color: #409eff;
    font-family: 'Courier New', Courier, monospace;
    font-size: 32px;
    font-weight: bold;
    text-align: center;
    padding: 15px 0;
    border-radius: 4px;
    letter-spacing: 2px;
    box-shadow: inset 0 0 10px rgba(255,255,255,0.2);
  }

  /* 迷你日历 */
  .mini-calendar {
    border: 1px solid #dcdfe6;
    background-color: #f7f9fa;
    border-radius: 4px;
    overflow: hidden;

    .calendar-header {
      background-color: #e4e7ed;
      color: #303133;
      text-align: center;
      padding: 8px 0;
      font-weight: bold;
      font-size: 14px;
    }

    :deep(.el-calendar) {
      background-color: transparent;
      .el-calendar__header {
        display: none; 
      }
      .el-calendar__body {
        padding: 5px;
      }
      .el-calendar-table th {
        padding: 5px 0;
        font-size: 12px;
        color: #606266;
      }
      .el-calendar-table td {
        border: none;
      }
      .el-calendar-table .el-calendar-day {
        height: 30px;
        line-height: 30px;
        padding: 0;
        text-align: center;
        font-size: 12px;
        &:hover {
          background-color: #ecf5ff;
        }
      }
      .el-calendar-table td.is-selected .el-calendar-day {
        background-color: #409eff;
        color: #fff;
        border-radius: 4px;
      }
    }
  }
}

/* ================= 右侧面板样式 ================= */
.right-panel {
  display: flex;
  flex-direction: column;
  gap: 25px;

  .section-block {
    .section-title {
      font-size: 16px;
      font-weight: bold;
      color: #1f4a7c;
      border-bottom: 2px solid #e4e7ed;
      padding-bottom: 8px;
      margin-bottom: 15px;
    }

    .shortcut-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;

      .shortcut-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        cursor: pointer;
        width: 80px;
        transition: all 0.2s;

        &:hover {
          transform: translateY(-3px);
          .icon-box {
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
          }
          span {
            color: #409eff;
          }
        }

        .icon-box {
          width: 50px;
          height: 50px;
          background: linear-gradient(135deg, #434343 0%, #1c1c1c 100%);
          border-radius: 8px;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-bottom: 8px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.2);
          border: 1px solid #555;

          .svg-icon {
            font-size: 24px;
            color: #ffffff;
          }
        }

        span {
          font-size: 12px;
          color: #606266;
        }
      }
    }

    .task-list {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        font-size: 14px;
        color: #303133;
        margin-bottom: 12px;
        display: flex;
        align-items: center;

        .dot {
          color: #909399;
          margin-right: 8px;
        }

        .highlight-num {
          color: #f56c6c;
          font-weight: bold;
          margin: 0 4px;
        }

        .star-icon {
          color: #e6a23c;
          margin-left: 8px;
          font-size: 16px;
        }
      }
    }

    .news-alert {
      :deep(.el-alert) {
        .el-alert__title {
          font-size: 14px;
          font-weight: bold;
        }
        .el-alert__icon {
          font-size: 20px;
          width: 20px;
        }
      }
    }
  }
}
</style>