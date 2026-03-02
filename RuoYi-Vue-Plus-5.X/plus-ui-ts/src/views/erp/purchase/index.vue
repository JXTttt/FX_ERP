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
          <el-option label="待处理" value="0" />
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
      <el-table-column label="关联工单" align="center" prop="relatedWoNo" width="110" />
      <el-table-column label="供应商名称" align="center" prop="supplierId" min-width="150" show-overflow-tooltip>
        <template #default="scope">
          <span>{{ getSupplierName(scope.row.supplierId) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="采购内容" align="center" prop="itemName" min-width="120" show-overflow-tooltip />
      <el-table-column label="规格" align="center" prop="spec" width="100" show-overflow-tooltip />
      <el-table-column label="采购量" align="center" prop="applyQty" width="80">
        <template #default="scope">
          <span style="color: #409EFF; font-weight: bold;">{{ scope.row.applyQty }}</span>
        </template>
      </el-table-column>
      <el-table-column label="验收量" align="center" prop="receivedQty" width="80">
        <template #default="scope">
          <span style="color: #67C23A; font-weight: bold;">{{ scope.row.receivedQty || '--' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="单价" align="center" prop="price" width="80" />
      <el-table-column label="总金额" align="center" prop="totalPrice" width="100">
        <template #default="scope">
          <span v-if="scope.row.totalPrice" style="color: #F56C6C; font-weight: bold;">￥{{ scope.row.totalPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template #default="scope">
          <el-tag v-if="scope.row.status === '0'" type="warning">待处理</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="primary">已批</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="success">已验收</el-tag>
          <el-tag v-else-if="scope.row.status === '3'" type="danger">已驳回</el-tag>
          <span v-else>--</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180" fixed="right">
        <template #default="scope">
          <el-button v-if="['0', '1'].includes(scope.row.status)" link type="success" icon="Check" @click="handleAccept(scope.row)" v-hasPermi="['erp:purchase:edit']">验收</el-button>
          
          <el-button v-if="scope.row.status !== '2'" link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:purchase:edit']">处理</el-button>
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

        <el-divider content-position="left">采购处理与审批</el-divider>
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
            <el-form-item label="审批状态" prop="status">
              <el-select v-model="form.status" style="width: 100%">
                <el-option label="待处理" value="0" />
                <el-option label="已批 (同意采购)" value="1" />
                <el-option label="驳回" value="3" />
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

    <el-dialog title="采购验收与入库" v-model="acceptOpen" width="500px" append-to-body>
      <el-form ref="acceptRef" :model="acceptForm" label-width="110px">
        <el-alert title="确认验收后，货物将自动转入系统库存" type="success" :closable="false" style="margin-bottom: 20px;" />
        <el-form-item label="采购单号">
          <el-input v-model="acceptForm.purchaseNo" disabled />
        </el-form-item>
        <el-form-item label="物品名称">
          <el-input v-model="acceptForm.itemName" disabled />
        </el-form-item>
        <el-form-item label="供应商">
          <el-input :model-value="getSupplierName(acceptForm.supplierId)" disabled />
        </el-form-item>
        <el-form-item label="预计采购量">
          <el-input-number v-model="acceptForm.applyQty" disabled style="width: 100%" />
        </el-form-item>
        <el-form-item label="最终单价" prop="price">
          <el-input-number v-model="acceptForm.price" :precision="4" :step="0.1" :min="0" style="width: 100%" @change="calcAcceptTotal" />
        </el-form-item>
        <el-form-item label="实际收货量" prop="receivedQty">
          <el-input-number v-model="acceptForm.receivedQty" :min="0" style="width: 100%" @change="calcAcceptTotal" />
        </el-form-item>
        <el-form-item label="入库总金额">
          <el-input-number v-model="acceptForm.totalPrice" disabled :precision="2" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="success" @click="submitAccept">确 认 入 库</el-button>
          <el-button @click="acceptOpen = false">取 消</el-button>
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

const purchaseRef = ref<any>(null);

// 验收专属数据
const acceptOpen = ref(false);
const acceptForm = ref<any>({});

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

const calcAcceptTotal = () => {
  if (acceptForm.value.price && acceptForm.value.receivedQty) {
    acceptForm.value.totalPrice = Number((acceptForm.value.price * acceptForm.value.receivedQty).toFixed(2));
  }
}

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
  title.value = "添加手工单";
}

function handleUpdate(row: any) {
  reset();
  const _id = row.id || ids.value[0];
  getPurchase(_id).then(response => {
    form.value = response.data as any;
    if (form.value.supplierId) {
      form.value.supplierId = String(form.value.supplierId);
    }
    // 如果之前是已验收状态的数据被强行打开处理，为了防止下拉框报错，重置为已批
    if (form.value.status === '2') {
        form.value.status = '1'; 
    }
    open.value = true;
    title.value = "处理采购单";
  });
}

// 👉 新增：打开验收弹窗
function handleAccept(row: any) {
  // 把行数据拉取过来，实际收货量默认等于采购量
  acceptForm.value = {
    id: row.id,
    purchaseNo: row.purchaseNo,
    itemName: row.itemName,
    supplierId: row.supplierId,
    spec: row.spec,
    applyQty: row.applyQty,
    receivedQty: row.receivedQty && row.receivedQty > 0 ? row.receivedQty : row.applyQty,
    price: row.price,
    status: '2' // 直接锁定状态为：2-已验收
  };
  calcAcceptTotal(); // 算一下初始总价
  acceptOpen.value = true;
}

// 👉 新增：提交验收
function submitAccept() {
  if (acceptForm.value.receivedQty == null || acceptForm.value.receivedQty <= 0) {
    proxy.$modal.msgError("实际验收量必须大于0！");
    return;
  }
  updatePurchase(acceptForm.value).then(() => {
    proxy.$modal.msgSuccess("验收成功，物资已添加入库！");
    acceptOpen.value = false;
    getList();
  });
}

function submitForm() {
  purchaseRef.value.validate((valid: boolean) => {
    if (valid) {
      if (form.value.id != null) {
        updatePurchase(form.value).then(response => {
          proxy.$modal.msgSuccess("处理成功");
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