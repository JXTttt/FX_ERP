/*
 Navicat Premium Dump SQL

 Source Server         : fx-db
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : 154.83.17.141:3306
 Source Schema         : fx_erp

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 06/04/2026 21:18:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_customer
-- ----------------------------
DROP TABLE IF EXISTS `biz_customer`;
CREATE TABLE `biz_customer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户公司全称',
  `customer_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户编码(唯一标识)',
  `short_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '客户简称/个人全名',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '首要联系人名称',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '联系人手机号',
  `customer_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '类型：1-普通客户, 2-供应商',
  `supplier_category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商分类',
  `company_province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司所在省',
  `company_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司所在市',
  `company_district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司所在区',
  `company_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司详细地址',
  `delivery_province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货省',
  `delivery_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货市',
  `delivery_district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货区',
  `delivery_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货详细地址',
  `delivery_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货单位名称',
  `bank_account_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行账户信息(例:工行 张三 6212...)',
  `total_deal_amount` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '总交易金额(出货/采购)',
  `total_owe_amount` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '当前欠款/待付金额',
  `sales_man_id` bigint NULL DEFAULT NULL COMMENT '业务归属员ID (关联sys_user)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2040728250557284355 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户及供应商表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_customer
-- ----------------------------
INSERT INTO `biz_customer` VALUES (2040728250557284354, '中山市恒华实业有限公司', 'ZSHH', '恒华实业', '袁小姐', '13715622473', '2', '7', '广东省', '中山市', '板芙镇', '白溪村芙中路54号', '广东省', '中山市', '板芙镇', '白溪村芙中路54号', '白溪村芙中路54号', NULL, 0.00, 0.00, 1, '1', '2026-04-05 17:48:24', 103, '1', '2026-04-06 10:02:03', NULL, '0');

-- ----------------------------
-- Table structure for biz_finance_record
-- ----------------------------
DROP TABLE IF EXISTS `biz_finance_record`;
CREATE TABLE `biz_finance_record`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `record_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '财务流水号(如 FIN2026...)',
  `record_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资金流向: 1-应收/收入, 2-应付/支出',
  `business_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型: 销售出货, 采购入库, 委外加工, 临时工费',
  `related_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联单号(出货单号/采购单号/工单号)',
  `target_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收付款对象(客户名/供应商名/临时工姓名)',
  `amount` decimal(15, 2) NOT NULL COMMENT '发生金额',
  `settlement_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '财务收支流水表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_finance_record
-- ----------------------------
INSERT INTO `biz_finance_record` VALUES (2029555173633855489, 'FIN-TW-2029555173625466882', '2', '临时工费', NULL, '王楚钦', 154.00, '2', '日期:03月05日 | 计时: 11小时 × 单价:￥14 | 内容:无', '0', 103, 1, '2026-03-05 21:50:35', 1, '2026-03-05 22:10:09');
INSERT INTO `biz_finance_record` VALUES (2029560769925910530, 'FIN-WW-1772719969623', '2', '委外加工', '2603050001', '测试供应商2', 63700.00, '2', '委外收货结算，收货单号: OSR1772718243520，工序: 表面处理 - 过光胶', '0', 103, 1, '2026-03-05 22:12:50', 1, '2026-03-05 22:15:29');
INSERT INTO `biz_finance_record` VALUES (2029560989824880641, 'FIN-XS-1772720022049', '1', '销售出货', '2603050001', '测试客户1', 46410.00, '2', '成品出货自动生成应收账款，出货产品: 中秋盲盒，出货量: 9100', '0', 103, 1, '2026-03-05 22:13:42', 1, '2026-03-05 22:15:24');
INSERT INTO `biz_finance_record` VALUES (2029561599966089218, 'FIN-CG-1772720167518', '2', '采购入库', 'CG2026030521420075', '测试供应商1', 9476.00, '0', '采购验收自动产生应付款，物资: 纸张 - 坑纸898g，数量: 9200', '0', 103, 1, '2026-03-05 22:16:08', 1, '2026-03-05 22:16:08');
INSERT INTO `biz_finance_record` VALUES (2029561719549890562, 'FIN-WW-1772720196031', '2', '委外加工', '2603050001', '测试供应商1', 18200.00, '0', '委外收货结算，收货单号: OSR1772718243544，工序: 表面处理 - 烫金', '0', 103, 1, '2026-03-05 22:16:36', 1, '2026-03-05 22:16:36');
INSERT INTO `biz_finance_record` VALUES (2029561739871293442, 'FIN-WW-1772720200876', '2', '委外加工', '2603050001', '测试供应商1', 18200.00, '0', '委外收货结算，收货单号: OSR1772718243564，工序: 表面处理 - 击凸', '0', 103, 1, '2026-03-05 22:16:41', 1, '2026-03-05 22:16:41');
INSERT INTO `biz_finance_record` VALUES (2029561763590082562, 'FIN-WW-1772720206531', '2', '委外加工', '2603050001', '测试供应商1', 10920.00, '0', '委外收货结算，收货单号: OSR1772718243884，工序: 表面处理 - 压纹', '0', 103, 1, '2026-03-05 22:16:47', 1, '2026-03-05 22:16:47');
INSERT INTO `biz_finance_record` VALUES (2030246192113315843, 'FIN-CG-1772883387010', '2', '采购入库', 'CG2026030719353732', 'null', 8109.00, '0', '采购验收自动产生应付款，物资: 面纸 - 白纸300g，数量: 8109', '0', 103, 1, '2026-03-07 19:36:27', 1, '2026-03-07 19:36:27');
INSERT INTO `biz_finance_record` VALUES (2030246220886241283, 'FIN-CG-1772883393876', '2', '采购入库', 'CG2026030719353723', 'null', 8000.00, '0', '采购验收自动产生应付款，物资: 配件 - 手提袋，数量: 8000.00', '0', 103, 1, '2026-03-07 19:36:34', 1, '2026-03-07 19:36:34');
INSERT INTO `biz_finance_record` VALUES (2030247516389306369, 'FIN-WW-1772883702740', '2', '委外加工', '2603070002', '供应商001', 1.00, '0', '委外收货结算，收货单号: OSR1772883675393，工序: 表面处理 - 过光胶', '0', 103, 1, '2026-03-07 19:41:43', 1, '2026-03-07 19:41:43');
INSERT INTO `biz_finance_record` VALUES (2030247577538064386, 'FIN-WW-1772883717326', '2', '委外加工', '2603070002', '测试供应商2', 1.02, '2', '委外收货结算，收货单号: OSR1772883675723，工序: 表面处理 - 击凸', '0', 103, 1, '2026-03-07 19:41:57', 1, '2026-03-07 20:21:27');
INSERT INTO `biz_finance_record` VALUES (2030254150457028609, 'FIN-XS-1772885284422', '1', '销售出货', '2603070002', '客户001', 14000.00, '2', '成品出货自动生成应收账款，出货产品: 测试产品001，出货量: 4000', '0', 103, 1, '2026-03-07 20:08:04', 1, '2026-03-07 20:21:27');
INSERT INTO `biz_finance_record` VALUES (2030254287606575106, 'FIN-MN-1772885317130', '1', '手工结清', NULL, '客户001', 8000.00, '2', '在客户管理处手动打款结清，备注：', '0', 103, 1, '2026-03-07 20:08:37', 1, '2026-03-07 20:08:37');
INSERT INTO `biz_finance_record` VALUES (2030254580813590530, 'FIN-XS-1772885387036', '1', '销售出货', '2603070002', '客户001', 3500.00, '2', '成品出货自动生成应收账款，出货产品: 测试产品001，出货量: 1000', '0', 103, 1, '2026-03-07 20:09:47', 1, '2026-03-07 20:21:27');
INSERT INTO `biz_finance_record` VALUES (2030255709827952642, 'FIN-XS-1772885656213', '1', '销售出货', '2603070002', '客户001', 3500.00, '2', '成品出货自动生成应收账款，出货产品: 测试产品001，出货量: 1000', '0', 103, 1, '2026-03-07 20:14:16', 1, '2026-03-07 20:21:27');
INSERT INTO `biz_finance_record` VALUES (2030256216818642945, 'FIN-MN-1772885777089', '1', '手工结清', NULL, '客户001', 7000.00, '2', '在客户管理处手动打款结清，备注：', '0', 103, 1, '2026-03-07 20:16:17', 1, '2026-03-07 20:16:17');
INSERT INTO `biz_finance_record` VALUES (2035681654541979649, 'FIN-XS-1774179302248', '1', '销售出货', '2603220002', '测试客户2', 1799.10, '2', '成品出货自动生成应收账款，出货产品: 礼盒1，出货量: 1999', '0', 103, 1, '2026-03-22 19:35:02', 1, '2026-03-22 19:38:49');
INSERT INTO `biz_finance_record` VALUES (2035682092821581825, 'FIN-TW-2035682092754472962', '2', '临时工费', NULL, '樊振东', 5000.00, '2', '日期:03月22日 | 计件: 5000件 × 单价:￥1 | 内容:无', '0', 103, 1, '2026-03-22 19:36:47', 1, '2026-03-22 19:37:54');
INSERT INTO `biz_finance_record` VALUES (2035682311500009474, 'FIN-WW-1774179458869', '2', '委外加工', '2603220002', '供应商001', 1450.13, '2', '委外收货结算，收货单号: OSR1774179232936，工序: 表面处理 - 过哑胶', '0', 103, 1, '2026-03-22 19:37:39', 1, '2026-03-22 19:38:49');

-- ----------------------------
-- Table structure for biz_inventory
-- ----------------------------
DROP TABLE IF EXISTS `biz_inventory`;
CREATE TABLE `biz_inventory`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `unique_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专用码(关联订单)',
  `item_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型：成品, 配件, 纸张',
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物料名称',
  `spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `current_qty` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '当前库存量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '默认供应商ID',
  `purchase_price` decimal(10, 4) NULL DEFAULT 0.0000 COMMENT '最新采购单价',
  `total_amount` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '库存总金额',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT NULL,
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035681572564307970 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_inventory
-- ----------------------------
INSERT INTO `biz_inventory` VALUES (2029553840751153153, 'wp300g', '3', '白纸300g', '111*222', 100000.00, '2', 2029549846247018498, 0.0500, 5000.00, '1', '2026-03-05 21:45:18', 103, '1', '2026-03-05 21:45:18', '0');
INSERT INTO `biz_inventory` VALUES (2029560917997424641, '2603050001', '成品', '中秋盲盒', '213*42*23', 0.00, '个', 2029549525726695425, 5.1000, 0.00, '1', '2026-03-05 22:13:25', 103, '1', '2026-03-05 22:13:42', '0');
INSERT INTO `biz_inventory` VALUES (2029560926608330753, '2603050001', '成品', '重生点纸钱', '', 350.00, '个', 2029549525726695425, 0.0200, 7.00, '1', '2026-03-05 22:13:27', 103, '1', '2026-03-05 22:13:27', '0');
INSERT INTO `biz_inventory` VALUES (2029561599957700609, NULL, '纸张', '纸张 - 坑纸898g', '333*44*44', 9200.00, '张', 2029549846247018498, 1.0300, 9476.00, '1', '2026-03-05 22:16:08', 103, '1', '2026-03-05 22:16:08', '0');
INSERT INTO `biz_inventory` VALUES (2030246192113315842, NULL, '纸张', '面纸 - 白纸300g', '111*222', 8109.00, '张', 2030243625677418497, 1.0000, 8109.00, '1', '2026-03-07 19:36:27', 103, '1', '2026-03-07 19:37:03', '0');
INSERT INTO `biz_inventory` VALUES (2030246220886241282, NULL, '纸张', '配件 - 手提袋', '222*333', 8000.00, '张', NULL, 1.0000, 8000.00, '1', '2026-03-07 19:36:34', 103, '1', '2026-03-07 19:36:34', '0');
INSERT INTO `biz_inventory` VALUES (2030254056731111426, '2603070002', '成品', '测试产品001', '83*321', 2050.00, '个', 2030243178455560194, 3.5000, 3675.00, '1', '2026-03-07 20:07:42', 103, '1', '2026-03-07 20:07:42', '0');
INSERT INTO `biz_inventory` VALUES (2035681572564307969, '2603220002', '成品', '礼盒1', '111*111*111', 8001.00, '个', 2029550188372201473, 0.9000, 5401.80, '1', '2026-03-22 19:34:43', 103, '1', '2026-03-22 19:34:43', '0');

-- ----------------------------
-- Table structure for biz_outsourcing_receipt
-- ----------------------------
DROP TABLE IF EXISTS `biz_outsourcing_receipt`;
CREATE TABLE `biz_outsourcing_receipt`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `receipt_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货单号(如 OSR2026...)',
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联工单号',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品/材料名称',
  `process_project` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加工工序',
  `supplier_id` bigint NOT NULL COMMENT '加工商ID',
  `sent_qty` decimal(10, 2) NULL DEFAULT NULL COMMENT '发出数量',
  `received_qty` decimal(10, 2) NOT NULL COMMENT '实际验收数量',
  `price_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '算价方式(张/平方米/套)',
  `unit_price` decimal(10, 4) NOT NULL COMMENT '结算单价',
  `total_fee` decimal(15, 2) NOT NULL COMMENT '结算加工费',
  `receipt_date` datetime NOT NULL COMMENT '收货日期',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态: 0-待入库, 1-已验收结算',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '委外收货与结算表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_outsourcing_receipt
-- ----------------------------
INSERT INTO `biz_outsourcing_receipt` VALUES (2029553530129387521, 'OSR1772718243520', '2603050001', '中秋盲盒', '表面处理 - 过光胶', 2029550563984707585, 9100.00, 9100.00, '平方米', 7.0000, 63700.00, '2026-03-05 21:44:03', '1', NULL, '0', 103, 1, '2026-03-05 21:44:04', 1, '2026-03-05 22:12:50');
INSERT INTO `biz_outsourcing_receipt` VALUES (2029553530225856514, 'OSR1772718243544', '2603050001', '中秋盲盒', '表面处理 - 烫金', 2029549846247018498, 9100.00, 9100.00, '平方米', 2.0000, 18200.00, '2026-03-05 21:44:03', '1', NULL, '0', 103, 1, '2026-03-05 21:44:04', 1, '2026-03-05 22:16:36');
INSERT INTO `biz_outsourcing_receipt` VALUES (2029553530309742594, 'OSR1772718243564', '2603050001', '中秋盲盒', '表面处理 - 击凸', 2029549846247018498, 9100.00, 9100.00, '平方米', 2.0000, 18200.00, '2026-03-05 21:44:03', '1', NULL, '0', 103, 1, '2026-03-05 21:44:04', 1, '2026-03-05 22:16:41');
INSERT INTO `biz_outsourcing_receipt` VALUES (2029553531656114177, 'OSR1772718243884', '2603050001', '中秋盲盒', '表面处理 - 压纹', 2029549846247018498, 9100.00, 9100.00, '平方米', 1.2000, 10920.00, '2026-03-05 21:44:03', '1', NULL, '0', 103, 1, '2026-03-05 21:44:04', 1, '2026-03-05 22:16:47');
INSERT INTO `biz_outsourcing_receipt` VALUES (2030247401675091970, 'OSR1772883675393', '2603070002', '测试产品001', '表面处理 - 过光胶', 2030243625677418497, 8050.00, 8050.00, '平方米', 0.0000, 1.00, '2026-03-07 19:41:15', '1', NULL, '0', 103, 1, '2026-03-07 19:41:15', 1, '2026-03-07 19:41:43');
INSERT INTO `biz_outsourcing_receipt` VALUES (2030247403059212290, 'OSR1772883675723', '2603070002', '测试产品001', '表面处理 - 击凸', 2029550563984707585, 8050.00, 8050.00, '平方米', 0.0000, 1.02, '2026-03-07 19:41:15', '1', NULL, '0', 103, 1, '2026-03-07 19:41:16', 1, '2026-03-07 19:41:57');
INSERT INTO `biz_outsourcing_receipt` VALUES (2035681363843158017, 'OSR1774179232936', '2603220002', '礼盒1', '表面处理 - 过哑胶', 2030243625677418497, 10000.00, 10000.00, '平方米', 0.0100, 1450.13, '2026-03-22 19:33:52', '1', NULL, '0', 103, 1, '2026-03-22 19:33:53', 1, '2026-03-22 19:37:39');
INSERT INTO `biz_outsourcing_receipt` VALUES (2035681365285998594, 'OSR1774179233276', '2603220002', '礼盒1', '表面处理 - 过光胶', 2029550563984707585, 10000.00, 10000.00, '平方米', 0.0100, 5.87, '2026-03-22 19:33:52', '0', NULL, '0', 103, 1, '2026-03-22 19:33:53', 1, '2026-03-22 19:33:53');
INSERT INTO `biz_outsourcing_receipt` VALUES (2035681366678507521, 'OSR1774179233609', '2603220002', '礼盒1', '表面处理 - 烫金', 2029549846247018498, 10000.00, 10000.00, '平方米', 0.0100, 14.69, '2026-03-22 19:33:53', '0', NULL, '0', 103, 1, '2026-03-22 19:33:54', 1, '2026-03-22 19:33:54');
INSERT INTO `biz_outsourcing_receipt` VALUES (2035681368058433538, 'OSR1774179233938', '2603220002', '礼盒1', '表面处理 - 击凸', 2035676029082734593, 10000.00, 10000.00, '平方米', 0.0100, 0.15, '2026-03-22 19:33:53', '0', NULL, '0', 103, 1, '2026-03-22 19:33:54', 1, '2026-03-22 19:33:54');

-- ----------------------------
-- Table structure for biz_production_order
-- ----------------------------
DROP TABLE IF EXISTS `biz_production_order`;
CREATE TABLE `biz_production_order`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工单编号',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格型号',
  `planned_qty` decimal(15, 2) NOT NULL COMMENT '计划生产数量',
  `completed_qty` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '已完成数量',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0待生产 1生产中 2已完成 3已取消)',
  `start_date` date NULL DEFAULT NULL COMMENT '计划开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '计划结束日期',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产工单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_production_order
-- ----------------------------

-- ----------------------------
-- Table structure for biz_production_schedule
-- ----------------------------
DROP TABLE IF EXISTS `biz_production_schedule`;
CREATE TABLE `biz_production_schedule`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '排产主键ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工单编号',
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生产部件/产品名称',
  `quantity` int NOT NULL COMMENT '生产数量',
  `delivery_date` date NULL DEFAULT NULL COMMENT '交货日期',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '排产状态(如: 0待生产, 1生产中, 2已完成入库)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跟单备注(最右侧列)',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035681331035312131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产排产主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_production_schedule
-- ----------------------------
INSERT INTO `biz_production_schedule` VALUES (2029553014750089218, 2029552035195555841, '2603050001', '中秋盲盒', 9100, '2026-03-12', '0', NULL, 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 22:13:25', '1');
INSERT INTO `biz_production_schedule` VALUES (2029553014792032259, 2029552035195555841, '2603050001', '重生点纸钱', 350, '2026-03-12', '0', NULL, 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 22:13:27', '1');
INSERT INTO `biz_production_schedule` VALUES (2030215644703744002, 2030215622440378370, '2603070001', '1111', 111, '2026-03-08', '0', NULL, 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04', '0');
INSERT INTO `biz_production_schedule` VALUES (2030245983887093762, 2030244845267775489, '2603070002', '测试产品001', 8050, '2026-03-30', '2', NULL, 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37', '0');
INSERT INTO `biz_production_schedule` VALUES (2035681331035312130, 2035680913995665409, '2603220002', '礼盒1', 10000, '2026-03-26', '2', NULL, 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45', '0');

-- ----------------------------
-- Table structure for biz_purchase
-- ----------------------------
DROP TABLE IF EXISTS `biz_purchase`;
CREATE TABLE `biz_purchase`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '采购单号',
  `related_wo_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联工单编号',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '采购内容/名称',
  `spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `apply_qty` decimal(15, 2) NULL DEFAULT NULL COMMENT '采购数量',
  `received_qty` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '验收数量',
  `price` decimal(10, 4) NULL DEFAULT NULL COMMENT '采购单价',
  `total_price` decimal(15, 2) NULL DEFAULT NULL COMMENT '采购总价',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态: 0-待审, 1-已批, 2-已验收, 3-驳回',
  `applicant_id` bigint NULL DEFAULT NULL COMMENT '申请人ID',
  `verify_time` datetime NULL DEFAULT NULL COMMENT '验收时间',
  `delivery_date` date NULL DEFAULT NULL COMMENT '期望交货期',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT NULL,
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035681331358273539 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '采购管理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_purchase
-- ----------------------------
INSERT INTO `biz_purchase` VALUES (2029514054455795713, 'CG2026030519071156', '2603050001', NULL, '材料 - eniwfnwio', '136*2329', 999.00, 0.00, NULL, NULL, '0', 1, NULL, NULL, '1', '2026-03-05 19:07:12', 103, '1', '2026-03-05 22:16:14', '1');
INSERT INTO `biz_purchase` VALUES (2029514054468378626, 'CG2026030519071147', '2603050001', 2029550563984707585, '材料 - f\'we\'f\'we', '', 1.00, 0.00, NULL, NULL, '3', 1, NULL, NULL, '1', '2026-03-05 19:07:12', 103, '1', '2026-03-05 21:47:36', '0');
INSERT INTO `biz_purchase` VALUES (2029553014846558209, 'CG2026030521420075', '2603050001', 2029549846247018498, '纸张 - 坑纸898g', '333*44*44', 9200.00, 9200.00, 1.0300, 9476.00, '2', 1, NULL, '2026-03-10', '1', '2026-03-05 21:42:01', 103, '1', '2026-03-05 22:16:08', '0');
INSERT INTO `biz_purchase` VALUES (2030245983950008330, 'CG2026030719353732', '2603070002', NULL, '面纸 - 白纸300g', '111*222', 8109.00, 8109.00, 1.0000, 8109.00, '2', 1, NULL, NULL, '1', '2026-03-07 19:35:37', 103, '1', '2026-03-07 19:36:27', '0');
INSERT INTO `biz_purchase` VALUES (2030245983950008331, 'CG2026030719353723', '2603070002', NULL, '配件 - 手提袋', '222*333', 8000.00, 8000.00, 1.0000, 8000.00, '2', 1, NULL, NULL, '1', '2026-03-07 19:35:37', 103, '1', '2026-03-07 19:36:34', '0');
INSERT INTO `biz_purchase` VALUES (2035681331358273537, 'CG2026032219334551', '2603220002', 2029550563984707585, '成品 - 纸袋', '111*111*222', 10000.00, 0.00, NULL, NULL, '1', 1, NULL, NULL, '1', '2026-03-22 19:33:45', 103, '1', '2026-03-22 19:37:28', '0');
INSERT INTO `biz_purchase` VALUES (2035681331358273538, 'CG2026032219334571', '2603220002', NULL, '包装箱', '500*500*500', 500.00, 0.00, NULL, NULL, '0', 1, NULL, NULL, '1', '2026-03-22 19:33:45', 103, '1', '2026-03-22 19:33:45', '0');

-- ----------------------------
-- Table structure for biz_schedule_node
-- ----------------------------
DROP TABLE IF EXISTS `biz_schedule_node`;
CREATE TABLE `biz_schedule_node`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '节点主键ID',
  `schedule_id` bigint NOT NULL COMMENT '关联排产主表ID',
  `node_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工序编码(如:print, gluing等)',
  `node_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工序名称(供参考)',
  `status_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'white' COMMENT '状态颜色(red, yellow, green, white)',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '格子填写的具体内容(日期/文字)',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_schedule_node`(`schedule_id` ASC, `node_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035681331295358987 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '排产工序节点状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_schedule_node
-- ----------------------------
INSERT INTO `biz_schedule_node` VALUES (2028761764719525889, 2028761764715331585, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764719525890, 2028761764715331585, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764719525891, 2028761764715331585, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764727914497, 2028761764715331585, 'print', '印刷', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764727914498, 2028761764715331585, 'surface', '表面处理', 'green', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:34:12');
INSERT INTO `biz_schedule_node` VALUES (2028761764736303106, 2028761764715331585, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764740497409, 2028761764715331585, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764740497410, 2028761764715331585, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764748886017, 2028761764715331585, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2028761764748886018, 2028761764715331585, 'packing', '打包', 'red', '', 103, 1, '2026-03-03 17:17:52', 1, '2026-03-03 17:17:52');
INSERT INTO `biz_schedule_node` VALUES (2029514054178971649, 2029514054107668481, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054241886210, 2029514054107668481, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054246080514, 2029514054107668481, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054254469122, 2029514054107668481, 'print', '印刷', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054262857730, 2029514054107668481, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054271246337, 2029514054107668481, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054275440641, 2029514054107668481, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054288023554, 2029514054107668481, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054296412162, 2029514054107668481, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054304800770, 2029514054107668481, 'packing', '打包', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054321577985, 2029514054317383681, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054329966593, 2029514054317383681, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054338355201, 2029514054317383681, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054350938114, 2029514054317383681, 'print', '印刷', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054355132418, 2029514054317383681, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054363521026, 2029514054317383681, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054371909634, 2029514054317383681, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054376103938, 2029514054317383681, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054380298241, 2029514054317383681, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029514054392881153, 2029514054317383681, 'packing', '打包', 'red', '', 103, 1, '2026-03-05 19:07:12', 1, '2026-03-05 19:07:12');
INSERT INTO `biz_schedule_node` VALUES (2029553014758477826, 2029553014750089218, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014766866434, 2029553014750089218, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014775255042, 2029553014750089218, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014775255043, 2029553014750089218, 'print', '印刷', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014779449345, 2029553014750089218, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014779449346, 2029553014750089218, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014787837954, 2029553014750089218, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014787837955, 2029553014750089218, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014792032257, 2029553014750089218, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014792032258, 2029553014750089218, 'packing', '打包', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014800420865, 2029553014792032259, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014800420866, 2029553014792032259, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014800420867, 2029553014792032259, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014808809474, 2029553014792032259, 'print', '印刷', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014813003777, 2029553014792032259, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014813003778, 2029553014792032259, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014817198081, 2029553014792032259, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014817198082, 2029553014792032259, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014817198083, 2029553014792032259, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2029553014825586689, 2029553014792032259, 'packing', '打包', 'red', '', 103, 1, '2026-03-05 21:42:01', 1, '2026-03-05 21:42:01');
INSERT INTO `biz_schedule_node` VALUES (2030215644833767426, 2030215644703744002, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681986, 2030215644703744002, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681987, 2030215644703744002, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681988, 2030215644703744002, 'print', '印刷', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681989, 2030215644703744002, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681990, 2030215644703744002, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681991, 2030215644703744002, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681992, 2030215644703744002, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681993, 2030215644703744002, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030215644896681994, 2030215644703744002, 'packing', '打包', 'red', '', 103, 1, '2026-03-07 17:35:04', 1, '2026-03-07 17:35:04');
INSERT INTO `biz_schedule_node` VALUES (2030245983887093763, 2030245983887093762, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008321, 2030245983887093762, 'face_paper', '面纸', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008322, 2030245983887093762, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008323, 2030245983887093762, 'print', '印刷', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008324, 2030245983887093762, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008325, 2030245983887093762, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008326, 2030245983887093762, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008327, 2030245983887093762, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008328, 2030245983887093762, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2030245983950008329, 2030245983887093762, 'packing', '打包', 'red', '', 103, 1, '2026-03-07 19:35:37', 1, '2026-03-07 19:35:37');
INSERT INTO `biz_schedule_node` VALUES (2035681331228250114, 2035681331035312130, 'purchase', '采购辅料', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358978, 2035681331035312130, 'face_paper', '面纸', 'white', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:34:35');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358979, 2035681331035312130, 'pit_paper', '坑纸', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358980, 2035681331035312130, 'print', '印刷', 'yellow', '测试', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:34:31');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358981, 2035681331035312130, 'surface', '表面处理', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358982, 2035681331035312130, 'die_board', '刀模', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358983, 2035681331035312130, 'die_cut', '啤', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358984, 2035681331035312130, 'mounting', '裱坑', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358985, 2035681331035312130, 'gluing', '粘盒', 'red', '', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:33:45');
INSERT INTO `biz_schedule_node` VALUES (2035681331295358986, 2035681331035312130, 'packing', '打包', 'green', '未完成\n', 103, 1, '2026-03-22 19:33:45', 1, '2026-03-22 19:34:23');

-- ----------------------------
-- Table structure for biz_temp_worker
-- ----------------------------
DROP TABLE IF EXISTS `biz_temp_worker`;
CREATE TABLE `biz_temp_worker`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `worker_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '临时工姓名',
  `work_date` date NOT NULL COMMENT '工作日期',
  `related_wo_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联工单号(可为空)',
  `work_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计费方式: 1-计时, 2-计件',
  `work_qty` decimal(10, 2) NOT NULL COMMENT '数量/时长',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '总薪资',
  `pay_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '支付状态: 0-未付, 1-已付',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工作内容描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '临时工费用登记表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_temp_worker
-- ----------------------------
INSERT INTO `biz_temp_worker` VALUES (2029555173625466882, '王楚钦', '2026-03-05', NULL, '1', 11.00, 14.00, 154.00, '1', NULL, '0', 103, 1, '2026-03-05 21:50:35', 1, '2026-03-05 22:10:09');
INSERT INTO `biz_temp_worker` VALUES (2035682092754472962, '樊振东', '2026-03-22', NULL, '2', 5000.00, 1.00, 5000.00, '1', NULL, '0', 103, 1, '2026-03-22 19:36:47', 1, '2026-03-22 19:37:54');

-- ----------------------------
-- Table structure for biz_temp_worker_info
-- ----------------------------
DROP TABLE IF EXISTS `biz_temp_worker_info`;
CREATE TABLE `biz_temp_worker_info`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `worker_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '临时工姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `skills` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '特长/工种',
  `default_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '默认工价(元)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态: 0-在职, 1-离职',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '临时工档案台账' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_temp_worker_info
-- ----------------------------
INSERT INTO `biz_temp_worker_info` VALUES (2029554686633218050, '马龙', '19999999999', '967567546321', NULL, 12.00, '0', NULL, '0', 103, 1, '2026-03-05 21:48:39', 1, '2026-03-05 21:48:39');
INSERT INTO `biz_temp_worker_info` VALUES (2029554775271444482, '王楚钦', '10000000000', '4654678734', NULL, 14.00, '0', NULL, '0', 103, 1, '2026-03-05 21:49:00', 1, '2026-03-05 21:49:00');
INSERT INTO `biz_temp_worker_info` VALUES (2035681978543575042, '樊振东', '13434344434343', NULL, NULL, 12.00, '0', NULL, '0', 103, 1, '2026-03-22 19:36:19', 1, '2026-03-22 19:36:19');

-- ----------------------------
-- Table structure for biz_wo_ctp
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_ctp`;
CREATE TABLE `biz_wo_ctp`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `part_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部件',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源(本厂CTP等)',
  `open_num` int NULL DEFAULT NULL COMMENT '开数(1-9)',
  `print_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷方式(自反, 天地反等)',
  `set_num` int NULL DEFAULT NULL COMMENT '套数',
  `plate_count` int NULL DEFAULT NULL COMMENT 'CTP版张数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974022 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单CTP子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_ctp
-- ----------------------------
INSERT INTO `biz_wo_ctp` VALUES (2035680961189974021, 2035680913995665409, '测试', NULL, 9, '正反', 543543, NULL, NULL, 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_wo_extra_purchase
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_extra_purchase`;
CREATE TABLE `biz_wo_extra_purchase`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `item_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '采购内容',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `quantity` decimal(15, 2) NULL DEFAULT NULL COMMENT '数量',
  `unit_price` decimal(10, 4) NULL DEFAULT NULL COMMENT '单价',
  `total_price` decimal(15, 2) NULL DEFAULT NULL COMMENT '总价',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单其他订购子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_extra_purchase
-- ----------------------------
INSERT INTO `biz_wo_extra_purchase` VALUES (2029508547452190721, 2029460291787526146, '材料 - eniwfnwio', '136*2329', 999.00, NULL, NULL, '由材料清单转入生成', 103, 1, '2026-03-05 18:45:19', 1, '2026-03-05 18:45:19');
INSERT INTO `biz_wo_extra_purchase` VALUES (2029508547460579329, 2029460291787526146, '材料 - f\'we\'f\'we', '', 1.00, NULL, NULL, '由材料清单转入生成', 103, 1, '2026-03-05 18:45:19', 1, '2026-03-05 18:45:19');
INSERT INTO `biz_wo_extra_purchase` VALUES (2029552486095818754, 2029552035195555841, '纸张 - 坑纸898g', '333*44*44', 9200.00, NULL, NULL, '由材料清单转入生成', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_extra_purchase` VALUES (2030244845401993218, 2030244845267775489, '面纸 - 白纸300g', '111*222', 8109.00, NULL, NULL, '由材料清单转入生成', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_extra_purchase` VALUES (2030244845401993219, 2030244845267775489, '配件 - 手提袋', '222*333', 8000.00, NULL, NULL, '测试订购备件', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_extra_purchase` VALUES (2035680961189974023, 2035680913995665409, '成品 - 纸袋', '111*111*222', 10000.00, NULL, NULL, '测试', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_extra_purchase` VALUES (2035680961189974024, 2035680913995665409, '包装箱', '500*500*500', 500.00, NULL, NULL, NULL, 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_wo_material
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_material`;
CREATE TABLE `biz_wo_material`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `part_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部件(面纸, 坑纸, 面纸a...)',
  `source_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源(自来, 订购, 本厂...)',
  `paper_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '纸张名称',
  `require_qty` int NULL DEFAULT NULL COMMENT '需求张数(自动计算结果)',
  `paper_size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '纸张尺寸',
  `cut_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '切成(如:正度对开)',
  `cut_size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '切纸尺寸',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974021 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单材料子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_material
-- ----------------------------
INSERT INTO `biz_wo_material` VALUES (2029508547418636290, 2029460291787526146, '配件', '本厂', '测试纸张', 999, '100*100', NULL, NULL, NULL, 103, 1, '2026-03-05 18:45:19', 1, '2026-03-05 18:45:19');
INSERT INTO `biz_wo_material` VALUES (2029508547422830593, 2029460291787526146, '纸张', '订购', 'f\'we\'f\'we', 898, NULL, NULL, NULL, NULL, 103, 1, '2026-03-05 18:45:19', 1, '2026-03-05 18:45:19');
INSERT INTO `biz_wo_material` VALUES (2029552486079041538, 2029552035195555841, '面纸', '自来', '宏图色纸', 110, '-', '-', NULL, NULL, 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_material` VALUES (2029552486079041539, 2029552035195555841, '配件', '自来', '嫦娥挂坠', 10, '-', '-', NULL, NULL, 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_material` VALUES (2029552486079041540, 2029552035195555841, '纸张', '订购', '坑纸898g', 9200, NULL, '-', NULL, NULL, 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_material` VALUES (2030215622570401794, 2030215622440378370, '面纸', '订购', '中秋盲盒', 102, '213*42*23', NULL, NULL, NULL, 103, 1, '2026-03-07 17:34:59', 1, '2026-03-07 17:34:59');
INSERT INTO `biz_wo_material` VALUES (2030215622570401795, 2030215622440378370, '坑纸', '自来', '白纸300g', 99999, '111*222', NULL, NULL, NULL, 103, 1, '2026-03-07 17:34:59', 1, '2026-03-07 17:34:59');
INSERT INTO `biz_wo_material` VALUES (2030244845334884354, 2030244845267775489, '面纸', '订购', '白纸300g', 109, '111*222', NULL, NULL, NULL, 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_material` VALUES (2030244845334884355, 2030244845267775489, '坑纸', '自来', '测试坑纸', 9, '222*333', NULL, NULL, NULL, 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_material` VALUES (2035680961189974018, 2035680913995665409, '面纸', '自来', '配件 - 手提袋', 11000, '333*44*44', NULL, NULL, NULL, 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_material` VALUES (2035680961189974019, 2035680913995665409, '坑纸', '自来', '纸张 - 坑纸898g', 10000, '333*44*44', NULL, NULL, NULL, 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_material` VALUES (2035680961189974020, 2035680913995665409, '成品', '订购', '纸袋', NULL, NULL, NULL, NULL, NULL, 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_wo_outsourcing
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_outsourcing`;
CREATE TABLE `biz_wo_outsourcing`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联产品名称',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '加工商/供应商ID',
  `process_project` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加工项目/工序(如:过哑胶,模切)',
  `finish_size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '成品尺寸',
  `process_qty` int NULL DEFAULT NULL COMMENT '加工数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '张' COMMENT '计算单位',
  `unit_price` decimal(10, 4) NULL DEFAULT NULL COMMENT '加工单价',
  `total_price` decimal(15, 2) NULL DEFAULT NULL COMMENT '加工总价',
  `extra_fee` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '附加费用',
  `delivery_date` date NULL DEFAULT NULL COMMENT '交货期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL,
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `material_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '材料名称',
  `length` decimal(10, 2) NULL DEFAULT NULL COMMENT '长(mm)',
  `width` decimal(10, 2) NULL DEFAULT NULL COMMENT '宽(mm)',
  `material_qty` int NULL DEFAULT NULL COMMENT '材料数量',
  `good_qty` int NULL DEFAULT NULL COMMENT '需生产良品数量',
  `price_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '张' COMMENT '单价计算方式(如:平方米,张,套)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961257082886 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单委外加工子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_outsourcing
-- ----------------------------
INSERT INTO `biz_wo_outsourcing` VALUES (2029552486116790274, 2029552035195555841, '中秋盲盒', 2029550563984707585, '表面处理 - 过光胶', '3*5435', 9100, '平方米', NULL, 0.00, 0.00, '2026-03-10', '232', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55', '宏图色纸', 3.00, 5435.00, NULL, 10000, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2029552486120984577, 2029552035195555841, '中秋盲盒', 2029549846247018498, '表面处理 - 烫金', '34*543', 9100, '平方米', NULL, 0.00, 0.00, '2026-03-10', '323', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55', '宏图色纸', 34.00, 543.00, NULL, 10000, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2029552486120984578, 2029552035195555841, '中秋盲盒', 2029549846247018498, '表面处理 - 击凸', '432*2', 9100, '平方米', NULL, 0.00, 0.00, '2026-03-10', '334', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55', '宏图色纸', 432.00, 2.00, NULL, 10000, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2029552486120984579, 2029552035195555841, '中秋盲盒', 2029549846247018498, '表面处理 - 压纹', '42*453', 9100, '平方米', NULL, 0.00, 0.00, '2026-03-10', '454', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55', '宏图色纸', 42.00, 453.00, NULL, 10000, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2030215622700425217, 2030215622440378370, '1111', 2029549846247018498, '表面处理 - 烫金', '213*42', 111, '平方米', NULL, 0.00, 0.00, NULL, 'reggresgr', 103, 1, '2026-03-07 17:34:59', 1, '2026-03-07 17:34:59', '中秋盲盒', 213.00, 42.00, NULL, NULL, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2030244845464907778, 2030244845267775489, '测试产品001', 2030243625677418497, '表面处理 - 过光胶', '111*222', 8050, '平方米', NULL, 0.00, 0.00, NULL, '测试备注001', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06', '白纸300g', 111.00, 222.00, NULL, 8100, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2030244845464907779, 2030244845267775489, '测试产品001', 2029550563984707585, '表面处理 - 击凸', '111*222', 8050, '平方米', NULL, 0.00, 0.00, NULL, '测试备注002', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06', '白纸300g', 111.00, 222.00, NULL, 8000, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2035680961257082882, 2035680913995665409, '礼盒1', 2030243625677418497, '表面处理 - 过哑胶', '3339*4343', 10000, '平方米', 0.0100, 1450.13, 0.00, '2026-03-25', '111', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17', '面纸 - 白纸300g', 3339.00, 4343.00, NULL, 11111, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2035680961257082883, 2035680913995665409, '礼盒1', 2029550563984707585, '表面处理 - 过光胶', '1333*44', 10000, '平方米', 0.0100, 5.87, 0.00, '2026-03-24', '222', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17', '面纸 - 白纸300g', 1333.00, 44.00, NULL, 11111, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2035680961257082884, 2035680913995665409, '礼盒1', 2029549846247018498, '表面处理 - 烫金', '3339*44', 10000, '平方米', 0.0100, 14.69, 0.00, '2026-03-31', '444', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17', '面纸 - 白纸300g', 3339.00, 44.00, NULL, 11111, '张');
INSERT INTO `biz_wo_outsourcing` VALUES (2035680961257082885, 2035680913995665409, '礼盒1', 2035676029082734593, '表面处理 - 击凸', '33*44', 10000, '平方米', 0.0100, 0.15, 0.00, '2026-03-30', '333', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17', '面纸 - 白纸300g', 33.00, 44.00, NULL, 11111, '张');

-- ----------------------------
-- Table structure for biz_wo_post_process
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_post_process`;
CREATE TABLE `biz_wo_post_process`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `finish_size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '成品尺寸',
  `process_content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '形目内容(多选)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单后续加工子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_post_process
-- ----------------------------

-- ----------------------------
-- Table structure for biz_wo_print
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_print`;
CREATE TABLE `biz_wo_print`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `machine_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷机号',
  `print_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷颜色(4C, 1C等)',
  `print_size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷尺寸',
  `print_method` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷方式(多选,逗号分隔)',
  `mold_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模数(3+1等)',
  `actual_print_qty` int NULL DEFAULT NULL COMMENT '印刷实数',
  `loss_qty` int NULL DEFAULT NULL COMMENT '损耗数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974023 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单印刷子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_print
-- ----------------------------
INSERT INTO `biz_wo_print` VALUES (2029552486087430145, 2029552035195555841, '起飞机', '5C', '479*349', '正反', '4', 10000, NULL, NULL, 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_print` VALUES (2030244845334884356, 2030244845267775489, 'xx号', '5C', '462*312', '正反', '3+3', NULL, NULL, '545256354', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_print` VALUES (2035680961189974022, 2035680913995665409, '测试', '5C', '600*999', '单面', '6', 99999, 700, '备注', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_wo_process
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_process`;
CREATE TABLE `biz_wo_process`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `process_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工序名称(如:表面处理,裱坑,粘盒)',
  `process_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工艺内容(如下拉选择的:单钉,双钉)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL,
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974029 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单生产工艺子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_process
-- ----------------------------
INSERT INTO `biz_wo_process` VALUES (2029552486104207362, 2029552035195555841, '表面处理 - 过光胶', NULL, '111', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_process` VALUES (2029552486104207363, 2029552035195555841, '表面处理 - 烫金', NULL, '222', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_process` VALUES (2029552486104207364, 2029552035195555841, '表面处理 - 击凸', NULL, '333', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_process` VALUES (2029552486104207365, 2029552035195555841, '表面处理 - 压纹', NULL, '444', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_process` VALUES (2030215622633316354, 2030215622440378370, '表面处理 - 烫金', NULL, 'reggresgr', 103, 1, '2026-03-07 17:34:59', 1, '2026-03-07 17:34:59');
INSERT INTO `biz_wo_process` VALUES (2030244845401993220, 2030244845267775489, '表面处理 - 过光胶', NULL, '测试备注001', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_process` VALUES (2030244845401993221, 2030244845267775489, '表面处理 - 击凸', NULL, '测试备注002', 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_process` VALUES (2035680961189974025, 2035680913995665409, '表面处理 - 过哑胶', NULL, '111', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_process` VALUES (2035680961189974026, 2035680913995665409, '表面处理 - 过光胶', NULL, '222', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_process` VALUES (2035680961189974027, 2035680913995665409, '表面处理 - 击凸', NULL, '333', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');
INSERT INTO `biz_wo_process` VALUES (2035680961189974028, 2035680913995665409, '表面处理 - 烫金', NULL, '444', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_wo_product
-- ----------------------------
DROP TABLE IF EXISTS `biz_wo_product`;
CREATE TABLE `biz_wo_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL COMMENT '关联工单ID',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `customer_po` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户PO号',
  `customer_material_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户物料号',
  `spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `layers` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '层数(单E,BB等)',
  `knife_plate_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刀版号',
  `order_quantity` int NULL DEFAULT 0 COMMENT '订单数量',
  `produce_quantity` int NULL DEFAULT 0 COMMENT '生产数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '个' COMMENT '单位',
  `unit_price` decimal(10, 4) NULL DEFAULT 0.0000 COMMENT '单价',
  `total_amount` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '总金额',
  `delivery_date` date NULL DEFAULT NULL COMMENT '专属交货日期',
  `create_dept` bigint NULL DEFAULT NULL,
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680961189974018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单产品明细子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_wo_product
-- ----------------------------
INSERT INTO `biz_wo_product` VALUES (2029552486062264321, 2029552035195555841, '中秋盲盒', 'AF-0815', '5180-FA', '213*42*23', '单B', '旧刀模', 9000, 9100, '个', 5.1000, 46410.00, '2026-03-09', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_product` VALUES (2029552486070652929, 2029552035195555841, '重生点纸钱', '', '', '', '', '', 333, 350, '个', 0.0200, 7.00, '2026-03-09', 103, 1, '2026-03-05 21:39:55', 1, '2026-03-05 21:39:55');
INSERT INTO `biz_wo_product` VALUES (2030215622440378371, 2030215622440378370, '1111', '', '', '', '', '', 111, 111, '个', 0.0000, 0.00, '2026-03-08', 103, 1, '2026-03-07 17:34:59', 1, '2026-03-07 17:34:59');
INSERT INTO `biz_wo_product` VALUES (2030244845267775490, 2030244845267775489, '测试产品001', '', '', '83*321', '单B', '旧刀模', 8000, 8050, '个', 3.5000, 28175.00, NULL, 103, 1, '2026-03-07 19:31:06', 1, '2026-03-07 19:31:06');
INSERT INTO `biz_wo_product` VALUES (2035680961189974017, 2035680913995665409, '礼盒1', '', '', '111*111*111', '单B', '', 9999, 10000, '个', 0.9000, 9000.00, '2026-03-26', 103, 1, '2026-03-22 19:32:17', 1, '2026-03-22 19:32:17');

-- ----------------------------
-- Table structure for biz_work_order
-- ----------------------------
DROP TABLE IF EXISTS `biz_work_order`;
CREATE TABLE `biz_work_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工单编号(例:2602030037)',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称快照',
  `product_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '包含产品名称快照(冗余字段,用于列表展示和搜索)',
  `total_amount` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '总金额',
  `order_date` date NULL DEFAULT NULL COMMENT '开单日期',
  `delivery_date` date NULL DEFAULT NULL COMMENT '交货日期',
  `sales_man_id` bigint NULL DEFAULT NULL COMMENT '业务员ID',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '开单人ID',
  `production_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '未生产' COMMENT '生产进度: 完成,未完成,已排产,异常',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审核状态: 0-待审, 1-通过, 2-驳回',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人签名',
  `pack_requirement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '包装要求',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_wo_no`(`work_order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2035680913995665410 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产工单主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of biz_work_order
-- ----------------------------
INSERT INTO `biz_work_order` VALUES (2029516750768316418, '2603050002', 2028749557034156034, '测试客户1', 'ebiuceiwu,cacac', 0.00, NULL, '2026-03-31', NULL, NULL, '未生产', '1', NULL, 'wfwa', 'vdvsd', '1', '2026-03-05 19:17:55', '1', '2026-03-05 21:21:17', '1', 103);
INSERT INTO `biz_work_order` VALUES (2029552035195555841, '2603050001', 2029549525726695425, '测试客户1', '中秋盲盒,重生点纸钱', 0.00, NULL, '2026-03-12', NULL, NULL, '未生产', '2', 'admin', '运输箱子', NULL, '1', '2026-03-05 21:38:07', '1', '2026-03-05 21:42:01', '0', 103);
INSERT INTO `biz_work_order` VALUES (2030215622440378370, '2603070001', 2029549525726695425, '测试客户1', '1111', 0.00, NULL, '2026-03-08', NULL, NULL, '未生产', '2', 'admin', NULL, NULL, '1', '2026-03-07 17:34:59', '1', '2026-03-07 17:35:04', '0', 103);
INSERT INTO `biz_work_order` VALUES (2030244845267775489, '2603070002', 2030243178455560194, '客户001', '测试产品001', 0.00, NULL, '2026-03-30', NULL, NULL, '未生产', '2', 'admin', NULL, NULL, '1', '2026-03-07 19:31:06', '1', '2026-03-07 19:35:37', '0', 103);
INSERT INTO `biz_work_order` VALUES (2035678104340467713, '2603220001', 2030243178455560194, '客户001', '礼盒1', 0.00, NULL, '2026-03-28', NULL, NULL, '未生产', '1', NULL, NULL, NULL, '1', '2026-03-22 19:20:56', '1', '2026-03-22 19:33:40', '1', 103);
INSERT INTO `biz_work_order` VALUES (2035680913995665409, '2603220002', 2029550188372201473, '测试客户2', '礼盒1', 0.00, NULL, '2026-03-26', NULL, NULL, '未生产', '2', 'admin', '备注', NULL, '1', '2026-03-22 19:32:06', '1', '2026-03-22 19:33:45', '0', 103);

-- ----------------------------
-- Table structure for erp_prod_cost
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_cost`;
CREATE TABLE `erp_prod_cost`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `material_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '面纸金额',
  `flute_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '坑纸金额',
  `print_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '印刷金额',
  `surface_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '表面处理',
  `laminate_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '裱坑金额',
  `die_cut_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '啤机金额',
  `other_cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '其他金额',
  `total_cost` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '总计',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单金额表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_cost
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_ctp
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_ctp`;
CREATE TABLE `erp_prod_ctp`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `component_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部件',
  `source_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源',
  `open_number` int NULL DEFAULT 1 COMMENT '开数',
  `print_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '印刷方式',
  `set_number` int NULL DEFAULT 1 COMMENT '套数',
  `plate_count` int NULL DEFAULT 4 COMMENT 'CTP版张数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单CTP表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_ctp
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_material
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_material`;
CREATE TABLE `erp_prod_material`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `component_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部件',
  `source_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源',
  `material_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '纸张名称',
  `quantity` bigint NULL DEFAULT 0 COMMENT '纸张数量',
  `material_size` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '纸张尺寸',
  `cut_method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '切成',
  `cut_size` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '切纸尺寸',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单材料表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_material
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_order`;
CREATE TABLE `erp_prod_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工单编号(年月日+流水号)',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `customer_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称(冗余)',
  `sales_id` bigint NULL DEFAULT NULL COMMENT '业务员ID',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '开单人ID',
  `delivery_date` date NULL DEFAULT NULL COMMENT '交货日期',
  `prod_quantity` bigint NULL DEFAULT 0 COMMENT '生产总数量(等于订单数之和)',
  `layer_count` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '层数',
  `knife_template_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刀版号',
  `structure_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结构类型',
  `structure_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '结构说明',
  `structure_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结构图纸URL',
  `total_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '工单总金额',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0待产 1生产中 2完成)',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产工单主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_order
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_print
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_print`;
CREATE TABLE `erp_prod_print`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `component_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部件',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `print_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方式',
  `print_color` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '4+0' COMMENT '印色',
  `print_number` int NULL DEFAULT 0 COMMENT '正数',
  `loss_number` int NULL DEFAULT 0 COMMENT '印损',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单印刷表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_print
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_process
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_process`;
CREATE TABLE `erp_prod_process`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `process_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工艺名称(如表面处理)',
  `process_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工艺内容(如过光胶)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单工艺表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_process
-- ----------------------------

-- ----------------------------
-- Table structure for erp_prod_product
-- ----------------------------
DROP TABLE IF EXISTS `erp_prod_product`;
CREATE TABLE `erp_prod_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '关联主表ID',
  `product_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品编码(拼音+日期+流水)',
  `cust_mat_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户物料号',
  `cust_po_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户PO号',
  `product_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `specs` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `order_qty` bigint NULL DEFAULT 0 COMMENT '订单数',
  `mix_plate` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '搭版',
  `unit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '个' COMMENT '单位',
  `unit_price` decimal(10, 4) NULL DEFAULT 0.0000 COMMENT '单价',
  `total_amount` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '金额',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单产品明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_prod_product
-- ----------------------------

-- ----------------------------
-- Table structure for flow_category
-- ----------------------------
DROP TABLE IF EXISTS `flow_category`;
CREATE TABLE `flow_category`  (
  `category_id` bigint NOT NULL COMMENT '流程分类ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父流程分类id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `category_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程分类名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_category
-- ----------------------------
INSERT INTO `flow_category` VALUES (100, '000000', 0, '0', 'OA审批', 0, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (101, '000000', 100, '0,100', '假勤管理', 0, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (102, '000000', 100, '0,100', '人事管理', 1, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (103, '000000', 101, '0,100,101', '请假', 0, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (104, '000000', 101, '0,100,101', '出差', 1, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (105, '000000', 101, '0,100,101', '加班', 2, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (106, '000000', 101, '0,100,101', '换班', 3, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (107, '000000', 101, '0,100,101', '外出', 4, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (108, '000000', 102, '0,100,102', '转正', 1, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (109, '000000', 102, '0,100,102', '离职', 2, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL);
INSERT INTO `flow_category` VALUES (1024, '000000', 0, '0', 'ERP业务', 1, '0', NULL, NULL, '2026-02-24 14:30:17', NULL, NULL);
INSERT INTO `flow_category` VALUES (2026157455108517889, '000000', 100, '0,100', '生产审批', 0, '0', 103, 1, '2026-02-24 12:49:16', 1, '2026-02-24 12:49:16');
INSERT INTO `flow_category` VALUES (2026183226057338881, '000000', 1024, '0,1024', '生产审批', 0, '0', 103, 1, '2026-02-24 14:31:40', 1, '2026-02-24 14:31:40');

-- ----------------------------
-- Table structure for flow_definition
-- ----------------------------
DROP TABLE IF EXISTS `flow_definition`;
CREATE TABLE `flow_definition`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `flow_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程编码',
  `flow_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程名称',
  `model_value` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'CLASSICS' COMMENT '设计器模型（CLASSICS经典模型 MIMIC仿钉钉模型）',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程类别',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程版本',
  `is_publish` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否发布（0未发布 1已发布 9失效）',
  `form_custom` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批表单路径',
  `activity_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '流程激活状态（0挂起 1激活）',
  `listener_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '监听器路径',
  `ext` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程定义表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_definition
-- ----------------------------
INSERT INTO `flow_definition` VALUES (2026183656657170434, 'work_order_approval', '生产审批', 'CLASSICS', '1024', '1', 1, 'N', '', 0, NULL, NULL, '{\"autoPass\":false}', '2026-02-24 14:33:23', '1', '2026-02-25 12:39:16', '1', '1', NULL);
INSERT INTO `flow_definition` VALUES (2026517518344040449, 'work_order_approval', '审批工单', 'CLASSICS', '1024', '1', 0, 'N', '', 1, NULL, NULL, '{\"autoPass\":false}', '2026-02-25 12:40:02', '1', '2026-02-25 12:43:08', '1', '1', NULL);
INSERT INTO `flow_definition` VALUES (2026517999946608641, 'work_order_approval', '生产审批', 'CLASSICS', '1024', '2', 1, 'N', '', 1, NULL, NULL, NULL, '2026-02-25 12:41:57', '1', '2026-02-25 12:50:48', '1', '0', NULL);
INSERT INTO `flow_definition` VALUES (2026517999946608642, 'work_order_approval', '生产审批', 'CLASSICS', '1024', '2', 0, 'N', '', 1, NULL, NULL, NULL, '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '0', NULL);

-- ----------------------------
-- Table structure for flow_his_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_his_task`;
CREATE TABLE `flow_his_task`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `task_id` bigint NOT NULL COMMENT '对应flow_task表的id',
  `node_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开始节点编码',
  `node_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开始节点名称',
  `node_type` tinyint(1) NULL DEFAULT NULL COMMENT '开始节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `target_node_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标节点编码',
  `target_node_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结束节点名称',
  `approver` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批人',
  `cooperate_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '协作方式(1审批 2转办 3委派 4会签 5票签 6加签 7减签)',
  `collaborator` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '协作人',
  `skip_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流转类型（PASS通过 REJECT退回 NONE无动作）',
  `flow_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批表单路径',
  `message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批意见',
  `variable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '任务变量',
  `ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime NULL DEFAULT NULL COMMENT '任务开始时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '审批完成时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '历史任务记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_his_task
-- ----------------------------

-- ----------------------------
-- Table structure for flow_instance
-- ----------------------------
DROP TABLE IF EXISTS `flow_instance`;
CREATE TABLE `flow_instance`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `business_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `node_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程节点名称',
  `variable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '任务变量',
  `flow_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `activity_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '流程激活状态（0挂起 1激活）',
  `def_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '流程定义json',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `ext` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '扩展字段，预留给业务系统使用',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程实例表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_instance
-- ----------------------------

-- ----------------------------
-- Table structure for flow_instance_biz_ext
-- ----------------------------
DROP TABLE IF EXISTS `flow_instance_biz_ext`;
CREATE TABLE `flow_instance_biz_ext`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `business_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务编码',
  `business_title` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务标题',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `instance_id` bigint NULL DEFAULT NULL COMMENT '流程实例Id',
  `business_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程实例业务扩展表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_instance_biz_ext
-- ----------------------------

-- ----------------------------
-- Table structure for flow_node
-- ----------------------------
DROP TABLE IF EXISTS `flow_node`;
CREATE TABLE `flow_node`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `node_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程节点名称',
  `permission_flag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识（权限类型:权限标识，可以多个，用@@隔开)',
  `node_ratio` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '流程签署比例值',
  `coordinate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '坐标',
  `any_node_skip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任意结点跳转',
  `listener_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '监听器路径',
  `form_custom` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批表单路径',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '版本',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '节点扩展属性',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程节点表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_node
-- ----------------------------
INSERT INTO `flow_node` VALUES (2026185568643231746, 0, 2026183656657170434, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103.10553932189941,146.28888702392578|103.10553932189941,146.28888702392578', NULL, '', '', 'N', NULL, '1', '2026-02-24 14:40:59', '1', '2026-02-24 14:40:59', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026185568643231747, 1, 2026183656657170434, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1', '0', '233.1055393218994,147.28888702392578|233.1055393218994,147.28888702392578', NULL, 'start', 'workOrderPassListener', 'N', NULL, '1', '2026-02-24 14:40:59', '1', '2026-02-24 14:40:59', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026185568643231748, 2, 2026183656657170434, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391.1055393218994,151.28888702392578|391.1055393218994,151.28888702392578', NULL, NULL, NULL, 'N', NULL, '1', '2026-02-24 14:40:59', '1', '2026-02-24 14:40:59', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026185623949324290, 0, 2026183656657170434, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103,146|103,146', NULL, '', '', 'N', NULL, '1', '2026-02-24 14:41:12', '1', '2026-02-24 14:41:12', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026185623949324291, 1, 2026183656657170434, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1', '0', '233,147|233,147', NULL, 'start', 'workOrderPassListener', 'N', NULL, '1', '2026-02-24 14:41:12', '1', '2026-02-24 14:41:12', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026185623949324292, 2, 2026183656657170434, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391,151|391,151', NULL, NULL, NULL, 'N', NULL, '1', '2026-02-24 14:41:12', '1', '2026-02-24 14:41:12', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580161, 0, 2026517999946608642, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103,146|103,146', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580162, 0, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103.10553932189941,146.28888702392578|103.10553932189941,146.28888702392578', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580163, 1, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '', '0', '233.1055393218994,147.28888702392578|233.1055393218994,147.28888702392578', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580164, 1, 2026517999946608642, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1', '0', '233,147|233,147', NULL, 'start', 'workOrderPassListener', 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580165, 2, 2026517999946608642, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391,151|391,151', NULL, NULL, NULL, 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026517999967580166, 2, 2026517999946608641, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391.1055393218994,151.28888702392578|391.1055393218994,151.28888702392578', NULL, NULL, NULL, 'N', NULL, '2', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026520096075198466, 0, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103,146|103,146', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:50:16', '1', '2026-02-25 12:50:16', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026520096075198467, 1, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1@@role:1', '0', '233,147|233,147', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:50:16', '1', '2026-02-25 12:50:16', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026520096075198468, 2, 2026517999946608641, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391,151|391,151', NULL, NULL, NULL, 'N', NULL, '2', '2026-02-25 12:50:16', '1', '2026-02-25 12:50:16', '1', '[]', '1', NULL);
INSERT INTO `flow_node` VALUES (2026520172461862914, 0, 2026517999946608642, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103,146|103,146', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:50:35', '1', '2026-02-25 12:50:35', '1', '[]', '0', NULL);
INSERT INTO `flow_node` VALUES (2026520172461862915, 1, 2026517999946608642, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1', '0', '233,147|233,147', NULL, 'start', 'workOrderPassListener', 'N', NULL, '2', '2026-02-25 12:50:35', '1', '2026-02-25 12:50:35', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '0', NULL);
INSERT INTO `flow_node` VALUES (2026520172461862916, 2, 2026517999946608642, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391,151|391,151', NULL, NULL, NULL, 'N', NULL, '2', '2026-02-25 12:50:35', '1', '2026-02-25 12:50:35', '1', '[]', '0', NULL);
INSERT INTO `flow_node` VALUES (2026520207270391810, 0, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', '开始', NULL, '0', '103,146|103,146', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:50:43', '1', '2026-02-25 12:50:43', '1', '[]', '0', NULL);
INSERT INTO `flow_node` VALUES (2026520207270391811, 1, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', '部门审批', '1@@role:1', '0', '233,147|233,147', NULL, '', '', 'N', NULL, '2', '2026-02-25 12:50:43', '1', '2026-02-25 12:50:43', '1', '[{\"code\":\"ButtonPermissionEnum\",\"value\":\"copy,back,termination,file\"}]', '0', NULL);
INSERT INTO `flow_node` VALUES (2026520207270391812, 2, 2026517999946608641, '4af920d8-1da6-475e-942d-95b07ba0cbea', '结束', NULL, '0', '391,151|391,151', NULL, NULL, NULL, 'N', NULL, '2', '2026-02-25 12:50:43', '1', '2026-02-25 12:50:43', '1', '[]', '0', NULL);

-- ----------------------------
-- Table structure for flow_skip
-- ----------------------------
DROP TABLE IF EXISTS `flow_skip`;
CREATE TABLE `flow_skip`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `now_node_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '当前流程节点的编码',
  `now_node_type` tinyint(1) NULL DEFAULT NULL COMMENT '当前节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `next_node_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '下一个流程节点的编码',
  `next_node_type` tinyint(1) NULL DEFAULT NULL COMMENT '下一个节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `skip_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转名称',
  `skip_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转类型（PASS审批通过 REJECT退回）',
  `skip_condition` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转条件',
  `coordinate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '坐标',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '节点跳转关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_skip
-- ----------------------------
INSERT INTO `flow_skip` VALUES (2026185568773255170, 2026183656657170434, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', NULL, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-24 14:40:59', '1', '2026-02-24 14:40:59', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026185568773255171, 2026183656657170434, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', NULL, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-24 14:40:59', '1', '2026-02-24 14:40:59', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026185623949324293, 2026183656657170434, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', NULL, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-24 14:41:12', '1', '2026-02-24 14:41:12', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026185623949324294, 2026183656657170434, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', NULL, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-24 14:41:12', '1', '2026-02-24 14:41:12', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026517999988551681, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026517999988551682, 2026517999946608642, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026517999988551683, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', 2, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026517999988551684, 2026517999946608642, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', 2, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-25 12:41:57', '1', '2026-02-25 12:41:57', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026520096087781378, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', NULL, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-25 12:50:16', '1', '2026-02-25 12:50:16', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026520096087781379, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', NULL, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-25 12:50:16', '1', '2026-02-25 12:50:16', '1', '1', NULL);
INSERT INTO `flow_skip` VALUES (2026520172474445826, 2026517999946608642, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', NULL, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-25 12:50:35', '1', '2026-02-25 12:50:35', '1', '0', NULL);
INSERT INTO `flow_skip` VALUES (2026520172474445827, 2026517999946608642, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', NULL, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-25 12:50:35', '1', '2026-02-25 12:50:35', '1', '0', NULL);
INSERT INTO `flow_skip` VALUES (2026520207282974721, 2026517999946608641, 'b871690a-b908-4254-833c-0840c4fc224f', 0, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', NULL, NULL, 'PASS', NULL, '128,146;155,146;155,147;183,147', '2026-02-25 12:50:43', '1', '2026-02-25 12:50:43', '1', '0', NULL);
INSERT INTO `flow_skip` VALUES (2026520207282974722, 2026517999946608641, 'd7604984-a9d1-4d4f-b371-e89ccf3ee192', 1, '4af920d8-1da6-475e-942d-95b07ba0cbea', NULL, NULL, 'PASS', NULL, '283,147;324,147;324,151;366,151', '2026-02-25 12:50:43', '1', '2026-02-25 12:50:43', '1', '0', NULL);

-- ----------------------------
-- Table structure for flow_spel
-- ----------------------------
DROP TABLE IF EXISTS `flow_spel`;
CREATE TABLE `flow_spel`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名',
  `method_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参数',
  `view_spel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预览spel表达式',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程spel表达式定义表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_spel
-- ----------------------------
INSERT INTO `flow_spel` VALUES (1, 'spelRuleComponent', 'selectDeptLeaderById', 'initiatorDeptId', '#{@spelRuleComponent.selectDeptLeaderById(#initiatorDeptId)}', '根据部门id获取部门负责人', '0', '0', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50');
INSERT INTO `flow_spel` VALUES (2, NULL, NULL, 'initiator', '${initiator}', '流程发起人', '0', '0', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50');

-- ----------------------------
-- Table structure for flow_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_task`;
CREATE TABLE `flow_task`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `node_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '节点编码',
  `node_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '节点名称',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `flow_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批表单路径',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '待办任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_task
-- ----------------------------

-- ----------------------------
-- Table structure for flow_user
-- ----------------------------
DROP TABLE IF EXISTS `flow_user`;
CREATE TABLE `flow_user`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '人员类型（1待办任务的审批人权限 2待办任务的转办人权限 3待办任务的委托人权限）',
  `processed_by` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限人',
  `associated` bigint NOT NULL COMMENT '任务表id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_processed_type`(`processed_by` ASC, `type` ASC) USING BTREE,
  INDEX `user_associated`(`associated` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '流程用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of flow_user
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL COMMENT '编号',
  `data_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (2020041027045306369, 'master', 'biz_customer', '客户及供应商表', NULL, NULL, 'BizCustomer', 'crud', 'org.dromara.system', 'erp', 'customer', '客户及供应商', 'Lion Li', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":1}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14', NULL);
INSERT INTO `gen_table` VALUES (2020041027376656386, 'master', 'biz_inventory', '库存管理表', NULL, NULL, 'BizInventory', 'crud', 'org.dromara.system', 'erp', 'inventory', '库存管理', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45', NULL);
INSERT INTO `gen_table` VALUES (2020041027510874128, 'master', 'biz_purchase', '采购管理表', NULL, NULL, 'BizPurchase', 'crud', 'org.dromara.system', 'erp', 'purchase', '采购管理', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08', NULL);
INSERT INTO `gen_table` VALUES (2020041027645091861, 'master', 'biz_wo_ctp', '工单CTP子表', NULL, NULL, 'BizWoCtp', 'crud', 'org.dromara.system', 'erp', 'woCtp', '工单CTP子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36', NULL);
INSERT INTO `gen_table` VALUES (2020041027775115268, 'master', 'biz_wo_material', '工单材料子表', NULL, NULL, 'BizWoMaterial', 'crud', 'org.dromara.system', 'erp', 'woMaterial', '工单材料子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36', NULL);
INSERT INTO `gen_table` VALUES (2020041027842224140, 'master', 'biz_wo_print', '工单印刷子表', NULL, NULL, 'BizWoPrint', 'crud', 'org.dromara.system', 'erp', 'woPrint', '工单印刷子', 'Lion Li', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55', NULL);
INSERT INTO `gen_table` VALUES (2020041027976441868, 'master', 'biz_work_order', '生产工单主表', '', '', 'BizWorkOrder', 'crud', 'org.dromara.system', 'erp', 'workOrder', '工单管理', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":1}', 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 09:38:59', NULL);
INSERT INTO `gen_table` VALUES (2021599719733682177, 'master', 'biz_production_order', '生产工单表', NULL, NULL, 'BizProductionOrder', 'crud', 'org.dromara.system', 'erp', 'productionOrder', '生产工单', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43', NULL);
INSERT INTO `gen_table` VALUES (2021785901457301506, 'master', 'biz_wo_extra_purchase', '工单其他订购子表', NULL, NULL, 'BizWoExtraPurchase', 'crud', 'org.dromara.system', 'erp', 'woExtraPurchase', '工单其他订购子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41', NULL);
INSERT INTO `gen_table` VALUES (2021785901587324937, 'master', 'biz_wo_post_process', '工单后续加工子表', NULL, NULL, 'BizWoPostProcess', 'crud', 'org.dromara.system', 'system', 'woPostProcess', '工单后续加工子', 'Lion Li', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07', NULL);
INSERT INTO `gen_table` VALUES (2022326060489482242, 'master', 'biz_wo_outsourcing', '工单委外加工子表', NULL, NULL, 'BizWoOutsourcing', 'crud', 'org.dromara.system', 'erp', 'woOutsourcing', '工单委外加工子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-13 23:04:40', 1, '2026-02-14 11:44:17', NULL);
INSERT INTO `gen_table` VALUES (2022326060690808850, 'master', 'biz_wo_process', '工单生产工艺子表', NULL, NULL, 'BizWoProcess', 'crud', 'org.dromara.system', 'erp', 'woProcess', '工单生产工艺子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51', NULL);
INSERT INTO `gen_table` VALUES (2022326060820832263, 'master', 'biz_wo_product', '工单产品明细子表', NULL, NULL, 'BizWoProduct', 'crud', 'org.dromara.system', 'erp', 'woProduct', '工单产品明细子', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44', NULL);
INSERT INTO `gen_table` VALUES (2028324268856438785, 'master', 'biz_production_schedule', '生产排产主表', NULL, NULL, 'BizProductionSchedule', 'crud', 'org.dromara.system', 'erp', 'productionSchedule', '生产排产主', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48', NULL);
INSERT INTO `gen_table` VALUES (2028324269397504001, 'master', 'biz_schedule_node', '排产工序节点状态表', NULL, NULL, 'BizScheduleNode', 'crud', 'org.dromara.system', 'erp', 'scheduleNode', '排产工序节点状态', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45', NULL);
INSERT INTO `gen_table` VALUES (2028723463295893505, 'master', 'biz_finance_record', '财务收支流水表', NULL, NULL, 'BizFinanceRecord', 'crud', 'org.dromara.system', 'erp', 'financeRecord', '财务收支流水', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53', NULL);
INSERT INTO `gen_table` VALUES (2028723463778238466, 'master', 'biz_temp_worker', '临时工费用登记表', NULL, NULL, 'BizTempWorker', 'crud', 'org.dromara.system', 'erp', 'tempWorker', '临时工费用登记', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42', NULL);
INSERT INTO `gen_table` VALUES (2028739702374342658, 'master', 'biz_outsourcing_receipt', '委外收货与结算表', NULL, NULL, 'BizOutsourcingReceipt', 'crud', 'org.dromara.system', 'erp', 'outsourcingReceipt', '委外收货与结算', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07', NULL);
INSERT INTO `gen_table` VALUES (2028774098603139074, 'master', 'biz_temp_worker_info', '临时工档案台账', NULL, NULL, 'BizTempWorkerInfo', 'crud', 'org.dromara.system', 'erp', 'tempWorkerInfo', '临时工档案台账', 'JXTttt', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (2020041027242438658, 2020041027045306369, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', '1', 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741825, 2020041027045306369, 'company_name', '客户公司全称', 'varchar(255)', 'String', 'companyName', '0', '0', '1', '0', '1', '1', '1', 'LIKE', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741826, 2020041027045306369, 'customer_code', '客户编码(唯一标识)', 'varchar(50)', 'String', 'customerCode', '0', '0', '1', '0', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741827, 2020041027045306369, 'short_name', '客户简称/个人全名', 'varchar(100)', 'String', 'shortName', '0', '0', '0', '0', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741828, 2020041027045306369, 'contact_person', '首要联系人名称', 'varchar(50)', 'String', 'contactPerson', '0', '0', '0', '0', '1', '1', '1', 'LIKE', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741829, 2020041027045306369, 'contact_phone', '联系人手机号', 'varchar(20)', 'String', 'contactPhone', '0', '0', '0', '0', '1', '1', '1', 'LIKE', 'input', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741830, 2020041027045306369, 'customer_type', '类型：1-普通客户, 2-供应商', 'char(1)', 'String', 'customerType', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'select', 'erp_customer_type', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741831, 2020041027045306369, 'company_province', '公司所在省', 'varchar(50)', 'String', 'companyProvince', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741832, 2020041027045306369, 'company_city', '公司所在市', 'varchar(50)', 'String', 'companyCity', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741833, 2020041027045306369, 'company_district', '公司所在区', 'varchar(50)', 'String', 'companyDistrict', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741834, 2020041027045306369, 'company_address', '公司详细地址', 'varchar(255)', 'String', 'companyAddress', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 11, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741835, 2020041027045306369, 'delivery_province', '收货省', 'varchar(50)', 'String', 'deliveryProvince', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 12, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741836, 2020041027045306369, 'delivery_city', '收货市', 'varchar(50)', 'String', 'deliveryCity', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 13, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741837, 2020041027045306369, 'delivery_district', '收货区', 'varchar(50)', 'String', 'deliveryDistrict', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 14, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741838, 2020041027045306369, 'delivery_address', '收货详细地址', 'varchar(255)', 'String', 'deliveryAddress', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 15, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741839, 2020041027045306369, 'delivery_unit', '收货单位名称', 'varchar(255)', 'String', 'deliveryUnit', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 16, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741840, 2020041027045306369, 'bank_account_info', '银行账户信息(例:工行 张三 6212...)', 'varchar(255)', 'String', 'bankAccountInfo', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 17, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741841, 2020041027045306369, 'total_deal_amount', '总交易金额(出货/采购)', 'decimal(15,2)', 'BigDecimal', 'totalDealAmount', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'input', '', 18, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741842, 2020041027045306369, 'total_owe_amount', '当前欠款/待付金额', 'decimal(15,2)', 'BigDecimal', 'totalOweAmount', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'input', '', 19, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741843, 2020041027045306369, 'sales_man_id', '业务归属员ID (关联sys_user)', 'bigint', 'Long', 'salesManId', '0', '0', '0', '1', '0', '1', '1', 'EQ', 'input', '', 20, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741844, 2020041027045306369, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'input', '', 21, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741845, 2020041027045306369, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'datetime', '', 22, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741846, 2020041027045306369, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'input', '', 23, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741847, 2020041027045306369, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'datetime', '', 24, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741848, 2020041027045306369, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 25, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027313741849, 2020041027045306369, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 26, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-07 16:21:14');
INSERT INTO `gen_table_column` VALUES (2020041027510874113, 2020041027376656386, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', '1', 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874114, 2020041027376656386, 'unique_code', '专用码', 'varchar(100)', 'String', 'uniqueCode', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874115, 2020041027376656386, 'item_type', '类型', 'varchar(20)', 'String', 'itemType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'erp_item_type', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874116, 2020041027376656386, 'item_name', '物料名称', 'varchar(255)', 'String', 'itemName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874117, 2020041027376656386, 'spec', '规格', 'varchar(255)', 'String', 'spec', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874118, 2020041027376656386, 'current_qty', '当前库存量', 'decimal(15,2)', 'BigDecimal', 'currentQty', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874119, 2020041027376656386, 'unit', '单位', 'varchar(20)', 'String', 'unit', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', 'erp_item_unit', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874120, 2020041027376656386, 'supplier_id', '供应商ID', 'bigint', 'Long', 'supplierId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874121, 2020041027376656386, 'purchase_price', '采购单价', 'decimal(10,4)', 'BigDecimal', 'purchasePrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874122, 2020041027376656386, 'total_amount', '总金额', 'decimal(15,2)', 'BigDecimal', 'totalAmount', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874123, 2020041027376656386, 'create_by', '', 'varchar(64)', 'String', 'createBy', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'input', '', 11, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874124, 2020041027376656386, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'datetime', '', 12, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874125, 2020041027376656386, 'update_by', '', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'input', '', 13, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874126, 2020041027376656386, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, '1', '1', 'EQ', 'datetime', '', 14, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027510874127, 2020041027376656386, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-08 16:30:45');
INSERT INTO `gen_table_column` VALUES (2020041027645091842, 2020041027510874128, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', '1', '1', '0', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091843, 2020041027510874128, 'purchase_no', '采购单号', 'varchar(50)', 'String', 'purchaseNo', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091844, 2020041027510874128, 'related_wo_no', '关联工单编号', 'varchar(50)', 'String', 'relatedWoNo', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091845, 2020041027510874128, 'supplier_id', '供应商ID', 'bigint', 'Long', 'supplierId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091846, 2020041027510874128, 'item_name', '采购内容/名称', 'varchar(255)', 'String', 'itemName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091847, 2020041027510874128, 'spec', '规格', 'varchar(255)', 'String', 'spec', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091848, 2020041027510874128, 'apply_qty', '采购数量', 'decimal(15,2)', 'BigDecimal', 'applyQty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091849, 2020041027510874128, 'received_qty', '验收数量', 'decimal(15,2)', 'BigDecimal', 'receivedQty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091850, 2020041027510874128, 'price', '采购单价', 'decimal(10,4)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091851, 2020041027510874128, 'total_price', '采购总价', 'decimal(15,2)', 'BigDecimal', 'totalPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091852, 2020041027510874128, 'status', '状态: 0-待审, 1-已批, 2-已验收, 3-驳回', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091853, 2020041027510874128, 'applicant_id', '申请人ID', 'bigint', 'Long', 'applicantId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091854, 2020041027510874128, 'verify_time', '验收时间', 'datetime', 'Date', 'verifyTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 13, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091855, 2020041027510874128, 'delivery_date', '期望交货期', 'date', 'Date', 'deliveryDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091856, 2020041027510874128, 'create_by', '', 'varchar(64)', 'String', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091857, 2020041027510874128, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091858, 2020041027510874128, 'update_by', '', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 17, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091859, 2020041027510874128, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027645091860, 2020041027510874128, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 19, 103, 1, '2026-02-07 15:44:46', 1, '2026-03-02 15:19:08');
INSERT INTO `gen_table_column` VALUES (2020041027708006402, 2020041027645091861, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027708006403, 2020041027645091861, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027708006404, 2020041027645091861, 'part_name', '部件', 'varchar(50)', 'String', 'partName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027708006405, 2020041027645091861, 'source_type', '来源(本厂CTP等)', 'varchar(50)', 'String', 'sourceType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027708006406, 2020041027645091861, 'open_num', '开数(1-9)', 'int', 'Long', 'openNum', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027708006407, 2020041027645091861, 'print_type', '印刷方式(自反, 天地反等)', 'varchar(50)', 'String', 'printType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027775115265, 2020041027645091861, 'set_num', '套数', 'int', 'Long', 'setNum', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027775115266, 2020041027645091861, 'plate_count', 'CTP版张数', 'int', 'Long', 'plateCount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027775115267, 2020041027645091861, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:21:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224130, 2020041027775115268, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224131, 2020041027775115268, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224132, 2020041027775115268, 'part_name', '部件', 'varchar(50)', 'String', 'partName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224133, 2020041027775115268, 'source_type', '来源', 'varchar(20)', 'String', 'sourceType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224134, 2020041027775115268, 'paper_name', '纸张名称', 'varchar(255)', 'String', 'paperName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224135, 2020041027775115268, 'require_qty', '需求张数', 'int', 'Long', 'requireQty', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224136, 2020041027775115268, 'paper_size', '纸张尺寸', 'varchar(100)', 'String', 'paperSize', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224137, 2020041027775115268, 'cut_method', '切成(如:正度对开)', 'varchar(50)', 'String', 'cutMethod', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224138, 2020041027775115268, 'cut_size', '切纸尺寸', 'varchar(100)', 'String', 'cutSize', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027842224139, 2020041027775115268, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:14:36');
INSERT INTO `gen_table_column` VALUES (2020041027976441858, 2020041027842224140, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', '0', 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441859, 2020041027842224140, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441860, 2020041027842224140, 'machine_no', '印刷机号', 'varchar(50)', 'String', 'machineNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441861, 2020041027842224140, 'print_color', '印刷颜色(4C, 1C等)', 'varchar(100)', 'String', 'printColor', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441862, 2020041027842224140, 'print_size', '印刷尺寸', 'varchar(100)', 'String', 'printSize', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441863, 2020041027842224140, 'print_method', '印刷方式', 'varchar(50)', 'String', 'printMethod', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441864, 2020041027842224140, 'mold_num', '模数(3+1等)', 'varchar(50)', 'String', 'moldNum', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441865, 2020041027842224140, 'actual_print_qty', '印刷实数', 'int', 'Long', 'actualPrintQty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441866, 2020041027842224140, 'loss_qty', '损耗数', 'int', 'Long', 'lossQty', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041027976441867, 2020041027842224140, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 10:17:55');
INSERT INTO `gen_table_column` VALUES (2020041028106465281, 2020041027976441868, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465282, 2020041027976441868, 'work_order_no', '工单编号(例:2602030037)', 'varchar(50)', 'String', 'workOrderNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465283, 2020041027976441868, 'customer_id', '客户ID', 'bigint', 'Long', 'customerId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465284, 2020041027976441868, 'customer_name', '客户名称快照', 'varchar(255)', 'String', 'customerName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465293, 2020041027976441868, 'total_amount', '总金额', 'decimal(15,2)', 'Long', 'totalAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465298, 2020041027976441868, 'order_date', '开单日期', 'date', 'Date', 'orderDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465299, 2020041027976441868, 'delivery_date', '交货日期', 'date', 'Date', 'deliveryDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465300, 2020041027976441868, 'sales_man_id', '业务员ID', 'bigint', 'Long', 'salesManId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465301, 2020041027976441868, 'operator_id', '开单人ID', 'bigint', 'Long', 'operatorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465302, 2020041027976441868, 'production_status', '生产进度: 完成,未完成,已排产,异常', 'varchar(20)', 'String', 'productionStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', 'wf_task_status', 10, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465303, 2020041027976441868, 'audit_status', '审核状态: 0-待审, 1-通过, 2-驳回', 'char(1)', 'String', 'auditStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465304, 2020041027976441868, 'audit_by', '审核人签名', 'varchar(64)', 'String', 'auditBy', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028106465305, 2020041027976441868, 'pack_requirement', '包装要求', 'text', 'String', 'packRequirement', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574145, 2020041027976441868, 'remark', '备注', 'text', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574146, 2020041027976441868, 'create_by', '', 'varchar(64)', 'String', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', NULL, 15, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574147, 2020041027976441868, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', NULL, 16, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574148, 2020041027976441868, 'update_by', '', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', NULL, 17, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574149, 2020041027976441868, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', NULL, 18, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2020041028173574150, 2020041027976441868, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', NULL, 19, 103, 1, '2026-02-07 15:44:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2021599720253775873, 2021599719733682177, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '0', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720253775874, 2021599719733682177, 'order_no', '工单编号', 'varchar(50)', 'String', 'orderNo', '0', '0', '1', '0', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720253775875, 2021599719733682177, 'product_name', '产品名称', 'varchar(100)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720253775876, 2021599719733682177, 'spec', '规格型号', 'varchar(100)', 'String', 'spec', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720253775877, 2021599719733682177, 'planned_qty', '计划生产数量', 'decimal(15,2)', 'Long', 'plannedQty', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690434, 2021599719733682177, 'completed_qty', '已完成数量', 'decimal(15,2)', 'Long', 'completedQty', '0', '0', '0', '0', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690435, 2021599719733682177, 'status', '状态(0待生产 1生产中 2已完成 3已取消)', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690436, 2021599719733682177, 'start_date', '计划开始日期', 'date', 'Date', 'startDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690437, 2021599719733682177, 'end_date', '计划结束日期', 'date', 'Date', 'endDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690438, 2021599719733682177, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690439, 2021599719733682177, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690440, 2021599719733682177, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690441, 2021599719733682177, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, '1', NULL, 'EQ', 'datetime', '', 13, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690442, 2021599719733682177, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690443, 2021599719733682177, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 15, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021599720316690444, 2021599719733682177, 'del_flag', '删除标志', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 16, 103, 1, '2026-02-11 22:58:27', 1, '2026-02-11 23:01:43');
INSERT INTO `gen_table_column` VALUES (2021785901587324929, 2021785901457301506, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324930, 2021785901457301506, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324931, 2021785901457301506, 'item_content', '采购内容', 'varchar(255)', 'String', 'itemContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 3, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324932, 2021785901457301506, 'spec', '规格', 'varchar(100)', 'String', 'spec', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324933, 2021785901457301506, 'quantity', '数量', 'decimal(15,2)', 'Long', 'quantity', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324934, 2021785901457301506, 'unit_price', '单价', 'decimal(10,4)', 'Long', 'unitPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324935, 2021785901457301506, 'total_price', '总价', 'decimal(15,2)', 'Long', 'totalPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901587324936, 2021785901457301506, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 8, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:29:41');
INSERT INTO `gen_table_column` VALUES (2021785901717348354, 2021785901587324937, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2021785901717348355, 2021785901587324937, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2021785901717348356, 2021785901587324937, 'supplier_id', '供应商ID', 'bigint', 'Long', 'supplierId', '0', '0', '0', '1', '0', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2021785901717348357, 2021785901587324937, 'finish_size', '成品尺寸', 'varchar(100)', 'String', 'finishSize', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2021785901717348358, 2021785901587324937, 'process_content', '形目内容(多选)', 'varchar(500)', 'String', 'processContent', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 5, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2021785901717348359, 2021785901587324937, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 6, 103, 1, '2026-02-12 11:18:17', 1, '2026-02-13 10:30:07');
INSERT INTO `gen_table_column` VALUES (2022325832327733249, 2020041027976441868, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', NULL, 20, 103, 1, '2026-02-13 23:03:46', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2022326060623699970, 2022326060489482242, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808833, 2022326060489482242, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808834, 2022326060489482242, 'product_name', '关联产品名称', 'varchar(255)', 'String', 'productName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808835, 2022326060489482242, 'supplier_id', '加工商/供应商ID', 'bigint', 'Long', 'supplierId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808836, 2022326060489482242, 'process_project', '加工项目', 'varchar(100)', 'String', 'processProject', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808837, 2022326060489482242, 'finish_size', '成品尺寸', 'varchar(100)', 'String', 'finishSize', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808838, 2022326060489482242, 'process_qty', '加工数量', 'int', 'Long', 'processQty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808839, 2022326060489482242, 'unit', '计算单位', 'varchar(20)', 'String', 'unit', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808840, 2022326060489482242, 'unit_price', '加工单价', 'decimal(10,4)', 'Long', 'unitPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808841, 2022326060489482242, 'total_price', '加工总价', 'decimal(15,2)', 'Long', 'totalPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808842, 2022326060489482242, 'extra_fee', '附加费用', 'decimal(15,2)', 'Long', 'extraFee', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808843, 2022326060489482242, 'delivery_date', '交货期', 'date', 'Date', 'deliveryDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808844, 2022326060489482242, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 13, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808845, 2022326060489482242, 'create_dept', '', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808846, 2022326060489482242, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808847, 2022326060489482242, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808848, 2022326060489482242, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 17, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060690808849, 2022326060489482242, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:44:17');
INSERT INTO `gen_table_column` VALUES (2022326060757917697, 2022326060690808850, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060757917698, 2022326060690808850, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060757917699, 2022326060690808850, 'process_name', '工序名称(如:表面处理,裱坑,粘盒)', 'varchar(50)', 'String', 'processName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060757917700, 2022326060690808850, 'process_content', '工艺内容', 'varchar(255)', 'String', 'processContent', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'checkbox', 'erp_process_name', 4, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060757917701, 2022326060690808850, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060820832258, 2022326060690808850, 'create_dept', '', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060820832259, 2022326060690808850, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060820832260, 2022326060690808850, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060820832261, 2022326060690808850, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060820832262, 2022326060690808850, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:50:51');
INSERT INTO `gen_table_column` VALUES (2022326060883746818, 2022326060820832263, 'id', '', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746819, 2022326060820832263, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746820, 2022326060820832263, 'product_name', '产品名称', 'varchar(255)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746821, 2022326060820832263, 'customer_po', '客户PO号', 'varchar(100)', 'String', 'customerPo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746822, 2022326060820832263, 'customer_material_no', '客户物料号', 'varchar(100)', 'String', 'customerMaterialNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746823, 2022326060820832263, 'spec', '规格', 'varchar(255)', 'String', 'spec', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746824, 2022326060820832263, 'layers', '层数(单E,BB等)', 'varchar(50)', 'String', 'layers', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746825, 2022326060820832263, 'knife_plate_no', '刀版号', 'varchar(100)', 'String', 'knifePlateNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746826, 2022326060820832263, 'order_quantity', '订单数量', 'int', 'Long', 'orderQuantity', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746827, 2022326060820832263, 'produce_quantity', '生产数量', 'int', 'Long', 'produceQuantity', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746828, 2022326060820832263, 'unit', '单位', 'varchar(20)', 'String', 'unit', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746829, 2022326060820832263, 'unit_price', '单价', 'decimal(10,4)', 'Long', 'unitPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746830, 2022326060820832263, 'total_amount', '总金额', 'decimal(15,2)', 'Long', 'totalAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746831, 2022326060820832263, 'create_dept', '', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746832, 2022326060820832263, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746833, 2022326060820832263, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746834, 2022326060820832263, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 17, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022326060883746835, 2022326060820832263, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 103, 1, '2026-02-13 23:04:41', 1, '2026-02-14 11:45:44');
INSERT INTO `gen_table_column` VALUES (2022331234285101058, 2020041027976441868, 'process_options', '选中的工艺选项(逗号分隔)', 'varchar(500)', 'String', 'processOptions', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 21, 103, 1, '2026-02-13 23:25:14', 1, '2026-02-13 23:25:14');
INSERT INTO `gen_table_column` VALUES (2028324269217148929, 2028324268856438785, 'id', '排产主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269225537538, 2028324268856438785, 'work_order_id', '关联工单ID', 'bigint', 'Long', 'workOrderId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269229731842, 2028324268856438785, 'work_order_no', '工单编号', 'varchar(50)', 'String', 'workOrderNo', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269238120449, 2028324268856438785, 'item_name', '生产部件/产品名称', 'varchar(255)', 'String', 'itemName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269238120450, 2028324268856438785, 'quantity', '生产数量', 'int', 'Long', 'quantity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269254897665, 2028324268856438785, 'delivery_date', '交货日期', 'date', 'Date', 'deliveryDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269263286273, 2028324268856438785, 'remark', '跟单备注(最右侧列)', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 7, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269263286274, 2028324268856438785, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269267480577, 2028324268856438785, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269267480578, 2028324268856438785, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269267480579, 2028324268856438785, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269267480580, 2028324268856438785, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269267480581, 2028324268856438785, 'del_flag', '删除标志', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:20:48');
INSERT INTO `gen_table_column` VALUES (2028324269519138817, 2028324269397504001, 'id', '节点主键ID', 'bigint', 'Long', 'id', '1', '1', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269527527425, 2028324269397504001, 'schedule_id', '关联排产主表ID', 'bigint', 'Long', 'scheduleId', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269527527426, 2028324269397504001, 'node_code', '工序编码(如:print, gluing等)', 'varchar(50)', 'String', 'nodeCode', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269531721729, 2028324269397504001, 'node_name', '工序名称(供参考)', 'varchar(50)', 'String', 'nodeName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269531721730, 2028324269397504001, 'status_color', '状态颜色(red, yellow, green, white)', 'varchar(20)', 'String', 'statusColor', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269531721731, 2028324269397504001, 'content', '格子填写的具体内容(日期/文字)', 'varchar(500)', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269531721732, 2028324269397504001, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028324269531721733, 2028324269397504001, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 103, 1, '2026-03-02 12:19:25', 1, '2026-03-02 12:55:45');
INSERT INTO `gen_table_column` VALUES (2028723463602077698, 2028723463295893505, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463614660609, 2028723463295893505, 'record_no', '财务流水号(如 FIN2026...)', 'varchar(50)', 'String', 'recordNo', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463618854914, 2028723463295893505, 'record_type', '资金流向: 1-应收/收入, 2-应付/支出', 'char(1)', 'String', 'recordType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463618854915, 2028723463295893505, 'business_type', '业务类型: 销售出货, 采购入库, 委外加工, 临时工费', 'varchar(20)', 'String', 'businessType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463627243521, 2028723463295893505, 'related_no', '关联单号(出货单号/采购单号/工单号)', 'varchar(50)', 'String', 'relatedNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463631437826, 2028723463295893505, 'target_name', '收付款对象(客户名/供应商名/临时工姓名)', 'varchar(100)', 'String', 'targetName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463631437827, 2028723463295893505, 'amount', '发生金额', 'decimal(15,2)', 'BigDecimal', 'amount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463639826434, 2028723463295893505, 'settlement_status', '结算状态: 0-未结清(挂账), 1-部分结清, 2-已结清', 'char(1)', 'String', 'settlementStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463639826435, 2028723463295893505, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 9, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463648215042, 2028723463295893505, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463648215043, 2028723463295893505, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463652409346, 2028723463295893505, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463652409347, 2028723463295893505, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463656603650, 2028723463295893505, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463656603651, 2028723463295893505, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 15, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:50:53');
INSERT INTO `gen_table_column` VALUES (2028723463916650497, 2028723463778238466, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463925039105, 2028723463778238466, 'worker_name', '临时工姓名', 'varchar(50)', 'String', 'workerName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463929233410, 2028723463778238466, 'work_date', '工作日期', 'date', 'Date', 'workDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463929233411, 2028723463778238466, 'related_wo_no', '关联工单号(可为空)', 'varchar(50)', 'String', 'relatedWoNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463937622018, 2028723463778238466, 'work_type', '计费方式: 1-计时, 2-计件', 'char(1)', 'String', 'workType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463937622019, 2028723463778238466, 'work_qty', '数量/时长', 'decimal(10,2)', 'BigDecimal', 'workQty', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463937622020, 2028723463778238466, 'unit_price', '单价', 'decimal(10,2)', 'BigDecimal', 'unitPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463937622021, 2028723463778238466, 'total_amount', '总薪资', 'decimal(10,2)', 'BigDecimal', 'totalAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463941816321, 2028723463778238466, 'pay_status', '支付状态: 0-未付, 1-已付', 'char(1)', 'String', 'payStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463941816322, 2028723463778238466, 'remark', '工作内容描述', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463941816323, 2028723463778238466, 'del_flag', '删除标志', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463946010626, 2028723463778238466, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463946010627, 2028723463778238466, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463946010628, 2028723463778238466, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463946010629, 2028723463778238466, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028723463946010630, 2028723463778238466, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 103, 1, '2026-03-03 14:45:40', 1, '2026-03-03 14:51:42');
INSERT INTO `gen_table_column` VALUES (2028739702646972417, 2028739702374342658, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '0', '1', NULL, '0', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702651166722, 2028739702374342658, 'receipt_no', '收货单号(如 OSR2026...)', 'varchar(50)', 'String', 'receiptNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702659555330, 2028739702374342658, 'work_order_no', '关联工单号', 'varchar(50)', 'String', 'workOrderNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702667943938, 2028739702374342658, 'product_name', '产品/材料名称', 'varchar(100)', 'String', 'productName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702672138242, 2028739702374342658, 'process_project', '加工工序', 'varchar(100)', 'String', 'processProject', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702680526850, 2028739702374342658, 'supplier_id', '加工商ID', 'bigint', 'Long', 'supplierId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702684721153, 2028739702374342658, 'sent_qty', '发出数量', 'decimal(10,2)', 'BigDecimal', 'sentQty', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702684721154, 2028739702374342658, 'received_qty', '实际验收数量', 'decimal(10,2)', 'BigDecimal', 'receivedQty', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702684721155, 2028739702374342658, 'price_method', '算价方式(张/平方米/套)', 'varchar(20)', 'String', 'priceMethod', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702693109762, 2028739702374342658, 'unit_price', '结算单价', 'decimal(10,4)', 'BigDecimal', 'unitPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702693109763, 2028739702374342658, 'total_fee', '结算加工费', 'decimal(15,2)', 'BigDecimal', 'totalFee', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702693109764, 2028739702374342658, 'receipt_date', '收货日期', 'datetime', 'Date', 'receiptDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702693109765, 2028739702374342658, 'status', '状态: 0-待入库, 1-已验收结算', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 13, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702701498369, 2028739702374342658, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702701498370, 2028739702374342658, 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702705692674, 2028739702374342658, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 16, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702705692675, 2028739702374342658, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 17, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702705692676, 2028739702374342658, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702714081282, 2028739702374342658, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 19, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028739702714081283, 2028739702374342658, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 20, 103, 1, '2026-03-03 15:50:12', 1, '2026-03-03 15:54:07');
INSERT INTO `gen_table_column` VALUES (2028774098871574529, 2028774098603139074, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '0', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098879963137, 2028774098603139074, 'worker_name', '临时工姓名', 'varchar(50)', 'String', 'workerName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098884157442, 2028774098603139074, 'phone', '联系电话', 'varchar(20)', 'String', 'phone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098892546049, 2028774098603139074, 'id_card', '身份证号', 'varchar(20)', 'String', 'idCard', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098896740353, 2028774098603139074, 'skills', '特长/工种', 'varchar(100)', 'String', 'skills', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098905128962, 2028774098603139074, 'default_price', '默认工价(元)', 'decimal(10,2)', 'BigDecimal', 'defaultPrice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098905128963, 2028774098603139074, 'status', '状态: 0-在职, 1-离职', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098905128964, 2028774098603139074, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 8, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098913517570, 2028774098603139074, 'del_flag', '删除标志', 'char(1)', 'String', 'delFlag', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098913517571, 2028774098603139074, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098913517572, 2028774098603139074, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098917711874, 2028774098603139074, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098917711875, 2028774098603139074, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');
INSERT INTO `gen_table_column` VALUES (2028774098917711876, 2028774098603139074, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 103, 1, '2026-03-03 18:06:53', 1, '2026-03-03 18:07:56');

-- ----------------------------
-- Table structure for sj_distributed_lock
-- ----------------------------
DROP TABLE IF EXISTS `sj_distributed_lock`;
CREATE TABLE `sj_distributed_lock`  (
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁名称',
  `lock_until` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '锁定时长',
  `locked_at` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '锁定时间',
  `locked_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁定者',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '锁定表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_distributed_lock
-- ----------------------------

-- ----------------------------
-- Table structure for sj_group_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_group_config`;
CREATE TABLE `sj_group_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '组名称',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '组描述',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT' COMMENT 'token',
  `group_status` tinyint NOT NULL DEFAULT 0 COMMENT '组状态 0、未启用 1、启用',
  `version` int NOT NULL COMMENT '版本号',
  `group_partition` int NOT NULL COMMENT '分区',
  `id_generator_mode` tinyint NOT NULL DEFAULT 1 COMMENT '唯一id生成模式 默认号段模式',
  `init_scene` tinyint NOT NULL DEFAULT 0 COMMENT '是否初始化场景 0:否 1:是',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '组配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_group_config
-- ----------------------------
INSERT INTO `sj_group_config` VALUES (1, 'dev', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1, '2026-02-04 09:56:51', '2026-02-04 09:56:51');
INSERT INTO `sj_group_config` VALUES (2, 'prod', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1, '2026-02-04 09:56:51', '2026-02-04 09:56:51');

-- ----------------------------
-- Table structure for sj_job
-- ----------------------------
DROP TABLE IF EXISTS `sj_job`;
CREATE TABLE `sj_job`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `args_str` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT 1 COMMENT '参数类型 ',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `job_status` tinyint NOT NULL DEFAULT 1 COMMENT '任务状态 0、关闭、1、开启',
  `task_type` tinyint NOT NULL DEFAULT 1 COMMENT '任务类型 1、集群 2、广播 3、切片',
  `route_key` tinyint NOT NULL DEFAULT 4 COMMENT '路由策略',
  `executor_type` tinyint NOT NULL DEFAULT 1 COMMENT '执行器类型',
  `executor_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器名称',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '间隔时长',
  `block_strategy` tinyint NOT NULL DEFAULT 1 COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行 4、恢复',
  `executor_timeout` int NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `max_retry_times` int NOT NULL DEFAULT 0 COMMENT '最大重试次数',
  `parallel_num` int NOT NULL DEFAULT 1 COMMENT '并行数',
  `retry_interval` int NOT NULL DEFAULT 0 COMMENT '重试间隔(s)',
  `bucket_index` int NOT NULL DEFAULT 0 COMMENT 'bucket',
  `resident` tinyint NOT NULL DEFAULT 0 COMMENT '是否是常驻任务',
  `notify_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '负责人id',
  `labels` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE,
  INDEX `idx_job_status_bucket_index`(`job_status` ASC, `bucket_index` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job
-- ----------------------------
INSERT INTO `sj_job` VALUES (1, 'dev', 'ruoyi_group', 'demo-job', NULL, 1, 1772892896504, 1, 1, 4, 1, 'testJobExecutor', 2, '60', 1, 60, 3, 1, 1, 116, 0, '', 1, '', '', '', 0, '2026-02-04 09:56:51', '2026-03-07 22:13:56');

-- ----------------------------
-- Table structure for sj_job_executor
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_executor`;
CREATE TABLE `sj_job_executor`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `executor_info` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务执行器名称',
  `executor_type` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '1:java 2:python 3:go',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务执行器信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job_executor
-- ----------------------------
INSERT INTO `sj_job_executor` VALUES (1, 'dev', 'ruoyi_group', 'alipayBillTask', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (2, 'dev', 'ruoyi_group', 'summaryBillTask', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (3, 'dev', 'ruoyi_group', 'testJobExecutor', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (4, 'dev', 'ruoyi_group', 'testBroadcastJob', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (5, 'dev', 'ruoyi_group', 'org.dromara.job.snailjob.TestClassJobExecutor', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (6, 'dev', 'ruoyi_group', 'testMapJobAnnotation', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (7, 'dev', 'ruoyi_group', 'testMapReduceAnnotation1', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (8, 'dev', 'ruoyi_group', 'testStaticShardingJob', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');
INSERT INTO `sj_job_executor` VALUES (9, 'dev', 'ruoyi_group', 'wechatBillTask', '1', '2026-02-06 23:11:30', '2026-02-06 23:11:30');

-- ----------------------------
-- Table structure for sj_job_log_message
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_log_message`;
CREATE TABLE `sj_job_log_message`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '任务批次id',
  `task_id` bigint NOT NULL COMMENT '调度任务id',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度信息',
  `log_num` int NOT NULL DEFAULT 1 COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT 0 COMMENT '上报时间',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_batch_id_task_id`(`task_batch_id` ASC, `task_id` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13251 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job_log_message
-- ----------------------------

-- ----------------------------
-- Table structure for sj_job_summary
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_summary`;
CREATE TABLE `sj_job_summary`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '组名称',
  `business_id` bigint NOT NULL COMMENT '业务id (job_id或workflow_id)',
  `system_task_type` tinyint NOT NULL DEFAULT 3 COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `success_num` int NOT NULL DEFAULT 0 COMMENT '执行成功-日志数量',
  `fail_num` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `fail_reason` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '失败原因',
  `stop_num` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `stop_reason` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '失败原因',
  `cancel_num` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `cancel_reason` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '失败原因',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_trigger_at_system_task_type_business_id`(`trigger_at` ASC, `system_task_type` ASC, `business_id` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name_business_id`(`namespace_id` ASC, `group_name` ASC, `business_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'DashBoard_Job' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job_summary
-- ----------------------------
INSERT INTO `sj_job_summary` VALUES (1, 'dev', 'ruoyi_group', 1, 3, '2026-02-06 00:00:00', 126, 3, '[{\"reason\":0,\"total\":3}]', 0, '[]', 2, '[{\"reason\":2,\"total\":2}]', '2026-02-06 19:26:05', '2026-02-07 10:51:31');
INSERT INTO `sj_job_summary` VALUES (2, 'dev', 'ruoyi_group', 1, 3, '2026-02-07 00:00:00', 713, 3, '[{\"reason\":0,\"total\":3}]', 0, '[]', 15, '[{\"reason\":2,\"total\":15}]', '2026-02-07 10:52:31', '2026-02-08 10:20:57');
INSERT INTO `sj_job_summary` VALUES (3, 'dev', 'ruoyi_group', 1, 3, '2026-02-08 00:00:00', 778, 1, '[{\"reason\":0,\"total\":1}]', 0, '[]', 40, '[{\"reason\":2,\"total\":40}]', '2026-02-08 10:21:57', '2026-02-08 23:59:48');
INSERT INTO `sj_job_summary` VALUES (4, 'dev', 'ruoyi_group', 1, 3, '2026-02-09 00:00:00', 1304, 132, '[{\"reason\":0,\"total\":132}]', 0, '[]', 0, '[]', '2026-02-09 00:00:48', '2026-02-10 00:00:26');
INSERT INTO `sj_job_summary` VALUES (5, 'dev', 'ruoyi_group', 1, 3, '2026-02-10 00:00:00', 0, 1289, '[{\"reason\":0,\"total\":1289}]', 0, '[]', 0, '[]', '2026-02-10 00:01:26', '2026-02-10 21:29:29');
INSERT INTO `sj_job_summary` VALUES (6, 'dev', 'ruoyi_group', 1, 3, '2026-02-11 00:00:00', 83, 0, '[]', 0, '[]', 0, '[]', '2026-02-11 22:38:13', '2026-02-12 00:00:13');
INSERT INTO `sj_job_summary` VALUES (7, 'dev', 'ruoyi_group', 1, 3, '2026-02-12 00:00:00', 1440, 0, '[]', 0, '[]', 0, '[]', '2026-02-12 00:01:13', '2026-02-13 00:00:13');
INSERT INTO `sj_job_summary` VALUES (8, 'dev', 'ruoyi_group', 1, 3, '2026-02-13 00:00:00', 1376, 2, '[{\"reason\":0,\"total\":2}]', 0, '[]', 20, '[{\"reason\":2,\"total\":20}]', '2026-02-13 00:01:13', '2026-02-14 11:57:56');
INSERT INTO `sj_job_summary` VALUES (9, 'dev', 'ruoyi_group', 1, 3, '2026-02-14 00:00:00', 275, 1, '[{\"reason\":0,\"total\":1}]', 0, '[]', 0, '[]', '2026-02-14 11:58:56', '2026-02-14 16:33:56');
INSERT INTO `sj_job_summary` VALUES (10, 'dev', 'ruoyi_group', 1, 3, '2026-02-23 00:00:00', 0, 0, '[]', 0, '[]', 331, '[{\"reason\":2,\"total\":331}]', '2026-02-23 16:42:49', '2026-02-23 22:12:49');
INSERT INTO `sj_job_summary` VALUES (11, 'dev', 'ruoyi_group', 1, 3, '2026-03-03 00:00:00', 0, 0, '[]', 0, '[]', 271, '[{\"reason\":2,\"total\":271}]', '2026-03-03 14:44:41', '2026-03-03 19:15:11');
INSERT INTO `sj_job_summary` VALUES (12, 'dev', 'ruoyi_group', 1, 3, '2026-03-04 00:00:00', 0, 0, '[]', 0, '[]', 716, '[{\"reason\":2,\"total\":716}]', '2026-03-04 10:16:21', '2026-03-05 12:39:58');
INSERT INTO `sj_job_summary` VALUES (13, 'dev', 'ruoyi_group', 1, 3, '2026-03-05 00:00:00', 0, 0, '[]', 0, '[]', 579, '[{\"reason\":2,\"total\":579}]', '2026-03-05 12:40:57', '2026-03-06 14:51:00');
INSERT INTO `sj_job_summary` VALUES (14, 'dev', 'ruoyi_group', 1, 3, '2026-03-06 00:00:00', 0, 0, '[]', 0, '[]', 183, '[{\"reason\":2,\"total\":183}]', '2026-03-06 14:51:59', '2026-03-06 18:27:36');
INSERT INTO `sj_job_summary` VALUES (15, 'dev', 'ruoyi_group', 1, 3, '2026-03-07 00:00:00', 0, 0, '[]', 0, '[]', 389, '[{\"reason\":2,\"total\":389}]', '2026-03-07 15:46:26', '2026-03-07 22:14:26');

-- ----------------------------
-- Table structure for sj_job_task
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_task`;
CREATE TABLE `sj_job_task`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '调度任务id',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父执行器id',
  `task_status` tinyint NOT NULL DEFAULT 0 COMMENT '执行的状态 0、失败 1、成功',
  `retry_count` int NOT NULL DEFAULT 0 COMMENT '重试次数',
  `mr_stage` tinyint NULL DEFAULT NULL COMMENT '动态分片所处阶段 1:map 2:reduce 3:mergeReduce',
  `leaf` tinyint NOT NULL DEFAULT 1 COMMENT '叶子节点',
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `client_info` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `wf_context` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '工作流全局上下文',
  `result_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行结果',
  `args_str` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT 1 COMMENT '参数类型 ',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_batch_id_task_status`(`task_batch_id` ASC, `task_status` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7527 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务实例' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job_task
-- ----------------------------

-- ----------------------------
-- Table structure for sj_job_task_batch
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_task_batch`;
CREATE TABLE `sj_job_task_batch`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `workflow_node_id` bigint NOT NULL DEFAULT 0 COMMENT '工作流节点id',
  `parent_workflow_node_id` bigint NOT NULL DEFAULT 0 COMMENT '工作流任务父批次id',
  `workflow_task_batch_id` bigint NOT NULL DEFAULT 0 COMMENT '工作流任务批次id',
  `task_batch_status` tinyint NOT NULL DEFAULT 0 COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT 0 COMMENT '操作原因',
  `execution_at` bigint NOT NULL DEFAULT 0 COMMENT '任务执行时间',
  `system_task_type` tinyint NOT NULL DEFAULT 3 COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `parent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '父节点',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_job_id_task_batch_status`(`job_id` ASC, `task_batch_status` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE,
  INDEX `idx_workflow_task_batch_id_workflow_node_id`(`workflow_task_batch_id` ASC, `workflow_node_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10073 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务批次' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_job_task_batch
-- ----------------------------
INSERT INTO `sj_job_task_batch` VALUES (7935, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:44:12', '2026-03-03 14:44:12');
INSERT INTO `sj_job_task_batch` VALUES (7936, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:45:12', '2026-03-03 14:45:12');
INSERT INTO `sj_job_task_batch` VALUES (7937, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:46:12', '2026-03-03 14:46:12');
INSERT INTO `sj_job_task_batch` VALUES (7938, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:47:12', '2026-03-03 14:47:12');
INSERT INTO `sj_job_task_batch` VALUES (7939, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:48:12', '2026-03-03 14:48:12');
INSERT INTO `sj_job_task_batch` VALUES (7940, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:49:12', '2026-03-03 14:49:12');
INSERT INTO `sj_job_task_batch` VALUES (7941, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:50:12', '2026-03-03 14:50:12');
INSERT INTO `sj_job_task_batch` VALUES (7942, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:51:12', '2026-03-03 14:51:12');
INSERT INTO `sj_job_task_batch` VALUES (7943, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:52:12', '2026-03-03 14:52:12');
INSERT INTO `sj_job_task_batch` VALUES (7944, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:53:12', '2026-03-03 14:53:12');
INSERT INTO `sj_job_task_batch` VALUES (7945, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:54:12', '2026-03-03 14:54:12');
INSERT INTO `sj_job_task_batch` VALUES (7946, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:55:12', '2026-03-03 14:55:12');
INSERT INTO `sj_job_task_batch` VALUES (7947, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:56:12', '2026-03-03 14:56:12');
INSERT INTO `sj_job_task_batch` VALUES (7948, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:57:12', '2026-03-03 14:57:12');
INSERT INTO `sj_job_task_batch` VALUES (7949, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:58:12', '2026-03-03 14:58:12');
INSERT INTO `sj_job_task_batch` VALUES (7950, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 14:59:12', '2026-03-03 14:59:12');
INSERT INTO `sj_job_task_batch` VALUES (7951, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:00:41', '2026-03-03 15:00:41');
INSERT INTO `sj_job_task_batch` VALUES (7952, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:01:41', '2026-03-03 15:01:41');
INSERT INTO `sj_job_task_batch` VALUES (7953, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:02:41', '2026-03-03 15:02:41');
INSERT INTO `sj_job_task_batch` VALUES (7954, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:03:41', '2026-03-03 15:03:41');
INSERT INTO `sj_job_task_batch` VALUES (7955, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:04:41', '2026-03-03 15:04:41');
INSERT INTO `sj_job_task_batch` VALUES (7956, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:05:41', '2026-03-03 15:05:41');
INSERT INTO `sj_job_task_batch` VALUES (7957, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:06:41', '2026-03-03 15:06:41');
INSERT INTO `sj_job_task_batch` VALUES (7958, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:07:41', '2026-03-03 15:07:41');
INSERT INTO `sj_job_task_batch` VALUES (7959, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:08:41', '2026-03-03 15:08:41');
INSERT INTO `sj_job_task_batch` VALUES (7960, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:09:41', '2026-03-03 15:09:41');
INSERT INTO `sj_job_task_batch` VALUES (7961, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:10:41', '2026-03-03 15:10:41');
INSERT INTO `sj_job_task_batch` VALUES (7962, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:11:41', '2026-03-03 15:11:41');
INSERT INTO `sj_job_task_batch` VALUES (7963, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:12:41', '2026-03-03 15:12:41');
INSERT INTO `sj_job_task_batch` VALUES (7964, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:13:41', '2026-03-03 15:13:41');
INSERT INTO `sj_job_task_batch` VALUES (7965, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:14:41', '2026-03-03 15:14:41');
INSERT INTO `sj_job_task_batch` VALUES (7966, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:15:41', '2026-03-03 15:15:41');
INSERT INTO `sj_job_task_batch` VALUES (7967, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:16:41', '2026-03-03 15:16:41');
INSERT INTO `sj_job_task_batch` VALUES (7968, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:17:41', '2026-03-03 15:17:41');
INSERT INTO `sj_job_task_batch` VALUES (7969, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:18:41', '2026-03-03 15:18:41');
INSERT INTO `sj_job_task_batch` VALUES (7970, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:19:41', '2026-03-03 15:19:41');
INSERT INTO `sj_job_task_batch` VALUES (7971, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:20:41', '2026-03-03 15:20:41');
INSERT INTO `sj_job_task_batch` VALUES (7972, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:21:41', '2026-03-03 15:21:41');
INSERT INTO `sj_job_task_batch` VALUES (7973, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:22:41', '2026-03-03 15:22:41');
INSERT INTO `sj_job_task_batch` VALUES (7974, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:23:41', '2026-03-03 15:23:41');
INSERT INTO `sj_job_task_batch` VALUES (7975, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:24:41', '2026-03-03 15:24:41');
INSERT INTO `sj_job_task_batch` VALUES (7976, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:25:41', '2026-03-03 15:25:41');
INSERT INTO `sj_job_task_batch` VALUES (7977, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:26:41', '2026-03-03 15:26:41');
INSERT INTO `sj_job_task_batch` VALUES (7978, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:27:41', '2026-03-03 15:27:41');
INSERT INTO `sj_job_task_batch` VALUES (7979, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:28:41', '2026-03-03 15:28:41');
INSERT INTO `sj_job_task_batch` VALUES (7980, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:29:41', '2026-03-03 15:29:41');
INSERT INTO `sj_job_task_batch` VALUES (7981, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:30:41', '2026-03-03 15:30:41');
INSERT INTO `sj_job_task_batch` VALUES (7982, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:31:41', '2026-03-03 15:31:41');
INSERT INTO `sj_job_task_batch` VALUES (7983, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:32:41', '2026-03-03 15:32:41');
INSERT INTO `sj_job_task_batch` VALUES (7984, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:33:41', '2026-03-03 15:33:41');
INSERT INTO `sj_job_task_batch` VALUES (7985, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:34:41', '2026-03-03 15:34:41');
INSERT INTO `sj_job_task_batch` VALUES (7986, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:35:41', '2026-03-03 15:35:41');
INSERT INTO `sj_job_task_batch` VALUES (7987, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:36:41', '2026-03-03 15:36:41');
INSERT INTO `sj_job_task_batch` VALUES (7988, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:37:41', '2026-03-03 15:37:41');
INSERT INTO `sj_job_task_batch` VALUES (7989, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:38:41', '2026-03-03 15:38:41');
INSERT INTO `sj_job_task_batch` VALUES (7990, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:39:41', '2026-03-03 15:39:41');
INSERT INTO `sj_job_task_batch` VALUES (7991, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:40:41', '2026-03-03 15:40:41');
INSERT INTO `sj_job_task_batch` VALUES (7992, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:41:41', '2026-03-03 15:41:41');
INSERT INTO `sj_job_task_batch` VALUES (7993, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:42:41', '2026-03-03 15:42:41');
INSERT INTO `sj_job_task_batch` VALUES (7994, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:43:41', '2026-03-03 15:43:41');
INSERT INTO `sj_job_task_batch` VALUES (7995, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:44:41', '2026-03-03 15:44:41');
INSERT INTO `sj_job_task_batch` VALUES (7996, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:45:41', '2026-03-03 15:45:41');
INSERT INTO `sj_job_task_batch` VALUES (7997, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:46:41', '2026-03-03 15:46:41');
INSERT INTO `sj_job_task_batch` VALUES (7998, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:47:41', '2026-03-03 15:47:41');
INSERT INTO `sj_job_task_batch` VALUES (7999, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:48:41', '2026-03-03 15:48:41');
INSERT INTO `sj_job_task_batch` VALUES (8000, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:49:41', '2026-03-03 15:49:41');
INSERT INTO `sj_job_task_batch` VALUES (8001, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:50:41', '2026-03-03 15:50:41');
INSERT INTO `sj_job_task_batch` VALUES (8002, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:51:41', '2026-03-03 15:51:41');
INSERT INTO `sj_job_task_batch` VALUES (8003, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:52:41', '2026-03-03 15:52:41');
INSERT INTO `sj_job_task_batch` VALUES (8004, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:53:41', '2026-03-03 15:53:41');
INSERT INTO `sj_job_task_batch` VALUES (8005, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:54:41', '2026-03-03 15:54:41');
INSERT INTO `sj_job_task_batch` VALUES (8006, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:55:41', '2026-03-03 15:55:41');
INSERT INTO `sj_job_task_batch` VALUES (8007, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:56:41', '2026-03-03 15:56:41');
INSERT INTO `sj_job_task_batch` VALUES (8008, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:57:41', '2026-03-03 15:57:41');
INSERT INTO `sj_job_task_batch` VALUES (8009, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:58:41', '2026-03-03 15:58:41');
INSERT INTO `sj_job_task_batch` VALUES (8010, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 15:59:41', '2026-03-03 15:59:41');
INSERT INTO `sj_job_task_batch` VALUES (8011, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:00:41', '2026-03-03 16:00:41');
INSERT INTO `sj_job_task_batch` VALUES (8012, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:01:41', '2026-03-03 16:01:41');
INSERT INTO `sj_job_task_batch` VALUES (8013, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:02:41', '2026-03-03 16:02:41');
INSERT INTO `sj_job_task_batch` VALUES (8014, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:03:41', '2026-03-03 16:03:41');
INSERT INTO `sj_job_task_batch` VALUES (8015, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:04:41', '2026-03-03 16:04:41');
INSERT INTO `sj_job_task_batch` VALUES (8016, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:05:41', '2026-03-03 16:05:41');
INSERT INTO `sj_job_task_batch` VALUES (8017, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:06:41', '2026-03-03 16:06:41');
INSERT INTO `sj_job_task_batch` VALUES (8018, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:07:41', '2026-03-03 16:07:41');
INSERT INTO `sj_job_task_batch` VALUES (8019, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:08:41', '2026-03-03 16:08:41');
INSERT INTO `sj_job_task_batch` VALUES (8020, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:09:41', '2026-03-03 16:09:41');
INSERT INTO `sj_job_task_batch` VALUES (8021, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:10:41', '2026-03-03 16:10:41');
INSERT INTO `sj_job_task_batch` VALUES (8022, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:11:41', '2026-03-03 16:11:41');
INSERT INTO `sj_job_task_batch` VALUES (8023, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:12:41', '2026-03-03 16:12:41');
INSERT INTO `sj_job_task_batch` VALUES (8024, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:13:41', '2026-03-03 16:13:41');
INSERT INTO `sj_job_task_batch` VALUES (8025, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:14:41', '2026-03-03 16:14:41');
INSERT INTO `sj_job_task_batch` VALUES (8026, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:15:41', '2026-03-03 16:15:41');
INSERT INTO `sj_job_task_batch` VALUES (8027, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:16:41', '2026-03-03 16:16:41');
INSERT INTO `sj_job_task_batch` VALUES (8028, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:17:41', '2026-03-03 16:17:41');
INSERT INTO `sj_job_task_batch` VALUES (8029, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:18:41', '2026-03-03 16:18:41');
INSERT INTO `sj_job_task_batch` VALUES (8030, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:19:41', '2026-03-03 16:19:41');
INSERT INTO `sj_job_task_batch` VALUES (8031, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:20:41', '2026-03-03 16:20:41');
INSERT INTO `sj_job_task_batch` VALUES (8032, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:21:41', '2026-03-03 16:21:41');
INSERT INTO `sj_job_task_batch` VALUES (8033, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:22:41', '2026-03-03 16:22:41');
INSERT INTO `sj_job_task_batch` VALUES (8034, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:23:41', '2026-03-03 16:23:41');
INSERT INTO `sj_job_task_batch` VALUES (8035, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:24:41', '2026-03-03 16:24:41');
INSERT INTO `sj_job_task_batch` VALUES (8036, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:25:41', '2026-03-03 16:25:41');
INSERT INTO `sj_job_task_batch` VALUES (8037, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:26:41', '2026-03-03 16:26:41');
INSERT INTO `sj_job_task_batch` VALUES (8038, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:27:41', '2026-03-03 16:27:41');
INSERT INTO `sj_job_task_batch` VALUES (8039, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:28:41', '2026-03-03 16:28:41');
INSERT INTO `sj_job_task_batch` VALUES (8040, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:29:41', '2026-03-03 16:29:41');
INSERT INTO `sj_job_task_batch` VALUES (8041, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:30:41', '2026-03-03 16:30:41');
INSERT INTO `sj_job_task_batch` VALUES (8042, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:31:41', '2026-03-03 16:31:41');
INSERT INTO `sj_job_task_batch` VALUES (8043, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:32:41', '2026-03-03 16:32:41');
INSERT INTO `sj_job_task_batch` VALUES (8044, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:33:41', '2026-03-03 16:33:41');
INSERT INTO `sj_job_task_batch` VALUES (8045, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:34:41', '2026-03-03 16:34:41');
INSERT INTO `sj_job_task_batch` VALUES (8046, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:35:41', '2026-03-03 16:35:41');
INSERT INTO `sj_job_task_batch` VALUES (8047, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:36:41', '2026-03-03 16:36:41');
INSERT INTO `sj_job_task_batch` VALUES (8048, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:37:41', '2026-03-03 16:37:41');
INSERT INTO `sj_job_task_batch` VALUES (8049, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:38:41', '2026-03-03 16:38:41');
INSERT INTO `sj_job_task_batch` VALUES (8050, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:39:41', '2026-03-03 16:39:41');
INSERT INTO `sj_job_task_batch` VALUES (8051, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:40:41', '2026-03-03 16:40:41');
INSERT INTO `sj_job_task_batch` VALUES (8052, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:41:41', '2026-03-03 16:41:41');
INSERT INTO `sj_job_task_batch` VALUES (8053, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:42:41', '2026-03-03 16:42:41');
INSERT INTO `sj_job_task_batch` VALUES (8054, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:43:41', '2026-03-03 16:43:41');
INSERT INTO `sj_job_task_batch` VALUES (8055, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:44:41', '2026-03-03 16:44:41');
INSERT INTO `sj_job_task_batch` VALUES (8056, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:45:41', '2026-03-03 16:45:41');
INSERT INTO `sj_job_task_batch` VALUES (8057, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:46:41', '2026-03-03 16:46:41');
INSERT INTO `sj_job_task_batch` VALUES (8058, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:47:41', '2026-03-03 16:47:41');
INSERT INTO `sj_job_task_batch` VALUES (8059, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:48:41', '2026-03-03 16:48:41');
INSERT INTO `sj_job_task_batch` VALUES (8060, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:49:41', '2026-03-03 16:49:41');
INSERT INTO `sj_job_task_batch` VALUES (8061, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:50:41', '2026-03-03 16:50:41');
INSERT INTO `sj_job_task_batch` VALUES (8062, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:51:41', '2026-03-03 16:51:41');
INSERT INTO `sj_job_task_batch` VALUES (8063, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:52:41', '2026-03-03 16:52:41');
INSERT INTO `sj_job_task_batch` VALUES (8064, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:53:41', '2026-03-03 16:53:41');
INSERT INTO `sj_job_task_batch` VALUES (8065, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:54:41', '2026-03-03 16:54:41');
INSERT INTO `sj_job_task_batch` VALUES (8066, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:55:41', '2026-03-03 16:55:41');
INSERT INTO `sj_job_task_batch` VALUES (8067, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:56:41', '2026-03-03 16:56:41');
INSERT INTO `sj_job_task_batch` VALUES (8068, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:57:41', '2026-03-03 16:57:41');
INSERT INTO `sj_job_task_batch` VALUES (8069, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:58:41', '2026-03-03 16:58:41');
INSERT INTO `sj_job_task_batch` VALUES (8070, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 16:59:41', '2026-03-03 16:59:41');
INSERT INTO `sj_job_task_batch` VALUES (8071, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:00:41', '2026-03-03 17:00:41');
INSERT INTO `sj_job_task_batch` VALUES (8072, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:01:41', '2026-03-03 17:01:41');
INSERT INTO `sj_job_task_batch` VALUES (8073, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:02:41', '2026-03-03 17:02:41');
INSERT INTO `sj_job_task_batch` VALUES (8074, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:03:41', '2026-03-03 17:03:41');
INSERT INTO `sj_job_task_batch` VALUES (8075, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:04:41', '2026-03-03 17:04:41');
INSERT INTO `sj_job_task_batch` VALUES (8076, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:05:41', '2026-03-03 17:05:41');
INSERT INTO `sj_job_task_batch` VALUES (8077, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:06:41', '2026-03-03 17:06:41');
INSERT INTO `sj_job_task_batch` VALUES (8078, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:07:41', '2026-03-03 17:07:41');
INSERT INTO `sj_job_task_batch` VALUES (8079, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:08:41', '2026-03-03 17:08:41');
INSERT INTO `sj_job_task_batch` VALUES (8080, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:09:41', '2026-03-03 17:09:41');
INSERT INTO `sj_job_task_batch` VALUES (8081, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:10:41', '2026-03-03 17:10:41');
INSERT INTO `sj_job_task_batch` VALUES (8082, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:11:41', '2026-03-03 17:11:41');
INSERT INTO `sj_job_task_batch` VALUES (8083, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:12:41', '2026-03-03 17:12:41');
INSERT INTO `sj_job_task_batch` VALUES (8084, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:13:41', '2026-03-03 17:13:41');
INSERT INTO `sj_job_task_batch` VALUES (8085, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:14:41', '2026-03-03 17:14:41');
INSERT INTO `sj_job_task_batch` VALUES (8086, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:15:41', '2026-03-03 17:15:41');
INSERT INTO `sj_job_task_batch` VALUES (8087, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:16:41', '2026-03-03 17:16:41');
INSERT INTO `sj_job_task_batch` VALUES (8088, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:17:41', '2026-03-03 17:17:41');
INSERT INTO `sj_job_task_batch` VALUES (8089, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:18:41', '2026-03-03 17:18:41');
INSERT INTO `sj_job_task_batch` VALUES (8090, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:19:41', '2026-03-03 17:19:41');
INSERT INTO `sj_job_task_batch` VALUES (8091, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:20:41', '2026-03-03 17:20:41');
INSERT INTO `sj_job_task_batch` VALUES (8092, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:21:41', '2026-03-03 17:21:41');
INSERT INTO `sj_job_task_batch` VALUES (8093, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:22:41', '2026-03-03 17:22:41');
INSERT INTO `sj_job_task_batch` VALUES (8094, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:23:41', '2026-03-03 17:23:41');
INSERT INTO `sj_job_task_batch` VALUES (8095, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:24:41', '2026-03-03 17:24:41');
INSERT INTO `sj_job_task_batch` VALUES (8096, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:25:41', '2026-03-03 17:25:41');
INSERT INTO `sj_job_task_batch` VALUES (8097, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:26:41', '2026-03-03 17:26:41');
INSERT INTO `sj_job_task_batch` VALUES (8098, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:27:41', '2026-03-03 17:27:41');
INSERT INTO `sj_job_task_batch` VALUES (8099, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:28:41', '2026-03-03 17:28:41');
INSERT INTO `sj_job_task_batch` VALUES (8100, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:29:41', '2026-03-03 17:29:41');
INSERT INTO `sj_job_task_batch` VALUES (8101, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:30:41', '2026-03-03 17:30:41');
INSERT INTO `sj_job_task_batch` VALUES (8102, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:31:41', '2026-03-03 17:31:41');
INSERT INTO `sj_job_task_batch` VALUES (8103, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:32:41', '2026-03-03 17:32:41');
INSERT INTO `sj_job_task_batch` VALUES (8104, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:33:41', '2026-03-03 17:33:41');
INSERT INTO `sj_job_task_batch` VALUES (8105, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:34:41', '2026-03-03 17:34:41');
INSERT INTO `sj_job_task_batch` VALUES (8106, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:35:41', '2026-03-03 17:35:41');
INSERT INTO `sj_job_task_batch` VALUES (8107, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:36:41', '2026-03-03 17:36:41');
INSERT INTO `sj_job_task_batch` VALUES (8108, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:37:41', '2026-03-03 17:37:41');
INSERT INTO `sj_job_task_batch` VALUES (8109, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:38:41', '2026-03-03 17:38:41');
INSERT INTO `sj_job_task_batch` VALUES (8110, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:39:41', '2026-03-03 17:39:41');
INSERT INTO `sj_job_task_batch` VALUES (8111, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:40:41', '2026-03-03 17:40:41');
INSERT INTO `sj_job_task_batch` VALUES (8112, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:41:41', '2026-03-03 17:41:41');
INSERT INTO `sj_job_task_batch` VALUES (8113, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:42:41', '2026-03-03 17:42:41');
INSERT INTO `sj_job_task_batch` VALUES (8114, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:43:41', '2026-03-03 17:43:41');
INSERT INTO `sj_job_task_batch` VALUES (8115, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:44:41', '2026-03-03 17:44:41');
INSERT INTO `sj_job_task_batch` VALUES (8116, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:45:41', '2026-03-03 17:45:41');
INSERT INTO `sj_job_task_batch` VALUES (8117, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:46:41', '2026-03-03 17:46:41');
INSERT INTO `sj_job_task_batch` VALUES (8118, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:47:41', '2026-03-03 17:47:41');
INSERT INTO `sj_job_task_batch` VALUES (8119, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:48:41', '2026-03-03 17:48:41');
INSERT INTO `sj_job_task_batch` VALUES (8120, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:49:41', '2026-03-03 17:49:41');
INSERT INTO `sj_job_task_batch` VALUES (8121, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:50:41', '2026-03-03 17:50:41');
INSERT INTO `sj_job_task_batch` VALUES (8122, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:51:41', '2026-03-03 17:51:41');
INSERT INTO `sj_job_task_batch` VALUES (8123, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:52:41', '2026-03-03 17:52:41');
INSERT INTO `sj_job_task_batch` VALUES (8124, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:53:41', '2026-03-03 17:53:41');
INSERT INTO `sj_job_task_batch` VALUES (8125, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:54:41', '2026-03-03 17:54:41');
INSERT INTO `sj_job_task_batch` VALUES (8126, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:55:41', '2026-03-03 17:55:41');
INSERT INTO `sj_job_task_batch` VALUES (8127, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:56:41', '2026-03-03 17:56:41');
INSERT INTO `sj_job_task_batch` VALUES (8128, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:57:41', '2026-03-03 17:57:41');
INSERT INTO `sj_job_task_batch` VALUES (8129, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:58:41', '2026-03-03 17:58:41');
INSERT INTO `sj_job_task_batch` VALUES (8130, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 17:59:41', '2026-03-03 17:59:41');
INSERT INTO `sj_job_task_batch` VALUES (8131, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:00:41', '2026-03-03 18:00:41');
INSERT INTO `sj_job_task_batch` VALUES (8132, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:01:41', '2026-03-03 18:01:41');
INSERT INTO `sj_job_task_batch` VALUES (8133, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:02:41', '2026-03-03 18:02:41');
INSERT INTO `sj_job_task_batch` VALUES (8134, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:03:41', '2026-03-03 18:03:41');
INSERT INTO `sj_job_task_batch` VALUES (8135, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:04:41', '2026-03-03 18:04:41');
INSERT INTO `sj_job_task_batch` VALUES (8136, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:05:41', '2026-03-03 18:05:41');
INSERT INTO `sj_job_task_batch` VALUES (8137, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:06:41', '2026-03-03 18:06:41');
INSERT INTO `sj_job_task_batch` VALUES (8138, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:07:41', '2026-03-03 18:07:41');
INSERT INTO `sj_job_task_batch` VALUES (8139, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:08:41', '2026-03-03 18:08:41');
INSERT INTO `sj_job_task_batch` VALUES (8140, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:09:41', '2026-03-03 18:09:41');
INSERT INTO `sj_job_task_batch` VALUES (8141, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:10:41', '2026-03-03 18:10:41');
INSERT INTO `sj_job_task_batch` VALUES (8142, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:11:41', '2026-03-03 18:11:41');
INSERT INTO `sj_job_task_batch` VALUES (8143, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:12:41', '2026-03-03 18:12:41');
INSERT INTO `sj_job_task_batch` VALUES (8144, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:13:41', '2026-03-03 18:13:41');
INSERT INTO `sj_job_task_batch` VALUES (8145, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:14:41', '2026-03-03 18:14:41');
INSERT INTO `sj_job_task_batch` VALUES (8146, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:15:41', '2026-03-03 18:15:41');
INSERT INTO `sj_job_task_batch` VALUES (8147, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:16:41', '2026-03-03 18:16:41');
INSERT INTO `sj_job_task_batch` VALUES (8148, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:17:41', '2026-03-03 18:17:41');
INSERT INTO `sj_job_task_batch` VALUES (8149, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:18:41', '2026-03-03 18:18:41');
INSERT INTO `sj_job_task_batch` VALUES (8150, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:19:41', '2026-03-03 18:19:41');
INSERT INTO `sj_job_task_batch` VALUES (8151, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:20:41', '2026-03-03 18:20:41');
INSERT INTO `sj_job_task_batch` VALUES (8152, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:21:41', '2026-03-03 18:21:41');
INSERT INTO `sj_job_task_batch` VALUES (8153, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:22:41', '2026-03-03 18:22:41');
INSERT INTO `sj_job_task_batch` VALUES (8154, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:23:41', '2026-03-03 18:23:41');
INSERT INTO `sj_job_task_batch` VALUES (8155, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:24:41', '2026-03-03 18:24:41');
INSERT INTO `sj_job_task_batch` VALUES (8156, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:25:41', '2026-03-03 18:25:41');
INSERT INTO `sj_job_task_batch` VALUES (8157, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:26:41', '2026-03-03 18:26:41');
INSERT INTO `sj_job_task_batch` VALUES (8158, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:27:41', '2026-03-03 18:27:41');
INSERT INTO `sj_job_task_batch` VALUES (8159, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:28:41', '2026-03-03 18:28:41');
INSERT INTO `sj_job_task_batch` VALUES (8160, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:29:41', '2026-03-03 18:29:41');
INSERT INTO `sj_job_task_batch` VALUES (8161, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:30:41', '2026-03-03 18:30:41');
INSERT INTO `sj_job_task_batch` VALUES (8162, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:31:41', '2026-03-03 18:31:41');
INSERT INTO `sj_job_task_batch` VALUES (8163, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:32:41', '2026-03-03 18:32:41');
INSERT INTO `sj_job_task_batch` VALUES (8164, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:33:41', '2026-03-03 18:33:41');
INSERT INTO `sj_job_task_batch` VALUES (8165, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:34:41', '2026-03-03 18:34:41');
INSERT INTO `sj_job_task_batch` VALUES (8166, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:35:41', '2026-03-03 18:35:41');
INSERT INTO `sj_job_task_batch` VALUES (8167, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:36:41', '2026-03-03 18:36:41');
INSERT INTO `sj_job_task_batch` VALUES (8168, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:37:41', '2026-03-03 18:37:41');
INSERT INTO `sj_job_task_batch` VALUES (8169, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:38:41', '2026-03-03 18:38:41');
INSERT INTO `sj_job_task_batch` VALUES (8170, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:39:41', '2026-03-03 18:39:41');
INSERT INTO `sj_job_task_batch` VALUES (8171, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:40:41', '2026-03-03 18:40:41');
INSERT INTO `sj_job_task_batch` VALUES (8172, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:41:41', '2026-03-03 18:41:41');
INSERT INTO `sj_job_task_batch` VALUES (8173, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:42:41', '2026-03-03 18:42:41');
INSERT INTO `sj_job_task_batch` VALUES (8174, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:43:41', '2026-03-03 18:43:41');
INSERT INTO `sj_job_task_batch` VALUES (8175, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:44:41', '2026-03-03 18:44:41');
INSERT INTO `sj_job_task_batch` VALUES (8176, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:45:41', '2026-03-03 18:45:41');
INSERT INTO `sj_job_task_batch` VALUES (8177, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:46:41', '2026-03-03 18:46:41');
INSERT INTO `sj_job_task_batch` VALUES (8178, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:47:41', '2026-03-03 18:47:41');
INSERT INTO `sj_job_task_batch` VALUES (8179, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:48:41', '2026-03-03 18:48:41');
INSERT INTO `sj_job_task_batch` VALUES (8180, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:49:41', '2026-03-03 18:49:41');
INSERT INTO `sj_job_task_batch` VALUES (8181, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:50:41', '2026-03-03 18:50:41');
INSERT INTO `sj_job_task_batch` VALUES (8182, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:51:41', '2026-03-03 18:51:41');
INSERT INTO `sj_job_task_batch` VALUES (8183, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:52:41', '2026-03-03 18:52:41');
INSERT INTO `sj_job_task_batch` VALUES (8184, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:53:41', '2026-03-03 18:53:41');
INSERT INTO `sj_job_task_batch` VALUES (8185, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:54:41', '2026-03-03 18:54:41');
INSERT INTO `sj_job_task_batch` VALUES (8186, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:55:41', '2026-03-03 18:55:41');
INSERT INTO `sj_job_task_batch` VALUES (8187, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:56:41', '2026-03-03 18:56:41');
INSERT INTO `sj_job_task_batch` VALUES (8188, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:57:41', '2026-03-03 18:57:41');
INSERT INTO `sj_job_task_batch` VALUES (8189, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:58:41', '2026-03-03 18:58:41');
INSERT INTO `sj_job_task_batch` VALUES (8190, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 18:59:41', '2026-03-03 18:59:41');
INSERT INTO `sj_job_task_batch` VALUES (8191, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:00:41', '2026-03-03 19:00:41');
INSERT INTO `sj_job_task_batch` VALUES (8192, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:01:41', '2026-03-03 19:01:41');
INSERT INTO `sj_job_task_batch` VALUES (8193, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:02:41', '2026-03-03 19:02:41');
INSERT INTO `sj_job_task_batch` VALUES (8194, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:03:41', '2026-03-03 19:03:41');
INSERT INTO `sj_job_task_batch` VALUES (8195, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:04:41', '2026-03-03 19:04:41');
INSERT INTO `sj_job_task_batch` VALUES (8196, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:05:41', '2026-03-03 19:05:41');
INSERT INTO `sj_job_task_batch` VALUES (8197, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:06:41', '2026-03-03 19:06:41');
INSERT INTO `sj_job_task_batch` VALUES (8198, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:07:41', '2026-03-03 19:07:41');
INSERT INTO `sj_job_task_batch` VALUES (8199, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:08:41', '2026-03-03 19:08:41');
INSERT INTO `sj_job_task_batch` VALUES (8200, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:09:41', '2026-03-03 19:09:41');
INSERT INTO `sj_job_task_batch` VALUES (8201, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:10:41', '2026-03-03 19:10:41');
INSERT INTO `sj_job_task_batch` VALUES (8202, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:11:41', '2026-03-03 19:11:41');
INSERT INTO `sj_job_task_batch` VALUES (8203, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:12:41', '2026-03-03 19:12:41');
INSERT INTO `sj_job_task_batch` VALUES (8204, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:13:41', '2026-03-03 19:13:41');
INSERT INTO `sj_job_task_batch` VALUES (8205, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-03 19:14:41', '2026-03-03 19:14:41');
INSERT INTO `sj_job_task_batch` VALUES (8206, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:15:51', '2026-03-04 10:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8207, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:16:51', '2026-03-04 10:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8208, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:17:51', '2026-03-04 10:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8209, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:18:51', '2026-03-04 10:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8210, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:19:51', '2026-03-04 10:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8211, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:20:51', '2026-03-04 10:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8212, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:21:51', '2026-03-04 10:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8213, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:22:51', '2026-03-04 10:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8214, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:23:51', '2026-03-04 10:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8215, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:24:51', '2026-03-04 10:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8216, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:25:51', '2026-03-04 10:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8217, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:26:51', '2026-03-04 10:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8218, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:27:51', '2026-03-04 10:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8219, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:28:51', '2026-03-04 10:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8220, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:29:51', '2026-03-04 10:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8221, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:30:51', '2026-03-04 10:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8222, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:31:51', '2026-03-04 10:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8223, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:32:51', '2026-03-04 10:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8224, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:33:51', '2026-03-04 10:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8225, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:34:51', '2026-03-04 10:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8226, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:35:51', '2026-03-04 10:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8227, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:36:51', '2026-03-04 10:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8228, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:37:51', '2026-03-04 10:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8229, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:38:51', '2026-03-04 10:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8230, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:39:51', '2026-03-04 10:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8231, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:40:51', '2026-03-04 10:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8232, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:41:51', '2026-03-04 10:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8233, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:42:51', '2026-03-04 10:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8234, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:43:51', '2026-03-04 10:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8235, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:44:51', '2026-03-04 10:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8236, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:45:51', '2026-03-04 10:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8237, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:46:51', '2026-03-04 10:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8238, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:47:51', '2026-03-04 10:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8239, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:48:51', '2026-03-04 10:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8240, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:49:51', '2026-03-04 10:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8241, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:50:51', '2026-03-04 10:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8242, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:51:51', '2026-03-04 10:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8243, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:52:51', '2026-03-04 10:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8244, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:53:51', '2026-03-04 10:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8245, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:54:51', '2026-03-04 10:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8246, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:55:51', '2026-03-04 10:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8247, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:56:51', '2026-03-04 10:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8248, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:57:51', '2026-03-04 10:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8249, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:58:51', '2026-03-04 10:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8250, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 10:59:51', '2026-03-04 10:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8251, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:00:51', '2026-03-04 11:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8252, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:01:51', '2026-03-04 11:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8253, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:02:51', '2026-03-04 11:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8254, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:03:51', '2026-03-04 11:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8255, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:04:51', '2026-03-04 11:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8256, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:05:51', '2026-03-04 11:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8257, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:06:51', '2026-03-04 11:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8258, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:07:51', '2026-03-04 11:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8259, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:08:51', '2026-03-04 11:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8260, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:09:51', '2026-03-04 11:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8261, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:10:51', '2026-03-04 11:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8262, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:11:51', '2026-03-04 11:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8263, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:12:51', '2026-03-04 11:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8264, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:13:51', '2026-03-04 11:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8265, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:14:51', '2026-03-04 11:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8266, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:15:51', '2026-03-04 11:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8267, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:16:51', '2026-03-04 11:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8268, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:17:51', '2026-03-04 11:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8269, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:18:51', '2026-03-04 11:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8270, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:19:51', '2026-03-04 11:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8271, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:20:51', '2026-03-04 11:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8272, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:21:51', '2026-03-04 11:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8273, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:22:51', '2026-03-04 11:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8274, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:23:51', '2026-03-04 11:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8275, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:24:51', '2026-03-04 11:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8276, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:25:51', '2026-03-04 11:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8277, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:26:51', '2026-03-04 11:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8278, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:27:51', '2026-03-04 11:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8279, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:28:51', '2026-03-04 11:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8280, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:29:51', '2026-03-04 11:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8281, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:30:51', '2026-03-04 11:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8282, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:31:51', '2026-03-04 11:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8283, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:32:51', '2026-03-04 11:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8284, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:33:51', '2026-03-04 11:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8285, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:34:51', '2026-03-04 11:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8286, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:35:51', '2026-03-04 11:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8287, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:36:51', '2026-03-04 11:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8288, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:37:51', '2026-03-04 11:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8289, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:38:51', '2026-03-04 11:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8290, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:39:51', '2026-03-04 11:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8291, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:40:51', '2026-03-04 11:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8292, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:41:51', '2026-03-04 11:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8293, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:42:51', '2026-03-04 11:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8294, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:43:51', '2026-03-04 11:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8295, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:44:51', '2026-03-04 11:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8296, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:45:51', '2026-03-04 11:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8297, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:46:51', '2026-03-04 11:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8298, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:47:51', '2026-03-04 11:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8299, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:48:51', '2026-03-04 11:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8300, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:49:51', '2026-03-04 11:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8301, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:50:51', '2026-03-04 11:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8302, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:51:51', '2026-03-04 11:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8303, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:52:51', '2026-03-04 11:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8304, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:53:51', '2026-03-04 11:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8305, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:54:51', '2026-03-04 11:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8306, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:55:51', '2026-03-04 11:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8307, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:56:51', '2026-03-04 11:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8308, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:57:51', '2026-03-04 11:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8309, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:58:51', '2026-03-04 11:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8310, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 11:59:51', '2026-03-04 11:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8311, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:00:51', '2026-03-04 12:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8312, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:01:51', '2026-03-04 12:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8313, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:02:51', '2026-03-04 12:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8314, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:03:51', '2026-03-04 12:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8315, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:04:51', '2026-03-04 12:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8316, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:05:51', '2026-03-04 12:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8317, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:06:51', '2026-03-04 12:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8318, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:07:51', '2026-03-04 12:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8319, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:08:51', '2026-03-04 12:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8320, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:09:51', '2026-03-04 12:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8321, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:10:51', '2026-03-04 12:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8322, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:11:51', '2026-03-04 12:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8323, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:12:51', '2026-03-04 12:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8324, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:13:51', '2026-03-04 12:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8325, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:14:51', '2026-03-04 12:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8326, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:15:51', '2026-03-04 12:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8327, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:16:51', '2026-03-04 12:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8328, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:17:51', '2026-03-04 12:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8329, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:18:51', '2026-03-04 12:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8330, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:19:51', '2026-03-04 12:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8331, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:20:51', '2026-03-04 12:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8332, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:21:51', '2026-03-04 12:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8333, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:22:51', '2026-03-04 12:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8334, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:23:51', '2026-03-04 12:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8335, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:24:51', '2026-03-04 12:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8336, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:25:51', '2026-03-04 12:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8337, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:26:51', '2026-03-04 12:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8338, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:27:51', '2026-03-04 12:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8339, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:28:51', '2026-03-04 12:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8340, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:29:51', '2026-03-04 12:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8341, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:30:51', '2026-03-04 12:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8342, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:31:51', '2026-03-04 12:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8343, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:32:51', '2026-03-04 12:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8344, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:33:51', '2026-03-04 12:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8345, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:34:51', '2026-03-04 12:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8346, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:35:51', '2026-03-04 12:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8347, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:36:51', '2026-03-04 12:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8348, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:37:51', '2026-03-04 12:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8349, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:38:51', '2026-03-04 12:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8350, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:39:51', '2026-03-04 12:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8351, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:40:51', '2026-03-04 12:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8352, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:41:51', '2026-03-04 12:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8353, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:42:51', '2026-03-04 12:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8354, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:43:51', '2026-03-04 12:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8355, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:44:51', '2026-03-04 12:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8356, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:45:51', '2026-03-04 12:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8357, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:46:51', '2026-03-04 12:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8358, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:47:51', '2026-03-04 12:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8359, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:48:51', '2026-03-04 12:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8360, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:49:51', '2026-03-04 12:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8361, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:50:51', '2026-03-04 12:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8362, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:51:51', '2026-03-04 12:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8363, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:52:51', '2026-03-04 12:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8364, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:53:51', '2026-03-04 12:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8365, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:54:51', '2026-03-04 12:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8366, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:55:51', '2026-03-04 12:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8367, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:56:51', '2026-03-04 12:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8368, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:57:51', '2026-03-04 12:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8369, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:58:51', '2026-03-04 12:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8370, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 12:59:51', '2026-03-04 12:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8371, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:00:51', '2026-03-04 13:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8372, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:01:51', '2026-03-04 13:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8373, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:02:51', '2026-03-04 13:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8374, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:03:51', '2026-03-04 13:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8375, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:04:51', '2026-03-04 13:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8376, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:05:51', '2026-03-04 13:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8377, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:06:51', '2026-03-04 13:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8378, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:07:51', '2026-03-04 13:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8379, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:08:51', '2026-03-04 13:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8380, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:09:51', '2026-03-04 13:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8381, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:10:51', '2026-03-04 13:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8382, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:11:51', '2026-03-04 13:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8383, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:12:51', '2026-03-04 13:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8384, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:13:51', '2026-03-04 13:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8385, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:14:51', '2026-03-04 13:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8386, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:15:51', '2026-03-04 13:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8387, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:16:51', '2026-03-04 13:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8388, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:17:51', '2026-03-04 13:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8389, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:18:51', '2026-03-04 13:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8390, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:19:51', '2026-03-04 13:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8391, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:20:51', '2026-03-04 13:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8392, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:21:51', '2026-03-04 13:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8393, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:22:51', '2026-03-04 13:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8394, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:23:51', '2026-03-04 13:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8395, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:24:51', '2026-03-04 13:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8396, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:25:51', '2026-03-04 13:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8397, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:26:51', '2026-03-04 13:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8398, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:27:51', '2026-03-04 13:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8399, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:28:51', '2026-03-04 13:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8400, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:29:51', '2026-03-04 13:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8401, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:30:51', '2026-03-04 13:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8402, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:31:51', '2026-03-04 13:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8403, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:32:51', '2026-03-04 13:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8404, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:33:51', '2026-03-04 13:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8405, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:34:51', '2026-03-04 13:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8406, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:35:51', '2026-03-04 13:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8407, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:36:51', '2026-03-04 13:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8408, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:37:51', '2026-03-04 13:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8409, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:38:51', '2026-03-04 13:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8410, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:39:51', '2026-03-04 13:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8411, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:40:51', '2026-03-04 13:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8412, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:41:51', '2026-03-04 13:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8413, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:42:51', '2026-03-04 13:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8414, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:43:51', '2026-03-04 13:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8415, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:44:51', '2026-03-04 13:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8416, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:45:51', '2026-03-04 13:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8417, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:46:51', '2026-03-04 13:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8418, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:47:51', '2026-03-04 13:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8419, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:48:51', '2026-03-04 13:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8420, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:49:51', '2026-03-04 13:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8421, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:50:51', '2026-03-04 13:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8422, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:51:51', '2026-03-04 13:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8423, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:52:51', '2026-03-04 13:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8424, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:53:51', '2026-03-04 13:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8425, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:54:51', '2026-03-04 13:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8426, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:55:51', '2026-03-04 13:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8427, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:56:51', '2026-03-04 13:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8428, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:57:51', '2026-03-04 13:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8429, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:58:51', '2026-03-04 13:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8430, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 13:59:51', '2026-03-04 13:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8431, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:00:51', '2026-03-04 14:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8432, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:01:51', '2026-03-04 14:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8433, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:02:51', '2026-03-04 14:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8434, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:03:51', '2026-03-04 14:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8435, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:04:51', '2026-03-04 14:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8436, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:05:51', '2026-03-04 14:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8437, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:06:51', '2026-03-04 14:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8438, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:07:51', '2026-03-04 14:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8439, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:08:51', '2026-03-04 14:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8440, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:09:51', '2026-03-04 14:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8441, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:10:51', '2026-03-04 14:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8442, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:11:51', '2026-03-04 14:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8443, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:12:51', '2026-03-04 14:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8444, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:13:51', '2026-03-04 14:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8445, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:14:51', '2026-03-04 14:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8446, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:15:51', '2026-03-04 14:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8447, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:16:51', '2026-03-04 14:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8448, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:17:51', '2026-03-04 14:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8449, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:18:51', '2026-03-04 14:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8450, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:19:51', '2026-03-04 14:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8451, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:20:51', '2026-03-04 14:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8452, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:21:51', '2026-03-04 14:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8453, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:22:51', '2026-03-04 14:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8454, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:23:51', '2026-03-04 14:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8455, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:24:51', '2026-03-04 14:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8456, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:25:51', '2026-03-04 14:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8457, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:26:51', '2026-03-04 14:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8458, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:27:51', '2026-03-04 14:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8459, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:28:51', '2026-03-04 14:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8460, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:29:51', '2026-03-04 14:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8461, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:30:51', '2026-03-04 14:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8462, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:31:51', '2026-03-04 14:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8463, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:32:51', '2026-03-04 14:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8464, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:33:51', '2026-03-04 14:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8465, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:34:51', '2026-03-04 14:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8466, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:35:51', '2026-03-04 14:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8467, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:36:51', '2026-03-04 14:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8468, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:37:51', '2026-03-04 14:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8469, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:38:51', '2026-03-04 14:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8470, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:39:51', '2026-03-04 14:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8471, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:40:51', '2026-03-04 14:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8472, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:41:51', '2026-03-04 14:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8473, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:42:51', '2026-03-04 14:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8474, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:43:51', '2026-03-04 14:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8475, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:44:51', '2026-03-04 14:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8476, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:45:51', '2026-03-04 14:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8477, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:46:51', '2026-03-04 14:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8478, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:47:51', '2026-03-04 14:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8479, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:48:51', '2026-03-04 14:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8480, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:49:51', '2026-03-04 14:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8481, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:50:51', '2026-03-04 14:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8482, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:51:51', '2026-03-04 14:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8483, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:52:51', '2026-03-04 14:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8484, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:53:51', '2026-03-04 14:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8485, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:54:51', '2026-03-04 14:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8486, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:55:51', '2026-03-04 14:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8487, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:56:51', '2026-03-04 14:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8488, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:57:51', '2026-03-04 14:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8489, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:58:51', '2026-03-04 14:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8490, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 14:59:51', '2026-03-04 14:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8491, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:00:51', '2026-03-04 15:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8492, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:01:51', '2026-03-04 15:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8493, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:02:51', '2026-03-04 15:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8494, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:03:51', '2026-03-04 15:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8495, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:04:51', '2026-03-04 15:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8496, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:05:51', '2026-03-04 15:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8497, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:06:51', '2026-03-04 15:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8498, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8499, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:08:51', '2026-03-04 15:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8500, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:09:51', '2026-03-04 15:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8501, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:10:51', '2026-03-04 15:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8502, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:11:51', '2026-03-04 15:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8503, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:12:51', '2026-03-04 15:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8504, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:13:51', '2026-03-04 15:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8505, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:14:51', '2026-03-04 15:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8506, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:15:51', '2026-03-04 15:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8507, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:16:51', '2026-03-04 15:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8508, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:17:51', '2026-03-04 15:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8509, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:18:51', '2026-03-04 15:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8510, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:19:51', '2026-03-04 15:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8511, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:20:51', '2026-03-04 15:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8512, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:21:51', '2026-03-04 15:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8513, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:22:51', '2026-03-04 15:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8514, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:23:51', '2026-03-04 15:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8515, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:24:51', '2026-03-04 15:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8516, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:25:51', '2026-03-04 15:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8517, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:26:51', '2026-03-04 15:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8518, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:27:51', '2026-03-04 15:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8519, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:28:51', '2026-03-04 15:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8520, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:29:51', '2026-03-04 15:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8521, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:30:51', '2026-03-04 15:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8522, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:31:51', '2026-03-04 15:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8523, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:32:51', '2026-03-04 15:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8524, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:33:51', '2026-03-04 15:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8525, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:34:51', '2026-03-04 15:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8526, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:35:51', '2026-03-04 15:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8527, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:36:51', '2026-03-04 15:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8528, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:37:51', '2026-03-04 15:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8529, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:38:51', '2026-03-04 15:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8530, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:39:51', '2026-03-04 15:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8531, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:40:51', '2026-03-04 15:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8532, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:41:51', '2026-03-04 15:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8533, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:42:51', '2026-03-04 15:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8534, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:43:51', '2026-03-04 15:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8535, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:44:51', '2026-03-04 15:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8536, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:45:51', '2026-03-04 15:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8537, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:46:51', '2026-03-04 15:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8538, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:47:51', '2026-03-04 15:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8539, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:48:51', '2026-03-04 15:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8540, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:49:51', '2026-03-04 15:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8541, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:50:51', '2026-03-04 15:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8542, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:51:51', '2026-03-04 15:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8543, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:52:51', '2026-03-04 15:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8544, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:53:51', '2026-03-04 15:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8545, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:54:51', '2026-03-04 15:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8546, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:55:51', '2026-03-04 15:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8547, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:56:51', '2026-03-04 15:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8548, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:57:51', '2026-03-04 15:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8549, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:58:51', '2026-03-04 15:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8550, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 15:59:51', '2026-03-04 15:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8551, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:00:51', '2026-03-04 16:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8552, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:01:51', '2026-03-04 16:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8553, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:02:51', '2026-03-04 16:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8554, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:03:51', '2026-03-04 16:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8555, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:04:51', '2026-03-04 16:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8556, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:05:51', '2026-03-04 16:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8557, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:06:51', '2026-03-04 16:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8558, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:07:51', '2026-03-04 16:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8559, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:08:51', '2026-03-04 16:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8560, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:09:51', '2026-03-04 16:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8561, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:10:51', '2026-03-04 16:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8562, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:11:51', '2026-03-04 16:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8563, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:12:51', '2026-03-04 16:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8564, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:13:51', '2026-03-04 16:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8565, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:14:51', '2026-03-04 16:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8566, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:15:51', '2026-03-04 16:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8567, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:16:51', '2026-03-04 16:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8568, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:17:51', '2026-03-04 16:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8569, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:18:51', '2026-03-04 16:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8570, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:19:51', '2026-03-04 16:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8571, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:20:51', '2026-03-04 16:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8572, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:21:51', '2026-03-04 16:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8573, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:22:51', '2026-03-04 16:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8574, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:23:51', '2026-03-04 16:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8575, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:24:51', '2026-03-04 16:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8576, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:25:51', '2026-03-04 16:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8577, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:26:51', '2026-03-04 16:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8578, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:27:51', '2026-03-04 16:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8579, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:28:51', '2026-03-04 16:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8580, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:29:51', '2026-03-04 16:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8581, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:30:51', '2026-03-04 16:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8582, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:31:51', '2026-03-04 16:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8583, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:32:51', '2026-03-04 16:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8584, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:33:51', '2026-03-04 16:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8585, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:34:51', '2026-03-04 16:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8586, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:35:51', '2026-03-04 16:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8587, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:36:51', '2026-03-04 16:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8588, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:37:51', '2026-03-04 16:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8589, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:38:51', '2026-03-04 16:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8590, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:39:51', '2026-03-04 16:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8591, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:40:51', '2026-03-04 16:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8592, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:41:51', '2026-03-04 16:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8593, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:42:51', '2026-03-04 16:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8594, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:43:51', '2026-03-04 16:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8595, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:44:51', '2026-03-04 16:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8596, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:45:51', '2026-03-04 16:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8597, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:46:51', '2026-03-04 16:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8598, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:47:51', '2026-03-04 16:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8599, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:48:51', '2026-03-04 16:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8600, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:49:51', '2026-03-04 16:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8601, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:50:51', '2026-03-04 16:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8602, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:51:51', '2026-03-04 16:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8603, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:52:51', '2026-03-04 16:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8604, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:53:51', '2026-03-04 16:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8605, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:54:51', '2026-03-04 16:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8606, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:55:51', '2026-03-04 16:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8607, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:56:51', '2026-03-04 16:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8608, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:57:51', '2026-03-04 16:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8609, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:58:51', '2026-03-04 16:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8610, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 16:59:51', '2026-03-04 16:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8611, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:00:51', '2026-03-04 17:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8612, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:01:51', '2026-03-04 17:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8613, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:02:51', '2026-03-04 17:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8614, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:03:51', '2026-03-04 17:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8615, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:04:51', '2026-03-04 17:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8616, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:05:51', '2026-03-04 17:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8617, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:06:51', '2026-03-04 17:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8618, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:07:51', '2026-03-04 17:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8619, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:08:51', '2026-03-04 17:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8620, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:09:51', '2026-03-04 17:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8621, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:10:51', '2026-03-04 17:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8622, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:11:51', '2026-03-04 17:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8623, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:12:51', '2026-03-04 17:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8624, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:13:51', '2026-03-04 17:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8625, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:14:51', '2026-03-04 17:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8626, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:15:51', '2026-03-04 17:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8627, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:16:51', '2026-03-04 17:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8628, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:17:51', '2026-03-04 17:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8629, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:18:51', '2026-03-04 17:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8630, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:19:51', '2026-03-04 17:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8631, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:20:51', '2026-03-04 17:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8632, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:21:51', '2026-03-04 17:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8633, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:22:51', '2026-03-04 17:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8634, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:23:51', '2026-03-04 17:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8635, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:24:51', '2026-03-04 17:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8636, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:25:51', '2026-03-04 17:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8637, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:26:51', '2026-03-04 17:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8638, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:27:51', '2026-03-04 17:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8639, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:28:51', '2026-03-04 17:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8640, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:29:51', '2026-03-04 17:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8641, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:30:51', '2026-03-04 17:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8642, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:31:51', '2026-03-04 17:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8643, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:32:51', '2026-03-04 17:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8644, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:33:51', '2026-03-04 17:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8645, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:34:51', '2026-03-04 17:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8646, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:35:51', '2026-03-04 17:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8647, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:36:51', '2026-03-04 17:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8648, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:37:51', '2026-03-04 17:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8649, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:38:51', '2026-03-04 17:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8650, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:39:51', '2026-03-04 17:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8651, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:40:51', '2026-03-04 17:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8652, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:41:51', '2026-03-04 17:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8653, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:42:51', '2026-03-04 17:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8654, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:43:51', '2026-03-04 17:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8655, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:44:51', '2026-03-04 17:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8656, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:45:51', '2026-03-04 17:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8657, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:46:51', '2026-03-04 17:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8658, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:47:51', '2026-03-04 17:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8659, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:48:51', '2026-03-04 17:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8660, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:49:51', '2026-03-04 17:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8661, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:50:51', '2026-03-04 17:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8662, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:51:51', '2026-03-04 17:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8663, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:52:51', '2026-03-04 17:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8664, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:53:51', '2026-03-04 17:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8665, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:54:51', '2026-03-04 17:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8666, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:55:51', '2026-03-04 17:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8667, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:56:51', '2026-03-04 17:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8668, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:57:51', '2026-03-04 17:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8669, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:58:51', '2026-03-04 17:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8670, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 17:59:51', '2026-03-04 17:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8671, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:00:51', '2026-03-04 18:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8672, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:01:51', '2026-03-04 18:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8673, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:02:51', '2026-03-04 18:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8674, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:03:51', '2026-03-04 18:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8675, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:04:51', '2026-03-04 18:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8676, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:05:51', '2026-03-04 18:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8677, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:06:51', '2026-03-04 18:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8678, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:07:51', '2026-03-04 18:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8679, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:08:51', '2026-03-04 18:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8680, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:09:51', '2026-03-04 18:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8681, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:10:51', '2026-03-04 18:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8682, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:11:51', '2026-03-04 18:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8683, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:12:51', '2026-03-04 18:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8684, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:13:51', '2026-03-04 18:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8685, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:14:51', '2026-03-04 18:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8686, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:15:51', '2026-03-04 18:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8687, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:16:51', '2026-03-04 18:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8688, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:17:51', '2026-03-04 18:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8689, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:18:51', '2026-03-04 18:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8690, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:19:51', '2026-03-04 18:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8691, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:20:51', '2026-03-04 18:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8692, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:21:51', '2026-03-04 18:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8693, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:22:51', '2026-03-04 18:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8694, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:23:51', '2026-03-04 18:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8695, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:24:51', '2026-03-04 18:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8696, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:25:51', '2026-03-04 18:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8697, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:26:51', '2026-03-04 18:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8698, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:27:51', '2026-03-04 18:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8699, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:28:51', '2026-03-04 18:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8700, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:29:51', '2026-03-04 18:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8701, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:30:51', '2026-03-04 18:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8702, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:31:51', '2026-03-04 18:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8703, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:32:51', '2026-03-04 18:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8704, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:33:51', '2026-03-04 18:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8705, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:34:51', '2026-03-04 18:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8706, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:35:51', '2026-03-04 18:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8707, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:36:51', '2026-03-04 18:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8708, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:37:51', '2026-03-04 18:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8709, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:38:51', '2026-03-04 18:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8710, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:39:51', '2026-03-04 18:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8711, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:40:51', '2026-03-04 18:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8712, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:41:51', '2026-03-04 18:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8713, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:42:51', '2026-03-04 18:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8714, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:43:51', '2026-03-04 18:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8715, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:44:51', '2026-03-04 18:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8716, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:45:51', '2026-03-04 18:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8717, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:46:52', '2026-03-04 18:46:52');
INSERT INTO `sj_job_task_batch` VALUES (8718, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:47:51', '2026-03-04 18:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8719, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:48:51', '2026-03-04 18:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8720, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:49:51', '2026-03-04 18:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8721, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:50:51', '2026-03-04 18:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8722, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:51:51', '2026-03-04 18:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8723, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:52:51', '2026-03-04 18:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8724, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:53:51', '2026-03-04 18:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8725, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:54:51', '2026-03-04 18:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8726, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:55:51', '2026-03-04 18:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8727, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:56:51', '2026-03-04 18:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8728, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:57:51', '2026-03-04 18:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8729, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:58:51', '2026-03-04 18:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8730, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 18:59:51', '2026-03-04 18:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8731, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:00:51', '2026-03-04 19:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8732, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:01:51', '2026-03-04 19:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8733, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:02:51', '2026-03-04 19:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8734, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:03:51', '2026-03-04 19:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8735, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:04:51', '2026-03-04 19:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8736, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:05:51', '2026-03-04 19:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8737, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:06:51', '2026-03-04 19:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8738, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:07:51', '2026-03-04 19:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8739, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:08:51', '2026-03-04 19:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8740, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:09:51', '2026-03-04 19:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8741, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:10:51', '2026-03-04 19:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8742, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:11:51', '2026-03-04 19:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8743, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:12:51', '2026-03-04 19:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8744, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:13:51', '2026-03-04 19:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8745, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:14:51', '2026-03-04 19:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8746, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:15:51', '2026-03-04 19:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8747, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:16:51', '2026-03-04 19:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8748, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:17:51', '2026-03-04 19:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8749, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:18:51', '2026-03-04 19:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8750, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:19:51', '2026-03-04 19:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8751, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:20:51', '2026-03-04 19:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8752, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:21:51', '2026-03-04 19:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8753, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:22:51', '2026-03-04 19:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8754, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:23:51', '2026-03-04 19:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8755, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:24:51', '2026-03-04 19:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8756, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:25:51', '2026-03-04 19:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8757, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:26:51', '2026-03-04 19:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8758, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:27:51', '2026-03-04 19:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8759, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:28:51', '2026-03-04 19:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8760, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:29:51', '2026-03-04 19:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8761, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:30:51', '2026-03-04 19:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8762, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:31:51', '2026-03-04 19:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8763, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:32:51', '2026-03-04 19:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8764, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:33:51', '2026-03-04 19:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8765, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:34:51', '2026-03-04 19:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8766, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:35:51', '2026-03-04 19:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8767, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:36:51', '2026-03-04 19:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8768, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:37:51', '2026-03-04 19:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8769, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:38:51', '2026-03-04 19:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8770, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:39:51', '2026-03-04 19:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8771, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:40:51', '2026-03-04 19:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8772, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:41:51', '2026-03-04 19:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8773, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:42:51', '2026-03-04 19:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8774, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:43:51', '2026-03-04 19:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8775, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:44:51', '2026-03-04 19:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8776, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:45:51', '2026-03-04 19:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8777, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:46:51', '2026-03-04 19:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8778, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:47:51', '2026-03-04 19:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8779, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:48:51', '2026-03-04 19:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8780, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:49:51', '2026-03-04 19:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8781, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:50:51', '2026-03-04 19:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8782, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:51:51', '2026-03-04 19:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8783, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:52:51', '2026-03-04 19:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8784, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:53:51', '2026-03-04 19:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8785, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:54:51', '2026-03-04 19:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8786, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:55:51', '2026-03-04 19:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8787, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:56:51', '2026-03-04 19:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8788, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:57:51', '2026-03-04 19:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8789, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:58:51', '2026-03-04 19:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8790, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 19:59:51', '2026-03-04 19:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8791, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:00:51', '2026-03-04 20:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8792, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:01:51', '2026-03-04 20:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8793, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:02:51', '2026-03-04 20:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8794, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:03:51', '2026-03-04 20:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8795, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:04:51', '2026-03-04 20:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8796, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:05:51', '2026-03-04 20:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8797, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:06:51', '2026-03-04 20:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8798, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:07:51', '2026-03-04 20:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8799, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:08:51', '2026-03-04 20:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8800, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:09:51', '2026-03-04 20:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8801, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:10:51', '2026-03-04 20:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8802, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:11:51', '2026-03-04 20:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8803, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:12:51', '2026-03-04 20:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8804, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:13:51', '2026-03-04 20:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8805, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:14:51', '2026-03-04 20:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8806, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:15:51', '2026-03-04 20:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8807, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:16:51', '2026-03-04 20:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8808, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:17:51', '2026-03-04 20:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8809, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:18:51', '2026-03-04 20:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8810, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:19:51', '2026-03-04 20:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8811, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:20:51', '2026-03-04 20:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8812, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:21:51', '2026-03-04 20:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8813, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:22:51', '2026-03-04 20:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8814, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:23:51', '2026-03-04 20:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8815, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:24:51', '2026-03-04 20:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8816, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:25:51', '2026-03-04 20:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8817, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:26:51', '2026-03-04 20:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8818, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:27:51', '2026-03-04 20:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8819, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:28:51', '2026-03-04 20:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8820, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:29:51', '2026-03-04 20:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8821, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:30:51', '2026-03-04 20:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8822, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:31:51', '2026-03-04 20:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8823, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:32:51', '2026-03-04 20:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8824, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:33:51', '2026-03-04 20:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8825, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:34:51', '2026-03-04 20:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8826, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:35:51', '2026-03-04 20:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8827, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:36:51', '2026-03-04 20:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8828, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:37:51', '2026-03-04 20:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8829, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:38:51', '2026-03-04 20:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8830, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:39:51', '2026-03-04 20:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8831, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:40:51', '2026-03-04 20:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8832, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:41:51', '2026-03-04 20:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8833, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:42:51', '2026-03-04 20:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8834, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:43:51', '2026-03-04 20:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8835, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:44:51', '2026-03-04 20:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8836, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:45:51', '2026-03-04 20:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8837, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:46:51', '2026-03-04 20:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8838, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:47:51', '2026-03-04 20:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8839, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:48:51', '2026-03-04 20:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8840, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:49:51', '2026-03-04 20:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8841, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:50:51', '2026-03-04 20:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8842, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:51:51', '2026-03-04 20:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8843, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:52:51', '2026-03-04 20:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8844, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:53:51', '2026-03-04 20:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8845, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:54:51', '2026-03-04 20:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8846, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:55:51', '2026-03-04 20:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8847, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:56:51', '2026-03-04 20:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8848, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:57:51', '2026-03-04 20:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8849, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:58:51', '2026-03-04 20:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8850, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 20:59:51', '2026-03-04 20:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8851, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:00:51', '2026-03-04 21:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8852, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:01:51', '2026-03-04 21:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8853, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:02:51', '2026-03-04 21:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8854, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:03:51', '2026-03-04 21:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8855, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:04:51', '2026-03-04 21:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8856, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:05:51', '2026-03-04 21:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8857, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:06:51', '2026-03-04 21:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8858, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:07:51', '2026-03-04 21:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8859, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:08:51', '2026-03-04 21:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8860, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:09:51', '2026-03-04 21:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8861, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:10:51', '2026-03-04 21:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8862, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:11:51', '2026-03-04 21:11:51');
INSERT INTO `sj_job_task_batch` VALUES (8863, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:12:51', '2026-03-04 21:12:51');
INSERT INTO `sj_job_task_batch` VALUES (8864, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:13:51', '2026-03-04 21:13:51');
INSERT INTO `sj_job_task_batch` VALUES (8865, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:14:51', '2026-03-04 21:14:51');
INSERT INTO `sj_job_task_batch` VALUES (8866, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:15:51', '2026-03-04 21:15:51');
INSERT INTO `sj_job_task_batch` VALUES (8867, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:16:51', '2026-03-04 21:16:51');
INSERT INTO `sj_job_task_batch` VALUES (8868, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:17:51', '2026-03-04 21:17:51');
INSERT INTO `sj_job_task_batch` VALUES (8869, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:18:51', '2026-03-04 21:18:51');
INSERT INTO `sj_job_task_batch` VALUES (8870, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:19:51', '2026-03-04 21:19:51');
INSERT INTO `sj_job_task_batch` VALUES (8871, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:20:51', '2026-03-04 21:20:51');
INSERT INTO `sj_job_task_batch` VALUES (8872, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:21:51', '2026-03-04 21:21:51');
INSERT INTO `sj_job_task_batch` VALUES (8873, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:22:51', '2026-03-04 21:22:51');
INSERT INTO `sj_job_task_batch` VALUES (8874, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:23:51', '2026-03-04 21:23:51');
INSERT INTO `sj_job_task_batch` VALUES (8875, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:24:51', '2026-03-04 21:24:51');
INSERT INTO `sj_job_task_batch` VALUES (8876, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:25:51', '2026-03-04 21:25:51');
INSERT INTO `sj_job_task_batch` VALUES (8877, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:26:51', '2026-03-04 21:26:51');
INSERT INTO `sj_job_task_batch` VALUES (8878, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:27:51', '2026-03-04 21:27:51');
INSERT INTO `sj_job_task_batch` VALUES (8879, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:28:51', '2026-03-04 21:28:51');
INSERT INTO `sj_job_task_batch` VALUES (8880, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:29:51', '2026-03-04 21:29:51');
INSERT INTO `sj_job_task_batch` VALUES (8881, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:30:51', '2026-03-04 21:30:51');
INSERT INTO `sj_job_task_batch` VALUES (8882, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:31:51', '2026-03-04 21:31:51');
INSERT INTO `sj_job_task_batch` VALUES (8883, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:32:51', '2026-03-04 21:32:51');
INSERT INTO `sj_job_task_batch` VALUES (8884, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:33:51', '2026-03-04 21:33:51');
INSERT INTO `sj_job_task_batch` VALUES (8885, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:34:51', '2026-03-04 21:34:51');
INSERT INTO `sj_job_task_batch` VALUES (8886, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:35:51', '2026-03-04 21:35:51');
INSERT INTO `sj_job_task_batch` VALUES (8887, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:36:51', '2026-03-04 21:36:51');
INSERT INTO `sj_job_task_batch` VALUES (8888, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:37:51', '2026-03-04 21:37:51');
INSERT INTO `sj_job_task_batch` VALUES (8889, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:38:51', '2026-03-04 21:38:51');
INSERT INTO `sj_job_task_batch` VALUES (8890, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:39:51', '2026-03-04 21:39:51');
INSERT INTO `sj_job_task_batch` VALUES (8891, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:40:51', '2026-03-04 21:40:51');
INSERT INTO `sj_job_task_batch` VALUES (8892, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:41:51', '2026-03-04 21:41:51');
INSERT INTO `sj_job_task_batch` VALUES (8893, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:42:51', '2026-03-04 21:42:51');
INSERT INTO `sj_job_task_batch` VALUES (8894, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:43:51', '2026-03-04 21:43:51');
INSERT INTO `sj_job_task_batch` VALUES (8895, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:44:51', '2026-03-04 21:44:51');
INSERT INTO `sj_job_task_batch` VALUES (8896, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:45:51', '2026-03-04 21:45:51');
INSERT INTO `sj_job_task_batch` VALUES (8897, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:46:51', '2026-03-04 21:46:51');
INSERT INTO `sj_job_task_batch` VALUES (8898, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:47:51', '2026-03-04 21:47:51');
INSERT INTO `sj_job_task_batch` VALUES (8899, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:48:51', '2026-03-04 21:48:51');
INSERT INTO `sj_job_task_batch` VALUES (8900, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:49:51', '2026-03-04 21:49:51');
INSERT INTO `sj_job_task_batch` VALUES (8901, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:50:51', '2026-03-04 21:50:51');
INSERT INTO `sj_job_task_batch` VALUES (8902, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:51:51', '2026-03-04 21:51:51');
INSERT INTO `sj_job_task_batch` VALUES (8903, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:52:51', '2026-03-04 21:52:51');
INSERT INTO `sj_job_task_batch` VALUES (8904, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:53:51', '2026-03-04 21:53:51');
INSERT INTO `sj_job_task_batch` VALUES (8905, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:54:51', '2026-03-04 21:54:51');
INSERT INTO `sj_job_task_batch` VALUES (8906, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:55:51', '2026-03-04 21:55:51');
INSERT INTO `sj_job_task_batch` VALUES (8907, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:56:51', '2026-03-04 21:56:51');
INSERT INTO `sj_job_task_batch` VALUES (8908, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:57:51', '2026-03-04 21:57:51');
INSERT INTO `sj_job_task_batch` VALUES (8909, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:58:51', '2026-03-04 21:58:51');
INSERT INTO `sj_job_task_batch` VALUES (8910, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 21:59:51', '2026-03-04 21:59:51');
INSERT INTO `sj_job_task_batch` VALUES (8911, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:00:51', '2026-03-04 22:00:51');
INSERT INTO `sj_job_task_batch` VALUES (8912, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:01:51', '2026-03-04 22:01:51');
INSERT INTO `sj_job_task_batch` VALUES (8913, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:02:51', '2026-03-04 22:02:51');
INSERT INTO `sj_job_task_batch` VALUES (8914, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:03:51', '2026-03-04 22:03:51');
INSERT INTO `sj_job_task_batch` VALUES (8915, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:04:51', '2026-03-04 22:04:51');
INSERT INTO `sj_job_task_batch` VALUES (8916, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:05:51', '2026-03-04 22:05:51');
INSERT INTO `sj_job_task_batch` VALUES (8917, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:06:51', '2026-03-04 22:06:51');
INSERT INTO `sj_job_task_batch` VALUES (8918, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:07:51', '2026-03-04 22:07:51');
INSERT INTO `sj_job_task_batch` VALUES (8919, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:08:51', '2026-03-04 22:08:51');
INSERT INTO `sj_job_task_batch` VALUES (8920, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:09:51', '2026-03-04 22:09:51');
INSERT INTO `sj_job_task_batch` VALUES (8921, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-04 22:10:51', '2026-03-04 22:10:51');
INSERT INTO `sj_job_task_batch` VALUES (8922, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:40:28', '2026-03-05 12:40:28');
INSERT INTO `sj_job_task_batch` VALUES (8923, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:41:28', '2026-03-05 12:41:28');
INSERT INTO `sj_job_task_batch` VALUES (8924, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:42:28', '2026-03-05 12:42:28');
INSERT INTO `sj_job_task_batch` VALUES (8925, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:43:28', '2026-03-05 12:43:28');
INSERT INTO `sj_job_task_batch` VALUES (8926, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:44:28', '2026-03-05 12:44:28');
INSERT INTO `sj_job_task_batch` VALUES (8927, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:45:28', '2026-03-05 12:45:28');
INSERT INTO `sj_job_task_batch` VALUES (8928, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:46:28', '2026-03-05 12:46:28');
INSERT INTO `sj_job_task_batch` VALUES (8929, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:47:28', '2026-03-05 12:47:28');
INSERT INTO `sj_job_task_batch` VALUES (8930, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:48:28', '2026-03-05 12:48:28');
INSERT INTO `sj_job_task_batch` VALUES (8931, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:49:28', '2026-03-05 12:49:28');
INSERT INTO `sj_job_task_batch` VALUES (8932, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:50:28', '2026-03-05 12:50:28');
INSERT INTO `sj_job_task_batch` VALUES (8933, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:51:28', '2026-03-05 12:51:28');
INSERT INTO `sj_job_task_batch` VALUES (8934, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:52:28', '2026-03-05 12:52:28');
INSERT INTO `sj_job_task_batch` VALUES (8935, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:53:28', '2026-03-05 12:53:28');
INSERT INTO `sj_job_task_batch` VALUES (8936, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:54:28', '2026-03-05 12:54:28');
INSERT INTO `sj_job_task_batch` VALUES (8937, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:55:28', '2026-03-05 12:55:28');
INSERT INTO `sj_job_task_batch` VALUES (8938, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:56:28', '2026-03-05 12:56:28');
INSERT INTO `sj_job_task_batch` VALUES (8939, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:57:28', '2026-03-05 12:57:28');
INSERT INTO `sj_job_task_batch` VALUES (8940, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:58:28', '2026-03-05 12:58:28');
INSERT INTO `sj_job_task_batch` VALUES (8941, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 12:59:28', '2026-03-05 12:59:28');
INSERT INTO `sj_job_task_batch` VALUES (8942, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:00:28', '2026-03-05 13:00:28');
INSERT INTO `sj_job_task_batch` VALUES (8943, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:01:28', '2026-03-05 13:01:28');
INSERT INTO `sj_job_task_batch` VALUES (8944, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:02:28', '2026-03-05 13:02:28');
INSERT INTO `sj_job_task_batch` VALUES (8945, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:03:28', '2026-03-05 13:03:28');
INSERT INTO `sj_job_task_batch` VALUES (8946, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:04:28', '2026-03-05 13:04:28');
INSERT INTO `sj_job_task_batch` VALUES (8947, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:05:28', '2026-03-05 13:05:28');
INSERT INTO `sj_job_task_batch` VALUES (8948, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:06:28', '2026-03-05 13:06:28');
INSERT INTO `sj_job_task_batch` VALUES (8949, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:07:28', '2026-03-05 13:07:28');
INSERT INTO `sj_job_task_batch` VALUES (8950, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:08:28', '2026-03-05 13:08:28');
INSERT INTO `sj_job_task_batch` VALUES (8951, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:09:28', '2026-03-05 13:09:28');
INSERT INTO `sj_job_task_batch` VALUES (8952, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:10:28', '2026-03-05 13:10:28');
INSERT INTO `sj_job_task_batch` VALUES (8953, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:11:28', '2026-03-05 13:11:28');
INSERT INTO `sj_job_task_batch` VALUES (8954, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:12:28', '2026-03-05 13:12:28');
INSERT INTO `sj_job_task_batch` VALUES (8955, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:13:28', '2026-03-05 13:13:28');
INSERT INTO `sj_job_task_batch` VALUES (8956, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:14:28', '2026-03-05 13:14:28');
INSERT INTO `sj_job_task_batch` VALUES (8957, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:15:28', '2026-03-05 13:15:28');
INSERT INTO `sj_job_task_batch` VALUES (8958, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:16:28', '2026-03-05 13:16:28');
INSERT INTO `sj_job_task_batch` VALUES (8959, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:17:28', '2026-03-05 13:17:28');
INSERT INTO `sj_job_task_batch` VALUES (8960, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:18:28', '2026-03-05 13:18:28');
INSERT INTO `sj_job_task_batch` VALUES (8961, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:19:28', '2026-03-05 13:19:28');
INSERT INTO `sj_job_task_batch` VALUES (8962, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:20:28', '2026-03-05 13:20:28');
INSERT INTO `sj_job_task_batch` VALUES (8963, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:21:28', '2026-03-05 13:21:28');
INSERT INTO `sj_job_task_batch` VALUES (8964, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:22:28', '2026-03-05 13:22:28');
INSERT INTO `sj_job_task_batch` VALUES (8965, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:23:28', '2026-03-05 13:23:28');
INSERT INTO `sj_job_task_batch` VALUES (8966, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:24:28', '2026-03-05 13:24:28');
INSERT INTO `sj_job_task_batch` VALUES (8967, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:25:28', '2026-03-05 13:25:28');
INSERT INTO `sj_job_task_batch` VALUES (8968, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:26:28', '2026-03-05 13:26:28');
INSERT INTO `sj_job_task_batch` VALUES (8969, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:27:28', '2026-03-05 13:27:28');
INSERT INTO `sj_job_task_batch` VALUES (8970, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:28:28', '2026-03-05 13:28:28');
INSERT INTO `sj_job_task_batch` VALUES (8971, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:29:28', '2026-03-05 13:29:28');
INSERT INTO `sj_job_task_batch` VALUES (8972, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:30:28', '2026-03-05 13:30:28');
INSERT INTO `sj_job_task_batch` VALUES (8973, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:31:28', '2026-03-05 13:31:28');
INSERT INTO `sj_job_task_batch` VALUES (8974, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:32:28', '2026-03-05 13:32:28');
INSERT INTO `sj_job_task_batch` VALUES (8975, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:33:28', '2026-03-05 13:33:28');
INSERT INTO `sj_job_task_batch` VALUES (8976, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:34:28', '2026-03-05 13:34:28');
INSERT INTO `sj_job_task_batch` VALUES (8977, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:35:28', '2026-03-05 13:35:28');
INSERT INTO `sj_job_task_batch` VALUES (8978, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:36:28', '2026-03-05 13:36:28');
INSERT INTO `sj_job_task_batch` VALUES (8979, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:37:28', '2026-03-05 13:37:28');
INSERT INTO `sj_job_task_batch` VALUES (8980, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:38:28', '2026-03-05 13:38:28');
INSERT INTO `sj_job_task_batch` VALUES (8981, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:39:28', '2026-03-05 13:39:28');
INSERT INTO `sj_job_task_batch` VALUES (8982, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:40:28', '2026-03-05 13:40:28');
INSERT INTO `sj_job_task_batch` VALUES (8983, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:41:28', '2026-03-05 13:41:28');
INSERT INTO `sj_job_task_batch` VALUES (8984, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:42:28', '2026-03-05 13:42:28');
INSERT INTO `sj_job_task_batch` VALUES (8985, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:43:28', '2026-03-05 13:43:28');
INSERT INTO `sj_job_task_batch` VALUES (8986, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:44:28', '2026-03-05 13:44:28');
INSERT INTO `sj_job_task_batch` VALUES (8987, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:45:28', '2026-03-05 13:45:28');
INSERT INTO `sj_job_task_batch` VALUES (8988, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:46:28', '2026-03-05 13:46:28');
INSERT INTO `sj_job_task_batch` VALUES (8989, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:47:28', '2026-03-05 13:47:28');
INSERT INTO `sj_job_task_batch` VALUES (8990, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:48:28', '2026-03-05 13:48:28');
INSERT INTO `sj_job_task_batch` VALUES (8991, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:49:28', '2026-03-05 13:49:28');
INSERT INTO `sj_job_task_batch` VALUES (8992, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:50:28', '2026-03-05 13:50:28');
INSERT INTO `sj_job_task_batch` VALUES (8993, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:51:28', '2026-03-05 13:51:28');
INSERT INTO `sj_job_task_batch` VALUES (8994, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:52:28', '2026-03-05 13:52:28');
INSERT INTO `sj_job_task_batch` VALUES (8995, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:53:28', '2026-03-05 13:53:28');
INSERT INTO `sj_job_task_batch` VALUES (8996, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:54:28', '2026-03-05 13:54:28');
INSERT INTO `sj_job_task_batch` VALUES (8997, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:55:28', '2026-03-05 13:55:28');
INSERT INTO `sj_job_task_batch` VALUES (8998, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:56:28', '2026-03-05 13:56:28');
INSERT INTO `sj_job_task_batch` VALUES (8999, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:57:28', '2026-03-05 13:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9000, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:58:28', '2026-03-05 13:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9001, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 13:59:28', '2026-03-05 13:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9002, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:00:28', '2026-03-05 14:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9003, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:01:28', '2026-03-05 14:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9004, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:02:28', '2026-03-05 14:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9005, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:03:28', '2026-03-05 14:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9006, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:04:28', '2026-03-05 14:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9007, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:05:28', '2026-03-05 14:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9008, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:06:28', '2026-03-05 14:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9009, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:07:28', '2026-03-05 14:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9010, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:08:28', '2026-03-05 14:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9011, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:09:28', '2026-03-05 14:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9012, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:10:28', '2026-03-05 14:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9013, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:11:28', '2026-03-05 14:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9014, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:12:28', '2026-03-05 14:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9015, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:13:28', '2026-03-05 14:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9016, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:14:28', '2026-03-05 14:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9017, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:15:28', '2026-03-05 14:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9018, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:16:28', '2026-03-05 14:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9019, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:17:28', '2026-03-05 14:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9020, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:18:28', '2026-03-05 14:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9021, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:19:28', '2026-03-05 14:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9022, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:20:28', '2026-03-05 14:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9023, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:21:28', '2026-03-05 14:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9024, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:22:28', '2026-03-05 14:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9025, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:23:28', '2026-03-05 14:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9026, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:24:28', '2026-03-05 14:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9027, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:25:28', '2026-03-05 14:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9028, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:26:28', '2026-03-05 14:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9029, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:27:28', '2026-03-05 14:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9030, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:28:28', '2026-03-05 14:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9031, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:29:28', '2026-03-05 14:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9032, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:30:28', '2026-03-05 14:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9033, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:31:28', '2026-03-05 14:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9034, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:32:28', '2026-03-05 14:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9035, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:33:28', '2026-03-05 14:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9036, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:34:28', '2026-03-05 14:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9037, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:35:28', '2026-03-05 14:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9038, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:36:28', '2026-03-05 14:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9039, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:37:28', '2026-03-05 14:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9040, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:38:28', '2026-03-05 14:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9041, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:39:28', '2026-03-05 14:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9042, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:40:28', '2026-03-05 14:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9043, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:41:28', '2026-03-05 14:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9044, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:42:28', '2026-03-05 14:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9045, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:43:28', '2026-03-05 14:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9046, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:44:28', '2026-03-05 14:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9047, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:45:28', '2026-03-05 14:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9048, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:46:28', '2026-03-05 14:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9049, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:47:28', '2026-03-05 14:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9050, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:48:28', '2026-03-05 14:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9051, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:49:28', '2026-03-05 14:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9052, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:50:28', '2026-03-05 14:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9053, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:51:28', '2026-03-05 14:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9054, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:52:28', '2026-03-05 14:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9055, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:53:28', '2026-03-05 14:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9056, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:54:28', '2026-03-05 14:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9057, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:55:28', '2026-03-05 14:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9058, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:56:28', '2026-03-05 14:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9059, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:57:28', '2026-03-05 14:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9060, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:58:28', '2026-03-05 14:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9061, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 14:59:28', '2026-03-05 14:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9062, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:00:28', '2026-03-05 15:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9063, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:01:28', '2026-03-05 15:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9064, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:02:28', '2026-03-05 15:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9065, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:03:28', '2026-03-05 15:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9066, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:04:28', '2026-03-05 15:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9067, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:05:28', '2026-03-05 15:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9068, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:06:28', '2026-03-05 15:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9069, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:07:28', '2026-03-05 15:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9070, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:08:28', '2026-03-05 15:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9071, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:09:28', '2026-03-05 15:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9072, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:10:28', '2026-03-05 15:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9073, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:11:28', '2026-03-05 15:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9074, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:12:28', '2026-03-05 15:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9075, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:13:28', '2026-03-05 15:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9076, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:14:28', '2026-03-05 15:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9077, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:15:28', '2026-03-05 15:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9078, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:16:28', '2026-03-05 15:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9079, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:17:28', '2026-03-05 15:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9080, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:18:28', '2026-03-05 15:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9081, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:19:28', '2026-03-05 15:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9082, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:20:28', '2026-03-05 15:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9083, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:21:28', '2026-03-05 15:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9084, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:22:28', '2026-03-05 15:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9085, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:23:28', '2026-03-05 15:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9086, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:24:28', '2026-03-05 15:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9087, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:25:28', '2026-03-05 15:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9088, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:26:28', '2026-03-05 15:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9089, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:27:28', '2026-03-05 15:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9090, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:28:28', '2026-03-05 15:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9091, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:29:28', '2026-03-05 15:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9092, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:30:28', '2026-03-05 15:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9093, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:31:28', '2026-03-05 15:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9094, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:32:28', '2026-03-05 15:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9095, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:33:28', '2026-03-05 15:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9096, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:34:28', '2026-03-05 15:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9097, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:35:28', '2026-03-05 15:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9098, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:36:28', '2026-03-05 15:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9099, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:37:28', '2026-03-05 15:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9100, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:38:28', '2026-03-05 15:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9101, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:39:28', '2026-03-05 15:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9102, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:40:28', '2026-03-05 15:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9103, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:41:28', '2026-03-05 15:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9104, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:42:28', '2026-03-05 15:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9105, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:43:28', '2026-03-05 15:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9106, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:44:28', '2026-03-05 15:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9107, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:45:28', '2026-03-05 15:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9108, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:46:28', '2026-03-05 15:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9109, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:47:28', '2026-03-05 15:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9110, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:48:28', '2026-03-05 15:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9111, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:49:28', '2026-03-05 15:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9112, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:50:28', '2026-03-05 15:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9113, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:51:28', '2026-03-05 15:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9114, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:52:28', '2026-03-05 15:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9115, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:53:28', '2026-03-05 15:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9116, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:54:28', '2026-03-05 15:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9117, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:55:28', '2026-03-05 15:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9118, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:56:28', '2026-03-05 15:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9119, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:57:28', '2026-03-05 15:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9120, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:58:28', '2026-03-05 15:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9121, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 15:59:28', '2026-03-05 15:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9122, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:00:28', '2026-03-05 16:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9123, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:01:28', '2026-03-05 16:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9124, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:02:28', '2026-03-05 16:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9125, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:03:28', '2026-03-05 16:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9126, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:04:28', '2026-03-05 16:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9127, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:05:28', '2026-03-05 16:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9128, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:06:28', '2026-03-05 16:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9129, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:07:28', '2026-03-05 16:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9130, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:08:28', '2026-03-05 16:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9131, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:09:28', '2026-03-05 16:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9132, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:10:28', '2026-03-05 16:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9133, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:11:28', '2026-03-05 16:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9134, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:12:28', '2026-03-05 16:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9135, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:13:28', '2026-03-05 16:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9136, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:14:28', '2026-03-05 16:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9137, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:15:28', '2026-03-05 16:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9138, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:16:28', '2026-03-05 16:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9139, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:17:28', '2026-03-05 16:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9140, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:18:28', '2026-03-05 16:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9141, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:19:28', '2026-03-05 16:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9142, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:20:28', '2026-03-05 16:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9143, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:21:28', '2026-03-05 16:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9144, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:22:28', '2026-03-05 16:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9145, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:23:28', '2026-03-05 16:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9146, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:24:28', '2026-03-05 16:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9147, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:25:28', '2026-03-05 16:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9148, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:26:28', '2026-03-05 16:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9149, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:27:28', '2026-03-05 16:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9150, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:28:28', '2026-03-05 16:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9151, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:29:28', '2026-03-05 16:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9152, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:30:28', '2026-03-05 16:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9153, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:31:28', '2026-03-05 16:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9154, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:32:28', '2026-03-05 16:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9155, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:33:28', '2026-03-05 16:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9156, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:34:28', '2026-03-05 16:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9157, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:35:28', '2026-03-05 16:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9158, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:36:28', '2026-03-05 16:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9159, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:37:28', '2026-03-05 16:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9160, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:38:28', '2026-03-05 16:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9161, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:39:28', '2026-03-05 16:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9162, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:40:28', '2026-03-05 16:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9163, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:41:28', '2026-03-05 16:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9164, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:42:28', '2026-03-05 16:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9165, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:43:28', '2026-03-05 16:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9166, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:44:28', '2026-03-05 16:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9167, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:45:28', '2026-03-05 16:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9168, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:46:28', '2026-03-05 16:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9169, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:47:28', '2026-03-05 16:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9170, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:48:28', '2026-03-05 16:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9171, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:49:28', '2026-03-05 16:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9172, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:50:28', '2026-03-05 16:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9173, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:51:28', '2026-03-05 16:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9174, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:52:28', '2026-03-05 16:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9175, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:53:28', '2026-03-05 16:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9176, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:54:28', '2026-03-05 16:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9177, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:55:28', '2026-03-05 16:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9178, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:56:28', '2026-03-05 16:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9179, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:57:28', '2026-03-05 16:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9180, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:58:28', '2026-03-05 16:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9181, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 16:59:28', '2026-03-05 16:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9182, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:00:28', '2026-03-05 17:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9183, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:01:28', '2026-03-05 17:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9184, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:02:28', '2026-03-05 17:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9185, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:03:28', '2026-03-05 17:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9186, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:04:28', '2026-03-05 17:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9187, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:05:28', '2026-03-05 17:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9188, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:06:28', '2026-03-05 17:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9189, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:07:28', '2026-03-05 17:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9190, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:08:28', '2026-03-05 17:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9191, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:09:28', '2026-03-05 17:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9192, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:10:28', '2026-03-05 17:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9193, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:11:28', '2026-03-05 17:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9194, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:12:28', '2026-03-05 17:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9195, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:13:28', '2026-03-05 17:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9196, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:14:28', '2026-03-05 17:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9197, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:15:28', '2026-03-05 17:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9198, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:16:28', '2026-03-05 17:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9199, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:17:28', '2026-03-05 17:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9200, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:18:28', '2026-03-05 17:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9201, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:19:28', '2026-03-05 17:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9202, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:20:28', '2026-03-05 17:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9203, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:21:28', '2026-03-05 17:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9204, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:22:28', '2026-03-05 17:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9205, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:23:28', '2026-03-05 17:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9206, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:24:28', '2026-03-05 17:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9207, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:25:28', '2026-03-05 17:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9208, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:26:28', '2026-03-05 17:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9209, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:27:28', '2026-03-05 17:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9210, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:28:28', '2026-03-05 17:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9211, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:29:28', '2026-03-05 17:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9212, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:30:28', '2026-03-05 17:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9213, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:31:28', '2026-03-05 17:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9214, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:32:28', '2026-03-05 17:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9215, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:33:28', '2026-03-05 17:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9216, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:34:28', '2026-03-05 17:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9217, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:35:28', '2026-03-05 17:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9218, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:36:28', '2026-03-05 17:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9219, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:37:28', '2026-03-05 17:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9220, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:38:28', '2026-03-05 17:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9221, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:39:28', '2026-03-05 17:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9222, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:40:28', '2026-03-05 17:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9223, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:41:28', '2026-03-05 17:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9224, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:42:28', '2026-03-05 17:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9225, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:43:28', '2026-03-05 17:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9226, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:44:28', '2026-03-05 17:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9227, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:45:28', '2026-03-05 17:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9228, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:46:28', '2026-03-05 17:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9229, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:47:28', '2026-03-05 17:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9230, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:48:28', '2026-03-05 17:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9231, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:49:28', '2026-03-05 17:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9232, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:50:28', '2026-03-05 17:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9233, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:51:28', '2026-03-05 17:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9234, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:52:28', '2026-03-05 17:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9235, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:53:28', '2026-03-05 17:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9236, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:54:28', '2026-03-05 17:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9237, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:55:28', '2026-03-05 17:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9238, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:56:28', '2026-03-05 17:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9239, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:57:28', '2026-03-05 17:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9240, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:58:28', '2026-03-05 17:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9241, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 17:59:28', '2026-03-05 17:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9242, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:00:28', '2026-03-05 18:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9243, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:01:28', '2026-03-05 18:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9244, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:02:28', '2026-03-05 18:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9245, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:03:28', '2026-03-05 18:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9246, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:04:28', '2026-03-05 18:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9247, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:05:28', '2026-03-05 18:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9248, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:06:28', '2026-03-05 18:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9249, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:07:28', '2026-03-05 18:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9250, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:08:28', '2026-03-05 18:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9251, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:09:28', '2026-03-05 18:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9252, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:10:28', '2026-03-05 18:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9253, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:11:28', '2026-03-05 18:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9254, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:12:28', '2026-03-05 18:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9255, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:13:28', '2026-03-05 18:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9256, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:14:28', '2026-03-05 18:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9257, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:15:28', '2026-03-05 18:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9258, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:16:28', '2026-03-05 18:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9259, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:17:28', '2026-03-05 18:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9260, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:18:28', '2026-03-05 18:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9261, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:19:28', '2026-03-05 18:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9262, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:20:28', '2026-03-05 18:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9263, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:21:28', '2026-03-05 18:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9264, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:22:28', '2026-03-05 18:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9265, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:23:28', '2026-03-05 18:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9266, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:24:28', '2026-03-05 18:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9267, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:25:28', '2026-03-05 18:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9268, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:26:28', '2026-03-05 18:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9269, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:27:28', '2026-03-05 18:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9270, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:28:28', '2026-03-05 18:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9271, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:29:28', '2026-03-05 18:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9272, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:30:28', '2026-03-05 18:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9273, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:31:28', '2026-03-05 18:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9274, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:32:28', '2026-03-05 18:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9275, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:33:28', '2026-03-05 18:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9276, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:34:28', '2026-03-05 18:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9277, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:35:28', '2026-03-05 18:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9278, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:36:28', '2026-03-05 18:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9279, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:37:28', '2026-03-05 18:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9280, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:38:28', '2026-03-05 18:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9281, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:39:28', '2026-03-05 18:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9282, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:40:28', '2026-03-05 18:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9283, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:41:28', '2026-03-05 18:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9284, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:42:28', '2026-03-05 18:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9285, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:43:28', '2026-03-05 18:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9286, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:44:28', '2026-03-05 18:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9287, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:45:28', '2026-03-05 18:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9288, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:46:28', '2026-03-05 18:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9289, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:47:28', '2026-03-05 18:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9290, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:48:28', '2026-03-05 18:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9291, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:49:28', '2026-03-05 18:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9292, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:50:28', '2026-03-05 18:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9293, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:51:28', '2026-03-05 18:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9294, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:52:28', '2026-03-05 18:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9295, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:53:28', '2026-03-05 18:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9296, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:54:28', '2026-03-05 18:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9297, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:55:28', '2026-03-05 18:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9298, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:56:28', '2026-03-05 18:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9299, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:57:28', '2026-03-05 18:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9300, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:58:28', '2026-03-05 18:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9301, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 18:59:28', '2026-03-05 18:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9302, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:00:28', '2026-03-05 19:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9303, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:01:28', '2026-03-05 19:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9304, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:02:28', '2026-03-05 19:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9305, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:03:28', '2026-03-05 19:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9306, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:04:28', '2026-03-05 19:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9307, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:05:28', '2026-03-05 19:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9308, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:06:28', '2026-03-05 19:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9309, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:07:28', '2026-03-05 19:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9310, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:08:28', '2026-03-05 19:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9311, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:09:28', '2026-03-05 19:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9312, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:10:28', '2026-03-05 19:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9313, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:11:28', '2026-03-05 19:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9314, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:12:28', '2026-03-05 19:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9315, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:13:28', '2026-03-05 19:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9316, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:14:28', '2026-03-05 19:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9317, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:15:28', '2026-03-05 19:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9318, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:16:28', '2026-03-05 19:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9319, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:17:28', '2026-03-05 19:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9320, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:18:28', '2026-03-05 19:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9321, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:19:28', '2026-03-05 19:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9322, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:20:28', '2026-03-05 19:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9323, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:21:28', '2026-03-05 19:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9324, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:22:28', '2026-03-05 19:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9325, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:23:28', '2026-03-05 19:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9326, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:24:28', '2026-03-05 19:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9327, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:25:28', '2026-03-05 19:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9328, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:26:28', '2026-03-05 19:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9329, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:27:28', '2026-03-05 19:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9330, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:28:28', '2026-03-05 19:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9331, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:29:28', '2026-03-05 19:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9332, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:30:28', '2026-03-05 19:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9333, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:31:28', '2026-03-05 19:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9334, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:32:28', '2026-03-05 19:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9335, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:33:28', '2026-03-05 19:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9336, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:34:28', '2026-03-05 19:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9337, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:35:28', '2026-03-05 19:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9338, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:36:28', '2026-03-05 19:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9339, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:37:28', '2026-03-05 19:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9340, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:38:28', '2026-03-05 19:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9341, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:39:28', '2026-03-05 19:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9342, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:40:28', '2026-03-05 19:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9343, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:41:28', '2026-03-05 19:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9344, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:42:28', '2026-03-05 19:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9345, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:43:28', '2026-03-05 19:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9346, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:44:28', '2026-03-05 19:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9347, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:45:28', '2026-03-05 19:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9348, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:46:28', '2026-03-05 19:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9349, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:47:28', '2026-03-05 19:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9350, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:48:28', '2026-03-05 19:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9351, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:49:28', '2026-03-05 19:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9352, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:50:28', '2026-03-05 19:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9353, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:51:28', '2026-03-05 19:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9354, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:52:28', '2026-03-05 19:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9355, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:53:28', '2026-03-05 19:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9356, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:54:28', '2026-03-05 19:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9357, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:55:28', '2026-03-05 19:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9358, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:56:28', '2026-03-05 19:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9359, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:57:28', '2026-03-05 19:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9360, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:58:28', '2026-03-05 19:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9361, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 19:59:28', '2026-03-05 19:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9362, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:00:28', '2026-03-05 20:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9363, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:01:28', '2026-03-05 20:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9364, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:02:28', '2026-03-05 20:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9365, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:03:28', '2026-03-05 20:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9366, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:04:28', '2026-03-05 20:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9367, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:05:28', '2026-03-05 20:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9368, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:06:28', '2026-03-05 20:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9369, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:07:28', '2026-03-05 20:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9370, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:08:28', '2026-03-05 20:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9371, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:09:28', '2026-03-05 20:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9372, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:10:28', '2026-03-05 20:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9373, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:11:28', '2026-03-05 20:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9374, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:12:28', '2026-03-05 20:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9375, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:13:28', '2026-03-05 20:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9376, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:14:28', '2026-03-05 20:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9377, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:15:28', '2026-03-05 20:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9378, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:16:28', '2026-03-05 20:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9379, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:17:28', '2026-03-05 20:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9380, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:18:28', '2026-03-05 20:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9381, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:19:28', '2026-03-05 20:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9382, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:20:28', '2026-03-05 20:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9383, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:21:28', '2026-03-05 20:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9384, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:22:28', '2026-03-05 20:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9385, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:23:28', '2026-03-05 20:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9386, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:24:28', '2026-03-05 20:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9387, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:25:28', '2026-03-05 20:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9388, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:26:28', '2026-03-05 20:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9389, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:27:28', '2026-03-05 20:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9390, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:28:28', '2026-03-05 20:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9391, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:29:28', '2026-03-05 20:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9392, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:30:28', '2026-03-05 20:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9393, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:31:28', '2026-03-05 20:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9394, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:32:28', '2026-03-05 20:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9395, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:33:28', '2026-03-05 20:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9396, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:34:28', '2026-03-05 20:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9397, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:35:28', '2026-03-05 20:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9398, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:36:28', '2026-03-05 20:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9399, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:37:28', '2026-03-05 20:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9400, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:38:28', '2026-03-05 20:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9401, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:39:28', '2026-03-05 20:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9402, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:40:28', '2026-03-05 20:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9403, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:41:28', '2026-03-05 20:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9404, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:42:28', '2026-03-05 20:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9405, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:43:28', '2026-03-05 20:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9406, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:44:28', '2026-03-05 20:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9407, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:45:28', '2026-03-05 20:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9408, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:46:28', '2026-03-05 20:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9409, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:47:28', '2026-03-05 20:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9410, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:48:28', '2026-03-05 20:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9411, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:49:28', '2026-03-05 20:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9412, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:50:28', '2026-03-05 20:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9413, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:51:28', '2026-03-05 20:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9414, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:52:28', '2026-03-05 20:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9415, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:53:28', '2026-03-05 20:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9416, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:54:28', '2026-03-05 20:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9417, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:55:28', '2026-03-05 20:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9418, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:56:28', '2026-03-05 20:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9419, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:57:28', '2026-03-05 20:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9420, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:58:28', '2026-03-05 20:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9421, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 20:59:28', '2026-03-05 20:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9422, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:00:28', '2026-03-05 21:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9423, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:01:28', '2026-03-05 21:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9424, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:02:28', '2026-03-05 21:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9425, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:03:28', '2026-03-05 21:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9426, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:04:28', '2026-03-05 21:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9427, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:05:28', '2026-03-05 21:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9428, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:06:28', '2026-03-05 21:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9429, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:07:28', '2026-03-05 21:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9430, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:08:28', '2026-03-05 21:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9431, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:09:28', '2026-03-05 21:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9432, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:10:28', '2026-03-05 21:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9433, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:11:28', '2026-03-05 21:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9434, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:12:28', '2026-03-05 21:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9435, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:13:28', '2026-03-05 21:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9436, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:14:28', '2026-03-05 21:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9437, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:15:28', '2026-03-05 21:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9438, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:16:28', '2026-03-05 21:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9439, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:17:28', '2026-03-05 21:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9440, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:18:28', '2026-03-05 21:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9441, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:19:28', '2026-03-05 21:19:28');
INSERT INTO `sj_job_task_batch` VALUES (9442, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:20:28', '2026-03-05 21:20:28');
INSERT INTO `sj_job_task_batch` VALUES (9443, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:21:28', '2026-03-05 21:21:28');
INSERT INTO `sj_job_task_batch` VALUES (9444, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:22:28', '2026-03-05 21:22:28');
INSERT INTO `sj_job_task_batch` VALUES (9445, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:23:28', '2026-03-05 21:23:28');
INSERT INTO `sj_job_task_batch` VALUES (9446, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:24:28', '2026-03-05 21:24:28');
INSERT INTO `sj_job_task_batch` VALUES (9447, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:25:28', '2026-03-05 21:25:28');
INSERT INTO `sj_job_task_batch` VALUES (9448, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:26:28', '2026-03-05 21:26:28');
INSERT INTO `sj_job_task_batch` VALUES (9449, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:27:28', '2026-03-05 21:27:28');
INSERT INTO `sj_job_task_batch` VALUES (9450, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:28:28', '2026-03-05 21:28:28');
INSERT INTO `sj_job_task_batch` VALUES (9451, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:29:28', '2026-03-05 21:29:28');
INSERT INTO `sj_job_task_batch` VALUES (9452, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:30:28', '2026-03-05 21:30:28');
INSERT INTO `sj_job_task_batch` VALUES (9453, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:31:28', '2026-03-05 21:31:28');
INSERT INTO `sj_job_task_batch` VALUES (9454, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:32:28', '2026-03-05 21:32:28');
INSERT INTO `sj_job_task_batch` VALUES (9455, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:33:28', '2026-03-05 21:33:28');
INSERT INTO `sj_job_task_batch` VALUES (9456, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:34:28', '2026-03-05 21:34:28');
INSERT INTO `sj_job_task_batch` VALUES (9457, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:35:28', '2026-03-05 21:35:28');
INSERT INTO `sj_job_task_batch` VALUES (9458, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:36:28', '2026-03-05 21:36:28');
INSERT INTO `sj_job_task_batch` VALUES (9459, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:37:28', '2026-03-05 21:37:28');
INSERT INTO `sj_job_task_batch` VALUES (9460, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:38:28', '2026-03-05 21:38:28');
INSERT INTO `sj_job_task_batch` VALUES (9461, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:39:28', '2026-03-05 21:39:28');
INSERT INTO `sj_job_task_batch` VALUES (9462, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:40:28', '2026-03-05 21:40:28');
INSERT INTO `sj_job_task_batch` VALUES (9463, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:41:28', '2026-03-05 21:41:28');
INSERT INTO `sj_job_task_batch` VALUES (9464, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:42:28', '2026-03-05 21:42:28');
INSERT INTO `sj_job_task_batch` VALUES (9465, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:43:28', '2026-03-05 21:43:28');
INSERT INTO `sj_job_task_batch` VALUES (9466, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:44:28', '2026-03-05 21:44:28');
INSERT INTO `sj_job_task_batch` VALUES (9467, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:45:28', '2026-03-05 21:45:28');
INSERT INTO `sj_job_task_batch` VALUES (9468, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:46:28', '2026-03-05 21:46:28');
INSERT INTO `sj_job_task_batch` VALUES (9469, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:47:28', '2026-03-05 21:47:28');
INSERT INTO `sj_job_task_batch` VALUES (9470, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:48:28', '2026-03-05 21:48:28');
INSERT INTO `sj_job_task_batch` VALUES (9471, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:49:28', '2026-03-05 21:49:28');
INSERT INTO `sj_job_task_batch` VALUES (9472, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:50:28', '2026-03-05 21:50:28');
INSERT INTO `sj_job_task_batch` VALUES (9473, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:51:28', '2026-03-05 21:51:28');
INSERT INTO `sj_job_task_batch` VALUES (9474, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:52:28', '2026-03-05 21:52:28');
INSERT INTO `sj_job_task_batch` VALUES (9475, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:53:28', '2026-03-05 21:53:28');
INSERT INTO `sj_job_task_batch` VALUES (9476, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:54:28', '2026-03-05 21:54:28');
INSERT INTO `sj_job_task_batch` VALUES (9477, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:55:28', '2026-03-05 21:55:28');
INSERT INTO `sj_job_task_batch` VALUES (9478, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:56:28', '2026-03-05 21:56:28');
INSERT INTO `sj_job_task_batch` VALUES (9479, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:57:28', '2026-03-05 21:57:28');
INSERT INTO `sj_job_task_batch` VALUES (9480, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:58:28', '2026-03-05 21:58:28');
INSERT INTO `sj_job_task_batch` VALUES (9481, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 21:59:28', '2026-03-05 21:59:28');
INSERT INTO `sj_job_task_batch` VALUES (9482, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:00:28', '2026-03-05 22:00:28');
INSERT INTO `sj_job_task_batch` VALUES (9483, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:01:28', '2026-03-05 22:01:28');
INSERT INTO `sj_job_task_batch` VALUES (9484, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:02:28', '2026-03-05 22:02:28');
INSERT INTO `sj_job_task_batch` VALUES (9485, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:03:28', '2026-03-05 22:03:28');
INSERT INTO `sj_job_task_batch` VALUES (9486, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:04:28', '2026-03-05 22:04:28');
INSERT INTO `sj_job_task_batch` VALUES (9487, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:05:28', '2026-03-05 22:05:28');
INSERT INTO `sj_job_task_batch` VALUES (9488, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:06:28', '2026-03-05 22:06:28');
INSERT INTO `sj_job_task_batch` VALUES (9489, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:07:28', '2026-03-05 22:07:28');
INSERT INTO `sj_job_task_batch` VALUES (9490, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:08:28', '2026-03-05 22:08:28');
INSERT INTO `sj_job_task_batch` VALUES (9491, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:09:28', '2026-03-05 22:09:28');
INSERT INTO `sj_job_task_batch` VALUES (9492, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:10:28', '2026-03-05 22:10:28');
INSERT INTO `sj_job_task_batch` VALUES (9493, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:11:28', '2026-03-05 22:11:28');
INSERT INTO `sj_job_task_batch` VALUES (9494, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:12:28', '2026-03-05 22:12:28');
INSERT INTO `sj_job_task_batch` VALUES (9495, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:13:28', '2026-03-05 22:13:28');
INSERT INTO `sj_job_task_batch` VALUES (9496, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:14:28', '2026-03-05 22:14:28');
INSERT INTO `sj_job_task_batch` VALUES (9497, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:15:28', '2026-03-05 22:15:28');
INSERT INTO `sj_job_task_batch` VALUES (9498, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:16:28', '2026-03-05 22:16:28');
INSERT INTO `sj_job_task_batch` VALUES (9499, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:17:28', '2026-03-05 22:17:28');
INSERT INTO `sj_job_task_batch` VALUES (9500, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-05 22:18:28', '2026-03-05 22:18:28');
INSERT INTO `sj_job_task_batch` VALUES (9501, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:51:30', '2026-03-06 14:51:30');
INSERT INTO `sj_job_task_batch` VALUES (9502, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:52:30', '2026-03-06 14:52:30');
INSERT INTO `sj_job_task_batch` VALUES (9503, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:53:30', '2026-03-06 14:53:30');
INSERT INTO `sj_job_task_batch` VALUES (9504, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:54:30', '2026-03-06 14:54:30');
INSERT INTO `sj_job_task_batch` VALUES (9505, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:55:30', '2026-03-06 14:55:30');
INSERT INTO `sj_job_task_batch` VALUES (9506, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:56:30', '2026-03-06 14:56:30');
INSERT INTO `sj_job_task_batch` VALUES (9507, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:57:30', '2026-03-06 14:57:30');
INSERT INTO `sj_job_task_batch` VALUES (9508, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:58:30', '2026-03-06 14:58:30');
INSERT INTO `sj_job_task_batch` VALUES (9509, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 14:59:30', '2026-03-06 14:59:30');
INSERT INTO `sj_job_task_batch` VALUES (9510, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:00:30', '2026-03-06 15:00:30');
INSERT INTO `sj_job_task_batch` VALUES (9511, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:01:30', '2026-03-06 15:01:30');
INSERT INTO `sj_job_task_batch` VALUES (9512, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:19:29', '2026-03-06 15:19:29');
INSERT INTO `sj_job_task_batch` VALUES (9513, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:20:29', '2026-03-06 15:20:29');
INSERT INTO `sj_job_task_batch` VALUES (9514, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:21:29', '2026-03-06 15:21:29');
INSERT INTO `sj_job_task_batch` VALUES (9515, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:22:29', '2026-03-06 15:22:29');
INSERT INTO `sj_job_task_batch` VALUES (9516, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:23:29', '2026-03-06 15:23:29');
INSERT INTO `sj_job_task_batch` VALUES (9517, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:24:29', '2026-03-06 15:24:29');
INSERT INTO `sj_job_task_batch` VALUES (9518, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:25:29', '2026-03-06 15:25:29');
INSERT INTO `sj_job_task_batch` VALUES (9519, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:26:29', '2026-03-06 15:26:29');
INSERT INTO `sj_job_task_batch` VALUES (9520, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:27:29', '2026-03-06 15:27:29');
INSERT INTO `sj_job_task_batch` VALUES (9521, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:28:29', '2026-03-06 15:28:29');
INSERT INTO `sj_job_task_batch` VALUES (9522, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:29:29', '2026-03-06 15:29:29');
INSERT INTO `sj_job_task_batch` VALUES (9523, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:30:29', '2026-03-06 15:30:29');
INSERT INTO `sj_job_task_batch` VALUES (9524, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:31:29', '2026-03-06 15:31:29');
INSERT INTO `sj_job_task_batch` VALUES (9525, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:32:29', '2026-03-06 15:32:29');
INSERT INTO `sj_job_task_batch` VALUES (9526, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:33:29', '2026-03-06 15:33:29');
INSERT INTO `sj_job_task_batch` VALUES (9527, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:34:29', '2026-03-06 15:34:29');
INSERT INTO `sj_job_task_batch` VALUES (9528, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:35:29', '2026-03-06 15:35:29');
INSERT INTO `sj_job_task_batch` VALUES (9529, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:36:29', '2026-03-06 15:36:29');
INSERT INTO `sj_job_task_batch` VALUES (9530, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:37:29', '2026-03-06 15:37:29');
INSERT INTO `sj_job_task_batch` VALUES (9531, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:38:29', '2026-03-06 15:38:29');
INSERT INTO `sj_job_task_batch` VALUES (9532, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:39:29', '2026-03-06 15:39:29');
INSERT INTO `sj_job_task_batch` VALUES (9533, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:40:29', '2026-03-06 15:40:29');
INSERT INTO `sj_job_task_batch` VALUES (9534, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:41:29', '2026-03-06 15:41:29');
INSERT INTO `sj_job_task_batch` VALUES (9535, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:42:29', '2026-03-06 15:42:29');
INSERT INTO `sj_job_task_batch` VALUES (9536, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:43:29', '2026-03-06 15:43:29');
INSERT INTO `sj_job_task_batch` VALUES (9537, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:44:29', '2026-03-06 15:44:29');
INSERT INTO `sj_job_task_batch` VALUES (9538, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:45:29', '2026-03-06 15:45:29');
INSERT INTO `sj_job_task_batch` VALUES (9539, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:46:29', '2026-03-06 15:46:29');
INSERT INTO `sj_job_task_batch` VALUES (9540, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:47:29', '2026-03-06 15:47:29');
INSERT INTO `sj_job_task_batch` VALUES (9541, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:48:29', '2026-03-06 15:48:29');
INSERT INTO `sj_job_task_batch` VALUES (9542, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:49:29', '2026-03-06 15:49:29');
INSERT INTO `sj_job_task_batch` VALUES (9543, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:50:29', '2026-03-06 15:50:29');
INSERT INTO `sj_job_task_batch` VALUES (9544, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:51:29', '2026-03-06 15:51:29');
INSERT INTO `sj_job_task_batch` VALUES (9545, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:52:29', '2026-03-06 15:52:29');
INSERT INTO `sj_job_task_batch` VALUES (9546, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:53:29', '2026-03-06 15:53:29');
INSERT INTO `sj_job_task_batch` VALUES (9547, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:54:29', '2026-03-06 15:54:29');
INSERT INTO `sj_job_task_batch` VALUES (9548, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:55:29', '2026-03-06 15:55:29');
INSERT INTO `sj_job_task_batch` VALUES (9549, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:56:29', '2026-03-06 15:56:29');
INSERT INTO `sj_job_task_batch` VALUES (9550, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:57:29', '2026-03-06 15:57:29');
INSERT INTO `sj_job_task_batch` VALUES (9551, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:58:29', '2026-03-06 15:58:29');
INSERT INTO `sj_job_task_batch` VALUES (9552, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 15:59:29', '2026-03-06 15:59:29');
INSERT INTO `sj_job_task_batch` VALUES (9553, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:17:07', '2026-03-06 16:17:07');
INSERT INTO `sj_job_task_batch` VALUES (9554, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:18:07', '2026-03-06 16:18:07');
INSERT INTO `sj_job_task_batch` VALUES (9555, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:19:07', '2026-03-06 16:19:07');
INSERT INTO `sj_job_task_batch` VALUES (9556, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:20:07', '2026-03-06 16:20:07');
INSERT INTO `sj_job_task_batch` VALUES (9557, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:21:07', '2026-03-06 16:21:07');
INSERT INTO `sj_job_task_batch` VALUES (9558, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:22:07', '2026-03-06 16:22:07');
INSERT INTO `sj_job_task_batch` VALUES (9559, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:23:07', '2026-03-06 16:23:07');
INSERT INTO `sj_job_task_batch` VALUES (9560, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:24:07', '2026-03-06 16:24:07');
INSERT INTO `sj_job_task_batch` VALUES (9561, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:25:07', '2026-03-06 16:25:07');
INSERT INTO `sj_job_task_batch` VALUES (9562, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:26:07', '2026-03-06 16:26:07');
INSERT INTO `sj_job_task_batch` VALUES (9563, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:27:07', '2026-03-06 16:27:07');
INSERT INTO `sj_job_task_batch` VALUES (9564, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:28:07', '2026-03-06 16:28:07');
INSERT INTO `sj_job_task_batch` VALUES (9565, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:29:07', '2026-03-06 16:29:07');
INSERT INTO `sj_job_task_batch` VALUES (9566, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:30:07', '2026-03-06 16:30:07');
INSERT INTO `sj_job_task_batch` VALUES (9567, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:31:07', '2026-03-06 16:31:07');
INSERT INTO `sj_job_task_batch` VALUES (9568, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:32:07', '2026-03-06 16:32:07');
INSERT INTO `sj_job_task_batch` VALUES (9569, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:33:07', '2026-03-06 16:33:07');
INSERT INTO `sj_job_task_batch` VALUES (9570, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:34:07', '2026-03-06 16:34:07');
INSERT INTO `sj_job_task_batch` VALUES (9571, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:35:07', '2026-03-06 16:35:07');
INSERT INTO `sj_job_task_batch` VALUES (9572, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:36:07', '2026-03-06 16:36:07');
INSERT INTO `sj_job_task_batch` VALUES (9573, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:37:07', '2026-03-06 16:37:07');
INSERT INTO `sj_job_task_batch` VALUES (9574, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:38:07', '2026-03-06 16:38:07');
INSERT INTO `sj_job_task_batch` VALUES (9575, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:39:07', '2026-03-06 16:39:07');
INSERT INTO `sj_job_task_batch` VALUES (9576, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:40:07', '2026-03-06 16:40:07');
INSERT INTO `sj_job_task_batch` VALUES (9577, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:41:07', '2026-03-06 16:41:07');
INSERT INTO `sj_job_task_batch` VALUES (9578, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:42:07', '2026-03-06 16:42:07');
INSERT INTO `sj_job_task_batch` VALUES (9579, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:43:07', '2026-03-06 16:43:07');
INSERT INTO `sj_job_task_batch` VALUES (9580, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:44:07', '2026-03-06 16:44:07');
INSERT INTO `sj_job_task_batch` VALUES (9581, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:45:07', '2026-03-06 16:45:07');
INSERT INTO `sj_job_task_batch` VALUES (9582, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:46:07', '2026-03-06 16:46:07');
INSERT INTO `sj_job_task_batch` VALUES (9583, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:47:07', '2026-03-06 16:47:07');
INSERT INTO `sj_job_task_batch` VALUES (9584, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:48:07', '2026-03-06 16:48:07');
INSERT INTO `sj_job_task_batch` VALUES (9585, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:49:07', '2026-03-06 16:49:07');
INSERT INTO `sj_job_task_batch` VALUES (9586, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:50:07', '2026-03-06 16:50:07');
INSERT INTO `sj_job_task_batch` VALUES (9587, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:51:07', '2026-03-06 16:51:07');
INSERT INTO `sj_job_task_batch` VALUES (9588, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:52:07', '2026-03-06 16:52:07');
INSERT INTO `sj_job_task_batch` VALUES (9589, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:53:07', '2026-03-06 16:53:07');
INSERT INTO `sj_job_task_batch` VALUES (9590, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:54:07', '2026-03-06 16:54:07');
INSERT INTO `sj_job_task_batch` VALUES (9591, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:55:07', '2026-03-06 16:55:07');
INSERT INTO `sj_job_task_batch` VALUES (9592, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:56:07', '2026-03-06 16:56:07');
INSERT INTO `sj_job_task_batch` VALUES (9593, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:57:07', '2026-03-06 16:57:07');
INSERT INTO `sj_job_task_batch` VALUES (9594, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:58:07', '2026-03-06 16:58:07');
INSERT INTO `sj_job_task_batch` VALUES (9595, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 16:59:07', '2026-03-06 16:59:07');
INSERT INTO `sj_job_task_batch` VALUES (9596, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:00:07', '2026-03-06 17:00:07');
INSERT INTO `sj_job_task_batch` VALUES (9597, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:01:07', '2026-03-06 17:01:07');
INSERT INTO `sj_job_task_batch` VALUES (9598, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:02:07', '2026-03-06 17:02:07');
INSERT INTO `sj_job_task_batch` VALUES (9599, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:03:07', '2026-03-06 17:03:07');
INSERT INTO `sj_job_task_batch` VALUES (9600, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:04:07', '2026-03-06 17:04:07');
INSERT INTO `sj_job_task_batch` VALUES (9601, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:05:07', '2026-03-06 17:05:07');
INSERT INTO `sj_job_task_batch` VALUES (9602, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:06:07', '2026-03-06 17:06:07');
INSERT INTO `sj_job_task_batch` VALUES (9603, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:07:07', '2026-03-06 17:07:07');
INSERT INTO `sj_job_task_batch` VALUES (9604, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:08:07', '2026-03-06 17:08:07');
INSERT INTO `sj_job_task_batch` VALUES (9605, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:09:07', '2026-03-06 17:09:07');
INSERT INTO `sj_job_task_batch` VALUES (9606, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:10:07', '2026-03-06 17:10:07');
INSERT INTO `sj_job_task_batch` VALUES (9607, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:11:07', '2026-03-06 17:11:07');
INSERT INTO `sj_job_task_batch` VALUES (9608, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:12:07', '2026-03-06 17:12:07');
INSERT INTO `sj_job_task_batch` VALUES (9609, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:13:07', '2026-03-06 17:13:07');
INSERT INTO `sj_job_task_batch` VALUES (9610, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:14:07', '2026-03-06 17:14:07');
INSERT INTO `sj_job_task_batch` VALUES (9611, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:15:07', '2026-03-06 17:15:07');
INSERT INTO `sj_job_task_batch` VALUES (9612, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:16:07', '2026-03-06 17:16:07');
INSERT INTO `sj_job_task_batch` VALUES (9613, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:17:07', '2026-03-06 17:17:07');
INSERT INTO `sj_job_task_batch` VALUES (9614, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:18:07', '2026-03-06 17:18:07');
INSERT INTO `sj_job_task_batch` VALUES (9615, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:19:07', '2026-03-06 17:19:07');
INSERT INTO `sj_job_task_batch` VALUES (9616, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:20:07', '2026-03-06 17:20:07');
INSERT INTO `sj_job_task_batch` VALUES (9617, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:21:07', '2026-03-06 17:21:07');
INSERT INTO `sj_job_task_batch` VALUES (9618, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:22:07', '2026-03-06 17:22:07');
INSERT INTO `sj_job_task_batch` VALUES (9619, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:23:07', '2026-03-06 17:23:07');
INSERT INTO `sj_job_task_batch` VALUES (9620, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:24:07', '2026-03-06 17:24:07');
INSERT INTO `sj_job_task_batch` VALUES (9621, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:25:07', '2026-03-06 17:25:07');
INSERT INTO `sj_job_task_batch` VALUES (9622, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:26:07', '2026-03-06 17:26:07');
INSERT INTO `sj_job_task_batch` VALUES (9623, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:27:07', '2026-03-06 17:27:07');
INSERT INTO `sj_job_task_batch` VALUES (9624, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:28:07', '2026-03-06 17:28:07');
INSERT INTO `sj_job_task_batch` VALUES (9625, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:29:07', '2026-03-06 17:29:07');
INSERT INTO `sj_job_task_batch` VALUES (9626, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:30:07', '2026-03-06 17:30:07');
INSERT INTO `sj_job_task_batch` VALUES (9627, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:31:07', '2026-03-06 17:31:07');
INSERT INTO `sj_job_task_batch` VALUES (9628, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:32:07', '2026-03-06 17:32:07');
INSERT INTO `sj_job_task_batch` VALUES (9629, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:33:07', '2026-03-06 17:33:07');
INSERT INTO `sj_job_task_batch` VALUES (9630, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:34:07', '2026-03-06 17:34:07');
INSERT INTO `sj_job_task_batch` VALUES (9631, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:35:07', '2026-03-06 17:35:07');
INSERT INTO `sj_job_task_batch` VALUES (9632, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:36:07', '2026-03-06 17:36:07');
INSERT INTO `sj_job_task_batch` VALUES (9633, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:37:07', '2026-03-06 17:37:07');
INSERT INTO `sj_job_task_batch` VALUES (9634, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:38:07', '2026-03-06 17:38:07');
INSERT INTO `sj_job_task_batch` VALUES (9635, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:39:07', '2026-03-06 17:39:07');
INSERT INTO `sj_job_task_batch` VALUES (9636, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:40:07', '2026-03-06 17:40:07');
INSERT INTO `sj_job_task_batch` VALUES (9637, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:41:07', '2026-03-06 17:41:07');
INSERT INTO `sj_job_task_batch` VALUES (9638, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:42:07', '2026-03-06 17:42:07');
INSERT INTO `sj_job_task_batch` VALUES (9639, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:43:07', '2026-03-06 17:43:07');
INSERT INTO `sj_job_task_batch` VALUES (9640, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:44:07', '2026-03-06 17:44:07');
INSERT INTO `sj_job_task_batch` VALUES (9641, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:45:07', '2026-03-06 17:45:07');
INSERT INTO `sj_job_task_batch` VALUES (9642, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:46:07', '2026-03-06 17:46:07');
INSERT INTO `sj_job_task_batch` VALUES (9643, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:47:07', '2026-03-06 17:47:07');
INSERT INTO `sj_job_task_batch` VALUES (9644, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:48:07', '2026-03-06 17:48:07');
INSERT INTO `sj_job_task_batch` VALUES (9645, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:49:07', '2026-03-06 17:49:07');
INSERT INTO `sj_job_task_batch` VALUES (9646, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:50:07', '2026-03-06 17:50:07');
INSERT INTO `sj_job_task_batch` VALUES (9647, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:51:07', '2026-03-06 17:51:07');
INSERT INTO `sj_job_task_batch` VALUES (9648, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:52:07', '2026-03-06 17:52:07');
INSERT INTO `sj_job_task_batch` VALUES (9649, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:53:07', '2026-03-06 17:53:07');
INSERT INTO `sj_job_task_batch` VALUES (9650, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:54:07', '2026-03-06 17:54:07');
INSERT INTO `sj_job_task_batch` VALUES (9651, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:55:07', '2026-03-06 17:55:07');
INSERT INTO `sj_job_task_batch` VALUES (9652, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:56:07', '2026-03-06 17:56:07');
INSERT INTO `sj_job_task_batch` VALUES (9653, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:57:07', '2026-03-06 17:57:07');
INSERT INTO `sj_job_task_batch` VALUES (9654, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:58:07', '2026-03-06 17:58:07');
INSERT INTO `sj_job_task_batch` VALUES (9655, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 17:59:07', '2026-03-06 17:59:07');
INSERT INTO `sj_job_task_batch` VALUES (9656, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:00:07', '2026-03-06 18:00:07');
INSERT INTO `sj_job_task_batch` VALUES (9657, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:01:07', '2026-03-06 18:01:07');
INSERT INTO `sj_job_task_batch` VALUES (9658, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:02:07', '2026-03-06 18:02:07');
INSERT INTO `sj_job_task_batch` VALUES (9659, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:03:07', '2026-03-06 18:03:07');
INSERT INTO `sj_job_task_batch` VALUES (9660, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:04:07', '2026-03-06 18:04:07');
INSERT INTO `sj_job_task_batch` VALUES (9661, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:05:07', '2026-03-06 18:05:07');
INSERT INTO `sj_job_task_batch` VALUES (9662, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:06:07', '2026-03-06 18:06:07');
INSERT INTO `sj_job_task_batch` VALUES (9663, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:07:07', '2026-03-06 18:07:07');
INSERT INTO `sj_job_task_batch` VALUES (9664, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:08:07', '2026-03-06 18:08:07');
INSERT INTO `sj_job_task_batch` VALUES (9665, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:09:07', '2026-03-06 18:09:07');
INSERT INTO `sj_job_task_batch` VALUES (9666, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:10:07', '2026-03-06 18:10:07');
INSERT INTO `sj_job_task_batch` VALUES (9667, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:11:07', '2026-03-06 18:11:07');
INSERT INTO `sj_job_task_batch` VALUES (9668, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:12:07', '2026-03-06 18:12:07');
INSERT INTO `sj_job_task_batch` VALUES (9669, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:13:07', '2026-03-06 18:13:07');
INSERT INTO `sj_job_task_batch` VALUES (9670, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:14:07', '2026-03-06 18:14:07');
INSERT INTO `sj_job_task_batch` VALUES (9671, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:15:07', '2026-03-06 18:15:07');
INSERT INTO `sj_job_task_batch` VALUES (9672, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:16:07', '2026-03-06 18:16:07');
INSERT INTO `sj_job_task_batch` VALUES (9673, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:17:07', '2026-03-06 18:17:07');
INSERT INTO `sj_job_task_batch` VALUES (9674, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:18:07', '2026-03-06 18:18:07');
INSERT INTO `sj_job_task_batch` VALUES (9675, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:19:07', '2026-03-06 18:19:07');
INSERT INTO `sj_job_task_batch` VALUES (9676, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:20:07', '2026-03-06 18:20:07');
INSERT INTO `sj_job_task_batch` VALUES (9677, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:21:07', '2026-03-06 18:21:07');
INSERT INTO `sj_job_task_batch` VALUES (9678, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:22:07', '2026-03-06 18:22:07');
INSERT INTO `sj_job_task_batch` VALUES (9679, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:23:07', '2026-03-06 18:23:07');
INSERT INTO `sj_job_task_batch` VALUES (9680, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:24:07', '2026-03-06 18:24:07');
INSERT INTO `sj_job_task_batch` VALUES (9681, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:25:07', '2026-03-06 18:25:07');
INSERT INTO `sj_job_task_batch` VALUES (9682, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:26:07', '2026-03-06 18:26:07');
INSERT INTO `sj_job_task_batch` VALUES (9683, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-06 18:27:07', '2026-03-06 18:27:07');
INSERT INTO `sj_job_task_batch` VALUES (9684, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:45:57', '2026-03-07 15:45:57');
INSERT INTO `sj_job_task_batch` VALUES (9685, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:46:57', '2026-03-07 15:46:57');
INSERT INTO `sj_job_task_batch` VALUES (9686, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:47:56', '2026-03-07 15:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9687, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:48:56', '2026-03-07 15:48:56');
INSERT INTO `sj_job_task_batch` VALUES (9688, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:49:56', '2026-03-07 15:49:56');
INSERT INTO `sj_job_task_batch` VALUES (9689, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:50:56', '2026-03-07 15:50:56');
INSERT INTO `sj_job_task_batch` VALUES (9690, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:51:56', '2026-03-07 15:51:56');
INSERT INTO `sj_job_task_batch` VALUES (9691, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:52:56', '2026-03-07 15:52:56');
INSERT INTO `sj_job_task_batch` VALUES (9692, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:53:56', '2026-03-07 15:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9693, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:54:56', '2026-03-07 15:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9694, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:55:56', '2026-03-07 15:55:56');
INSERT INTO `sj_job_task_batch` VALUES (9695, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:56:56', '2026-03-07 15:56:56');
INSERT INTO `sj_job_task_batch` VALUES (9696, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:57:56', '2026-03-07 15:57:56');
INSERT INTO `sj_job_task_batch` VALUES (9697, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:58:56', '2026-03-07 15:58:56');
INSERT INTO `sj_job_task_batch` VALUES (9698, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 15:59:57', '2026-03-07 15:59:57');
INSERT INTO `sj_job_task_batch` VALUES (9699, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:00:56', '2026-03-07 16:00:56');
INSERT INTO `sj_job_task_batch` VALUES (9700, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:01:56', '2026-03-07 16:01:56');
INSERT INTO `sj_job_task_batch` VALUES (9701, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:02:56', '2026-03-07 16:02:56');
INSERT INTO `sj_job_task_batch` VALUES (9702, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:03:56', '2026-03-07 16:03:56');
INSERT INTO `sj_job_task_batch` VALUES (9703, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:04:56', '2026-03-07 16:04:56');
INSERT INTO `sj_job_task_batch` VALUES (9704, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:05:56', '2026-03-07 16:05:56');
INSERT INTO `sj_job_task_batch` VALUES (9705, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:06:57', '2026-03-07 16:06:57');
INSERT INTO `sj_job_task_batch` VALUES (9706, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:07:56', '2026-03-07 16:07:56');
INSERT INTO `sj_job_task_batch` VALUES (9707, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:08:56', '2026-03-07 16:08:56');
INSERT INTO `sj_job_task_batch` VALUES (9708, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:09:56', '2026-03-07 16:09:56');
INSERT INTO `sj_job_task_batch` VALUES (9709, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:10:56', '2026-03-07 16:10:56');
INSERT INTO `sj_job_task_batch` VALUES (9710, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:11:56', '2026-03-07 16:11:56');
INSERT INTO `sj_job_task_batch` VALUES (9711, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:12:56', '2026-03-07 16:12:56');
INSERT INTO `sj_job_task_batch` VALUES (9712, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:13:56', '2026-03-07 16:13:56');
INSERT INTO `sj_job_task_batch` VALUES (9713, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:14:56', '2026-03-07 16:14:56');
INSERT INTO `sj_job_task_batch` VALUES (9714, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:15:56', '2026-03-07 16:15:56');
INSERT INTO `sj_job_task_batch` VALUES (9715, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:16:56', '2026-03-07 16:16:56');
INSERT INTO `sj_job_task_batch` VALUES (9716, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:17:56', '2026-03-07 16:17:56');
INSERT INTO `sj_job_task_batch` VALUES (9717, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:18:56', '2026-03-07 16:18:56');
INSERT INTO `sj_job_task_batch` VALUES (9718, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:19:56', '2026-03-07 16:19:56');
INSERT INTO `sj_job_task_batch` VALUES (9719, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:20:56', '2026-03-07 16:20:56');
INSERT INTO `sj_job_task_batch` VALUES (9720, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:21:57', '2026-03-07 16:21:57');
INSERT INTO `sj_job_task_batch` VALUES (9721, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:22:56', '2026-03-07 16:22:56');
INSERT INTO `sj_job_task_batch` VALUES (9722, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:23:56', '2026-03-07 16:23:56');
INSERT INTO `sj_job_task_batch` VALUES (9723, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:24:56', '2026-03-07 16:24:56');
INSERT INTO `sj_job_task_batch` VALUES (9724, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:25:56', '2026-03-07 16:25:56');
INSERT INTO `sj_job_task_batch` VALUES (9725, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:26:56', '2026-03-07 16:26:56');
INSERT INTO `sj_job_task_batch` VALUES (9726, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:27:56', '2026-03-07 16:27:56');
INSERT INTO `sj_job_task_batch` VALUES (9727, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:28:56', '2026-03-07 16:28:56');
INSERT INTO `sj_job_task_batch` VALUES (9728, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:29:57', '2026-03-07 16:29:57');
INSERT INTO `sj_job_task_batch` VALUES (9729, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:30:56', '2026-03-07 16:30:56');
INSERT INTO `sj_job_task_batch` VALUES (9730, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:31:57', '2026-03-07 16:31:57');
INSERT INTO `sj_job_task_batch` VALUES (9731, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:32:56', '2026-03-07 16:32:56');
INSERT INTO `sj_job_task_batch` VALUES (9732, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:33:56', '2026-03-07 16:33:56');
INSERT INTO `sj_job_task_batch` VALUES (9733, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:34:56', '2026-03-07 16:34:56');
INSERT INTO `sj_job_task_batch` VALUES (9734, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:35:56', '2026-03-07 16:35:56');
INSERT INTO `sj_job_task_batch` VALUES (9735, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:36:56', '2026-03-07 16:36:56');
INSERT INTO `sj_job_task_batch` VALUES (9736, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:37:56', '2026-03-07 16:37:56');
INSERT INTO `sj_job_task_batch` VALUES (9737, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:38:56', '2026-03-07 16:38:56');
INSERT INTO `sj_job_task_batch` VALUES (9738, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:39:56', '2026-03-07 16:39:56');
INSERT INTO `sj_job_task_batch` VALUES (9739, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:40:57', '2026-03-07 16:40:57');
INSERT INTO `sj_job_task_batch` VALUES (9740, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:41:56', '2026-03-07 16:41:56');
INSERT INTO `sj_job_task_batch` VALUES (9741, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:42:56', '2026-03-07 16:42:56');
INSERT INTO `sj_job_task_batch` VALUES (9742, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:43:56', '2026-03-07 16:43:56');
INSERT INTO `sj_job_task_batch` VALUES (9743, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:44:56', '2026-03-07 16:44:56');
INSERT INTO `sj_job_task_batch` VALUES (9744, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:45:56', '2026-03-07 16:45:56');
INSERT INTO `sj_job_task_batch` VALUES (9745, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:46:56', '2026-03-07 16:46:56');
INSERT INTO `sj_job_task_batch` VALUES (9746, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:47:56', '2026-03-07 16:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9747, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:48:56', '2026-03-07 16:48:56');
INSERT INTO `sj_job_task_batch` VALUES (9748, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:49:56', '2026-03-07 16:49:56');
INSERT INTO `sj_job_task_batch` VALUES (9749, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:50:57', '2026-03-07 16:50:57');
INSERT INTO `sj_job_task_batch` VALUES (9750, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:51:56', '2026-03-07 16:51:56');
INSERT INTO `sj_job_task_batch` VALUES (9751, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:52:57', '2026-03-07 16:52:57');
INSERT INTO `sj_job_task_batch` VALUES (9752, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:53:56', '2026-03-07 16:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9753, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:54:56', '2026-03-07 16:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9754, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:55:56', '2026-03-07 16:55:56');
INSERT INTO `sj_job_task_batch` VALUES (9755, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:56:56', '2026-03-07 16:56:56');
INSERT INTO `sj_job_task_batch` VALUES (9756, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:57:56', '2026-03-07 16:57:56');
INSERT INTO `sj_job_task_batch` VALUES (9757, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:58:56', '2026-03-07 16:58:56');
INSERT INTO `sj_job_task_batch` VALUES (9758, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 16:59:56', '2026-03-07 16:59:56');
INSERT INTO `sj_job_task_batch` VALUES (9759, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:00:56', '2026-03-07 17:00:56');
INSERT INTO `sj_job_task_batch` VALUES (9760, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:01:57', '2026-03-07 17:01:57');
INSERT INTO `sj_job_task_batch` VALUES (9761, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:02:57', '2026-03-07 17:02:57');
INSERT INTO `sj_job_task_batch` VALUES (9762, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:03:56', '2026-03-07 17:03:56');
INSERT INTO `sj_job_task_batch` VALUES (9763, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:04:56', '2026-03-07 17:04:56');
INSERT INTO `sj_job_task_batch` VALUES (9764, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:05:56', '2026-03-07 17:05:56');
INSERT INTO `sj_job_task_batch` VALUES (9765, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:06:56', '2026-03-07 17:06:56');
INSERT INTO `sj_job_task_batch` VALUES (9766, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:07:56', '2026-03-07 17:07:56');
INSERT INTO `sj_job_task_batch` VALUES (9767, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:08:56', '2026-03-07 17:08:56');
INSERT INTO `sj_job_task_batch` VALUES (9768, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:09:56', '2026-03-07 17:09:56');
INSERT INTO `sj_job_task_batch` VALUES (9769, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:10:56', '2026-03-07 17:10:56');
INSERT INTO `sj_job_task_batch` VALUES (9770, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:11:56', '2026-03-07 17:11:56');
INSERT INTO `sj_job_task_batch` VALUES (9771, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:12:56', '2026-03-07 17:12:56');
INSERT INTO `sj_job_task_batch` VALUES (9772, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:13:56', '2026-03-07 17:13:56');
INSERT INTO `sj_job_task_batch` VALUES (9773, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:14:57', '2026-03-07 17:14:57');
INSERT INTO `sj_job_task_batch` VALUES (9774, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:15:56', '2026-03-07 17:15:56');
INSERT INTO `sj_job_task_batch` VALUES (9775, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:16:57', '2026-03-07 17:16:57');
INSERT INTO `sj_job_task_batch` VALUES (9776, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:17:56', '2026-03-07 17:17:56');
INSERT INTO `sj_job_task_batch` VALUES (9777, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:18:56', '2026-03-07 17:18:56');
INSERT INTO `sj_job_task_batch` VALUES (9778, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:19:56', '2026-03-07 17:19:56');
INSERT INTO `sj_job_task_batch` VALUES (9779, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:20:56', '2026-03-07 17:20:56');
INSERT INTO `sj_job_task_batch` VALUES (9780, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:21:56', '2026-03-07 17:21:56');
INSERT INTO `sj_job_task_batch` VALUES (9781, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:22:56', '2026-03-07 17:22:56');
INSERT INTO `sj_job_task_batch` VALUES (9782, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:23:56', '2026-03-07 17:23:56');
INSERT INTO `sj_job_task_batch` VALUES (9783, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:24:56', '2026-03-07 17:24:56');
INSERT INTO `sj_job_task_batch` VALUES (9784, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:25:57', '2026-03-07 17:25:57');
INSERT INTO `sj_job_task_batch` VALUES (9785, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:26:57', '2026-03-07 17:26:57');
INSERT INTO `sj_job_task_batch` VALUES (9786, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:27:57', '2026-03-07 17:27:57');
INSERT INTO `sj_job_task_batch` VALUES (9787, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:28:56', '2026-03-07 17:28:56');
INSERT INTO `sj_job_task_batch` VALUES (9788, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:29:56', '2026-03-07 17:29:56');
INSERT INTO `sj_job_task_batch` VALUES (9789, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:30:56', '2026-03-07 17:30:56');
INSERT INTO `sj_job_task_batch` VALUES (9790, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:31:56', '2026-03-07 17:31:56');
INSERT INTO `sj_job_task_batch` VALUES (9791, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:32:56', '2026-03-07 17:32:56');
INSERT INTO `sj_job_task_batch` VALUES (9792, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:33:56', '2026-03-07 17:33:56');
INSERT INTO `sj_job_task_batch` VALUES (9793, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:34:56', '2026-03-07 17:34:56');
INSERT INTO `sj_job_task_batch` VALUES (9794, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:35:57', '2026-03-07 17:35:57');
INSERT INTO `sj_job_task_batch` VALUES (9795, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:36:56', '2026-03-07 17:36:56');
INSERT INTO `sj_job_task_batch` VALUES (9796, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:37:56', '2026-03-07 17:37:56');
INSERT INTO `sj_job_task_batch` VALUES (9797, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:38:56', '2026-03-07 17:38:56');
INSERT INTO `sj_job_task_batch` VALUES (9798, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:39:56', '2026-03-07 17:39:56');
INSERT INTO `sj_job_task_batch` VALUES (9799, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:40:56', '2026-03-07 17:40:56');
INSERT INTO `sj_job_task_batch` VALUES (9800, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:41:56', '2026-03-07 17:41:56');
INSERT INTO `sj_job_task_batch` VALUES (9801, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:42:56', '2026-03-07 17:42:56');
INSERT INTO `sj_job_task_batch` VALUES (9802, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:43:57', '2026-03-07 17:43:57');
INSERT INTO `sj_job_task_batch` VALUES (9803, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:44:56', '2026-03-07 17:44:56');
INSERT INTO `sj_job_task_batch` VALUES (9804, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:45:56', '2026-03-07 17:45:56');
INSERT INTO `sj_job_task_batch` VALUES (9805, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:46:56', '2026-03-07 17:46:56');
INSERT INTO `sj_job_task_batch` VALUES (9806, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:47:56', '2026-03-07 17:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9807, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:48:56', '2026-03-07 17:48:56');
INSERT INTO `sj_job_task_batch` VALUES (9808, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:49:56', '2026-03-07 17:49:56');
INSERT INTO `sj_job_task_batch` VALUES (9809, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:50:56', '2026-03-07 17:50:56');
INSERT INTO `sj_job_task_batch` VALUES (9810, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:51:56', '2026-03-07 17:51:56');
INSERT INTO `sj_job_task_batch` VALUES (9811, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:52:56', '2026-03-07 17:52:56');
INSERT INTO `sj_job_task_batch` VALUES (9812, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:53:56', '2026-03-07 17:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9813, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:54:56', '2026-03-07 17:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9814, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:55:56', '2026-03-07 17:55:56');
INSERT INTO `sj_job_task_batch` VALUES (9815, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:56:56', '2026-03-07 17:56:56');
INSERT INTO `sj_job_task_batch` VALUES (9816, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:57:56', '2026-03-07 17:57:56');
INSERT INTO `sj_job_task_batch` VALUES (9817, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:58:56', '2026-03-07 17:58:56');
INSERT INTO `sj_job_task_batch` VALUES (9818, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 17:59:56', '2026-03-07 17:59:56');
INSERT INTO `sj_job_task_batch` VALUES (9819, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:00:56', '2026-03-07 18:00:56');
INSERT INTO `sj_job_task_batch` VALUES (9820, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:01:56', '2026-03-07 18:01:56');
INSERT INTO `sj_job_task_batch` VALUES (9821, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:02:56', '2026-03-07 18:02:56');
INSERT INTO `sj_job_task_batch` VALUES (9822, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:03:56', '2026-03-07 18:03:56');
INSERT INTO `sj_job_task_batch` VALUES (9823, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:04:56', '2026-03-07 18:04:56');
INSERT INTO `sj_job_task_batch` VALUES (9824, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:05:56', '2026-03-07 18:05:56');
INSERT INTO `sj_job_task_batch` VALUES (9825, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:06:56', '2026-03-07 18:06:56');
INSERT INTO `sj_job_task_batch` VALUES (9826, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:07:56', '2026-03-07 18:07:56');
INSERT INTO `sj_job_task_batch` VALUES (9827, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:08:57', '2026-03-07 18:08:57');
INSERT INTO `sj_job_task_batch` VALUES (9828, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:09:56', '2026-03-07 18:09:56');
INSERT INTO `sj_job_task_batch` VALUES (9829, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:10:56', '2026-03-07 18:10:56');
INSERT INTO `sj_job_task_batch` VALUES (9830, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:11:56', '2026-03-07 18:11:56');
INSERT INTO `sj_job_task_batch` VALUES (9831, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:12:56', '2026-03-07 18:12:56');
INSERT INTO `sj_job_task_batch` VALUES (9832, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:13:56', '2026-03-07 18:13:56');
INSERT INTO `sj_job_task_batch` VALUES (9833, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:14:57', '2026-03-07 18:14:57');
INSERT INTO `sj_job_task_batch` VALUES (9834, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:15:56', '2026-03-07 18:15:56');
INSERT INTO `sj_job_task_batch` VALUES (9835, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:16:56', '2026-03-07 18:16:56');
INSERT INTO `sj_job_task_batch` VALUES (9836, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:17:56', '2026-03-07 18:17:56');
INSERT INTO `sj_job_task_batch` VALUES (9837, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:18:56', '2026-03-07 18:18:56');
INSERT INTO `sj_job_task_batch` VALUES (9838, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:19:56', '2026-03-07 18:19:56');
INSERT INTO `sj_job_task_batch` VALUES (9839, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:20:56', '2026-03-07 18:20:56');
INSERT INTO `sj_job_task_batch` VALUES (9840, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:21:57', '2026-03-07 18:21:57');
INSERT INTO `sj_job_task_batch` VALUES (9841, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:22:57', '2026-03-07 18:22:57');
INSERT INTO `sj_job_task_batch` VALUES (9842, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:23:56', '2026-03-07 18:23:56');
INSERT INTO `sj_job_task_batch` VALUES (9843, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:24:56', '2026-03-07 18:24:56');
INSERT INTO `sj_job_task_batch` VALUES (9844, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:25:56', '2026-03-07 18:25:56');
INSERT INTO `sj_job_task_batch` VALUES (9845, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:26:56', '2026-03-07 18:26:56');
INSERT INTO `sj_job_task_batch` VALUES (9846, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:27:56', '2026-03-07 18:27:56');
INSERT INTO `sj_job_task_batch` VALUES (9847, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:28:56', '2026-03-07 18:28:56');
INSERT INTO `sj_job_task_batch` VALUES (9848, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:29:56', '2026-03-07 18:29:56');
INSERT INTO `sj_job_task_batch` VALUES (9849, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:30:56', '2026-03-07 18:30:56');
INSERT INTO `sj_job_task_batch` VALUES (9850, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:31:56', '2026-03-07 18:31:56');
INSERT INTO `sj_job_task_batch` VALUES (9851, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:32:56', '2026-03-07 18:32:56');
INSERT INTO `sj_job_task_batch` VALUES (9852, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:33:56', '2026-03-07 18:33:56');
INSERT INTO `sj_job_task_batch` VALUES (9853, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:34:56', '2026-03-07 18:34:56');
INSERT INTO `sj_job_task_batch` VALUES (9854, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:35:56', '2026-03-07 18:35:56');
INSERT INTO `sj_job_task_batch` VALUES (9855, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:36:56', '2026-03-07 18:36:56');
INSERT INTO `sj_job_task_batch` VALUES (9856, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:37:56', '2026-03-07 18:37:56');
INSERT INTO `sj_job_task_batch` VALUES (9857, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:38:56', '2026-03-07 18:38:56');
INSERT INTO `sj_job_task_batch` VALUES (9858, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:39:56', '2026-03-07 18:39:56');
INSERT INTO `sj_job_task_batch` VALUES (9859, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:40:56', '2026-03-07 18:40:56');
INSERT INTO `sj_job_task_batch` VALUES (9860, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:41:56', '2026-03-07 18:41:56');
INSERT INTO `sj_job_task_batch` VALUES (9861, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:42:56', '2026-03-07 18:42:56');
INSERT INTO `sj_job_task_batch` VALUES (9862, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:43:56', '2026-03-07 18:43:56');
INSERT INTO `sj_job_task_batch` VALUES (9863, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:44:57', '2026-03-07 18:44:57');
INSERT INTO `sj_job_task_batch` VALUES (9864, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:45:57', '2026-03-07 18:45:57');
INSERT INTO `sj_job_task_batch` VALUES (9865, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:46:56', '2026-03-07 18:46:56');
INSERT INTO `sj_job_task_batch` VALUES (9866, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:47:56', '2026-03-07 18:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9867, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:48:56', '2026-03-07 18:48:56');
INSERT INTO `sj_job_task_batch` VALUES (9868, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:49:56', '2026-03-07 18:49:56');
INSERT INTO `sj_job_task_batch` VALUES (9869, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:50:56', '2026-03-07 18:50:56');
INSERT INTO `sj_job_task_batch` VALUES (9870, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:51:56', '2026-03-07 18:51:56');
INSERT INTO `sj_job_task_batch` VALUES (9871, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:52:56', '2026-03-07 18:52:56');
INSERT INTO `sj_job_task_batch` VALUES (9872, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:53:56', '2026-03-07 18:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9873, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:54:56', '2026-03-07 18:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9874, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:55:57', '2026-03-07 18:55:57');
INSERT INTO `sj_job_task_batch` VALUES (9875, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:56:57', '2026-03-07 18:56:57');
INSERT INTO `sj_job_task_batch` VALUES (9876, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:57:57', '2026-03-07 18:57:57');
INSERT INTO `sj_job_task_batch` VALUES (9877, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:58:57', '2026-03-07 18:58:57');
INSERT INTO `sj_job_task_batch` VALUES (9878, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 18:59:56', '2026-03-07 18:59:56');
INSERT INTO `sj_job_task_batch` VALUES (9879, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:00:56', '2026-03-07 19:00:56');
INSERT INTO `sj_job_task_batch` VALUES (9880, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:01:56', '2026-03-07 19:01:56');
INSERT INTO `sj_job_task_batch` VALUES (9881, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:02:56', '2026-03-07 19:02:56');
INSERT INTO `sj_job_task_batch` VALUES (9882, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:03:56', '2026-03-07 19:03:56');
INSERT INTO `sj_job_task_batch` VALUES (9883, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:04:56', '2026-03-07 19:04:56');
INSERT INTO `sj_job_task_batch` VALUES (9884, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:05:56', '2026-03-07 19:05:56');
INSERT INTO `sj_job_task_batch` VALUES (9885, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:06:57', '2026-03-07 19:06:57');
INSERT INTO `sj_job_task_batch` VALUES (9886, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:07:57', '2026-03-07 19:07:57');
INSERT INTO `sj_job_task_batch` VALUES (9887, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:08:56', '2026-03-07 19:08:56');
INSERT INTO `sj_job_task_batch` VALUES (9888, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:09:56', '2026-03-07 19:09:56');
INSERT INTO `sj_job_task_batch` VALUES (9889, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:10:56', '2026-03-07 19:10:56');
INSERT INTO `sj_job_task_batch` VALUES (9890, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:11:56', '2026-03-07 19:11:56');
INSERT INTO `sj_job_task_batch` VALUES (9891, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:12:56', '2026-03-07 19:12:56');
INSERT INTO `sj_job_task_batch` VALUES (9892, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:13:56', '2026-03-07 19:13:56');
INSERT INTO `sj_job_task_batch` VALUES (9893, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:14:56', '2026-03-07 19:14:56');
INSERT INTO `sj_job_task_batch` VALUES (9894, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:15:57', '2026-03-07 19:15:57');
INSERT INTO `sj_job_task_batch` VALUES (9895, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:16:57', '2026-03-07 19:16:57');
INSERT INTO `sj_job_task_batch` VALUES (9896, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:17:56', '2026-03-07 19:17:56');
INSERT INTO `sj_job_task_batch` VALUES (9897, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:18:56', '2026-03-07 19:18:56');
INSERT INTO `sj_job_task_batch` VALUES (9898, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:19:56', '2026-03-07 19:19:56');
INSERT INTO `sj_job_task_batch` VALUES (9899, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:20:56', '2026-03-07 19:20:56');
INSERT INTO `sj_job_task_batch` VALUES (9900, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:21:56', '2026-03-07 19:21:56');
INSERT INTO `sj_job_task_batch` VALUES (9901, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:22:56', '2026-03-07 19:22:56');
INSERT INTO `sj_job_task_batch` VALUES (9902, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:23:56', '2026-03-07 19:23:56');
INSERT INTO `sj_job_task_batch` VALUES (9903, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:24:57', '2026-03-07 19:24:57');
INSERT INTO `sj_job_task_batch` VALUES (9904, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:25:56', '2026-03-07 19:25:56');
INSERT INTO `sj_job_task_batch` VALUES (9905, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:26:56', '2026-03-07 19:26:56');
INSERT INTO `sj_job_task_batch` VALUES (9906, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:27:56', '2026-03-07 19:27:56');
INSERT INTO `sj_job_task_batch` VALUES (9907, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:28:56', '2026-03-07 19:28:56');
INSERT INTO `sj_job_task_batch` VALUES (9908, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:29:56', '2026-03-07 19:29:56');
INSERT INTO `sj_job_task_batch` VALUES (9909, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:30:56', '2026-03-07 19:30:56');
INSERT INTO `sj_job_task_batch` VALUES (9910, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:31:56', '2026-03-07 19:31:56');
INSERT INTO `sj_job_task_batch` VALUES (9911, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:32:56', '2026-03-07 19:32:56');
INSERT INTO `sj_job_task_batch` VALUES (9912, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:33:56', '2026-03-07 19:33:56');
INSERT INTO `sj_job_task_batch` VALUES (9913, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:34:56', '2026-03-07 19:34:56');
INSERT INTO `sj_job_task_batch` VALUES (9914, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:35:56', '2026-03-07 19:35:56');
INSERT INTO `sj_job_task_batch` VALUES (9915, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:36:56', '2026-03-07 19:36:56');
INSERT INTO `sj_job_task_batch` VALUES (9916, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:37:56', '2026-03-07 19:37:56');
INSERT INTO `sj_job_task_batch` VALUES (9917, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:38:56', '2026-03-07 19:38:56');
INSERT INTO `sj_job_task_batch` VALUES (9918, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:39:56', '2026-03-07 19:39:56');
INSERT INTO `sj_job_task_batch` VALUES (9919, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:40:56', '2026-03-07 19:40:56');
INSERT INTO `sj_job_task_batch` VALUES (9920, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:41:56', '2026-03-07 19:41:56');
INSERT INTO `sj_job_task_batch` VALUES (9921, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:42:56', '2026-03-07 19:42:56');
INSERT INTO `sj_job_task_batch` VALUES (9922, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:43:56', '2026-03-07 19:43:56');
INSERT INTO `sj_job_task_batch` VALUES (9923, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:44:57', '2026-03-07 19:44:57');
INSERT INTO `sj_job_task_batch` VALUES (9924, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:45:56', '2026-03-07 19:45:56');
INSERT INTO `sj_job_task_batch` VALUES (9925, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:46:56', '2026-03-07 19:46:56');
INSERT INTO `sj_job_task_batch` VALUES (9926, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:47:56', '2026-03-07 19:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9927, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:48:56', '2026-03-07 19:48:56');
INSERT INTO `sj_job_task_batch` VALUES (9928, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:49:56', '2026-03-07 19:49:56');
INSERT INTO `sj_job_task_batch` VALUES (9929, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:50:56', '2026-03-07 19:50:56');
INSERT INTO `sj_job_task_batch` VALUES (9930, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:51:56', '2026-03-07 19:51:56');
INSERT INTO `sj_job_task_batch` VALUES (9931, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:52:56', '2026-03-07 19:52:56');
INSERT INTO `sj_job_task_batch` VALUES (9932, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:53:56', '2026-03-07 19:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9933, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:54:56', '2026-03-07 19:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9934, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:55:56', '2026-03-07 19:55:56');
INSERT INTO `sj_job_task_batch` VALUES (9935, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:56:56', '2026-03-07 19:56:56');
INSERT INTO `sj_job_task_batch` VALUES (9936, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:57:57', '2026-03-07 19:57:57');
INSERT INTO `sj_job_task_batch` VALUES (9937, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:58:56', '2026-03-07 19:58:56');
INSERT INTO `sj_job_task_batch` VALUES (9938, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 19:59:57', '2026-03-07 19:59:57');
INSERT INTO `sj_job_task_batch` VALUES (9939, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:00:56', '2026-03-07 20:00:56');
INSERT INTO `sj_job_task_batch` VALUES (9940, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:01:56', '2026-03-07 20:01:56');
INSERT INTO `sj_job_task_batch` VALUES (9941, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:02:56', '2026-03-07 20:02:56');
INSERT INTO `sj_job_task_batch` VALUES (9942, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:03:56', '2026-03-07 20:03:56');
INSERT INTO `sj_job_task_batch` VALUES (9943, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:04:56', '2026-03-07 20:04:56');
INSERT INTO `sj_job_task_batch` VALUES (9944, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:05:56', '2026-03-07 20:05:56');
INSERT INTO `sj_job_task_batch` VALUES (9945, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:06:57', '2026-03-07 20:06:57');
INSERT INTO `sj_job_task_batch` VALUES (9946, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:07:57', '2026-03-07 20:07:57');
INSERT INTO `sj_job_task_batch` VALUES (9947, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:08:56', '2026-03-07 20:08:56');
INSERT INTO `sj_job_task_batch` VALUES (9948, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:09:56', '2026-03-07 20:09:56');
INSERT INTO `sj_job_task_batch` VALUES (9949, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:10:56', '2026-03-07 20:10:56');
INSERT INTO `sj_job_task_batch` VALUES (9950, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:11:56', '2026-03-07 20:11:56');
INSERT INTO `sj_job_task_batch` VALUES (9951, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:12:56', '2026-03-07 20:12:56');
INSERT INTO `sj_job_task_batch` VALUES (9952, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:13:56', '2026-03-07 20:13:56');
INSERT INTO `sj_job_task_batch` VALUES (9953, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:14:56', '2026-03-07 20:14:56');
INSERT INTO `sj_job_task_batch` VALUES (9954, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:15:56', '2026-03-07 20:15:56');
INSERT INTO `sj_job_task_batch` VALUES (9955, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:16:56', '2026-03-07 20:16:56');
INSERT INTO `sj_job_task_batch` VALUES (9956, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:17:56', '2026-03-07 20:17:56');
INSERT INTO `sj_job_task_batch` VALUES (9957, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:18:57', '2026-03-07 20:18:57');
INSERT INTO `sj_job_task_batch` VALUES (9958, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:19:57', '2026-03-07 20:19:57');
INSERT INTO `sj_job_task_batch` VALUES (9959, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:20:56', '2026-03-07 20:20:56');
INSERT INTO `sj_job_task_batch` VALUES (9960, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:21:56', '2026-03-07 20:21:56');
INSERT INTO `sj_job_task_batch` VALUES (9961, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:22:56', '2026-03-07 20:22:56');
INSERT INTO `sj_job_task_batch` VALUES (9962, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:23:56', '2026-03-07 20:23:56');
INSERT INTO `sj_job_task_batch` VALUES (9963, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:24:56', '2026-03-07 20:24:56');
INSERT INTO `sj_job_task_batch` VALUES (9964, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:25:56', '2026-03-07 20:25:56');
INSERT INTO `sj_job_task_batch` VALUES (9965, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:26:56', '2026-03-07 20:26:56');
INSERT INTO `sj_job_task_batch` VALUES (9966, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:27:56', '2026-03-07 20:27:56');
INSERT INTO `sj_job_task_batch` VALUES (9967, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:28:56', '2026-03-07 20:28:56');
INSERT INTO `sj_job_task_batch` VALUES (9968, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:29:56', '2026-03-07 20:29:56');
INSERT INTO `sj_job_task_batch` VALUES (9969, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:30:56', '2026-03-07 20:30:56');
INSERT INTO `sj_job_task_batch` VALUES (9970, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:31:56', '2026-03-07 20:31:56');
INSERT INTO `sj_job_task_batch` VALUES (9971, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:32:56', '2026-03-07 20:32:56');
INSERT INTO `sj_job_task_batch` VALUES (9972, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:33:56', '2026-03-07 20:33:56');
INSERT INTO `sj_job_task_batch` VALUES (9973, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:34:56', '2026-03-07 20:34:56');
INSERT INTO `sj_job_task_batch` VALUES (9974, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:35:56', '2026-03-07 20:35:56');
INSERT INTO `sj_job_task_batch` VALUES (9975, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:36:56', '2026-03-07 20:36:56');
INSERT INTO `sj_job_task_batch` VALUES (9976, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:37:56', '2026-03-07 20:37:56');
INSERT INTO `sj_job_task_batch` VALUES (9977, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:38:56', '2026-03-07 20:38:56');
INSERT INTO `sj_job_task_batch` VALUES (9978, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:39:56', '2026-03-07 20:39:56');
INSERT INTO `sj_job_task_batch` VALUES (9979, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:40:56', '2026-03-07 20:40:56');
INSERT INTO `sj_job_task_batch` VALUES (9980, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:41:56', '2026-03-07 20:41:56');
INSERT INTO `sj_job_task_batch` VALUES (9981, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:42:56', '2026-03-07 20:42:56');
INSERT INTO `sj_job_task_batch` VALUES (9982, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:43:56', '2026-03-07 20:43:56');
INSERT INTO `sj_job_task_batch` VALUES (9983, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:44:56', '2026-03-07 20:44:56');
INSERT INTO `sj_job_task_batch` VALUES (9984, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:45:56', '2026-03-07 20:45:56');
INSERT INTO `sj_job_task_batch` VALUES (9985, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:46:56', '2026-03-07 20:46:56');
INSERT INTO `sj_job_task_batch` VALUES (9986, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:47:56', '2026-03-07 20:47:56');
INSERT INTO `sj_job_task_batch` VALUES (9987, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:48:57', '2026-03-07 20:48:57');
INSERT INTO `sj_job_task_batch` VALUES (9988, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:49:57', '2026-03-07 20:49:57');
INSERT INTO `sj_job_task_batch` VALUES (9989, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:50:57', '2026-03-07 20:50:57');
INSERT INTO `sj_job_task_batch` VALUES (9990, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:51:57', '2026-03-07 20:51:57');
INSERT INTO `sj_job_task_batch` VALUES (9991, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:52:56', '2026-03-07 20:52:56');
INSERT INTO `sj_job_task_batch` VALUES (9992, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:53:56', '2026-03-07 20:53:56');
INSERT INTO `sj_job_task_batch` VALUES (9993, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:54:56', '2026-03-07 20:54:56');
INSERT INTO `sj_job_task_batch` VALUES (9994, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:55:56', '2026-03-07 20:55:56');
INSERT INTO `sj_job_task_batch` VALUES (9995, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:56:56', '2026-03-07 20:56:56');
INSERT INTO `sj_job_task_batch` VALUES (9996, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:57:56', '2026-03-07 20:57:56');
INSERT INTO `sj_job_task_batch` VALUES (9997, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:58:56', '2026-03-07 20:58:56');
INSERT INTO `sj_job_task_batch` VALUES (9998, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 20:59:56', '2026-03-07 20:59:56');
INSERT INTO `sj_job_task_batch` VALUES (9999, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:00:56', '2026-03-07 21:00:56');
INSERT INTO `sj_job_task_batch` VALUES (10000, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:01:56', '2026-03-07 21:01:56');
INSERT INTO `sj_job_task_batch` VALUES (10001, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:02:56', '2026-03-07 21:02:56');
INSERT INTO `sj_job_task_batch` VALUES (10002, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:03:57', '2026-03-07 21:03:57');
INSERT INTO `sj_job_task_batch` VALUES (10003, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:04:56', '2026-03-07 21:04:56');
INSERT INTO `sj_job_task_batch` VALUES (10004, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:05:56', '2026-03-07 21:05:56');
INSERT INTO `sj_job_task_batch` VALUES (10005, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:06:56', '2026-03-07 21:06:56');
INSERT INTO `sj_job_task_batch` VALUES (10006, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:07:56', '2026-03-07 21:07:56');
INSERT INTO `sj_job_task_batch` VALUES (10007, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:08:56', '2026-03-07 21:08:56');
INSERT INTO `sj_job_task_batch` VALUES (10008, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:09:56', '2026-03-07 21:09:56');
INSERT INTO `sj_job_task_batch` VALUES (10009, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:10:57', '2026-03-07 21:10:57');
INSERT INTO `sj_job_task_batch` VALUES (10010, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:11:56', '2026-03-07 21:11:56');
INSERT INTO `sj_job_task_batch` VALUES (10011, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:12:56', '2026-03-07 21:12:56');
INSERT INTO `sj_job_task_batch` VALUES (10012, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:13:56', '2026-03-07 21:13:56');
INSERT INTO `sj_job_task_batch` VALUES (10013, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:14:56', '2026-03-07 21:14:56');
INSERT INTO `sj_job_task_batch` VALUES (10014, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:15:56', '2026-03-07 21:15:56');
INSERT INTO `sj_job_task_batch` VALUES (10015, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:16:56', '2026-03-07 21:16:56');
INSERT INTO `sj_job_task_batch` VALUES (10016, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:17:56', '2026-03-07 21:17:56');
INSERT INTO `sj_job_task_batch` VALUES (10017, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:18:56', '2026-03-07 21:18:56');
INSERT INTO `sj_job_task_batch` VALUES (10018, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:19:56', '2026-03-07 21:19:56');
INSERT INTO `sj_job_task_batch` VALUES (10019, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:20:56', '2026-03-07 21:20:56');
INSERT INTO `sj_job_task_batch` VALUES (10020, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:21:56', '2026-03-07 21:21:56');
INSERT INTO `sj_job_task_batch` VALUES (10021, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:22:56', '2026-03-07 21:22:56');
INSERT INTO `sj_job_task_batch` VALUES (10022, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:23:56', '2026-03-07 21:23:56');
INSERT INTO `sj_job_task_batch` VALUES (10023, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:24:56', '2026-03-07 21:24:56');
INSERT INTO `sj_job_task_batch` VALUES (10024, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:25:56', '2026-03-07 21:25:56');
INSERT INTO `sj_job_task_batch` VALUES (10025, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:26:56', '2026-03-07 21:26:56');
INSERT INTO `sj_job_task_batch` VALUES (10026, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:27:56', '2026-03-07 21:27:56');
INSERT INTO `sj_job_task_batch` VALUES (10027, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:28:57', '2026-03-07 21:28:57');
INSERT INTO `sj_job_task_batch` VALUES (10028, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:29:56', '2026-03-07 21:29:56');
INSERT INTO `sj_job_task_batch` VALUES (10029, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:30:56', '2026-03-07 21:30:56');
INSERT INTO `sj_job_task_batch` VALUES (10030, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:31:56', '2026-03-07 21:31:56');
INSERT INTO `sj_job_task_batch` VALUES (10031, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:32:56', '2026-03-07 21:32:56');
INSERT INTO `sj_job_task_batch` VALUES (10032, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:33:56', '2026-03-07 21:33:56');
INSERT INTO `sj_job_task_batch` VALUES (10033, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:34:56', '2026-03-07 21:34:56');
INSERT INTO `sj_job_task_batch` VALUES (10034, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:35:56', '2026-03-07 21:35:56');
INSERT INTO `sj_job_task_batch` VALUES (10035, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:36:56', '2026-03-07 21:36:56');
INSERT INTO `sj_job_task_batch` VALUES (10036, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:37:57', '2026-03-07 21:37:57');
INSERT INTO `sj_job_task_batch` VALUES (10037, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:38:56', '2026-03-07 21:38:56');
INSERT INTO `sj_job_task_batch` VALUES (10038, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:39:56', '2026-03-07 21:39:56');
INSERT INTO `sj_job_task_batch` VALUES (10039, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:40:56', '2026-03-07 21:40:56');
INSERT INTO `sj_job_task_batch` VALUES (10040, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:41:56', '2026-03-07 21:41:56');
INSERT INTO `sj_job_task_batch` VALUES (10041, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:42:56', '2026-03-07 21:42:56');
INSERT INTO `sj_job_task_batch` VALUES (10042, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:43:56', '2026-03-07 21:43:56');
INSERT INTO `sj_job_task_batch` VALUES (10043, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:44:56', '2026-03-07 21:44:56');
INSERT INTO `sj_job_task_batch` VALUES (10044, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:45:56', '2026-03-07 21:45:56');
INSERT INTO `sj_job_task_batch` VALUES (10045, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:46:56', '2026-03-07 21:46:56');
INSERT INTO `sj_job_task_batch` VALUES (10046, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:47:56', '2026-03-07 21:47:56');
INSERT INTO `sj_job_task_batch` VALUES (10047, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:48:56', '2026-03-07 21:48:56');
INSERT INTO `sj_job_task_batch` VALUES (10048, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:49:56', '2026-03-07 21:49:56');
INSERT INTO `sj_job_task_batch` VALUES (10049, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:50:56', '2026-03-07 21:50:56');
INSERT INTO `sj_job_task_batch` VALUES (10050, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:51:56', '2026-03-07 21:51:56');
INSERT INTO `sj_job_task_batch` VALUES (10051, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:52:57', '2026-03-07 21:52:57');
INSERT INTO `sj_job_task_batch` VALUES (10052, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:53:56', '2026-03-07 21:53:56');
INSERT INTO `sj_job_task_batch` VALUES (10053, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:54:56', '2026-03-07 21:54:56');
INSERT INTO `sj_job_task_batch` VALUES (10054, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:55:56', '2026-03-07 21:55:56');
INSERT INTO `sj_job_task_batch` VALUES (10055, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:56:56', '2026-03-07 21:56:56');
INSERT INTO `sj_job_task_batch` VALUES (10056, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:57:56', '2026-03-07 21:57:56');
INSERT INTO `sj_job_task_batch` VALUES (10057, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:58:56', '2026-03-07 21:58:56');
INSERT INTO `sj_job_task_batch` VALUES (10058, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 21:59:56', '2026-03-07 21:59:56');
INSERT INTO `sj_job_task_batch` VALUES (10059, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:00:56', '2026-03-07 22:00:56');
INSERT INTO `sj_job_task_batch` VALUES (10060, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:01:56', '2026-03-07 22:01:56');
INSERT INTO `sj_job_task_batch` VALUES (10061, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:02:57', '2026-03-07 22:02:57');
INSERT INTO `sj_job_task_batch` VALUES (10062, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:03:57', '2026-03-07 22:03:57');
INSERT INTO `sj_job_task_batch` VALUES (10063, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:04:56', '2026-03-07 22:04:56');
INSERT INTO `sj_job_task_batch` VALUES (10064, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:05:56', '2026-03-07 22:05:56');
INSERT INTO `sj_job_task_batch` VALUES (10065, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:06:56', '2026-03-07 22:06:56');
INSERT INTO `sj_job_task_batch` VALUES (10066, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:07:56', '2026-03-07 22:07:56');
INSERT INTO `sj_job_task_batch` VALUES (10067, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:08:56', '2026-03-07 22:08:56');
INSERT INTO `sj_job_task_batch` VALUES (10068, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:09:56', '2026-03-07 22:09:56');
INSERT INTO `sj_job_task_batch` VALUES (10069, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:10:56', '2026-03-07 22:10:56');
INSERT INTO `sj_job_task_batch` VALUES (10070, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:11:57', '2026-03-07 22:11:57');
INSERT INTO `sj_job_task_batch` VALUES (10071, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:12:56', '2026-03-07 22:12:56');
INSERT INTO `sj_job_task_batch` VALUES (10072, 'dev', 'ruoyi_group', 1, 0, 0, 0, 6, 2, 0, 3, '', '', 0, '2026-03-07 22:13:56', '2026-03-07 22:13:56');

-- ----------------------------
-- Table structure for sj_namespace
-- ----------------------------
DROP TABLE IF EXISTS `sj_namespace`;
CREATE TABLE `sj_namespace`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `unique_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一id',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_unique_id`(`unique_id` ASC) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '命名空间' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_namespace
-- ----------------------------
INSERT INTO `sj_namespace` VALUES (1, 'Development', 'dev', '', 0, '2026-02-04 09:56:51', '2026-02-04 09:56:51');
INSERT INTO `sj_namespace` VALUES (2, 'Production', 'prod', '', 0, '2026-02-04 09:56:51', '2026-02-04 09:56:51');

-- ----------------------------
-- Table structure for sj_notify_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_notify_config`;
CREATE TABLE `sj_notify_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `notify_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '通知名称',
  `system_task_type` tinyint NOT NULL DEFAULT 3 COMMENT '任务类型 1. 重试任务 2. 重试回调 3、JOB任务 4、WORKFLOW任务',
  `notify_status` tinyint NOT NULL DEFAULT 0 COMMENT '通知状态 0、未启用 1、启用',
  `recipient_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收人id列表',
  `notify_threshold` int NOT NULL DEFAULT 0 COMMENT '通知阈值',
  `notify_scene` tinyint NOT NULL DEFAULT 0 COMMENT '通知场景',
  `rate_limiter_status` tinyint NOT NULL DEFAULT 0 COMMENT '限流状态 0、未启用 1、启用',
  `rate_limiter_threshold` int NOT NULL DEFAULT 0 COMMENT '每秒限流阈值',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id_group_name_scene_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_notify_config
-- ----------------------------

-- ----------------------------
-- Table structure for sj_notify_recipient
-- ----------------------------
DROP TABLE IF EXISTS `sj_notify_recipient`;
CREATE TABLE `sj_notify_recipient`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `recipient_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收人名称',
  `notify_type` tinyint NOT NULL DEFAULT 0 COMMENT '通知类型 1、钉钉 2、邮件 3、企业微信 4 飞书 5 webhook',
  `notify_attribute` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置属性',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id`(`namespace_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '告警通知接收人' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_notify_recipient
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry`;
CREATE TABLE `sj_retry`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '执行器名称',
  `args_str` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '扩展字段',
  `serializer_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'jackson' COMMENT '执行方法参数序列化器名称',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `retry_count` int NOT NULL DEFAULT 0 COMMENT '重试次数',
  `retry_status` tinyint NOT NULL DEFAULT 0 COMMENT '重试状态 0、重试中 1、成功 2、最大重试次数',
  `task_type` tinyint NOT NULL DEFAULT 1 COMMENT '任务类型 1、重试数据 2、回调数据',
  `bucket_index` int NOT NULL DEFAULT 0 COMMENT 'bucket',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父节点id',
  `deleted` bigint NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_scene_tasktype_idempotentid_deleted`(`scene_id` ASC, `task_type` ASC, `idempotent_id` ASC, `deleted` ASC) USING BTREE,
  INDEX `idx_biz_no`(`biz_no` ASC) USING BTREE,
  INDEX `idx_idempotent_id`(`idempotent_id` ASC) USING BTREE,
  INDEX `idx_retry_status_bucket_index`(`retry_status` ASC, `bucket_index` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '重试信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_dead_letter
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_dead_letter`;
CREATE TABLE `sj_retry_dead_letter`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '执行器名称',
  `serializer_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'jackson' COMMENT '执行方法参数序列化器名称',
  `args_str` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id_group_name_scene_name`(`namespace_id` ASC, `group_name` ASC, `scene_name` ASC) USING BTREE,
  INDEX `idx_idempotent_id`(`idempotent_id` ASC) USING BTREE,
  INDEX `idx_biz_no`(`biz_no` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '死信队列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry_dead_letter
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_scene_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_scene_config`;
CREATE TABLE `sj_retry_scene_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `scene_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '场景名称',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `scene_status` tinyint NOT NULL DEFAULT 0 COMMENT '组状态 0、未启用 1、启用',
  `max_retry_count` int NOT NULL DEFAULT 5 COMMENT '最大重试次数',
  `back_off` tinyint NOT NULL DEFAULT 1 COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `trigger_interval` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '间隔时长',
  `notify_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `deadline_request` bigint UNSIGNED NOT NULL DEFAULT 60000 COMMENT 'Deadline Request 调用链超时 单位毫秒',
  `executor_timeout` int UNSIGNED NOT NULL DEFAULT 5 COMMENT '任务执行超时时间，单位秒',
  `route_key` tinyint NOT NULL DEFAULT 4 COMMENT '路由策略',
  `block_strategy` tinyint NOT NULL DEFAULT 1 COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `cb_status` tinyint NOT NULL DEFAULT 0 COMMENT '回调状态 0、不开启 1、开启',
  `cb_trigger_type` tinyint NOT NULL DEFAULT 1 COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `cb_max_count` int NOT NULL DEFAULT 16 COMMENT '回调的最大执行次数',
  `cb_trigger_interval` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '回调的最大执行次数',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '负责人id',
  `labels` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_namespace_id_group_name_scene_name`(`namespace_id` ASC, `group_name` ASC, `scene_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '场景配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry_scene_config
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_summary
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_summary`;
CREATE TABLE `sj_retry_summary`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '组名称',
  `scene_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '场景名称',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `running_num` int NOT NULL DEFAULT 0 COMMENT '重试中-日志数量',
  `finish_num` int NOT NULL DEFAULT 0 COMMENT '重试完成-日志数量',
  `max_count_num` int NOT NULL DEFAULT 0 COMMENT '重试到达最大次数-日志数量',
  `suspend_num` int NOT NULL DEFAULT 0 COMMENT '暂停重试-日志数量',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_scene_name_trigger_at`(`namespace_id` ASC, `group_name` ASC, `scene_name` ASC, `trigger_at` ASC) USING BTREE,
  INDEX `idx_trigger_at`(`trigger_at` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'DashBoard_Retry' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry_summary
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_task
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_task`;
CREATE TABLE `sj_retry_task`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `scene_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '场景名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `ext_attrs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '扩展字段',
  `task_status` tinyint NOT NULL DEFAULT 1 COMMENT '重试状态',
  `task_type` tinyint NOT NULL DEFAULT 1 COMMENT '任务类型 1、重试数据 2、回调数据',
  `operation_reason` tinyint NOT NULL DEFAULT 0 COMMENT '操作原因',
  `client_info` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group_name_scene_name`(`namespace_id` ASC, `group_name` ASC, `scene_name` ASC) USING BTREE,
  INDEX `task_status`(`task_status` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_retry_id`(`retry_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '重试任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry_task
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_task_log_message
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_task_log_message`;
CREATE TABLE `sj_retry_task_log_message`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `retry_task_id` bigint NOT NULL COMMENT '重试任务Id',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '异常信息',
  `log_num` int NOT NULL DEFAULT 1 COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT 0 COMMENT '上报时间',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_namespace_id_group_name_retry_task_id`(`namespace_id` ASC, `group_name` ASC, `retry_task_id` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务调度日志信息记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_retry_task_log_message
-- ----------------------------

-- ----------------------------
-- Table structure for sj_server_node
-- ----------------------------
DROP TABLE IF EXISTS `sj_server_node`;
CREATE TABLE `sj_server_node`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `host_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主机id',
  `host_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '机器ip',
  `host_port` int NOT NULL COMMENT '机器端口',
  `expire_at` datetime NOT NULL COMMENT '过期时间',
  `node_type` tinyint NOT NULL COMMENT '节点类型 1、客户端 2、是服务端',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `labels` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '标签',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_host_id_host_ip`(`host_id` ASC, `host_ip` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE,
  INDEX `idx_expire_at_node_type`(`expire_at` ASC, `node_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '服务器节点' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_server_node
-- ----------------------------

-- ----------------------------
-- Table structure for sj_system_user
-- ----------------------------
DROP TABLE IF EXISTS `sj_system_user`;
CREATE TABLE `sj_system_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL DEFAULT 0 COMMENT '角色：1-普通用户、2-管理员',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_system_user
-- ----------------------------
INSERT INTO `sj_system_user` VALUES (1, 'admin', '465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', 2, '2026-02-04 09:56:51', '2026-02-04 09:56:51');

-- ----------------------------
-- Table structure for sj_system_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `sj_system_user_permission`;
CREATE TABLE `sj_system_user_permission`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `system_user_id` bigint NOT NULL COMMENT '系统用户id',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_namespace_id_group_name_system_user_id`(`namespace_id` ASC, `group_name` ASC, `system_user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_system_user_permission
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow`;
CREATE TABLE `sj_workflow`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `workflow_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工作流名称',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `workflow_status` tinyint NOT NULL DEFAULT 1 COMMENT '工作流状态 0、关闭、1、开启',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '间隔时长',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `block_strategy` tinyint NOT NULL DEFAULT 1 COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `executor_timeout` int NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `flow_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '流程信息',
  `wf_context` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '上下文',
  `notify_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `bucket_index` int NOT NULL DEFAULT 0 COMMENT 'bucket',
  `version` int NOT NULL COMMENT '版本号',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '负责人id',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow_node
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow_node`;
CREATE TABLE `sj_workflow_node`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `node_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '节点名称',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `workflow_id` bigint NOT NULL COMMENT '工作流ID',
  `node_type` tinyint NOT NULL DEFAULT 1 COMMENT '1、任务节点 2、条件节点',
  `expression_type` tinyint NOT NULL DEFAULT 0 COMMENT '1、SpEl、2、Aviator 3、QL',
  `fail_strategy` tinyint NOT NULL DEFAULT 1 COMMENT '失败策略 1、跳过 2、阻塞',
  `workflow_node_status` tinyint NOT NULL DEFAULT 1 COMMENT '工作流节点状态 0、关闭、1、开启',
  `priority_level` int NOT NULL DEFAULT 1 COMMENT '优先级',
  `node_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '节点信息 ',
  `version` int NOT NULL COMMENT '版本号',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流节点' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sj_workflow_node
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow_task_batch
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow_task_batch`;
CREATE TABLE `sj_workflow_task_batch`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名称',
  `workflow_id` bigint NOT NULL COMMENT '工作流任务id',
  `task_batch_status` tinyint NOT NULL DEFAULT 0 COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT 0 COMMENT '操作原因',
  `flow_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '流程信息',
  `wf_context` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '全局上下文',
  `execution_at` bigint NOT NULL DEFAULT 0 COMMENT '任务执行时间',
  `ext_attrs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `version` int NOT NULL DEFAULT 1 COMMENT '版本号',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_job_id_task_batch_status`(`workflow_id` ASC, `task_batch_status` ASC) USING BTREE,
  INDEX `idx_create_dt`(`create_dt` ASC) USING BTREE,
  INDEX `idx_namespace_id_group_name`(`namespace_id` ASC, `group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流批次' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sj_workflow_task_batch
-- ----------------------------

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE `sys_client`  (
  `id` bigint NOT NULL COMMENT 'id',
  `client_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int NULL DEFAULT 1800 COMMENT 'token活跃超时时间',
  `timeout` int NULL DEFAULT 604800 COMMENT 'token固定超时',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统授权表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_client
-- ----------------------------
INSERT INTO `sys_client` VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50');
INSERT INTO `sys_client` VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', '0', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, 'true:开启, false:关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` bigint NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', '梵熙纸业', NULL, 0, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-26 12:21:46');
INSERT INTO `sys_dept` VALUES (101, '000000', 100, '0,100', '系统开发', NULL, 1, NULL, '13924683996', '1987291625@qq.com', '0', '0', 103, 1, '2026-02-04 09:56:49', 2040792051533103106, '2026-04-05 22:18:28');
INSERT INTO `sys_dept` VALUES (103, '000000', 101, '0,100,101', '研发部门', NULL, 1, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL);
INSERT INTO `sys_dept` VALUES (2040728717316210689, '000000', 100, '0,100', '生产部', '生产', 0, NULL, NULL, NULL, '0', '0', 103, 1, '2026-04-05 17:50:16', 1, '2026-04-05 17:50:16');
INSERT INTO `sys_dept` VALUES (2040728840905572353, '000000', 100, '0,100', '财务部', '财务', 0, NULL, NULL, NULL, '0', '0', 103, 1, '2026-04-05 17:50:45', 1, '2026-04-05 17:50:45');
INSERT INTO `sys_dept` VALUES (2040728904776433666, '000000', 100, '0,100', '经理室', '经理', 0, NULL, NULL, NULL, '0', '0', 103, 1, '2026-04-05 17:51:00', 1, '2026-04-05 17:51:00');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '密码认证');
INSERT INTO `sys_dict_data` VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '短信认证');
INSERT INTO `sys_dict_data` VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '邮件认证');
INSERT INTO `sys_dict_data` VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '小程序认证');
INSERT INTO `sys_dict_data` VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '三方登录认证');
INSERT INTO `sys_dict_data` VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, 'PC');
INSERT INTO `sys_dict_data` VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '安卓');
INSERT INTO `sys_dict_data` VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, 'iOS');
INSERT INTO `sys_dict_data` VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '小程序');
INSERT INTO `sys_dict_data` VALUES (39, '000000', 1, '已撤销', 'cancel', 'wf_business_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '已撤销');
INSERT INTO `sys_dict_data` VALUES (40, '000000', 2, '草稿', 'draft', 'wf_business_status', '', 'info', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '草稿');
INSERT INTO `sys_dict_data` VALUES (41, '000000', 3, '待审核', 'waiting', 'wf_business_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '待审核');
INSERT INTO `sys_dict_data` VALUES (42, '000000', 4, '已完成', 'finish', 'wf_business_status', '', 'success', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '已完成');
INSERT INTO `sys_dict_data` VALUES (43, '000000', 5, '已作废', 'invalid', 'wf_business_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '已作废');
INSERT INTO `sys_dict_data` VALUES (44, '000000', 6, '已退回', 'back', 'wf_business_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '已退回');
INSERT INTO `sys_dict_data` VALUES (45, '000000', 7, '已终止', 'termination', 'wf_business_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '已终止');
INSERT INTO `sys_dict_data` VALUES (46, '000000', 1, '自定义表单', 'static', 'wf_form_type', '', 'success', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '自定义表单');
INSERT INTO `sys_dict_data` VALUES (47, '000000', 2, '动态表单', 'dynamic', 'wf_form_type', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '动态表单');
INSERT INTO `sys_dict_data` VALUES (48, '000000', 1, '撤销', 'cancel', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '撤销');
INSERT INTO `sys_dict_data` VALUES (49, '000000', 2, '通过', 'pass', 'wf_task_status', '', 'success', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '通过');
INSERT INTO `sys_dict_data` VALUES (50, '000000', 3, '待审核', 'waiting', 'wf_task_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '待审核');
INSERT INTO `sys_dict_data` VALUES (51, '000000', 4, '作废', 'invalid', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '作废');
INSERT INTO `sys_dict_data` VALUES (52, '000000', 5, '退回', 'back', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '退回');
INSERT INTO `sys_dict_data` VALUES (53, '000000', 6, '终止', 'termination', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '终止');
INSERT INTO `sys_dict_data` VALUES (54, '000000', 7, '转办', 'transfer', 'wf_task_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '转办');
INSERT INTO `sys_dict_data` VALUES (55, '000000', 8, '委托', 'depute', 'wf_task_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '委托');
INSERT INTO `sys_dict_data` VALUES (56, '000000', 9, '抄送', 'copy', 'wf_task_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '抄送');
INSERT INTO `sys_dict_data` VALUES (57, '000000', 10, '加签', 'sign', 'wf_task_status', '', 'primary', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '加签');
INSERT INTO `sys_dict_data` VALUES (58, '000000', 11, '减签', 'sign_off', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '减签');
INSERT INTO `sys_dict_data` VALUES (59, '000000', 11, '超时', 'timeout', 'wf_task_status', '', 'danger', 'N', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '超时');
INSERT INTO `sys_dict_data` VALUES (2020044691248001026, '000000', 1, '单面', '1', 'erp_print_type', '', 'primary', 'N', 103, 1, '2026-02-07 15:59:20', 1, '2026-02-07 16:00:12', '');
INSERT INTO `sys_dict_data` VALUES (2020049508733300737, '000000', 1, '普通客户', '1', 'erp_customer_type', '', 'primary', 'N', 103, 1, '2026-02-07 16:18:28', 1, '2026-02-07 16:18:37', '');
INSERT INTO `sys_dict_data` VALUES (2020049646402940929, '000000', 2, '供应商', '2', 'erp_customer_type', '', 'success', 'N', 103, 1, '2026-02-07 16:19:01', 1, '2026-02-07 16:19:01', '');
INSERT INTO `sys_dict_data` VALUES (2020145618160283650, '000000', 1, '成品', '1', 'erp_item_type', '', 'primary', 'N', 103, 1, '2026-02-07 22:40:23', 1, '2026-02-07 22:40:23', '');
INSERT INTO `sys_dict_data` VALUES (2020145708107132930, '000000', 2, '配件', '2', 'erp_item_type', '', 'success', 'N', 103, 1, '2026-02-07 22:40:44', 1, '2026-02-07 22:41:11', '');
INSERT INTO `sys_dict_data` VALUES (2020145784514768897, '000000', 3, '纸张', '3', 'erp_item_type', '', 'warning', 'N', 103, 1, '2026-02-07 22:41:02', 1, '2026-02-07 22:41:02', '');
INSERT INTO `sys_dict_data` VALUES (2020147099601039361, '000000', 1, '个', '1', 'erp_item_unit', '', 'default', 'N', 103, 1, '2026-02-07 22:46:16', 1, '2026-02-08 11:25:11', '个');
INSERT INTO `sys_dict_data` VALUES (2020147141581828097, '000000', 2, '张', '2', 'erp_item_unit', '', 'default', 'N', 103, 1, '2026-02-07 22:46:26', 1, '2026-02-08 11:25:17', '张');
INSERT INTO `sys_dict_data` VALUES (2020147209307254786, '000000', 3, '份', '3', 'erp_item_unit', '', 'default', 'N', 103, 1, '2026-02-07 22:46:42', 1, '2026-02-08 11:25:29', '份');
INSERT INTO `sys_dict_data` VALUES (2020338223758258177, '000000', 4, '册', '4', 'erp_item_unit', '', 'default', 'N', 103, 1, '2026-02-08 11:25:43', 1, '2026-02-08 11:25:43', '册');
INSERT INTO `sys_dict_data` VALUES (2021599966551695362, '000000', 1, '4C', '1', 'erp_print_color', '', 'default', 'N', 103, 1, '2026-02-11 22:59:26', 1, '2026-02-11 22:59:43', '');
INSERT INTO `sys_dict_data` VALUES (2021600014819745793, '000000', 2, '3C', '2', 'erp_print_color', '', 'default', 'N', 103, 1, '2026-02-11 22:59:38', 1, '2026-02-11 22:59:38', '');
INSERT INTO `sys_dict_data` VALUES (2021795138140987393, '000000', 1, '未排产', '1', 'erp_prod_status', '', 'info', 'N', 103, 1, '2026-02-12 11:54:59', 1, '2026-02-12 11:54:59', '');
INSERT INTO `sys_dict_data` VALUES (2021795218545795074, '000000', 2, '已排产', '2', 'erp_prod_status', '', 'primary', 'N', 103, 1, '2026-02-12 11:55:18', 1, '2026-02-12 11:55:18', '');
INSERT INTO `sys_dict_data` VALUES (2021795286430605313, '000000', 3, '已完成', '3', 'erp_prod_status', '', 'success', 'N', 103, 1, '2026-02-12 11:55:34', 1, '2026-02-12 11:55:34', '');
INSERT INTO `sys_dict_data` VALUES (2021795382362726402, '000000', 4, '异常中', '4', 'erp_prod_status', '', 'danger', 'N', 103, 1, '2026-02-12 11:55:57', 1, '2026-02-12 11:55:57', '');
INSERT INTO `sys_dict_data` VALUES (2022313823905357826, '000000', 1, '过油', '1', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:16:03', 1, '2026-02-13 22:17:14', '过油');
INSERT INTO `sys_dict_data` VALUES (2022313868012658690, '000000', 2, '光胶', '2', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:16:14', 1, '2026-02-13 22:17:26', '光胶');
INSERT INTO `sys_dict_data` VALUES (2022313923109036034, '000000', 3, '亮膜', '3', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:16:27', 1, '2026-02-13 22:16:27', '');
INSERT INTO `sys_dict_data` VALUES (2022313981430833154, '000000', 4, '哑膜', '4', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:16:41', 1, '2026-02-13 22:16:41', '');
INSERT INTO `sys_dict_data` VALUES (2022314062817107969, '000000', 5, '磨光', '5', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:17:00', 1, '2026-02-13 22:24:44', '磨光');
INSERT INTO `sys_dict_data` VALUES (2022315817277693953, '000000', 6, '烫银', '6', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:23:58', 1, '2026-02-13 22:24:31', '烫银');
INSERT INTO `sys_dict_data` VALUES (2022315908977762305, '000000', 7, '烫金', '7', 'erp_process_name', '', 'primary', 'N', 103, 1, '2026-02-13 22:24:20', 1, '2026-02-13 22:24:20', '烫金');
INSERT INTO `sys_dict_data` VALUES (2022529282403827714, '000000', 1, '模切', '1', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-02-14 12:32:12', 1, '2026-02-14 12:32:12', '');
INSERT INTO `sys_dict_data` VALUES (2022529314351841282, '000000', 2, '表面处理', '2', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-02-14 12:32:20', 1, '2026-04-05 18:12:22', '');
INSERT INTO `sys_dict_data` VALUES (2022529380475043842, '000000', 3, 'uv', '3', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-02-14 12:32:36', 1, '2026-02-14 12:32:36', '');
INSERT INTO `sys_dict_data` VALUES (2040730671895429121, '000000', 5, '运输物流', '5', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-04-05 17:58:02', 1, '2026-04-05 17:58:02', '');
INSERT INTO `sys_dict_data` VALUES (2040731652855054337, '000000', 6, '后道工序', '6', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-04-05 18:01:56', 1, '2026-04-05 21:00:23', '');
INSERT INTO `sys_dict_data` VALUES (2040732431515009025, '000000', 7, '原纸材料', '7', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-04-05 18:05:01', 1, '2026-04-05 18:05:01', '');
INSERT INTO `sys_dict_data` VALUES (2040733662190911490, '000000', 8, '模具', '8', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-04-05 18:09:55', 1, '2026-04-05 18:09:55', '');
INSERT INTO `sys_dict_data` VALUES (2040776698627244033, '000000', 9, '印刷车间', '9', 'erp_supplier_category', '', 'primary', 'N', 103, 1, '2026-04-05 21:00:55', 1, '2026-04-05 21:01:19', '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `tenant_id`(`tenant_id` ASC, `dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '认证授权类型');
INSERT INTO `sys_dict_type` VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES (13, '000000', '业务状态', 'wf_business_status', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '业务状态列表');
INSERT INTO `sys_dict_type` VALUES (14, '000000', '表单类型', 'wf_form_type', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '表单类型列表');
INSERT INTO `sys_dict_type` VALUES (15, '000000', '任务状态', 'wf_task_status', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '任务状态');
INSERT INTO `sys_dict_type` VALUES (2019695918961512450, '000000', '工单-层数', 'erp_layer_count', 103, 1, '2026-02-06 16:53:26', 1, '2026-02-06 16:53:26', '生产工单层数选择');
INSERT INTO `sys_dict_type` VALUES (2019695998581985282, '000000', '工单-纸张来源', 'erp_paper_source', 103, 1, '2026-02-06 16:53:45', 1, '2026-02-06 16:53:45', '纸张来源类型');
INSERT INTO `sys_dict_type` VALUES (2019696089220894722, '000000', '工单-CTP来源', 'erp_ctp_source', 103, 1, '2026-02-06 16:54:06', 1, '2026-02-06 16:54:06', 'CTP或菲林来源');
INSERT INTO `sys_dict_type` VALUES (2019696396902453250, '000000', '工单-印刷方式', 'erp_print_type', 103, 1, '2026-02-06 16:55:20', 1, '2026-02-06 16:55:20', '');
INSERT INTO `sys_dict_type` VALUES (2019696477030436865, '000000', '工单-印色', 'erp_print_color', 103, 1, '2026-02-06 16:55:39', 1, '2026-02-06 16:55:39', '印刷颜色组合');
INSERT INTO `sys_dict_type` VALUES (2019696545649250305, '000000', '工单-结构类型', 'erp_struct_type', 103, 1, '2026-02-06 16:55:55', 1, '2026-02-06 16:55:55', '包装盒结构类型');
INSERT INTO `sys_dict_type` VALUES (2019696628176375810, '000000', '工单-工艺项目', 'erp_process_name', 103, 1, '2026-02-06 16:56:15', 1, '2026-02-06 16:56:15', '工艺子表的项目名称');
INSERT INTO `sys_dict_type` VALUES (2019696684510072834, '000000', '工单-表面处理', 'erp_process_surface', 103, 1, '2026-02-06 16:56:28', 1, '2026-02-06 16:56:28', '表面处理的具体内容');
INSERT INTO `sys_dict_type` VALUES (2020049222358806530, '000000', '客户类型', 'erp_customer_type', 103, 1, '2026-02-07 16:17:20', 1, '2026-02-07 16:17:20', '');
INSERT INTO `sys_dict_type` VALUES (2020145408793210882, '000000', '库存物料类型', 'erp_item_type', 103, 1, '2026-02-07 22:39:33', 1, '2026-02-07 22:39:33', '');
INSERT INTO `sys_dict_type` VALUES (2020147020303527938, '000000', '单位', 'erp_item_unit', 103, 1, '2026-02-07 22:45:57', 1, '2026-02-07 22:45:57', '');
INSERT INTO `sys_dict_type` VALUES (2021795021568696322, '000000', '生产状态', 'erp_prod_status', 103, 1, '2026-02-12 11:54:31', 1, '2026-02-12 11:54:31', '');
INSERT INTO `sys_dict_type` VALUES (2022529209901088769, '000000', '供应商分类', 'erp_supplier_category', 103, 1, '2026-02-14 12:31:55', 1, '2026-02-14 12:31:55', '');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (2040786398634721281, '000000', '谭智新', 'pc', 'pc', '113.117.208.130', '中国|广东省|中山市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-05 21:39:28');
INSERT INTO `sys_logininfor` VALUES (2040787492953800706, '000000', '谭智新', 'pc', 'pc', '113.117.208.130', '中国|广东省|中山市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-05 21:43:49');
INSERT INTO `sys_logininfor` VALUES (2041053041688518657, '000000', 'test', 'pc', 'pc', '104.192.92.87', '美国|密歇根|0|0', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-06 15:19:01');
INSERT INTO `sys_logininfor` VALUES (2041053106129805313, '000000', 'admin', 'pc', 'pc', '104.192.92.87', '美国|密歇根|0|0', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-06 15:19:16');
INSERT INTO `sys_logininfor` VALUES (2041065246312046593, '000000', 'admin', 'pc', 'pc', '104.192.92.87', '美国|密歇根|0|0', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-06 16:07:31');
INSERT INTO `sys_logininfor` VALUES (2041136756074684418, '000000', 'test', 'pc', 'pc', '113.117.208.130', '中国|广东省|中山市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-06 20:51:40');
INSERT INTO `sys_logininfor` VALUES (2041141381817376769, '000000', 'admin', 'pc', 'pc', '104.192.92.87', '美国|密歇根|0|0', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-06 21:10:03');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '1', '0', '', 'tool', 103, 1, '2026-02-04 09:56:49', 1, '2026-04-05 17:20:03', '系统工具目录');
INSERT INTO `sys_menu` VALUES (5, '测试菜单', 0, 5, 'demo', NULL, '', 1, 0, 'M', '1', '0', '', 'star', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-08 14:29:01', '测试菜单');
INSERT INTO `sys_menu` VALUES (6, '租户管理', 0, 2, 'tenant', NULL, '', 1, 0, 'M', '1', '1', '', 'chart', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-07 22:54:50', '租户管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 0, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-26 12:21:04', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '修改生成配置', 3, 2, 'gen-edit/index/:tableId', 'tool/gen/editTable', '', 1, 1, 'C', '1', '0', 'tool:gen:edit', '#', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-08 14:27:16', '/tool/gen');
INSERT INTO `sys_menu` VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', 1, 0, 'C', '1', '1', 'monitor:admin:list', 'dashboard', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-26 15:48:24', 'Admin监控菜单');
INSERT INTO `sys_menu` VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '文件管理菜单');
INSERT INTO `sys_menu` VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', '', 1, 0, 'C', '1', '1', 'monitor:snailjob:list', 'job', 103, 1, '2026-02-04 09:56:49', 1, '2026-02-26 15:48:44', 'SnailJob控制台菜单');
INSERT INTO `sys_menu` VALUES (121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', '', 1, 0, 'C', '0', '0', 'system:tenant:list', 'list', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '租户管理菜单');
INSERT INTO `sys_menu` VALUES (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', 1, 0, 'C', '0', '0', 'system:tenantPackage:list', 'form', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '租户套餐管理菜单');
INSERT INTO `sys_menu` VALUES (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', 1, 0, 'C', '0', '0', 'system:client:list', 'international', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '客户端管理菜单');
INSERT INTO `sys_menu` VALUES (130, '分配用户', 1, 2, 'role-auth/user/:roleId', 'system/role/authUser', '', 1, 1, 'C', '1', '0', 'system:role:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '/system/role');
INSERT INTO `sys_menu` VALUES (131, '分配角色', 1, 1, 'user-auth/role/:userId', 'system/user/authRole', '', 1, 1, 'C', '1', '0', 'system:user:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '/system/user');
INSERT INTO `sys_menu` VALUES (132, '字典数据', 1, 6, 'dict-data/index/:dictId', 'system/dict/data', '', 1, 1, 'C', '1', '0', 'system:dict:list', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '/system/dict');
INSERT INTO `sys_menu` VALUES (133, '文件配置管理', 1, 10, 'oss-config/index', 'system/oss/config', '', 1, 1, 'C', '1', '0', 'system:ossConfig:list', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '/system/oss');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1500, '测试单表', 5, 1, 'demo', 'demo/demo/index', '', 1, 0, 'C', '0', '0', 'demo:demo:list', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '测试单表菜单');
INSERT INTO `sys_menu` VALUES (1501, '测试单表查询', 1500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1502, '测试单表新增', 1500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1503, '测试单表修改', 1500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1504, '测试单表删除', 1500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1505, '测试单表导出', 1500, 5, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1506, '测试树表', 5, 1, 'tree', 'demo/tree/index', '', 1, 0, 'C', '0', '0', 'demo:tree:list', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '测试树表菜单');
INSERT INTO `sys_menu` VALUES (1507, '测试树表查询', 1506, 1, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1508, '测试树表新增', 1506, 2, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1509, '测试树表修改', 1506, 3, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1510, '测试树表删除', 1506, 4, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1511, '测试树表导出', 1506, 5, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1600, '文件查询', 118, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1601, '文件上传', 118, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1602, '文件下载', 118, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:download', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1603, '文件删除', 118, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1606, '租户查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1607, '租户新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1608, '租户修改', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1609, '租户删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1610, '租户导出', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:export', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1611, '租户套餐查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:query', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1612, '租户套餐新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1613, '租户套餐修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1620, '配置列表', 118, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:list', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1621, '配置添加', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:add', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1622, '配置编辑', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:edit', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1623, '配置删除', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11616, '工作流', 0, 6, 'workflow', '', '', 1, 0, 'M', '1', '0', '', 'workflow', 103, 1, '2026-02-04 09:56:51', 1, '2026-02-26 09:43:19', '');
INSERT INTO `sys_menu` VALUES (11618, '我的任务', 0, 7, 'task', '', '', 1, 0, 'M', '1', '0', '', 'my-task', 103, 1, '2026-02-04 09:56:51', 1, '2026-02-26 09:43:05', '');
INSERT INTO `sys_menu` VALUES (11619, '我的待办', 11618, 2, 'taskWaiting', 'workflow/task/taskWaiting', '', 1, 1, 'C', '0', '0', '', 'waiting', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11620, '流程定义', 11616, 3, 'processDefinition', 'workflow/processDefinition/index', '', 1, 1, 'C', '0', '0', '', 'process-definition', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11621, '流程实例', 11630, 1, 'processInstance', 'workflow/processInstance/index', '', 1, 1, 'C', '0', '0', '', 'tree-table', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11622, '流程分类', 11616, 1, 'category', 'workflow/category/index', '', 1, 0, 'C', '0', '0', 'workflow:category:list', 'category', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11623, '流程分类查询', 11622, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:query', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11624, '流程分类新增', 11622, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:add', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11625, '流程分类修改', 11622, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:edit', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11626, '流程分类删除', 11622, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:remove', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11627, '流程分类导出', 11622, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:export', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11629, '我发起的', 11618, 1, 'myDocument', 'workflow/task/myDocument', '', 1, 1, 'C', '0', '0', '', 'guide', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11630, '流程监控', 11616, 4, 'monitor', '', '', 1, 0, 'M', '0', '0', '', 'monitor', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11631, '待办任务', 11630, 2, 'allTaskWaiting', 'workflow/task/allTaskWaiting', '', 1, 1, 'C', '0', '0', '', 'waiting', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11632, '我的已办', 11618, 3, 'taskFinish', 'workflow/task/taskFinish', '', 1, 1, 'C', '0', '0', '', 'finish', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11633, '我的抄送', 11618, 4, 'taskCopyList', 'workflow/task/taskCopyList', '', 1, 1, 'C', '0', '0', '', 'my-copy', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11638, '请假申请', 5, 1, 'leave', 'workflow/leave/index', '', 1, 0, 'C', '0', '0', 'workflow:leave:list', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '请假申请菜单');
INSERT INTO `sys_menu` VALUES (11639, '请假申请查询', 11638, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:query', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11640, '请假申请新增', 11638, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:add', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11641, '请假申请修改', 11638, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:edit', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11642, '请假申请删除', 11638, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:remove', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11643, '请假申请导出', 11638, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:export', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11700, '流程设计', 11616, 5, 'design/index', 'workflow/processDefinition/design', '', 1, 1, 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '/workflow/processDefinition');
INSERT INTO `sys_menu` VALUES (11701, '请假申请', 11616, 6, 'leaveEdit/index', 'workflow/leave/leaveEdit', '', 1, 1, 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11801, '流程表达式', 11616, 2, 'spel', 'workflow/spel/index', '', 1, 0, 'C', '0', '0', 'workflow:spel:list', 'input', 103, 1, '2026-02-04 09:56:51', 1, '2026-02-04 09:56:51', '流程达式定义菜单');
INSERT INTO `sys_menu` VALUES (11802, '流程达式定义查询', 11801, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:query', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11803, '流程达式定义新增', 11801, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:add', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11804, '流程达式定义修改', 11801, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:edit', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11805, '流程达式定义删除', 11801, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:remove', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (11806, '流程达式定义导出', 11801, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'workflow:spel:export', '#', 103, 1, '2026-02-04 09:56:51', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020050217822334977, '客户及供应商', 0, 13, 'customer', 'erp/customer/index', NULL, 1, 0, 'C', '0', '0', 'erp:customer:list', 'peoples', 103, 1, '2026-02-07 16:22:01', 1, '2026-03-04 11:16:16', '客户及供应商菜单');
INSERT INTO `sys_menu` VALUES (2020050217822334978, '客户及供应商查询', 2020050217822334977, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:customer:query', '#', 103, 1, '2026-02-07 16:22:01', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020050217822334979, '客户及供应商新增', 2020050217822334977, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:customer:add', '#', 103, 1, '2026-02-07 16:22:01', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020050217822334980, '客户及供应商修改', 2020050217822334977, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:customer:edit', '#', 103, 1, '2026-02-07 16:22:01', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020050217822334981, '客户及供应商删除', 2020050217822334977, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:customer:remove', '#', 103, 1, '2026-02-07 16:22:01', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020050217822334982, '客户及供应商导出', 2020050217822334977, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:customer:export', '#', 103, 1, '2026-02-07 16:22:01', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020415020961181697, '库存管理', 0, 11, 'inventory', 'erp/inventory/index', NULL, 1, 0, 'C', '0', '0', 'erp:inventory:list', 'model', 103, 1, '2026-02-08 16:32:07', 1, '2026-03-04 11:15:48', '库存管理菜单');
INSERT INTO `sys_menu` VALUES (2020415020961181698, '库存管理查询', 2020415020961181697, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:inventory:query', '#', 103, 1, '2026-02-08 16:32:07', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020415020961181699, '库存管理新增', 2020415020961181697, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:inventory:add', '#', 103, 1, '2026-02-08 16:32:07', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020415020961181700, '库存管理修改', 2020415020961181697, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:inventory:edit', '#', 103, 1, '2026-02-08 16:32:07', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020415020961181701, '库存管理删除', 2020415020961181697, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:inventory:remove', '#', 103, 1, '2026-02-08 16:32:07', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2020415020961181702, '库存管理导出', 2020415020961181697, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:inventory:export', '#', 103, 1, '2026-02-08 16:32:07', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2022122396940365825, '工单管理', 0, 9, 'workOrder', 'erp/workOrder/index', NULL, 1, 0, 'C', '0', '0', 'erp:workOrder:list', 'clipboard', 103, 1, '2026-02-13 09:36:25', 1, '2026-03-04 11:15:32', '工单管理菜单');
INSERT INTO `sys_menu` VALUES (2022122396940365826, '工单管理查询', 2022122396940365825, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:workOrder:query', '#', 103, 1, '2026-02-13 09:36:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2022122396940365827, '工单管理新增', 2022122396940365825, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:workOrder:add', '#', 103, 1, '2026-02-13 09:36:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2022122396940365828, '工单管理修改', 2022122396940365825, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:workOrder:edit', '#', 103, 1, '2026-02-13 09:36:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2022122396940365829, '工单管理删除', 2022122396940365825, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:workOrder:remove', '#', 103, 1, '2026-02-13 09:36:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2022122396940365830, '工单管理导出', 2022122396940365825, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:workOrder:export', '#', 103, 1, '2026-02-13 09:36:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334192193826818, '排产工序节点状态', 0, 1, 'scheduleNode', 'erp/scheduleNode/index', NULL, 1, 0, 'C', '1', '0', 'erp:scheduleNode:list', 'log', 103, 1, '2026-03-02 13:37:22', 1, '2026-03-02 19:32:57', '排产工序节点状态菜单');
INSERT INTO `sys_menu` VALUES (2028334192193826819, '排产工序节点状态查询', 2028334192193826818, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:scheduleNode:query', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334192193826820, '排产工序节点状态新增', 2028334192193826818, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:scheduleNode:add', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334192193826821, '排产工序节点状态修改', 2028334192193826818, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:scheduleNode:edit', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334192193826822, '排产工序节点状态删除', 2028334192193826818, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:scheduleNode:remove', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334192193826823, '排产工序节点状态导出', 2028334192193826818, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:scheduleNode:export', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334193993183234, '排产管理', 0, 12, 'productionSchedule', 'erp/productionSchedule/index', NULL, 1, 0, 'C', '0', '0', 'erp:productionSchedule:list', 'nested', 103, 1, '2026-03-02 13:37:22', 1, '2026-03-04 11:16:02', '生产排产主菜单');
INSERT INTO `sys_menu` VALUES (2028334193993183235, '生产排产主查询', 2028334193993183234, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:productionSchedule:query', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334193993183236, '生产排产主新增', 2028334193993183234, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:productionSchedule:add', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334193993183237, '生产排产主修改', 2028334193993183234, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:productionSchedule:edit', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334193993183238, '生产排产主删除', 2028334193993183234, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:productionSchedule:remove', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028334193993183239, '生产排产主导出', 2028334193993183234, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:productionSchedule:export', '#', 103, 1, '2026-03-02 13:37:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028369514294255617, '采购管理', 0, 10, 'purchase', 'erp/purchase/index', NULL, 1, 0, 'C', '0', '0', 'erp:purchase:list', 'shopping', 103, 1, '2026-03-02 15:20:27', 1, '2026-03-04 11:15:40', '采购管理菜单');
INSERT INTO `sys_menu` VALUES (2028369514294255618, '采购管理查询', 2028369514294255617, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:purchase:query', '#', 103, 1, '2026-03-02 15:20:27', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028369514294255619, '采购管理新增', 2028369514294255617, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:purchase:add', '#', 103, 1, '2026-03-02 15:20:27', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028369514294255620, '采购管理修改', 2028369514294255617, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:purchase:edit', '#', 103, 1, '2026-03-02 15:20:27', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028369514294255621, '采购管理删除', 2028369514294255617, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:purchase:remove', '#', 103, 1, '2026-03-02 15:20:27', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028369514294255622, '采购管理导出', 2028369514294255617, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:purchase:export', '#', 103, 1, '2026-03-02 15:20:27', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725537639268354, '财务收支流水', 2029033891611893762, 1, 'financeRecord', 'erp/financeRecord/index', NULL, 1, 0, 'C', '0', '0', 'erp:financeRecord:list', '#', 103, 1, '2026-03-03 14:55:00', 1, '2026-03-04 11:19:42', '财务收支流水菜单');
INSERT INTO `sys_menu` VALUES (2028725537639268355, '财务收支流水查询', 2028725537639268354, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:financeRecord:query', '#', 103, 1, '2026-03-03 14:55:00', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725537639268356, '财务收支流水新增', 2028725537639268354, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:financeRecord:add', '#', 103, 1, '2026-03-03 14:55:00', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725537639268357, '财务收支流水修改', 2028725537639268354, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:financeRecord:edit', '#', 103, 1, '2026-03-03 14:55:00', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725537639268358, '财务收支流水删除', 2028725537639268354, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:financeRecord:remove', '#', 103, 1, '2026-03-03 14:55:00', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725537639268359, '财务收支流水导出', 2028725537639268354, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:financeRecord:export', '#', 103, 1, '2026-03-03 14:55:00', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725539073720321, '临时工费用登记', 2029033891611893762, 1, 'tempWorker', 'erp/tempWorker/index', NULL, 1, 0, 'C', '0', '0', 'erp:tempWorker:list', '#', 103, 1, '2026-03-03 14:55:15', 1, '2026-03-04 11:19:54', '临时工费用登记菜单');
INSERT INTO `sys_menu` VALUES (2028725539073720322, '临时工费用登记查询', 2028725539073720321, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorker:query', '#', 103, 1, '2026-03-03 14:55:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725539073720323, '临时工费用登记新增', 2028725539073720321, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorker:add', '#', 103, 1, '2026-03-03 14:55:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725539073720324, '临时工费用登记修改', 2028725539073720321, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorker:edit', '#', 103, 1, '2026-03-03 14:55:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725539073720325, '临时工费用登记删除', 2028725539073720321, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorker:remove', '#', 103, 1, '2026-03-03 14:55:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028725539073720326, '临时工费用登记导出', 2028725539073720321, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorker:export', '#', 103, 1, '2026-03-03 14:55:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028740775881285633, '委外收货与结算', 2029033891611893762, 1, 'outsourcingReceipt', 'erp/outsourcingReceipt/index', NULL, 1, 0, 'C', '0', '0', 'erp:outsourcingReceipt:list', '#', 103, 1, '2026-03-03 15:55:14', 1, '2026-03-04 11:20:07', '委外收货与结算菜单');
INSERT INTO `sys_menu` VALUES (2028740775881285634, '委外收货与结算查询', 2028740775881285633, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:outsourcingReceipt:query', '#', 103, 1, '2026-03-03 15:55:14', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028740775881285635, '委外收货与结算新增', 2028740775881285633, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:outsourcingReceipt:add', '#', 103, 1, '2026-03-03 15:55:14', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028740775881285636, '委外收货与结算修改', 2028740775881285633, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:outsourcingReceipt:edit', '#', 103, 1, '2026-03-03 15:55:14', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028740775881285637, '委外收货与结算删除', 2028740775881285633, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:outsourcingReceipt:remove', '#', 103, 1, '2026-03-03 15:55:14', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028740775881285638, '委外收货与结算导出', 2028740775881285633, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:outsourcingReceipt:export', '#', 103, 1, '2026-03-03 15:55:14', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028774387116728322, '临时工档案台账', 2029033891611893762, 1, 'tempWorkerInfo', 'erp/tempWorkerInfo/index', NULL, 1, 0, 'C', '0', '0', 'erp:tempWorkerInfo:list', '#', 103, 1, '2026-03-03 18:08:35', 1, '2026-03-04 11:20:20', '临时工档案台账菜单');
INSERT INTO `sys_menu` VALUES (2028774387116728323, '临时工档案台账查询', 2028774387116728322, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorkerInfo:query', '#', 103, 1, '2026-03-03 18:08:35', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028774387116728324, '临时工档案台账新增', 2028774387116728322, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorkerInfo:add', '#', 103, 1, '2026-03-03 18:08:35', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028774387116728325, '临时工档案台账修改', 2028774387116728322, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorkerInfo:edit', '#', 103, 1, '2026-03-03 18:08:35', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028774387116728326, '临时工档案台账删除', 2028774387116728322, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorkerInfo:remove', '#', 103, 1, '2026-03-03 18:08:35', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2028774387116728327, '临时工档案台账导出', 2028774387116728322, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'erp:tempWorkerInfo:export', '#', 103, 1, '2026-03-03 18:08:35', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2029033891611893762, '财务管理', 0, 14, 'finance', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'money', 103, 1, '2026-03-04 11:19:12', 1, '2026-03-04 12:06:15', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 103, 1, '2026-02-04 09:56:50', NULL, NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (2041052603803181058, '000000', '用户管理', 3, 'org.dromara.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'test', '梵熙纸业', '/system/user/2040793199203729409', '104.192.92.87', '美国|密歇根|0|0', '[\"2040793199203729409\"]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2026-04-06 15:17:16', 58);
INSERT INTO `sys_oper_log` VALUES (2041053367376224257, '000000', '角色管理', 2, 'org.dromara.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '104.192.92.87', '美国|密歇根|0|0', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-02-04 09:56:49\",\"updateBy\":null,\"updateTime\":null,\"roleId\":3,\"roleName\":\"总经理\",\"roleKey\":\"generalmanager\",\"roleSort\":2,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[1,108,500,100,1001,1002,1003,1004,1005,1006,1007,131,101,1008,1009,1010,1011,1012,130,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,132,1040,1042,501,1043,1044,1045,1050,\"2028334192193826818\",\"2028334192193826819\",\"2028334192193826820\",\"2028334192193826821\",\"2028334192193826822\",\"2028334192193826823\",107,1036,1037,1038,1039,\"2022122396940365825\",\"2022122396940365826\",\"2022122396940365827\",\"2022122396940365828\",\"2022122396940365829\",\"2022122396940365830\",\"2028369514294255617\",\"2028369514294255618\",\"2028369514294255619\",\"2028369514294255620\",\"2028369514294255621\",\"2028369514294255622\",\"2020415020961181697\",\"2020415020961181698\",\"2020415020961181699\",\"2020415020961181700\",\"2020415020961181701\",\"2020415020961181702\",\"2028334193993183234\",\"2028334193993183235\",\"2028334193993183236\",\"2028334193993183237\",\"2028334193993183238\",\"2028334193993183239\",\"2020050217822334977\",\"2020050217822334978\",\"2020050217822334979\",\"2020050217822334980\",\"2020050217822334981\",\"2020050217822334982\",\"2029033891611893762\",\"2028725537639268354\",\"2028725537639268355\",\"2028725537639268356\",\"2028725537639268357\",\"2028725537639268358\",\"2028725537639268359\",\"2028725539073720321\",\"2028725539073720322\",\"2028725539073720323\",\"2028725539073720324\",\"2028725539073720325\",\"2028725539073720326\",\"2028740775881285633\",\"2028740775881285634\",\"2028740775881285635\",\"2028740775881285636\",\"2028740775881285637\",\"2028740775881285638\",\"2028774387116728322\",\"2028774387116728323\",\"2028774387116728324\",\"2028774387116728325\",\"2028774387116728326\",\"2028774387116728327\"],\"deptIds\":[],\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2026-04-06 15:20:18', 96);
INSERT INTO `sys_oper_log` VALUES (2041053416567021570, '000000', '角色管理', 2, 'org.dromara.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '104.192.92.87', '美国|密歇根|0|0', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-02-04 09:56:49\",\"updateBy\":null,\"updateTime\":null,\"roleId\":4,\"roleName\":\"副总经理\",\"roleKey\":\"vicegeneralmanager\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[1,108,500,100,1001,1002,1003,1004,1005,1006,1007,131,101,1008,1009,1010,1011,1012,130,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,132,1040,1042,501,1043,1044,1045,1050,\"2028334192193826818\",\"2028334192193826819\",\"2028334192193826820\",\"2028334192193826821\",\"2028334192193826822\",\"2028334192193826823\",107,1036,1037,1038,1039,\"2022122396940365825\",\"2022122396940365826\",\"2022122396940365827\",\"2022122396940365828\",\"2022122396940365829\",\"2022122396940365830\",\"2028369514294255617\",\"2028369514294255618\",\"2028369514294255619\",\"2028369514294255620\",\"2028369514294255621\",\"2028369514294255622\",\"2020415020961181697\",\"2020415020961181698\",\"2020415020961181699\",\"2020415020961181700\",\"2020415020961181701\",\"2020415020961181702\",\"2028334193993183234\",\"2028334193993183235\",\"2028334193993183236\",\"2028334193993183237\",\"2028334193993183238\",\"2028334193993183239\",\"2020050217822334977\",\"2020050217822334978\",\"2020050217822334979\",\"2020050217822334980\",\"2020050217822334981\",\"2020050217822334982\",\"2029033891611893762\",\"2028725537639268354\",\"2028725537639268355\",\"2028725537639268356\",\"2028725537639268357\",\"2028725537639268358\",\"2028725537639268359\",\"2028725539073720321\",\"2028725539073720322\",\"2028725539073720323\",\"2028725539073720324\",\"2028725539073720325\",\"2028725539073720326\",\"2028740775881285633\",\"2028740775881285634\",\"2028740775881285635\",\"2028740775881285636\",\"2028740775881285637\",\"2028740775881285638\",\"2028774387116728322\",\"2028774387116728323\",\"2028774387116728324\",\"2028774387116728325\",\"2028774387116728326\",\"2028774387116728327\"],\"deptIds\":[],\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2026-04-06 15:20:30', 56);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'URL地址',
  `ext1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扩展字段',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '域',
  `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对象存储配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50', NULL);
INSERT INTO `sys_oss_config` VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50', NULL);
INSERT INTO `sys_oss_config` VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50', NULL);
INSERT INTO `sys_oss_config` VALUES (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1240000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '1', '', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50', NULL);
INSERT INTO `sys_oss_config` VALUES (5, '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2026-02-04 09:56:50', 1, '2026-02-04 09:56:50', NULL);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2040724428329992194, '000000', 100, 'FX005', '', '生产经理', 6, '0', 103, 1, '2026-04-05 17:33:13', 1, '2026-04-05 17:33:13', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '000000', '系统管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (3, '000000', '总经理', 'generalmanager', 2, '4', 1, 1, '0', '0', 103, 1, '2026-02-04 09:56:49', 1, '2026-04-06 15:20:18', '');
INSERT INTO `sys_role` VALUES (4, '000000', '副总经理', 'vicegeneralmanager', 3, '4', 1, 1, '0', '0', 103, 1, '2026-02-04 09:56:49', 1, '2026-04-06 15:20:30', '');
INSERT INTO `sys_role` VALUES (2029093823631699969, '000000', '业务员', 'businessstaff', 4, '5', 1, 1, '0', '0', 103, 1, '2026-03-04 15:17:21', 1, '2026-04-05 23:03:42', '');
INSERT INTO `sys_role` VALUES (2029095106656710658, '000000', '财务专员', 'fiancestaff', 5, '1', 1, 1, '0', '0', 103, 1, '2026-03-04 15:22:27', 1, '2026-04-05 17:26:44', '');
INSERT INTO `sys_role` VALUES (2040725829365940225, '000000', '生产经理', 'productionmanager', 6, '1', 1, 1, '0', '0', 103, 1, '2026-04-05 17:38:47', 1, '2026-04-05 22:46:33', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (3, 100);
INSERT INTO `sys_role_menu` VALUES (3, 101);
INSERT INTO `sys_role_menu` VALUES (3, 103);
INSERT INTO `sys_role_menu` VALUES (3, 104);
INSERT INTO `sys_role_menu` VALUES (3, 105);
INSERT INTO `sys_role_menu` VALUES (3, 107);
INSERT INTO `sys_role_menu` VALUES (3, 108);
INSERT INTO `sys_role_menu` VALUES (3, 130);
INSERT INTO `sys_role_menu` VALUES (3, 131);
INSERT INTO `sys_role_menu` VALUES (3, 132);
INSERT INTO `sys_role_menu` VALUES (3, 500);
INSERT INTO `sys_role_menu` VALUES (3, 501);
INSERT INTO `sys_role_menu` VALUES (3, 1001);
INSERT INTO `sys_role_menu` VALUES (3, 1002);
INSERT INTO `sys_role_menu` VALUES (3, 1003);
INSERT INTO `sys_role_menu` VALUES (3, 1004);
INSERT INTO `sys_role_menu` VALUES (3, 1005);
INSERT INTO `sys_role_menu` VALUES (3, 1006);
INSERT INTO `sys_role_menu` VALUES (3, 1007);
INSERT INTO `sys_role_menu` VALUES (3, 1008);
INSERT INTO `sys_role_menu` VALUES (3, 1009);
INSERT INTO `sys_role_menu` VALUES (3, 1010);
INSERT INTO `sys_role_menu` VALUES (3, 1011);
INSERT INTO `sys_role_menu` VALUES (3, 1012);
INSERT INTO `sys_role_menu` VALUES (3, 1017);
INSERT INTO `sys_role_menu` VALUES (3, 1018);
INSERT INTO `sys_role_menu` VALUES (3, 1019);
INSERT INTO `sys_role_menu` VALUES (3, 1020);
INSERT INTO `sys_role_menu` VALUES (3, 1021);
INSERT INTO `sys_role_menu` VALUES (3, 1022);
INSERT INTO `sys_role_menu` VALUES (3, 1023);
INSERT INTO `sys_role_menu` VALUES (3, 1024);
INSERT INTO `sys_role_menu` VALUES (3, 1025);
INSERT INTO `sys_role_menu` VALUES (3, 1026);
INSERT INTO `sys_role_menu` VALUES (3, 1027);
INSERT INTO `sys_role_menu` VALUES (3, 1028);
INSERT INTO `sys_role_menu` VALUES (3, 1029);
INSERT INTO `sys_role_menu` VALUES (3, 1030);
INSERT INTO `sys_role_menu` VALUES (3, 1036);
INSERT INTO `sys_role_menu` VALUES (3, 1037);
INSERT INTO `sys_role_menu` VALUES (3, 1038);
INSERT INTO `sys_role_menu` VALUES (3, 1039);
INSERT INTO `sys_role_menu` VALUES (3, 1040);
INSERT INTO `sys_role_menu` VALUES (3, 1042);
INSERT INTO `sys_role_menu` VALUES (3, 1043);
INSERT INTO `sys_role_menu` VALUES (3, 1044);
INSERT INTO `sys_role_menu` VALUES (3, 1045);
INSERT INTO `sys_role_menu` VALUES (3, 1050);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334977);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334978);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334979);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334980);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334981);
INSERT INTO `sys_role_menu` VALUES (3, 2020050217822334982);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181697);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181698);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181699);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181700);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181701);
INSERT INTO `sys_role_menu` VALUES (3, 2020415020961181702);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365825);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365826);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365827);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365828);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365829);
INSERT INTO `sys_role_menu` VALUES (3, 2022122396940365830);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826818);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826819);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826820);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826821);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826822);
INSERT INTO `sys_role_menu` VALUES (3, 2028334192193826823);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183234);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183235);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183236);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183237);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183238);
INSERT INTO `sys_role_menu` VALUES (3, 2028334193993183239);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255617);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255618);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255619);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255620);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255621);
INSERT INTO `sys_role_menu` VALUES (3, 2028369514294255622);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268354);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268355);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268356);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268357);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268358);
INSERT INTO `sys_role_menu` VALUES (3, 2028725537639268359);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720321);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720322);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720323);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720324);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720325);
INSERT INTO `sys_role_menu` VALUES (3, 2028725539073720326);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285633);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285634);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285635);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285636);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285637);
INSERT INTO `sys_role_menu` VALUES (3, 2028740775881285638);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728322);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728323);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728324);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728325);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728326);
INSERT INTO `sys_role_menu` VALUES (3, 2028774387116728327);
INSERT INTO `sys_role_menu` VALUES (3, 2029033891611893762);
INSERT INTO `sys_role_menu` VALUES (4, 1);
INSERT INTO `sys_role_menu` VALUES (4, 100);
INSERT INTO `sys_role_menu` VALUES (4, 101);
INSERT INTO `sys_role_menu` VALUES (4, 103);
INSERT INTO `sys_role_menu` VALUES (4, 104);
INSERT INTO `sys_role_menu` VALUES (4, 105);
INSERT INTO `sys_role_menu` VALUES (4, 107);
INSERT INTO `sys_role_menu` VALUES (4, 108);
INSERT INTO `sys_role_menu` VALUES (4, 130);
INSERT INTO `sys_role_menu` VALUES (4, 131);
INSERT INTO `sys_role_menu` VALUES (4, 132);
INSERT INTO `sys_role_menu` VALUES (4, 500);
INSERT INTO `sys_role_menu` VALUES (4, 501);
INSERT INTO `sys_role_menu` VALUES (4, 1001);
INSERT INTO `sys_role_menu` VALUES (4, 1002);
INSERT INTO `sys_role_menu` VALUES (4, 1003);
INSERT INTO `sys_role_menu` VALUES (4, 1004);
INSERT INTO `sys_role_menu` VALUES (4, 1005);
INSERT INTO `sys_role_menu` VALUES (4, 1006);
INSERT INTO `sys_role_menu` VALUES (4, 1007);
INSERT INTO `sys_role_menu` VALUES (4, 1008);
INSERT INTO `sys_role_menu` VALUES (4, 1009);
INSERT INTO `sys_role_menu` VALUES (4, 1010);
INSERT INTO `sys_role_menu` VALUES (4, 1011);
INSERT INTO `sys_role_menu` VALUES (4, 1012);
INSERT INTO `sys_role_menu` VALUES (4, 1017);
INSERT INTO `sys_role_menu` VALUES (4, 1018);
INSERT INTO `sys_role_menu` VALUES (4, 1019);
INSERT INTO `sys_role_menu` VALUES (4, 1020);
INSERT INTO `sys_role_menu` VALUES (4, 1021);
INSERT INTO `sys_role_menu` VALUES (4, 1022);
INSERT INTO `sys_role_menu` VALUES (4, 1023);
INSERT INTO `sys_role_menu` VALUES (4, 1024);
INSERT INTO `sys_role_menu` VALUES (4, 1025);
INSERT INTO `sys_role_menu` VALUES (4, 1026);
INSERT INTO `sys_role_menu` VALUES (4, 1027);
INSERT INTO `sys_role_menu` VALUES (4, 1028);
INSERT INTO `sys_role_menu` VALUES (4, 1029);
INSERT INTO `sys_role_menu` VALUES (4, 1030);
INSERT INTO `sys_role_menu` VALUES (4, 1036);
INSERT INTO `sys_role_menu` VALUES (4, 1037);
INSERT INTO `sys_role_menu` VALUES (4, 1038);
INSERT INTO `sys_role_menu` VALUES (4, 1039);
INSERT INTO `sys_role_menu` VALUES (4, 1040);
INSERT INTO `sys_role_menu` VALUES (4, 1042);
INSERT INTO `sys_role_menu` VALUES (4, 1043);
INSERT INTO `sys_role_menu` VALUES (4, 1044);
INSERT INTO `sys_role_menu` VALUES (4, 1045);
INSERT INTO `sys_role_menu` VALUES (4, 1050);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334977);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334978);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334979);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334980);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334981);
INSERT INTO `sys_role_menu` VALUES (4, 2020050217822334982);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181697);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181698);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181699);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181700);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181701);
INSERT INTO `sys_role_menu` VALUES (4, 2020415020961181702);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365825);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365826);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365827);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365828);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365829);
INSERT INTO `sys_role_menu` VALUES (4, 2022122396940365830);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826818);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826819);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826820);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826821);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826822);
INSERT INTO `sys_role_menu` VALUES (4, 2028334192193826823);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183234);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183235);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183236);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183237);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183238);
INSERT INTO `sys_role_menu` VALUES (4, 2028334193993183239);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255617);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255618);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255619);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255620);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255621);
INSERT INTO `sys_role_menu` VALUES (4, 2028369514294255622);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268354);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268355);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268356);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268357);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268358);
INSERT INTO `sys_role_menu` VALUES (4, 2028725537639268359);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720321);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720322);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720323);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720324);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720325);
INSERT INTO `sys_role_menu` VALUES (4, 2028725539073720326);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285633);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285634);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285635);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285636);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285637);
INSERT INTO `sys_role_menu` VALUES (4, 2028740775881285638);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728322);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728323);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728324);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728325);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728326);
INSERT INTO `sys_role_menu` VALUES (4, 2028774387116728327);
INSERT INTO `sys_role_menu` VALUES (4, 2029033891611893762);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 107);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 1036);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 1037);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 1038);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 1039);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334977);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334978);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334979);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334980);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334981);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020050217822334982);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181697);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181698);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181699);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181700);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181701);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2020415020961181702);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365825);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365826);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365827);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365828);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365829);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2022122396940365830);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826818);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826819);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826820);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826821);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826822);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334192193826823);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183234);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183235);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183236);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183237);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183238);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028334193993183239);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255617);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255618);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255619);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255620);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255621);
INSERT INTO `sys_role_menu` VALUES (2029093823631699969, 2028369514294255622);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334977);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334978);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334979);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334980);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334981);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020050217822334982);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181697);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181698);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181699);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181700);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181701);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2020415020961181702);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255617);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255618);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255619);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255620);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255621);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028369514294255622);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268354);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268355);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268356);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268357);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268358);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725537639268359);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720321);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720322);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720323);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720324);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720325);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028725539073720326);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285633);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285634);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285635);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285636);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285637);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028740775881285638);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728322);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728323);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728324);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728325);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728326);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2028774387116728327);
INSERT INTO `sys_role_menu` VALUES (2029095106656710658, 2029033891611893762);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 107);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 1036);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 1037);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 1038);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 1039);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11616);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11618);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11619);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11620);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11621);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11622);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11623);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11624);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11625);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11626);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11627);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11629);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11630);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11631);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11632);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11633);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11700);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11701);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11801);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11802);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11803);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11804);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11805);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 11806);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181697);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181698);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181699);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181700);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181701);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2020415020961181702);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826818);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826819);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826820);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826821);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826822);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334192193826823);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183234);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183235);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183236);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183237);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183238);
INSERT INTO `sys_role_menu` VALUES (2040725829365940225, 2028334193993183239);

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS `sys_social`;
CREATE TABLE `sys_social`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户id',
  `auth_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int NULL DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '社会化关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_social
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2026-02-04 09:56:49', NULL, NULL);

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint NULL DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '000000', 103, 'admin', '系统管理员', 'sys_user', '1987291625@qq.com', '13924683996', '1', NULL, '$2a$10$nNU9Wyv1qf2TQcbOTBSozuyl4r25d7Xmi/yCL/1TbS2RLr55.Nnoq', '0', '0', '104.192.92.87', '2026-04-06 21:10:03', 103, 1, '2026-02-04 09:56:49', -1, '2026-04-06 21:10:03', '管理员');
INSERT INTO `sys_user` VALUES (3, '000000', 108, 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '1', '127.0.0.1', '2026-02-04 09:56:49', 103, 1, '2026-02-04 09:56:49', 1, '2026-03-04 15:13:19', NULL);
INSERT INTO `sys_user` VALUES (4, '000000', 102, 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '1', '127.0.0.1', '2026-02-04 09:56:49', 103, 1, '2026-02-04 09:56:49', 1, '2026-03-04 15:13:17', NULL);
INSERT INTO `sys_user` VALUES (2020382840348291074, '000000', 100, 'test3', 'test3', 'sys_user', '', '', '0', NULL, '$2a$10$1k7uhUH7R2qLLAXqSejIiOPXzYgy3AEvgHxJLmc/.Lp4XrpnyZLQm', '0', '1', '', NULL, 103, 1, '2026-02-08 14:23:01', 1, '2026-03-04 15:13:13', '');
INSERT INTO `sys_user` VALUES (2029092962549477377, '000000', 100, 'test1', '测试用户1', 'sys_user', '', '13434343434', '0', NULL, '$2a$10$Xiog0qEKCta81Pw1b8yJ7uYEtH39xPyx8S/YkhHMO/3sE0N7f7d8a', '0', '1', '127.0.0.1', '2026-03-04 15:15:10', 103, 1, '2026-03-04 15:13:56', 1, '2026-04-05 17:56:18', '');
INSERT INTO `sys_user` VALUES (2040720310324576258, '000000', 100, '谭智新', '谭智新', 'sys_user', '', '13048114443', '0', NULL, '$2a$10$Edyj1vwBmnjw97WRxtCepex6m7CCR0tfSFGUpXBfoUYHfZrcHAUsG', '0', '0', '113.117.208.130', '2026-04-05 21:39:28', 103, 1, '2026-04-05 17:16:51', -1, '2026-04-05 21:39:28', '');
INSERT INTO `sys_user` VALUES (2040723188439203841, '000000', 100, '刘淑佳', '刘淑佳', 'sys_user', '', '18818654321', '0', NULL, '$2a$10$OFtNQnrZaF9wDTosxECt/.Jsg/04oiI2F85a/j5tW8359ShaYrQve', '0', '0', '', NULL, 103, 1, '2026-04-05 17:28:18', 1, '2026-04-05 17:28:18', '');
INSERT INTO `sys_user` VALUES (2040723574487138306, '000000', 100, '蓝毅', '蓝毅', 'sys_user', '', '13925367744', '0', NULL, '$2a$10$RLCJ0m4ejPiIhfJXNe5teuboQbZkRVhJpuPZOocIlTTnUXdEeoUBe', '0', '0', '', NULL, 103, 1, '2026-04-05 17:29:50', 1, '2026-04-05 17:29:50', '');
INSERT INTO `sys_user` VALUES (2040723904692109313, '000000', 100, '廖声燕', '廖声燕', 'sys_user', '', '15015007628', '1', NULL, '$2a$10$DJ71ONOGsJ7SrjTafDwdm.MhJTjG68Bu7.l90ICZsrv3HcVjH..3q', '0', '0', '', NULL, 103, 1, '2026-04-05 17:31:08', 1, '2026-04-05 17:31:08', '');
INSERT INTO `sys_user` VALUES (2040724213346746369, '000000', 100, '李金成', '李金成', 'sys_user', '', '13415378825', '0', NULL, '$2a$10$6.F8uAz0LneKt/JqaJRaOuBvo36eq57SANsEXsoQYuyS/4jovsskq', '0', '0', '', NULL, 103, 1, '2026-04-05 17:32:22', 1, '2026-04-05 17:39:06', '');
INSERT INTO `sys_user` VALUES (2040792051533103106, '000000', 100, 'test', 'test1', 'sys_user', '', '', '0', NULL, '$2a$10$dr4sbfE2WfCJE8TaM/p3fODpVRoJ2476lbA0n8reNVlxzr0YS1/Am', '0', '0', '113.117.208.130', '2026-04-06 20:51:40', 103, 1, '2026-04-05 22:01:56', -1, '2026-04-06 20:51:40', '');
INSERT INTO `sys_user` VALUES (2040793199203729409, '000000', 100, 'test2', 'test2', 'sys_user', '', '', '0', NULL, '$2a$10$GIaY.7b4rJq5U0ZbA6wwh.A/TARN4HJsjmKRjfzV172W19mKqLksa', '0', '1', '104.192.92.87', '2026-04-05 22:51:18', 100, 2040792051533103106, '2026-04-05 22:06:29', 2040792051533103106, '2026-04-06 15:17:16', '');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2040720310324576258, 2);
INSERT INTO `sys_user_post` VALUES (2040723188439203841, 2);
INSERT INTO `sys_user_post` VALUES (2040723574487138306, 2);
INSERT INTO `sys_user_post` VALUES (2040723904692109313, 2);
INSERT INTO `sys_user_post` VALUES (2040724213346746369, 2040724428329992194);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2040720310324576258, 4);
INSERT INTO `sys_user_role` VALUES (2040723188439203841, 4);
INSERT INTO `sys_user_role` VALUES (2040723574487138306, 3);
INSERT INTO `sys_user_role` VALUES (2040723904692109313, 2029095106656710658);
INSERT INTO `sys_user_role` VALUES (2040724213346746369, 2040725829365940225);
INSERT INTO `sys_user_role` VALUES (2040792051533103106, 3);

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS `test_demo`;
CREATE TABLE `test_demo`  (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `order_num` int NULL DEFAULT 0 COMMENT '排序号',
  `test_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'key键',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '值',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_demo
-- ----------------------------
INSERT INTO `test_demo` VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);

-- ----------------------------
-- Table structure for test_leave
-- ----------------------------
DROP TABLE IF EXISTS `test_leave`;
CREATE TABLE `test_leave`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `apply_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申请编号',
  `leave_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请假类型',
  `start_date` datetime NOT NULL COMMENT '开始时间',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `leave_days` int NOT NULL COMMENT '请假天数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请假原因',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '请假申请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_leave
-- ----------------------------

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS `test_tree`;
CREATE TABLE `test_tree`  (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父id',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `tree_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '值',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试树表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_tree
-- ----------------------------
INSERT INTO `test_tree` VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, '2026-02-04 09:56:50', 1, NULL, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
