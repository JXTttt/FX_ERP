<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="主键ID" prop="id">
              <el-input v-model="queryParams.id" placeholder="请输入主键ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="客户公司全称" prop="companyName">
              <el-input v-model="queryParams.companyName" placeholder="请输入客户公司全称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="客户编码(唯一标识)" prop="customerCode">
              <el-input v-model="queryParams.customerCode" placeholder="请输入客户编码(唯一标识)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="客户简称/个人全名" prop="shortName">
              <el-input v-model="queryParams.shortName" placeholder="请输入客户简称/个人全名" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="首要联系人名称" prop="contactPerson">
              <el-input v-model="queryParams.contactPerson" placeholder="请输入首要联系人名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="联系人手机号" prop="contactPhone">
              <el-input v-model="queryParams.contactPhone" placeholder="请输入联系人手机号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="类型：1-普通客户, 2-供应商" prop="customerType">
              <el-select v-model="queryParams.customerType" placeholder="请选择类型：1-普通客户, 2-供应商" clearable >
                <el-option v-for="dict in erp_customer_type" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="公司所在省" prop="companyProvince">
              <el-input v-model="queryParams.companyProvince" placeholder="请输入公司所在省" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="公司所在市" prop="companyCity">
              <el-input v-model="queryParams.companyCity" placeholder="请输入公司所在市" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="公司所在区" prop="companyDistrict">
              <el-input v-model="queryParams.companyDistrict" placeholder="请输入公司所在区" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="公司详细地址" prop="companyAddress">
              <el-input v-model="queryParams.companyAddress" placeholder="请输入公司详细地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="收货省" prop="deliveryProvince">
              <el-input v-model="queryParams.deliveryProvince" placeholder="请输入收货省" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="收货市" prop="deliveryCity">
              <el-input v-model="queryParams.deliveryCity" placeholder="请输入收货市" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="收货区" prop="deliveryDistrict">
              <el-input v-model="queryParams.deliveryDistrict" placeholder="请输入收货区" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="收货详细地址" prop="deliveryAddress">
              <el-input v-model="queryParams.deliveryAddress" placeholder="请输入收货详细地址" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="收货单位名称" prop="deliveryUnit">
              <el-input v-model="queryParams.deliveryUnit" placeholder="请输入收货单位名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="银行账户信息(例:工行 张三 6212...)" prop="bankAccountInfo">
              <el-input v-model="queryParams.bankAccountInfo" placeholder="请输入银行账户信息(例:工行 张三 6212...)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="总交易金额(出货/采购)" prop="totalDealAmount">
              <el-input v-model="queryParams.totalDealAmount" placeholder="请输入总交易金额(出货/采购)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="当前欠款/待付金额" prop="totalOweAmount">
              <el-input v-model="queryParams.totalOweAmount" placeholder="请输入当前欠款/待付金额" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="业务归属员ID (关联sys_user)" prop="salesManId">
              <el-input v-model="queryParams.salesManId" placeholder="请输入业务归属员ID (关联sys_user)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="创建者" prop="createBy">
              <el-input v-model="queryParams.createBy" placeholder="请输入创建者" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="创建时间" prop="createTime">
              <el-date-picker clearable
                v-model="queryParams.createTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择创建时间"
              />
            </el-form-item>
            <el-form-item label="更新者" prop="updateBy">
              <el-input v-model="queryParams.updateBy" placeholder="请输入更新者" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="更新时间" prop="updateTime">
              <el-date-picker clearable
                v-model="queryParams.updateTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择更新时间"
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:customer:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['erp:customer:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['erp:customer:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:customer:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="customerList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="客户公司全称" align="center" prop="companyName" />
        <el-table-column label="客户编码(唯一标识)" align="center" prop="customerCode" />
        <el-table-column label="客户简称/个人全名" align="center" prop="shortName" />
        <el-table-column label="首要联系人名称" align="center" prop="contactPerson" />
        <el-table-column label="联系人手机号" align="center" prop="contactPhone" />
        <el-table-column label="类型：1-普通客户, 2-供应商" align="center" prop="customerType">
          <template #default="scope">
            <dict-tag :options="erp_customer_type" :value="scope.row.customerType"/>
          </template>
        </el-table-column>
        <el-table-column label="公司所在省" align="center" prop="companyProvince" />
        <el-table-column label="公司所在市" align="center" prop="companyCity" />
        <el-table-column label="公司所在区" align="center" prop="companyDistrict" />
        <el-table-column label="公司详细地址" align="center" prop="companyAddress" />
        <el-table-column label="收货省" align="center" prop="deliveryProvince" />
        <el-table-column label="收货市" align="center" prop="deliveryCity" />
        <el-table-column label="收货区" align="center" prop="deliveryDistrict" />
        <el-table-column label="收货详细地址" align="center" prop="deliveryAddress" />
        <el-table-column label="收货单位名称" align="center" prop="deliveryUnit" />
        <el-table-column label="银行账户信息(例:工行 张三 6212...)" align="center" prop="bankAccountInfo" />
        <el-table-column label="总交易金额(出货/采购)" align="center" prop="totalDealAmount" />
        <el-table-column label="当前欠款/待付金额" align="center" prop="totalOweAmount" />
        <el-table-column label="业务归属员ID (关联sys_user)" align="center" prop="salesManId" />
        <el-table-column label="创建者" align="center" prop="createBy" />
        <el-table-column label="创建时间" align="center" prop="createTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="更新者" align="center" prop="updateBy" />
        <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:customer:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:customer:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改客户及供应商对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="customerFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="客户公司全称" prop="companyName">
          <el-input v-model="form.companyName" placeholder="请输入客户公司全称" />
        </el-form-item>
        <el-form-item label="客户编码(唯一标识)" prop="customerCode">
          <el-input v-model="form.customerCode" placeholder="请输入客户编码(唯一标识)" />
        </el-form-item>
        <el-form-item label="客户简称/个人全名" prop="shortName">
          <el-input v-model="form.shortName" placeholder="请输入客户简称/个人全名" />
        </el-form-item>
        <el-form-item label="首要联系人名称" prop="contactPerson">
          <el-input v-model="form.contactPerson" placeholder="请输入首要联系人名称" />
        </el-form-item>
        <el-form-item label="联系人手机号" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系人手机号" />
        </el-form-item>
        <el-form-item label="类型：1-普通客户, 2-供应商" prop="customerType">
          <el-select v-model="form.customerType" placeholder="请选择类型：1-普通客户, 2-供应商">
            <el-option
                v-for="dict in erp_customer_type"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="公司所在省" prop="companyProvince">
          <el-input v-model="form.companyProvince" placeholder="请输入公司所在省" />
        </el-form-item>
        <el-form-item label="公司所在市" prop="companyCity">
          <el-input v-model="form.companyCity" placeholder="请输入公司所在市" />
        </el-form-item>
        <el-form-item label="公司所在区" prop="companyDistrict">
          <el-input v-model="form.companyDistrict" placeholder="请输入公司所在区" />
        </el-form-item>
        <el-form-item label="公司详细地址" prop="companyAddress">
          <el-input v-model="form.companyAddress" placeholder="请输入公司详细地址" />
        </el-form-item>
        <el-form-item label="收货省" prop="deliveryProvince">
          <el-input v-model="form.deliveryProvince" placeholder="请输入收货省" />
        </el-form-item>
        <el-form-item label="收货市" prop="deliveryCity">
          <el-input v-model="form.deliveryCity" placeholder="请输入收货市" />
        </el-form-item>
        <el-form-item label="收货区" prop="deliveryDistrict">
          <el-input v-model="form.deliveryDistrict" placeholder="请输入收货区" />
        </el-form-item>
        <el-form-item label="收货详细地址" prop="deliveryAddress">
          <el-input v-model="form.deliveryAddress" placeholder="请输入收货详细地址" />
        </el-form-item>
        <el-form-item label="收货单位名称" prop="deliveryUnit">
          <el-input v-model="form.deliveryUnit" placeholder="请输入收货单位名称" />
        </el-form-item>
        <el-form-item label="银行账户信息(例:工行 张三 6212...)" prop="bankAccountInfo">
          <el-input v-model="form.bankAccountInfo" placeholder="请输入银行账户信息(例:工行 张三 6212...)" />
        </el-form-item>
        <el-form-item label="业务归属员ID (关联sys_user)" prop="salesManId">
          <el-input v-model="form.salesManId" placeholder="请输入业务归属员ID (关联sys_user)" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Customer" lang="ts">
import { listCustomer, getCustomer, delCustomer, addCustomer, updateCustomer } from '@/api/erp/customer';
import { CustomerVO, CustomerQuery, CustomerForm } from '@/api/erp/customer/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { erp_customer_type } = toRefs<any>(proxy?.useDict('erp_customer_type'));

const customerList = ref<CustomerVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const customerFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
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
}
const data = reactive<PageData<CustomerForm, CustomerQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    id: undefined,
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
    totalDealAmount: undefined,
    totalOweAmount: undefined,
    salesManId: undefined,
    createBy: undefined,
    createTime: undefined,
    updateBy: undefined,
    updateTime: undefined,
    params: {
    }
  },
  rules: {
    companyName: [
      { required: true, message: "客户公司全称不能为空", trigger: "blur" }
    ],
    customerCode: [
      { required: true, message: "客户编码(唯一标识)不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询客户及供应商列表 */
const getList = async () => {
  loading.value = true;
  const res = await listCustomer(queryParams.value);
  customerList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

/** 取消按钮 */
const cancel = () => {
  reset();
  dialog.visible = false;
}

/** 表单重置 */
const reset = () => {
  form.value = {...initFormData};
  customerFormRef.value?.resetFields();
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
}

/** 多选框选中数据 */
const handleSelectionChange = (selection: CustomerVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加客户及供应商";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: CustomerVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getCustomer(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改客户及供应商";
}

/** 提交按钮 */
const submitForm = () => {
  customerFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateCustomer(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addCustomer(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: CustomerVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除客户及供应商编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delCustomer(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('erp/customer/export', {
    ...queryParams.value
  }, `customer_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
