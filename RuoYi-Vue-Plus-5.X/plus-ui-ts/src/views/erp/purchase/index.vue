<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="90px">
      <el-form-item label="采购单号" prop="purchaseNo">
        <el-input v-model="queryParams.purchaseNo" placeholder="请输入采购单号" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="关联工单" prop="relatedWoNo">
        <el-input v-model="queryParams.relatedWoNo" placeholder="请输入关联工单编号" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="供应商" prop="supplierId">
        <el-select v-model="queryParams.supplierId" placeholder="请选择供应商" filterable clearable style="width: 200px">
          <el-option v-for="item in supplierList" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
        </el-select>
      </el-form-item>
      <el-form-item label="采购状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 200px">
          <el-option label="待审/待处理" value="0" />
          <el-option label="已批" value="1" />
          <el-option label="已验收" value="2" />
          <el-option label="已驳回" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:purchase:add']">新增手工单</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:purchase:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="purchaseList" @selection-change="handleSelectionChange" border>
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="采购单号" align="center" prop="purchaseNo" width="160" />
      <el-table-column label="关联工单" align="center" prop="relatedWoNo" width="120" />
      <el-table-column label="供应商名称" align="center" prop="supplierId" min-width="150" show-overflow-tooltip>
        <template #default="scope">
          <span>{{ getSupplierName(scope.row.supplierId) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="采购内容" align="center" prop="itemName" min-width="120" show-overflow-tooltip />
      <el-table-column label="规格" align="center" prop="spec" width="100" show-overflow-tooltip />
      <el-table-column label="采购数量" align="center" prop="applyQty" width="100">
        <template #default="scope">
          <span style="color: #409EFF; font-weight: bold;">{{ scope.row.applyQty }}</span>
        </template>
      </el-table-column>
      <el-table-column label="单价" align="center" prop="price" width="80" />
      <el-table-column label="总金额" align="center" prop="totalPrice" width="100">
        <template #default="scope">
          <span v-if="scope.row.totalPrice" style="color: #F56C6C; font-weight: bold;">￥{{ scope.row.totalPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="交货期" align="center" prop="deliveryDate" width="110">
        <template #default="scope">
          <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="warning">待处理</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="primary">已批</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="success">已验收</el-tag>
          <el-tag v-else-if="scope.row.status === '3'" type="danger">已驳回</el-tag>
          <span v-else>--</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150" fixed="right">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:purchase:edit']">处理/修改</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:purchase:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form ref="purchaseRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="采购单号" prop="purchaseNo">
              <el-input v-model="form.purchaseNo" placeholder="系统自动生成" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关联工单" prop="relatedWoNo">
              <el-input v-model="form.relatedWoNo" placeholder="关联工单" :disabled="!!form.id" />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-divider content-position="left">物品信息</el-divider>
        <el-row>
          <el-col :span="24">
            <el-form-item label="物品名称" prop="itemName">
              <el-input v-model="form.itemName" placeholder="请输入采购内容/名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="规格" prop="spec">
              <el-input v-model="form.spec" placeholder="请输入规格" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购数量" prop="applyQty">
              <el-input-number v-model="form.applyQty" :min="1" style="width: 100%" @change="calcTotal" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">采购处理</el-divider>
        <el-row>
          <el-col :span="24">
            <el-form-item label="选择供应商" prop="supplierId">
              <el-select v-model="form.supplierId" placeholder="请搜索并选择供应商" filterable style="width: 100%;">
                <el-option v-for="item in supplierList" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购单价" prop="price">
              <el-input-number v-model="form.price" :precision="4" :step="0.1" :min="0" style="width: 100%" @change="calcTotal" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购总价" prop="totalPrice">
              <el-input-number v-model="form.totalPrice" :precision="2" :min="0" style="width: 100%" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="期望交期" prop="deliveryDate">
              <el-date-picker clearable v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择期望交货期" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="当前状态" prop="status">
              <el-select v-model="form.status" style="width: 100%">
                <el-option label="待处理" value="0" />
                <el-option label="已批" value="1" />
                <el-option label="已验收" value="2" />
                <el-option label="已驳回" value="3" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Purchase" lang="ts">
import { ref, reactive, toRefs, onMounted, getCurrentInstance } from 'vue';
import { listPurchase, getPurchase, delPurchase, addPurchase, updatePurchase } from "@/api/erp/purchase";
import { listCustomer } from "@/api/erp/customer";

const { proxy } = getCurrentInstance() as any;

const purchaseList = ref([]);
const supplierList = ref<any[]>([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<number[]>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

// 👉 新增：原生表单 Ref，替代 proxy.resetForm
const purchaseRef = ref<any>(null);

const data = reactive({
  form: {
    id: undefined,
    purchaseNo: undefined,
    relatedWoNo: undefined,
    supplierId: undefined,
    itemName: undefined,
    spec: undefined,
    applyQty: undefined,
    receivedQty: 0,
    price: undefined,
    totalPrice: undefined,
    status: '0',
    applicantId: undefined,
    deliveryDate: undefined
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    purchaseNo: undefined,
    relatedWoNo: undefined,
    supplierId: undefined,
    status: undefined,
  },
  rules: {
    supplierId: [{ required: true, message: "供应商不能为空", trigger: "change" }],
    itemName: [{ required: true, message: "采购内容不能为空", trigger: "blur" }],
    applyQty: [{ required: true, message: "采购数量不能为空", trigger: "blur" }],
  }
});

const { queryParams, form, rules } = toRefs(data);

const getSupplierList = async () => {
  const res = await listCustomer({ customerType: '2', pageNum: 1, pageSize: 1000 } as any);
  supplierList.value = res.rows;
};

const getSupplierName = (id: any) => {
  if (!id) return '--';
  const supplier = supplierList.value.find(s => String(s.id) === String(id));
  return supplier ? supplier.companyName : id;
};

const calcTotal = () => {
  if (form.value.price && form.value.applyQty) {
    form.value.totalPrice = Number((form.value.price * form.value.applyQty).toFixed(2));
  } else {
    form.value.totalPrice = undefined;
  }
};

function getList() {
  loading.value = true;
  listPurchase(queryParams.value).then(response => {
    purchaseList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

function cancel() {
  open.value = false;
  reset();
}

// 👉 修复：使用原生写法清空表单，绝不报错
function reset() {
  form.value = {
    id: undefined,
    purchaseNo: undefined,
    relatedWoNo: undefined,
    supplierId: undefined,
    itemName: undefined,
    spec: undefined,
    applyQty: undefined,
    receivedQty: 0,
    price: undefined,
    totalPrice: undefined,
    status: '0',
    applicantId: undefined,
    deliveryDate: undefined
  };
  if (purchaseRef.value) {
    purchaseRef.value.resetFields();
  }
}

function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

function resetQuery() {
  if (proxy.$refs["queryRef"]) {
    proxy.$refs["queryRef"].resetFields();
  }
  handleQuery();
}

function handleSelectionChange(selection: any[]) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加手工采购单";
}

// 👉 修复：修改按钮操作
function handleUpdate(row: any) {
  console.log("当前点击的行数据：", row); // 让你在 F12 里能看到到底有没有拿到 ID
  reset();
  
  const _id = row.id || ids.value[0];
  if (!_id) {
    proxy.$modal.msgError("无法获取记录ID，请检查后端是否正确返回了id字段！");
    return;
  }

  getPurchase(_id).then(response => {
    form.value = response.data as any;
    if (form.value.supplierId) {
      form.value.supplierId = String(form.value.supplierId);
    }
    open.value = true;
    title.value = "处理采购单";
  }).catch(err => {
    console.error("获取详情失败:", err);
  });
}

function submitForm() {
  purchaseRef.value.validate((valid: boolean) => {
    if (valid) {
      if (form.value.id != null) {
        updatePurchase(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        if (!form.value.purchaseNo) {
           form.value.purchaseNo = "CG" + new Date().getTime().toString().slice(-8);
        }
        addPurchase(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

function handleDelete(row: any) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除采购单号为"' + (row.purchaseNo || _ids) + '"的数据项？').then(function() {
    return delPurchase(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

function handleExport() {
  proxy.download('erp/purchase/export', {
    ...queryParams.value
  }, `purchase_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getSupplierList();
  getList();
});
</script>

<style scoped>
.el-divider--horizontal {
  margin: 16px 0;
}
</style>