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

 Date: 02/04/2024 09:17:33
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
INSERT INTO `admin_authority` VALUES (17, 'user', 'allotAuthority', NULL, 'allotAuthority', '分配权限');
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
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for admin_op_review
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_review`;
CREATE TABLE `admin_op_review`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `datetime` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------

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
INSERT INTO `admin_user` VALUES ('012301', '01', '达达利亚', 'admin', '在线', 'home,staff,staffMsg,checkingIn,settingDimission,allStaffMsgView,updateCheckingIn,allStaffCheckingInView,user,operatingRequestAudit,updateOpReviewStatus,showUserPassWord,allotAuthority,updateUserPassWord,deleteUser,operatingData,feedback,dimission,dimissionData,addAdminUser,returnStaffTable,dimissionAudit,updateResignReviewStatus,adminUpdateStaff,adminAddStaff');

-- ----------------------------
-- Table structure for askforleave
-- ----------------------------
DROP TABLE IF EXISTS `askforleave`;
CREATE TABLE `askforleave`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver_staffId` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `dateTime` datetime NOT NULL,
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
  `dateTime` datetime NOT NULL,
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
  `datetime` datetime NOT NULL,
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
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------
INSERT INTO `resignreview` VALUES (10, '052303', '放屁老板', '2024-03-31 09:50:44', '待审核', '阿斯托洛吉斯·莫娜·梅姬斯图斯');
INSERT INTO `resignreview` VALUES (9, '052301', '家里有矿', '2024-04-01 09:49:50', '审核通过', '夜阑');

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
INSERT INTO `staff` VALUES ('012404', '01', 12171190114, '雷电·影', '女', 300, 7700, '普通员工', '2024-03-01');
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
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `staffName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of workattendance
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
