/*
Navicat MySQL Data Transfer

Source Server         : 本地MYSQL
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : bjtu_demo

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-09-14 19:33:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for data_cookbook
-- ----------------------------
DROP TABLE IF EXISTS `data_cookbook`;
CREATE TABLE `data_cookbook` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `week` int(1) NOT NULL DEFAULT '0' COMMENT '标识星期几',
  `breakfast` varchar(150) NOT NULL DEFAULT '' COMMENT '标识早餐',
  `lunch` varchar(150) NOT NULL DEFAULT '' COMMENT '标识午餐',
  `supper` varchar(150) NOT NULL DEFAULT '' COMMENT '标识晚餐',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜谱公示表';

-- ----------------------------
-- Records of data_cookbook
-- ----------------------------

-- ----------------------------
-- Table structure for data_order_food
-- ----------------------------
DROP TABLE IF EXISTS `data_order_food`;
CREATE TABLE `data_order_food` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orga_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联组织机构表机构ID',
  `depart_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联部门表ID',
  `salary_number` varchar(10) NOT NULL DEFAULT '' COMMENT '关联用户工资号码',
  `order_date` int(15) NOT NULL DEFAULT '0' COMMENT '用户订餐日期',
  `order_category` varchar(4) NOT NULL DEFAULT '' COMMENT '用来标识三餐类别',
  `order_money` int(2) NOT NULL DEFAULT '0' COMMENT '订餐所扣金额',
  `is_del` varchar(2) NOT NULL DEFAULT '否' COMMENT '此用户是否被删除',
  `remark` text COMMENT '备注信息',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订餐表';

-- ----------------------------
-- Records of data_order_food
-- ----------------------------

-- ----------------------------
-- Table structure for info_cookselect
-- ----------------------------
DROP TABLE IF EXISTS `info_cookselect`;
CREATE TABLE `info_cookselect` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(100) NOT NULL DEFAULT '' COMMENT '取时令蔬菜名',
  `month` varchar(30) NOT NULL DEFAULT '' COMMENT '取时令蔬菜对应月份',
  `cooking` varchar(10) NOT NULL DEFAULT '' COMMENT '区别烹饪手法:炒菜，汤菜，炖菜',
  `clitocybine` varchar(10) NOT NULL DEFAULT '' COMMENT '区别荤菜、素菜',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品选择表';

-- ----------------------------
-- Records of info_cookselect
-- ----------------------------

-- ----------------------------
-- Table structure for info_department
-- ----------------------------
DROP TABLE IF EXISTS `info_department`;
CREATE TABLE `info_department` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orga_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联组织机构表机构ID',
  `depart_name` varchar(50) NOT NULL DEFAULT '' COMMENT '各段各部门名称(重复)',
  `depart_id` int(5) NOT NULL DEFAULT '0' COMMENT '识别此部门的唯一id',
  `depart_category` varchar(10) NOT NULL DEFAULT '' COMMENT '识别此部门是科室还是车间',
  `is_del` varchar(2) DEFAULT '否',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `depart_id` (`depart_id`),
  KEY `orga_id` (`orga_id`),
  CONSTRAINT `depar_organ` FOREIGN KEY (`orga_id`) REFERENCES `info_organization` (`orga_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of info_department
-- ----------------------------
INSERT INTO `info_department` VALUES ('1', '1', '管控中心', '101', '科室', '否');
INSERT INTO `info_department` VALUES ('2', '1', '检测车间', '102', '车间', '否');
INSERT INTO `info_department` VALUES ('3', '1', '财务科', '103', '科室', '否');
INSERT INTO `info_department` VALUES ('4', '2', '管控中心', '201', '科室', '否');
INSERT INTO `info_department` VALUES ('5', '2', '检测车间', '202', '车间', '否');
INSERT INTO `info_department` VALUES ('6', '3', '办公室', '301', '科室', '否');
INSERT INTO `info_department` VALUES ('7', '4', '办公室', '401', '科室', '否');
INSERT INTO `info_department` VALUES ('8', '5', '办公室', '501', '科室', '否');

-- ----------------------------
-- Table structure for info_organization
-- ----------------------------
DROP TABLE IF EXISTS `info_organization`;
CREATE TABLE `info_organization` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orga_name` varchar(50) NOT NULL DEFAULT '' COMMENT '此机构的中文名称',
  `orga_id` int(5) NOT NULL DEFAULT '0' COMMENT '识别此机构的唯一id',
  `is_del` char(2) NOT NULL DEFAULT '否',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `orga_name` (`orga_name`),
  UNIQUE KEY `orga_id` (`orga_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='组织机构表';

-- ----------------------------
-- Records of info_organization
-- ----------------------------
INSERT INTO `info_organization` VALUES ('1', '锦州供电段', '1', '否');
INSERT INTO `info_organization` VALUES ('2', '通辽供电段', '2', '否');
INSERT INTO `info_organization` VALUES ('3', '丹东房产段', '3', '否');
INSERT INTO `info_organization` VALUES ('4', '长春房产段', '4', '否');
INSERT INTO `info_organization` VALUES ('5', '通化房产段', '5', '否');
INSERT INTO `info_organization` VALUES ('6', '测试站段', '6', '否');

-- ----------------------------
-- Table structure for info_user
-- ----------------------------
DROP TABLE IF EXISTS `info_user`;
CREATE TABLE `info_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orga_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联组织机构表机构ID',
  `depart_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联部门表ID',
  `login_name` varchar(16) NOT NULL DEFAULT '' COMMENT '用户登录名称',
  `login_pass` varchar(20) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户真实姓名',
  `gender` varchar(2) NOT NULL DEFAULT '' COMMENT '用户性别',
  `nation` varchar(10) NOT NULL DEFAULT '' COMMENT '用户民族',
  `politics_status` varchar(8) NOT NULL DEFAULT '' COMMENT '政治面貌',
  `duty` varchar(15) NOT NULL DEFAULT '' COMMENT '用户职务',
  `job_title` varchar(15) NOT NULL DEFAULT '' COMMENT '用户职称',
  `salary_number` varchar(10) NOT NULL DEFAULT '' COMMENT '用户工资号码',
  `tel` varchar(15) NOT NULL DEFAULT '' COMMENT '电话号码',
  `identity_num` varchar(20) NOT NULL DEFAULT '' COMMENT '身份证号',
  `lev` varchar(20) NOT NULL DEFAULT '' COMMENT '用户进入各模块的权限',
  `virtual_account` int(3) NOT NULL DEFAULT '0' COMMENT '用户虚拟帐户',
  `is_del` varchar(2) NOT NULL DEFAULT '否' COMMENT '此用户是否被删除',
  `remark` text,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `login_name` (`login_name`),
  UNIQUE KEY `salary_number` (`salary_number`),
  UNIQUE KEY `tel` (`tel`),
  UNIQUE KEY `identity_num` (`identity_num`),
  KEY `user_organ` (`orga_id`),
  KEY `user_depar` (`depart_id`),
  CONSTRAINT `user_depar` FOREIGN KEY (`depart_id`) REFERENCES `info_department` (`depart_id`),
  CONSTRAINT `user_organ` FOREIGN KEY (`orga_id`) REFERENCES `info_organization` (`orga_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of info_user
-- ----------------------------
INSERT INTO `info_user` VALUES ('1', '1', '101', 'wg', '1', '吴戈', '男', '汉', '党员', '工程师', '电力工', '0372683', '15804169171', '210702198309282052', '1', '100', '否', null);
INSERT INTO `info_user` VALUES ('2', '2', '202', 'lxp', 'lxp888', '李辛平', '男', '汉', '群众', '副工人', '接触网工', '0378888', '13888888888', '210702199108128888', '1', '98', '否', null);
INSERT INTO `info_user` VALUES ('3', '3', '301', 'ycq', 'ycq888', '衣长清', '男', '汉', '群众', '工程师', '维修工', '0003301', '1333013013011', '210602197502129999', '2', '50', '否', null);
INSERT INTO `info_user` VALUES ('4', '4', '401', 'xzc', 'xzc888', '徐志成', '男', '汉', '群众', '高级工程师', '维修工', '0004401', '13444440728', '211203197501112211', '3', '100', '否', null);
INSERT INTO `info_user` VALUES ('5', '5', '501', 'jww', 'jww888', '贾文文', '男', '满', '党员', '工长', '食堂管理员', '0005501', '13555550555', '210501198505515555', '2,3', '90', '否', null);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orga_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联组织机构表机构ID',
  `depart_id` int(5) NOT NULL DEFAULT '0' COMMENT '关联部门表ID',
  `salary_number` varchar(10) NOT NULL DEFAULT '' COMMENT '关联用户工资号码',
  `log_date` int(15) NOT NULL DEFAULT '0' COMMENT '日志产生日期',
  `log_category` varchar(10) NOT NULL DEFAULT '' COMMENT '存放日志类别 消费、退费、订餐、退餐',
  `log_content` text NOT NULL COMMENT '存放日志内容',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of log
-- ----------------------------
