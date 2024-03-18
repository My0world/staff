/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : staff_manage

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 18/03/2024 11:18:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_authority
-- ----------------------------
DROP TABLE IF EXISTS `admin_authority`;
CREATE TABLE `admin_authority`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `one_level_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `two_level_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `three_level_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `right_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`, `right_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_authority
-- ----------------------------
INSERT INTO `admin_authority` VALUES (1, 'home', NULL, NULL, 'home', '首页');
INSERT INTO `admin_authority` VALUES (2, 'staff', NULL, NULL, 'staff', '员工管理');
INSERT INTO `admin_authority` VALUES (3, 'staff', 'staffMsg', NULL, 'staffMsg', '员工信息');
INSERT INTO `admin_authority` VALUES (4, 'staff', 'checkingIn', NULL, 'checkingIn', '考勤管理');
INSERT INTO `admin_authority` VALUES (5, 'staff', 'staffMsg', 'userAddStaff', 'userAddStaff', '添加员工(需审核)');
INSERT INTO `admin_authority` VALUES (6, 'staff', 'staffMsg', 'userUpdateStaff', 'userUpdateStaff', '修改员工(需审核)');
INSERT INTO `admin_authority` VALUES (7, 'dimission', 'settingDimission', '', 'settingDimission', '设置为离职');
INSERT INTO `admin_authority` VALUES (8, 'staff', 'staffMsg', 'allStaffMsgView', 'allStaffMsgView', '所有员工信息');
INSERT INTO `admin_authority` VALUES (9, 'staff', 'staffMsg', 'adminAddStaff', 'adminAddStaff', '添加员工(无需审核)');
INSERT INTO `admin_authority` VALUES (10, 'staff', 'staffMsg', 'adminUpdateStaff', 'adminUpdateStaff', '修改员工(无需审核)');
INSERT INTO `admin_authority` VALUES (11, 'staff', 'checkingIn', 'updateCheckingIn', 'updateCheckingIn', '修改员工考勤');
INSERT INTO `admin_authority` VALUES (12, 'staff', 'checkingIn', 'allStaffCheckingInView', 'allStaffCheckingInView', '所有员工考勤');
INSERT INTO `admin_authority` VALUES (13, 'user', '', '', 'user', '用户管理');
INSERT INTO `admin_authority` VALUES (14, 'operatingRequestAudit', NULL, NULL, 'operatingRequestAudit', '操作请求审核');
INSERT INTO `admin_authority` VALUES (15, 'operatingRequestAudit', 'updateOpReviewStatus', NULL, 'updateOpReviewStatus', '更新操作请求内容状态');
INSERT INTO `admin_authority` VALUES (16, 'user', 'showUserPassWord', NULL, 'showUserPassWord', '查看某位用户的密码');
INSERT INTO `admin_authority` VALUES (17, 'user', 'allotAuthority', NULL, 'allotAuthority', '权限表');
INSERT INTO `admin_authority` VALUES (18, 'user', 'updateUserPassWord', NULL, 'updateUserPassWord', '修改某位用户的密码');
INSERT INTO `admin_authority` VALUES (19, 'user', 'deleteUser', NULL, 'deleteUser', '删除某位用户');
INSERT INTO `admin_authority` VALUES (20, 'operatingData', NULL, NULL, 'operatingData', '操作记录');
INSERT INTO `admin_authority` VALUES (21, 'feedback', NULL, NULL, 'feedback', '反馈消息');
INSERT INTO `admin_authority` VALUES (22, 'dimission', NULL, NULL, 'dimission', '离职员工管理');
INSERT INTO `admin_authority` VALUES (23, 'dimission', 'dimissionData', NULL, 'dimissionData', '所有离职员工');
INSERT INTO `admin_authority` VALUES (24, 'user', 'addAdminUser', NULL, 'addAdminUser', '添加用户');
INSERT INTO `admin_authority` VALUES (25, 'dimission', 'returnStaffTable', NULL, 'returnStaffTable', '从离职员工表移回员工表');
INSERT INTO `admin_authority` VALUES (26, 'dimission', 'dimissionAudit', NULL, 'dimissionAudit', '查看离职申请数据');
INSERT INTO `admin_authority` VALUES (27, 'dimission', 'updateResignReviewStatus', NULL, 'updateResignReviewStatus', '更改离职申请状态');

