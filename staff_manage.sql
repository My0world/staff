/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : staff_manage

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/05/2024 14:19:16
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
) ENGINE = MyISAM AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_authority
-- ----------------------------
INSERT INTO `admin_authority` VALUES (1, 'home', NULL, NULL, 'home', '首页');
INSERT INTO `admin_authority` VALUES (2, 'staff', NULL, NULL, 'staff', '员工管理');
INSERT INTO `admin_authority` VALUES (3, 'staff', 'staffMsg', NULL, 'staffMsg', '员工信息');
INSERT INTO `admin_authority` VALUES (5, 'staff', 'staffMsg', 'userAddStaff', 'userAddStaff', '添加员工(需审核)');
INSERT INTO `admin_authority` VALUES (6, 'staff', 'staffMsg', 'userUpdateStaff', 'userUpdateStaff', '修改员工(需审核)');
INSERT INTO `admin_authority` VALUES (7, 'dimission', 'settingDimission', '', 'settingDimission', '设置为离职');
INSERT INTO `admin_authority` VALUES (8, 'staff', 'staffMsg', 'allStaffMsgView', 'allStaffMsgView', '所有员工信息');
INSERT INTO `admin_authority` VALUES (9, 'staff', 'staffMsg', 'adminAddStaff', 'adminAddStaff', '添加员工(无需审核)');
INSERT INTO `admin_authority` VALUES (10, 'staff', 'staffMsg', 'adminUpdateStaff', 'adminUpdateStaff', '修改员工(无需审核)');
INSERT INTO `admin_authority` VALUES (13, 'user', '', '', 'user', '用户管理');
INSERT INTO `admin_authority` VALUES (14, 'operatingRequestAudit', NULL, NULL, 'operatingRequestAudit', '操作请求审核');
INSERT INTO `admin_authority` VALUES (15, 'operatingRequestAudit', 'updateOpReviewStatus', NULL, 'updateOpReviewStatus', '审核操作的内容');
INSERT INTO `admin_authority` VALUES (16, 'user', 'showUserPassWord', NULL, 'showUserPassWord', '查看某位用户的密码');
INSERT INTO `admin_authority` VALUES (17, 'user', 'allotAuthority', NULL, 'allotAuthority', '分配权限');
INSERT INTO `admin_authority` VALUES (18, 'user', 'updateUserPassWord', NULL, 'updateUserPassWord', '修改某位用户的密码');
INSERT INTO `admin_authority` VALUES (19, 'user', 'deleteUser', NULL, 'deleteUser', '删除某位用户');
INSERT INTO `admin_authority` VALUES (20, 'operatingData', NULL, NULL, 'operatingData', '操作记录');
INSERT INTO `admin_authority` VALUES (21, 'feedback', NULL, NULL, 'feedback', '反馈消息');
INSERT INTO `admin_authority` VALUES (22, 'dimission', NULL, NULL, 'dimission', '离职员工管理');
INSERT INTO `admin_authority` VALUES (28, 'dimission', 'dimissionData', NULL, 'dimissionData', '所有离职员工');
INSERT INTO `admin_authority` VALUES (24, 'user', 'addAdminUser', NULL, 'addAdminUser', '添加用户');
INSERT INTO `admin_authority` VALUES (25, 'dimission', 'returnStaffTable', NULL, 'returnStaffTable', '从离职员工表移回员工表');
INSERT INTO `admin_authority` VALUES (26, 'dimission', 'dimissionAudit', NULL, 'dimissionAudit', '查看离职申请数据');
INSERT INTO `admin_authority` VALUES (27, 'dimission', 'updateResignReviewStatus', NULL, 'updateResignReviewStatus', '审核离职申请');
INSERT INTO `admin_authority` VALUES (31, 'staff', 'staffMsg', 'departmentStaffMsg', 'departmentStaffMsg', '部门员工信息');
INSERT INTO `admin_authority` VALUES (32, 'user', 'userData', '', 'userData', '所有用户数据');
INSERT INTO `admin_authority` VALUES (33, 'operatingRequestAudit', 'operatingRequestAuditData', NULL, 'operatingRequestAuditData', '所有操作请求的数据');
INSERT INTO `admin_authority` VALUES (34, 'staff', 'checkingIn', '', 'checkingIn', '考勤管理');
INSERT INTO `admin_authority` VALUES (35, 'staff', 'checkingIn', 'allCheckingIn', 'allCheckingIn', '所有员工考勤');
INSERT INTO `admin_authority` VALUES (36, 'staff', 'checkingIn', 'departmentCheckingIn', 'departmentCheckingIn', '部门员工考勤');
INSERT INTO `admin_authority` VALUES (37, 'staff', 'checkingIn', 'editCheckingIn', 'editCheckingIn', '修改员工考勤记录');
INSERT INTO `admin_authority` VALUES (42, 'notice', 'noticeForAll', NULL, 'noticeForAll', '向所有部门发送通知');
INSERT INTO `admin_authority` VALUES (41, 'notice', NULL, NULL, 'notice', '通知管理');
INSERT INTO `admin_authority` VALUES (40, 'staff', 'checkingIn', 'checkVacate', 'checkVacate', '审核员工请假');
INSERT INTO `admin_authority` VALUES (43, 'notice', 'noticeForDepart', NULL, 'noticeForDepart', '向自己部门发送通知');

