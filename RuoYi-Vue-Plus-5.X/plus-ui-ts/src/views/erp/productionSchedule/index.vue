<template>
  <div class="p-2 app-container">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="工单编号" prop="workOrderNo">
              <el-input v-model="queryParams.workOrderNo" placeholder="请输入工单编号" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="部件名称" prop="itemName">
              <el-input v-model="queryParams.itemName" placeholder="请输入部件/产品名称" clearable @keyup.enter="handleQuery" />
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
            <div class="color-legend">
              <span class="legend-item"><i class="bg-red"></i> 未开始/缺料</span>
              <span class="legend-item"><i class="bg-yellow"></i> 进行中/打样</span>
              <span class="legend-item"><i class="bg-green"></i> 已完成/齐料</span>
              <span class="legend-item"><i class="bg-white"></i> 无需此工序</span>
            </div>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="matrixList" class="schedule-matrix-table">
        
        <el-table-column label="订单信息" align="center">
          
          <el-table-column label="客户名称" prop="customerName" width="110" fixed="left" align="center" show-overflow-tooltip>
            <template #default="scope">
              <span style="font-weight: bold; color: #1f4a7c;">{{ scope.row.customerName }}</span>
            </template>
          </el-table-column>

          <el-table-column label="部件名称" prop="itemName" width="180" fixed="left" show-overflow-tooltip>
            <template #default="scope">
              <div style="font-weight: bold;">{{ scope.row.itemName }}</div>
              <div style="font-size: 11px; color: #888;">{{ scope.row.workOrderNo }}</div>
            </template>
          </el-table-column>
          <el-table-column label="数量" prop="quantity" width="80" align="center" fixed="left">
            <template #default="scope">
              <span style="color: red; font-weight: bold;">{{ scope.row.quantity }}</span>
            </template>
          </el-table-column>
          <el-table-column label="交货日期" prop="deliveryDate" width="100" align="center" fixed="left">
            <template #default="scope">
              <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
            </template>
          </el-table-column>
        </el-table-column>

        <el-table-column label="前纺信息" align="center">
          <el-table-column label="采购辅料" width="120" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.purchase?.color || 'white')" @click="openEditNode(scope.row.purchase, '采购辅料', scope.row)">
                {{ scope.row.purchase?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="面纸" width="120" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.face_paper?.color || 'white')" @click="openEditNode(scope.row.face_paper, '面纸', scope.row)">
                {{ scope.row.face_paper?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="坑纸" width="120" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.pit_paper?.color || 'white')" @click="openEditNode(scope.row.pit_paper, '坑纸', scope.row)">
                {{ scope.row.pit_paper?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="印刷" width="120" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.print?.color || 'white')" @click="openEditNode(scope.row.print, '印刷', scope.row)">
                {{ scope.row.print?.content }}
              </div>
            </template>
          </el-table-column>
        </el-table-column>

        <el-table-column label="后工序" align="center">
          <el-table-column label="表面处理" width="120" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.surface?.color || 'white')" @click="openEditNode(scope.row.surface, '表面处理', scope.row)">
                {{ scope.row.surface?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="刀模" width="100" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.die_board?.color || 'white')" @click="openEditNode(scope.row.die_board, '刀模', scope.row)">
                {{ scope.row.die_board?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="啤" width="100" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.die_cut?.color || 'white')" @click="openEditNode(scope.row.die_cut, '啤', scope.row)">
                {{ scope.row.die_cut?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="裱坑" width="100" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.mounting?.color || 'white')" @click="openEditNode(scope.row.mounting, '裱坑', scope.row)">
                {{ scope.row.mounting?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="粘盒" width="100" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.gluing?.color || 'white')" @click="openEditNode(scope.row.gluing, '粘盒', scope.row)">
                {{ scope.row.gluing?.content }}
              </div>
            </template>
          </el-table-column>
          <el-table-column label="打包" width="100" align="center">
            <template #default="scope">
              <div class="cell-box" :class="'bg-' + (scope.row.packing?.color || 'white')" @click="openEditNode(scope.row.packing, '打包', scope.row)">
                {{ scope.row.packing?.content }}
              </div>
            </template>
          </el-table-column>
        </el-table-column>

      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="nodeDialog.title" v-model="nodeDialog.visible" width="500px" append-to-body>
      <el-form ref="nodeFormRef" :model="nodeForm" label-width="80px">
        <el-form-item label="当前部件">
          <strong>{{ currentNodeRow?.itemName }}</strong>
        </el-form-item>
        <el-form-item label="节点状态">
          <el-radio-group v-model="nodeForm.statusColor">
            <el-radio label="red" border class="radio-red">未开始(红)</el-radio>
            <el-radio label="yellow" border class="radio-yellow">进行中(黄)</el-radio>
            <el-radio label="green" border class="radio-green">已完成(绿)</el-radio>
            <el-radio label="white" border>无(白)</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="详细内容">
          <el-input 
            v-model="nodeForm.content" 
            type="textarea" 
            :rows="5" 
            placeholder="输入排产日期、供应商、缺料原因等" 
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitNodeEdit" :loading="submitLoading">确 定 保 存</el-button>
          <el-button @click="nodeDialog.visible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup lang="ts" name="ScheduleMatrix">
import { ref, reactive, onMounted, getCurrentInstance } from 'vue';
import { listMatrix, updateScheduleNode } from '@/api/erp/schedule'; // 确认为你第一步新建的API路径

const { proxy } = getCurrentInstance() as any;

const matrixList = ref([]);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const submitLoading = ref(false);

const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  workOrderNo: undefined,
  itemName: undefined
});

// 节点编辑弹窗相关
const nodeDialog = reactive({ visible: false, title: '' });
const nodeForm = ref({
  id: undefined,
  statusColor: 'white',
  content: ''
});
const currentNodeRow = ref<any>(null); // 记录正在编辑的哪一行（仅用于展示标题）

// 查询列表
const getList = async () => {
  loading.value = true;
  try {
    const res = await listMatrix(queryParams);
    matrixList.value = res.rows;
    total.value = res.total;
  } finally {
    loading.value = false;
  }
};

// 搜索 & 重置
const handleQuery = () => {
  queryParams.pageNum = 1;
  getList();
};
const resetQuery = () => {
  proxy.$refs['queryFormRef'].resetFields();
  handleQuery();
};

// 点击格子，打开编辑弹窗
const openEditNode = (nodeData: any, nodeName: string, row: any) => {
  if (!nodeData || !nodeData.id) {
    proxy.$modal.msgWarning("该节点数据异常或不存在");
    return;
  }
  currentNodeRow.value = row;
  nodeDialog.title = `更新状态 - [ ${nodeName} ]`;
  nodeForm.value = {
    id: nodeData.id,
    statusColor: nodeData.color,
    content: nodeData.content
  };
  nodeDialog.visible = true;
};

// 提交格子修改
const submitNodeEdit = async () => {
  submitLoading.value = true;
  try {
    // 构造请求给后端的 BO 对象。只要传 id, statusColor, content 即可更新
    const reqData = {
      id: nodeForm.value.id,
      statusColor: nodeForm.value.statusColor,
      content: nodeForm.value.content
    };
    await updateScheduleNode(reqData);
    proxy.$modal.msgSuccess("更新成功");
    nodeDialog.visible = false;
    // 局部刷新列表
    getList();
  } finally {
    submitLoading.value = false;
  }
};

onMounted(() => {
  getList();
});
</script>

<style lang="scss" scoped>
/* 颜色图例 */
.color-legend {
  display: flex;
  align-items: center;
  gap: 15px;
  font-size: 13px;
  color: #606266;
  margin-top: 5px;
  .legend-item {
    display: flex;
    align-items: center;
    i {
      display: inline-block;
      width: 16px;
      height: 16px;
      border-radius: 3px;
      margin-right: 5px;
      border: 1px solid #ccc;
    }
  }
}

/* 矩阵表定制样式 */
.schedule-matrix-table {
  :deep(.el-table__body-wrapper) {
    // 单元格去掉 padding 方便填满
    td.el-table__cell {
      padding: 0;
      .cell {
        padding: 0;
        height: 100%;
        display: flex;
        flex-direction: column;
      }
    }
  }

  /* 每一个可点击的格子 */
  .cell-box {
    width: 100%;
    min-height: 80px; /* 保证格子够大，像 Excel 一样 */
    padding: 8px;
    cursor: pointer;
    white-space: pre-wrap; /* 允许换行 */
    font-size: 12px;
    line-height: 1.4;
    transition: opacity 0.2s;
    flex-grow: 1;

    &:hover {
      opacity: 0.8;
      box-shadow: inset 0 0 10px rgba(0,0,0,0.1);
    }
  }
}

/* 定义排产大表的背景色系（精准还原 Excel 感觉） */
.bg-red { background-color: #ff4d4f !important; color: #ffffff !important; }
.bg-yellow { background-color: #faad14 !important; color: #000000 !important; }
.bg-green { background-color: #52c41a !important; color: #ffffff !important; }
.bg-white { background-color: #ffffff !important; color: #333333 !important; }

/* 弹窗里的单选框颜色加强 */
:deep(.radio-red.is-checked .el-radio__inner) { background: #ff4d4f; border-color: #ff4d4f; }
:deep(.radio-red.is-checked .el-radio__label) { color: #ff4d4f; }
:deep(.radio-yellow.is-checked .el-radio__inner) { background: #faad14; border-color: #faad14; }
:deep(.radio-yellow.is-checked .el-radio__label) { color: #faad14; }
:deep(.radio-green.is-checked .el-radio__inner) { background: #52c41a; border-color: #52c41a; }
:deep(.radio-green.is-checked .el-radio__label) { color: #52c41a; }
</style>