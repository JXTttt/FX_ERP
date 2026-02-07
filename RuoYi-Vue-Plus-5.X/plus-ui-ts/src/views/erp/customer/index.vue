<template>
  <div class="p-2">
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
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="手机号" prop="contactPhone">
              <el-input
                v-model="queryParams.contactPhone"
                placeholder="请输入联系人手机号"
                clearable
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
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
            <el-button
              type="primary"
              plain
              icon="Plus"
              @click="handleAdd"
              v-hasPermi="['erp:customer:add']"
              >新增</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="success"
              plain
              icon="Edit"
              :disabled="single"
              @click="handleUpdate()"
              v-hasPermi="['erp:customer:edit']"
              >修改</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              @click="handleDelete()"
              v-hasPermi="['erp:customer:remove']"
              >删除</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['erp:customer:export']"
              >导出</el-button
            >
          </el-col>
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
          ></right-toolbar>
        </el-row>
      </template>

      <el-table
        v-loading="loading"
        border
        :data="customerList"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column
          label="客户名称"
          align="center"
          prop="companyName"
          min-width="150"
          :show-overflow-tooltip="true"
        />
        <el-table-column label="联系人" align="center" prop="contactPerson" width="100" />
        <el-table-column label="手机号" align="center" prop="contactPhone" width="120" />

        <el-table-column label="类型" align="center" prop="customerType" width="100">
          <template #default="scope">
            <dict-tag :options="erp_customer_type" :value="scope.row.customerType" />
          </template>
        </el-table-column>

        <el-table-column
          label="公司地址"
          align="center"
          min-width="200"
          :show-overflow-tooltip="true"
        >
          <template #default="scope">
            <span>
              {{ scope.row.companyProvince || "" }}
              {{ scope.row.companyCity || "" }}
              {{ scope.row.companyDistrict || "" }}
              {{ scope.row.companyAddress || "" }}
            </span>
          </template>
        </el-table-column>

        <el-table-column
          label="收货地址"
          align="center"
          min-width="200"
          :show-overflow-tooltip="true"
        >
          <template #default="scope">
            <span>
              {{ scope.row.deliveryProvince || "" }}
              {{ scope.row.deliveryCity || "" }}
              {{ scope.row.deliveryDistrict || "" }}
              {{ scope.row.deliveryAddress || "" }}
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
              trigger="click"
              :content="scope.row.bankAccountInfo"
            >
              <template #reference>
                <el-button link type="primary" icon="View">查看</el-button>
              </template>
            </el-popover>
            <span v-else>-</span>
          </template>
        </el-table-column>

        <el-table-column
          label="交易总额"
          align="center"
          prop="totalDealAmount"
          width="120"
        />
        <el-table-column
          label="当前欠款"
          align="center"
          prop="totalOweAmount"
          width="120"
        >
          <template #default="scope">
            <span :style="scope.row.totalOweAmount > 0 ? 'color: red' : ''">{{
              scope.row.totalOweAmount
            }}</span>
          </template>
        </el-table-column>

        <el-table-column
          label="操作"
          align="center"
          width="220"
          fixed="right"
          class-name="small-padding fixed-width"
        >
          <template #default="scope">
            <el-button
              link
              type="primary"
              icon="View"
              @click="handleView(scope.row)"
              v-hasPermi="['erp:customer:query']"
              >详情</el-button
            >
            <el-button
              link
              type="primary"
              icon="Edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['erp:customer:edit']"
              >修改</el-button
            >
            <el-button
              link
              type="primary"
              icon="Delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['erp:customer:remove']"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <el-dialog
      :title="dialog.title"
      v-model="dialog.visible"
      width="800px"
      append-to-body
    >
      <el-form
        ref="customerFormRef"
        :model="form"
        :rules="rules"
        label-width="110px"
        :disabled="isView"
      >
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="客户公司全称" prop="companyName">
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
            <el-form-item label="客户类型" prop="customerType">
              <el-select
                v-model="form.customerType"
                placeholder="请选择类型"
                style="width: 100%"
              >
                <el-option
                  v-for="dict in erp_customer_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
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
                :options="pcaTextArr"
                placeholder="请选择省/市/区"
                style="width: 100%"
                clearable
                filterable
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
                :options="pcaTextArr"
                placeholder="请选择省/市/区"
                style="width: 100%"
                clearable
                filterable
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
              <el-input
                v-model="form.bankAccountInfo"
                placeholder="例:工行 张三 6212..."
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="业务员ID" prop="salesManId">
              <el-input v-model="form.salesManId" placeholder="关联sys_user" />
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
          <el-button
            :loading="buttonLoading"
            type="primary"
            @click="submitForm"
            v-if="!isView"
            >确 定</el-button
          >
          <el-button @click="cancel">{{ isView ? "关 闭" : "取 消" }}</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Customer" lang="ts">
