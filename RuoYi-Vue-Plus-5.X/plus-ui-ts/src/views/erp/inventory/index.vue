<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="专用码" prop="uniqueCode">
              <el-input v-model="queryParams.uniqueCode" placeholder="请输入专用码" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="类型" prop="itemType">
              <el-select v-model="queryParams.itemType" placeholder="请选择类型" clearable style="width: 150px">
                <el-option v-for="dict in erp_item_type" :key="dict.value" :label="dict.label" :value="dict.value"/>
              </el-select>
            </el-form-item>
            <el-form-item label="物料名称" prop="itemName">
              <el-input v-model="queryParams.itemName" placeholder="请输入物料名称" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="规格" prop="spec">
              <el-input v-model="queryParams.spec" placeholder="请输入规格" clearable @keyup.enter="handleQuery" />
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
        <el-table-column label="专用码" align="center" prop="uniqueCode" width="120" />
        <el-table-column label="类型" align="center" prop="itemType" width="100">
          <template #default="scope">
            <dict-tag :options="erp_item_type" :value="scope.row.itemType"/>
          </template>
        </el-table-column>
        <el-table-column label="物料名称" align="center" prop="itemName" min-width="150" :show-overflow-tooltip="true" />
        <el-table-column label="规格" align="center" prop="spec" min-width="120" />
        <el-table-column label="库存量" align="center" prop="currentQty" />
        <el-table-column label="单位" align="center" prop="unit">
          <template #default="scope">
            <dict-tag :options="erp_item_unit" :value="scope.row.unit"/>
          </template>
        </el-table-column>
        
        <el-table-column label="供应商/客户" align="center" prop="supplierId" min-width="150" :show-overflow-tooltip="true">
          <template #default="scope">
             <span>{{ supplierOptions.find(opt => opt.id === scope.row.supplierId)?.companyName || scope.row.supplierId }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="采购单价" align="center" prop="purchasePrice" />
        <el-table-column label="总金额" align="center" prop="totalAmount" />
        
        <el-table-column label="操作" align="center" fixed="right" width="150" class-name="small-padding fixed-width">
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

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="600px" append-to-body>
      <el-form ref="inventoryFormRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
            <el-col :span="12">
                <el-form-item label="专用码" prop="uniqueCode">
                  <el-input v-model="form.uniqueCode" placeholder="请输入专用码" />
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="类型" prop="itemType">
                  <el-select v-model="form.itemType" placeholder="请选择类型" style="width: 100%">
                    <el-option v-for="dict in erp_item_type" :key="dict.value" :label="dict.label" :value="dict.value"></el-option>
                  </el-select>
                </el-form-item>
            </el-col>
            <el-col :span="24">
                <el-form-item label="物料名称" prop="itemName">
                  <el-input v-model="form.itemName" placeholder="请输入物料名称" />
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="规格" prop="spec">
                  <el-input v-model="form.spec" placeholder="请输入规格" />
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="单位" prop="unit">
                  <el-select v-model="form.unit" placeholder="请选择" style="width: 100%">
                    <el-option v-for="dict in erp_item_unit" :key="dict.value" :label="dict.label" :value="dict.value"></el-option>
                  </el-select>
                </el-form-item>
            </el-col>
            
            <el-divider content-position="left">库存与财务</el-divider>
            
            <el-col :span="24">
                <el-form-item label="供应商/客户" prop="supplierId">
                  <el-select v-model="form.supplierId" placeholder="请选择供应商/客户" style="width: 100%" filterable clearable>
                    <el-option
                        v-for="item in supplierOptions"
                        :key="item.id"
                        :label="item.companyName"
                        :value="item.id"
                    />
                  </el-select>
                </el-form-item>
            </el-col>
            
            <el-col :span="12">
                <el-form-item label="当前库存" prop="currentQty">
                  <el-input-number v-model="form.currentQty" :min="0" :precision="2" style="width: 100%" @change="calculateTotal"/>
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="采购单价" prop="purchasePrice">
                  <el-input-number v-model="form.purchasePrice" :min="0" :precision="4" style="width: 100%" @change="calculateTotal"/>
                </el-form-item>
            </el-col>
            <el-col :span="12">
                <el-form-item label="总金额" prop="totalAmount">
                  <el-input-number v-model="form.totalAmount" :min="0" :precision="2" style="width: 100%" disabled />
                </el-form-item>
            </el-col>
        </el-row>
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
// 1. 引入客户查询接口
import { listCustomer } from '@/api/erp/customer';

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

// 2. 供应商列表数据
const supplierOptions = ref<any[]>([]);

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
  totalAmount: undefined
}
const data = reactive<PageData<InventoryForm, InventoryQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    uniqueCode: undefined,
    itemType: undefined,
    itemName: undefined,
    spec: undefined,
    // 删除了其他不必要的查询参数
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

/** 3. 获取供应商列表 */
const getSupplierList = async () => {
  // 假设 customerType '2' 代表供应商，根据实际字典值调整
  // pageSize 设置大一些以获取所有供应商
  const res = await listCustomer({ pageNum: 1, pageSize: 1000, customerType: '2' });
  supplierOptions.value = res.rows;
}

/** 4. 自动计算总金额 */
const calculateTotal = () => {
    if (form.value.currentQty && form.value.purchasePrice) {
        form.value.totalAmount = Number((form.value.currentQty * form.value.purchasePrice).toFixed(2));
    }
}

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
      // 解决TS id 类型检查问题
      if ((form.value as any).id) {
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
  getSupplierList(); // 页面加载时获取供应商数据
});
</script>