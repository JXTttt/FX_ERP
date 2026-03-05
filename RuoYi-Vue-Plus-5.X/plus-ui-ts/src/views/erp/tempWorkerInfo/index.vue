<template>
  <div class="p-2 app-container">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="临时工姓名" prop="workerName">
              <el-input v-model="queryParams.workerName" placeholder="请输入临时工姓名" clearable @keyup.enter="handleQuery" style="width: 150px" />
            </el-form-item>
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="queryParams.phone" placeholder="请输入联系电话" clearable @keyup.enter="handleQuery" style="width: 150px" />
            </el-form-item>
            <el-form-item label="特长/工种" prop="skills">
              <el-input v-model="queryParams.skills" placeholder="请输入特长/工种" clearable @keyup.enter="handleQuery" style="width: 150px" />
            </el-form-item>
            <el-form-item label="人员状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 120px">
                <el-option label="在职" value="0" />
                <el-option label="离职" value="1" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:tempWorkerInfo:add']">新增档案</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:tempWorkerInfo:export']">导出台账</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="tempWorkerInfoList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="序号" type="index" width="55" align="center" />
        
        <el-table-column label="临时工姓名" align="center" prop="workerName">
          <template #default="scope">
             <strong>{{ scope.row.workerName }}</strong>
          </template>
        </el-table-column>
        <el-table-column label="联系电话" align="center" prop="phone" width="130" />
        <el-table-column label="身份证号" align="center" prop="idCard" min-width="160" />
        <el-table-column label="特长/工种" align="center" prop="skills" width="150">
          <template #default="scope">
             <el-tag type="info" v-if="scope.row.skills">{{ scope.row.skills }}</el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="默认工价(元)" align="center" prop="defaultPrice" width="120">
          <template #default="scope">
             <span style="color: #F56C6C; font-weight: bold;" v-if="scope.row.defaultPrice != null">
               ￥{{ Number(scope.row.defaultPrice).toFixed(2) }}
             </span>
          </template>
        </el-table-column>
        
        <el-table-column label="状态" align="center" prop="status" width="100">
           <template #default="scope">
             <el-tag v-if="scope.row.status === '0'" type="success">在职</el-tag>
             <el-tag v-else-if="scope.row.status === '1'" type="danger">离职</el-tag>
          </template>
        </el-table-column>
        
        <el-table-column label="备注" align="center" prop="remark" min-width="150" show-overflow-tooltip />
        
        <el-table-column label="操作" align="center" fixed="right" width="120" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:tempWorkerInfo:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:tempWorkerInfo:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>
    
    <el-dialog :title="dialog.title" v-model="dialog.visible" width="600px" append-to-body>
      <el-form ref="tempWorkerInfoFormRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="临时工姓名" prop="workerName">
              <el-input v-model="form.workerName" placeholder="请输入临时工姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="身份证号" prop="idCard">
              <el-input v-model="form.idCard" placeholder="请输入身份证号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="特长/工种" prop="skills">
              <el-input v-model="form.skills" placeholder="如: 包装、搬运" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="默认工价" prop="defaultPrice">
              <el-input-number v-model="form.defaultPrice" :min="0" :precision="2" style="width: 100%" placeholder="默认单价(元)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
             <el-form-item label="人员状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio label="0">在职</el-radio>
                <el-radio label="1">离职</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注信息" />
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

<script setup name="TempWorkerInfo" lang="ts">
import { listTempWorkerInfo, getTempWorkerInfo, delTempWorkerInfo, addTempWorkerInfo, updateTempWorkerInfo } from '@/api/erp/tempWorkerInfo';
import { TempWorkerInfoVO, TempWorkerInfoQuery, TempWorkerInfoForm } from '@/api/erp/tempWorkerInfo/types';
import { ComponentInternalInstance, getCurrentInstance, onMounted, reactive, ref, toRefs } from 'vue';
import type { ElForm } from 'element-plus';

type ElFormInstance = InstanceType<typeof ElForm>;

interface DialogOption {
  visible: boolean;
  title: string;
}

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const tempWorkerInfoList = ref<TempWorkerInfoVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<ElFormInstance>();
const tempWorkerInfoFormRef = ref<ElFormInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: TempWorkerInfoForm = {
  id: undefined,
  workerName: undefined,
  phone: undefined,
  idCard: undefined,
  skills: undefined,
  defaultPrice: undefined,
  status: '0', // 👉 默认新增就是“0-在职”状态
  remark: undefined,
}

const data = reactive<any>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    workerName: undefined,
    phone: undefined,
    idCard: undefined,
    skills: undefined,
    status: undefined, // 改为状态搜索
    params: {}
  },
  rules: {
    workerName: [
      { required: true, message: "临时工姓名不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询临时工档案台账列表 */
const getList = async () => {
  loading.value = true;
  const res = await listTempWorkerInfo(queryParams.value);
  tempWorkerInfoList.value = res.rows;
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
  tempWorkerInfoFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: TempWorkerInfoVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加临时工档案";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: TempWorkerInfoVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getTempWorkerInfo(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改临时工档案";
}

/** 提交按钮 */
const submitForm = () => {
  tempWorkerInfoFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateTempWorkerInfo(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addTempWorkerInfo(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: TempWorkerInfoVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除该临时工档案？').finally(() => loading.value = false);
  await delTempWorkerInfo(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('erp/tempWorkerInfo/export', {
    ...queryParams.value
  }, `临时工台账_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>