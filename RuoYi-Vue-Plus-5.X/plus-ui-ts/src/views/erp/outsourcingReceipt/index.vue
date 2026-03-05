<template>
  <div class="p-2 app-container">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="收货单号" prop="receiptNo">
              <el-input v-model="queryParams.receiptNo" placeholder="请输入收货单号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="关联工单号" prop="workOrderNo">
              <el-input v-model="queryParams.workOrderNo" placeholder="请输入关联工单号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="加工商" prop="supplierId">
              <el-select v-model="queryParams.supplierId" placeholder="请选择加工商" filterable clearable style="width: 200px">
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
            <el-form-item label="状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 120px">
                <el-option label="待入库" value="0" />
                <el-option label="已验收结算" value="1" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:outsourcingReceipt:add']">手工录入</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:outsourcingReceipt:export']">导出明细</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="outsourcingReceiptList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="收货单号" align="center" prop="receiptNo" width="160" />
        <el-table-column label="关联工单" align="center" prop="workOrderNo" width="130" />
        <el-table-column label="产品/材料" align="center" prop="productName" min-width="120" show-overflow-tooltip />
        <el-table-column label="加工工序" align="center" prop="processProject" width="120" />
        
        <el-table-column label="加工商" align="center" prop="supplierId" min-width="150" show-overflow-tooltip>
          <template #default="scope">
             <span>{{ getSupplierName(scope.row.supplierId) }}</span>
          </template>
        </el-table-column>

        <el-table-column label="发出量" align="center" prop="sentQty" width="80" />
        <el-table-column label="验收量" align="center" prop="receivedQty" width="80">
           <template #default="scope">
             <span style="color: #67C23A; font-weight: bold;">{{ scope.row.receivedQty }}</span>
           </template>
        </el-table-column>
        <el-table-column label="算价方式" align="center" prop="priceMethod" width="80" />
        <el-table-column label="结算单价" align="center" prop="unitPrice" width="90" />
        <el-table-column label="加工费" align="center" prop="totalFee" width="110">
          <template #default="scope">
             <span style="color: #F56C6C; font-weight: bold;">￥{{ scope.row.totalFee }}</span>
          </template>
        </el-table-column>
        <el-table-column label="收货日期" align="center" prop="receiptDate" width="110">
          <template #default="scope">
            <span>{{ parseTime(scope.row.receiptDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" prop="status" width="100" fixed="right">
          <template #default="scope">
            <el-tag v-if="scope.row.status === '0'" type="warning">待入库</el-tag>
            <el-tag v-else-if="scope.row.status === '1'" type="success">已结算</el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="操作" align="center" fixed="right" width="160" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button 
              v-if="scope.row.status === '0'" 
              link 
              type="primary" 
              icon="Edit" 
              @click="handleUpdate(scope.row)" 
              v-hasPermi="['erp:outsourcingReceipt:edit']"
            >验收登记</el-button>

            <el-tooltip content="删除" placement="top" v-if="scope.row.status === '0'">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:outsourcingReceipt:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="700px" append-to-body>
      <el-form ref="outsourcingReceiptFormRef" :model="form" :rules="rules" label-width="110px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="收货单号" prop="receiptNo">
              <el-input v-model="form.receiptNo" placeholder="系统自动生成" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="收货日期" prop="receiptDate">
              <el-date-picker clearable v-model="form.receiptDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择收货日期" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关联工单号" prop="workOrderNo">
              <el-input v-model="form.workOrderNo" placeholder="请输入关联工单号" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="产品/材料" prop="productName">
              <el-input v-model="form.productName" placeholder="请输入产品/材料名称" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="加工工序" prop="processProject">
              <el-input v-model="form.processProject" placeholder="请输入加工工序" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="加工商" prop="supplierId">
              <el-select v-model="form.supplierId" placeholder="请选择加工商" filterable style="width: 100%" disabled>
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.companyName" :value="String(item.id)" />
              </el-select>
            </el-form-item>
          </el-col>
          
          <el-divider content-position="left">结算确认信息 (请核对金额)</el-divider>

          <el-col :span="12">
            <el-form-item label="发出数量" prop="sentQty">
              <el-input-number v-model="form.sentQty" :min="0" style="width: 100%" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实际验收量" prop="receivedQty">
              <el-input-number v-model="form.receivedQty" :min="0" style="width: 100%" @change="calcFee" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="算价方式" prop="priceMethod">
              <el-select v-model="form.priceMethod" style="width: 100%" disabled>
                <el-option label="平方米" value="平方米"/><el-option label="张" value="张"/><el-option label="套" value="套"/>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结算单价" prop="unitPrice">
              <el-input-number v-model="form.unitPrice" :precision="4" :step="0.1" :min="0" style="width: 100%" @change="calcFee" placeholder="请填入最终单价" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="加工总费" prop="totalFee">
              <el-input-number v-model="form.totalFee" :precision="2" style="width: 100%" placeholder="系统自动计算" />
            </el-form-item>
          </el-col>
          
          <el-col :span="12">
            <el-form-item label="当前状态" prop="status">
              <el-select v-model="form.status" style="width: 100%">
                <el-option label="待入库 (仅保存)" value="0" />
                <el-option label="已验收结算 (将产生财务流水)" value="1" />
              </el-select>
            </el-form-item>
          </el-col>
          
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 认 提 交</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="OutsourcingReceipt" lang="ts">
import { ref, reactive, toRefs, onMounted, getCurrentInstance } from 'vue';
import { listOutsourcingReceipt, getOutsourcingReceipt, delOutsourcingReceipt, addOutsourcingReceipt, updateOutsourcingReceipt } from '@/api/erp/outsourcingReceipt';
import { listCustomer } from '@/api/erp/customer';

const { proxy } = getCurrentInstance() as any;

const outsourcingReceiptList = ref<any[]>([]);
const customerOptions = ref<any[]>([]); 
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<any>();
const outsourcingReceiptFormRef = ref<any>();

const dialog = reactive({
  visible: false,
  title: ''
});

const initFormData = {
  id: undefined,
  receiptNo: undefined,
  workOrderNo: undefined,
  productName: undefined,
  processProject: undefined,
  supplierId: undefined,
  sentQty: undefined,
  receivedQty: undefined,
  priceMethod: '张',
  unitPrice: undefined,
  totalFee: undefined,
  receiptDate: proxy.parseTime(new Date(), '{y}-{m}-{d}'),
  status: '0',
  remark: undefined,
}
const data = reactive({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    receiptNo: undefined,
    workOrderNo: undefined,
    supplierId: undefined,
    status: undefined,
  },
  rules: {
    workOrderNo: [{ required: true, message: "关联工单号不能为空", trigger: "blur" }],
    processProject: [{ required: true, message: "加工工序不能为空", trigger: "blur" }],
    supplierId: [{ required: true, message: "加工商不能为空", trigger: "change" }],
    receivedQty: [{ required: true, message: "实际验收数量不能为空", trigger: "blur" }],
    // 👉 保留了必填校验，因为在弹窗里必须填了才能结算
    unitPrice: [{ required: true, message: "结算单价不能为空", trigger: "blur" }],
    totalFee: [{ required: true, message: "结算加工费不能为空", trigger: "blur" }],
    receiptDate: [{ required: true, message: "收货日期不能为空", trigger: "blur" }],
  }
});

const { queryParams, form, rules } = toRefs(data);

const getCustomerList = async () => {
  const res = await listCustomer({ customerType: '2', pageNum: 1, pageSize: 1000 } as any);
  customerOptions.value = res.rows;
};

const getSupplierName = (id: any) => {
  if (!id) return '--';
  const supplier = customerOptions.value.find(s => String(s.id) === String(id));
  return supplier ? supplier.companyName : id;
};

// 自动计算加工费
const calcFee = () => {
  if (form.value.receivedQty && form.value.unitPrice) {
      // 注意：这里我们简写了，如果是平方米等特殊算法，需要结合 finishSize 的长宽算。
      // 但对于财务确认框，多数情况下加工费 = 验收量 * 结算单价
      form.value.totalFee = Number((form.value.receivedQty * form.value.unitPrice).toFixed(2));
  }
};

const getList = async () => {
  loading.value = true;
  const res = await listOutsourcingReceipt(queryParams.value);
  outsourcingReceiptList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

const cancel = () => {
  reset();
  dialog.visible = false;
}

const reset = () => {
  form.value = {...initFormData};
  outsourcingReceiptFormRef.value?.resetFields();
}

const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
}

const resetQuery = () => {
  queryFormRef.value?.resetFields();
  handleQuery();
}

const handleSelectionChange = (selection: any[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

const handleAdd = () => {
  reset();
  form.value.receiptNo = "OSR" + new Date().getTime().toString().slice(-8);
  dialog.visible = true;
  dialog.title = "手工录入委外收货";
}

const handleUpdate = async (row?: any) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getOutsourcingReceipt(_id);
  Object.assign(form.value, res.data);
  if (form.value.supplierId) form.value.supplierId = String(form.value.supplierId);
  dialog.visible = true;
  dialog.title = "验收与财务登记确认";
}

const submitForm = () => {
  outsourcingReceiptFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      // 如果用户选择了“已验收结算”，弹出一个警告确认一下，毕竟这会抛账
      if (form.value.status === '1') {
         proxy.$modal.confirm(`您将此单据设为了【已验收结算】，系统将立即抛送一笔 ￥${form.value.totalFee} 的财务流水，是否继续？`).then(async () => {
             doSubmit();
         }).catch(() => {});
      } else {
         doSubmit();
      }
    }
  });
}

const doSubmit = async () => {
   buttonLoading.value = true;
   if (form.value.id) {
     await updateOutsourcingReceipt(form.value).finally(() =>  buttonLoading.value = false);
   } else {
     if (!form.value.receiptNo) {
         form.value.receiptNo = "OSR" + new Date().getTime().toString().slice(-8);
     }
     await addOutsourcingReceipt(form.value).finally(() =>  buttonLoading.value = false);
   }
   proxy?.$modal.msgSuccess("操作成功！");
   dialog.visible = false;
   await getList();
}

const handleDelete = async (row?: any) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除委外收货单？').finally(() => loading.value = false);
  await delOutsourcingReceipt(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

const handleExport = () => {
  proxy?.download('erp/outsourcingReceipt/export', {
    ...queryParams.value
  }, `outsourcingReceipt_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getCustomerList();
  getList();
});
</script>