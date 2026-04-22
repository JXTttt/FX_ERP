<template>
  <div class="p-2 app-container">
    <transition
      :enter-active-class="proxy?.animate.searchAnimate.enter"
      :leave-active-class="proxy?.animate.searchAnimate.leave"
    >
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="客户名称" prop="companyName">
              <el-input
                v-model="queryParams.companyName"
                placeholder="请输入客户公司全称"
                clearable
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="联系人" prop="contactPerson">
              <el-input
                v-model="queryParams.contactPerson"
                placeholder="请输入联系人姓名"
                clearable
                style="width: 150px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="手机号" prop="contactPhone">
              <el-input
                v-model="queryParams.contactPhone"
                placeholder="请输入联系人手机号"
                clearable
                style="width: 180px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="客户角色" prop="customerType">
              <el-select v-model="queryParams.customerType" placeholder="全部" clearable style="width: 120px" @change="handleQuery">
                <el-option v-for="dict in erp_customer_type" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
            
            <el-form-item label="加工/供应" prop="bizCategory">
              <el-select v-model="queryParams.bizCategory" placeholder="请选择分类" clearable filterable style="width: 150px" @change="handleQuery">
                <el-option-group label="► 供应商分类">
                  <el-option v-for="dict in erp_supplier_category" :key="'sup_' + dict.value" :label="dict.label" :value="dict.value" />
                </el-option-group>
                <el-option-group label="► 加工商分类">
                  <el-option v-for="dict in erp_processor_category" :key="'proc_' + dict.value" :label="dict.label" :value="dict.value" />
                </el-option-group>
              </el-select>
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:customer:add']">新增客户/供应商</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:customer:export']">导出档案表格</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table
        v-loading="loading"
        border
        :data="customerList"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        
        <el-table-column label="客户/公司全称" align="left" prop="companyName" min-width="180" show-overflow-tooltip>
          <template #default="scope">
             <strong style="color: #303133">{{ scope.row.companyName }}</strong>
          </template>
        </el-table-column>

        <el-table-column label="简称" align="center" prop="shortName" min-width="100" show-overflow-tooltip />

        <el-table-column label="联系人" align="center" prop="contactPerson" width="100" />
        <el-table-column label="手机号" align="center" prop="contactPhone" width="130" />

        <el-table-column label="类型" align="center" prop="customerType" width="100">
          <template #default="scope">
            <dict-tag :options="erp_customer_type" :value="scope.row.customerType" />
          </template>
        </el-table-column>

        <el-table-column label="加工/供应类型" align="left" min-width="180">
          <template #default="scope">
            <div v-if="scope.row.customerType && scope.row.customerType.includes('2')" class="mb-[5px]">
              <dict-tag :options="erp_supplier_category" :value="scope.row.supplierCategory" />
            </div>
            <div v-if="scope.row.customerType && scope.row.customerType.includes('3')">
              <dict-tag :options="erp_processor_category" :value="scope.row.processorCategory" />
            </div>
          </template>
        </el-table-column>

        <el-table-column label="公司地址" align="center" min-width="200" show-overflow-tooltip>
          <template #default="scope">
            <span>
              {{ scope.row.companyProvince || "" }}{{ scope.row.companyCity || "" }}{{ scope.row.companyDistrict || "" }}{{ scope.row.companyAddress || "" }}
            </span>
          </template>
        </el-table-column>

        <el-table-column label="银行账户" align="center" width="100">
          <template #default="scope">
            <el-popover
              v-if="scope.row.bankAccountInfo"
              placement="top"
              title="账户详情"
              :width="300"
              trigger="hover"
              :content="scope.row.bankAccountInfo"
            >
              <template #reference>
                <el-button link type="primary" icon="View">查看</el-button>
              </template>
            </el-popover>
            <span v-else style="color: #C0C4CC; font-size: 12px;">未录入</span>
          </template>
        </el-table-column>

        <el-table-column label="交易总额" align="center" prop="totalDealAmount" width="120">
          <template #default="scope">
             <span style="font-weight: bold; color: #606266;">￥{{ Number(scope.row.totalDealAmount || 0).toFixed(2) }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="当前欠款/待付" align="center" prop="totalOweAmount" width="140">
          <template #default="scope">
            <span v-if="Number(scope.row.totalOweAmount) > 0" style="color: #F56C6C; font-weight: bold;">
              ￥{{ Number(scope.row.totalOweAmount).toFixed(2) }}
            </span>
            <span v-else-if="Number(scope.row.totalOweAmount) < 0" style="color: #409EFF; font-weight: bold;">
              预存: ￥{{ Math.abs(Number(scope.row.totalOweAmount)).toFixed(2) }}
            </span>
            <span v-else style="color: #67C23A;">￥0.00</span>
          </template>
        </el-table-column>

        <el-table-column label="操作" align="center" width="280" fixed="right" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button 
              v-if="Number(scope.row.totalOweAmount) > 0" 
              link 
              type="warning" 
              icon="Money" 
              @click="handleSettle(scope.row)" 
              v-hasPermi="['erp:customer:edit']"
            >手工结清</el-button>

            <el-button link type="success" icon="View" @click="handleView(scope.row)" v-hasPermi="['erp:customer:query']">详情</el-button>
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:customer:edit']">修改</el-button>
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:customer:remove']">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog title="手工结清账款" v-model="settleDialog.visible" width="450px" append-to-body>
      <el-form ref="settleFormRef" :model="settleForm" label-width="100px">
        <el-form-item label="当前欠款：">
          <span style="color: #F56C6C; font-weight: bold; font-size: 18px;">￥{{ Number(currentSettleCustomer.totalOweAmount || 0).toFixed(2) }}</span>
        </el-form-item>
        <el-form-item label="结清金额：" required>
          <el-input-number v-model="settleForm.settleAmount" :min="0.01" :precision="2" style="width: 100%" placeholder="请输入实际打款/收款金额" />
        </el-form-item>
        <el-form-item label="结清备注：">
          <el-input v-model="settleForm.remark" type="textarea" placeholder="请输入流水凭证号或付款备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="settleLoading" @click="submitSettle">确 认 结 清</el-button>
          <el-button @click="settleDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="800px" append-to-body>
      <el-form ref="customerFormRef" :model="form" :rules="rules" label-width="110px" :disabled="isView">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="客户/公司全称" prop="companyName">
              <el-input v-model="form.companyName" placeholder="请输入客户公司全称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="客户编码" prop="customerCode">
              <el-input v-model="form.customerCode" placeholder="系统唯一标识" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="简称/全名" prop="shortName">
              <el-input v-model="form.shortName" placeholder="请输入客户简称" />
            </el-form-item>
          </el-col>
          
          <el-col :span="12">
            <el-form-item label="类型" prop="customerType">
              <el-select v-model="form.customerType" multiple placeholder="请选择类型" style="width: 100%">
                <el-option v-for="dict in erp_customer_type" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>

          <el-col :span="12" v-if="form.customerType && form.customerType.includes('2')">
            <el-form-item label="供应分类" prop="supplierCategory">
              <el-select 
                v-model="form.supplierCategory" 
                multiple 
                placeholder="请选择供应商分类" 
                style="width: 100%"
                clearable
              >
                <el-option v-for="dict in erp_supplier_category" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>

          <el-col :span="12" v-if="form.customerType && form.customerType.includes('3')">
            <el-form-item label="加工分类" prop="processorCategory">
              <el-select 
                v-model="form.processorCategory" 
                multiple 
                placeholder="请选择加工商分类" 
                style="width: 100%"
                clearable
              >
                <el-option v-for="dict in erp_processor_category" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="联系人" prop="contactPerson">
              <el-input v-model="form.contactPerson" placeholder="请输入首要联系人" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入手机号" />
            </el-form-item>
          </el-col>

          <el-divider content-position="left">公司地址信息</el-divider>
          <el-col :span="24">
            <el-form-item label="所在地区" prop="companyProvince">
              <el-cascader
                v-model="companyRegion"
                :options="(pcaTextArr as any)"
                placeholder="请选择省/市/区"
                style="width: 100%"
                clearable filterable
                @change="handleCompanyRegionChange"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="详细地址" prop="companyAddress">
              <el-input v-model="form.companyAddress" placeholder="请输入街道/门牌号等" />
            </el-form-item>
          </el-col>

          <el-divider content-position="left">收货信息</el-divider>
          <el-col :span="24">
            <el-form-item label="收货地区" prop="deliveryProvince">
              <el-cascader
                v-model="deliveryRegion"
                :options="(pcaTextArr as any)"
                placeholder="请选择省/市/区"
                style="width: 100%"
                clearable filterable
                @change="handleDeliveryRegionChange"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="收货详细地址" prop="deliveryAddress">
              <el-input v-model="form.deliveryAddress" placeholder="请输入街道/门牌号等" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="收货单位" prop="deliveryUnit">
              <el-input v-model="form.deliveryUnit" />
            </el-form-item>
          </el-col>

          <el-divider content-position="left">其他信息</el-divider>
          <el-col :span="24">
            <el-form-item label="银行账户" prop="bankAccountInfo">
              <el-input v-model="form.bankAccountInfo" placeholder="例:工行 张三 6212..." />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="业务员" prop="salesManId">
              <el-select 
                v-model="form.salesManId" 
                placeholder="请选择业务员" 
                filterable 
                clearable
                style="width: 100%"
              >
                <el-option
                  v-for="user in userList"
                  :key="user.userId"
                  :label="user.nickName" 
                  :value="user.userId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm" v-if="!isView">确 定</el-button>
          <el-button @click="cancel">{{ isView ? "关 闭" : "取 消" }}</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Customer" lang="ts">
import request from '@/utils/request';
import { listCustomer, getCustomer, delCustomer, addCustomer, updateCustomer } from "@/api/erp/customer";
import { CustomerVO } from "@/api/erp/customer/types";
import { pcaTextArr } from "element-china-area-data";
import { ComponentInternalInstance, getCurrentInstance, onMounted, reactive, ref, toRefs } from 'vue';
import { listUser } from "@/api/system/user";
import { useRoute } from 'vue-router';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { erp_customer_type, erp_supplier_category, erp_processor_category } = toRefs<any>(proxy?.useDict("erp_customer_type", "erp_supplier_category", "erp_processor_category"));

const route = useRoute();
const customerList = ref<CustomerVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const isView = ref(false);
const userList = ref<any[]>([]);

const companyRegion = ref<string[]>([]); 
const deliveryRegion = ref<string[]>([]); 

const queryFormRef = ref<any>();
const customerFormRef = ref<any>();

const dialog = reactive({
  visible: false,
  title: "",
});

const settleDialog = reactive({ visible: false });
const settleLoading = ref(false);
const currentSettleCustomer = ref<any>({});
const settleForm = ref({ id: undefined, settleAmount: undefined, remark: '' });

const initFormData: any = {
  companyName: undefined,
  customerCode: undefined,
  shortName: undefined,
  contactPerson: undefined,
  contactPhone: undefined,
  customerType: [], 
  supplierCategory: [], 
  processorCategory: [], 
  companyProvince: undefined,
  companyCity: undefined,
  companyDistrict: undefined,
  companyAddress: undefined,
  deliveryProvince: undefined,
  deliveryCity: undefined,
  deliveryDistrict: undefined,
  deliveryAddress: undefined,
  deliveryUnit: undefined,
  bankAccountInfo: undefined,
  salesManId: undefined,
  remark: undefined,
};

const data = reactive<any>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    companyName: undefined,
    contactPerson: undefined,
    contactPhone: undefined,
    customerType: undefined,
    bizCategory: undefined,
  },
  rules: {
    companyName: [{ required: true, message: "客户公司全称不能为空", trigger: "blur" }],
    customerCode: [{ required: true, message: "客户编码不能为空", trigger: "blur" }],
    customerType: [{ required: true, message: "客户类型不能为空", trigger: "change" }]
  },
});

