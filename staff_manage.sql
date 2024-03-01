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

 Date: 01/03/2024 10:57:13
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
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_authority
-- ----------------------------
INSERT INTO `admin_authority` VALUES (1, 'home', NULL, NULL, 'home', '首页');
INSERT INTO `admin_authority` VALUES (2, 'staff', NULL, NULL, 'staff', '员工管理');
INSERT INTO `admin_authority` VALUES (3, 'staff', 'staffMsg', NULL, 'staffMsg', '员工信息');
INSERT INTO `admin_authority` VALUES (4, 'staff', 'checkingIn', NULL, 'checkingIn', '考勤管理');
INSERT INTO `admin_authority` VALUES (5, 'staff', 'staffMsg', 'userAddStaff', 'userAddStaff', '添加员工(需审核)');
INSERT INTO `admin_authority` VALUES (6, 'staff', 'staffMsg', 'userUpdateStaff', 'userUpdateStaff', '修改员工(需审核)');
INSERT INTO `admin_authority` VALUES (7, 'staff', 'staffMsg', 'settingDimission', 'settingDimission', '设置为离职');
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
) ENGINE = MyISAM AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_record
-- ----------------------------
INSERT INTO `admin_op_record` VALUES (1, '\n                <div>\n                    <p>修改信息</p>\n                    <p>012301用户将员工号为012302员工的信息修改</p>\n                </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5100</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>20</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>200</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-27</span>\n            </p>\n        </div>\n        ', '012301', '2023-11-28 13:38:08');
INSERT INTO `admin_op_record` VALUES (2, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-14</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 14:19:30');
INSERT INTO `admin_op_record` VALUES (3, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>sda</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-14</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 14:22:13');
INSERT INTO `admin_op_record` VALUES (4, '\n            <div>\n                <p>添加信息请求</p>\n                <p>012302用户请求添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-07</span>\n            </p>\n        </div>\n        ', '012302', '2024-02-11 14:26:01');
INSERT INTO `admin_op_record` VALUES (5, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13122290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>4</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-16</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 14:58:42');
INSERT INTO `admin_op_record` VALUES (6, '\n                <div>\n                    <p>修改信息</p>\n                    <p>012301用户将员工号为012301员工的信息修改</p>\n                </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>达达利亚</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>9000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>达达利亚</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>9000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-08</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 15:14:23');
INSERT INTO `admin_op_record` VALUES (7, '\n            <div>\n                <p>修改信息请求</p>\n                <p>012302用户想要修改员工号为012301员工的信息</p>\n            </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>达达利亚</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>9000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-08</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>达达利亚</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>9000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-08</span>\n            </p>\n        </div>\n        ', '012302', '2024-02-11 15:15:57');
INSERT INTO `admin_op_record` VALUES (8, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-13</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 21:03:27');
INSERT INTO `admin_op_record` VALUES (9, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123546</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>4</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-15</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-11 21:05:07');
INSERT INTO `admin_op_record` VALUES (10, '\n                <div>\n                    <p>修改信息</p>\n                    <p>012301用户将员工号为012404员工的信息修改</p>\n                </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123546</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>4</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>荧</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13172290114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>500</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-15</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-12 17:35:36');
INSERT INTO `admin_op_record` VALUES (11, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-02-13 18:09:14');
INSERT INTO `admin_op_record` VALUES (12, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-02-13 18:11:59');
INSERT INTO `admin_op_record` VALUES (13, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-02-13 18:15:03');
INSERT INTO `admin_op_record` VALUES (14, '<div class=\"shortMsg\">012301将达达利亚设置为离职</div>', '012301', '2024-02-13 18:16:45');
INSERT INTO `admin_op_record` VALUES (15, '<div class=\"shortMsg\">012301将万叶设置为离职</div>', '012301', '2024-02-13 18:17:42');
INSERT INTO `admin_op_record` VALUES (16, '<div class=\"shortMsg\">012301将香菱设置为离职</div>', '012301', '2024-02-13 18:17:53');
INSERT INTO `admin_op_record` VALUES (17, '<div class=\"shortMsg\">012301将sda设置为离职</div>', '012301', '2024-02-13 18:24:41');
INSERT INTO `admin_op_record` VALUES (18, '<div class=\"shortMsg\">012301将123设置为离职</div>', '012301', '2024-02-13 18:25:58');
INSERT INTO `admin_op_record` VALUES (19, '<div class=\"shortMsg\">012301将123设置为离职</div>', '012301', '2024-02-13 18:28:40');
INSERT INTO `admin_op_record` VALUES (20, '<div class=\"shortMsg\">012301将123设置为离职</div>', '012301', '2024-02-13 18:33:51');
INSERT INTO `admin_op_record` VALUES (21, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>2</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>2</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-14</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 18:38:00');
INSERT INTO `admin_op_record` VALUES (22, '<div class=\"shortMsg\">012301将2设置为离职</div>', '012301', '2024-02-13 18:38:06');
INSERT INTO `admin_op_record` VALUES (23, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>456</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>2</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>2000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-13</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 22:18:28');
INSERT INTO `admin_op_record` VALUES (24, '<div class=\"shortMsg\">012301将荧设置为离职</div>', '012301', '2024-02-13 22:18:31');
INSERT INTO `admin_op_record` VALUES (25, '<div class=\"shortMsg\">012301将123设置为离职</div>', '012301', '2024-02-13 22:19:01');
INSERT INTO `admin_op_record` VALUES (26, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>1000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-14</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 22:20:02');
INSERT INTO `admin_op_record` VALUES (27, '<div class=\"shortMsg\">012301将123设置为离职</div>', '012301', '2024-02-13 22:20:18');
INSERT INTO `admin_op_record` VALUES (28, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>123</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>122315</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-15</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 22:25:00');
INSERT INTO `admin_op_record` VALUES (29, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>1321</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>21321596</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>3</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-07</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 22:27:33');
INSERT INTO `admin_op_record` VALUES (30, '<div class=\"shortMsg\">012301将1321设置为离职</div>', '012301', '2024-02-13 22:28:05');
INSERT INTO `admin_op_record` VALUES (31, '\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>11325</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>52216</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>1</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>1000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-29</span>\n            </p>\n        </div>\n        ', '012301', '2024-02-13 22:28:22');
INSERT INTO `admin_op_record` VALUES (32, '<div class=\"shortMsg\">012301将11325设置为离职</div>', '012301', '2024-02-13 22:32:05');
INSERT INTO `admin_op_record` VALUES (33, '\n            <div>\n                <p>修改信息请求</p>\n                <p>012302用户想要修改员工号为012302员工的信息</p>\n            </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5100</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5100</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-02-23</span>\n            </p>\n        </div>\n        ', '012302', '2024-02-18 09:49:24');
INSERT INTO `admin_op_record` VALUES (34, '\n            <div>\n                <p>修改信息请求</p>\n                <p>012302用户想要修改员工号为012303员工的信息</p>\n            </div>\n            \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>香菱</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19322904711</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5300</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>香菱</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19322904711</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5300</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-12-12</span>\n            </p>\n        </div>\n        ', '012302', '2024-02-18 09:55:56');
INSERT INTO `admin_op_record` VALUES (35, '<div class=\"shortMsg\">012302用户的修改信息请求已被012301用户驳回</div>', '012301', '2024-02-19 11:31:16');
INSERT INTO `admin_op_record` VALUES (36, '<div class=\"shortMsg\">012301查看了012302的密码</div>', '012301', '2024-02-21 09:48:12');
INSERT INTO `admin_op_record` VALUES (37, '<div class=\"shortMsg\">012301查看了012302的密码</div>', '012301', '2024-02-21 09:49:05');
INSERT INTO `admin_op_record` VALUES (38, '<div class=\"shortMsg\">012301查看了012302的密码</div>', '012301', '2024-02-21 09:49:24');
INSERT INTO `admin_op_record` VALUES (39, '<div class=\"shortMsg\">012301查看了012302的密码</div>', '012301', '2024-02-21 09:50:00');
INSERT INTO `admin_op_record` VALUES (40, '<div class=\"shortMsg\">012301修改了012302的密码</div>', '012301', '2024-02-29 13:52:14');
INSERT INTO `admin_op_record` VALUES (41, '<div class=\"shortMsg\">012301修改了012302的密码</div>', '012301', '2024-02-29 14:01:55');
INSERT INTO `admin_op_record` VALUES (42, '<div class=\"shortMsg\">012301修改了012302的密码</div>', '012301', '2024-02-29 14:02:08');
INSERT INTO `admin_op_record` VALUES (43, '<div class=\"shortMsg\">012301删除了test用户</div>', '012301', '2024-02-29 14:19:33');

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
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------
INSERT INTO `admin_op_review` VALUES (4, '{\"oldData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-12-12\"}}', 'updateRequest', '012302', '2024-02-18 09:55:56', '审核驳回');
INSERT INTO `admin_op_review` VALUES (3, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2024-02-23\"}}', 'updateRequest', '012302', '2024-02-18 09:49:24', '待审核');

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
INSERT INTO `admin_user` VALUES ('012301', '01', '达达利亚', 'admin', '下线', 'home,staff,staffMsg,checkingIn,settingDimission,adminAddStaff,adminUpdateStaff,updateCheckingIn,allStaffCheckingInView,user,allStaffMsgView,operatingRequestAudit,updateOpReviewStatus,showUserPassWord,allotAuthority,updateUserPassWord,deleteUser');
INSERT INTO `admin_user` VALUES ('012302', '01', '万叶', 'lgd', '在线', 'home,staff,staffMsg,userAddStaff,userUpdateStaff');

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
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dateTime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, 'adwdada', '012301', 'admin', '2023-11-13 09:48:20');
INSERT INTO `feedback` VALUES (2, '忘记密码。', '012301', 'admin', '2023-11-13 13:37:06');
INSERT INTO `feedback` VALUES (3, 'hello 哇', '012301', 'admin', '2023-11-28 09:50:50');

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departId` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phoneNum` bigint(20) NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entryTime` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resign
-- ----------------------------
INSERT INTO `resign` VALUES (1, '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-03-08');
INSERT INTO `resign` VALUES (2, '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-03-08');
INSERT INTO `resign` VALUES (3, '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-03-08');
INSERT INTO `resign` VALUES (4, '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-03-08');
INSERT INTO `resign` VALUES (5, '01', 17322297254, '万叶', '男', 20, 200, '普通员工', '2023-09-27');
INSERT INTO `resign` VALUES (6, '01', 19322904711, '香菱', '女', 22, 5300, '普通员工', '2023-09-15');
INSERT INTO `resign` VALUES (7, '02', 13172290114, 'sda', '男', 1, 3, '普通员工', '2024-02-14');
INSERT INTO `resign` VALUES (8, '02', 13172290114, '123', '男', 3, 4, '普通员工', '2024-02-14');
INSERT INTO `resign` VALUES (9, '01', 13172290114, '123', '男', 5, 3000, '普通员工', '2024-02-13');
INSERT INTO `resign` VALUES (10, '02', 13122290114, '123', '男', 4, 4000, '普通员工', '2024-02-16');
INSERT INTO `resign` VALUES (11, '02', 2, '2', '男', 3, 3000, '普通员工', '2024-02-14');
INSERT INTO `resign` VALUES (12, '05', 13172290114, '荧', '女', 500, 7000, '普通员工', '2024-02-15');
INSERT INTO `resign` VALUES (13, '01', 456, '123', '男', 2, 2000, '经理', '2024-02-13');
INSERT INTO `resign` VALUES (14, '01', 123, '123', '男', 3, 1000, '普通员工', '2024-02-14');
INSERT INTO `resign` VALUES (15, '01', 21321596, '1321', '男', 3, 3000, '经理', '2024-02-07');
INSERT INTO `resign` VALUES (16, '01', 52216, '11325', '女', 1, 1000, '普通员工', '2024-02-29');

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
  PRIMARY KEY (`id`, `staffId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------

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
INSERT INTO `staff` VALUES ('022301', '02', 13376629080, '班尼特', '男', 21, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('022302', '02', 13376629080, '胡桃', '女', 16, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('032301', '03', 13232234167, '行秋', '男', 17, 5000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('042301', '04', 15238199014, '钟离', '男', 1000, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052301', '05', 11371238904, '夜阑', '女', 24, 8000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052302', '05', 11371238224, '纳西妲', '女', 500, 4000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052303', '05', 12134444042, '莫娜', '女', 23, 3000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('052304', '05', 13472894789, '久岐忍', '女', 22, 4200, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012302', '01', 17322297254, '万叶', '男', 22, 5100, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012301', '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-02-15');
INSERT INTO `staff` VALUES ('012303', '01', 19322904711, '香菱', '女', 22, 5300, '普通员工', '2023-09-15');

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of workattendance
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