-- ----------------------------
-- Table structure for admin_op_record
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_record`;
CREATE TABLE `admin_op_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 389 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_record
-- ----------------------------
INSERT INTO `admin_op_record` VALUES (200, '<div class=\"shortMsg\">012302用户的修改信息请求编号为46已被012301用户审核并通过</div>', '012301', '2024-03-31 22:29:12');
INSERT INTO `admin_op_record` VALUES (201, '<div class=\"shortMsg\">012302用户的操作请求编号为45已被012301用户驳回</div>', '012301', '2024-03-31 22:29:15');
INSERT INTO `admin_op_record` VALUES (190, '<div class=\"shortMsg\">012301用户通过了042301员工的离职申请</div>', '012301', '2024-03-17 20:57:40');
INSERT INTO `admin_op_record` VALUES (191, '<div class=\"shortMsg\">012301用户通过了012408员工的离职申请</div>', '012301', '2024-03-17 20:58:51');
INSERT INTO `admin_op_record` VALUES (192, '<div class=\"shortMsg\">022302员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 20:58:58');
INSERT INTO `admin_op_record` VALUES (193, '<div class=\"shortMsg\">012303员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 20:58:59');
INSERT INTO `admin_op_record` VALUES (194, '<div class=\"shortMsg\">032301员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-17 21:05:54');
INSERT INTO `admin_op_record` VALUES (195, '<div class=\"shortMsg\">012301将012408从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:16');
INSERT INTO `admin_op_record` VALUES (196, '<div class=\"shortMsg\">012301将042301从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:21');
INSERT INTO `admin_op_record` VALUES (197, '<div class=\"shortMsg\">012301将022405从离职员工移到了正式员工中</div>', '012301', '2024-03-17 22:45:23');
INSERT INTO `admin_op_record` VALUES (198, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>012302用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>18131129667</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>4</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-02</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-31 22:17:07');
INSERT INTO `admin_op_record` VALUES (199, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-31 22:17:29');
INSERT INTO `admin_op_record` VALUES (187, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:32:30');
INSERT INTO `admin_op_record` VALUES (188, '<div class=\"shortMsg\">012302用户的操作请求编号为44已被012301用户驳回</div>', '012301', '2024-03-17 20:32:44');
INSERT INTO `admin_op_record` VALUES (189, '<div class=\"shortMsg\">012302用户的修改信息请求编号为43已被012301用户审核并通过</div>', '012301', '2024-03-17 20:32:47');
INSERT INTO `admin_op_record` VALUES (185, '<div class=\"shortMsg\">012302用户的操作请求编号为42已被012301用户驳回</div>', '012301', '2024-03-17 20:31:51');
INSERT INTO `admin_op_record` VALUES (186, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:32:27');
INSERT INTO `admin_op_record` VALUES (183, '<div class=\"shortMsg\">012302用户的操作请求编号为41已被012301用户驳回</div>', '012301', '2024-03-17 20:30:17');
INSERT INTO `admin_op_record` VALUES (184, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:31:41');
INSERT INTO `admin_op_record` VALUES (182, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012302用户想要修改员工号为012408员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231239223</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12222222222</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-17 20:26:22');
INSERT INTO `admin_op_record` VALUES (202, '<div class=\"shortMsg\">012301将纳西妲设置为离职</div>', '012301', '2024-04-01 09:35:00');
INSERT INTO `admin_op_record` VALUES (203, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-04-01 09:35:14');
INSERT INTO `admin_op_record` VALUES (204, '<div class=\"shortMsg\">012301将丹恒•饮月设置为离职</div>', '012301', '2024-04-01 09:37:55');
INSERT INTO `admin_op_record` VALUES (205, '<div class=\"shortMsg\">012301将三月七设置为离职</div>', '012301', '2024-04-01 09:37:58');
INSERT INTO `admin_op_record` VALUES (206, '<div class=\"shortMsg\">012301将派蒙设置为离职</div>', '012301', '2024-04-01 09:38:36');
INSERT INTO `admin_op_record` VALUES (207, '<div class=\"shortMsg\">012301将012301从离职员工移到了正式员工中</div>', '012301', '2024-04-01 16:40:13');
INSERT INTO `admin_op_record` VALUES (208, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-04-01 16:48:07');
INSERT INTO `admin_op_record` VALUES (209, '<div class=\"shortMsg\">012301用户通过了052301员工的离职申请</div>', '012301', '2024-04-01 17:13:59');
INSERT INTO `admin_op_record` VALUES (210, '<div class=\"shortMsg\">012301将052301从离职员工移到了正式员工中</div>', '012301', '2024-04-01 17:14:38');
INSERT INTO `admin_op_record` VALUES (211, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>022404用户想要修改员工号为022301员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13300000000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '022404', '2024-04-02 22:38:57');
INSERT INTO `admin_op_record` VALUES (212, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>022404用户想要修改员工号为022301员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19111199997</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-18</span>\n            </p>\n        </div>\n        </div>', '022404', '2024-04-02 22:39:43');
INSERT INTO `admin_op_record` VALUES (213, '<div class=\"shortMsg\">022404用户的操作请求编号为48已被012301用户驳回</div>', '012301', '2024-04-02 22:40:23');
INSERT INTO `admin_op_record` VALUES (214, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:14:56');
INSERT INTO `admin_op_record` VALUES (215, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 03:20:58');
INSERT INTO `admin_op_record` VALUES (216, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 03:21:12');
INSERT INTO `admin_op_record` VALUES (217, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:21:21');
INSERT INTO `admin_op_record` VALUES (218, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:22:31');
INSERT INTO `admin_op_record` VALUES (219, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:27:32');
INSERT INTO `admin_op_record` VALUES (220, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:27:46');
INSERT INTO `admin_op_record` VALUES (221, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:30:28');
INSERT INTO `admin_op_record` VALUES (222, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:35:45');
INSERT INTO `admin_op_record` VALUES (223, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>分配权限</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 03:38:56');
INSERT INTO `admin_op_record` VALUES (224, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 03:39:06');
INSERT INTO `admin_op_record` VALUES (225, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 03:44:49');
INSERT INTO `admin_op_record` VALUES (226, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 03:45:02');
INSERT INTO `admin_op_record` VALUES (227, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 04:28:36');
INSERT INTO `admin_op_record` VALUES (228, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 04:28:46');
INSERT INTO `admin_op_record` VALUES (229, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 04:29:03');
INSERT INTO `admin_op_record` VALUES (230, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>分配权限</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 04:30:18');
INSERT INTO `admin_op_record` VALUES (231, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 04:30:28');
INSERT INTO `admin_op_record` VALUES (232, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 04:30:43');
INSERT INTO `admin_op_record` VALUES (233, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>分配权限</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 04:30:52');
INSERT INTO `admin_op_record` VALUES (234, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 04:31:00');
INSERT INTO `admin_op_record` VALUES (235, '\n                    <div class=\"authority\">\n                        <p>022404分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>分配权限</span><span>所有用户数据</span></div></div>', '022404', '2024-04-06 04:31:48');
INSERT INTO `admin_op_record` VALUES (236, '\n                    <div class=\"authority\">\n                        <p>022404分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '022404', '2024-04-06 04:31:56');
INSERT INTO `admin_op_record` VALUES (237, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>查看某位用户的密码</span><span>所有用户数据</span></div></div>', '012301', '2024-04-06 04:32:25');
INSERT INTO `admin_op_record` VALUES (238, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>离职员工管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:51:37');
INSERT INTO `admin_op_record` VALUES (239, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:51:58');
INSERT INTO `admin_op_record` VALUES (240, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>用户管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>分配权限</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:52:20');
INSERT INTO `admin_op_record` VALUES (241, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:52:31');
INSERT INTO `admin_op_record` VALUES (242, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:52:40');
INSERT INTO `admin_op_record` VALUES (243, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>操作请求审核</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:52:58');
INSERT INTO `admin_op_record` VALUES (244, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:53:16');
INSERT INTO `admin_op_record` VALUES (245, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>只可以查看自己部门的员工信息</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:53:46');
INSERT INTO `admin_op_record` VALUES (246, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-06 12:54:14');
INSERT INTO `admin_op_record` VALUES (247, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:26:37');
INSERT INTO `admin_op_record` VALUES (248, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:29:00');
INSERT INTO `admin_op_record` VALUES (249, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:29:22');
INSERT INTO `admin_op_record` VALUES (250, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:30:01');
INSERT INTO `admin_op_record` VALUES (251, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:31:09');
INSERT INTO `admin_op_record` VALUES (252, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:31:34');
INSERT INTO `admin_op_record` VALUES (253, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:32:22');
INSERT INTO `admin_op_record` VALUES (254, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:32:33');
INSERT INTO `admin_op_record` VALUES (255, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:32:49');
INSERT INTO `admin_op_record` VALUES (256, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 16:36:21');
INSERT INTO `admin_op_record` VALUES (257, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-06 16:36:44');
INSERT INTO `admin_op_record` VALUES (258, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:08:32');
INSERT INTO `admin_op_record` VALUES (259, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:14:12');
INSERT INTO `admin_op_record` VALUES (260, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:21:00');
INSERT INTO `admin_op_record` VALUES (261, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:21:47');
INSERT INTO `admin_op_record` VALUES (262, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:24:20');
INSERT INTO `admin_op_record` VALUES (263, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:27:03');
INSERT INTO `admin_op_record` VALUES (264, '<div class=\"shortMsg\">012301查看了的密码</div>', '012301', '2024-04-06 17:27:16');
INSERT INTO `admin_op_record` VALUES (265, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:28:18');
INSERT INTO `admin_op_record` VALUES (266, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-06 17:33:38');
INSERT INTO `admin_op_record` VALUES (267, '<div class=\"shortMsg\">012301修改了022404的密码</div>', '012301', '2024-04-06 17:33:50');
INSERT INTO `admin_op_record` VALUES (268, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-06 17:34:02');
INSERT INTO `admin_op_record` VALUES (269, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:34:24');
INSERT INTO `admin_op_record` VALUES (270, '<div class=\"shortMsg\">012301修改了012301的密码</div>', '012301', '2024-04-06 17:34:34');
INSERT INTO `admin_op_record` VALUES (271, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-06 17:34:40');
INSERT INTO `admin_op_record` VALUES (272, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span></div></div>', '012301', '2024-04-07 18:03:22');
INSERT INTO `admin_op_record` VALUES (273, '<div class=\"shortMsg\">012301删除了022404用户</div>', '012301', '2024-04-07 22:08:45');
INSERT INTO `admin_op_record` VALUES (274, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-07 22:26:01');
INSERT INTO `admin_op_record` VALUES (275, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-07 22:27:11');
INSERT INTO `admin_op_record` VALUES (276, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-07 22:28:19');
INSERT INTO `admin_op_record` VALUES (277, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-07 22:28:34');
INSERT INTO `admin_op_record` VALUES (278, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span></div></div>', '012301', '2024-04-07 22:36:15');
INSERT INTO `admin_op_record` VALUES (279, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-07 22:36:27');
INSERT INTO `admin_op_record` VALUES (280, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-07 22:49:04');
INSERT INTO `admin_op_record` VALUES (281, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-07 22:49:27');
INSERT INTO `admin_op_record` VALUES (282, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012301用户想要修改员工号为012407员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>500</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-04-07 22:52:06');
INSERT INTO `admin_op_record` VALUES (283, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012301用户想要修改员工号为012407员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>500</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-04-07 22:52:18');
INSERT INTO `admin_op_record` VALUES (284, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012301用户想要修改员工号为012407员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>500</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>瓦尔特·杨</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19191923128</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-14</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-04-07 22:53:54');
INSERT INTO `admin_op_record` VALUES (285, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-07 23:04:20');
INSERT INTO `admin_op_record` VALUES (286, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>012301用户想要修改员工号为012404员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>雷电·影</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12171190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>300</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7700</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-01</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>雷电·影</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12171190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>500</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7700</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-01</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-04-07 23:04:49');
INSERT INTO `admin_op_record` VALUES (287, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-07 23:05:12');
INSERT INTO `admin_op_record` VALUES (288, '<div class=\"shortMsg\">012301用户的修改信息请求编号为52已被012301用户审核并通过</div>', '012301', '2024-04-07 23:05:19');
INSERT INTO `admin_op_record` VALUES (289, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了012301</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '012301', '2024-04-08 09:49:07');
INSERT INTO `admin_op_record` VALUES (290, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 09:49:33');
INSERT INTO `admin_op_record` VALUES (291, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 09:55:28');
INSERT INTO `admin_op_record` VALUES (292, '<div class=\"shortMsg\">012301修改了012301的密码</div>', '012301', '2024-04-08 09:55:39');
INSERT INTO `admin_op_record` VALUES (293, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 09:55:55');
INSERT INTO `admin_op_record` VALUES (294, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 11:02:12');
INSERT INTO `admin_op_record` VALUES (295, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 11:15:02');
INSERT INTO `admin_op_record` VALUES (296, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 11:15:12');
INSERT INTO `admin_op_record` VALUES (297, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 11:16:51');
INSERT INTO `admin_op_record` VALUES (298, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-08 13:48:42');
INSERT INTO `admin_op_record` VALUES (299, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-08 13:49:23');
INSERT INTO `admin_op_record` VALUES (300, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-08 13:50:34');
INSERT INTO `admin_op_record` VALUES (301, '<div class=\"shortMsg\">012301查看了022404的密码</div>', '012301', '2024-04-08 13:50:50');
INSERT INTO `admin_op_record` VALUES (302, '<div class=\"shortMsg\">012301添加了022404用户</div>', '012301', '2024-04-08 13:52:00');
INSERT INTO `admin_op_record` VALUES (303, '<div class=\"shortMsg\">012301查看了012301的密码</div>', '012301', '2024-04-08 14:00:48');
INSERT INTO `admin_op_record` VALUES (304, '\n                    <div class=\"authority\">\n                        <p>012301分配权限给了022404</p>\n                        \n                        <div>\n                <span>首页</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span></div></div>', '012301', '2024-04-08 14:02:18');
INSERT INTO `admin_op_record` VALUES (305, '<div class=\"shortMsg\">012301删除了012301用户</div>', '012301', '2024-04-08 14:02:42');
INSERT INTO `admin_op_record` VALUES (306, '\n                    <div class=\"authority\">\n                        <p>022404分配权限给了022404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '022404', '2024-04-08 14:05:08');
INSERT INTO `admin_op_record` VALUES (307, '<div class=\"shortMsg\">022404将达达利亚设置为离职</div>', '022404', '2024-04-08 14:06:13');
INSERT INTO `admin_op_record` VALUES (308, '<div class=\"shortMsg\">022404添加了032404用户</div>', '022404', '2024-04-08 14:06:40');
INSERT INTO `admin_op_record` VALUES (309, '\n                    <div class=\"authority\">\n                        <p>022404分配权限给了032404</p>\n                        \n                        <div>\n                <span>首页</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span></div></div>', '022404', '2024-04-08 14:08:03');
INSERT INTO `admin_op_record` VALUES (310, '<div class=\"shortMsg\">022404删除了022404用户</div>', '022404', '2024-04-08 14:08:18');
INSERT INTO `admin_op_record` VALUES (311, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了032404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 14:26:47');
INSERT INTO `admin_op_record` VALUES (312, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>迈凯伦塞纳</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17124287216</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>20</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>99000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-08 14:34:32');
INSERT INTO `admin_op_record` VALUES (313, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>迈凯伦塞纳</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17124287216</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>20</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>99000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-08 14:35:17');
INSERT INTO `admin_op_record` VALUES (314, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>迈凯伦塞纳</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17124287216</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>20</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>99000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-08 14:38:58');
INSERT INTO `admin_op_record` VALUES (315, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>Intensa Emozione</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>14294374825</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-08 14:40:59');
INSERT INTO `admin_op_record` VALUES (316, '<div class=\"shortMsg\">032404添加了022407用户</div>', '032404', '2024-04-08 14:42:15');
INSERT INTO `admin_op_record` VALUES (317, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>首页</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span></div></div>', '032404', '2024-04-08 14:42:32');
INSERT INTO `admin_op_record` VALUES (318, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了032404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 14:48:47');
INSERT INTO `admin_op_record` VALUES (319, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>只可以查看自己部门的员工信息</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span></div></div>', '032404', '2024-04-08 14:49:19');
INSERT INTO `admin_op_record` VALUES (320, '<div class=\"shortMsg\">022404用户的修改信息请求编号为47已被022407用户审核并通过</div>', '022407', '2024-04-08 14:50:07');
INSERT INTO `admin_op_record` VALUES (321, '<div class=\"shortMsg\">032404添加了022406用户</div>', '032404', '2024-04-08 14:51:31');
INSERT INTO `admin_op_record` VALUES (322, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022406</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>只可以查看自己部门的员工信息</span></div></div>', '032404', '2024-04-08 14:52:00');
INSERT INTO `admin_op_record` VALUES (323, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>022406用户想要修改员工号为022405员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022405</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>星</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19273322110</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-13</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022405</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>星</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19000000000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-13</span>\n            </p>\n        </div>\n        </div>', '022406', '2024-04-08 14:53:26');
INSERT INTO `admin_op_record` VALUES (324, '<div class=\"shortMsg\">022406用户的修改信息请求编号为53已被032404用户审核并通过</div>', '032404', '2024-04-08 14:54:25');
INSERT INTO `admin_op_record` VALUES (325, '<div class=\"shortMsg\">022406用户的修改信息请求编号为53已被022407用户审核并通过</div>', '022407', '2024-04-08 14:54:27');
INSERT INTO `admin_op_record` VALUES (326, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了032404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>所有员工考勤</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 22:24:12');
INSERT INTO `admin_op_record` VALUES (327, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了032404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>所有员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 22:24:27');
INSERT INTO `admin_op_record` VALUES (328, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022406</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span></div></div>', '032404', '2024-04-08 22:24:43');
INSERT INTO `admin_op_record` VALUES (329, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 22:25:18');
INSERT INTO `admin_op_record` VALUES (330, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 22:26:20');
INSERT INTO `admin_op_record` VALUES (331, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span></div></div>', '032404', '2024-04-08 22:26:34');
INSERT INTO `admin_op_record` VALUES (332, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span></div></div>', '032404', '2024-04-12 15:42:21');
INSERT INTO `admin_op_record` VALUES (333, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了032404</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>通知管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>所有员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span><span>操作记录</span><span>反馈消息</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span><span>向所有部门发送通知</span></div></div>', '032404', '2024-04-12 16:19:50');
INSERT INTO `admin_op_record` VALUES (334, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-12 16:20:20');
INSERT INTO `admin_op_record` VALUES (335, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-12 16:20:49');
INSERT INTO `admin_op_record` VALUES (336, '\n                    <div class=\"authority\">\n                        <p>022407分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>用户管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>查看某位用户的密码</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>向自己部门发送通知</span></div></div>', '022407', '2024-04-12 16:21:24');
INSERT INTO `admin_op_record` VALUES (337, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>用户管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>添加用户</span><span>所有用户数据</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-12 16:22:15');
INSERT INTO `admin_op_record` VALUES (338, '<div class=\"shortMsg\">032404查看了032404的密码</div>', '032404', '2024-04-12 16:26:31');
INSERT INTO `admin_op_record` VALUES (339, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100090114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>100</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-22</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-14 14:08:35');
INSERT INTO `admin_op_record` VALUES (340, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为032305员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032305</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100090114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>100</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-22</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032305</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100090000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>100</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-22</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:15:22');
INSERT INTO `admin_op_record` VALUES (341, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为032305员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032305</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100090000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>100</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-22</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032305</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>帕姆</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100000000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>100</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-22</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:17:02');
INSERT INTO `admin_op_record` VALUES (342, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为012408员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000001</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:17:49');
INSERT INTO `admin_op_record` VALUES (343, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为012408员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000001</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000201</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:19:12');
INSERT INTO `admin_op_record` VALUES (344, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为012408员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000201</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000211</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:19:52');
INSERT INTO `admin_op_record` VALUES (345, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为012408员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19231000211</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012408</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>穹</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19201000211</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-07-20</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-15 22:22:45');
INSERT INTO `admin_op_record` VALUES (346, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>用户管理</span><span>离职员工管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>添加用户</span><span>所有用户数据</span><span>设置为离职</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-15 22:33:09');
INSERT INTO `admin_op_record` VALUES (347, '<div class=\"shortMsg\">022407将胡桃设置为离职</div>', '022407', '2024-04-15 22:33:47');
INSERT INTO `admin_op_record` VALUES (348, '<div class=\"shortMsg\">032404将022302从离职员工移到了正式员工中</div>', '032404', '2024-04-15 22:33:55');
INSERT INTO `admin_op_record` VALUES (349, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>022406用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>飞升自由</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13100061846</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>9</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-03</span>\n            </p>\n        </div>\n        </div>', '022406', '2024-04-15 22:49:33');
INSERT INTO `admin_op_record` VALUES (350, '<div class=\"shortMsg\">022406用户的添加信息请求编号为54已被032404用户审核并通过</div>', '032404', '2024-04-15 22:50:01');
INSERT INTO `admin_op_record` VALUES (351, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022406</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>通知管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-21 00:56:22');
INSERT INTO `admin_op_record` VALUES (352, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为022407员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>Intensa Emozione</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>14294374825</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022407</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>阿波罗IE</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>14294374825</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-01</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-28 15:39:52');
INSERT INTO `admin_op_record` VALUES (353, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>梁庚大</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13184495447</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>13</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-30</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:30:50');
INSERT INTO `admin_op_record` VALUES (354, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>梁庚大</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13184495447</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>13</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-30</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:30:53');
INSERT INTO `admin_op_record` VALUES (355, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>梁庚大</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13184495447</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>13</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-30</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:31:01');
INSERT INTO `admin_op_record` VALUES (356, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>梁庚大</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172289122</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>8000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-25</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:40:31');
INSERT INTO `admin_op_record` VALUES (357, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>宫龙寻</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>18595532114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:45:14');
INSERT INTO `admin_op_record` VALUES (358, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为012409员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012409</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>宫龙寻</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>18595532114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012409</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>宫龙寻</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>18595500000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 22:45:36');
INSERT INTO `admin_op_record` VALUES (359, '<div class=\"shortMsg\">032404查看了022407的密码</div>', '032404', '2024-04-30 22:49:28');
INSERT INTO `admin_op_record` VALUES (360, '<div class=\"shortMsg\">032404修改了022407的密码</div>', '032404', '2024-04-30 22:49:51');
INSERT INTO `admin_op_record` VALUES (361, '<div class=\"shortMsg\">032404添加了022409用户</div>', '032404', '2024-04-30 22:50:29');
INSERT INTO `admin_op_record` VALUES (362, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022409</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>所有员工信息</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span><span>用户管理</span><span>查看某位用户的密码</span><span>分配权限</span><span>修改某位用户的密码</span><span>删除某位用户</span><span>添加用户</span><span>所有用户数据</span><span>操作请求审核</span><span>审核操作的内容</span><span>所有操作请求的数据</span></div></div>', '032404', '2024-04-30 22:52:29');
INSERT INTO `admin_op_record` VALUES (363, '<div class=\"shortMsg\">032404删除了022409用户</div>', '032404', '2024-04-30 22:52:41');
INSERT INTO `admin_op_record` VALUES (364, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022406</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>通知管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span><span>离职员工管理</span><span>设置为离职</span><span>所有离职员工</span><span>从离职员工表移回员工表</span><span>查看离职申请数据</span><span>审核离职申请</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-04-30 22:53:01');
INSERT INTO `admin_op_record` VALUES (365, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>022406用户想要修改员工号为022404员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432300000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        </div>', '022406', '2024-04-30 22:54:18');
INSERT INTO `admin_op_record` VALUES (366, '<div class=\"shortMsg\">022406用户的修改信息请求编号为55已被032404用户审核并通过</div>', '032404', '2024-04-30 22:54:48');
INSERT INTO `admin_op_record` VALUES (367, '<div class=\"shortMsg\">052301员工的离职申请已被032404用户驳回</div>', '032404', '2024-04-30 22:55:04');
INSERT INTO `admin_op_record` VALUES (368, '<div class=\"shortMsg\">052303员工的离职申请已被032404用户驳回</div>', '032404', '2024-04-30 22:55:05');
INSERT INTO `admin_op_record` VALUES (369, '<div class=\"shortMsg\">032404将012301从离职员工移到了正式员工中</div>', '032404', '2024-04-30 22:55:53');
INSERT INTO `admin_op_record` VALUES (370, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>test</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12385565554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 23:10:35');
INSERT INTO `admin_op_record` VALUES (371, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>032404用户修改员工号为032406员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032406</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>test</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12385565554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>032406</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>test</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12385565000</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-04-29</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-04-30 23:11:38');
INSERT INTO `admin_op_record` VALUES (372, '\n            <div class=\'update\'>\n                <div>\n                    <p>修改信息请求</p>\n                    <p>022406用户想要修改员工号为022403员工的信息</p>\n                </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022403</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>荧</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12132290117</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>600</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>8000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-06</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022403</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>荧</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12132290117</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>10000</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>8000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-06</span>\n            </p>\n        </div>\n        </div>', '022406', '2024-04-30 23:12:55');
INSERT INTO `admin_op_record` VALUES (373, '<div class=\"shortMsg\">022406用户的修改信息请求编号为56已被032404用户审核并通过</div>', '032404', '2024-04-30 23:13:35');
INSERT INTO `admin_op_record` VALUES (374, '<div class=\"shortMsg\">032404将test设置为离职</div>', '032404', '2024-04-30 23:13:56');
INSERT INTO `admin_op_record` VALUES (375, '<div class=\"shortMsg\">032404将032406从离职员工移到了正式员工中</div>', '032404', '2024-04-30 23:14:13');
INSERT INTO `admin_op_record` VALUES (376, '<div class=\"shortMsg\">032404添加了022409用户</div>', '032404', '2024-04-30 23:16:48');
INSERT INTO `admin_op_record` VALUES (377, '<div class=\"shortMsg\">032404查看了022409的密码</div>', '032404', '2024-04-30 23:17:00');
INSERT INTO `admin_op_record` VALUES (378, '<div class=\"shortMsg\">032404修改了022409的密码</div>', '032404', '2024-04-30 23:17:15');
INSERT INTO `admin_op_record` VALUES (379, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022409</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>首页</span><span>添加员工(需审核)</span><span>修改员工(需审核)</span><span>部门员工信息</span><span>所有员工考勤</span><span>修改员工考勤记录</span><span>审核员工请假</span></div></div>', '032404', '2024-04-30 23:18:10');
INSERT INTO `admin_op_record` VALUES (380, '<div class=\"shortMsg\">032404删除了022409用户</div>', '032404', '2024-04-30 23:18:20');
INSERT INTO `admin_op_record` VALUES (381, '<div class=\"shortMsg\">032404用户通过了012409员工的离职申请</div>', '032404', '2024-05-18 02:39:54');
INSERT INTO `admin_op_record` VALUES (382, '<div class=\"shortMsg\">032404查看了022407的密码</div>', '032404', '2024-05-18 02:40:11');
INSERT INTO `admin_op_record` VALUES (383, '\n                    <div class=\"authority\">\n                        <p>032404分配权限给了022407</p>\n                        \n                        <div>\n                <span>员工管理</span><span>员工信息</span><span>考勤管理</span><span>用户管理</span><span>离职员工管理</span><span>通知管理</span><span>首页</span><span>添加员工(无需审核)</span><span>修改员工(无需审核)</span><span>部门员工信息</span><span>部门员工考勤</span><span>添加用户</span><span>所有用户数据</span><span>设置为离职</span><span>所有离职员工</span><span>向自己部门发送通知</span></div></div>', '032404', '2024-05-18 02:41:02');
INSERT INTO `admin_op_record` VALUES (384, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>test1</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>20</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-05-15</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-05-18 09:39:53');
INSERT INTO `admin_op_record` VALUES (385, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>032404用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>test2</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290331</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-05-16</span>\n            </p>\n        </div>\n        </div>', '032404', '2024-05-18 11:12:49');
INSERT INTO `admin_op_record` VALUES (386, '<div class=\"shortMsg\">032404查看了022406的密码</div>', '032404', '2024-05-18 11:14:27');
INSERT INTO `admin_op_record` VALUES (387, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>022406用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>testww</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13194420119</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>2</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>2000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-05-15</span>\n            </p>\n        </div>\n        </div>', '022406', '2024-05-18 11:15:13');
INSERT INTO `admin_op_record` VALUES (388, '<div class=\"shortMsg\">022406用户的添加信息请求编号为57已被032404用户审核并通过</div>', '032404', '2024-05-18 11:15:23');

-- ----------------------------
-- Table structure for admin_op_review
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_review`;
CREATE TABLE `admin_op_review`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------
INSERT INTO `admin_op_review` VALUES (47, '{\"oldData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": \"13300000000\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-02 22:38:57', '审核通过');
INSERT INTO `admin_op_review` VALUES (48, '{\"oldData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": \"19111199997\", \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u5e15\\u59c6\", \"sex\": \"\\u7537\", \"age\": 5, \"salary\": 7000, \"entryTime\": \"2024-04-18\"}}', 'updateRequest', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-02 22:39:43', '审核驳回');
INSERT INTO `admin_op_review` VALUES (52, '{\"oldData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}, \"newData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 500, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}}', 'updateRequest', '012301', '达达利亚', '2024-04-07 23:04:49', '审核通过');
INSERT INTO `admin_op_review` VALUES (53, '{\"oldData\": {\"staffId\": \"022405\", \"departId\": \"02\", \"phoneNum\": 19273322110, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}, \"newData\": {\"staffId\": \"022405\", \"departId\": \"02\", \"phoneNum\": \"19000000000\", \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"salary\": 5000, \"entryTime\": \"2024-03-13\"}}', 'updateRequest', '022406', '迈凯伦塞纳', '2024-04-08 14:53:26', '审核通过');
INSERT INTO `admin_op_review` VALUES (54, '{\"departId\": \"02\", \"phoneNum\": \"13100061846\", \"staffName\": \"\\u98de\\u5347\\u81ea\\u7531\", \"sex\": \"\\u7537\", \"age\": 9, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 4000, \"entryTime\": \"2024-04-03\"}', 'addRequest', '022406', '迈凯伦塞纳', '2024-04-15 22:49:33', '审核通过');
INSERT INTO `admin_op_review` VALUES (55, '{\"oldData\": {\"staffId\": \"022404\", \"departId\": \"02\", \"phoneNum\": 17432397554, \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u83f2\\u8c22\\u5c14\\u00b7\\u51af\\u00b7\\u9732\\u5f17\\u65bd\\u6d1b\\u65af\\u00b7\\u90a3\\u83f2\\u591a\\u7279\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 6000, \"entryTime\": \"2024-03-12\"}, \"newData\": {\"staffId\": \"022404\", \"departId\": \"02\", \"phoneNum\": \"17432300000\", \"job\": \"\\u5b9e\\u4e60\\u751f\", \"staffName\": \"\\u83f2\\u8c22\\u5c14\\u00b7\\u51af\\u00b7\\u9732\\u5f17\\u65bd\\u6d1b\\u65af\\u00b7\\u90a3\\u83f2\\u591a\\u7279\", \"sex\": \"\\u5973\", \"age\": 23, \"salary\": 6000, \"entryTime\": \"2024-03-12\"}}', 'updateRequest', '022406', '迈凯伦塞纳', '2024-04-30 22:54:18', '审核通过');
INSERT INTO `admin_op_review` VALUES (56, '{\"oldData\": {\"staffId\": \"022403\", \"departId\": \"02\", \"phoneNum\": 12132290117, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u8367\", \"sex\": \"\\u5973\", \"age\": 600, \"salary\": 8000, \"entryTime\": \"2024-03-06\"}, \"newData\": {\"staffId\": \"022403\", \"departId\": \"02\", \"phoneNum\": 12132290117, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u8367\", \"sex\": \"\\u5973\", \"age\": 10000, \"salary\": 8000, \"entryTime\": \"2024-03-06\"}}', 'updateRequest', '022406', '迈凯伦塞纳', '2024-04-30 23:12:55', '审核通过');
INSERT INTO `admin_op_review` VALUES (57, '{\"departId\": \"02\", \"phoneNum\": \"13194420119\", \"staffName\": \"testww\", \"sex\": \"\\u7537\", \"age\": 2, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"salary\": 2000, \"entryTime\": \"2024-05-15\"}', 'addRequest', '022406', '迈凯伦塞纳', '2024-05-18 11:15:13', '审核通过');

-- ----------------------------
-- Table structure for admin_send_notice
-- ----------------------------
DROP TABLE IF EXISTS `admin_send_notice`;
CREATE TABLE `admin_send_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
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
INSERT INTO `admin_user` VALUES ('032404', '03', '艾吉奥·奥迪托雷·达·佛罗伦萨', 'admin', '在线', 'staff,staffMsg,checkingIn,notice,home,allStaffMsgView,adminAddStaff,adminUpdateStaff,allCheckingIn,editCheckingIn,checkVacate,user,showUserPassWord,allotAuthority,updateUserPassWord,deleteUser,addAdminUser,userData,operatingRequestAudit,updateOpReviewStatus,operatingRequestAuditData,operatingData,feedback,dimission,settingDimission,dimissionData,returnStaffTable,dimissionAudit,updateResignReviewStatus,noticeForAll');
INSERT INTO `admin_user` VALUES ('022407', '02', 'Intensa Emozione', '123', '下线', 'staff,staffMsg,checkingIn,user,dimission,notice,home,adminAddStaff,adminUpdateStaff,departmentStaffMsg,departmentCheckingIn,addAdminUser,userData,settingDimission,dimissionData,noticeForDepart');
INSERT INTO `admin_user` VALUES ('022406', '02', '迈凯伦塞纳', 'admin', '在线', 'staff,staffMsg,checkingIn,notice,home,userAddStaff,userUpdateStaff,departmentStaffMsg,departmentCheckingIn,editCheckingIn,checkVacate,dimission,settingDimission,dimissionData,returnStaffTable,dimissionAudit,updateResignReviewStatus,noticeForDepart');

-- ----------------------------
-- Table structure for askforleave
-- ----------------------------
DROP TABLE IF EXISTS `askforleave`;
CREATE TABLE `askforleave`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `departId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `startTime` date NOT NULL,
  `endTime` date NOT NULL,
  `dateTime` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of askforleave
-- ----------------------------
INSERT INTO `askforleave` VALUES (1, '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '02', '加班太累了，休息', '2024-04-21', '2024-04-21', '2024-04-21 21:35:56', '审核通过');
INSERT INTO `askforleave` VALUES (2, '032301', '行秋', '03', '回家睡觉', '2024-04-30', '2024-04-30', '2024-04-21 21:37:29', '审核通过');
INSERT INTO `askforleave` VALUES (3, '032305', '帕姆', '03', '放长假旅游', '2024-05-02', '2024-05-04', '2024-04-21 21:38:33', '审核通过');
INSERT INTO `askforleave` VALUES (4, '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '03', '休息', '2024-05-07', '2024-05-07', '2024-04-21 21:40:47', '审核通过');
INSERT INTO `askforleave` VALUES (5, '022403', '荧', '02', '累了', '2024-04-23', '2024-04-26', '2024-04-24 23:01:21', '审核通过');
INSERT INTO `askforleave` VALUES (6, '022302', '胡桃', '02', '累了', '2024-04-24', '2024-04-30', '2024-04-24 23:18:39', '审核通过');
INSERT INTO `askforleave` VALUES (7, '022302', '胡桃', '02', '累了', '2024-05-21', '2024-05-21', '2024-05-14 23:18:39', '审核通过');
INSERT INTO `askforleave` VALUES (8, '022409', '梁庚大', '02', '累了', '2024-05-20', '2024-05-20', '2024-05-18 07:18:39', '待审核');

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
  `dateTime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (17, '忘记密码了', '012302', '2024-03-17 14:55:25');
INSERT INTO `feedback` VALUES (18, '报服务器异常的错误\n', '012303', '2024-03-17 14:55:42');
INSERT INTO `feedback` VALUES (19, '123SADASD', '032404', '2024-04-14 13:56:44');
INSERT INTO `feedback` VALUES (20, 'asdwdadw', '012301', '2024-04-30 22:57:40');
INSERT INTO `feedback` VALUES (21, '156155', '012302', '2024-04-30 23:19:54');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_departIds` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, 'admin', '032404', '01,02,03,04,05', 'test', '2024-04-21 00:08:01');
INSERT INTO `notice` VALUES (2, 'testtesttest', '022406', '02', 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest', '2024-04-21 00:57:20');
INSERT INTO `notice` VALUES (3, 'adwdawdwd', '032404', '02', 'test', '2024-04-21 00:59:58');
INSERT INTO `notice` VALUES (4, 'asfasf', '032404', '02', 'fasfasfasdasfgfw', '2024-04-21 01:02:01');
INSERT INTO `notice` VALUES (5, 'asfasfdsa', '032404', '02', 'asdasdasdwdawdawfwaawd', '2024-04-21 01:02:34');
INSERT INTO `notice` VALUES (6, 'asdddddddddddddddddd', '022407', '02', '2wwwwwwwwwwwwwwwwwwwwwwwwwww', '2024-04-21 01:05:14');
INSERT INTO `notice` VALUES (7, 'test', '032404', '01,02,03,04,05', 'testtest', '2024-04-30 22:48:39');
INSERT INTO `notice` VALUES (8, 'test', '032404', '01,02,03,04,05', '123152', '2024-04-30 23:15:58');
INSERT INTO `notice` VALUES (9, 'tes', '022406', '02', '123', '2024-05-18 11:16:31');

-- ----------------------------
-- Table structure for receivernotice
-- ----------------------------
DROP TABLE IF EXISTS `receivernotice`;
CREATE TABLE `receivernotice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
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
INSERT INTO `resign` VALUES ('052302', '05', 11371238224, '纳西妲', '女', 500, 4000, '普通员工', '2023-09-15', '2024-04-01');
INSERT INTO `resign` VALUES ('032403', '03', 18173209421, '丹恒•饮月', '男', 600, 7000, '普通员工', '2024-03-13', '2024-04-01');
INSERT INTO `resign` VALUES ('042403', '04', 18293321991, '三月七', '女', 22, 9000, '普通员工', '2024-03-07', '2024-04-01');
INSERT INTO `resign` VALUES ('012409', '01', 18595500000, '宫龙寻', '男', 6, 5000, '经理', '2024-04-29', '2024-05-18');

-- ----------------------------
-- Table structure for resignreview
-- ----------------------------
DROP TABLE IF EXISTS `resignreview`;
CREATE TABLE `resignreview`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dateTime` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`, `staffId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------
INSERT INTO `resignreview` VALUES (10, '052303', '找到更好的工作，准备转行。', '2024-03-31 09:50:44', '审核驳回', '阿斯托洛吉斯·莫娜·梅姬斯图斯');
INSERT INTO `resignreview` VALUES (9, '052301', '需要出国留学。', '2024-04-01 09:49:50', '审核驳回', '夜阑');
INSERT INTO `resignreview` VALUES (11, '022409', '找到更好的工作，准备转行。', '2024-05-17 09:49:50', '待审核', '梁庚大');
INSERT INTO `resignreview` VALUES (12, '012409', '找到更好的工作，准备转行。', '2024-05-17 09:49:50', '审核通过', '宫龙寻');

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
INSERT INTO `staff` VALUES ('022404', '02', 17432300000, '菲谢尔·冯·露弗施洛斯·那菲多特', '女', 23, 6000, '实习生', '2024-03-12');
INSERT INTO `staff` VALUES ('022403', '02', 12132290117, '荧', '女', 10000, 8000, '普通员工', '2024-03-06');
INSERT INTO `staff` VALUES ('042301', '04', 15238199014, '钟离', '男', 1000, 7000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052301', '05', 11371238904, '夜阑', '女', 24, 8000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052303', '05', 12134444042, '阿斯托洛吉斯·莫娜·梅姬斯图斯', '女', 23, 100000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052304', '05', 13472894789, '久岐忍', '女', 22, 4200, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('012302', '01', 17322297254, '枫原万叶', '男', 22, 5100, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012303', '01', 19322904711, '卯香菱', '女', 22, 300, '实习生', '2023-09-04');
INSERT INTO `staff` VALUES ('012404', '01', 12171190114, '雷电·影', '女', 500, 7700, '普通员工', '2024-03-01');
INSERT INTO `staff` VALUES ('022301', '02', 13300000000, '班尼特·卡塔库栗', '男', 21, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('022302', '02', 13376629080, '胡桃', '女', 16, 7000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('032301', '03', 13232234167, '行秋', '男', 17, 5000, '实习生', '2023-09-15');
INSERT INTO `staff` VALUES ('042402', '04', 15312250345, '空', '男', 540, 8000, '经理', '2024-03-22');
INSERT INTO `staff` VALUES ('032402', '03', 12322253454, '派蒙', '女', 6, 7000, '普通员工', '2024-03-21');
INSERT INTO `staff` VALUES ('022405', '02', 19000000000, '星', '女', 5, 5000, '普通员工', '2024-03-13');
INSERT INTO `staff` VALUES ('042404', '04', 18293318992, '姬子', '女', 32, 13000, '普通员工', '2024-03-06');
INSERT INTO `staff` VALUES ('012407', '01', 19191923128, '瓦尔特·杨', '男', 500, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('012408', '01', 19201000211, '穹', '男', 9, 10000, '经理', '2023-07-20');
INSERT INTO `staff` VALUES ('032404', '03', 12689931884, '艾吉奥·奥迪托雷·达·佛罗伦萨', '男', 35, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('022406', '02', 17124287216, '迈凯伦塞纳', '男', 20, 99000, '普通员工', '2024-04-01');
INSERT INTO `staff` VALUES ('022407', '02', 14294374825, '阿波罗IE', '男', 5, 10000, '普通员工', '2024-04-01');
INSERT INTO `staff` VALUES ('032305', '03', 13100000000, '帕姆', '男', 100, 10000, '普通员工', '2023-07-22');
INSERT INTO `staff` VALUES ('022408', '02', 13100061846, '飞升自由', '男', 9, 4000, '普通员工', '2024-04-03');
INSERT INTO `staff` VALUES ('012405', '01', 12171190000, '零式飞翼', '男', 500, 7700, '普通员工', '2024-03-01');
INSERT INTO `staff` VALUES ('012406', '01', 13171190000, '地狱死神', '男', 500, 7700, '普通员工', '2024-03-01');
INSERT INTO `staff` VALUES ('022409', '02', 13172289122, '梁庚大', '男', 23, 8000, '经理', '2024-04-25');
INSERT INTO `staff` VALUES ('032407', '03', 13172290114, 'test1', '男', 20, 5000, '普通员工', '2024-05-15');
INSERT INTO `staff` VALUES ('012301', '01', 13172290114, '达达利亚', '男', 22, 10000, '普通员工', '2024-04-01');
INSERT INTO `staff` VALUES ('032406', '03', 12385565000, 'test', '女', 5, 3000, '经理', '2024-04-29');
INSERT INTO `staff` VALUES ('012410', '01', 13172290331, 'test2', '男', 6, 3000, '普通员工', '2024-05-16');
INSERT INTO `staff` VALUES ('022410', '02', 13194420119, 'testww', '男', 2, 2000, '普通员工', '2024-05-15');

-- ----------------------------
-- Table structure for workattendance
-- ----------------------------
DROP TABLE IF EXISTS `workattendance`;
CREATE TABLE `workattendance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `startTime` time NULL DEFAULT NULL,
  `endTime` time NULL DEFAULT NULL,
  `departId` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 656 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of workattendance
-- ----------------------------
INSERT INTO `workattendance` VALUES (1, '请假', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-21', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (2, '请假', '032301', '行秋', '2024-04-30', '00:00:00', '00:00:00', '03');
INSERT INTO `workattendance` VALUES (3, '请假', '032305', '帕姆', '2024-05-02', '00:00:00', '00:00:00', '03');
INSERT INTO `workattendance` VALUES (4, '请假', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-07', '00:00:00', '00:00:00', '03');
INSERT INTO `workattendance` VALUES (5, '请假', '032305', '帕姆', '2024-05-03', '00:00:00', '00:00:00', '03');
INSERT INTO `workattendance` VALUES (6, '请假', '032305', '帕姆', '2024-05-04', '00:00:00', '00:00:00', '03');
INSERT INTO `workattendance` VALUES (39, '迟到', '032301', '行秋', '2024-04-21', '09:01:37', '19:18:33', '03');
INSERT INTO `workattendance` VALUES (38, '迟到', '022302', '胡桃', '2024-04-21', '09:06:34', '18:49:22', '02');
INSERT INTO `workattendance` VALUES (37, '迟到', '022301', '班尼特·卡塔库栗', '2024-04-21', '09:28:33', '18:59:10', '02');
INSERT INTO `workattendance` VALUES (36, '迟到', '012302', '枫原万叶', '2024-04-21', '09:12:32', '19:53:38', '01');
INSERT INTO `workattendance` VALUES (35, '正常', '052304', '久岐忍', '2024-04-21', '08:27:20', '18:21:37', '05');
INSERT INTO `workattendance` VALUES (34, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-21', '08:13:36', '18:24:21', '05');
INSERT INTO `workattendance` VALUES (33, '迟到', '052301', '夜阑', '2024-04-21', '09:19:22', '19:30:17', '05');
INSERT INTO `workattendance` VALUES (32, '正常', '042301', '钟离', '2024-04-21', '08:16:59', '18:19:14', '04');
INSERT INTO `workattendance` VALUES (31, '正常', '012303', '卯香菱', '2024-04-21', '08:29:51', '19:21:07', '01');
INSERT INTO `workattendance` VALUES (30, '迟到', '032305', '帕姆', '2024-04-21', '09:24:32', '18:52:20', '03');
INSERT INTO `workattendance` VALUES (29, '迟到', '012408', '穹', '2024-04-21', '09:00:36', '17:55:48', '01');
INSERT INTO `workattendance` VALUES (40, '迟到', '012404', '雷电·影', '2024-04-21', '09:15:58', '18:04:29', '01');
INSERT INTO `workattendance` VALUES (41, '正常', '022403', '荧', '2024-04-21', '08:22:08', '18:44:18', '02');
INSERT INTO `workattendance` VALUES (42, '迟到', '042404', '姬子', '2024-04-21', '09:21:12', '19:18:31', '04');
INSERT INTO `workattendance` VALUES (43, '正常', '022405', '星', '2024-04-21', '08:18:41', '19:45:06', '02');
INSERT INTO `workattendance` VALUES (44, '迟到', '012407', '瓦尔特·杨', '2024-04-21', '09:27:50', '19:31:41', '01');
INSERT INTO `workattendance` VALUES (45, '迟到', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-21', '09:10:05', '18:24:36', '03');
INSERT INTO `workattendance` VALUES (46, '正常', '032402', '派蒙', '2024-04-21', '09:29:34', '19:57:44', '03');
INSERT INTO `workattendance` VALUES (47, '迟到', '042402', '空', '2024-04-21', '09:24:15', '19:26:07', '04');
INSERT INTO `workattendance` VALUES (48, '迟到', '022406', '迈凯伦塞纳', '2024-04-21', '09:07:15', '19:38:39', '02');
INSERT INTO `workattendance` VALUES (49, '正常', '022407', 'Intensa Emozione', '2024-04-21', '08:13:47', '18:46:30', '02');
INSERT INTO `workattendance` VALUES (50, '正常', '022408', '飞升自由', '2024-04-21', '08:14:39', '18:12:11', '02');
INSERT INTO `workattendance` VALUES (51, '正常', '012408', '穹', '2024-04-22', '08:26:37', '19:52:37', '01');
INSERT INTO `workattendance` VALUES (52, '迟到', '032305', '帕姆', '2024-04-22', '09:17:36', '19:54:27', '03');
INSERT INTO `workattendance` VALUES (53, '迟到', '012303', '卯香菱', '2024-04-22', '09:18:36', '18:09:42', '01');
INSERT INTO `workattendance` VALUES (54, '正常', '042301', '钟离', '2024-04-22', '08:05:28', '19:35:29', '04');
INSERT INTO `workattendance` VALUES (55, '迟到', '052301', '夜阑', '2024-04-22', '09:05:34', '18:06:24', '05');
INSERT INTO `workattendance` VALUES (56, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-22', '08:23:48', '19:21:12', '05');
INSERT INTO `workattendance` VALUES (57, '迟到', '052304', '久岐忍', '2024-04-22', '09:30:07', '19:54:36', '05');
INSERT INTO `workattendance` VALUES (58, '正常', '012302', '枫原万叶', '2024-04-22', '08:20:58', '18:26:38', '01');
INSERT INTO `workattendance` VALUES (59, '正常', '022301', '班尼特·卡塔库栗', '2024-04-22', '08:11:49', '18:17:39', '02');
INSERT INTO `workattendance` VALUES (60, '迟到', '022302', '胡桃', '2024-04-22', '09:16:57', '18:43:59', '02');
INSERT INTO `workattendance` VALUES (61, '正常', '032301', '行秋', '2024-04-22', '08:30:02', '18:51:19', '03');
INSERT INTO `workattendance` VALUES (62, '正常', '012404', '雷电·影', '2024-04-22', '08:22:53', '18:13:24', '01');
INSERT INTO `workattendance` VALUES (63, '迟到', '022403', '荧', '2024-04-22', '09:21:23', '18:36:35', '02');
INSERT INTO `workattendance` VALUES (64, '正常', '042404', '姬子', '2024-04-22', '08:15:32', '19:02:52', '04');
INSERT INTO `workattendance` VALUES (65, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-22', '09:08:09', '18:16:51', '02');
INSERT INTO `workattendance` VALUES (66, '正常', '022405', '星', '2024-04-22', '08:11:18', '19:48:38', '02');
INSERT INTO `workattendance` VALUES (67, '正常', '012407', '瓦尔特·杨', '2024-04-22', '08:20:42', '18:40:00', '01');
INSERT INTO `workattendance` VALUES (68, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-22', '08:04:40', '18:06:17', '03');
INSERT INTO `workattendance` VALUES (69, '迟到', '032402', '派蒙', '2024-04-22', '09:01:03', '19:35:56', '03');
INSERT INTO `workattendance` VALUES (70, '迟到', '042402', '空', '2024-04-22', '09:06:06', '19:54:56', '04');
INSERT INTO `workattendance` VALUES (71, '正常', '022406', '迈凯伦塞纳', '2024-04-22', '08:01:25', '19:42:59', '02');
INSERT INTO `workattendance` VALUES (72, '迟到', '022407', 'Intensa Emozione', '2024-04-22', '09:04:10', '19:39:08', '02');
INSERT INTO `workattendance` VALUES (73, '迟到', '022408', '飞升自由', '2024-04-22', '09:12:42', '19:38:21', '02');
INSERT INTO `workattendance` VALUES (74, '迟到', '012408', '穹', '2024-04-23', '09:10:06', '19:45:49', '01');
INSERT INTO `workattendance` VALUES (75, '正常', '032305', '帕姆', '2024-04-23', '08:21:46', '19:38:35', '03');
INSERT INTO `workattendance` VALUES (76, '正常', '012303', '卯香菱', '2024-04-23', '08:29:41', '19:44:37', '01');
INSERT INTO `workattendance` VALUES (77, '正常', '042301', '钟离', '2024-04-23', '08:02:36', '19:01:53', '04');
INSERT INTO `workattendance` VALUES (78, '正常', '052301', '夜阑', '2024-04-23', '08:07:16', '18:31:11', '05');
INSERT INTO `workattendance` VALUES (79, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-23', '08:29:14', '18:48:02', '05');
INSERT INTO `workattendance` VALUES (80, '正常', '052304', '久岐忍', '2024-04-23', '08:28:02', '18:14:56', '05');
INSERT INTO `workattendance` VALUES (81, '迟到', '012302', '枫原万叶', '2024-04-23', '09:00:39', '18:44:07', '01');
INSERT INTO `workattendance` VALUES (82, '正常', '022301', '班尼特·卡塔库栗', '2024-04-23', '08:20:21', '18:29:42', '02');
INSERT INTO `workattendance` VALUES (83, '正常', '022302', '胡桃', '2024-04-23', '08:02:56', '19:53:42', '02');
INSERT INTO `workattendance` VALUES (84, '迟到', '032301', '行秋', '2024-04-23', '09:03:14', '19:10:04', '03');
INSERT INTO `workattendance` VALUES (85, '正常', '012404', '雷电·影', '2024-04-23', '08:18:47', '18:30:22', '01');
INSERT INTO `workattendance` VALUES (86, '请假', '022403', '荧', '2024-04-23', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (87, '迟到', '042404', '姬子', '2024-04-23', '09:25:52', '19:01:01', '04');
INSERT INTO `workattendance` VALUES (88, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-23', '09:05:55', '19:48:49', '02');
INSERT INTO `workattendance` VALUES (89, '迟到', '022405', '星', '2024-04-23', '09:19:15', '19:26:31', '02');
INSERT INTO `workattendance` VALUES (90, '迟到', '012407', '瓦尔特·杨', '2024-04-23', '09:06:12', '18:47:50', '01');
INSERT INTO `workattendance` VALUES (91, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-23', '08:26:45', '19:12:32', '03');
INSERT INTO `workattendance` VALUES (92, '正常', '032402', '派蒙', '2024-04-23', '08:10:39', '18:17:09', '03');
INSERT INTO `workattendance` VALUES (93, '迟到', '042402', '空', '2024-04-23', '09:22:27', '18:19:44', '04');
INSERT INTO `workattendance` VALUES (94, '正常', '022406', '迈凯伦塞纳', '2024-04-23', '08:24:37', '18:45:42', '02');
INSERT INTO `workattendance` VALUES (95, '迟到', '022407', 'Intensa Emozione', '2024-04-23', '09:03:09', '18:45:50', '02');
INSERT INTO `workattendance` VALUES (96, '正常', '022408', '飞升自由', '2024-04-23', '08:24:45', '19:01:33', '02');
INSERT INTO `workattendance` VALUES (97, '迟到', '012408', '穹', '2024-04-24', '09:10:24', '19:59:29', '01');
INSERT INTO `workattendance` VALUES (98, '迟到', '032305', '帕姆', '2024-04-24', '09:16:25', '18:09:34', '03');
INSERT INTO `workattendance` VALUES (99, '正常', '012303', '卯香菱', '2024-04-24', '08:19:39', '18:44:51', '01');
INSERT INTO `workattendance` VALUES (100, '正常', '042301', '钟离', '2024-04-24', '08:28:23', '19:02:45', '04');
INSERT INTO `workattendance` VALUES (101, '正常', '052301', '夜阑', '2024-04-24', '08:09:49', '18:38:44', '05');
INSERT INTO `workattendance` VALUES (102, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-24', '08:24:24', '19:07:42', '05');
INSERT INTO `workattendance` VALUES (103, '正常', '052304', '久岐忍', '2024-04-24', '08:29:13', '18:49:57', '05');
INSERT INTO `workattendance` VALUES (104, '迟到', '012302', '枫原万叶', '2024-04-24', '09:19:11', '19:50:18', '01');
INSERT INTO `workattendance` VALUES (105, '正常', '022301', '班尼特·卡塔库栗', '2024-04-24', '08:02:20', '19:02:12', '02');
INSERT INTO `workattendance` VALUES (106, '请假', '022302', '胡桃', '2024-04-24', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (107, '正常', '032301', '行秋', '2024-04-24', '08:23:40', '19:49:10', '03');
INSERT INTO `workattendance` VALUES (108, '正常', '012404', '雷电·影', '2024-04-24', '08:27:29', '18:21:53', '01');
INSERT INTO `workattendance` VALUES (109, '请假', '022403', '荧', '2024-04-24', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (110, '正常', '042404', '姬子', '2024-04-24', '08:12:08', '18:33:01', '04');
INSERT INTO `workattendance` VALUES (111, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-24', '08:09:52', '18:28:25', '02');
INSERT INTO `workattendance` VALUES (112, '迟到', '022405', '星', '2024-04-24', '09:26:30', '19:56:22', '02');
INSERT INTO `workattendance` VALUES (113, '正常', '012407', '瓦尔特·杨', '2024-04-24', '08:30:17', '18:38:34', '01');
INSERT INTO `workattendance` VALUES (114, '迟到', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-24', '09:21:52', '19:25:05', '03');
INSERT INTO `workattendance` VALUES (115, '迟到', '032402', '派蒙', '2024-04-24', '09:18:44', '19:01:57', '03');
INSERT INTO `workattendance` VALUES (116, '迟到', '042402', '空', '2024-04-24', '09:05:57', '18:40:19', '04');
INSERT INTO `workattendance` VALUES (117, '迟到', '022406', '迈凯伦塞纳', '2024-04-24', '09:20:17', '19:17:22', '02');
INSERT INTO `workattendance` VALUES (118, '迟到', '022407', 'Intensa Emozione', '2024-04-24', '09:19:20', '18:30:35', '02');
INSERT INTO `workattendance` VALUES (119, '迟到', '022408', '飞升自由', '2024-04-24', '09:26:09', '19:26:34', '02');
INSERT INTO `workattendance` VALUES (123, '请假', '022403', '荧', '2024-04-26', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (122, '请假', '022403', '荧', '2024-04-25', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (135, '请假', '022302', '胡桃', '2024-04-30', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (134, '请假', '022302', '胡桃', '2024-04-29', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (133, '请假', '022302', '胡桃', '2024-04-28', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (132, '请假', '022302', '胡桃', '2024-04-27', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (131, '请假', '022302', '胡桃', '2024-04-26', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (130, '请假', '022302', '胡桃', '2024-04-25', '00:00:00', '00:00:00', '02');
INSERT INTO `workattendance` VALUES (246, '迟到', '052301', '夜阑', '2024-04-27', '09:24:02', '18:01:48', '05');
INSERT INTO `workattendance` VALUES (245, '正常', '042301', '钟离', '2024-04-27', '08:23:01', '18:04:00', '04');
INSERT INTO `workattendance` VALUES (244, '正常', '012303', '卯香菱', '2024-04-27', '08:13:14', '18:05:44', '01');
INSERT INTO `workattendance` VALUES (243, '正常', '032305', '帕姆', '2024-04-27', '08:25:46', '18:02:15', '03');
INSERT INTO `workattendance` VALUES (242, '正常', '012408', '穹', '2024-04-27', '08:18:19', '18:05:40', '01');
INSERT INTO `workattendance` VALUES (241, '正常', '022408', '飞升自由', '2024-04-26', '08:30:31', '18:10:07', '02');
INSERT INTO `workattendance` VALUES (240, '正常', '022407', 'Intensa Emozione', '2024-04-26', '08:25:39', '18:03:51', '02');
INSERT INTO `workattendance` VALUES (239, '正常', '022406', '迈凯伦塞纳', '2024-04-26', '08:30:56', '18:09:30', '02');
INSERT INTO `workattendance` VALUES (238, '迟到', '042402', '空', '2024-04-26', '09:05:37', '18:04:10', '04');
INSERT INTO `workattendance` VALUES (237, '迟到', '032402', '派蒙', '2024-04-26', '09:15:25', '18:03:46', '03');
INSERT INTO `workattendance` VALUES (236, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-26', '08:11:11', '18:07:23', '03');
INSERT INTO `workattendance` VALUES (235, '迟到', '012407', '瓦尔特·杨', '2024-04-26', '09:11:08', '18:05:04', '01');
INSERT INTO `workattendance` VALUES (234, '正常', '022405', '星', '2024-04-26', '08:10:17', '18:03:33', '02');
INSERT INTO `workattendance` VALUES (233, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-26', '09:08:18', '18:01:00', '02');
INSERT INTO `workattendance` VALUES (232, '正常', '042404', '姬子', '2024-04-26', '08:30:51', '18:09:49', '04');
INSERT INTO `workattendance` VALUES (231, '迟到', '012404', '雷电·影', '2024-04-26', '09:19:35', '18:04:54', '01');
INSERT INTO `workattendance` VALUES (230, '迟到', '032301', '行秋', '2024-04-26', '09:10:59', '18:02:34', '03');
INSERT INTO `workattendance` VALUES (229, '正常', '022301', '班尼特·卡塔库栗', '2024-04-26', '08:14:13', '18:06:22', '02');
INSERT INTO `workattendance` VALUES (228, '迟到', '012302', '枫原万叶', '2024-04-26', '09:09:29', '18:04:47', '01');
INSERT INTO `workattendance` VALUES (227, '正常', '052304', '久岐忍', '2024-04-26', '08:11:01', '18:02:54', '05');
INSERT INTO `workattendance` VALUES (226, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-26', '09:29:18', '18:01:12', '05');
INSERT INTO `workattendance` VALUES (225, '迟到', '052301', '夜阑', '2024-04-26', '09:02:28', '18:08:00', '05');
INSERT INTO `workattendance` VALUES (224, '正常', '042301', '钟离', '2024-04-26', '08:06:57', '18:07:30', '04');
INSERT INTO `workattendance` VALUES (223, '迟到', '012303', '卯香菱', '2024-04-26', '09:27:06', '18:09:57', '01');
INSERT INTO `workattendance` VALUES (222, '迟到', '032305', '帕姆', '2024-04-26', '09:17:24', '18:08:38', '03');
INSERT INTO `workattendance` VALUES (221, '正常', '012408', '穹', '2024-04-26', '08:17:18', '18:10:25', '01');
INSERT INTO `workattendance` VALUES (220, '正常', '022408', '飞升自由', '2024-04-25', '08:50:49', '18:08:12', '02');
INSERT INTO `workattendance` VALUES (219, '正常', '022407', 'Intensa Emozione', '2024-04-25', '08:50:11', '18:03:57', '02');
INSERT INTO `workattendance` VALUES (218, '正常', '022406', '迈凯伦塞纳', '2024-04-25', '08:50:33', '18:03:51', '02');
INSERT INTO `workattendance` VALUES (217, '正常', '042402', '空', '2024-04-25', '08:49:39', '18:10:10', '04');
INSERT INTO `workattendance` VALUES (216, '正常', '032402', '派蒙', '2024-04-25', '08:48:22', '18:09:24', '03');
INSERT INTO `workattendance` VALUES (215, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-25', '08:47:59', '18:06:46', '03');
INSERT INTO `workattendance` VALUES (214, '正常', '012407', '瓦尔特·杨', '2024-04-25', '08:45:22', '18:00:54', '01');
INSERT INTO `workattendance` VALUES (213, '正常', '022405', '星', '2024-04-25', '08:47:40', '18:02:36', '02');
INSERT INTO `workattendance` VALUES (212, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-25', '08:48:40', '18:01:57', '02');
INSERT INTO `workattendance` VALUES (211, '正常', '042404', '姬子', '2024-04-25', '08:47:07', '18:09:29', '04');
INSERT INTO `workattendance` VALUES (210, '正常', '012404', '雷电·影', '2024-04-25', '08:46:10', '18:00:31', '01');
INSERT INTO `workattendance` VALUES (209, '正常', '032301', '行秋', '2024-04-25', '08:45:29', '18:02:45', '03');
INSERT INTO `workattendance` VALUES (208, '正常', '022301', '班尼特·卡塔库栗', '2024-04-25', '08:46:29', '18:07:30', '02');
INSERT INTO `workattendance` VALUES (207, '正常', '012302', '枫原万叶', '2024-04-25', '08:48:39', '18:04:55', '01');
INSERT INTO `workattendance` VALUES (206, '正常', '052304', '久岐忍', '2024-04-25', '08:47:23', '18:07:46', '05');
INSERT INTO `workattendance` VALUES (205, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-25', '08:50:58', '18:03:32', '05');
INSERT INTO `workattendance` VALUES (204, '正常', '052301', '夜阑', '2024-04-25', '08:46:38', '18:00:27', '05');
INSERT INTO `workattendance` VALUES (203, '正常', '042301', '钟离', '2024-04-25', '08:50:12', '18:01:50', '04');
INSERT INTO `workattendance` VALUES (202, '正常', '012303', '卯香菱', '2024-04-25', '08:50:44', '18:00:15', '01');
INSERT INTO `workattendance` VALUES (201, '正常', '032305', '帕姆', '2024-04-25', '08:49:36', '18:07:06', '03');
INSERT INTO `workattendance` VALUES (200, '正常', '012408', '穹', '2024-04-25', '08:46:59', '18:03:47', '01');
INSERT INTO `workattendance` VALUES (247, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-27', '08:01:32', '18:04:04', '05');
INSERT INTO `workattendance` VALUES (248, '迟到', '052304', '久岐忍', '2024-04-27', '09:01:59', '18:05:10', '05');
INSERT INTO `workattendance` VALUES (249, '正常', '012302', '枫原万叶', '2024-04-27', '08:02:36', '18:08:25', '01');
INSERT INTO `workattendance` VALUES (250, '迟到', '022301', '班尼特·卡塔库栗', '2024-04-27', '09:23:18', '18:05:17', '02');
INSERT INTO `workattendance` VALUES (251, '正常', '032301', '行秋', '2024-04-27', '08:16:50', '18:10:23', '03');
INSERT INTO `workattendance` VALUES (252, '正常', '012404', '雷电·影', '2024-04-27', '08:07:44', '18:06:20', '01');
INSERT INTO `workattendance` VALUES (253, '正常', '022403', '荧', '2024-04-27', '08:08:11', '18:09:51', '02');
INSERT INTO `workattendance` VALUES (254, '迟到', '042404', '姬子', '2024-04-27', '09:28:59', '18:07:10', '04');
INSERT INTO `workattendance` VALUES (255, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-27', '09:27:42', '18:04:47', '02');
INSERT INTO `workattendance` VALUES (256, '正常', '022405', '星', '2024-04-27', '08:02:44', '18:08:21', '02');
INSERT INTO `workattendance` VALUES (257, '正常', '012407', '瓦尔特·杨', '2024-04-27', '08:22:46', '18:03:22', '01');
INSERT INTO `workattendance` VALUES (258, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-27', '09:07:37', '18:07:05', '03');
INSERT INTO `workattendance` VALUES (259, '正常', '032402', '派蒙', '2024-04-27', '08:29:10', '18:06:16', '03');
INSERT INTO `workattendance` VALUES (260, '迟到', '042402', '空', '2024-04-27', '09:02:48', '18:00:16', '04');
INSERT INTO `workattendance` VALUES (261, '迟到', '022406', '迈凯伦塞纳', '2024-04-27', '09:11:38', '18:04:36', '02');
INSERT INTO `workattendance` VALUES (262, '迟到', '022407', 'Intensa Emozione', '2024-04-27', '09:29:41', '18:05:15', '02');
INSERT INTO `workattendance` VALUES (263, '迟到', '022408', '飞升自由', '2024-04-27', '09:02:48', '18:08:07', '02');
INSERT INTO `workattendance` VALUES (264, '正常', '012408', '穹', '2024-04-28', '08:14:19', '18:09:04', '01');
INSERT INTO `workattendance` VALUES (265, '正常', '032305', '帕姆', '2024-04-28', '09:13:49', '18:08:52', '03');
INSERT INTO `workattendance` VALUES (266, '迟到', '012303', '卯香菱', '2024-04-28', '09:18:39', '18:03:51', '01');
INSERT INTO `workattendance` VALUES (267, '迟到', '042301', '钟离', '2024-04-28', '09:07:41', '18:03:12', '04');
INSERT INTO `workattendance` VALUES (268, '迟到', '052301', '夜阑', '2024-04-28', '09:06:11', '18:04:44', '05');
INSERT INTO `workattendance` VALUES (269, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-28', '08:30:53', '18:04:11', '05');
INSERT INTO `workattendance` VALUES (270, '迟到', '052304', '久岐忍', '2024-04-28', '09:28:19', '18:09:15', '05');
INSERT INTO `workattendance` VALUES (271, '迟到', '012302', '枫原万叶', '2024-04-28', '09:13:55', '18:06:23', '01');
INSERT INTO `workattendance` VALUES (272, '迟到', '022301', '班尼特·卡塔库栗', '2024-04-28', '09:03:15', '18:02:30', '02');
INSERT INTO `workattendance` VALUES (273, '正常', '032301', '行秋', '2024-04-28', '08:03:58', '18:06:37', '03');
INSERT INTO `workattendance` VALUES (274, '正常', '012404', '雷电·影', '2024-04-28', '08:24:08', '18:07:10', '01');
INSERT INTO `workattendance` VALUES (275, '正常', '022403', '荧', '2024-04-28', '08:19:29', '18:10:23', '02');
INSERT INTO `workattendance` VALUES (276, '正常', '042404', '姬子', '2024-04-28', '08:21:50', '18:09:40', '04');
INSERT INTO `workattendance` VALUES (277, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-28', '09:29:47', '18:02:36', '02');
INSERT INTO `workattendance` VALUES (278, '迟到', '022405', '星', '2024-04-28', '09:20:33', '18:06:46', '02');
INSERT INTO `workattendance` VALUES (279, '迟到', '012407', '瓦尔特·杨', '2024-04-28', '09:19:14', '18:08:43', '01');
INSERT INTO `workattendance` VALUES (280, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-28', '08:10:24', '18:03:48', '03');
INSERT INTO `workattendance` VALUES (281, '正常', '032402', '派蒙', '2024-04-28', '08:21:52', '18:07:39', '03');
INSERT INTO `workattendance` VALUES (282, '正常', '042402', '空', '2024-04-28', '08:21:37', '18:02:42', '04');
INSERT INTO `workattendance` VALUES (283, '迟到', '022406', '迈凯伦塞纳', '2024-04-28', '09:09:36', '18:03:19', '02');
INSERT INTO `workattendance` VALUES (284, '正常', '022407', '阿波罗IE', '2024-04-28', '08:19:29', '18:10:22', '02');
INSERT INTO `workattendance` VALUES (285, '迟到', '022408', '飞升自由', '2024-04-28', '09:15:31', '18:01:54', '02');
INSERT INTO `workattendance` VALUES (286, '正常', '012408', '穹', '2024-04-29', '08:12:58', '18:10:48', '01');
INSERT INTO `workattendance` VALUES (287, '正常', '032305', '帕姆', '2024-04-29', '08:27:54', '18:09:48', '03');
INSERT INTO `workattendance` VALUES (288, '迟到', '012303', '卯香菱', '2024-04-29', '09:04:48', '18:00:26', '01');
INSERT INTO `workattendance` VALUES (289, '迟到', '042301', '钟离', '2024-04-29', '09:08:28', '18:06:30', '04');
INSERT INTO `workattendance` VALUES (290, '正常', '052301', '夜阑', '2024-04-29', '08:23:14', '18:09:33', '05');
INSERT INTO `workattendance` VALUES (291, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-29', '08:08:07', '18:07:28', '05');
INSERT INTO `workattendance` VALUES (292, '正常', '052304', '久岐忍', '2024-04-29', '08:26:35', '18:06:55', '05');
INSERT INTO `workattendance` VALUES (293, '正常', '012302', '枫原万叶', '2024-04-29', '08:12:07', '18:03:03', '01');
INSERT INTO `workattendance` VALUES (294, '正常', '022301', '班尼特·卡塔库栗', '2024-04-29', '09:00:00', '18:08:20', '02');
INSERT INTO `workattendance` VALUES (295, '正常', '032301', '行秋', '2024-04-29', '08:30:08', '18:00:19', '03');
INSERT INTO `workattendance` VALUES (296, '正常', '012404', '雷电·影', '2024-04-29', '08:05:39', '18:02:25', '01');
INSERT INTO `workattendance` VALUES (297, '迟到', '022403', '荧', '2024-04-29', '09:20:41', '18:04:12', '02');
INSERT INTO `workattendance` VALUES (298, '正常', '042404', '姬子', '2024-04-29', '08:28:17', '18:00:20', '04');
INSERT INTO `workattendance` VALUES (299, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-29', '09:21:01', '18:05:23', '02');
INSERT INTO `workattendance` VALUES (300, '正常', '022405', '星', '2024-04-29', '08:11:35', '18:09:29', '02');
INSERT INTO `workattendance` VALUES (301, '正常', '012407', '瓦尔特·杨', '2024-04-29', '08:29:58', '18:07:11', '01');
INSERT INTO `workattendance` VALUES (302, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-29', '08:07:01', '18:04:52', '03');
INSERT INTO `workattendance` VALUES (303, '迟到', '032402', '派蒙', '2024-04-29', '09:20:25', '18:10:04', '03');
INSERT INTO `workattendance` VALUES (304, '正常', '042402', '空', '2024-04-29', '08:10:02', '18:07:19', '04');
INSERT INTO `workattendance` VALUES (305, '迟到', '022406', '迈凯伦塞纳', '2024-04-29', '09:15:58', '18:06:29', '02');
INSERT INTO `workattendance` VALUES (306, '迟到', '022407', '阿波罗IE', '2024-04-29', '09:24:37', '18:09:08', '02');
INSERT INTO `workattendance` VALUES (307, '迟到', '022408', '飞升自由', '2024-04-29', '09:26:58', '18:01:20', '02');
INSERT INTO `workattendance` VALUES (308, '迟到', '012408', '穹', '2024-04-30', '09:27:11', '18:05:40', '01');
INSERT INTO `workattendance` VALUES (309, '正常', '032305', '帕姆', '2024-04-30', '08:06:24', '18:07:09', '03');
INSERT INTO `workattendance` VALUES (310, '正常', '012303', '卯香菱', '2024-04-30', '08:28:03', '18:02:50', '01');
INSERT INTO `workattendance` VALUES (311, '迟到', '042301', '钟离', '2024-04-30', '09:04:08', '18:03:02', '04');
INSERT INTO `workattendance` VALUES (312, '正常', '052301', '夜阑', '2024-04-30', '08:22:31', '18:02:31', '05');
INSERT INTO `workattendance` VALUES (313, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-04-30', '09:10:00', '18:06:45', '05');
INSERT INTO `workattendance` VALUES (314, '迟到', '052304', '久岐忍', '2024-04-30', '09:27:46', '18:07:03', '05');
INSERT INTO `workattendance` VALUES (315, '迟到', '012302', '枫原万叶', '2024-04-30', '09:29:13', '18:00:25', '01');
INSERT INTO `workattendance` VALUES (316, '迟到', '022301', '班尼特·卡塔库栗', '2024-04-30', '09:24:59', '18:07:37', '02');
INSERT INTO `workattendance` VALUES (317, '正常', '012404', '雷电·影', '2024-04-30', '08:13:24', '18:06:59', '01');
INSERT INTO `workattendance` VALUES (318, '正常', '012405', '零式飞翼', '2024-04-30', '08:06:14', '18:04:28', '01');
INSERT INTO `workattendance` VALUES (319, '正常', '012406', '地狱死神', '2024-04-30', '08:28:50', '18:03:50', '01');
INSERT INTO `workattendance` VALUES (320, '迟到', '022403', '荧', '2024-04-30', '09:08:09', '18:09:23', '02');
INSERT INTO `workattendance` VALUES (321, '正常', '042404', '姬子', '2024-04-30', '08:12:06', '18:01:12', '04');
INSERT INTO `workattendance` VALUES (322, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-30', '09:24:02', '18:09:29', '02');
INSERT INTO `workattendance` VALUES (323, '正常', '022405', '星', '2024-04-30', '08:05:18', '18:05:06', '02');
INSERT INTO `workattendance` VALUES (324, '迟到', '012407', '瓦尔特·杨', '2024-04-30', '09:18:47', '18:00:35', '01');
INSERT INTO `workattendance` VALUES (325, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-04-30', '08:09:23', '18:00:01', '03');
INSERT INTO `workattendance` VALUES (326, '正常', '032402', '派蒙', '2024-04-30', '08:01:59', '18:00:05', '03');
INSERT INTO `workattendance` VALUES (327, '迟到', '042402', '空', '2024-04-30', '09:00:11', '18:09:29', '04');
INSERT INTO `workattendance` VALUES (328, '正常', '022406', '迈凯伦塞纳', '2024-04-30', '08:09:16', '18:10:34', '02');
INSERT INTO `workattendance` VALUES (329, '正常', '022407', '阿波罗IE', '2024-04-30', '08:05:49', '18:10:19', '02');
INSERT INTO `workattendance` VALUES (330, '正常', '012301', '达达利亚', '2024-04-30', '08:22:11', '18:06:52', '01');
INSERT INTO `workattendance` VALUES (331, '迟到', '022408', '飞升自由', '2024-04-30', '09:02:58', '18:06:46', '02');
INSERT INTO `workattendance` VALUES (332, '迟到', '022409', '梁庚大', '2024-04-30', '09:02:13', '18:03:53', '02');
INSERT INTO `workattendance` VALUES (333, '迟到', '012409', '宫龙寻', '2024-04-30', '09:00:34', '18:10:19', '01');
INSERT INTO `workattendance` VALUES (334, '迟到', '032406', 'test', '2024-04-30', '09:24:47', '18:03:02', '03');
INSERT INTO `workattendance` VALUES (335, '正常', '012408', '穹', '2024-05-06', '08:01:19', '18:09:53', '01');
INSERT INTO `workattendance` VALUES (336, '迟到', '032305', '帕姆', '2024-05-06', '09:25:00', '18:04:18', '03');
INSERT INTO `workattendance` VALUES (337, '迟到', '012303', '卯香菱', '2024-05-06', '09:02:55', '18:06:54', '01');
INSERT INTO `workattendance` VALUES (338, '正常', '042301', '钟离', '2024-05-06', '08:22:36', '18:07:42', '04');
INSERT INTO `workattendance` VALUES (339, '正常', '052301', '夜阑', '2024-05-06', '08:01:57', '18:09:48', '05');
INSERT INTO `workattendance` VALUES (340, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-06', '08:16:27', '18:01:16', '05');
INSERT INTO `workattendance` VALUES (341, '正常', '052304', '久岐忍', '2024-05-06', '08:18:02', '18:08:51', '05');
INSERT INTO `workattendance` VALUES (342, '正常', '012302', '枫原万叶', '2024-05-06', '08:15:09', '18:03:52', '01');
INSERT INTO `workattendance` VALUES (343, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-06', '09:04:29', '18:10:07', '02');
INSERT INTO `workattendance` VALUES (344, '正常', '022302', '胡桃', '2024-05-06', '08:27:47', '18:00:46', '02');
INSERT INTO `workattendance` VALUES (345, '迟到', '032301', '行秋', '2024-05-06', '09:23:20', '18:06:21', '03');
INSERT INTO `workattendance` VALUES (346, '迟到', '012404', '雷电·影', '2024-05-06', '09:02:03', '18:06:21', '01');
INSERT INTO `workattendance` VALUES (347, '正常', '012405', '零式飞翼', '2024-05-06', '08:13:22', '18:00:45', '01');
INSERT INTO `workattendance` VALUES (348, '正常', '012406', '地狱死神', '2024-05-06', '08:27:06', '18:06:35', '01');
INSERT INTO `workattendance` VALUES (349, '正常', '022403', '荧', '2024-05-06', '08:30:59', '18:09:05', '02');
INSERT INTO `workattendance` VALUES (350, '迟到', '042404', '姬子', '2024-05-06', '09:30:52', '18:03:22', '04');
INSERT INTO `workattendance` VALUES (351, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-06', '08:26:45', '18:02:00', '02');
INSERT INTO `workattendance` VALUES (352, '迟到', '022405', '星', '2024-05-06', '09:18:23', '18:03:44', '02');
INSERT INTO `workattendance` VALUES (353, '正常', '012407', '瓦尔特·杨', '2024-05-06', '08:12:00', '18:06:07', '01');
INSERT INTO `workattendance` VALUES (354, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-06', '08:25:38', '18:08:05', '03');
INSERT INTO `workattendance` VALUES (355, '正常', '032402', '派蒙', '2024-05-06', '08:07:42', '18:08:12', '03');
INSERT INTO `workattendance` VALUES (356, '迟到', '042402', '空', '2024-05-06', '09:04:28', '18:02:57', '04');
INSERT INTO `workattendance` VALUES (357, '正常', '022406', '迈凯伦塞纳', '2024-05-06', '08:26:58', '18:05:19', '02');
INSERT INTO `workattendance` VALUES (358, '正常', '022407', '阿波罗IE', '2024-05-06', '08:13:11', '18:07:40', '02');
INSERT INTO `workattendance` VALUES (359, '正常', '012301', '达达利亚', '2024-05-06', '08:04:37', '18:02:07', '01');
INSERT INTO `workattendance` VALUES (360, '正常', '022408', '飞升自由', '2024-05-06', '08:03:02', '18:04:34', '02');
INSERT INTO `workattendance` VALUES (361, '正常', '022409', '梁庚大', '2024-05-06', '08:15:04', '18:09:12', '02');
INSERT INTO `workattendance` VALUES (362, '迟到', '012409', '宫龙寻', '2024-05-06', '09:30:04', '18:04:51', '01');
INSERT INTO `workattendance` VALUES (363, '正常', '032406', 'test', '2024-05-06', '08:10:23', '18:03:16', '03');
INSERT INTO `workattendance` VALUES (364, '迟到', '012408', '穹', '2024-05-07', '09:20:09', '18:08:08', '01');
INSERT INTO `workattendance` VALUES (365, '迟到', '032305', '帕姆', '2024-05-07', '09:10:54', '18:10:30', '03');
INSERT INTO `workattendance` VALUES (366, '迟到', '012303', '卯香菱', '2024-05-07', '09:16:46', '18:09:32', '01');
INSERT INTO `workattendance` VALUES (367, '正常', '042301', '钟离', '2024-05-07', '08:15:34', '18:08:41', '04');
INSERT INTO `workattendance` VALUES (368, '迟到', '052301', '夜阑', '2024-05-07', '09:07:23', '18:00:14', '05');
INSERT INTO `workattendance` VALUES (369, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-07', '09:20:08', '18:04:34', '05');
INSERT INTO `workattendance` VALUES (370, '迟到', '052304', '久岐忍', '2024-05-07', '09:20:15', '18:10:41', '05');
INSERT INTO `workattendance` VALUES (371, '迟到', '012302', '枫原万叶', '2024-05-07', '09:01:13', '18:10:25', '01');
INSERT INTO `workattendance` VALUES (372, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-07', '09:24:08', '18:05:47', '02');
INSERT INTO `workattendance` VALUES (373, '正常', '022302', '胡桃', '2024-05-07', '08:06:46', '18:05:25', '02');
INSERT INTO `workattendance` VALUES (374, '迟到', '032301', '行秋', '2024-05-07', '09:24:20', '18:10:24', '03');
INSERT INTO `workattendance` VALUES (375, '正常', '012404', '雷电·影', '2024-05-07', '08:02:06', '18:07:42', '01');
INSERT INTO `workattendance` VALUES (376, '迟到', '012405', '零式飞翼', '2024-05-07', '09:01:05', '18:07:15', '01');
INSERT INTO `workattendance` VALUES (377, '正常', '012406', '地狱死神', '2024-05-07', '08:19:48', '18:00:00', '01');
INSERT INTO `workattendance` VALUES (378, '正常', '022403', '荧', '2024-05-07', '08:18:54', '18:04:17', '02');
INSERT INTO `workattendance` VALUES (379, '迟到', '042404', '姬子', '2024-05-07', '09:28:40', '18:06:22', '04');
INSERT INTO `workattendance` VALUES (380, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-07', '09:17:18', '18:06:03', '02');
INSERT INTO `workattendance` VALUES (381, '正常', '022405', '星', '2024-05-07', '08:05:04', '18:01:54', '02');
INSERT INTO `workattendance` VALUES (382, '迟到', '012407', '瓦尔特·杨', '2024-05-07', '09:04:48', '18:03:55', '01');
INSERT INTO `workattendance` VALUES (383, '正常', '032402', '派蒙', '2024-05-07', '08:25:39', '18:09:48', '03');
INSERT INTO `workattendance` VALUES (384, '正常', '042402', '空', '2024-05-07', '08:06:21', '18:09:38', '04');
INSERT INTO `workattendance` VALUES (385, '正常', '022406', '迈凯伦塞纳', '2024-05-07', '08:07:36', '18:03:26', '02');
INSERT INTO `workattendance` VALUES (386, '正常', '022407', '阿波罗IE', '2024-05-07', '08:20:37', '18:02:37', '02');
INSERT INTO `workattendance` VALUES (387, '迟到', '012301', '达达利亚', '2024-05-07', '09:30:40', '18:02:44', '01');
INSERT INTO `workattendance` VALUES (388, '迟到', '022408', '飞升自由', '2024-05-07', '09:14:45', '18:03:16', '02');
INSERT INTO `workattendance` VALUES (389, '迟到', '022409', '梁庚大', '2024-05-07', '09:26:14', '18:06:47', '02');
INSERT INTO `workattendance` VALUES (390, '正常', '012409', '宫龙寻', '2024-05-07', '08:29:14', '18:03:00', '01');
INSERT INTO `workattendance` VALUES (391, '正常', '032406', 'test', '2024-05-07', '08:11:54', '18:07:00', '03');
INSERT INTO `workattendance` VALUES (392, '正常', '012408', '穹', '2024-05-08', '08:11:02', '18:06:29', '01');
INSERT INTO `workattendance` VALUES (393, '迟到', '032305', '帕姆', '2024-05-08', '09:30:35', '18:08:53', '03');
INSERT INTO `workattendance` VALUES (394, '迟到', '012303', '卯香菱', '2024-05-08', '09:00:28', '18:00:29', '01');
INSERT INTO `workattendance` VALUES (395, '正常', '042301', '钟离', '2024-05-08', '08:11:14', '18:07:35', '04');
INSERT INTO `workattendance` VALUES (396, '迟到', '052301', '夜阑', '2024-05-08', '09:07:10', '18:07:52', '05');
INSERT INTO `workattendance` VALUES (397, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-08', '09:09:59', '18:09:52', '05');
INSERT INTO `workattendance` VALUES (398, '正常', '052304', '久岐忍', '2024-05-08', '08:13:36', '18:08:06', '05');
INSERT INTO `workattendance` VALUES (399, '迟到', '012302', '枫原万叶', '2024-05-08', '09:11:23', '18:02:34', '01');
INSERT INTO `workattendance` VALUES (400, '正常', '022301', '班尼特·卡塔库栗', '2024-05-08', '08:03:35', '18:02:28', '02');
INSERT INTO `workattendance` VALUES (401, '迟到', '022302', '胡桃', '2024-05-08', '09:04:24', '18:06:58', '02');
INSERT INTO `workattendance` VALUES (402, '迟到', '032301', '行秋', '2024-05-08', '09:02:15', '18:04:51', '03');
INSERT INTO `workattendance` VALUES (403, '迟到', '012404', '雷电·影', '2024-05-08', '09:29:55', '18:00:13', '01');
INSERT INTO `workattendance` VALUES (404, '迟到', '012405', '零式飞翼', '2024-05-08', '09:30:25', '18:01:59', '01');
INSERT INTO `workattendance` VALUES (405, '正常', '012406', '地狱死神', '2024-05-08', '08:19:02', '18:01:08', '01');
INSERT INTO `workattendance` VALUES (406, '正常', '022403', '荧', '2024-05-08', '08:16:51', '18:05:51', '02');
INSERT INTO `workattendance` VALUES (407, '迟到', '042404', '姬子', '2024-05-08', '09:08:47', '18:04:07', '04');
INSERT INTO `workattendance` VALUES (408, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-08', '08:08:33', '18:08:59', '02');
INSERT INTO `workattendance` VALUES (409, '迟到', '022405', '星', '2024-05-08', '09:25:47', '18:08:10', '02');
INSERT INTO `workattendance` VALUES (410, '迟到', '012407', '瓦尔特·杨', '2024-05-08', '09:27:17', '18:00:11', '01');
INSERT INTO `workattendance` VALUES (411, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-08', '08:10:31', '18:08:03', '03');
INSERT INTO `workattendance` VALUES (412, '迟到', '032402', '派蒙', '2024-05-08', '09:05:18', '18:04:33', '03');
INSERT INTO `workattendance` VALUES (413, '迟到', '042402', '空', '2024-05-08', '09:14:42', '18:04:00', '04');
INSERT INTO `workattendance` VALUES (414, '正常', '022406', '迈凯伦塞纳', '2024-05-08', '08:08:23', '18:09:58', '02');
INSERT INTO `workattendance` VALUES (415, '迟到', '022407', '阿波罗IE', '2024-05-08', '09:04:11', '18:03:08', '02');
INSERT INTO `workattendance` VALUES (416, '正常', '012301', '达达利亚', '2024-05-08', '08:08:21', '18:02:39', '01');
INSERT INTO `workattendance` VALUES (417, '正常', '022408', '飞升自由', '2024-05-08', '08:07:56', '18:05:25', '02');
INSERT INTO `workattendance` VALUES (418, '正常', '022409', '梁庚大', '2024-05-08', '08:26:30', '18:02:15', '02');
INSERT INTO `workattendance` VALUES (419, '正常', '012409', '宫龙寻', '2024-05-08', '08:21:31', '18:05:35', '01');
INSERT INTO `workattendance` VALUES (420, '迟到', '032406', 'test', '2024-05-08', '09:28:37', '18:00:07', '03');
INSERT INTO `workattendance` VALUES (421, '迟到', '012408', '穹', '2024-05-09', '09:05:47', '18:09:04', '01');
INSERT INTO `workattendance` VALUES (422, '迟到', '032305', '帕姆', '2024-05-09', '09:22:45', '18:05:32', '03');
INSERT INTO `workattendance` VALUES (423, '正常', '012303', '卯香菱', '2024-05-09', '08:22:36', '18:10:18', '01');
INSERT INTO `workattendance` VALUES (424, '迟到', '042301', '钟离', '2024-05-09', '09:24:12', '18:09:49', '04');
INSERT INTO `workattendance` VALUES (425, '迟到', '052301', '夜阑', '2024-05-09', '09:06:09', '18:01:02', '05');
INSERT INTO `workattendance` VALUES (426, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-09', '09:10:11', '18:06:51', '05');
INSERT INTO `workattendance` VALUES (427, '正常', '052304', '久岐忍', '2024-05-09', '08:23:18', '18:01:07', '05');
INSERT INTO `workattendance` VALUES (428, '正常', '012302', '枫原万叶', '2024-05-09', '08:01:21', '18:00:41', '01');
INSERT INTO `workattendance` VALUES (429, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-09', '09:17:08', '18:07:24', '02');
INSERT INTO `workattendance` VALUES (430, '正常', '022302', '胡桃', '2024-05-09', '08:02:15', '18:00:48', '02');
INSERT INTO `workattendance` VALUES (431, '正常', '032301', '行秋', '2024-05-09', '08:17:21', '18:02:59', '03');
INSERT INTO `workattendance` VALUES (432, '正常', '012404', '雷电·影', '2024-05-09', '08:04:02', '18:02:21', '01');
INSERT INTO `workattendance` VALUES (433, '正常', '012405', '零式飞翼', '2024-05-09', '08:15:23', '18:00:55', '01');
INSERT INTO `workattendance` VALUES (434, '迟到', '012406', '地狱死神', '2024-05-09', '09:12:05', '18:03:49', '01');
INSERT INTO `workattendance` VALUES (435, '迟到', '022403', '荧', '2024-05-09', '09:29:51', '18:02:01', '02');
INSERT INTO `workattendance` VALUES (436, '迟到', '042404', '姬子', '2024-05-09', '09:08:11', '18:04:17', '04');
INSERT INTO `workattendance` VALUES (437, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-09', '08:19:01', '18:05:15', '02');
INSERT INTO `workattendance` VALUES (438, '迟到', '022405', '星', '2024-05-09', '09:08:28', '18:05:53', '02');
INSERT INTO `workattendance` VALUES (439, '正常', '012407', '瓦尔特·杨', '2024-05-09', '08:05:28', '18:03:00', '01');
INSERT INTO `workattendance` VALUES (440, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-09', '08:20:56', '18:03:44', '03');
INSERT INTO `workattendance` VALUES (441, '迟到', '032402', '派蒙', '2024-05-09', '09:05:40', '18:07:31', '03');
INSERT INTO `workattendance` VALUES (442, '迟到', '042402', '空', '2024-05-09', '09:19:04', '18:09:20', '04');
INSERT INTO `workattendance` VALUES (443, '正常', '022406', '迈凯伦塞纳', '2024-05-09', '08:06:46', '18:01:16', '02');
INSERT INTO `workattendance` VALUES (444, '正常', '022407', '阿波罗IE', '2024-05-09', '08:04:16', '18:10:47', '02');
INSERT INTO `workattendance` VALUES (445, '迟到', '012301', '达达利亚', '2024-05-09', '09:21:25', '18:00:02', '01');
INSERT INTO `workattendance` VALUES (446, '正常', '022408', '飞升自由', '2024-05-09', '08:24:39', '18:03:30', '02');
INSERT INTO `workattendance` VALUES (447, '迟到', '022409', '梁庚大', '2024-05-09', '09:19:34', '18:01:58', '02');
INSERT INTO `workattendance` VALUES (448, '正常', '012409', '宫龙寻', '2024-05-09', '08:24:00', '18:07:36', '01');
INSERT INTO `workattendance` VALUES (449, '正常', '032406', 'test', '2024-05-09', '08:04:10', '18:03:34', '03');
INSERT INTO `workattendance` VALUES (450, '迟到', '012408', '穹', '2024-05-10', '09:15:47', '18:07:40', '01');
INSERT INTO `workattendance` VALUES (451, '迟到', '032305', '帕姆', '2024-05-10', '09:19:37', '18:03:45', '03');
INSERT INTO `workattendance` VALUES (452, '迟到', '012303', '卯香菱', '2024-05-10', '09:15:21', '18:06:03', '01');
INSERT INTO `workattendance` VALUES (453, '正常', '042301', '钟离', '2024-05-10', '08:06:45', '18:07:36', '04');
INSERT INTO `workattendance` VALUES (454, '正常', '052301', '夜阑', '2024-05-10', '08:01:26', '18:09:49', '05');
INSERT INTO `workattendance` VALUES (455, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-10', '08:07:28', '18:08:51', '05');
INSERT INTO `workattendance` VALUES (456, '迟到', '052304', '久岐忍', '2024-05-10', '09:29:39', '18:09:49', '05');
INSERT INTO `workattendance` VALUES (457, '正常', '012302', '枫原万叶', '2024-05-10', '08:18:21', '18:08:29', '01');
INSERT INTO `workattendance` VALUES (458, '正常', '022301', '班尼特·卡塔库栗', '2024-05-10', '08:20:21', '18:10:26', '02');
INSERT INTO `workattendance` VALUES (459, '正常', '022302', '胡桃', '2024-05-10', '08:17:22', '18:06:21', '02');
INSERT INTO `workattendance` VALUES (460, '迟到', '032301', '行秋', '2024-05-10', '09:13:34', '18:05:25', '03');
INSERT INTO `workattendance` VALUES (461, '正常', '012404', '雷电·影', '2024-05-10', '08:15:41', '18:05:30', '01');
INSERT INTO `workattendance` VALUES (462, '正常', '012405', '零式飞翼', '2024-05-10', '08:20:05', '18:00:09', '01');
INSERT INTO `workattendance` VALUES (463, '迟到', '012406', '地狱死神', '2024-05-10', '09:05:01', '18:05:12', '01');
INSERT INTO `workattendance` VALUES (464, '迟到', '022403', '荧', '2024-05-10', '09:00:09', '18:07:54', '02');
INSERT INTO `workattendance` VALUES (465, '正常', '042404', '姬子', '2024-05-10', '08:14:07', '18:03:55', '04');
INSERT INTO `workattendance` VALUES (466, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-10', '08:13:03', '18:05:22', '02');
INSERT INTO `workattendance` VALUES (467, '迟到', '022405', '星', '2024-05-10', '09:04:05', '18:04:42', '02');
INSERT INTO `workattendance` VALUES (468, '迟到', '012407', '瓦尔特·杨', '2024-05-10', '09:24:30', '18:07:25', '01');
INSERT INTO `workattendance` VALUES (469, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-10', '08:12:34', '18:08:06', '03');
INSERT INTO `workattendance` VALUES (470, '迟到', '032402', '派蒙', '2024-05-10', '09:06:38', '18:05:07', '03');
INSERT INTO `workattendance` VALUES (471, '正常', '042402', '空', '2024-05-10', '08:08:27', '18:06:36', '04');
INSERT INTO `workattendance` VALUES (472, '正常', '022406', '迈凯伦塞纳', '2024-05-10', '08:14:19', '18:02:57', '02');
INSERT INTO `workattendance` VALUES (473, '正常', '022407', '阿波罗IE', '2024-05-10', '08:07:47', '18:05:46', '02');
INSERT INTO `workattendance` VALUES (474, '迟到', '012301', '达达利亚', '2024-05-10', '09:05:01', '18:01:31', '01');
INSERT INTO `workattendance` VALUES (475, '正常', '022408', '飞升自由', '2024-05-10', '08:21:25', '18:02:05', '02');
INSERT INTO `workattendance` VALUES (476, '迟到', '022409', '梁庚大', '2024-05-10', '09:11:32', '18:06:36', '02');
INSERT INTO `workattendance` VALUES (477, '正常', '012409', '宫龙寻', '2024-05-10', '08:10:15', '18:02:56', '01');
INSERT INTO `workattendance` VALUES (478, '迟到', '032406', 'test', '2024-05-10', '09:15:39', '18:08:28', '03');
INSERT INTO `workattendance` VALUES (479, '迟到', '012408', '穹', '2024-05-13', '09:02:15', '18:04:42', '01');
INSERT INTO `workattendance` VALUES (480, '正常', '032305', '帕姆', '2024-05-13', '08:18:05', '18:06:46', '03');
INSERT INTO `workattendance` VALUES (481, '正常', '012303', '卯香菱', '2024-05-13', '08:16:49', '18:08:44', '01');
INSERT INTO `workattendance` VALUES (482, '正常', '042301', '钟离', '2024-05-13', '08:01:50', '18:03:15', '04');
INSERT INTO `workattendance` VALUES (483, '迟到', '052301', '夜阑', '2024-05-13', '09:26:19', '18:07:37', '05');
INSERT INTO `workattendance` VALUES (484, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-13', '09:10:08', '18:06:27', '05');
INSERT INTO `workattendance` VALUES (485, '正常', '052304', '久岐忍', '2024-05-13', '08:01:39', '18:07:24', '05');
INSERT INTO `workattendance` VALUES (486, '迟到', '012302', '枫原万叶', '2024-05-13', '09:01:41', '18:09:14', '01');
INSERT INTO `workattendance` VALUES (487, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-13', '09:00:44', '18:08:59', '02');
INSERT INTO `workattendance` VALUES (488, '迟到', '022302', '胡桃', '2024-05-13', '09:13:58', '18:07:25', '02');
INSERT INTO `workattendance` VALUES (489, '正常', '032301', '行秋', '2024-05-13', '08:28:01', '18:10:39', '03');
INSERT INTO `workattendance` VALUES (490, '迟到', '012404', '雷电·影', '2024-05-13', '09:12:54', '18:10:41', '01');
INSERT INTO `workattendance` VALUES (491, '迟到', '012405', '零式飞翼', '2024-05-13', '09:21:38', '18:06:31', '01');
INSERT INTO `workattendance` VALUES (492, '迟到', '012406', '地狱死神', '2024-05-13', '09:19:01', '18:06:41', '01');
INSERT INTO `workattendance` VALUES (493, '正常', '022403', '荧', '2024-05-13', '08:05:16', '18:04:07', '02');
INSERT INTO `workattendance` VALUES (494, '正常', '042404', '姬子', '2024-05-13', '08:15:27', '18:08:02', '04');
INSERT INTO `workattendance` VALUES (495, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-13', '09:05:23', '18:00:43', '02');
INSERT INTO `workattendance` VALUES (496, '迟到', '022405', '星', '2024-05-13', '09:24:42', '18:01:59', '02');
INSERT INTO `workattendance` VALUES (497, '正常', '012407', '瓦尔特·杨', '2024-05-13', '08:21:06', '18:04:51', '01');
INSERT INTO `workattendance` VALUES (498, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-13', '08:10:43', '18:03:59', '03');
INSERT INTO `workattendance` VALUES (499, '正常', '032402', '派蒙', '2024-05-13', '08:01:05', '18:09:59', '03');
INSERT INTO `workattendance` VALUES (500, '正常', '042402', '空', '2024-05-13', '08:18:49', '18:10:39', '04');
INSERT INTO `workattendance` VALUES (501, '迟到', '022406', '迈凯伦塞纳', '2024-05-13', '09:13:42', '18:10:38', '02');
INSERT INTO `workattendance` VALUES (502, '正常', '022407', '阿波罗IE', '2024-05-13', '08:02:35', '18:05:53', '02');
INSERT INTO `workattendance` VALUES (503, '迟到', '012301', '达达利亚', '2024-05-13', '09:12:21', '18:04:15', '01');
INSERT INTO `workattendance` VALUES (504, '迟到', '022408', '飞升自由', '2024-05-13', '09:09:49', '18:03:33', '02');
INSERT INTO `workattendance` VALUES (505, '正常', '022409', '梁庚大', '2024-05-13', '08:10:00', '18:07:03', '02');
INSERT INTO `workattendance` VALUES (506, '迟到', '012409', '宫龙寻', '2024-05-13', '09:23:14', '18:04:11', '01');
INSERT INTO `workattendance` VALUES (507, '迟到', '032406', 'test', '2024-05-13', '09:01:54', '18:00:38', '03');
INSERT INTO `workattendance` VALUES (508, '正常', '012408', '穹', '2024-05-14', '08:27:44', '18:09:35', '01');
INSERT INTO `workattendance` VALUES (509, '迟到', '032305', '帕姆', '2024-05-14', '09:02:47', '18:00:13', '03');
INSERT INTO `workattendance` VALUES (510, '迟到', '012303', '卯香菱', '2024-05-14', '09:17:22', '18:08:50', '01');
INSERT INTO `workattendance` VALUES (511, '正常', '042301', '钟离', '2024-05-14', '08:20:37', '18:00:49', '04');
INSERT INTO `workattendance` VALUES (512, '迟到', '052301', '夜阑', '2024-05-14', '09:21:17', '18:07:39', '05');
INSERT INTO `workattendance` VALUES (513, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-14', '08:01:39', '18:09:03', '05');
INSERT INTO `workattendance` VALUES (514, '正常', '052304', '久岐忍', '2024-05-14', '08:29:57', '18:04:48', '05');
INSERT INTO `workattendance` VALUES (515, '正常', '012302', '枫原万叶', '2024-05-14', '08:00:41', '18:00:08', '01');
INSERT INTO `workattendance` VALUES (516, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-14', '09:29:14', '18:02:33', '02');
INSERT INTO `workattendance` VALUES (517, '迟到', '022302', '胡桃', '2024-05-14', '09:14:01', '18:07:19', '02');
INSERT INTO `workattendance` VALUES (518, '正常', '032301', '行秋', '2024-05-14', '08:11:39', '18:02:43', '03');
INSERT INTO `workattendance` VALUES (519, '迟到', '012404', '雷电·影', '2024-05-14', '09:19:32', '18:06:46', '01');
INSERT INTO `workattendance` VALUES (520, '正常', '012405', '零式飞翼', '2024-05-14', '08:11:56', '18:06:00', '01');
INSERT INTO `workattendance` VALUES (521, '正常', '012406', '地狱死神', '2024-05-14', '08:26:41', '18:06:13', '01');
INSERT INTO `workattendance` VALUES (522, '迟到', '022403', '荧', '2024-05-14', '09:07:42', '18:06:01', '02');
INSERT INTO `workattendance` VALUES (523, '迟到', '042404', '姬子', '2024-05-14', '09:13:06', '18:09:14', '04');
INSERT INTO `workattendance` VALUES (524, '正常', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-14', '08:08:44', '18:06:35', '02');
INSERT INTO `workattendance` VALUES (525, '迟到', '022405', '星', '2024-05-14', '09:27:14', '18:09:52', '02');
INSERT INTO `workattendance` VALUES (526, '迟到', '012407', '瓦尔特·杨', '2024-05-14', '09:12:26', '18:06:19', '01');
INSERT INTO `workattendance` VALUES (527, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-14', '08:12:34', '18:09:11', '03');
INSERT INTO `workattendance` VALUES (528, '迟到', '032402', '派蒙', '2024-05-14', '09:07:52', '18:05:11', '03');
INSERT INTO `workattendance` VALUES (529, '正常', '042402', '空', '2024-05-14', '08:14:30', '18:01:47', '04');
INSERT INTO `workattendance` VALUES (530, '迟到', '022406', '迈凯伦塞纳', '2024-05-14', '09:04:14', '18:06:42', '02');
INSERT INTO `workattendance` VALUES (531, '迟到', '022407', '阿波罗IE', '2024-05-14', '09:26:17', '18:08:42', '02');
INSERT INTO `workattendance` VALUES (532, '正常', '012301', '达达利亚', '2024-05-14', '08:08:30', '18:03:36', '01');
INSERT INTO `workattendance` VALUES (533, '迟到', '022408', '飞升自由', '2024-05-14', '09:18:50', '18:06:04', '02');
INSERT INTO `workattendance` VALUES (534, '迟到', '022409', '梁庚大', '2024-05-14', '09:23:13', '18:02:10', '02');
INSERT INTO `workattendance` VALUES (535, '正常', '012409', '宫龙寻', '2024-05-14', '08:14:02', '18:01:44', '01');
INSERT INTO `workattendance` VALUES (536, '迟到', '032406', 'test', '2024-05-14', '09:17:18', '18:06:13', '03');
INSERT INTO `workattendance` VALUES (537, '正常', '012408', '穹', '2024-05-15', '08:02:14', '18:08:23', '01');
INSERT INTO `workattendance` VALUES (538, '正常', '032305', '帕姆', '2024-05-15', '08:09:13', '18:02:50', '03');
INSERT INTO `workattendance` VALUES (539, '迟到', '012303', '卯香菱', '2024-05-15', '09:11:44', '18:07:18', '01');
INSERT INTO `workattendance` VALUES (540, '迟到', '042301', '钟离', '2024-05-15', '09:17:47', '18:07:35', '04');
INSERT INTO `workattendance` VALUES (541, '正常', '052301', '夜阑', '2024-05-15', '08:21:23', '18:07:16', '05');
INSERT INTO `workattendance` VALUES (542, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-15', '09:29:32', '18:02:32', '05');
INSERT INTO `workattendance` VALUES (543, '迟到', '052304', '久岐忍', '2024-05-15', '09:00:24', '18:06:22', '05');
INSERT INTO `workattendance` VALUES (544, '正常', '012302', '枫原万叶', '2024-05-15', '08:27:51', '18:07:02', '01');
INSERT INTO `workattendance` VALUES (545, '正常', '022301', '班尼特·卡塔库栗', '2024-05-15', '08:09:16', '18:10:52', '02');
INSERT INTO `workattendance` VALUES (546, '迟到', '022302', '胡桃', '2024-05-15', '09:26:01', '18:00:50', '02');
INSERT INTO `workattendance` VALUES (547, '正常', '032301', '行秋', '2024-05-15', '08:27:22', '18:04:47', '03');
INSERT INTO `workattendance` VALUES (548, '正常', '012404', '雷电·影', '2024-05-15', '08:28:22', '18:00:08', '01');
INSERT INTO `workattendance` VALUES (549, '正常', '012405', '零式飞翼', '2024-05-15', '08:25:28', '18:04:06', '01');
INSERT INTO `workattendance` VALUES (550, '迟到', '012406', '地狱死神', '2024-05-15', '09:01:49', '18:02:46', '01');
INSERT INTO `workattendance` VALUES (551, '正常', '022403', '荧', '2024-05-15', '08:17:38', '18:04:12', '02');
INSERT INTO `workattendance` VALUES (552, '迟到', '042404', '姬子', '2024-05-15', '09:01:40', '18:10:19', '04');
INSERT INTO `workattendance` VALUES (553, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-15', '09:13:41', '18:08:36', '02');
INSERT INTO `workattendance` VALUES (554, '正常', '022405', '星', '2024-05-15', '08:11:52', '18:08:56', '02');
INSERT INTO `workattendance` VALUES (555, '迟到', '012407', '瓦尔特·杨', '2024-05-15', '09:15:32', '18:07:52', '01');
INSERT INTO `workattendance` VALUES (556, '迟到', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-15', '09:25:16', '18:02:40', '03');
INSERT INTO `workattendance` VALUES (557, '正常', '032402', '派蒙', '2024-05-15', '08:03:18', '18:01:33', '03');
INSERT INTO `workattendance` VALUES (558, '迟到', '042402', '空', '2024-05-15', '09:18:43', '18:09:22', '04');
INSERT INTO `workattendance` VALUES (559, '迟到', '022406', '迈凯伦塞纳', '2024-05-15', '09:00:48', '18:02:58', '02');
INSERT INTO `workattendance` VALUES (560, '迟到', '022407', '阿波罗IE', '2024-05-15', '09:21:18', '18:08:42', '02');
INSERT INTO `workattendance` VALUES (561, '迟到', '012301', '达达利亚', '2024-05-15', '09:21:12', '18:01:11', '01');
INSERT INTO `workattendance` VALUES (562, '迟到', '022408', '飞升自由', '2024-05-15', '09:10:56', '18:02:30', '02');
INSERT INTO `workattendance` VALUES (563, '正常', '022409', '梁庚大', '2024-05-15', '08:24:33', '18:00:06', '02');
INSERT INTO `workattendance` VALUES (564, '迟到', '012409', '宫龙寻', '2024-05-15', '09:20:16', '18:09:16', '01');
INSERT INTO `workattendance` VALUES (565, '正常', '032406', 'test', '2024-05-15', '08:08:30', '18:09:34', '03');
INSERT INTO `workattendance` VALUES (569, '正常', '032305', '帕姆', '2024-05-16', '08:23:15', '18:08:42', '03');
INSERT INTO `workattendance` VALUES (568, '正常', '012408', '穹', '2024-05-16', '08:00:32', '18:00:52', '01');
INSERT INTO `workattendance` VALUES (570, '迟到', '012303', '卯香菱', '2024-05-16', '09:27:00', '18:10:54', '01');
INSERT INTO `workattendance` VALUES (571, '正常', '042301', '钟离', '2024-05-16', '08:28:03', '18:06:34', '04');
INSERT INTO `workattendance` VALUES (572, '正常', '052301', '夜阑', '2024-05-16', '08:22:04', '18:08:59', '05');
INSERT INTO `workattendance` VALUES (573, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-16', '09:27:21', '18:00:52', '05');
INSERT INTO `workattendance` VALUES (574, '迟到', '052304', '久岐忍', '2024-05-16', '09:01:18', '18:06:52', '05');
INSERT INTO `workattendance` VALUES (575, '迟到', '012302', '枫原万叶', '2024-05-16', '09:09:37', '18:01:33', '01');
INSERT INTO `workattendance` VALUES (576, '迟到', '022301', '班尼特·卡塔库栗', '2024-05-16', '09:05:31', '18:03:58', '02');
INSERT INTO `workattendance` VALUES (577, '迟到', '022302', '胡桃', '2024-05-16', '09:30:43', '18:08:45', '02');
INSERT INTO `workattendance` VALUES (578, '迟到', '032301', '行秋', '2024-05-16', '09:29:23', '18:05:04', '03');
INSERT INTO `workattendance` VALUES (579, '迟到', '012404', '雷电·影', '2024-05-16', '09:05:49', '18:00:55', '01');
INSERT INTO `workattendance` VALUES (580, '正常', '012405', '零式飞翼', '2024-05-16', '08:04:48', '18:09:06', '01');
INSERT INTO `workattendance` VALUES (581, '正常', '012406', '地狱死神', '2024-05-16', '08:30:33', '18:05:33', '01');
INSERT INTO `workattendance` VALUES (582, '迟到', '022403', '荧', '2024-05-16', '09:11:50', '18:08:36', '02');
INSERT INTO `workattendance` VALUES (583, '正常', '042404', '姬子', '2024-05-16', '08:06:52', '18:00:49', '04');
INSERT INTO `workattendance` VALUES (584, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-16', '09:30:16', '18:09:10', '02');
INSERT INTO `workattendance` VALUES (585, '正常', '022405', '星', '2024-05-16', '08:11:09', '18:07:19', '02');
INSERT INTO `workattendance` VALUES (586, '正常', '012407', '瓦尔特·杨', '2024-05-16', '08:07:12', '18:04:26', '01');
INSERT INTO `workattendance` VALUES (587, '迟到', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-16', '09:04:04', '18:03:47', '03');
INSERT INTO `workattendance` VALUES (588, '正常', '032402', '派蒙', '2024-05-16', '08:16:49', '18:01:49', '03');
INSERT INTO `workattendance` VALUES (589, '迟到', '042402', '空', '2024-05-16', '09:25:06', '18:09:59', '04');
INSERT INTO `workattendance` VALUES (590, '正常', '022406', '迈凯伦塞纳', '2024-05-16', '08:16:33', '18:05:53', '02');
INSERT INTO `workattendance` VALUES (591, '正常', '022407', '阿波罗IE', '2024-05-16', '08:09:04', '18:01:01', '02');
INSERT INTO `workattendance` VALUES (592, '正常', '012301', '达达利亚', '2024-05-16', '08:24:12', '18:00:10', '01');
INSERT INTO `workattendance` VALUES (593, '迟到', '022408', '飞升自由', '2024-05-16', '09:21:31', '18:02:39', '02');
INSERT INTO `workattendance` VALUES (594, '正常', '022409', '梁庚大', '2024-05-16', '08:17:53', '18:07:51', '02');
INSERT INTO `workattendance` VALUES (595, '迟到', '012409', '宫龙寻', '2024-05-16', '09:14:32', '18:08:44', '01');
INSERT INTO `workattendance` VALUES (596, '正常', '032406', 'test', '2024-05-16', '08:26:15', '18:05:37', '03');
INSERT INTO `workattendance` VALUES (597, '迟到', '012408', '穹', '2024-05-17', '09:14:29', '18:04:37', '01');
INSERT INTO `workattendance` VALUES (598, '迟到', '032305', '帕姆', '2024-05-17', '09:15:58', '18:01:01', '03');
INSERT INTO `workattendance` VALUES (599, '正常', '012303', '卯香菱', '2024-05-17', '08:00:59', '18:02:33', '01');
INSERT INTO `workattendance` VALUES (600, '正常', '042301', '钟离', '2024-05-17', '08:12:26', '18:05:36', '04');
INSERT INTO `workattendance` VALUES (601, '迟到', '052301', '夜阑', '2024-05-17', '09:25:30', '18:00:14', '05');
INSERT INTO `workattendance` VALUES (602, '迟到', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-17', '09:26:39', '18:01:05', '05');
INSERT INTO `workattendance` VALUES (603, '正常', '052304', '久岐忍', '2024-05-17', '08:22:53', '18:10:48', '05');
INSERT INTO `workattendance` VALUES (604, '正常', '012302', '枫原万叶', '2024-05-17', '08:05:22', '18:08:14', '01');
INSERT INTO `workattendance` VALUES (605, '正常', '022301', '班尼特·卡塔库栗', '2024-05-17', '08:16:13', '18:00:43', '02');
INSERT INTO `workattendance` VALUES (606, '迟到', '022302', '胡桃', '2024-05-17', '09:20:19', '18:01:56', '02');
INSERT INTO `workattendance` VALUES (607, '迟到', '032301', '行秋', '2024-05-17', '09:09:17', '18:07:16', '03');
INSERT INTO `workattendance` VALUES (608, '正常', '012404', '雷电·影', '2024-05-17', '08:15:04', '18:06:16', '01');
INSERT INTO `workattendance` VALUES (609, '迟到', '012405', '零式飞翼', '2024-05-17', '09:07:15', '18:08:23', '01');
INSERT INTO `workattendance` VALUES (610, '迟到', '012406', '地狱死神', '2024-05-17', '09:13:47', '18:00:29', '01');
INSERT INTO `workattendance` VALUES (611, '正常', '022403', '荧', '2024-05-17', '08:23:11', '18:00:05', '02');
INSERT INTO `workattendance` VALUES (612, '正常', '042404', '姬子', '2024-05-17', '08:00:42', '18:05:35', '04');
INSERT INTO `workattendance` VALUES (613, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-17', '09:09:45', '18:03:18', '02');
INSERT INTO `workattendance` VALUES (614, '正常', '022405', '星', '2024-05-17', '08:00:32', '18:02:13', '02');
INSERT INTO `workattendance` VALUES (615, '迟到', '012407', '瓦尔特·杨', '2024-05-17', '09:02:58', '18:07:17', '01');
INSERT INTO `workattendance` VALUES (616, '正常', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-17', '08:16:38', '18:00:30', '03');
INSERT INTO `workattendance` VALUES (617, '正常', '032402', '派蒙', '2024-05-17', '08:30:31', '18:08:47', '03');
INSERT INTO `workattendance` VALUES (618, '迟到', '042402', '空', '2024-05-17', '09:09:05', '18:02:31', '04');
INSERT INTO `workattendance` VALUES (619, '正常', '022406', '迈凯伦塞纳', '2024-05-17', '08:09:09', '18:00:39', '02');
INSERT INTO `workattendance` VALUES (620, '迟到', '022407', '阿波罗IE', '2024-05-17', '09:26:49', '18:01:39', '02');
INSERT INTO `workattendance` VALUES (621, '正常', '012301', '达达利亚', '2024-05-17', '08:28:43', '18:03:08', '01');
INSERT INTO `workattendance` VALUES (622, '迟到', '022408', '飞升自由', '2024-05-17', '09:24:17', '18:10:23', '02');
INSERT INTO `workattendance` VALUES (623, '迟到', '022409', '梁庚大', '2024-05-17', '09:10:37', '18:05:33', '02');
INSERT INTO `workattendance` VALUES (624, '正常', '012409', '宫龙寻', '2024-05-17', '08:02:20', '18:07:05', '01');
INSERT INTO `workattendance` VALUES (625, '正常', '032406', 'test', '2024-05-17', '08:17:04', '18:00:34', '03');
INSERT INTO `workattendance` VALUES (626, '正常', '012408', '穹', '2024-05-18', '08:02:00', '18:01:51', '01');
INSERT INTO `workattendance` VALUES (627, '迟到', '032305', '帕姆', '2024-05-18', '09:06:33', '18:10:54', '03');
INSERT INTO `workattendance` VALUES (628, '迟到', '012303', '卯香菱', '2024-05-18', '09:23:36', '18:02:48', '01');
INSERT INTO `workattendance` VALUES (629, '迟到', '042301', '钟离', '2024-05-18', '09:25:08', '18:02:12', '04');
INSERT INTO `workattendance` VALUES (630, '迟到', '052301', '夜阑', '2024-05-18', '09:29:37', '18:06:20', '05');
INSERT INTO `workattendance` VALUES (631, '正常', '052303', '阿斯托洛吉斯·莫娜·梅姬斯图斯', '2024-05-18', '08:26:06', '18:00:27', '05');
INSERT INTO `workattendance` VALUES (632, '正常', '052304', '久岐忍', '2024-05-18', '08:15:20', '18:00:49', '05');
INSERT INTO `workattendance` VALUES (633, '迟到', '012302', '枫原万叶', '2024-05-18', '09:00:34', '18:07:54', '01');
INSERT INTO `workattendance` VALUES (634, '正常', '022301', '班尼特·卡塔库栗', '2024-05-18', '08:14:05', '18:10:08', '02');
INSERT INTO `workattendance` VALUES (635, '正常', '022302', '胡桃', '2024-05-18', '08:19:21', '18:00:32', '02');
INSERT INTO `workattendance` VALUES (636, '迟到', '032301', '行秋', '2024-05-18', '09:30:47', '18:09:54', '03');
INSERT INTO `workattendance` VALUES (637, '正常', '012404', '雷电·影', '2024-05-18', '08:26:24', '18:02:47', '01');
INSERT INTO `workattendance` VALUES (638, '正常', '012405', '零式飞翼', '2024-05-18', '08:16:18', '18:01:36', '01');
INSERT INTO `workattendance` VALUES (639, '迟到', '012406', '地狱死神', '2024-05-18', '09:03:41', '18:10:00', '01');
INSERT INTO `workattendance` VALUES (640, '迟到', '022403', '荧', '2024-05-18', '09:09:51', '18:08:12', '02');
INSERT INTO `workattendance` VALUES (641, '正常', '042404', '姬子', '2024-05-18', '08:05:37', '18:01:50', '04');
INSERT INTO `workattendance` VALUES (642, '迟到', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-05-18', '09:28:05', '18:04:36', '02');
INSERT INTO `workattendance` VALUES (643, '迟到', '022405', '星', '2024-05-18', '09:26:09', '18:00:10', '02');
INSERT INTO `workattendance` VALUES (644, '正常', '012407', '瓦尔特·杨', '2024-05-18', '08:20:15', '18:09:05', '01');
INSERT INTO `workattendance` VALUES (645, '迟到', '032404', '艾吉奥·奥迪托雷·达·佛罗伦萨', '2024-05-18', '09:16:05', '18:06:58', '03');
INSERT INTO `workattendance` VALUES (646, '正常', '032402', '派蒙', '2024-05-18', '08:08:28', '18:00:20', '03');
INSERT INTO `workattendance` VALUES (647, '正常', '042402', '空', '2024-05-18', '08:27:53', '18:05:09', '04');
INSERT INTO `workattendance` VALUES (648, '正常', '022406', '迈凯伦塞纳', '2024-05-18', '08:24:30', '18:10:41', '02');
INSERT INTO `workattendance` VALUES (649, '正常', '022407', '阿波罗IE', '2024-05-18', '08:28:01', '18:00:54', '02');
INSERT INTO `workattendance` VALUES (650, '迟到', '012301', '达达利亚', '2024-05-18', '09:10:18', '18:00:38', '01');
INSERT INTO `workattendance` VALUES (651, '正常', '022408', '飞升自由', '2024-05-18', '08:23:21', '18:08:48', '02');
INSERT INTO `workattendance` VALUES (652, '正常', '022409', '梁庚大', '2024-05-18', '08:00:25', '18:04:49', '02');
INSERT INTO `workattendance` VALUES (653, '迟到', '012409', '宫龙寻', '2024-05-18', '09:12:54', '18:09:21', '01');
INSERT INTO `workattendance` VALUES (654, '迟到', '032406', 'test', '2024-05-18', '09:25:09', '18:09:32', '03');
INSERT INTO `workattendance` VALUES (655, '请假', '022302', '胡桃', '2024-05-21', '00:00:00', '00:00:00', '02');

SET FOREIGN_KEY_CHECKS = 1;