import {
  listCustomer,
  getCustomer,
  delCustomer,
  addCustomer,
  updateCustomer,
} from "@/api/erp/customer";
import { CustomerVO, CustomerQuery, CustomerForm } from "@/api/erp/customer/types";
// 引入省市区数据（汉字版）
import { pcaTextArr } from "element-china-area-data";

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { erp_customer_type } = toRefs<any>(proxy?.useDict("erp_customer_type"));

const customerList = ref<CustomerVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
// 新增：控制是否为查看模式
const isView = ref(false);

// 新增：绑定级联选择器的数组变量
const companyRegion = ref<string[]>([]); 
const deliveryRegion = ref<string[]>([]); 

const queryFormRef = ref<ElFormInstance>();
const customerFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: "",
});

const initFormData: CustomerForm = {
  companyName: undefined,
  customerCode: undefined,
  shortName: undefined,
  contactPerson: undefined,
  contactPhone: undefined,
  customerType: undefined,
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
const data = reactive<PageData<CustomerForm, CustomerQuery>>({
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    companyName: undefined,
    contactPerson: undefined,
    contactPhone: undefined,
    id: undefined,
    customerCode: undefined,
    shortName: undefined,
    customerType: undefined,
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
    totalDealAmount: undefined,
    totalOweAmount: undefined,
    salesManId: undefined,
    createBy: undefined,
    createTime: undefined,
    updateBy: undefined,
    updateTime: undefined,
    params: {},
  },
  rules: {
    companyName: [{ required: true, message: "客户公司全称不能为空", trigger: "blur" }],
    customerCode: [{ required: true, message: "客户编码不能为空", trigger: "blur" }],
    // 可以加一个规则：如果选了省市区，必填
    // companyProvince: [{ required: true, message: "请选择所在地区", trigger: "change" }],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 监听公司地址级联选择器变化 */
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

/** 监听收货地址级联选择器变化 */
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

/** 查询客户及供应商列表 */
const getList = async () => {
  loading.value = true;
  const res = await listCustomer(queryParams.value);
  customerList.value = res.rows;
  total.value = res.total;
  loading.value = false;
};

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
};

/** 表单重置 */
const reset = () => {
  form.value = { ...initFormData };
  customerFormRef.value?.resetFields();
  // 重置时清空级联选择器
  companyRegion.value = [];
  deliveryRegion.value = [];
};

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
};

/** 多选框选中数据 */
const handleSelectionChange = (selection: CustomerVO[]) => {
  ids.value = selection.map((item) => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  isView.value = false;
  companyRegion.value = [];
  deliveryRegion.value = [];
  dialog.visible = true;
  dialog.title = "添加客户及供应商";
};

/** 修改按钮操作 */
const handleUpdate = async (row?: CustomerVO) => {
  reset();
  isView.value = false;
  const _id = row?.id || ids.value[0];
  const res = await getCustomer(_id);
  Object.assign(form.value, res.data);
  
  // 回显公司地址
  if (form.value.companyProvince && form.value.companyCity && form.value.companyDistrict) {
    companyRegion.value = [form.value.companyProvince, form.value.companyCity, form.value.companyDistrict];
  } else {
    companyRegion.value = [];
  }

  // 回显收货地址
  if (form.value.deliveryProvince && form.value.deliveryCity && form.value.deliveryDistrict) {
    deliveryRegion.value = [form.value.deliveryProvince, form.value.deliveryCity, form.value.deliveryDistrict];
  } else {
    deliveryRegion.value = [];
  }

  dialog.visible = true;
  dialog.title = "修改客户及供应商";
};

/** 详情按钮操作 */
const handleView = async (row?: CustomerVO) => {
  reset();
  isView.value = true;
  const _id = row?.id || ids.value[0];
  const res = await getCustomer(_id);
  Object.assign(form.value, res.data);

  // 回显公司地址
  if (form.value.companyProvince && form.value.companyCity && form.value.companyDistrict) {
    companyRegion.value = [form.value.companyProvince, form.value.companyCity, form.value.companyDistrict];
  }
  // 回显收货地址
  if (form.value.deliveryProvince && form.value.deliveryCity && form.value.deliveryDistrict) {
    deliveryRegion.value = [form.value.deliveryProvince, form.value.deliveryCity, form.value.deliveryDistrict];
  }

  dialog.visible = true;
  dialog.title = "客户详情";
};

/** 提交按钮 */
const submitForm = () => {
  customerFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if ((form.value as any).id) {
        await updateCustomer(form.value).finally(() => (buttonLoading.value = false));
      } else {
        await addCustomer(form.value).finally(() => (buttonLoading.value = false));
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
};

/** 删除按钮操作 */
const handleDelete = async (row?: CustomerVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal
    .confirm("是否确认删除所选数据项？")
    .finally(() => (loading.value = false));
  await delCustomer(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
};

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download(
    "erp/customer/export",
    {
      ...queryParams.value,
    },
    `customer_${new Date().getTime()}.xlsx`
  );
};

onMounted(() => {
  getList();
});
</script>