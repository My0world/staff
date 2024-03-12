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

 Date: 12/03/2024 09:26:44
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
) ENGINE = MyISAM AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_record
-- ----------------------------
INSERT INTO `admin_op_record` VALUES (88, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为022301员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:12:13');
INSERT INTO `admin_op_record` VALUES (87, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为052303员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>阿斯托洛吉斯·莫娜·梅姬斯图斯</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12134444042</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>阿斯托洛吉斯·莫娜·梅姬斯图斯</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12134444042</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:11:58');
INSERT INTO `admin_op_record` VALUES (86, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为052304员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052304</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>久岐忍</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13472894789</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4200</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052304</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>久岐忍</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13472894789</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4200</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:11:36');
INSERT INTO `admin_op_record` VALUES (85, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为022404员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:10:35');
INSERT INTO `admin_op_record` VALUES (84, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为022404员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>实习生</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:10:20');
INSERT INTO `admin_op_record` VALUES (83, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为012404员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>影</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12171190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>300</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7700</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-01</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012404</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>雷电·影</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12171190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>300</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7700</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-01</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:08:40');
INSERT INTO `admin_op_record` VALUES (82, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为012303员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>香菱</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19322904711</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5300</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>卯香菱</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19322904711</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5300</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:07:43');
INSERT INTO `admin_op_record` VALUES (81, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为012302员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5100</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>012302</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>管理层</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>枫原万叶</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17322297254</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>22</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5100</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:07:27');
INSERT INTO `admin_op_record` VALUES (80, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为022301员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022301</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>班尼特·卡塔库栗</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>13376629080</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>21</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:06:05');
INSERT INTO `admin_op_record` VALUES (78, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>菲谢尔·冯·露弗施洛斯·那菲多特</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>17432397554</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>6000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-12</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:04:41');
INSERT INTO `admin_op_record` VALUES (79, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为052303员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>莫娜</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12134444042</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>052303</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>运维部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>阿斯托洛吉斯·莫娜·梅姬斯图斯</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>普通员工</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12134444042</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>23</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>3000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2023-09-15</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-05 15:05:39');
INSERT INTO `admin_op_record` VALUES (89, '<div class=\"shortMsg\">012301用户通过了022403员工的离职申请</div>', '012301', '2024-03-08 17:07:58');
INSERT INTO `admin_op_record` VALUES (90, '<div class=\"shortMsg\">012302员工的离职申请已被012301用户驳回</div>', '012301', '2024-03-08 17:10:32');
INSERT INTO `admin_op_record` VALUES (91, '<div class=\"shortMsg\">012301用户通过了022404员工的离职申请</div>', '012301', '2024-03-08 17:15:24');
INSERT INTO `admin_op_record` VALUES (92, '\n                <div class=\"add\">\n                <div>\n                    <p>添加信息</p>\n                    <p>012301用户添加了一位员工</p>\n                </div>\n                \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>派蒙</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>15121190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-06</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-09 10:52:56');
INSERT INTO `admin_op_record` VALUES (93, '\n                <div class=\'update\'>\n                    <div>\n                        <p>修改信息请求</p>\n                        <p>012301用户修改员工号为022405员工的信息</p>\n                    </div>\n                \n        <div>\n            <p>修改前的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022405</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>派蒙</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>15121190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-06</span>\n            </p>\n        </div>\n        \n        <div>\n            <p>修改后的数据：</p>\n            <p>\n                <span>员工号：</span>\n                <span>022405</span>\n            </p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>派蒙</span>\n            </p>\n            <p>\n                <span>职位：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>15121190114</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>4000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-08</span>\n            </p>\n        </div>\n        </div>', '012301', '2024-03-09 10:53:06');
INSERT INTO `admin_op_record` VALUES (94, '<div class=\"shortMsg\">012301将派蒙设置为离职</div>', '012301', '2024-03-09 10:53:10');
INSERT INTO `admin_op_record` VALUES (95, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>012302用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>人力资源</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>空</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>15312250345</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>男</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>540</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>8000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-22</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-11 14:07:37');
INSERT INTO `admin_op_record` VALUES (96, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>012302用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>测试部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>派蒙</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>12322253454</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>6</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>7000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-21</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-11 14:32:23');
INSERT INTO `admin_op_record` VALUES (97, '\n            <div class=\"add\">\n            <div>\n                <p>添加信息</p>\n                <p>012302用户需要添加一位员工</p>\n            </div>\n            \n        <div>\n            <p>数据信息：</p>\n            <p>\n                <span>部门名称：</span>\n                <span>开发部</span>\n            </p>\n            <p>\n                <span>员工姓名：</span>\n                <span>星</span>\n            </p>\n            <p>\n                <span>工种：</span>\n                <span>经理</span>\n            </p>\n            <p>\n                <span>电话号码：</span>\n                <span>19273322110</span>\n            </p>\n            <p>\n                <span>性别：</span>\n                <span>女</span>\n            </p>\n            <p>\n                <span>年龄：</span>\n                <span>5</span>\n            </p>\n            <p>\n                <span>薪资：</span>\n                <span>5000</span>\n            </p>\n            <p>\n                <span>入职时间：</span>\n                <span>2024-03-13</span>\n            </p>\n        </div>\n        </div>', '012302', '2024-03-11 14:33:10');
INSERT INTO `admin_op_record` VALUES (98, '<div class=\"shortMsg\">012301将班尼特·卡塔库栗设置为离职</div>', '012301', '2024-03-11 22:38:53');

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
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_op_review
-- ----------------------------
INSERT INTO `admin_op_review` VALUES (4, '{\"oldData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012303\", \"departId\": \"01\", \"phoneNum\": 19322904711, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u9999\\u83f1\", \"sex\": \"\\u5973\", \"age\": 22, \"salary\": 5300, \"entryTime\": \"2023-12-12\"}}', 'updateRequest', '012302', '2024-02-18 09:55:56', '审核驳回');
INSERT INTO `admin_op_review` VALUES (3, '{\"oldData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2023-09-15\"}, \"newData\": {\"staffId\": \"012302\", \"departId\": \"01\", \"phoneNum\": 17322297254, \"job\": \"\\u666e\\u901a\\u5458\\u5de5\", \"staffName\": \"\\u4e07\\u53f6\", \"sex\": \"\\u7537\", \"age\": 22, \"salary\": 5100, \"entryTime\": \"2024-02-23\"}}', 'updateRequest', '012302', '2024-02-18 09:49:24', '待审核');
INSERT INTO `admin_op_review` VALUES (5, '{\"departId\": \"04\", \"phoneNum\": \"15312250345\", \"staffName\": \"\\u7a7a\", \"sex\": \"\\u7537\", \"age\": 540, \"job\": \"\\u7ecf\\u7406\", \"salary\": 8000, \"entryTime\": \"2024-03-22\"}', 'addRequest', '012302', '2024-03-11 14:07:37', '待审核');
INSERT INTO `admin_op_review` VALUES (6, '{\"departId\": \"03\", \"phoneNum\": \"12322253454\", \"staffName\": \"\\u6d3e\\u8499\", \"sex\": \"\\u5973\", \"age\": 6, \"job\": \"\\u7ecf\\u7406\", \"salary\": 7000, \"entryTime\": \"2024-03-21\"}', 'addRequest', '012302', '2024-03-11 14:32:23', '待审核');
INSERT INTO `admin_op_review` VALUES (7, '{\"departId\": \"02\", \"phoneNum\": \"19273322110\", \"staffName\": \"\\u661f\", \"sex\": \"\\u5973\", \"age\": 5, \"job\": \"\\u7ecf\\u7406\", \"salary\": 5000, \"entryTime\": \"2024-03-13\"}', 'addRequest', '012302', '2024-03-11 14:33:10', '待审核');

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
INSERT INTO `admin_user` VALUES ('012302', '01', '万叶', 'admin', '下线', 'home,staff,staffMsg,userAddStaff,userUpdateStaff,user,allotAuthority');

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
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------

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
INSERT INTO `resign` VALUES ('012406', '01', 123124, '2eqw', '男', 5, 6000, '普通员工', '2024-03-13', '2024-03-05');
INSERT INTO `resign` VALUES ('012405', '01', 123213213, 'qwe', '男', 3, 3000, '普通员工', '2024-02-28', '2024-03-01');
INSERT INTO `resign` VALUES ('022403', '02', 12132290117, '荧', '女', 600, 8000, '经理', '2024-03-06', '2024-03-08');
INSERT INTO `resign` VALUES ('022404', '02', 17432397554, '菲谢尔·冯·露弗施洛斯·那菲多特', '女', 23, 6000, '普通员工', '2024-03-12', '2024-03-08');
INSERT INTO `resign` VALUES ('022405', '02', 15121190114, '派蒙', '女', 6, 4000, '经理', '2024-03-08', '2024-03-09');
INSERT INTO `resign` VALUES ('022301', '02', 13376629080, '班尼特·卡塔库栗', '男', 21, 7000, '实习生', '2023-09-15', '2024-03-11');

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
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resignreview
-- ----------------------------
INSERT INTO `resignreview` VALUES (1, '022403', '不想干了', '2024-03-06 11:03:31', '审核通过');
INSERT INTO `resignreview` VALUES (2, '012302', '家里的矿需要我继承', '2024-02-25 11:07:01', '审核驳回');
INSERT INTO `resignreview` VALUES (3, '022404', '想打老板', '2024-03-16 17:14:12', '审核通过');

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
INSERT INTO `staff` VALUES ('022302', '02', 13376629080, '胡桃', '女', 16, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('032301', '03', 13232234167, '行秋', '男', 17, 5000, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('042301', '04', 15238199014, '钟离', '男', 1000, 7000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052301', '05', 11371238904, '夜阑', '女', 24, 8000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052302', '05', 11371238224, '纳西妲', '女', 500, 4000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052303', '05', 12134444042, '阿斯托洛吉斯·莫娜·梅姬斯图斯', '女', 23, 3000, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('052304', '05', 13472894789, '久岐忍', '女', 22, 4200, '实习生', '2023-09-15');
INSERT INTO `staff` VALUES ('012302', '01', 17322297254, '枫原万叶', '男', 22, 5100, '经理', '2023-09-15');
INSERT INTO `staff` VALUES ('012301', '01', 13172290114, '达达利亚', '男', 23, 9000, '经理', '2024-02-15');
INSERT INTO `staff` VALUES ('012303', '01', 19322904711, '卯香菱', '女', 22, 5300, '普通员工', '2023-09-15');
INSERT INTO `staff` VALUES ('012404', '01', 12171190114, '雷电·影', '女', 300, 7700, '经理', '2024-03-01');

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
