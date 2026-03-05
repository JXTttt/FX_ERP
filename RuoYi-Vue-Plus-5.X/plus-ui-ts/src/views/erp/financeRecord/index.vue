<template>
  <div class="p-2 app-container">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="流水号" prop="recordNo">
              <el-input v-model="queryParams.recordNo" placeholder="请输入流水号" clearable @keyup.enter="handleQuery" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="收付款对象" prop="targetName">
              <el-input v-model="queryParams.targetName" placeholder="客户/供应商/员工" clearable @keyup.enter="handleQuery" style="width: 150px"/>
            </el-form-item>
            <el-form-item label="资金流向" prop="recordType">
              <el-select v-model="queryParams.recordType" placeholder="请选择" clearable style="width: 120px">
                <el-option label="收入/应收" value="1" />
                <el-option label="支出/应付" value="2" />
              </el-select>
            </el-form-item>
            <el-form-item label="结算状态" prop="settlementStatus">
              <el-select v-model="queryParams.settlementStatus" placeholder="请选择状态" clearable style="width: 120px">
                <el-option label="未结清(挂账)" value="0" />
                <el-option label="部分结清" value="1" />
                <el-option label="已结清" value="2" />
              </el-select>
            </el-form-item>
            
            <el-form-item label="产生时间" style="width: 308px">
              <el-date-picker
                v-model="dateRange"
                value-format="YYYY-MM-DD"
                type="daterange"
                range-separator="-"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
              ></el-date-picker>
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:financeRecord:add']">新增手工账</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" icon="Document" :disabled="multiple" @click="handleBatchSummary" v-hasPermi="['erp:financeRecord:edit']">生成对账单 / 批量核销</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:financeRecord:export']">导出财务报表</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="financeRecordList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="财务流水号" align="center" prop="recordNo" width="180" />
        
        <el-table-column label="资金流向" align="center" prop="recordType" width="100">
          <template #default="scope">
            <el-tag v-if="scope.row.recordType === '1'" type="success" effect="dark">收入/应收</el-tag>
            <el-tag v-else-if="scope.row.recordType === '2'" type="danger" effect="dark">支出/应付</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="业务类型" align="center" prop="businessType" width="100">
          <template #default="scope">
             <el-tag type="info">{{ scope.row.businessType }}</el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="收付款对象" align="center" prop="targetName" min-width="150" show-overflow-tooltip>
          <template #default="scope">
             <strong>{{ scope.row.targetName }}</strong>
          </template>
        </el-table-column>

        <el-table-column label="关联业务单号" align="center" prop="relatedNo" width="150" />

        <el-table-column label="发生金额(元)" align="center" prop="amount" width="130">
          <template #default="scope">
             <span v-if="scope.row.recordType === '1'" style="color: #67C23A; font-weight: bold; font-size: 16px;">
               + {{ Number(scope.row.amount).toFixed(2) }}
             </span>
             <span v-else style="color: #F56C6C; font-weight: bold; font-size: 16px;">
               - {{ Number(scope.row.amount).toFixed(2) }}
             </span>
          </template>
        </el-table-column>

        <el-table-column label="结算状态" align="center" prop="settlementStatus" width="110">
          <template #default="scope">
            <el-tag v-if="scope.row.settlementStatus === '0'" type="danger">未结清(挂账)</el-tag>
            <el-tag v-else-if="scope.row.settlementStatus === '1'" type="warning">部分结清</el-tag>
            <el-tag v-else-if="scope.row.settlementStatus === '2'" type="success">已结清</el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="产生时间" align="center" prop="createTime" width="160">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}') }}</span>
          </template>
        </el-table-column>

        <el-table-column label="备注" align="center" prop="remark" min-width="150" show-overflow-tooltip />
        
        <el-table-column label="操作" align="center" fixed="right" width="160" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button 
              v-if="scope.row.settlementStatus !== '2'" 
              link 
              type="success" 
              icon="Select" 
              @click="handleSettle(scope.row)" 
              v-hasPermi="['erp:financeRecord:edit']"
            >单笔核销</el-button>

            <el-tooltip content="查看详情(防篡改)" placement="top" v-if="scope.row.settlementStatus === '2' || !scope.row.recordNo?.startsWith('FIN-MN-')">
              <el-button link type="success" icon="View" @click="handleView(scope.row)" v-hasPermi="['erp:financeRecord:query']"></el-button>
            </el-tooltip>
            
            <el-tooltip content="修改" placement="top" v-if="scope.row.settlementStatus !== '2' && scope.row.recordNo?.startsWith('FIN-MN-')">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:financeRecord:edit']"></el-button>
            </el-tooltip>
            
            <el-tooltip content="删除" placement="top" v-if="scope.row.settlementStatus !== '2' && scope.row.recordNo?.startsWith('FIN-MN-')">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:financeRecord:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="600px" append-to-body>
      <el-form ref="financeRecordFormRef" :model="form" :rules="rules" label-width="110px" :disabled="isView">
        <el-row>
          <el-col :span="12">
            <el-form-item label="资金流向" prop="recordType">
              <el-select v-model="form.recordType" placeholder="请选择" style="width: 100%">
                <el-option label="收入/应收" value="1" />
                <el-option label="支出/应付" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="业务类型" prop="businessType">
              <el-select v-model="form.businessType" placeholder="请选择" allow-create filterable style="width: 100%">
                <el-option label="销售出货" value="销售出货" />
                <el-option label="采购入库" value="采购入库" />
                <el-option label="委外加工" value="委外加工" />
                <el-option label="临时工费" value="临时工费" />
                <el-option label="日常开销" value="日常开销" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关联业务单号" prop="relatedNo">
              <el-input v-model="form.relatedNo" placeholder="请输入关联单号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="发生金额" prop="amount">
              <el-input-number v-model="form.amount" :min="0" :precision="2" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="收付款对象" prop="targetName">
              <el-input v-model="form.targetName" placeholder="请输入客户/供应商名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结算状态" prop="settlementStatus">
              <el-select v-model="form.settlementStatus" placeholder="请选择状态" style="width: 100%">
                <el-option label="未结清(挂账)" value="0" />
                <el-option label="部分结清" value="1" />
                <el-option label="已结清" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button v-if="!isView" :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">{{ isView ? '关 闭' : '取 消' }}</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="财务对账单明细" v-model="batchDialog.visible" width="900px" append-to-body>
      <el-alert v-if="batchSummary.hasMixed" type="warning" :title="`注意：包含 ${batchSummary.settledCount} 笔已结清和 ${batchSummary.unsettledCount} 笔未结清数据。点击核销将仅处理未结清部分！`" show-icon style="margin-bottom: 10px;" :closable="false" />
      <el-alert v-else-if="batchSummary.isAllSettled" type="success" title="当前为【历史对账单预览】模式，您所勾选的账单均已核销结清。" show-icon style="margin-bottom: 10px;" :closable="false" />
      <el-alert v-else type="info" title="请仔细核对以下对账明细，确认无误后可点击底部按钮进行一键批量核销打款。" show-icon style="margin-bottom: 10px;" :closable="false" />

      <div style="margin-bottom: 15px; padding: 15px; background: #f8f8f9; border-radius: 4px; border: 1px solid #ebeef5;">
        <el-row :gutter="20" style="font-size: 15px;">
          <el-col :span="8"><strong>包含账单总数：</strong> <span style="color: #409EFF; font-weight: bold;">{{ batchSummary.count }} 笔</span></el-col>
          <el-col :span="8"><strong>应收合计(打入)：</strong> <span style="color: #67C23A; font-weight: bold;">+ ￥{{ batchSummary.income.toFixed(2) }}</span></el-col>
          <el-col :span="8"><strong>应付合计(打出)：</strong> <span style="color: #F56C6C; font-weight: bold;">- ￥{{ batchSummary.expense.toFixed(2) }}</span></el-col>
        </el-row>
      </div>

      <el-table :data="selectedRowsToSettle" border max-height="400px" style="margin-bottom: 20px;">
        <el-table-column type="index" width="50" align="center" label="序号" />
        <el-table-column label="财务流水号" align="center" prop="recordNo" width="170" />
        <el-table-column label="业务类型" align="center" prop="businessType" width="100" />
        <el-table-column label="收付款对象" align="center" prop="targetName" show-overflow-tooltip />
        <el-table-column label="发生金额" align="center" prop="amount" width="130">
          <template #default="scope">
             <span v-if="scope.row.recordType === '1'" style="color: #67C23A; font-weight: bold;">+ ￥{{ Number(scope.row.amount).toFixed(2) }}</span>
             <span v-else style="color: #F56C6C; font-weight: bold;">- ￥{{ Number(scope.row.amount).toFixed(2) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="当前状态" align="center" prop="settlementStatus" width="100">
          <template #default="scope">
             <el-tag v-if="scope.row.settlementStatus === '2'" type="success" size="small">已结清</el-tag>
             <el-tag v-else type="danger" size="small">未结清</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="产生时间" align="center" prop="createTime" width="160">
          <template #default="scope"><span>{{ parseTime(scope.row.createTime) }}</span></template>
        </el-table-column>
      </el-table>

      <template #footer>
        <div class="dialog-footer">
          <el-button type="warning" icon="Download" @click="exportBatchDetail" style="float: left;">导出本表为Excel对账单</el-button>
          
          <el-button type="primary" :loading="buttonLoading" v-if="!batchSummary.isAllSettled" @click="confirmBatchSettle">
            {{ batchSummary.hasMixed ? `仅核销其中的 ${batchSummary.unsettledCount} 笔未结单` : '确 认 款 项 已 结 清' }}
          </el-button>
          
          <el-button @click="batchDialog.visible = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup name="FinanceRecord" lang="ts">
import { ref, reactive, toRefs, onMounted, getCurrentInstance } from 'vue';
import { listFinanceRecord, getFinanceRecord, delFinanceRecord, addFinanceRecord, updateFinanceRecord } from '@/api/erp/financeRecord';
import request from '@/utils/request'; 

const { proxy } = getCurrentInstance() as any;

const financeRecordList = ref<any[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const isView = ref(false); 

const dateRange = ref<any>([]);

const queryFormRef = ref<any>();
const financeRecordFormRef = ref<any>();

const dialog = reactive({
  visible: false,
  title: ''
});

const batchDialog = reactive({ visible: false });
const selectedRowsToSettle = ref<any[]>([]);
// 👉 在状态里新增精确的计数器和过滤后的未结算ID列表
const batchSummary = reactive({
  count: 0,
  income: 0,
  expense: 0,
  isAllSettled: false,
  hasMixed: false,
  settledCount: 0,
  unsettledCount: 0,
  unsettledIds: [] as number[]
});

const initFormData = {
  id: undefined,
  recordNo: undefined,
  recordType: '1',
  businessType: undefined,
  relatedNo: undefined,
  targetName: undefined,
  amount: undefined,
  settlementStatus: '0',
  remark: undefined,
}
const data = reactive({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    recordNo: undefined,
    recordType: undefined,
    businessType: undefined,
    relatedNo: undefined,
    targetName: undefined,
    settlementStatus: undefined,
    params: {} 
  },
  rules: {
    recordType: [{ required: true, message: "资金流向不能为空", trigger: "change" }],
    businessType: [{ required: true, message: "业务类型不能为空", trigger: "change" }],
    targetName: [{ required: true, message: "收付款对象不能为空", trigger: "blur" }],
    amount: [{ required: true, message: "发生金额不能为空", trigger: "blur" }],
  }
});

const { queryParams, form, rules } = toRefs(data);

const getList = async () => {
  loading.value = true;
  queryParams.value.params = {};
  if (dateRange.value && dateRange.value.length === 2) {
    (queryParams.value.params as any)['beginTime'] = dateRange.value[0] + ' 00:00:00';
    (queryParams.value.params as any)['endTime'] = dateRange.value[1] + ' 23:59:59';
  }
  
  const res = await listFinanceRecord(queryParams.value);
  financeRecordList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

const cancel = () => {
  reset();
  dialog.visible = false;
}

const reset = () => {
  form.value = {...initFormData};
  financeRecordFormRef.value?.resetFields();
}

const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
}

const resetQuery = () => {
  dateRange.value = []; 
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
  isView.value = false;
  form.value.recordNo = "FIN-MN-" + new Date().getTime().toString().slice(-8);
  dialog.visible = true;
  dialog.title = "新增手工财务账单";
}

const handleUpdate = async (row?: any) => {
  reset();
  isView.value = false;
  const _id = row?.id || ids.value[0]
  const res = await getFinanceRecord(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改财务流水";
}

const handleView = async (row?: any) => {
  reset();
  isView.value = true; 
  const _id = row?.id || ids.value[0]
  const res = await getFinanceRecord(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = row?.settlementStatus === '2' ? "查看财务流水 (已结清，系统锁定)" : "查看财务流水 (业务自动生成，严禁篡改)";
}

// 👉 核心逻辑修改：解析数据并分离未结清的 ID
const handleBatchSummary = () => {
  const selectedRows = financeRecordList.value.filter(item => ids.value.includes(item.id));
  
  selectedRowsToSettle.value = selectedRows;
  batchSummary.count = selectedRows.length;
  
  let income = 0;
  let expense = 0;
  let settledCount = 0;
  let unsettledIds: number[] = [];
  
  selectedRows.forEach(item => {
      if (item.recordType === '1') income += Number(item.amount || 0);
      else if (item.recordType === '2') expense += Number(item.amount || 0);
      
      if (item.settlementStatus === '2') {
          settledCount++;
      } else {
          unsettledIds.push(item.id);
      }
  });
  
  batchSummary.income = income;
  batchSummary.expense = expense;
  batchSummary.settledCount = settledCount;
  batchSummary.unsettledCount = selectedRows.length - settledCount;
  batchSummary.unsettledIds = unsettledIds;
  
  batchSummary.isAllSettled = (settledCount === selectedRows.length);
  batchSummary.hasMixed = (settledCount > 0 && settledCount < selectedRows.length);

  batchDialog.visible = true;
}

// 👉 提交时，只把没结清的 ID 扔给后端去处理
const confirmBatchSettle = async () => {
  buttonLoading.value = true;
  try {
    await request({
       url: '/erp/financeRecord/batchSettle',
       method: 'put',
       data: batchSummary.unsettledIds // 核心：精准打击
    });
    proxy.$modal.msgSuccess(`成功核销 ${batchSummary.unsettledCount} 笔账单！相关源单据已同步结清。`);
    batchDialog.visible = false;
    getList();
  } catch (error) {
    console.error(error);
  } finally {
    buttonLoading.value = false;
  }
}

const exportBatchDetail = () => {
  const nowStr = proxy.parseTime(new Date());
  let html = `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
    <head>
      <meta charset="UTF-8">
      <style>
        table { width: 100%; border-collapse: collapse; font-family: "Microsoft YaHei", sans-serif; }
        td, th { border: 1px solid #000; text-align: center; vertical-align: middle; padding: 5px; }
        .head { font-weight: bold; background-color: #f2f2f2; }
        .red { color: #F56C6C; }
        .green { color: #67C23A; }
      </style>
    </head>
    <body>
      <h2>财务对账明细单</h2>
      <p>导出时间：${nowStr}</p>
      <p><b>包含笔数：</b>${batchSummary.count} 笔 &nbsp;&nbsp;&nbsp;&nbsp; <b>应收合计：</b><span class="green">+ ${batchSummary.income.toFixed(2)}</span> &nbsp;&nbsp;&nbsp;&nbsp; <b>应付合计：</b><span class="red">- ${batchSummary.expense.toFixed(2)}</span></p>
      <table>
        <tr class="head">
          <th>序号</th><th>财务流水号</th><th>资金流向</th><th>业务类型</th><th>收付款对象</th><th>关联业务单号</th><th>发生金额(元)</th><th>状态</th><th>产生时间</th><th>备注</th>
        </tr>`;
  
  selectedRowsToSettle.value.forEach((row, index) => {
    const isIncome = row.recordType === '1';
    const amountStr = isIncome ? `+ ${row.amount}` : `- ${row.amount}`;
    const amountClass = isIncome ? 'green' : 'red';
    const statusStr = row.settlementStatus === '2' ? '已结清' : '未结清';
    
    html += `<tr>
      <td>${index + 1}</td>
      <td style="mso-number-format:'\\@';">${row.recordNo || ''}</td>
      <td>${isIncome ? '收入/应收' : '支出/应付'}</td>
      <td>${row.businessType || ''}</td>
      <td>${row.targetName || ''}</td>
      <td style="mso-number-format:'\\@';">${row.relatedNo || ''}</td>
      <td class="${amountClass}">${amountStr}</td>
      <td>${statusStr}</td>
      <td>${row.createTime || ''}</td>
      <td>${row.remark || ''}</td>
    </tr>`;
  });
  
  html += `</table></body></html>`;
  
  const blob = new Blob([html], { type: 'application/vnd.ms-excel' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `财务对账单_${new Date().getTime()}.xls`; 
  a.click();
  URL.revokeObjectURL(url);
}

const handleSettle = (row: any) => {
  const actionText = row.recordType === '1' ? '收到该笔款项' : '支付该笔款项';
  proxy.$modal.confirm(`确认已${actionText}【￥${row.amount}】，并将其标记为已结清吗？结清后作为财务死账，不可更改或删除！`).then(async () => {
    loading.value = true;
    const submitData = { ...row, settlementStatus: '2' };
    await updateFinanceRecord(submitData);
    proxy.$modal.msgSuccess("单笔核销成功！账单已结清。");
    getList();
  }).catch(() => {});
}

const submitForm = () => {
  financeRecordFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateFinanceRecord(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addFinanceRecord(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

const handleDelete = async (row?: any) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('确认删除该笔财务流水？').finally(() => loading.value = false);
  await delFinanceRecord(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

const handleExport = () => {
  const exportParams: any = JSON.parse(JSON.stringify(queryParams.value));
  exportParams.params = undefined; 
  if (dateRange.value && dateRange.value.length === 2) {
    exportParams['params[beginTime]'] = dateRange.value[0] + ' 00:00:00';
    exportParams['params[endTime]'] = dateRange.value[1] + ' 23:59:59';
  }
  proxy?.download('erp/financeRecord/export', exportParams, `财务流水总表_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>