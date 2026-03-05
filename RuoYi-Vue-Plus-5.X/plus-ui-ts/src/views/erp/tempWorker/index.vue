<template>
  <div class="p-2 app-container">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="临时工姓名" prop="workerName">
              <el-select v-model="queryParams.workerName" placeholder="请选择" filterable clearable style="width: 150px">
                <el-option v-for="item in workerOptions" :key="item.id" :label="item.workerName" :value="item.workerName" />
              </el-select>
            </el-form-item>
            <el-form-item label="关联工单号" prop="relatedWoNo">
              <el-input v-model="queryParams.relatedWoNo" placeholder="请输入关联工单号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="计费方式" prop="workType">
              <el-select v-model="queryParams.workType" placeholder="请选择" clearable style="width: 120px">
                <el-option label="计时" value="1" />
                <el-option label="计件" value="2" />
              </el-select>
            </el-form-item>
            <el-form-item label="支付状态" prop="payStatus">
              <el-select v-model="queryParams.payStatus" placeholder="请选择" clearable style="width: 120px">
                <el-option label="未付" value="0" />
                <el-option label="已付" value="1" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:tempWorker:add']">新增登记</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:tempWorker:export']">导出明细</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="tempWorkerList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="工作日期" align="center" prop="workDate" width="120">
          <template #default="scope">
            <span>{{ parseTime(scope.row.workDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="姓名" align="center" prop="workerName" width="120" />
        <el-table-column label="关联工单号" align="center" prop="relatedWoNo" min-width="120" />
        
        <el-table-column label="计费方式" align="center" prop="workType" width="100">
          <template #default="scope">
            <el-tag v-if="scope.row.workType === '1'" type="warning">计时</el-tag>
            <el-tag v-else-if="scope.row.workType === '2'" type="success">计件</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="数量/时长" align="center" prop="workQty" width="100">
          <template #default="scope">
             <span style="font-weight: bold">{{ scope.row.workQty }}</span>
          </template>
        </el-table-column>
        <el-table-column label="单价(元)" align="center" prop="unitPrice" width="100" />
        <el-table-column label="总薪资" align="center" prop="totalAmount" width="120">
          <template #default="scope">
             <span style="color: #F56C6C; font-weight: bold;">￥{{ scope.row.totalAmount }}</span>
          </template>
        </el-table-column>
        
        <el-table-column label="状态" align="center" prop="payStatus" width="100">
           <template #default="scope">
            <el-tag v-if="scope.row.payStatus === '0'" type="danger">未付(挂账)</el-tag>
            <el-tag v-else-if="scope.row.payStatus === '1'" type="success">已付(结清)</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="工作内容描述" align="center" prop="remark" show-overflow-tooltip min-width="150" />
        
        <el-table-column label="操作" align="center" fixed="right" width="120" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top" v-if="scope.row.payStatus === '0'">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:tempWorker:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top" v-if="scope.row.payStatus === '0'">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:tempWorker:remove']"></el-button>
            </el-tooltip>
            
            <span v-if="scope.row.payStatus === '1'" style="color: #909399; font-size: 12px;">
              <el-icon><Lock /></el-icon> 已锁定
            </span>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="650px" append-to-body>
      <el-form ref="tempWorkerFormRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          
          <el-col :span="12">
            <el-form-item label="临时工姓名" prop="workerName">
              <el-select 
                v-model="form.workerName" 
                placeholder="请选择人员" 
                filterable 
                allow-create
                style="width: 100%"
                @change="handleWorkerChange"
              >
                <el-option v-for="item in workerOptions" :key="item.id" :label="item.workerName" :value="item.workerName">
                   <span style="float: left">{{ item.workerName }}</span>
                   <span style="float: right; color: #8492a6; font-size: 12px">单价: ￥{{ item.defaultPrice || 0 }}</span>
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          
          <el-col :span="12">
            <el-form-item label="工作日期" prop="workDate">
              <el-date-picker clearable
                v-model="form.workDate"
                type="date"
                value-format="YYYY-MM-DD 00:00:00"
                placeholder="请选择日期"
                style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
          
          <el-col :span="12">
            <el-form-item label="计费方式" prop="workType">
              <el-select v-model="form.workType" placeholder="请选择" style="width: 100%">
                <el-option label="计时" value="1" />
                <el-option label="计件" value="2" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="支付状态" prop="payStatus">
              <el-select v-model="form.payStatus" disabled style="width: 100%">
                <el-option label="未付(挂账)" value="0" />
                <el-option label="已付(结清)" value="1" />
              </el-select>
            </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="数量/时长" prop="workQty">
              <el-input-number v-model="form.workQty" :min="0" :precision="2" style="width: 100%" @change="calcTotal" placeholder="小时或件数" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="单价" prop="unitPrice">
              <el-input-number v-model="form.unitPrice" :min="0" :precision="4" style="width: 100%" @change="calcTotal" placeholder="单价" />
            </el-form-item>
          </el-col>
          
          <el-col :span="12">
            <el-form-item label="总薪资" prop="totalAmount">
              <el-input-number v-model="form.totalAmount" :min="0" :precision="2" style="width: 100%" disabled placeholder="自动计算" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关联工单号" prop="relatedWoNo">
              <el-input v-model="form.relatedWoNo" placeholder="可为空" />
            </el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="工作描述" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入具体做了什么工作" />
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

<script setup name="TempWorker" lang="ts">
import { ref, reactive, toRefs, onMounted, getCurrentInstance } from 'vue';
import { listTempWorker, getTempWorker, delTempWorker, addTempWorker, updateTempWorker } from '@/api/erp/tempWorker';

// 👉 引入刚刚自动生成的临时工档案表 API
import { listTempWorkerInfo } from '@/api/erp/tempWorkerInfo'; 

const { proxy } = getCurrentInstance() as any;

const tempWorkerList = ref<any[]>([]);
const workerOptions = ref<any[]>([]); // 存放查出来的临时工档案下拉列表

const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<any>();
const tempWorkerFormRef = ref<any>();

const dialog = reactive({
  visible: false,
  title: ''
});

const initFormData = {
  id: undefined,
  workerName: undefined,
  workDate: proxy.parseTime(new Date(), '{y}-{m}-{d} 00:00:00'), // 默认填上今天
  relatedWoNo: undefined,
  workType: '1', // 默认计时
  workQty: undefined,
  unitPrice: undefined,
  totalAmount: undefined,
  payStatus: '0', // 默认挂账未付，由财务去改
  remark: undefined,
}
const data = reactive({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    workerName: undefined,
    workDate: undefined,
    relatedWoNo: undefined,
    workType: undefined,
    payStatus: undefined,
  },
  rules: {
    workerName: [{ required: true, message: "临时工姓名不能为空", trigger: "change" }],
    workDate: [{ required: true, message: "工作日期不能为空", trigger: "blur" }],
    workType: [{ required: true, message: "计费方式不能为空", trigger: "change" }],
    workQty: [{ required: true, message: "数量/时长不能为空", trigger: "blur" }],
    unitPrice: [{ required: true, message: "单价不能为空", trigger: "blur" }]
  }
});

const { queryParams, form, rules } = toRefs(data);

// 👉 获取档案台账里的临时工（只查在职的，假设 status='0' 是在职）
const getWorkerList = async () => {
  try {
     const res = await listTempWorkerInfo({ status: '0', pageNum: 1, pageSize: 500 } as any);
     workerOptions.value = res.rows || [];
  } catch(e) {
     console.error("加载临时工档案失败");
  }
}

// 👉 核心联动：选人后自动带出单价并算钱
const handleWorkerChange = (val: string) => {
  const worker = workerOptions.value.find(w => w.workerName === val);
  if (worker && worker.defaultPrice != null) {
     form.value.unitPrice = Number(worker.defaultPrice);
     calcTotal(); // 如果已经填了工时，自动算总价
     proxy.$modal.msgSuccess(`已自动带入【${val}】的默认工价：￥${worker.defaultPrice}`);
  }
};

const calcTotal = () => {
  if (form.value.workQty != null && form.value.unitPrice != null) {
    form.value.totalAmount = Number((form.value.workQty * form.value.unitPrice).toFixed(2));
  } else {
    form.value.totalAmount = undefined;
  }
};

const getList = async () => {
  loading.value = true;
  const res = await listTempWorker(queryParams.value);
  tempWorkerList.value = res.rows;
  total.value = res.total;
  loading.value = false;
}

const cancel = () => {
  reset();
  dialog.visible = false;
}

const reset = () => {
  form.value = {...initFormData};
  tempWorkerFormRef.value?.resetFields();
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

const handleAdd = async () => {
  reset();
  await getWorkerList(); // 核心：每次点新增，强行拉取最新临时工档案
  dialog.visible = true;
  dialog.title = "添加临时工费用登记";
}

const handleUpdate = async (row?: any) => {
  reset();
  await getWorkerList(); // 核心：每次点修改，强行拉取最新临时工档案
  const _id = row?.id || ids.value[0]
  const res = await getTempWorker(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改临时工费用登记";
}

const submitForm = () => {
  tempWorkerFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      calcTotal();
      buttonLoading.value = true;
      if (form.value.id) {
        await updateTempWorker(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addTempWorker(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("保存成功！财务应付账单已同步更新。");
      dialog.visible = false;
      await getList();
    }
  });
}

const handleDelete = async (row?: any) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('确认删除？对应的财务挂账流水必须手动前往财务页面撤销！').finally(() => loading.value = false);
  await delTempWorker(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

const handleExport = () => {
  proxy?.download('erp/tempWorker/export', {
    ...queryParams.value
  }, `tempWorker_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  //getWorkerList(); // 页面加载时查询临时工档案
  getList();
});
</script>