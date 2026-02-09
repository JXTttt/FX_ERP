<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <!-- <el-form-item label="主键ID" prop="id">
              <el-input v-model="queryParams.id" placeholder="请输入主键ID" clearable @keyup.enter="handleQuery" />
            </el-form-item> -->
            <el-form-item label="专用码" prop="uniqueCode">
              <el-input v-model="queryParams.uniqueCode" placeholder="请输入专用码" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="类型" prop="itemType">
              <el-select v-model="queryParams.itemType" placeholder="请选择类型" clearable >
                <el-option v-for="dict in erp_item_type" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="物料名称" prop="itemName">
              <el-input v-model="queryParams.itemName" placeholder="请输入物料名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="规格" prop="spec">
              <el-input v-model="queryParams.spec" placeholder="请输入规格" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <!-- <el-form-item label="当前库存量" prop="currentQty">
              <el-input v-model="queryParams.currentQty" placeholder="请输入当前库存量" clearable @keyup.enter="handleQuery" />
            </el-form-item> -->
            <!-- <el-form-item label="单位" prop="unit">
              <el-select v-model="queryParams.unit" placeholder="请选择单位" clearable >
                <el-option v-for="dict in erp_item_unit" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item> -->
            <!-- <el-form-item label="供应商ID" prop="supplierId">
              <el-input v-model="queryParams.supplierId" placeholder="请输入供应商ID" clearable @keyup.enter="handleQuery" />
            </el-form-item> -->
            <!-- <el-form-item label="采购单价" prop="purchasePrice">
              <el-input v-model="queryParams.purchasePrice" placeholder="请输入采购单价" clearable @keyup.enter="handleQuery" />
            </el-form-item> -->
            <!-- <el-form-item label="总金额" prop="totalAmount">
              <el-input v-model="queryParams.totalAmount" placeholder="请输入总金额" clearable @keyup.enter="handleQuery" />
            </el-form-item> -->
            <el-form-item label="" prop="createBy">
              <el-input v-model="queryParams.createBy" placeholder="请输入" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="" prop="createTime">
              <el-date-picker clearable
                v-model="queryParams.createTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择"
              />
            </el-form-item>
            <el-form-item label="" prop="updateBy">
              <el-input v-model="queryParams.updateBy" placeholder="请输入" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="" prop="updateTime">
              <el-date-picker clearable
                v-model="queryParams.updateTime"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择"
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:inventory:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['erp:inventory:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['erp:inventory:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:inventory:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="inventoryList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="专用码" align="center" prop="uniqueCode" />
        <el-table-column label="类型" align="center" prop="itemType">
          <template #default="scope">
            <dict-tag :options="erp_item_type" :value="scope.row.itemType"/>
          </template>
        </el-table-column>
        <el-table-column label="物料名称" align="center" prop="itemName" />
        <el-table-column label="规格" align="center" prop="spec" />
        <el-table-column label="当前库存量" align="center" prop="currentQty" />
        <el-table-column label="单位" align="center" prop="unit">
          <template #default="scope">
            <dict-tag :options="erp_item_unit" :value="scope.row.unit"/>
          </template>
        </el-table-column>
        <el-table-column label="供应商ID" align="center" prop="supplierId" />
        <el-table-column label="采购单价" align="center" prop="purchasePrice" />
        <el-table-column label="总金额" align="center" prop="totalAmount" />
        <el-table-column label="" align="center" prop="createBy" />
        <el-table-column label="" align="center" prop="createTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="" align="center" prop="updateBy" />
        <el-table-column label="" align="center" prop="updateTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right"  class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:inventory:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:inventory:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    <!-- 添加或修改库存管理对话框 -->
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="inventoryFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="专用码" prop="uniqueCode">
          <el-input v-model="form.uniqueCode" placeholder="请输入专用码" />
        </el-form-item>
        <el-form-item label="类型" prop="itemType">
          <el-select v-model="form.itemType" placeholder="请选择类型">
            <el-option
                v-for="dict in erp_item_type"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="物料名称" prop="itemName">
          <el-input v-model="form.itemName" placeholder="请输入物料名称" />
        </el-form-item>
        <el-form-item label="规格" prop="spec">
          <el-input v-model="form.spec" placeholder="请输入规格" />
        </el-form-item>
        <el-form-item label="当前库存量" prop="currentQty">
          <el-input v-model="form.currentQty" placeholder="请输入当前库存量" />
        </el-form-item>
        <el-form-item label="单位" prop="unit">
          <el-select v-model="form.unit" placeholder="请选择单位">
            <el-option
                v-for="dict in erp_item_unit"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="供应商ID" prop="supplierId">
          <el-input v-model="form.supplierId" placeholder="请输入供应商ID" />
        </el-form-item>
        <el-form-item label="采购单价" prop="purchasePrice">
          <el-input v-model="form.purchasePrice" placeholder="请输入采购单价" />
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

<script setup name="Inventory" lang="ts">
import { listInventory, getInventory, delInventory, addInventory, updateInventory } from '@/api/erp/inventory';
import { InventoryVO, InventoryQuery, InventoryForm } from '@/api/erp/inventory/types';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const { erp_item_type, erp_item_unit } = toRefs<any>(proxy?.useDict('erp_item_type', 'erp_item_unit'));

const inventoryList = ref<InventoryVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const inventoryFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: InventoryForm = {
  uniqueCode: undefined,
  itemType: undefined,
  itemName: undefined,
  spec: undefined,
  currentQty: undefined,
  unit: undefined,
  supplierId: undefined,
  purchasePrice: undefined,
}
const data = reactive<PageData<InventoryForm, InventoryQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    id: undefined,
    uniqueCode: undefined,
    itemType: undefined,
    itemName: undefined,
    spec: undefined,
    currentQty: undefined,
    unit: undefined,
    supplierId: undefined,
    purchasePrice: undefined,
    totalAmount: undefined,
    createBy: undefined,
    createTime: undefined,
    updateBy: undefined,
    updateTime: undefined,
    params: {
    }
  },
  rules: {
    itemName: [
      { required: true, message: "物料名称不能为空", trigger: "blur" }
    ],
    currentQty: [
      { required: true, message: "当前库存量不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询库存管理列表 */
const getList = async () => {
  loading.value = true;
  const res = await listInventory(queryParams.value);
  inventoryList.value = res.rows;
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
  inventoryFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: InventoryVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加库存管理";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: InventoryVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getInventory(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改库存管理";
}

/** 提交按钮 */
const submitForm = () => {
  inventoryFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateInventory(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addInventory(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: InventoryVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除库存管理编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delInventory(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('erp/inventory/export', {
    ...queryParams.value
  }, `inventory_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>
