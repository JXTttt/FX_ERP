<template>
  <div class="app-container home-dashboard">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="8" :md="6" :lg="5">
        <div class="left-panel">
          <div class="profile-card">
            <div class="avatar-box">
              <el-avatar :size="100" :src="userStore.avatar" />
            </div>
            <div class="user-info">
              <p>用户昵称: <strong>{{ userStore.nickname }}</strong></p>
            </div>
          </div>

          <div class="digital-clock">{{ currentTime }}</div>

          <div class="mini-calendar">
            <div class="calendar-header">《 {{ currentDateStr }} 》</div>
            <el-calendar v-model="currentDate" />
          </div>
        </div>
      </el-col>

      <el-col :xs="24" :sm="16" :md="18" :lg="19">
        <div class="right-panel">
          <div class="section-block">
            <div class="section-title">快捷操作</div>
            <div class="shortcut-grid">
              <div class="shortcut-item" @click="handleQuickAdd('/workOrder')">
                <div class="icon-box"><svg-icon icon-class="form" class="svg-icon" /></div>
                <span>添加生产单</span>
              </div>
              <div class="shortcut-item" @click="goTo('/workOrder')">
                <div class="icon-box"><svg-icon icon-class="documentation" class="svg-icon" /></div>
                <span>生产工单</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="chart" class="svg-icon" /></div>
                <span>生产报表</span>
              </div>
              <div class="shortcut-item" @click="goTo('/inventory')">
                <div class="icon-box"><svg-icon icon-class="dict" class="svg-icon" /></div>
                <span>库存管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="money" class="svg-icon" /></div>
                <span>支出开销</span>
              </div>
              <div class="shortcut-item" @click="goTo('/')">
                <div class="icon-box"><svg-icon icon-class="cascader" class="svg-icon" /></div>
                <span>查看账务</span>
              </div>
              <div class="shortcut-item" @click="handleQuickAdd('/customer')">
                <div class="icon-box"><svg-icon icon-class="peoples" class="svg-icon" /></div>
                <span>添加新客户</span>
              </div>
              <div class="shortcut-item" @click="goTo('/customer')">
                <div class="icon-box"><svg-icon icon-class="users" class="svg-icon" /></div>
                <span>客户管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/system/user')">
                <div class="icon-box"><svg-icon icon-class="user" class="svg-icon" /></div>
                <span>职员管理</span>
              </div>
              <div class="shortcut-item" @click="goTo('/notice')">
                <div class="icon-box"><svg-icon icon-class="message" class="svg-icon" /></div>
                <span>新闻动态</span>
              </div>
            </div>
          </div>

          <div class="section-block">
            <div class="section-title">等待处理</div>
            <ul class="task-list">
              <li>
                <span class="dot">•</span>
                <span class="highlight-num">0</span> 笔开立需要审核
                <el-icon class="star-icon"><StarFilled /></el-icon>
              </li>
            </ul>
          </div>

          <div class="section-block">
            <div class="section-title">管理反馈</div>
            <ul class="task-list">
              <li>
                <span class="dot">•</span>
                <span class="highlight-num">0</span> 笔送货单全额为0元
                <el-icon class="star-icon"><StarFilled /></el-icon>
              </li>
            </ul>
          </div>

          <div class="section-block">
            <div class="section-title">新闻动态</div>
            <div class="news-alert">
              <el-alert title="暂无最新新闻动态" type="info" show-icon :closable="false" />
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index" lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/store/modules/user';
import { StarFilled } from '@element-plus/icons-vue';

const router = useRouter();
const userStore = useUserStore();

// ================= 核心重构逻辑 =================

/** 快捷添加：跳转时带上 action=add 参数 */
const handleQuickAdd = (path: string) => {
  router.push({ path: path, query: { action: 'add' } });
};

/** 普通跳转 */
const goTo = (path: string) => {
  router.push(path);
};

// ================= 时间时钟逻辑 =================
const currentTime = ref('');
const currentDateStr = ref('');
const currentDate = ref(new Date());
let timer: any = null;

const updateTime = () => {
  const now = new Date();
  currentTime.value = now.toLocaleTimeString('en-US', { hour12: false });
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  currentDateStr.value = `${year}年${month}月${day}日`;
};