-- ----------------------------
-- Table structure for admin_op_record
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_record`;
CREATE TABLE `admin_op_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 198 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_record
-- ----------------------------
INSERT INTO `admin_op_record` VALUES (190, '<div class=\"shortMsg\">012301用户通过了042301员工的离职申请</div>', '012301', '2024-03-17 20:57:40');
INSERT INTO `admin_op_record` VALUES (191, '<div class=\"shortMsg\">012301用户通过了012408员工的离职申请</div>', '012301', '2024-03-17 20:58:51');
INSERT INTO `admin_op_record` VALUES (192, '<div class=\"shortMsg\">022302员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 20:58:58');
INSERT INTO `admin_op_record` VALUES (193, '<div class=\"shortMsg\">012303员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 20:58:59');
INSERT INTO `admin_op_record` VALUES (194, '<div class=\"shortMsg\">032301员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 21:05:54');
INSERT INTO `admin_op_record` VALUES (195, '<div class=\"shortMsg\">012301将012408从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:16');
INSERT INTO `admin_op_record` VALUES (196, '<div class=\"shortMsg\">012301将042301从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:21');
INSERT INTO `admin_op_record` VALUES (197, '<div class=\"shortMsg\">012301将022405从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:23');
INSERT INTO `admin_op_record` VALUES (187, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:32:30');
INSERT INTO `admin_op_record` VALUES (188, '<div class=\"shortMsg\">012302用户的操作请求编号为44已被012301用户驳回</div>', '012301', '2024-03-17 20:32:44');
INSERT INTO `admin_op_record` VALUES (189, '<div class=\"shortMsg\">012302用户的修改信息请求编号为43已被012301用户审核并通过</div>', '012301', '2024-03-17 20:32:47');
INSERT INTO `admin_op_record` VALUES (185, '<div class=\"shortMsg\">012302用户的操作请求编号为42已被012301用户驳回</div>', '012301', '2024-03-17 20:31:51');
INSERT INTO `admin_op_record` VALUES (186, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:32:27');
INSERT INTO `admin_op_record` VALUES (183, '<div class=\"shortMsg\">012302用户的操作请求编号为41已被012301用户驳回</div>', '012301', '2024-03-17 20:30:17');
INSERT INTO `admin_op_record` VALUES (184, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:31:41');
INSERT INTO `admin_op_record` VALUES (182, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12222222222</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:26:22');

-- ----------------------------
-- Table structure for admin_op_review
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_review`;
CREATE TABLE `admin_op_review`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------
INSERT INTO `admin_op_review` VALUES (4, '{\"oldData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-12-12\"}}', 'updateRequest', '012302', '2024-02-18 09:55:56', '审核驳回');
INSERT INTO `admin_op_review` VALUES (3, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2024-02-23\"}}', 'updateRequest', '012302', '2024-02-18 09:49:24', '审核通过');
INSERT INTO `admin_op_review` VALUES (5, '{\"departId\": \"04\", \"phoneNum\": \"15312250345\", \"staffName\": \"\\u7a7a\", \"sex\": \"\\u7537\", \"age\": 540, \"job\": \"\\u7ecf\\u7406\", \"salary\": 8000, \"entryTime\": \"2024-03-22\"}', 'addRequest', '012302', '2024-03-11 14:07:37', '审核通过');
INSERT INTO `admin_op_review` VALUES (6, '{\"departId\": \"03\", \"phoneNum\": \"12322253454\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"job\": \"\\u7ecf\\u7406\", \"salary\": 7000, \"entryTime\": \"2024-03-21\"}', 'addRequest', '012302', '2024-03-11 14:32:23', '审核通过');
INSERT INTO `admin_op_review` VALUES (7, '{\"departId\": \"02\", \"phoneNum\": \"19273322110\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"job\": \"\\u7ecf\\u7406\", \"salary\": 5000, \"entryTime\": \"2024-03-13\"}', 'addRequest', '012302', '2024-03-11 14:33:10', '审核通过');
INSERT INTO `admin_op_review` VALUES (8, '{\"oldData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}, \"newData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": \"12171195234\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}}', 'updateRequest', '012302', '2024-03-12 13:52:37', '审核驳回');
INSERT INTO `admin_op_review` VALUES (9, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-06\"}}', 'updateRequest', '012302', '2024-03-12 14:03:14', '审核驳回');
INSERT INTO `admin_op_review` VALUES (10, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-03\"}}', 'updateRequest', '012302', '2024-03-12 14:04:35', '审核驳回');
INSERT INTO `admin_op_review` VALUES (11, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-11\"}}', 'updateRequest', '012302', '2024-03-12 14:13:45', '审核驳回');
INSERT INTO `admin_op_review` VALUES (12, '{\"oldData\": {\"staffId\": \"022406\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"022406\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}}', 'updateRequest', '012302', '2024-03-12 14:23:56', '审核驳回');
INSERT INTO `admin_op_review` VALUES (13, '{\"oldData\": {\"staffId\": \"022406\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"022406\", \"departId\": \"03\", \"phoneNum\": \"18283990221\", \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e09\\u6708\\u4e03\", \"sex\": \"\\u5973\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2024-02-27\"}}', 'updateRequest', '012302', '2024-03-12 14:25:03', '审核驳回');
INSERT INTO `admin_op_review` VALUES (14, '{\"oldData\": {\"staffId\": \"022406\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"022406\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}}', 'updateRequest', '012302', '2024-03-12 14:32:55', '审核通过');
INSERT INTO `admin_op_review` VALUES (15, '{\"departId\": \"04\", \"phoneNum\": \"18293321991\", \"staffName\": \"\\u4e09\\u6708\\u4e03\", \"sex\": \"\\u5973\", \"age\": 22, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 9000, \"entryTime\": \"2024-03-07\"}', 'addRequest', '012302', '2024-03-12 14:36:25', '审核通过');
INSERT INTO `admin_op_review` VALUES (16, '{\"departId\": \"04\", \"phoneNum\": \"18293318992\", \"staffName\": \"\\u59ec\\u5b50\", \"sex\": \"\\u5973\", \"age\": 32, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 13000, \"entryTime\": \"2024-03-06\"}', 'addRequest', '012302', '2024-03-12 14:37:59', '审核通过');
INSERT INTO `admin_op_review` VALUES (17, '{\"oldData\": {\"staffId\": \"052303\", \"departId\": \"05\", \"phoneNum\": 12134444042, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u963f\\u65af\\u6258\\u6d1b\\u5409\\u65af\\u00b7\\u83ab\\u5a1c\\u00b7\\u6885\\u59ec\\u65af\\u56fe\\u65af\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 3000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"052303\", \"departId\": \"05\", \"phoneNum\": 12134444042, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u963f\\u65af\\u6258\\u6d1b\\u5409\\u65af\\u00b7\\u83ab\\u5a1c\\u00b7\\u6885\\u59ec\\u65af\\u56fe\\u65af\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 100000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:50:44', '审核通过');
INSERT INTO `admin_op_review` VALUES (18, '{\"oldData\": {\"staffId\": \"042301\", \"departId\": \"04\", \"phoneNum\": 15238199014, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u949f\\u79bb\", \"sex\": \"\\u7537\", \"age\": 1000, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"042301\", \"departId\": \"04\", \"phoneNum\": 15238199014, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u949f\\u79bb\", \"sex\": \"\\u7537\", \"age\": 1000, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:52:00', '审核通过');
INSERT INTO `admin_op_review` VALUES (19, '{\"oldData\": {\"staffId\": \"052301\", \"departId\": \"05\", \"phoneNum\": 11371238904, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u591c\\u9611\", \"sex\": \"\\u5973\", \"age\": 24, \"salary\": 8000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"052301\", \"departId\": \"05\", \"phoneNum\": 11371238904, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u591c\\u9611\", \"sex\": \"\\u5973\", \"age\": 24, \"salary\": 8000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:52:15', '审核通过');
INSERT INTO `admin_op_review` VALUES (20, '{\"oldData\": {\"staffId\": \"052302\", \"departId\": \"05\", \"phoneNum\": 11371238224, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7eb3\\u897f\\u59b2\", \"sex\": \"\\u5973\", \"age\": 500, \"salary\": 4000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"052302\", \"departId\": \"05\", \"phoneNum\": 11371238224, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u7eb3\\u897f\\u59b2\", \"sex\": \"\\u5973\", \"age\": 500, \"salary\": 4000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:52:22', '审核通过');
INSERT INTO `admin_op_review` VALUES (21, '{\"oldData\": {\"staffId\": \"052303\", \"departId\": \"05\", \"phoneNum\": 12134444042, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u963f\\u65af\\u6258\\u6d1b\\u5409\\u65af\\u00b7\\u83ab\\u5a1c\\u00b7\\u6885\\u59ec\\u65af\\u56fe\\u65af\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 100000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"052303\", \"departId\": \"05\", \"phoneNum\": 12134444042, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u963f\\u65af\\u6258\\u6d1b\\u5409\\u65af\\u00b7\\u83ab\\u5a1c\\u00b7\\u6885\\u59ec\\u65af\\u56fe\\u65af\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 100000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:52:31', '审核通过');
INSERT INTO `admin_op_review` VALUES (22, '{\"oldData\": {\"staffId\": \"052304\", \"departId\": \"05\", \"phoneNum\": 13472894789, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u4e45\\u5c90\\u5fcd\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 4200, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"052304\", \"departId\": \"05\", \"phoneNum\": 13472894789, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u4e45\\u5c90\\u5fcd\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 4200, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:53:02', '审核通过');
INSERT INTO `admin_op_review` VALUES (23, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u67ab\\u539f\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:53:10', '审核通过');
INSERT INTO `admin_op_review` VALUES (24, '{\"oldData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u536f\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u536f\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:53:22', '审核通过');
INSERT INTO `admin_op_review` VALUES (25, '{\"oldData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:53:37', '审核通过');
INSERT INTO `admin_op_review` VALUES (26, '{\"oldData\": {\"staffId\": \"022302\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u80e1\\u6843\", \"sex\": \"\\u5973\", \"age\": 16, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022302\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u80e1\\u6843\", \"sex\": \"\\u5973\", \"age\": 16, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:53:46', '审核通过');
INSERT INTO `admin_op_review` VALUES (27, '{\"oldData\": {\"staffId\": \"032301\", \"departId\": \"03\", \"phoneNum\": 13232234167, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u884c\\u79cb\", \"sex\": \"\\u7537\", \"age\": 17, \"salary\": 5000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"032301\", \"departId\": \"03\", \"phoneNum\": 13232234167, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u884c\\u79cb\", \"sex\": \"\\u7537\", \"age\": 17, \"salary\": 5000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '012302', '2024-03-12 14:54:15', '审核通过');
INSERT INTO `admin_op_review` VALUES (28, '{\"oldData\": {\"staffId\": \"012301\", \"departId\": \"01\", \"phoneNum\": 13172290114, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u8fbe\\u8fbe\\u5229\\u4e9a\", \"sex\": \"\\u7537\", \"age\": 23, \"salary\": 9000, \"entryTime\": \"2024-02-15\"}, \"newData\": {\"staffId\": \"012301\", \"departId\": \"01\", \"phoneNum\": 13172290114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u8fbe\\u8fbe\\u5229\\u4e9a\", \"sex\": \"\\u7537\", \"age\": 23, \"salary\": 9000, \"entryTime\": \"2024-02-15\"}}', 'updateRequest', '012302', '2024-03-12 14:54:27', '审核通过');
INSERT INTO `admin_op_review` VALUES (29, '{\"oldData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}, \"newData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}}', 'updateRequest', '012302', '2024-03-12 14:54:34', '审核通过');
INSERT INTO `admin_op_review` VALUES (30, '{\"oldData\": {\"staffId\": \"022403\", \"departId\": \"02\", \"phoneNum\": 12132290117, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u8367\", \"sex\": \"\\u5973\", \"age\": 600, \"salary\": 8000, \"entryTime\": \"2024-03-06\"}, \"newData\": {\"staffId\": \"022403\", \"departId\": \"02\", \"phoneNum\": 12132290117, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u8367\", \"sex\": \"\\u5973\", \"age\": 600, \"salary\": 8000, \"entryTime\": \"2024-03-06\"}}', 'updateRequest', '012302', '2024-03-12 14:54:48', '审核通过');
INSERT INTO `admin_op_review` VALUES (31, '{\"oldData\": {\"staffId\": \"042404\", \"departId\": \"04\", \"phoneNum\": 18293318992, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u59ec\\u5b50\", \"sex\": \"\\u5973\", \"age\": 32, \"salary\": 13000, \"entryTime\": \"2024-03-06\"}, \"newData\": {\"staffId\": \"042404\", \"departId\": \"04\", \"phoneNum\": 18293318992, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u59ec\\u5b50\", \"sex\": \"\\u5973\", \"age\": 32, \"salary\": 13000, \"entryTime\": \"2024-03-06\"}}', 'updateRequest', '012302', '2024-03-12 14:54:59', '审核通过');
INSERT INTO `admin_op_review` VALUES (32, '{\"oldData\": {\"staffId\": \"022405\", \"departId\": \"02\", \"phoneNum\": 15121190114, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"salary\": 4000, \"entryTime\": \"2024-03-08\"}, \"newData\": {\"staffId\": \"022405\", \"departId\": \"02\", \"phoneNum\": 15121190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"salary\": 4000, \"entryTime\": \"2024-03-08\"}}', 'updateRequest', '012302', '2024-03-12 14:55:12', '审核通过');
INSERT INTO `admin_op_review` VALUES (33, '{\"oldData\": {\"staffId\": \"022404\", \"departId\": \"02\", \"phoneNum\": 17432397554, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u83f2\\u8c22\\u5c14\\u00b7\\u51af\\u00b7\\u9732\\u5f17\\u65bd\\u6d1b\\u65af\\u00b7\\u90a3\\u83f2\\u591a\\u7279\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 6000, \"entryTime\": \"2024-03-12\"}, \"newData\": {\"staffId\": \"022404\", \"departId\": \"02\", \"phoneNum\": 17432397554, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u83f2\\u8c22\\u5c14\\u00b7\\u51af\\u00b7\\u9732\\u5f17\\u65bd\\u6d1b\\u65af\\u00b7\\u90a3\\u83f2\\u591a\\u7279\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 6000, \"entryTime\": \"2024-03-12\"}}', 'updateRequest', '012302', '2024-03-12 14:55:23', '审核通过');
INSERT INTO `admin_op_review` VALUES (34, '{\"oldData\": {\"staffId\": \"032402\", \"departId\": \"03\", \"phoneNum\": 12322253454, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"salary\": 7000, \"entryTime\": \"2024-03-21\"}, \"newData\": {\"staffId\": \"032402\", \"departId\": \"03\", \"phoneNum\": 12322253454, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"salary\": 7000, \"entryTime\": \"2024-03-21\"}}', 'updateRequest', '012302', '2024-03-12 14:55:37', '审核通过');
INSERT INTO `admin_op_review` VALUES (35, '{\"oldData\": {\"staffId\": \"042402\", \"departId\": \"04\", \"phoneNum\": 15312250345, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a7a\", \"sex\": \"\\u7537\", \"age\": 540, \"salary\": 8000, \"entryTime\": \"2024-03-22\"}, \"newData\": {\"staffId\": \"042402\", \"departId\": \"04\", \"phoneNum\": 15312250345, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a7a\", \"sex\": \"\\u7537\", \"age\": 540, \"salary\": 8000, \"entryTime\": \"2024-03-22\"}}', 'updateRequest', '012302', '2024-03-12 14:55:50', '审核通过');
INSERT INTO `admin_op_review` VALUES (36, '{\"oldData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}}', 'updateRequest', '012302', '2024-03-12 15:04:11', '审核通过');
INSERT INTO `admin_op_review` VALUES (37, '{\"departId\": \"03\", \"phoneNum\": \"18173209421\", \"staffName\": \"\\u4e39\\u6052\", \"sex\": \"\\u7537\", \"age\": 600, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 7000, \"entryTime\": \"2024-03-13\"}', 'addRequest', '012302', '2024-03-13 17:11:06', '审核通过');
INSERT INTO `admin_op_review` VALUES (38, '{\"oldData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u536f\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u536f\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 300, \"entryTime\": \"2023-09-04\"}}', 'updateRequest', '012302', '2024-03-13 17:18:53', '审核通过');
INSERT INTO `admin_op_review` VALUES (39, '{\"departId\": \"03\", \"phoneNum\": \"12689931884\", \"staffName\": \"\\u827e\\u5409\\u5965\\u00b7\\u5965\\u8fea\\u6258\\u96f7\\u00b7\\u8fbe\\u00b7\\u4f5b\\u7f57\\u4f26\\u8428\", \"sex\": \"\\u7537\", \"age\": 35, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 10000, \"entryTime\": \"2024-03-14\"}', 'addRequest', '012302', '2024-03-13 17:25:19', '审核通过');
INSERT INTO `admin_op_review` VALUES (40, '{\"oldData\": {\"staffId\": \"032403\", \"departId\": \"03\", \"phoneNum\": 18173209421, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e39\\u6052\", \"sex\": \"\\u7537\", \"age\": 600, \"salary\": 7000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"032403\", \"departId\": \"03\", \"phoneNum\": 18173209421, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e39\\u6052\\u2022\\u996e\\u6708\", \"sex\": \"\\u7537\", \"age\": 600, \"salary\": 7000, \"entryTime\": \"2024-03-13\"}}', 'updateRequest', '012302', '2024-03-13 17:25:56', '审核通过');
INSERT INTO `admin_op_review` VALUES (41, '{\"oldData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}, \"newData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": \"12222222222\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}}', 'updateRequest', '012302', '2024-03-17 20:26:22', '审核驳回');
INSERT INTO `admin_op_review` VALUES (42, '{\"oldData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}, \"newData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": \"1\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}}', 'updateRequest', '012302', '2024-03-17 20:31:41', '审核驳回');
INSERT INTO `admin_op_review` VALUES (43, '{\"oldData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}, \"newData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}}', 'updateRequest', '012302', '2024-03-17 20:32:27', '审核通过');
INSERT INTO `admin_op_review` VALUES (44, '{\"oldData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": 19231239223, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}, \"newData\": {\"staffId\": \"012408\", \"departId\": \"01\", \"phoneNum\": \"1\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u7a79\", \"sex\": \"\\u7537\", \"age\": 9, \"salary\": 10000, \"entryTime\": \"2023-07-20\"}}', 'updateRequest', '012302', '2024-03-17 20:32:30', '审核驳回');

-- ----------------------------
-- Table structure for admin_send_notice
-- ----------------------------
DROP TABLE IF EXISTS `admin_send_notice`;
CREATE TABLE `admin_send_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_send_notice
-- ----------------------------

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `authority` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`staffId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('012301', '01', '达达利亚', 'admin', '在线', 'home,staff,staffMsg,checkingIn,settingDimission,adminAddStaff,adminUpdateStaff,updateCheckingIn,allStaffCheckingInView,user,allStaffMsgView,operatingRequestAudit,updateOpReviewStatus,showUserPassWord,allotAuthority,updateUserPassWord,deleteUser,operatingData,feedback,dimission,dimissionData,addAdminUser,returnStaffTable,dimissionAudit,updateResignReviewStatus');
INSERT INTO `admin_user` VALUES ('012302', '01', '万叶', 'admin', '下线', 'home,staff,staffMsg,userAddStaff,userUpdateStaff,user,allotAuthority,operatingRequestAudit,allStaffMsgView');

-- ----------------------------
-- Table structure for askforleave
-- ----------------------------
DROP TABLE IF EXISTS `askforleave`;
CREATE TABLE `askforleave`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `startTime` datetime(0) NOT NULL,
  `endTime` datetime(0) NOT NULL,
  `dateTime` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of askforleave
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `departId` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `department_Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `manager_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`departId`) USING BTREE,
  INDEX `manager_staffId`(`manager_staffId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('01', '管理层', '012301');
INSERT INTO `department` VALUES ('02', '开发部', '022301');
INSERT INTO `department` VALUES ('03', '测试部', '032301');
INSERT INTO `department` VALUES ('04', '人力资源', '042301');
INSERT INTO `department` VALUES ('05', '运维部', '052301');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dateTime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (17, '忘记密码了', '012302', '2024-03-17 14:55:25');
INSERT INTO `feedback` VALUES (18, '滚蛋啊？？？？\n', '012303', '2024-03-17 14:55:42');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for receivernotice
-- ----------------------------
DROP TABLE IF EXISTS `receivernotice`;
CREATE TABLE `receivernotice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of receivernotice
-- ----------------------------

-- ----------------------------
-- Table structure for resign
-- ----------------------------
DROP TABLE IF EXISTS `resign`;
CREATE TABLE `resign`  (
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departId` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phoneNum` bigint(20) NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entryTime` date NOT NULL,
  `resignTime` date NOT NULL,
  PRIMARY KEY (`staffId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resign
-- ----------------------------

-- ----------------------------
-- Table structure for resignreview
-- ----------------------------
DROP TABLE IF EXISTS `resignreview`;
CREATE TABLE `resignreview`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dateTime` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`, `staffId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------
INSERT INTO `resignreview` VALUES (1, '022403', '不想干了', '2024-03-06 11:03:31', '审核通过', '荧');
INSERT INTO `resignreview` VALUES (4, '042301', '家里有矿', '2024-03-21 16:55:09', '审核通过', '钟离');
INSERT INTO `resignreview` VALUES (5, '012303', '工资太低', '2024-03-17 16:55:52', '审核驳回', '卯香菱');
INSERT INTO `resignreview` VALUES (6, '022302', '公司死人了', '2024-03-17 16:56:37', '审核驳回', '胡桃');
INSERT INTO `resignreview` VALUES (7, '012408', '我就是废物', '2024-03-17 16:57:19', '审核通过', '穹');
INSERT INTO `resignreview` VALUES (8, '032301', '废物公司来的', '2024-03-13 21:01:19', '审核驳回', '行秋');

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departId` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phoneNum` bigint(20) NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entryTime` date NOT NULL,
  PRIMARY KEY (`staffId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('022404', '02', 17432397554, '菲谢尔·冯·露弗施洛斯·那菲多特', '女', 23, 6000, '实习生', '2024-03-12');
INSERT INTO `staff` VALUES ('022403', '02', 12132290117, '荧', '女', 600, 8000, '普通员工', '2024-03-06');
INSERT INTO `staff` VALUES ('042301', '04', 15238199014, '钟离', '男', 1000, 7000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052301', '05', 11371238904, '夜阑', '女', 24, 8000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052302', '05', 11371238224, '纳西妲', '女', 500, 4000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052303', '05', 12134444042, '阿斯托洛吉斯·莫娜·梅姬斯图斯', '女', 23, 100000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052304', '05', 13472894789, '久岐忍', '女', 22, 4200, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('012302', '01', 17322297254, '枫原万叶', '男', 22, 5100, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012301', '01', 13172290114, '达达利亚', '男', 23, 9000, '普通员工', '2024-02-15');
INSERT INTO `staff` VALUES ('012303', '01', 19322904711, '卯香菱', '女', 22, 300, '实习生', '2023-09-04');
INSERT INTO `staff` VALUES ('012404', '01', 12171190114, '雷电·影', '女', 300, 7700, '普通员工', '2024-03-01');
INSERT INTO `staff` VALUES ('022301', '02', 13376629080, '班尼特·卡塔库栗', '男', 21, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('022302', '02', 13376629080, '胡桃', '女', 16, 7000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('032301', '03', 13232234167, '行秋', '男', 17, 5000, '实习生', '2023-09-15');
INSERT INTO `staff` VALUES ('042402', '04', 15312250345, '空', '男', 540, 8000, '经理', '2024-03-22');
INSERT INTO `staff` VALUES ('032402', '03', 12322253454, '派蒙', '女', 6, 7000, '普通员工', '2024-03-21');
INSERT INTO `staff` VALUES ('022406', '02', 19273322110, '星', '女', 5, 5000, '普通员工', '2024-03-13');
INSERT INTO `staff` VALUES ('042403', '04', 18293321991, '三月七', '女', 22, 9000, '普通员工', '2024-03-07');
INSERT INTO `staff` VALUES ('042404', '04', 18293318992, '姬子', '女', 32, 13000, '普通员工', '2024-03-06');
INSERT INTO `staff` VALUES ('012407', '01', 19191923128, '瓦尔特·杨', '男', 500, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('012408', '01', 19231239223, '穹', '男', 9, 10000, '经理', '2023-07-20');
INSERT INTO `staff` VALUES ('032403', '03', 18173209421, '丹恒•饮月', '男', 600, 7000, '普通员工', '2024-03-13');
INSERT INTO `staff` VALUES ('032404', '03', 12689931884, '艾吉奥·奥迪托雷·达·佛罗伦萨', '男', 35, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('022405', '02', 15121190114, '派蒙', '女', 6, 4000, '普通员工', '2024-03-08');

-- ----------------------------
-- Table structure for workattendance
-- ----------------------------
DROP TABLE IF EXISTS `workattendance`;
CREATE TABLE `workattendance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `startTime` datetime(0) NOT NULL,
  `endTime` datetime(0) NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of workattendance
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
