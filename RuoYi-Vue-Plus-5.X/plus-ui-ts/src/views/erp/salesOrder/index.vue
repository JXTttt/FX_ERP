<template>
  <div class="p-2 app-container">
    <el-card shadow="hover" class="mb-[10px]">
      <el-form :model="queryParams" ref="queryFormRef" :inline="true">
        <el-form-item label="客户名称" prop="customerName">
          <el-input v-model="queryParams.customerName" placeholder="请输入客户名称" clearable @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="订单编号" prop="orderNo">
          <el-input v-model="queryParams.orderNo" placeholder="请输入订单编号" clearable @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never">
      <template #header>
        <el-row :gutter="10">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['erp:salesOrder:add']">新增订单</el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" border :data="salesOrderList">
        <el-table-column label="订单编号" align="center" prop="orderNo" width="150" />
        <el-table-column label="客户名称" align="center" prop="customerName" :show-overflow-tooltip="true" />
        <el-table-column label="客户PO" align="center" prop="customerPo" width="120" />
        <el-table-column label="交货日期" align="center" prop="deliveryDate" width="120">
          <template #default="scope">
            <span>{{ parseTime(scope.row.deliveryDate, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="订单总额" align="center" prop="totalAmount" width="120" />
        <el-table-column label="状态" align="center" prop="status" width="100">
          <template #default="scope">
            <dict-tag :options="erp_order_status" :value="scope.row.status" />
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right" width="280">
          <template #default="scope">
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-if="scope.row.status !== 3">修改/核价</el-button>
            <el-button link type="success" icon="Check" @click="handleDeliver(scope.row)" v-if="scope.row.status === 2">确认发货</el-button>
            <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-if="scope.row.status === 0">删除</el-button>
            <el-button link type="warning" icon="Printer" @click="handlePrintOrder(scope.row)">打印</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <el-dialog :title="dialog.title" v-model="dialog.visible" width="96%" top="5vh" append-to-body>
      <el-form ref="orderFormRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="客户" prop="customerId">
              <el-select v-model="form.customerId" filterable placeholder="选择客户(支持搜索)" style="width: 100%;" @change="handleCustomerChange">
                <el-option v-for="item in customerOptions" :key="String(item.id)" :label="item.shortName || item.companyName" :value="String(item.id)">
                  <span style="float: left">{{ item.shortName || item.companyName }}</span>
                  <span style="float: right; color: #8492a6; font-size: 12px; margin-left: 10px;" v-if="item.shortName">{{ item.companyName }}</span>
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="客户PO号" prop="customerPo">
              <el-input v-model="form.customerPo" placeholder="客户提供的PO(选填)" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="交货日期" prop="deliveryDate">
              <el-date-picker v-model="form.deliveryDate" type="date" value-format="YYYY-MM-DD" placeholder="请选择交货日期" style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="left">产品及制造明细</el-divider>
        <div class="mb-2">
          <el-button type="primary" plain icon="Plus" size="small" @click="handleAddProduct">添加产品行</el-button>
        </div>

        <el-table :data="form.detailList" border size="small" style="width: 100%" stripe>
          <el-table-column type="index" width="50" align="center" label="序号" />
          
          <el-table-column label="产品名称(必填)" min-width="130">
            <template #default="scope"><el-input v-model="scope.row.productName" placeholder="产品名" /></template>
          </el-table-column>
          
          <el-table-column label="客户料号" min-width="100">
            <template #default="scope"><el-input v-model="scope.row.customerMaterialNo" placeholder="料号" /></template>
          </el-table-column>
          
          <el-table-column label="尺寸规格" min-width="110">
            <template #default="scope"><el-input v-model="scope.row.spec" placeholder="长*宽*高" /></template>
          </el-table-column>
          
          <el-table-column label="材质需求" min-width="110">
            <template #default="scope"><el-input v-model="scope.row.materialReq" placeholder="如:白卡" /></template>
          </el-table-column>
          
          <el-table-column label="印刷/工艺要求" min-width="200">
            <template #default="scope">
              <el-cascader
                v-model="scope.row.craftReqArray"
                :options="processTreeData"
                :props="{ multiple: true, emitPath: false }"
                clearable
                filterable
                placeholder="按分类多选"
                style="width: 100%"
                popper-class="hide-first-level-checkbox"
                @change="(val: any) => syncCraftReq(val, scope.row)"
              />
            </template>
          </el-table-column>
          
          <el-table-column label="包装需求" min-width="110">
            <template #default="scope">
              <el-autocomplete
                v-model="scope.row.packReq"
                :fetch-suggestions="querySearchPack"
                placeholder="包装方式"
                clearable
                style="width: 100%"
              />
            </template>
          </el-table-column>
          
          <el-table-column label="物流方式" min-width="110">
            <template #default="scope">
              <el-autocomplete
                v-model="scope.row.logisticsReq"
                :fetch-suggestions="querySearchLogistics"
                placeholder="物流方式"
                clearable
                style="width: 100%"
              />
            </template>
          </el-table-column>

          <el-table-column label="数量" width="90" align="center">
            <template #default="scope">
              <el-input-number v-model="scope.row.quantity" :min="1" :controls="false" style="width: 100%" @change="calcTotalAmount(scope.row)" />
            </template>
          </el-table-column>
          
          <el-table-column label="单价(不含)" width="95" align="center">
            <template #default="scope">
              <el-input-number v-model="scope.row.unitPrice" :precision="4" :step="0.01" :controls="false" style="width: 100%" @change="calcTotalAmount(scope.row)" />
            </template>
          </el-table-column>
          
          <el-table-column label="单价(含税)" width="95" align="center">
            <template #default="scope">
              <el-input-number v-model="scope.row.taxPrice" :precision="4" :step="0.01" :controls="false" style="width: 100%" @change="calcTotalAmount(scope.row)" />
            </template>
          </el-table-column>
          
          <el-table-column label="小计" width="80" align="center">
            <template #default="scope">
              <span style="font-weight: bold;">{{ scope.row.totalAmount || '0.00' }}</span>
            </template>
          </el-table-column>
          
          <el-table-column label="操作" width="60" align="center">
            <template #default="scope">
              <el-button link type="danger" icon="Delete" @click="handleRemoveProduct(scope.$index)" />
            </template>
          </el-table-column>
        </el-table>

        <el-row class="mt-4">
          <el-col :span="24">
            <el-form-item label="整单备注">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="填写其他补充信息" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div style="display: flex; justify-content: space-between; align-items: center; padding: 0 10px;">
          <div style="font-size: 16px; font-weight: bold;">
            订单总额：<span style="color: #F56C6C; font-size: 20px;">￥{{ form.totalAmount || '0.00' }}</span>
          </div>
          <div>
            <el-button type="primary" @click="submitForm">确 定 保 存</el-button>
            <el-button @click="cancel">取 消</el-button>
          </div>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="销售订单预览" v-model="printDialog.visible" width="1000px" append-to-body>
      <div v-if="printDialog.loading" v-loading="printDialog.loading" style="min-height:200px;"></div>
      <div v-else-if="printOrderData" style="font-family:'SimSun','Microsoft YaHei',sans-serif; color:#000; font-size:13px;">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; padding-bottom:8px; border-bottom:2px solid #000;">
          <div style="width:70px; flex-shrink:0;">
            <img v-if="printQrcode" :src="printQrcode" style="width:65px; height:65px;" title="扫二维码" />
          </div>
          <div style="flex:1; text-align:center;">
            <h2 style="margin:0; font-size:20px; font-weight:bold; letter-spacing:3px;">{{ printOrderData.companyName }}——销售订单</h2>
          </div>
          <div style="flex-shrink:0; text-align:right;">
            <img v-if="printBarcode" :src="printBarcode" style="max-height:50px;" title="扫条形码" />
          </div>
        </div>
        <div id="soPrintArea">
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000; margin-bottom:10px;">
          <colgroup><col width="10%"><col width="23%"><col width="10%"><col width="23%"><col width="10%"><col width="24%"></colgroup>
          <tbody>
          <tr>
            <td class="fp-label">订单编号</td><td>{{ printOrderData.orderNo || '' }}</td>
            <td class="fp-label">客户名称</td><td>{{ printOrderData.customerName || '' }}</td>
            <td class="fp-label">客户PO</td><td>{{ printOrderData.customerPo || '' }}</td>
          </tr>
          <tr>
            <td class="fp-label">交货日期</td><td>{{ parseTime(printOrderData.deliveryDate, '{y}-{m}-{d}') || '' }}</td>
            <td class="fp-label">订单总额</td><td colspan="3" style="font-weight:bold; color:#F56C6C;">{{ printOrderData.totalAmount ? '￥' + printOrderData.totalAmount : '-' }}</td>
          </tr>
          <tr>
            <td class="fp-label">备注</td><td colspan="5">{{ printOrderData.remark || '' }}</td>
          </tr>
          </tbody>
        </table>

        <div class="fp-section-title">产品明细</div>
        <table border="1" cellspacing="0" cellpadding="4" class="full-print-table" style="width:100%; border-collapse:collapse; font-size:12px; border-color:#000;">
          <colgroup><col width="4%"><col width="12%"><col width="8%"><col width="9%"><col width="9%"><col width="11%"><col width="8%"><col width="8%"><col width="6%"><col width="8%"><col width="8%"><col width="9%"></colgroup>
          <tbody>
          <tr class="fp-header-row">
            <td>序号</td><td>产品名称</td><td>客户料号</td><td>尺寸规格</td><td>材质需求</td>
            <td>印刷/工艺</td><td>包装</td><td>物流</td><td>数量</td><td>单价</td><td>含税价</td><td>小计</td>
          </tr>
          <tr v-for="(item, i) in (printOrderData.detailList && printOrderData.detailList.length ? printOrderData.detailList : [{}])" :key="'d'+i">
            <td style="text-align:center;">{{ i + 1 }}</td>
            <td>{{ item.productName || '' }}</td>
            <td style="text-align:center;">{{ item.customerMaterialNo || '' }}</td>
            <td style="text-align:center;">{{ item.spec || '' }}</td>
            <td>{{ item.materialReq || '' }}</td>
            <td style="font-size:11px;">{{ item.craftReq || '' }}</td>
            <td style="text-align:center;">{{ item.packReq || '' }}</td>
            <td style="text-align:center;">{{ item.logisticsReq || '' }}</td>
            <td style="text-align:center;">{{ dash(item.quantity) }}</td>
            <td style="text-align:center;">{{ dash(item.unitPrice) }}</td>
            <td style="text-align:center;">{{ dash(item.taxPrice) }}</td>
            <td style="text-align:center;">{{ dash(item.totalAmount) }}</td>
          </tr>
          </tbody>
        </table>
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="warning" icon="Download" @click="exportOrderExcel">下载 Excel</el-button>
          <el-button type="success" icon="Printer" @click="doOrderPrint">执 行 打 印</el-button>
          <el-button @click="printDialog.visible = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>

    <canvas id="soBarcodeCanvas" style="display:none;"></canvas>
  </div>
</template>

<script setup lang="ts" name="SalesOrder">
import { ref, reactive, toRefs, onMounted, getCurrentInstance, ComponentInternalInstance, computed, nextTick } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { listSalesOrder, getSalesOrder, addSalesOrder, updateSalesOrder, delSalesOrder, confirmDelivery } from '@/api/erp/salesOrder/index';
import { listCustomer } from '@/api/erp/customer/index';
import { getDicts } from '@/api/system/dict/data';
import JsBarcode from 'jsbarcode';
import QRCode from 'qrcode';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

// ==========================
// 1. 字典数据加载
// ==========================
const { 
  erp_process_name, erp_processor_category,
  erp_pack_type, erp_logistics_type, erp_order_status 
} = toRefs<any>(proxy?.useDict(
  'erp_process_name', 'erp_processor_category',
  'erp_pack_type', 'erp_logistics_type', 'erp_order_status'
));

// 存放原始工艺字典数据，用于构建树
const rawProcessDictOptions = ref<any[]>([]);

// 💡 核心构建：组装成多级级联树 (el-cascader 格式)
const processTreeData = computed(() => {
  const tree: any[] = [];
  const categories = erp_processor_category.value || [];
  const processes = rawProcessDictOptions.value || [];

  // 1. 遍历加工商分类作为树的【父节点】
  categories.forEach((cat: any) => {
    const parentNode = {
      value: cat.label, // 父节点标识
      label: cat.label,
      children: [] as any[]
    };
    
    // 2. 找到所有对应分类的子工艺
    processes.forEach((proc: any) => {
      // 通过 remark 绑定分类关系
      if (proc.remark && proc.remark.trim() === String(cat.value)) {
        parentNode.children.push({
          value: proc.dictLabel, 
          label: proc.dictLabel
        });
      }
    });
    
    if (parentNode.children.length > 0) {
      tree.push(parentNode);
    }
  });

  // 3. 兜底保护：没配置分类的放到“其他工艺”
  const unclassifiedNode = {
    value: '其他未分类',
    label: '其他工艺(未配置关联)',
    children: [] as any[]
  };
  
  processes.forEach((proc: any) => {
    if (!proc.remark || !categories.find((c: any) => String(c.value) === proc.remark.trim())) {
      unclassifiedNode.children.push({
        value: proc.dictLabel,
        label: proc.dictLabel
      });
    }
  });

  if (unclassifiedNode.children.length > 0) {
    tree.push(unclassifiedNode);
  }

  return tree;
});

// ==========================
// 2. Autocomplete 输入建议逻辑
// ==========================
const createQuerySearch = (dictRef: any) => {
  return (queryString: string, cb: any) => {
    const dict = dictRef.value || [];
    const results = queryString
      ? dict.filter((item: any) => item.label.toLowerCase().includes(queryString.toLowerCase()))
      : dict;
    cb(results.map((item: any) => ({ value: item.label })));
  };
};

const querySearchPack = createQuerySearch(erp_pack_type);
const querySearchLogistics = createQuerySearch(erp_logistics_type);

// ==========================
// 3. 状态定义
// ==========================
const salesOrderList = ref<any[]>([]);
const loading = ref(true);
const total = ref(0);
const showSearch = ref(true);
const customerOptions = ref<any[]>([]);

const dialog = reactive({ visible: false, title: '' });
const printDialog = reactive({ visible: false, loading: false });
const printOrderData = ref<any>(null);
const printQrcode = ref('');
const printBarcode = ref('');

const initFormData = {
  id: undefined, orderNo: undefined, customerId: undefined, customerName: undefined,
  customerPo: undefined, deliveryDate: undefined, totalAmount: 0, status: 0,
  remark: undefined, detailList: [] as any[]
};

const data = reactive({
  form: { ...initFormData },
  queryParams: { pageNum: 1, pageSize: 20, customerName: undefined, orderNo: undefined },
  rules: {
    customerId: [{ required: true, message: "请选择客户", trigger: "change" }],
    deliveryDate: [{ required: true, message: "请选择交货日期", trigger: "change" }]
  }
});

const { form, queryParams, rules } = toRefs(data);

// ==========================
// 4. 搜索与重置
// ==========================
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};

const resetQuery = () => {
  (proxy?.$refs["queryFormRef"] as any)?.resetFields();
  handleQuery();
};

// ==========================
// 5. 核心商务逻辑：含税/不含税换算
// ==========================

const calcTotalAmount = (row: any) => {
  const price = row.unitPrice || 0;
  const qty = row.quantity || 0;
  row.totalAmount = Number((price * qty).toFixed(2));

  let totalSum = 0;
  form.value.detailList.forEach(item => {
    totalSum += Number(item.totalAmount || 0);
  });
  form.value.totalAmount = Number(totalSum.toFixed(2));
};

// 级联多选结果同步到字符串
const syncCraftReq = (valArray: string[], row: any) => {
  row.craftReq = valArray ? valArray.join(',') : '';
};

// ==========================
// 6. 动态明细行操作
// ==========================
const handleAddProduct = () => {
  form.value.detailList.push({
    productName: '', customerMaterialNo: '', spec: '', materialReq: '',
    craftReq: '', craftReqArray: [], 
    packReq: '', logisticsReq: '', unitPrice: undefined, taxPrice: undefined, quantity: 1, totalAmount: 0
  });
};

const handleRemoveProduct = (index: number) => {
  form.value.detailList.splice(index, 1);
  calcTotalAmount({});
};

// ==========================
// 7. 客户字典加载
// ==========================
const getCustomerList = async () => {
  const res = await listCustomer({ pageNum: 1, pageSize: 1000 } as any);
  customerOptions.value = res.rows || [];
};

const handleCustomerChange = (val: any) => {
  const selected = customerOptions.value.find(i => String(i.id) === String(val));
  if (selected) form.value.customerName = selected.companyName;
};

// ==========================
// 8. 基础 CRUD 操作
// ==========================
const getList = async () => {
  loading.value = true;
  try {
    const res = await listSalesOrder(queryParams.value);
    salesOrderList.value = res.rows;
    total.value = res.total;
  } finally {
    loading.value = false;
  }
};

const handleAdd = () => {
  form.value = JSON.parse(JSON.stringify(initFormData));
  handleAddProduct();
  dialog.visible = true;
  dialog.title = "新增销售订单";
};

const handleUpdate = async (row: any) => {
  const res = await getSalesOrder(row.id);
  const orderData = res.data as any;
  
  if (orderData.detailList) {
    orderData.detailList.forEach((item: any) => {
      item.craftReqArray = item.craftReq ? item.craftReq.split(',') : [];
    });
  } else {
    orderData.detailList = [];
  }
  
  form.value = orderData;
  if (form.value.customerId) {
    form.value.customerId = String(form.value.customerId) as any;
  }
  dialog.visible = true;
  dialog.title = "修改订单/核价";
};

const submitForm = () => {
  (proxy?.$refs["orderFormRef"] as any)?.validate(async (valid: boolean) => {
    if (valid) {
      if (!form.value.detailList || form.value.detailList.length === 0) {
         ElMessage.warning("请至少录入一个产品明细！");
         return;
      }
      
      form.value.detailList = form.value.detailList.filter((item: any) => item.productName);

      if (form.value.id) {
        await updateSalesOrder(form.value);
        ElMessage.success("修改成功");
      } else {
        await addSalesOrder(form.value);
        ElMessage.success("新增成功");
      }
      dialog.visible = false;
      getList();
    }
  });
};

const handleDelete = async (row: any) => {
  await proxy?.$modal.confirm('确认删除订单号为【' + row.orderNo + '】的数据项?');
  await delSalesOrder(row.id);
  getList();
  ElMessage.success("删除成功");
};

const handleDeliver = async (row: any) => {
  await ElMessageBox.confirm('确认发货后，该订单将彻底锁定并生成账单流转。是否确认？', '警告', { type: 'warning' });
  await confirmDelivery(row.id);
  ElMessage.success("已确认发货！");
  getList();
};

const cancel = () => {
  dialog.visible = false;
};

const handlePrintOrder = async (row: any) => {
  printDialog.visible = true; printDialog.loading = true;
  try {
    const res = await getSalesOrder(row.id);
    const data = res.data as any;
    data.companyName = '中山市梵熙创意纸品有限公司';
    printOrderData.value = data;

    await nextTick();
    const orderNo = data.orderNo || '';
    const canvas = document.getElementById('soBarcodeCanvas') as HTMLCanvasElement;
    if (canvas) {
      JsBarcode(canvas, orderNo, { format: "CODE128", displayValue: true, fontSize: 16, height: 45, margin: 0 });
      printBarcode.value = canvas.toDataURL("image/png");
    }
    const qrText = [
      `订单号: ${orderNo}`,
      `客户: ${data.customerName || ''}`,
      `PO: ${data.customerPo || ''}`,
      `交期: ${data.deliveryDate || ''}`,
      `总额: ￥${data.totalAmount || '0.00'}`
    ].join('\n');
    printQrcode.value = await QRCode.toDataURL(qrText, { width: 80, margin: 1 });
  } catch (e) { console.error(e); }
  finally { printDialog.loading = false; }
};

const exportOrderExcel = () => {
  const content = document.getElementById('soPrintArea')?.innerHTML;
  if (!content) return;
  const html = `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><meta charset="UTF-8"><style>.full-print-table{width:100%;border-collapse:collapse;font-family:"SimSun";font-size:12px;}.full-print-table td{border:1px solid #000;padding:4px;}.fp-label{font-weight:bold;text-align:center;background-color:#f0f0f0;}.fp-header-row td{background-color:#e8e8e8;font-weight:bold;text-align:center;}.fp-section-title{font-weight:bold;font-size:14px;margin:10px 0 5px;}</style></head><body>${content}</body></html>`;
  const blob = new Blob([html], { type: 'application/vnd.ms-excel' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url; a.download = `销售订单_${printOrderData.value?.orderNo || 'unknown'}.xls`;
  a.click(); URL.revokeObjectURL(url);
};

const dash = (val: any) => (val === null || val === undefined || val === '' || val === 0) ? '-' : val;

const doOrderPrint = () => {
  const content = document.getElementById('soPrintArea')?.innerHTML;
  if (!content) return;
  const orderNo = printOrderData.value?.orderNo || '';
  const w = window.open('', '_blank');
  w?.document.write(`<html><head><title>销售订单 - ${orderNo}</title><style>
    body{font-family:"SimSun","Microsoft YaHei",sans-serif;padding:15px;color:#000;-webkit-print-color-adjust:exact;print-color-adjust:exact;}
    .print-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;padding-bottom:8px;border-bottom:2px solid #000;}
    .print-header .qr{width:70px;flex-shrink:0;}
    .print-header .title{flex:1;text-align:center;}
    .print-header .barcode{flex-shrink:0;text-align:right;}
    .full-print-table{width:100%;border-collapse:collapse;font-size:12px;}
    .full-print-table td{border:1px solid #000;padding:4px;}
    .fp-label{font-weight:bold;text-align:center;background-color:#f0f0f0;}
    .fp-header-row td{background-color:#e8e8e8;font-weight:bold;text-align:center;}
    .fp-section-title{font-weight:bold;font-size:14px;margin:10px 0 5px;}
    @media print{body{padding:5px;}}
  </style></head><body>
    <div class="print-header">
      <div class="qr">${printQrcode.value ? `<img src="${printQrcode.value}" style="width:65px;height:65px;"/>` : ''}</div>
      <div class="title"><h2 style="margin:0;font-size:20px;font-weight:bold;letter-spacing:3px;">${printOrderData.value?.companyName || ''}——销售订单</h2></div>
      <div class="barcode">${printBarcode.value ? `<img src="${printBarcode.value}" style="max-height:50px;"/>` : ''}</div>
    </div>
    ${content}
  </body></html>`);
  w?.document.close();
  setTimeout(() => { w?.print(); w?.close(); }, 300);
};

onMounted(() => {
  getList();
  getCustomerList();
  
  // 获取完整的工艺字典（带remark分类信息）
  getDicts('erp_process_name').then((res: any) => {
    rawProcessDictOptions.value = res.data || [];
  });
});
</script>

<style>
.hide-first-level-checkbox .el-cascader-menu:first-child .el-checkbox {
  display: none !important;
}

.full-print-table td {
  vertical-align: middle;
}
.full-print-table .fp-label {
  font-weight: bold;
  text-align: center;
  background-color: #f0f0f0;
}
.full-print-table .fp-header-row td {
  background-color: #e8e8e8;
  font-weight: bold;
  text-align: center;
}
.fp-section-title {
  font-weight: bold;
  font-size: 14px;
  margin: 12px 0 5px;
  padding: 2px 0 2px 8px;
  border-left: 3px solid #409EFF;
}
</style>