onMounted(() => {
  updateTime();
  timer = setInterval(updateTime, 1000);
});

onUnmounted(() => {
  if (timer) clearInterval(timer);
});
</script>

<style lang="scss" scoped>
.home-dashboard {
  background-color: #ffffff;
  min-height: calc(100vh - 84px);
  padding: 20px;
}

/* ================= 左侧面板样式 ================= */
.left-panel {
  display: flex;
  flex-direction: column;
  gap: 15px;

  /* 个人信息卡片 */
  .profile-card {
    border: 1px solid #dcdfe6;
    background-color: #f7f9fa;
    border-radius: 4px;
    padding: 20px 10px;
    text-align: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);

    .avatar-box {
      margin-bottom: 15px;
      .el-avatar {
        border: 2px solid #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      }
    }

    .user-info {
      text-align: left;
      padding-left: 10%;
      p {
        font-size: 13px;
        color: #333;
        margin: 6px 0;
        strong {
          color: #1f2d3d;
        }
      }
    }
  }

  /* 数字时钟 */
  .digital-clock {
    background-color: #000000;
    color: #409eff;
    font-family: 'Courier New', Courier, monospace;
    font-size: 32px;
    font-weight: bold;
    text-align: center;
    padding: 15px 0;
    border-radius: 4px;
    letter-spacing: 2px;
    box-shadow: inset 0 0 10px rgba(255,255,255,0.2);
  }

  /* 迷你日历 */
  .mini-calendar {
    border: 1px solid #dcdfe6;
    background-color: #f7f9fa;
    border-radius: 4px;
    overflow: hidden;

    .calendar-header {
      background-color: #e4e7ed;
      color: #303133;
      text-align: center;
      padding: 8px 0;
      font-weight: bold;
      font-size: 14px;
    }

    :deep(.el-calendar) {
      background-color: transparent;
      .el-calendar__header {
        display: none; 
      }
      .el-calendar__body {
        padding: 5px;
      }
      .el-calendar-table th {
        padding: 5px 0;
        font-size: 12px;
        color: #606266;
      }
      .el-calendar-table td {
        border: none;
      }
      .el-calendar-table .el-calendar-day {
        height: 30px;
        line-height: 30px;
        padding: 0;
        text-align: center;
        font-size: 12px;
        &:hover {
          background-color: #ecf5ff;
        }
      }
      .el-calendar-table td.is-selected .el-calendar-day {
        background-color: #409eff;
        color: #fff;
        border-radius: 4px;
      }
    }
  }
}

/* ================= 右侧面板样式 ================= */
.right-panel {
  display: flex;
  flex-direction: column;
  gap: 25px;

  .section-block {
    .section-title {
      font-size: 16px;
      font-weight: bold;
      color: #1f4a7c;
      border-bottom: 2px solid #e4e7ed;
      padding-bottom: 8px;
      margin-bottom: 15px;
    }

    .shortcut-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;

      .shortcut-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        cursor: pointer;
        width: 80px;
        transition: all 0.2s;

        &:hover {
          transform: translateY(-3px);
          .icon-box {
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
          }
          span {
            color: #409eff;
          }
        }

        .icon-box {
          width: 50px;
          height: 50px;
          background: linear-gradient(135deg, #434343 0%, #1c1c1c 100%);
          border-radius: 8px;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-bottom: 8px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.2);
          border: 1px solid #555;

          .svg-icon {
            font-size: 24px;
            color: #ffffff;
          }
        }

        span {
          font-size: 12px;
          color: #606266;
        }
      }
    }

    .task-list {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        font-size: 14px;
        color: #303133;
        margin-bottom: 12px;
        display: flex;
        align-items: center;

        .dot {
          color: #909399;
          margin-right: 8px;
        }

        .highlight-num {
          color: #f56c6c;
          font-weight: bold;
          margin: 0 4px;
        }

        .star-icon {
          color: #e6a23c;
          margin-left: 8px;
          font-size: 16px;
        }
      }
    }

    .news-alert {
      :deep(.el-alert) {
        .el-alert__title {
          font-size: 14px;
          font-weight: bold;
        }
        .el-alert__icon {
          font-size: 20px;
          width: 20px;
        }
      }
    }
  }
}
</style>