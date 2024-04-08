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

 Date: 08/04/2024 09:27:24
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
) ENGINE = MyISAM AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `admin_authority` VALUES (31, 'staff', 'staffMsg', 'departmentStaffMsg', 'departmentStaffMsg', '只可以查看自己部门的员工信息');
INSERT INTO `admin_authority` VALUES (32, 'user', 'userData', '', 'userData', '所有用户数据');
INSERT INTO `admin_authority` VALUES (33, 'operatingRequestAudit', 'operatingRequestAuditData', NULL, 'operatingRequestAuditData', '所有操作请求的数据');

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
) ENGINE = MyISAM AUTO_INCREMENT = 289 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
  `datetime` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------
INSERT INTO `admin_op_review` VALUES (47, '{\"oldData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": \"13300000000\", \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}}', 'updateRequest', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-02 22:38:57', '待审核');
INSERT INTO `admin_op_review` VALUES (48, '{\"oldData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": 13376629080, \"job\": \"\\u7ecf\\u7406\", \"staffName\": \"\\u73ed\\u5c3c\\u7279\\u00b7\\u5361\\u5854\\u5e93\\u6817\", \"sex\": \"\\u7537\", \"age\": 21, \"salary\": 7000, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"022301\", \"departId\": \"02\", \"phoneNum\": \"19111199997\", \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u5e15\\u59c6\", \"sex\": \"\\u7537\", \"age\": 5, \"salary\": 7000, \"entryTime\": \"2024-04-18\"}}', 'updateRequest', '022404', '菲谢尔·冯·露弗施洛斯·那菲多特', '2024-04-02 22:39:43', '审核驳回');
INSERT INTO `admin_op_review` VALUES (52, '{\"oldData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 300, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}, \"newData\": {\"staffId\": \"012404\", \"departId\": \"01\", \"phoneNum\": 12171190114, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u96f7\\u7535\\u00b7\\u5f71\", \"sex\": \"\\u5973\", \"age\": 500, \"salary\": 7700, \"entryTime\": \"2024-03-01\"}}', 'updateRequest', '012301', '达达利亚', '2024-04-07 23:04:49', '审核通过');

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
INSERT INTO `admin_user` VALUES ('012301', '01', '达达利亚', '123', '在线', 'staff,staffMsg,home,allStaffMsgView,adminAddStaff,adminUpdateStaff,user,showUserPassWord,allotAuthority,updateUserPassWord,deleteUser,addAdminUser,userData,operatingRequestAudit,updateOpReviewStatus,operatingRequestAuditData,operatingData,feedback,dimission,settingDimission,dimissionData,returnStaffTable,dimissionAudit,updateResignReviewStatus');

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
INSERT INTO `feedback` VALUES (18, '报服务器异常的错误\n', '012303', '2024-03-17 14:55:42');

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
INSERT INTO `resign` VALUES ('052302', '05', 11371238224, '纳西妲', '女', 500, 4000, '普通员工', '2023-09-15', '2024-04-01');
INSERT INTO `resign` VALUES ('032403', '03', 18173209421, '丹恒•饮月', '男', 600, 7000, '普通员工', '2024-03-13', '2024-04-01');
INSERT INTO `resign` VALUES ('042403', '04', 18293321991, '三月七', '女', 22, 9000, '普通员工', '2024-03-07', '2024-04-01');

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
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------
INSERT INTO `resignreview` VALUES (10, '052303', '找到更好的工作，准备转行。', '2024-03-31 09:50:44', '待审核', '阿斯托洛吉斯·莫娜·梅姬斯图斯');
INSERT INTO `resignreview` VALUES (9, '052301', '需要出国留学。', '2024-04-01 09:49:50', '待审核', '夜阑');

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
INSERT INTO `staff` VALUES ('052303', '05', 12134444042, '阿斯托洛吉斯·莫娜·梅姬斯图斯', '女', 23, 100000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052304', '05', 13472894789, '久岐忍', '女', 22, 4200, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('012302', '01', 17322297254, '枫原万叶', '男', 22, 5100, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012303', '01', 19322904711, '卯香菱', '女', 22, 300, '实习生', '2023-09-04');
INSERT INTO `staff` VALUES ('012404', '01', 12171190114, '雷电·影', '女', 500, 7700, '普通员工', '2024-03-01');
INSERT INTO `staff` VALUES ('022301', '02', 13376629080, '班尼特·卡塔库栗', '男', 21, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('022302', '02', 13376629080, '胡桃', '女', 16, 7000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('032301', '03', 13232234167, '行秋', '男', 17, 5000, '实习生', '2023-09-15');
INSERT INTO `staff` VALUES ('042402', '04', 15312250345, '空', '男', 540, 8000, '经理', '2024-03-22');
INSERT INTO `staff` VALUES ('032402', '03', 12322253454, '派蒙', '女', 6, 7000, '普通员工', '2024-03-21');
INSERT INTO `staff` VALUES ('022406', '02', 19273322110, '星', '女', 5, 5000, '普通员工', '2024-03-13');
INSERT INTO `staff` VALUES ('042404', '04', 18293318992, '姬子', '女', 32, 13000, '普通员工', '2024-03-06');
INSERT INTO `staff` VALUES ('012407', '01', 19191923128, '瓦尔特·杨', '男', 500, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('012408', '01', 19231000000, '穹', '男', 9, 10000, '经理', '2023-07-20');
INSERT INTO `staff` VALUES ('032404', '03', 12689931884, '艾吉奥·奥迪托雷·达·佛罗伦萨', '男', 35, 10000, '普通员工', '2024-03-14');
INSERT INTO `staff` VALUES ('012301', '01', 13172290114, '达达利亚', '男', 22, 10000, '普通员工', '2024-04-01');

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
