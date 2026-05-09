-- 打印工单功能 - 新增字段
ALTER TABLE biz_wo_material ADD COLUMN edition VARCHAR(255) DEFAULT NULL COMMENT '版次';
ALTER TABLE biz_wo_outsourcing ADD COLUMN print_size VARCHAR(255) DEFAULT NULL COMMENT '印刷尺寸';
ALTER TABLE biz_work_order ADD COLUMN prepared_by VARCHAR(255) DEFAULT NULL COMMENT '制单员';
