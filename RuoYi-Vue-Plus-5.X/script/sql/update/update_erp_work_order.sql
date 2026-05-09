-- 完善工单功能 - 新增字段
-- Issue 1: 加工细则字段
ALTER TABLE biz_wo_outsourcing ADD COLUMN process_detail VARCHAR(255) DEFAULT NULL COMMENT '加工细则(如裱坑类型:单E/单B/EE/BB)';
ALTER TABLE biz_wo_outsourcing ADD COLUMN print_color VARCHAR(255) DEFAULT NULL COMMENT '印刷颜色';
ALTER TABLE biz_wo_outsourcing ADD COLUMN print_impression VARCHAR(255) DEFAULT NULL COMMENT '印刷模数(如3+3,4+1)';
ALTER TABLE biz_wo_outsourcing ADD COLUMN print_machine VARCHAR(255) DEFAULT NULL COMMENT '印刷机号';
ALTER TABLE biz_wo_process ADD COLUMN process_detail VARCHAR(255) DEFAULT NULL COMMENT '加工细则(如裱坑类型:单E/单B/EE/BB)';
ALTER TABLE biz_outsourcing_receipt ADD COLUMN process_detail VARCHAR(255) DEFAULT NULL COMMENT '加工细则';

-- Issue 3: 包装需求 + 物流要求字段
ALTER TABLE biz_wo_product ADD COLUMN pack_requirement VARCHAR(255) DEFAULT NULL COMMENT '包装需求';
ALTER TABLE biz_wo_product ADD COLUMN logistics_req VARCHAR(255) DEFAULT NULL COMMENT '物流要求';

-- Issue 1: 工序细则字典数据 (remark字段关联父工序名)
INSERT INTO sys_dict_type (dict_name, dict_type, status, remark) VALUES ('工序细则字典', 'erp_process_detail', '0', '加工工序对应的子类型,remark字段关联父工序名');

INSERT INTO sys_dict_data (dict_type, dict_label, dict_value, remark, dict_sort) VALUES
('erp_process_detail', '单E', 'single_e', '裱坑', 0),
('erp_process_detail', '单B', 'single_b', '裱坑', 1),
('erp_process_detail', 'EE', 'ee', '裱坑', 2),
('erp_process_detail', 'BB', 'bb', '裱坑', 3);
-- 其他工序子类型(啤机/粘盒等)请按需要在后台字典管理中添加