const { queryParams, form, rules } = toRefs(data);

const handleCompanyRegionChange = (value: string[]) => {
  if (value && value.length > 0) {
    form.value.companyProvince = value[0];
    form.value.companyCity = value[1];
    form.value.companyDistrict = value[2];
  } else {
    form.value.companyProvince = undefined;
    form.value.companyCity = undefined;
    form.value.companyDistrict = undefined;
  }
}

const handleDeliveryRegionChange = (value: string[]) => {
  if (value && value.length > 0) {
    form.value.deliveryProvince = value[0];
    form.value.deliveryCity = value[1];
    form.value.deliveryDistrict = value[2];
  } else {
    form.value.deliveryProvince = undefined;
    form.value.deliveryCity = undefined;
    form.value.deliveryDistrict = undefined;
  }
}

const getList = async () => {
  loading.value = true;
  const res = await listCustomer(queryParams.value);
  customerList.value = res.rows;
  total.value = res.total;
  loading.value = false;
};

const cancel = () => {
  reset();
  dialog.visible = false;
};

const reset = () => {
  form.value = { ...initFormData };
  customerFormRef.value?.resetFields();
  companyRegion.value = [];
  deliveryRegion.value = [];
};

const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};

const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
};

const handleSelectionChange = (selection: CustomerVO[]) => {
  ids.value = selection.map((item) => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

const handleAdd = () => {
  reset();
  isView.value = false;
  companyRegion.value = [];
  deliveryRegion.value = [];
  dialog.visible = true;
  dialog.title = "添加客户及供应商";
};

const formatStringToArray = (val: any) => {
  if (val && typeof val === 'string') {
    return val.split(',');
  }
  return [];
};

const handleUpdate = async (row?: CustomerVO) => {
  reset();
  isView.value = false;
  const _id = row?.id || ids.value[0];
  const res = await getCustomer(_id);
  Object.assign(form.value, res.data);
  
  form.value.customerType = formatStringToArray(form.value.customerType);
  form.value.supplierCategory = formatStringToArray(form.value.supplierCategory);
  form.value.processorCategory = formatStringToArray(form.value.processorCategory);
  
  if (form.value.companyProvince && form.value.companyCity && form.value.companyDistrict) {
    companyRegion.value = [form.value.companyProvince, form.value.companyCity, form.value.companyDistrict];
  } else {
    companyRegion.value = [];
  }

  if (form.value.deliveryProvince && form.value.deliveryCity && form.value.deliveryDistrict) {
    deliveryRegion.value = [form.value.deliveryProvince, form.value.deliveryCity, form.value.deliveryDistrict];
  } else {
    deliveryRegion.value = [];
  }

  dialog.visible = true;
  dialog.title = "修改客户及供应商";
};

const handleView = async (row?: CustomerVO) => {
  reset();
  isView.value = true;
  const _id = row?.id || ids.value[0];
  const res = await getCustomer(_id);
  Object.assign(form.value, res.data);

  form.value.customerType = formatStringToArray(form.value.customerType);
  form.value.supplierCategory = formatStringToArray(form.value.supplierCategory);
  form.value.processorCategory = formatStringToArray(form.value.processorCategory);

  if (form.value.companyProvince && form.value.companyCity && form.value.companyDistrict) {
    companyRegion.value = [form.value.companyProvince, form.value.companyCity, form.value.companyDistrict];
  }
  if (form.value.deliveryProvince && form.value.deliveryCity && form.value.deliveryDistrict) {
    deliveryRegion.value = [form.value.deliveryProvince, form.value.deliveryCity, form.value.deliveryDistrict];
  }

  dialog.visible = true;
  dialog.title = "客户详情";
};

const handleSettle = (row: any) => {
  currentSettleCustomer.value = row;
  settleForm.value = {
    id: row.id,
    settleAmount: row.totalOweAmount,
    remark: ''
  };
  settleDialog.visible = true;
};

const submitSettle = async () => {
  if (!settleForm.value.settleAmount) {
    proxy?.$modal.msgError("请输入结清金额");
    return;
  }
  settleLoading.value = true;
  try {
    await request({
      url: '/erp/customer/settle',
      method: 'post',
      data: settleForm.value
    });
    proxy?.$modal.msgSuccess("账款核销成功！已自动生成财务流水。");
    settleDialog.visible = false;
    getList();
  } finally {
    settleLoading.value = false;
  }
};

const submitForm = () => {
  customerFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      const submitData = { ...form.value };
      
      if (Array.isArray(submitData.customerType)) {
          submitData.customerType = submitData.customerType.join(',');
      }
      if (Array.isArray(submitData.supplierCategory)) {
          submitData.supplierCategory = submitData.supplierCategory.join(',');
      }
      if (Array.isArray(submitData.processorCategory)) {
          submitData.processorCategory = submitData.processorCategory.join(',');
      }

      if (submitData.id) {
        await updateCustomer(submitData).finally(() => (buttonLoading.value = false));
      } else {
        await addCustomer(submitData).finally(() => (buttonLoading.value = false));
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
};

const handleDelete = async (row?: CustomerVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal
    .confirm("是否确认删除所选数据项？")
    .finally(() => (loading.value = false));
  await delCustomer(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
};

const handleExport = () => {
  const exportParams: any = JSON.parse(JSON.stringify(queryParams.value));
  exportParams.params = undefined; 
  proxy?.download(
    "erp/customer/export",
    exportParams,
    `客户档案导出_${new Date().getTime()}.xlsx`
  );
};

const getUserList = async () => {
  try {
    const res = await listUser({ 
      pageNum: 1, 
      pageSize: 1000, 
      status: '0' 
    });
    userList.value = res.rows;
  } catch (error) {
    console.error("获取业务员列表失败", error);
  }
};

onMounted(() => {
  getUserList();
  getList();

  if (route.query.action === 'add') {
    handleAdd();
  }
});
</script>