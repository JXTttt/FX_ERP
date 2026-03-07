<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="关联排产主表ID" prop="scheduleId">
              <el-input v-model="queryParams.scheduleId" placeholder="请输入关联排产主表ID" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="工序编码(如:print, gluing等)" prop="nodeCode">
              <el-input v-model="queryParams.nodeCode" placeholder="请输入工序编码(如:print, gluing等)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="工序名称(供参考)" prop="nodeName">
              <el-input v-model="queryParams.nodeName" placeholder="请输入工序名称(供参考)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="状态颜色(red, yellow, green, white)" prop="statusColor">
              <el-input v-model="queryParams.statusColor" placeholder="请输入状态颜色(red, yellow, green, white)" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="格子填写的具体内容(日期/文字)" prop="content">
              <el-input v-model="queryParams.content" placeholder="请输入格子填写的具体内容(日期/文字)" clearable @keyup.enter="handleQuery" />
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
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:scheduleNode:add']">新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['erp:scheduleNode:edit']">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['erp:scheduleNode:remove']">删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['erp:scheduleNode:export']">导出</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="scheduleNodeList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="节点主键ID" align="center" prop="id" v-if="true" />
        <el-table-column label="关联排产主表ID" align="center" prop="scheduleId" />
        <el-table-column label="工序编码(如:print, gluing等)" align="center" prop="nodeCode" />
        <el-table-column label="工序名称(供参考)" align="center" prop="nodeName" />
        <el-table-column label="状态颜色(red, yellow, green, white)" align="center" prop="statusColor" />
        <el-table-column label="格子填写的具体内容(日期/文字)" align="center" prop="content" />
        <el-table-column label="操作" align="center" fixed="right" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['erp:scheduleNode:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['erp:scheduleNode:remove']"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="500px" append-to-body>
      <el-form ref="scheduleNodeFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="工序名称(供参考)" prop="nodeName">
          <el-input v-model="form.nodeName" placeholder="请输入工序名称(供参考)" />
        </el-form-item>
        <el-form-item label="状态颜色(red, yellow, green, white)" prop="statusColor">
          <el-input v-model="form.statusColor" placeholder="请输入状态颜色(red, yellow, green, white)" />
        </el-form-item>
        <el-form-item label="格子填写的具体内容(日期/文字)" prop="content">
          <el-input v-model="form.content" placeholder="请输入格子填写的具体内容(日期/文字)" />
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

<script setup name="ScheduleNode" lang="ts">
import { ComponentInternalInstance, getCurrentInstance, onMounted, reactive, ref, toRefs } from 'vue';
import { listScheduleNode, getScheduleNode, delScheduleNode, addScheduleNode, updateScheduleNode } from '@/api/erp/scheduleNode';
import { ScheduleNodeVO, ScheduleNodeQuery } from '@/api/erp/scheduleNode/types';
import type { FormInstance } from 'element-plus';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const scheduleNodeList = ref<ScheduleNodeVO[]>([]);
const buttonLoading = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);

const queryFormRef = ref<FormInstance>();
const scheduleNodeFormRef = ref<FormInstance>();

const dialog = reactive<any>({
  visible: false,
  title: ''
});

// 👉 核心修改点：将泛型移除或设为any，并显式指定 id
const initFormData: any = {
  id: undefined,
  nodeName: undefined,
  statusColor: undefined,
  content: undefined,
}

// 👉 核心修改点：使用 any 绕过类型推断报错
const data = reactive<PageData<any, ScheduleNodeQuery>>({
  form: {...initFormData},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    scheduleId: undefined,
    nodeCode: undefined,
    nodeName: undefined,
    statusColor: undefined,
    content: undefined,
    params: {
    }
  },
  rules: {
    nodeName: [
      { required: true, message: "工序名称(供参考)不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询排产工序节点状态列表 */
const getList = async () => {
  loading.value = true;
  const res = await listScheduleNode(queryParams.value);
  scheduleNodeList.value = res.rows;
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
  scheduleNodeFormRef.value?.resetFields();
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
const handleSelectionChange = (selection: ScheduleNodeVO[]) => {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset();
  dialog.visible = true;
  dialog.title = "添加排产工序节点状态";
}

/** 修改按钮操作 */
const handleUpdate = async (row?: ScheduleNodeVO) => {
  reset();
  const _id = row?.id || ids.value[0]
  const res = await getScheduleNode(_id);
  Object.assign(form.value, res.data);
  dialog.visible = true;
  dialog.title = "修改排产工序节点状态";
}

/** 提交按钮 */
const submitForm = () => {
  scheduleNodeFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      buttonLoading.value = true;
      if (form.value.id) {
        await updateScheduleNode(form.value).finally(() =>  buttonLoading.value = false);
      } else {
        await addScheduleNode(form.value).finally(() =>  buttonLoading.value = false);
      }
      proxy?.$modal.msgSuccess("操作成功");
      dialog.visible = false;
      await getList();
    }
  });
}

/** 删除按钮操作 */
const handleDelete = async (row?: ScheduleNodeVO) => {
  const _ids = row?.id || ids.value;
  await proxy?.$modal.confirm('是否确认删除排产工序节点状态编号为"' + _ids + '"的数据项？').finally(() => loading.value = false);
  await delScheduleNode(_ids);
  proxy?.$modal.msgSuccess("删除成功");
  await getList();
}

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download('erp/scheduleNode/export', {
    ...queryParams.value
  }, `scheduleNode_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList();
});
</script>