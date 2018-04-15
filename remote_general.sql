/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : remote_general

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2016-05-21 18:54:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_case`
-- ----------------------------
DROP TABLE IF EXISTS `t_case`;
CREATE TABLE `t_case` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0' COMMENT '父级ID（0：父级）',
  `name` varchar(100) DEFAULT NULL COMMENT '案件名称',
  `status` tinyint(4) DEFAULT '0' COMMENT '0:启用 -100: 删除 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='案件类型';

-- ----------------------------
-- Records of t_case
-- ----------------------------
INSERT INTO `t_case` VALUES ('1', '0', '刑事犯罪', '0');
INSERT INTO `t_case` VALUES ('2', '0', '民事犯罪的', '0');
INSERT INTO `t_case` VALUES ('3', '1', '故意杀人大', '0');

-- ----------------------------
-- Table structure for `t_court`
-- ----------------------------
DROP TABLE IF EXISTS `t_court`;
CREATE TABLE `t_court` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `telephone` varchar(25) DEFAULT NULL COMMENT '电话号码',
  `is_enable` bit(1) DEFAULT b'0' COMMENT '0 启用 1 不启用',
  `level` tinyint(4) DEFAULT '2' COMMENT ' 0 初级人民法院  1 中级人民法院 2 高级人民法院',
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_id_level` (`id`,`level`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='高级人民法院';

-- ----------------------------
-- Records of t_court
-- ----------------------------
INSERT INTO `t_court` VALUES ('1', '高级人民法院', '高级人民法院', '15134212156', '', '2', '0');
INSERT INTO `t_court` VALUES ('61', '中级人民法院', '中级', '15134212156', '', '1', '1');
INSERT INTO `t_court` VALUES ('62', '初级人民', '初级', '15134212156', '', '0', '61');
INSERT INTO `t_court` VALUES ('63', '中级2', '中级2', '15134212156', '', '1', '1');

-- ----------------------------
-- Table structure for `t_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `court_id` int(11) DEFAULT '0' COMMENT '所属单位',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `telephone` varchar(25) DEFAULT NULL COMMENT '电话号码',
  `is_enable` bit(1) DEFAULT b'0' COMMENT '是否启用 0 启用 1不启用 ',
  `pid` int(11) DEFAULT '0' COMMENT '父级id',
  `level` int(11) DEFAULT NULL COMMENT '2 部门最高级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of t_department
-- ----------------------------

-- ----------------------------
-- Table structure for `t_dict_audio_format`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_audio_format`;
CREATE TABLE `t_dict_audio_format` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='音频格式（不可更改）';

-- ----------------------------
-- Records of t_dict_audio_format
-- ----------------------------
INSERT INTO `t_dict_audio_format` VALUES ('0', 'G.711 U');
INSERT INTO `t_dict_audio_format` VALUES ('2', 'G.721');
INSERT INTO `t_dict_audio_format` VALUES ('4', 'G.7231');
INSERT INTO `t_dict_audio_format` VALUES ('8', 'G.711 A');
INSERT INTO `t_dict_audio_format` VALUES ('9', 'G.722');
INSERT INTO `t_dict_audio_format` VALUES ('15', 'G.728');
INSERT INTO `t_dict_audio_format` VALUES ('18', 'G.729');
INSERT INTO `t_dict_audio_format` VALUES ('96', 'MP3');
INSERT INTO `t_dict_audio_format` VALUES ('98', 'G.722.1 Annex C Polycom Siren14');
INSERT INTO `t_dict_audio_format` VALUES ('99', 'G719 ');
INSERT INTO `t_dict_audio_format` VALUES ('102', 'MPEG4 AAC LC');
INSERT INTO `t_dict_audio_format` VALUES ('103', 'MPEG4 AAC LD');

-- ----------------------------
-- Table structure for `t_dict_auxiliary_code_rate`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_auxiliary_code_rate`;
CREATE TABLE `t_dict_auxiliary_code_rate` (
  `id` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='辅助码率（不可更改）';

-- ----------------------------
-- Records of t_dict_auxiliary_code_rate
-- ----------------------------
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('0', '0');
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('512', '512k');
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('1024', '1M');
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('2048', '2M');
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('4096', '4M');
INSERT INTO `t_dict_auxiliary_code_rate` VALUES ('6144', '6M');

-- ----------------------------
-- Table structure for `t_dict_code_rate`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_code_rate`;
CREATE TABLE `t_dict_code_rate` (
  `id` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='码率（不可更改）';

-- ----------------------------
-- Records of t_dict_code_rate
-- ----------------------------
INSERT INTO `t_dict_code_rate` VALUES ('1024', '1M');
INSERT INTO `t_dict_code_rate` VALUES ('2048', '2M');
INSERT INTO `t_dict_code_rate` VALUES ('4096', '4M');
INSERT INTO `t_dict_code_rate` VALUES ('6144', '6M');
INSERT INTO `t_dict_code_rate` VALUES ('8192', '8M');

-- ----------------------------
-- Table structure for `t_dict_frame_rate`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_frame_rate`;
CREATE TABLE `t_dict_frame_rate` (
  `id` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帧率（不可更改）';

-- ----------------------------
-- Records of t_dict_frame_rate
-- ----------------------------
INSERT INTO `t_dict_frame_rate` VALUES ('1', '1帧');
INSERT INTO `t_dict_frame_rate` VALUES ('2', '2帧');
INSERT INTO `t_dict_frame_rate` VALUES ('3', '3帧');
INSERT INTO `t_dict_frame_rate` VALUES ('4', '4帧');
INSERT INTO `t_dict_frame_rate` VALUES ('5', '5帧');
INSERT INTO `t_dict_frame_rate` VALUES ('6', '6帧');
INSERT INTO `t_dict_frame_rate` VALUES ('7', '7.5帧');
INSERT INTO `t_dict_frame_rate` VALUES ('10', '10帧');
INSERT INTO `t_dict_frame_rate` VALUES ('15', '15帧');
INSERT INTO `t_dict_frame_rate` VALUES ('20', '20帧');
INSERT INTO `t_dict_frame_rate` VALUES ('25', '25帧');
INSERT INTO `t_dict_frame_rate` VALUES ('30', '30帧');
INSERT INTO `t_dict_frame_rate` VALUES ('60', '60帧');

-- ----------------------------
-- Table structure for `t_dict_nation`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_nation`;
CREATE TABLE `t_dict_nation` (
  `id` tinyint(4) NOT NULL,
  `nation` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='名族';

-- ----------------------------
-- Records of t_dict_nation
-- ----------------------------
INSERT INTO `t_dict_nation` VALUES ('1', '汉族');
INSERT INTO `t_dict_nation` VALUES ('2', '蒙古族');
INSERT INTO `t_dict_nation` VALUES ('3', '回族');
INSERT INTO `t_dict_nation` VALUES ('4', '藏族');
INSERT INTO `t_dict_nation` VALUES ('5', '维吾尔族');
INSERT INTO `t_dict_nation` VALUES ('6', '苗族');
INSERT INTO `t_dict_nation` VALUES ('7', '彝族');
INSERT INTO `t_dict_nation` VALUES ('8', '壮族');
INSERT INTO `t_dict_nation` VALUES ('9', '布依族');
INSERT INTO `t_dict_nation` VALUES ('10', '朝鲜族');
INSERT INTO `t_dict_nation` VALUES ('11', '满族');
INSERT INTO `t_dict_nation` VALUES ('12', '侗族');
INSERT INTO `t_dict_nation` VALUES ('13', '瑶族');
INSERT INTO `t_dict_nation` VALUES ('14', '白族');
INSERT INTO `t_dict_nation` VALUES ('15', '土家族');
INSERT INTO `t_dict_nation` VALUES ('16', '哈尼族');
INSERT INTO `t_dict_nation` VALUES ('17', '哈萨克族');
INSERT INTO `t_dict_nation` VALUES ('18', '傣族');
INSERT INTO `t_dict_nation` VALUES ('19', '黎族');
INSERT INTO `t_dict_nation` VALUES ('20', '傈僳族');
INSERT INTO `t_dict_nation` VALUES ('21', '佤族');
INSERT INTO `t_dict_nation` VALUES ('22', '畲族');
INSERT INTO `t_dict_nation` VALUES ('23', '高山族');
INSERT INTO `t_dict_nation` VALUES ('24', '拉祜族');
INSERT INTO `t_dict_nation` VALUES ('25', '水族');
INSERT INTO `t_dict_nation` VALUES ('26', '东乡族');
INSERT INTO `t_dict_nation` VALUES ('27', '纳西族');
INSERT INTO `t_dict_nation` VALUES ('28', '景颇族');
INSERT INTO `t_dict_nation` VALUES ('29', '柯尔克孜族');
INSERT INTO `t_dict_nation` VALUES ('30', '土族');
INSERT INTO `t_dict_nation` VALUES ('31', '布朗族');
INSERT INTO `t_dict_nation` VALUES ('32', '撒拉族');
INSERT INTO `t_dict_nation` VALUES ('33', '阿昌族');
INSERT INTO `t_dict_nation` VALUES ('34', '乌孜别克族');
INSERT INTO `t_dict_nation` VALUES ('35', '鄂温克族');
INSERT INTO `t_dict_nation` VALUES ('36', '仫佬族');
INSERT INTO `t_dict_nation` VALUES ('37', '毛难族');
INSERT INTO `t_dict_nation` VALUES ('38', '普米族');
INSERT INTO `t_dict_nation` VALUES ('39', '怒族');
INSERT INTO `t_dict_nation` VALUES ('40', '崩龙族');
INSERT INTO `t_dict_nation` VALUES ('41', '保安族');
INSERT INTO `t_dict_nation` VALUES ('42', '塔塔尔族');
INSERT INTO `t_dict_nation` VALUES ('43', '鄂伦春族');
INSERT INTO `t_dict_nation` VALUES ('44', '赫哲族');
INSERT INTO `t_dict_nation` VALUES ('45', '珞巴族');
INSERT INTO `t_dict_nation` VALUES ('46', '达斡尔族');
INSERT INTO `t_dict_nation` VALUES ('47', '仡佬族');
INSERT INTO `t_dict_nation` VALUES ('48', '锡伯族');
INSERT INTO `t_dict_nation` VALUES ('49', '塔吉克族');
INSERT INTO `t_dict_nation` VALUES ('50', '俄罗斯族');
INSERT INTO `t_dict_nation` VALUES ('51', '裕固族');
INSERT INTO `t_dict_nation` VALUES ('52', '京族');
INSERT INTO `t_dict_nation` VALUES ('53', '独龙族');
INSERT INTO `t_dict_nation` VALUES ('54', '门巴族');
INSERT INTO `t_dict_nation` VALUES ('55', '基诺族');
INSERT INTO `t_dict_nation` VALUES ('56', '羌族');

-- ----------------------------
-- Table structure for `t_dict_port`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_port`;
CREATE TABLE `t_dict_port` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(4) DEFAULT '0' COMMENT '端口类型',
  `name` varchar(50) DEFAULT NULL COMMENT '端口名称',
  `port` tinyint(4) DEFAULT '0' COMMENT '端口号',
  `is_custom` bit(1) DEFAULT b'0' COMMENT '是否允许自定义',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='终端型号端口号（不可更改）';

-- ----------------------------
-- Records of t_dict_port
-- ----------------------------
INSERT INTO `t_dict_port` VALUES ('1', '1', 'InnerCamera', '0', '');
INSERT INTO `t_dict_port` VALUES ('2', '1', 'VGA', '1', '');
INSERT INTO `t_dict_port` VALUES ('3', '2', 'DVI', '0', '');
INSERT INTO `t_dict_port` VALUES ('4', '2', 'VGA', '2', '');
INSERT INTO `t_dict_port` VALUES ('5', '3', 'SDI', '2', '');
INSERT INTO `t_dict_port` VALUES ('6', '3', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('7', '3', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('8', '3', 'S端子', '4', '');
INSERT INTO `t_dict_port` VALUES ('9', '4', 'SDI', '2', '');
INSERT INTO `t_dict_port` VALUES ('10', '4', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('11', '4', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('12', '4', 'HDMI', '3', '');
INSERT INTO `t_dict_port` VALUES ('13', '4', 'S端子', '5', '');
INSERT INTO `t_dict_port` VALUES ('14', '5', 'SDI', '2', '');
INSERT INTO `t_dict_port` VALUES ('15', '5', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('16', '5', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('17', '5', 'HDMI', '3', '');
INSERT INTO `t_dict_port` VALUES ('18', '6', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('19', '6', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('20', '6', 'DVI3', '2', '');
INSERT INTO `t_dict_port` VALUES ('21', '6', 'HDMI', '3', '');
INSERT INTO `t_dict_port` VALUES ('22', '7', 'SDI1', '5', '');
INSERT INTO `t_dict_port` VALUES ('23', '7', 'SDI2', '6', '');
INSERT INTO `t_dict_port` VALUES ('24', '7', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('25', '7', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('26', '7', 'DVI3', '2', '');
INSERT INTO `t_dict_port` VALUES ('27', '7', 'HDMI', '3', '');
INSERT INTO `t_dict_port` VALUES ('28', '8', 'SDI', '5', '');
INSERT INTO `t_dict_port` VALUES ('29', '8', 'DVI1', '0', '');
INSERT INTO `t_dict_port` VALUES ('30', '8', 'DVI2', '1', '');
INSERT INTO `t_dict_port` VALUES ('31', '8', 'DVI3', '2', '');
INSERT INTO `t_dict_port` VALUES ('32', '8', 'HDMI', '3', '');

-- ----------------------------
-- Table structure for `t_dict_port_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_port_type`;
CREATE TABLE `t_dict_port_type` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '型号名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端型号（不可更改）';

-- ----------------------------
-- Records of t_dict_port_type
-- ----------------------------
INSERT INTO `t_dict_port_type` VALUES ('1', 'H600');
INSERT INTO `t_dict_port_type` VALUES ('2', 'H700');
INSERT INTO `t_dict_port_type` VALUES ('3', 'H800');
INSERT INTO `t_dict_port_type` VALUES ('4', 'H850');
INSERT INTO `t_dict_port_type` VALUES ('5', 'H850-TP');
INSERT INTO `t_dict_port_type` VALUES ('6', 'H900');
INSERT INTO `t_dict_port_type` VALUES ('7', 'H900-SDIC');
INSERT INTO `t_dict_port_type` VALUES ('8', 'H900-SDID');

-- ----------------------------
-- Table structure for `t_dict_resolution`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_resolution`;
CREATE TABLE `t_dict_resolution` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分辨率（不可更改）';

-- ----------------------------
-- Records of t_dict_resolution
-- ----------------------------
INSERT INTO `t_dict_resolution` VALUES ('3', 'CIF');
INSERT INTO `t_dict_resolution` VALUES ('31', '4CIF');
INSERT INTO `t_dict_resolution` VALUES ('32', '720P');
INSERT INTO `t_dict_resolution` VALUES ('35', '1080P/I');

-- ----------------------------
-- Table structure for `t_dict_video_format`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_video_format`;
CREATE TABLE `t_dict_video_format` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频格式（不可更改）';

-- ----------------------------
-- Records of t_dict_video_format
-- ----------------------------
INSERT INTO `t_dict_video_format` VALUES ('31', 'H.261');
INSERT INTO `t_dict_video_format` VALUES ('34', 'H.263');
INSERT INTO `t_dict_video_format` VALUES ('97', 'MPEG-4');
INSERT INTO `t_dict_video_format` VALUES ('106', 'H.264');

-- ----------------------------
-- Table structure for `t_dict_video_formats`
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_video_formats`;
CREATE TABLE `t_dict_video_formats` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='双流视频格式（不可更改）';

-- ----------------------------
-- Records of t_dict_video_formats
-- ----------------------------
INSERT INTO `t_dict_video_formats` VALUES ('1', '同主视频');
INSERT INTO `t_dict_video_formats` VALUES ('6', 'H.263+ | H.264');
INSERT INTO `t_dict_video_formats` VALUES ('101', 'H.263+');
INSERT INTO `t_dict_video_formats` VALUES ('106', 'H.264');

-- ----------------------------
-- Table structure for `t_mcu`
-- ----------------------------
DROP TABLE IF EXISTS `t_mcu`;
CREATE TABLE `t_mcu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `court_id` int(11) DEFAULT '0' COMMENT '法院id',
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip',
  `name` varchar(50) DEFAULT NULL COMMENT 'mcu别名',
  `video_id` bigint(11) DEFAULT '0' COMMENT '录像机id',
  `status` bigint(1) DEFAULT '0' COMMENT '0 : 使用 -100 ：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='mcu';

-- ----------------------------
-- Records of t_mcu
-- ----------------------------
INSERT INTO `t_mcu` VALUES ('1', '1', '172.16.40.123', 'fds', '3', '0');
INSERT INTO `t_mcu` VALUES ('2', '1', '172.16.40.167', '172MCU', '2', '0');
INSERT INTO `t_mcu` VALUES ('3', '1', '172.16.40.124', '111', '2', '0');

-- ----------------------------
-- Table structure for `t_node_supervisor`
-- ----------------------------
DROP TABLE IF EXISTS `t_node_supervisor`;
CREATE TABLE `t_node_supervisor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) DEFAULT '0' COMMENT '代办事项ID',
  `supervisor_id` int(11) DEFAULT '0' COMMENT '通知管理员ID',
  `is_read` bit(1) DEFAULT b'0' COMMENT '是否已读',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='通知管理员';

-- ----------------------------
-- Records of t_node_supervisor
-- ----------------------------
INSERT INTO `t_node_supervisor` VALUES ('7', '7', '22', '');
INSERT INTO `t_node_supervisor` VALUES ('8', '8', '22', '');
INSERT INTO `t_node_supervisor` VALUES ('9', '9', '22', '');
INSERT INTO `t_node_supervisor` VALUES ('10', '10', '1', '');
INSERT INTO `t_node_supervisor` VALUES ('11', '11', '1', '');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `show_time` datetime DEFAULT NULL COMMENT '显示时间',
  `type` tinyint(4) DEFAULT '0' COMMENT '0：通知；1：代办事项',
  `name` varchar(255) DEFAULT NULL COMMENT '发送人名称',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `action` varchar(255) DEFAULT NULL COMMENT '连接路由',
  `case_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='通知';

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('7', '2016-05-21 15:53:36', '2016-05-21 15:53:36', '1', '管理员', '已提交预约，请您进行处理。', '/visit/VisitDisAction/visit?currPage=1&words=&status=-101&pageSize=10', '1');
INSERT INTO `t_notice` VALUES ('8', '2016-05-21 15:54:41', '2016-05-21 15:54:41', '1', '管理员', '案件所有审批及接访室安排已完成，请您在2016-05-21 15:54准时参加接访。', '/visit/VisitMeetingAction/visit?currPage=1&words=&status=-101&pageSize=10', '1');
INSERT INTO `t_notice` VALUES ('9', '2016-05-21 15:54:41', '2016-05-21 15:54:41', '0', '管理员', 'admin已安排接访室', '/visit/VisitMeetingAction/visit?currPage=1&words=&status=-101&pageSize=10', '1');
INSERT INTO `t_notice` VALUES ('10', '2016-05-21 15:54:41', '2016-05-21 16:09:00', '0', '管理员', '您预约的接访会议将在2016-05-21 15:54开始，请及时开启。否则将在15-20分钟之内释放接访室资源。如需推迟，请重新安排相关接访室及时间并通知相关接访管理员。', '/visit/VisitMeetingAction/visit?currPage=1&words=&status=-101&pageSize=10', '1');
INSERT INTO `t_notice` VALUES ('11', '2016-05-21 15:54:41', '2016-05-21 17:54:00', '0', '管理员', '您预约的接访会议将在2016-05-21 15:54开始，请及时开启。否则将在15-20分钟之内释放接访室资源。如需推迟，请重新安排相关接访室及时间并通知相关接访管理员。', '/visit/VisitMeetingAction/visit?currPage=1&words=&status=-101&pageSize=10', '1');
INSERT INTO `t_notice` VALUES ('12', '2016-05-21 17:10:16', '2016-05-21 17:10:16', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('13', '2016-05-21 17:17:38', '2016-05-21 17:17:38', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('14', '2016-05-21 17:19:01', '2016-05-21 17:19:01', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('15', '2016-05-21 17:38:15', '2016-05-21 17:38:15', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('16', '2016-05-21 17:46:14', '2016-05-21 17:46:14', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('17', '2016-05-21 17:46:47', '2016-05-21 17:46:47', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('18', '2016-05-21 18:13:30', '2016-05-21 18:13:30', '0', '管理员', 'admin修改了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('19', '2016-05-21 18:13:40', '2016-05-21 18:13:40', '0', '管理员', 'admin修改了一个接访室，请知晓。', null, '0');
INSERT INTO `t_notice` VALUES ('20', '2016-05-21 18:42:36', '2016-05-21 18:42:36', '0', '管理员', 'admin添加了一个接访室，请知晓。', null, '0');

-- ----------------------------
-- Table structure for `t_notice_email_send`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice_email_send`;
CREATE TABLE `t_notice_email_send` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号ID',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` varchar(1000) DEFAULT NULL COMMENT '邮件内容',
  `is_try` bit(1) DEFAULT b'0' COMMENT '是否发送异常',
  PRIMARY KEY (`id`),
  KEY `index_ses_id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知邮件发送';

-- ----------------------------
-- Records of t_notice_email_send
-- ----------------------------
INSERT INTO `t_notice_email_send` VALUES ('2', null, null, null, null, '');

-- ----------------------------
-- Table structure for `t_option`
-- ----------------------------
DROP TABLE IF EXISTS `t_option`;
CREATE TABLE `t_option` (
  `id` tinyint(4) NOT NULL COMMENT '编号ID',
  `logo` varchar(50) DEFAULT '' COMMENT '平台logo',
  `name` varchar(50) DEFAULT NULL COMMENT '平台名称',
  `background` varchar(50) DEFAULT NULL COMMENT '背景',
  `versioninformation` varchar(50) DEFAULT NULL COMMENT '版本信息',
  `is_show` bit(1) DEFAULT b'0' COMMENT '是否显示版本信息1 显示 0隐藏',
  `email_name` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `email_password` varchar(50) DEFAULT NULL COMMENT '邮箱密码',
  `pop3_server` varchar(50) DEFAULT NULL COMMENT 'POP3服务器',
  `smtp_server` varchar(50) DEFAULT NULL COMMENT 'STMP服务器',
  PRIMARY KEY (`id`),
  KEY `index_so_id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统参数设置（必须存在ID为1的默认值）';

-- ----------------------------
-- Records of t_option
-- ----------------------------

-- ----------------------------
-- Table structure for `t_rights`
-- ----------------------------
DROP TABLE IF EXISTS `t_rights`;
CREATE TABLE `t_rights` (
  `id` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限（不可更改）';

-- ----------------------------
-- Records of t_rights
-- ----------------------------
INSERT INTO `t_rights` VALUES ('1', '首页');
INSERT INTO `t_rights` VALUES ('2', '数据管理');
INSERT INTO `t_rights` VALUES ('3', '预约登记');
INSERT INTO `t_rights` VALUES ('4', '预约处理');
INSERT INTO `t_rights` VALUES ('5', '审批');
INSERT INTO `t_rights` VALUES ('6', '接访会议');
INSERT INTO `t_rights` VALUES ('7', '系统配置');
INSERT INTO `t_rights` VALUES ('8', '接访室查询');
INSERT INTO `t_rights` VALUES ('9', '历史记录');
INSERT INTO `t_rights` VALUES ('10', '统计分析');

-- ----------------------------
-- Table structure for `t_rights_action`
-- ----------------------------
DROP TABLE IF EXISTS `t_rights_action`;
CREATE TABLE `t_rights_action` (
  `id` int(11) NOT NULL,
  `rights_id` tinyint(4) DEFAULT '0' COMMENT '权限ID',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `action` varchar(225) DEFAULT NULL COMMENT '路由名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限路由注册表';

-- ----------------------------
-- Records of t_rights_action
-- ----------------------------
INSERT INTO `t_rights_action` VALUES ('0', '8', '导出', 'supervisor.receptionroom.ReceptionRoomAction.export');
INSERT INTO `t_rights_action` VALUES ('1', '1', '首页', 'supervisor.home.HomeAction.home');
INSERT INTO `t_rights_action` VALUES ('2', '1', '个人信息', 'supervisor.home.HomeAction.updateUser');
INSERT INTO `t_rights_action` VALUES ('3', '1', '个人信息', 'supervisor.home.HomeAction.updatePassword');
INSERT INTO `t_rights_action` VALUES ('4', '1', '系统通知', 'supervisor.home.HomeAction.querynoticeinfo');
INSERT INTO `t_rights_action` VALUES ('5', '1', '删除系统通知', 'supervisor.home.HomeAction.delnoticeInfo');
INSERT INTO `t_rights_action` VALUES ('6', '1', '界面自定义', 'supervisor.home.HomeAction.updateCustomInterface');
INSERT INTO `t_rights_action` VALUES ('8', '1', '界面自定义修改', 'supervisor.option.OptionAction.updateCustomInterface');
INSERT INTO `t_rights_action` VALUES ('9', '1', '查看系统通知详情', 'supervisor.home.HomeAction.notificationDetails');
INSERT INTO `t_rights_action` VALUES ('10', '1', '批量更新通知状态', 'supervisor.home.HomeAction.updateNoticeStrtus');
INSERT INTO `t_rights_action` VALUES ('50', '1', '数据管理初始化', 'supervisor.home.HomeAction.dataManagement');
INSERT INTO `t_rights_action` VALUES ('51', '2', '导出', 'supervisor.home.HomeAction.homeExport');
INSERT INTO `t_rights_action` VALUES ('52', '2', '导入', 'supervisor.home.HomeAction.homeImport');
INSERT INTO `t_rights_action` VALUES ('101', '3', '预约登记列表', 'supervisor.visit.VisitRegAction.visit');
INSERT INTO `t_rights_action` VALUES ('102', '3', '提交/删除', 'supervisor.visit.VisitRegAction.submits');
INSERT INTO `t_rights_action` VALUES ('103', '3', '提交', 'supervisor.visit.VisitRegAction.submit');
INSERT INTO `t_rights_action` VALUES ('104', '3', '详情', 'supervisor.visit.VisitRegAction.detail');
INSERT INTO `t_rights_action` VALUES ('105', '3', '添加', 'supervisor.visit.VisitRegAction.add');
INSERT INTO `t_rights_action` VALUES ('106', '3', '保存', 'supervisor.visit.VisitRegAction.save');
INSERT INTO `t_rights_action` VALUES ('107', '3', '修改', 'supervisor.visit.VisitRegAction.update');
INSERT INTO `t_rights_action` VALUES ('108', '3', '指纹采集', 'supervisor.visit.VisitRegAction.fingerprint');
INSERT INTO `t_rights_action` VALUES ('109', '3', '采集/对比', 'supervisor.visit.VisitRegAction.collection');
INSERT INTO `t_rights_action` VALUES ('110', '3', '上传用户图像', 'supervisor.visit.VisitRegAction.uploadUserImg');
INSERT INTO `t_rights_action` VALUES ('111', '3', '案件类型', 'supervisor.tcase.CaseAction.caseTreeInit');
INSERT INTO `t_rights_action` VALUES ('200', '4', '接访处理列表', 'supervisor.visit.VisitDisAction.visit');
INSERT INTO `t_rights_action` VALUES ('201', '4', '批量撤销', 'supervisor.visit.VisitDisAction.revocations');
INSERT INTO `t_rights_action` VALUES ('202', '4', '撤销', 'supervisor.visit.VisitDisAction.revocation');
INSERT INTO `t_rights_action` VALUES ('203', '4', '详情', 'supervisor.visit.VisitDisAction.detail');
INSERT INTO `t_rights_action` VALUES ('204', '4', '本地接访', 'supervisor.visit.VisitDisAction.local');
INSERT INTO `t_rights_action` VALUES ('205', '4', '确定接访', 'supervisor.visit.VisitDisAction.doVisit');
INSERT INTO `t_rights_action` VALUES ('206', '4', '远程申请', 'supervisor.visit.VisitDisAction.apply');
INSERT INTO `t_rights_action` VALUES ('207', '4', '删除模板', 'supervisor.visit.VisitDisAction.delPar');
INSERT INTO `t_rights_action` VALUES ('208', '4', '设置模板', 'supervisor.visit.VisitDisAction.parameter');
INSERT INTO `t_rights_action` VALUES ('209', '4', '保存模板', 'supervisor.visit.VisitDisAction.saveParameter');
INSERT INTO `t_rights_action` VALUES ('210', '4', '选择会议室', 'supervisor.visit.VisitDisAction.roomInfo');
INSERT INTO `t_rights_action` VALUES ('211', '4', '查询中级法院', 'supervisor.visit.VisitDisAction.courtIntermediate');
INSERT INTO `t_rights_action` VALUES ('212', '4', '查询初级法院', 'supervisor.visit.VisitDisAction.courtPrimary');
INSERT INTO `t_rights_action` VALUES ('213', '4', '查询会议室', 'supervisor.visit.VisitDisAction.room');
INSERT INTO `t_rights_action` VALUES ('214', '4', '时刻表', 'supervisor.visit.VisitDisAction.timeTable');
INSERT INTO `t_rights_action` VALUES ('215', '4', '编辑', 'supervisor.visit.VisitDisAction.edit');
INSERT INTO `t_rights_action` VALUES ('216', '4', '确认编辑', 'supervisor.visit.VisitDisAction.doEdit');
INSERT INTO `t_rights_action` VALUES ('217', '4', '远程申请', 'supervisor.visit.VisitDisAction.remotelyApply');
INSERT INTO `t_rights_action` VALUES ('218', '4', '查询会议室', 'supervisor.visit.VisitDisAction.roomName');
INSERT INTO `t_rights_action` VALUES ('219', '4', '查询录像机', 'supervisor.visit.VisitDisAction.video');
INSERT INTO `t_rights_action` VALUES ('220', '4', '查询管理员', 'supervisor.visit.VisitDisAction.supName');
INSERT INTO `t_rights_action` VALUES ('221', '4', '确认申请', 'supervisor.visit.VisitDisAction.doApply');
INSERT INTO `t_rights_action` VALUES ('222', '4', '远程申请法院树菜单', 'supervisor.systemsetup.SystemSetupAction.queryAllCourtInfo');
INSERT INTO `t_rights_action` VALUES ('223', '4', '远程法院菜单切换', 'supervisor.visit.VisitDisAction.queryManagerByCourtIdAndRoleId');
INSERT INTO `t_rights_action` VALUES ('300', '5', '审核列表', 'supervisor.visit.VisitExamineAction.visit');
INSERT INTO `t_rights_action` VALUES ('301', '5', '批量撤销', 'supervisor.visit.VisitExamineAction.revocations');
INSERT INTO `t_rights_action` VALUES ('302', '5', '撤销', 'supervisor.visit.VisitExamineAction.revocation');
INSERT INTO `t_rights_action` VALUES ('303', '5', '详情', 'supervisor.visit.VisitExamineAction.detail');
INSERT INTO `t_rights_action` VALUES ('304', '5', '审批跳转', 'supervisor.visit.VisitExamineAction.examine');
INSERT INTO `t_rights_action` VALUES ('305', '5', '审批', 'supervisor.visit.VisitExamineAction.doExamine');
INSERT INTO `t_rights_action` VALUES ('306', '5', '通过法院ID和类型查询管理员列表项', 'supervisor.visit.VisitExamineAction.findSupByCourtId');
INSERT INTO `t_rights_action` VALUES ('307', '5', '通过省人民法院ID查询中级人民法院', 'supervisor.visit.VisitExamineAction.findCourtIntBySenid');
INSERT INTO `t_rights_action` VALUES ('308', '5', ' 通过中级民法院ID查询初级人民法院', 'supervisor.visit.VisitExamineAction.findCourtPriByIntId');
INSERT INTO `t_rights_action` VALUES ('400', '6', '接访会议', 'supervisor.visit.VisitMeetingAction.meeting');
INSERT INTO `t_rights_action` VALUES ('402', '6', '加载会议室', 'supervisor.visit.VisitMeetingAction.visitRoom');
INSERT INTO `t_rights_action` VALUES ('403', '6', '删除会议室', 'supervisor.visit.VisitMeetingAction.delVisitRoom');
INSERT INTO `t_rights_action` VALUES ('404', '6', '开启MCU录像', 'supervisor.visit.VisitMeetingAction.openMcuVideo');
INSERT INTO `t_rights_action` VALUES ('405', '6', '关闭MCU录像', 'supervisor.visit.VisitMeetingAction.closeMcuVideo');
INSERT INTO `t_rights_action` VALUES ('406', '6', '开始录像', 'supervisor.visit.VisitMeetingAction.openVideo');
INSERT INTO `t_rights_action` VALUES ('407', '6', '关闭录像', 'supervisor.visit.VisitMeetingAction.closeVideo');
INSERT INTO `t_rights_action` VALUES ('408', '6', '开启双流', 'supervisor.visit.VisitMeetingAction.openDualflow');
INSERT INTO `t_rights_action` VALUES ('409', '6', '选择视频源', 'supervisor.visit.VisitMeetingAction.selPort');
INSERT INTO `t_rights_action` VALUES ('410', '6', '切换视频资源', 'supervisor.visit.VisitMeetingAction.switchVideo');
INSERT INTO `t_rights_action` VALUES ('411', '6', '关闭双流', 'supervisor.visit.VisitMeetingAction.closeDualflow');
INSERT INTO `t_rights_action` VALUES ('412', '6', '接访会议列表', 'supervisor.visit.VisitMeetingAction.visit');
INSERT INTO `t_rights_action` VALUES ('413', '6', '批量撤销', 'supervisor.visit.VisitMeetingAction.revocations');
INSERT INTO `t_rights_action` VALUES ('414', '6', '撤销', 'supervisor.visit.VisitMeetingAction.revocation');
INSERT INTO `t_rights_action` VALUES ('415', '6', '详情', 'supervisor.visit.VisitMeetingAction.detail');
INSERT INTO `t_rights_action` VALUES ('416', '6', '开启录像选择录像机', 'supervisor.visit.VisitMeetingAction.video');
INSERT INTO `t_rights_action` VALUES ('417', '6', '选择临时会议室', 'supervisor.visit.VisitMeetingAction.roomInfo');
INSERT INTO `t_rights_action` VALUES ('418', '6', '常用语', 'supervisor.visit.VisitMeetingAction.languages');
INSERT INTO `t_rights_action` VALUES ('419', '6', '添加常用语', 'supervisor.visit.VisitMeetingAction.addLanguage');
INSERT INTO `t_rights_action` VALUES ('420', '6', '修改常用语', 'supervisor.visit.VisitMeetingAction.updateLanguage');
INSERT INTO `t_rights_action` VALUES ('422', '6', '监听硬件设备', 'supervisor.visit.VisitMeetingAction.monitorEquipment');
INSERT INTO `t_rights_action` VALUES ('423', '6', '停止会议', 'supervisor.visit.VisitMeetingAction.stopMeeting');
INSERT INTO `t_rights_action` VALUES ('424', '6', '保存/归档', 'supervisor.visit.VisitMeetingAction.save');
INSERT INTO `t_rights_action` VALUES ('425', '6', '会议详情', 'supervisor.visit.VisitMeetingAction.meetingDetail');
INSERT INTO `t_rights_action` VALUES ('426', '6', '添加临时会议室', 'supervisor.visit.VisitMeetingAction.addVisitRoom');
INSERT INTO `t_rights_action` VALUES ('427', '6', '手写板签名', 'supervisor.visit.VisitMeetingAction.handSign');
INSERT INTO `t_rights_action` VALUES ('428', '6', '确定手写板签名', 'supervisor.visit.VisitMeetingAction.doHandSign');
INSERT INTO `t_rights_action` VALUES ('429', '6', '指纹签名', 'supervisor.visit.VisitMeetingAction.fingSign');
INSERT INTO `t_rights_action` VALUES ('430', '6', '确定指纹签名', 'supervisor.visit.VisitMeetingAction.doFingSign');
INSERT INTO `t_rights_action` VALUES ('431', '6', '保存为word文档', 'supervisor.visit.VisitMeetingAction.export');
INSERT INTO `t_rights_action` VALUES ('432', '6', '保存附件资料', 'supervisor.visit.VisitDisAction.savaAttachment');
INSERT INTO `t_rights_action` VALUES ('433', '6', '多文件上传', 'supervisor.visit.VisitMeetingAction.uploadEnclosure');
INSERT INTO `t_rights_action` VALUES ('444', '6', '修改接访会议', 'supervisor.visit.VisitMeetingAction.editMeeting');
INSERT INTO `t_rights_action` VALUES ('500', '7', '查询部门', 'supervisor.systemsetup.SystemSetupAction.departmentUnit');
INSERT INTO `t_rights_action` VALUES ('501', '7', '查找单位详细信息', 'supervisor.courtsenior.CourtSeniorAction.queryCourtInformation');
INSERT INTO `t_rights_action` VALUES ('502', '7', '查找部门信息', 'supervisor.department.DepartmentAction.findDepartment');
INSERT INTO `t_rights_action` VALUES ('503', '7', '删除法院', 'supervisor.courtsenior.CourtSeniorAction.delCourt');
INSERT INTO `t_rights_action` VALUES ('504', '7', '添加法院初始化', 'supervisor.courtsenior.CourtSeniorAction.addCourtInit');
INSERT INTO `t_rights_action` VALUES ('505', '7', '添加法院', 'supervisor.courtsenior.CourtSeniorAction.addCourt');
INSERT INTO `t_rights_action` VALUES ('506', '7', '修改法院初始化', 'supervisor.courtsenior.CourtSeniorAction.updateCourtInit');
INSERT INTO `t_rights_action` VALUES ('507', '7', '修改法院', 'supervisor.courtsenior.CourtSeniorAction.updateCourt');
INSERT INTO `t_rights_action` VALUES ('508', '7', '查询部门', 'supervisor.systemsetup.SystemSetupAction.userConfiguration');
INSERT INTO `t_rights_action` VALUES ('509', '7', '用户列表', 'supervisor.home.HomeAction.queryUserConfiguration');
INSERT INTO `t_rights_action` VALUES ('510', '7', '删除用户', 'supervisor.home.HomeAction.delSupervisor');
INSERT INTO `t_rights_action` VALUES ('511', '7', '添加用户初始化', 'supervisor.home.HomeAction.addSupervisorInit');
INSERT INTO `t_rights_action` VALUES ('512', '7', '添加用户初始化', 'supervisor.home.HomeAction.addSupervisor');
INSERT INTO `t_rights_action` VALUES ('513', '7', '修改用户初始化', 'supervisor.home.HomeAction.updateSupervisorInit');
INSERT INTO `t_rights_action` VALUES ('514', '7', '修改用户', 'supervisor.home.HomeAction.updateSupervisor');
INSERT INTO `t_rights_action` VALUES ('515', '7', '接访室设置', 'supervisor.systemsetup.SystemSetupAction.room');
INSERT INTO `t_rights_action` VALUES ('517', '7', '系统设置查询接访室', 'supervisor.receptionroom.ReceptionRoomAction.querySystemSetupRoom');
INSERT INTO `t_rights_action` VALUES ('518', '7', '根据id删除接访室', 'supervisor.receptionroom.ReceptionRoomAction.delRoom');
INSERT INTO `t_rights_action` VALUES ('519', '7', '新增接访室初始化', 'supervisor.receptionroom.ReceptionRoomAction.addRoomInit');
INSERT INTO `t_rights_action` VALUES ('520', '7', '查询部门', 'supervisor.systemsetup.SystemSetupAction.mcuConfigure');
INSERT INTO `t_rights_action` VALUES ('521', '7', '查询mcu列表', 'supervisor.mcu.McuAction.queryMcu');
INSERT INTO `t_rights_action` VALUES ('522', '7', '查询mcu列表', 'supervisor.systemsetup.SystemSetupAction.caseConfigure');
INSERT INTO `t_rights_action` VALUES ('523', '7', '新增接访室', 'supervisor.receptionroom.ReceptionRoomAction.addRoom');
INSERT INTO `t_rights_action` VALUES ('524', '7', '修改接訪室初始化', 'supervisor.receptionroom.ReceptionRoomAction.updateRoomInit');
INSERT INTO `t_rights_action` VALUES ('525', '7', '修改接訪室', 'supervisor.receptionroom.ReceptionRoomAction.updateRoom');
INSERT INTO `t_rights_action` VALUES ('526', '7', '删除mcu', 'supervisor.mcu.McuAction.delMcu');
INSERT INTO `t_rights_action` VALUES ('527', '7', '新增mcu初始化', 'supervisor.mcu.McuAction.addMcuInit');
INSERT INTO `t_rights_action` VALUES ('528', '7', '新增mcu', 'supervisor.mcu.McuAction.addMcu');
INSERT INTO `t_rights_action` VALUES ('529', '7', '修改mcu初始化', 'supervisor.mcu.McuAction.updateMcuInit');
INSERT INTO `t_rights_action` VALUES ('530', '7', '修改mcu', 'supervisor.mcu.McuAction.updateMcu');
INSERT INTO `t_rights_action` VALUES ('531', '7', '案件类型详细信息', 'supervisor.tcase.CaseAction.queryCase');
INSERT INTO `t_rights_action` VALUES ('532', '7', '删除案件类型', 'supervisor.tcase.CaseAction.delCase');
INSERT INTO `t_rights_action` VALUES ('533', '7', '添加案件类型', 'supervisor.tcase.CaseAction.addCase');
INSERT INTO `t_rights_action` VALUES ('534', '7', '添加案件类型初始化', 'supervisor.tcase.CaseAction.addCaseInit');
INSERT INTO `t_rights_action` VALUES ('535', '7', '录播服务器', 'supervisor.systemsetup.SystemSetupAction.videoConfigure');
INSERT INTO `t_rights_action` VALUES ('536', '7', '查询录播服务器列表', 'supervisor.videoCourt.VideoCourtAction.queryVideoCourt');
INSERT INTO `t_rights_action` VALUES ('537', '7', '删除录播服务器', 'supervisor.videoCourt.VideoCourtAction.delVideo');
INSERT INTO `t_rights_action` VALUES ('538', '7', '添加录播服务器初始化', 'supervisor.videoCourt.VideoCourtAction.addVideoInit');
INSERT INTO `t_rights_action` VALUES ('539', '7', '添加录播服务器', 'supervisor.videoCourt.VideoCourtAction.addVideo');
INSERT INTO `t_rights_action` VALUES ('540', '7', '修改录播服务器初始化', 'supervisor.videoCourt.VideoCourtAction.updateVideoInit');
INSERT INTO `t_rights_action` VALUES ('541', '7', '修改录播服务器', 'supervisor.videoCourt.VideoCourtAction.updateVideo');
INSERT INTO `t_rights_action` VALUES ('542', '7', '系统设置查询', 'supervisor.option.OptionAction.queryOption');
INSERT INTO `t_rights_action` VALUES ('543', '7', '系统设置修改', 'supervisor.option.OptionAction.updateOption');
INSERT INTO `t_rights_action` VALUES ('544', '7', '查询部门', 'supervisor.department.DepartmentAction.queryDepartment');
INSERT INTO `t_rights_action` VALUES ('545', '7', '删除部门', 'supervisor.department.DepartmentAction.delDepartment');
INSERT INTO `t_rights_action` VALUES ('546', '7', '添加部门初始化', 'supervisor.department.DepartmentAction.addDepartmentInit');
INSERT INTO `t_rights_action` VALUES ('547', '7', '添加部门', 'supervisor.department.DepartmentAction.addDepartment');
INSERT INTO `t_rights_action` VALUES ('548', '7', '修改部门初始化', 'supervisor.department.DepartmentAction.updateDeartmentInit');
INSERT INTO `t_rights_action` VALUES ('549', '7', '修改部门', 'supervisor.department.DepartmentAction.updateDeartment');
INSERT INTO `t_rights_action` VALUES ('550', '7', '部门查询', 'supervisor.department.DepartmentAction.queryDepartmentUl');
INSERT INTO `t_rights_action` VALUES ('551', '7', '案件类型下面的案件类型', 'supervisor.tcase.CaseAction.FindCase');
INSERT INTO `t_rights_action` VALUES ('552', '7', '修改案件类型初始化', 'supervisor.tcase.CaseAction.updateCaseInit');
INSERT INTO `t_rights_action` VALUES ('553', '7', '修改案件类型', 'supervisor.tcase.CaseAction.updateCase');
INSERT INTO `t_rights_action` VALUES ('600', '8', '接访室查询', 'supervisor.receptionroom.ReceptionRoomAction.queryCourtSenior');
INSERT INTO `t_rights_action` VALUES ('601', '8', '查询中级人民法院', 'supervisor.receptionroom.ReceptionRoomAction.queryCourtIntermediate');
INSERT INTO `t_rights_action` VALUES ('602', '8', '查询初级人民法院', 'supervisor.receptionroom.ReceptionRoomAction.queryCourtPrimary');
INSERT INTO `t_rights_action` VALUES ('603', '8', '查询接访会议室', 'supervisor.receptionroom.ReceptionRoomAction.queryRoom');
INSERT INTO `t_rights_action` VALUES ('604', '8', '接访会议详情', 'supervisor.receptionroom.ReceptionRoomAction.roomDetails ');
INSERT INTO `t_rights_action` VALUES ('605', '8', '接访室实时查询', 'supervisor.visit.VisitDisAction.actualRoom');
INSERT INTO `t_rights_action` VALUES ('606', '8', '接访室重新安排', 'supervisor.visit.VisitMeetingAction.roomRearrange');
INSERT INTO `t_rights_action` VALUES ('607', '8', '接访会议修改', 'supervisor.visit.VisitMeetingAction.doEdit');
INSERT INTO `t_rights_action` VALUES ('700', '9', '查询历史记录', 'supervisor.history.HistoryAction.historyRecord');
INSERT INTO `t_rights_action` VALUES ('701', '9', '删除历史记录', 'supervisor.history.HistoryAction.updateVisit');
INSERT INTO `t_rights_action` VALUES ('702', '9', '查看附件资料', 'supervisor.history.HistoryAction.queryAppendix');
INSERT INTO `t_rights_action` VALUES ('703', '9', '删除附件资料', 'supervisor.history.HistoryAction.delAttachment');
INSERT INTO `t_rights_action` VALUES ('704', '9', '详情', 'supervisor.history.HistoryAction.detailsMeeting');
INSERT INTO `t_rights_action` VALUES ('705', '9', '接访笔录', 'supervisor.history.HistoryAction.visitDetail');
INSERT INTO `t_rights_action` VALUES ('706', '9', '信息补全', 'supervisor.history.HistoryAction.feedbac');
INSERT INTO `t_rights_action` VALUES ('707', '9', '送阅签', 'supervisor.history.HistoryAction.readLetter');
INSERT INTO `t_rights_action` VALUES ('708', '9', '保存阅签', 'supervisor.history.HistoryAction.doReadLetter');
INSERT INTO `t_rights_action` VALUES ('709', '9', '文件刻录', 'supervisor.history.HistoryAction.recordingDocuments');
INSERT INTO `t_rights_action` VALUES ('710', '9', '查询录像文件', 'supervisor.history.HistoryAction.queryVideoFile');
INSERT INTO `t_rights_action` VALUES ('711', '9', '文件刻录删除', 'supervisor.history.HistoryAction.delDocumentsOrVideoFile');
INSERT INTO `t_rights_action` VALUES ('712', '9', '播放', 'supervisor.history.HistoryAction.queryVisitVideoFile');
INSERT INTO `t_rights_action` VALUES ('713', '9', '删除录像文件', 'supervisor.history.HistoryAction.delVideoFile');
INSERT INTO `t_rights_action` VALUES ('714', '9', '下载视频文件', 'supervisor.history.HistoryAction.downloadVideoFile\r\n');
INSERT INTO `t_rights_action` VALUES ('715', '9', '文件刻录', 'supervisor.history.HistoryAction.burnFile');
INSERT INTO `t_rights_action` VALUES ('716', '9', '文件刻录', 'supervisor.history.HistoryAction.checkBurnRunrate');
INSERT INTO `t_rights_action` VALUES ('717', '9', '信息补录', 'supervisor.history.HistoryAction.feedback');
INSERT INTO `t_rights_action` VALUES ('800', '10', '统计分析首页', 'supervisor.statisticalanalysis.StatisticalAnalysisAction.statisticalAnalysisHomePage');
INSERT INTO `t_rights_action` VALUES ('801', '10', '搜索', 'supervisor.statisticalanalysis.StatisticalAnalysisAction.queryStatisticalAnalysis');
INSERT INTO `t_rights_action` VALUES ('802', '10', '查询接访管理员', 'supervisor.statisticalanalysis.StatisticalAnalysisAction.queryToSupevisor');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色（不可更改）';

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '配置管理员');
INSERT INTO `t_role` VALUES ('2', '预约管理员');
INSERT INTO `t_role` VALUES ('3', '审批管理员');
INSERT INTO `t_role` VALUES ('4', '接访管理员');

-- ----------------------------
-- Table structure for `t_role_of_rights`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_of_rights`;
CREATE TABLE `t_role_of_rights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT '0' COMMENT '角色id',
  `rights_id` int(11) DEFAULT '0' COMMENT '权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色的权限（不可更改）';

-- ----------------------------
-- Records of t_role_of_rights
-- ----------------------------
INSERT INTO `t_role_of_rights` VALUES ('1', '1', '1');
INSERT INTO `t_role_of_rights` VALUES ('2', '1', '2');
INSERT INTO `t_role_of_rights` VALUES ('3', '1', '7');
INSERT INTO `t_role_of_rights` VALUES ('4', '2', '1');
INSERT INTO `t_role_of_rights` VALUES ('5', '2', '3');
INSERT INTO `t_role_of_rights` VALUES ('6', '3', '1');
INSERT INTO `t_role_of_rights` VALUES ('7', '3', '5');
INSERT INTO `t_role_of_rights` VALUES ('8', '3', '9');
INSERT INTO `t_role_of_rights` VALUES ('9', '4', '1');
INSERT INTO `t_role_of_rights` VALUES ('10', '4', '4');
INSERT INTO `t_role_of_rights` VALUES ('11', '4', '6');
INSERT INTO `t_role_of_rights` VALUES ('12', '4', '9');
INSERT INTO `t_role_of_rights` VALUES ('13', '4', '10');

-- ----------------------------
-- Table structure for `t_room`
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '会议室名称',
  `court_id` tinyint(4) DEFAULT '0' COMMENT '法院id',
  `ip` varchar(50) DEFAULT NULL COMMENT '终端IP',
  `typeName` varchar(50) DEFAULT NULL COMMENT '型号名称',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态；0：使用中；-100：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='接访室';

-- ----------------------------
-- Records of t_room
-- ----------------------------
INSERT INTO `t_room` VALUES ('19', '120接访室', '61', '172.16.40.120', 'H850', '0');
INSERT INTO `t_room` VALUES ('20', '140接访室', '1', '172.16.40.140', 'H600', '0');
INSERT INTO `t_room` VALUES ('21', '149接访室', '7', '172.16.40.149', 'H600', '0');
INSERT INTO `t_room` VALUES ('22', '150接访室', '1', '172.16.40.150', 'H600', '0');
INSERT INTO `t_room` VALUES ('50', 'afsd', '1', '172.16.40.121', 'H600', '0');

-- ----------------------------
-- Table structure for `t_room_port`
-- ----------------------------
DROP TABLE IF EXISTS `t_room_port`;
CREATE TABLE `t_room_port` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) DEFAULT '0' COMMENT '会议室ID',
  `port_id` tinyint(4) DEFAULT '0' COMMENT '端口ID',
  `name` varchar(50) DEFAULT NULL COMMENT '别名',
  `status` tinyint(4) DEFAULT '0' COMMENT '0:主视频;1:辅视频;-1:无视频',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='终端对应的端口';

-- ----------------------------
-- Records of t_room_port
-- ----------------------------
INSERT INTO `t_room_port` VALUES ('15', '5', '9', '    ', '0');
INSERT INTO `t_room_port` VALUES ('16', '5', '10', '     ', '0');
INSERT INTO `t_room_port` VALUES ('17', '5', '11', '     ', '0');
INSERT INTO `t_room_port` VALUES ('18', '5', '12', '    ', '0');
INSERT INTO `t_room_port` VALUES ('19', '5', '13', ' ', '0');
INSERT INTO `t_room_port` VALUES ('20', '6', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('21', '6', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('22', '7', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('23', '7', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('24', '8', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('25', '8', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('26', '9', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('27', '9', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('28', '10', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('29', '10', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('30', '14', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('31', '14', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('32', '15', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('33', '15', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('34', '16', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('35', '16', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('36', '18', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('37', '18', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('38', '19', '9', '    ', '0');
INSERT INTO `t_room_port` VALUES ('39', '19', '10', '     ', '0');
INSERT INTO `t_room_port` VALUES ('40', '19', '11', '     ', '0');
INSERT INTO `t_room_port` VALUES ('41', '19', '12', '    ', '-1');
INSERT INTO `t_room_port` VALUES ('42', '19', '13', ' ', '-1');
INSERT INTO `t_room_port` VALUES ('43', '20', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('44', '20', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('45', '21', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('46', '21', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('47', '22', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('48', '22', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('49', '23', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('50', '23', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('51', '25', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('52', '25', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('53', '26', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('54', '26', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('55', '33', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('56', '33', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('57', '35', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('58', '35', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('59', '36', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('60', '36', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('61', '40', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('62', '40', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('63', '44', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('64', '44', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('65', '45', '1', '    ', '0');
INSERT INTO `t_room_port` VALUES ('66', '45', '2', ' ', '1');
INSERT INTO `t_room_port` VALUES ('67', '50', '1', 'fsad    ', '0');
INSERT INTO `t_room_port` VALUES ('68', '50', '2', ' ', '1');

-- ----------------------------
-- Table structure for `t_supervisor`
-- ----------------------------
DROP TABLE IF EXISTS `t_supervisor`;
CREATE TABLE `t_supervisor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '注册时间',
  `name` varchar(20) DEFAULT NULL COMMENT '登陆名',
  `password` varchar(50) DEFAULT NULL COMMENT '用户密码',
  `sex` bit(1) DEFAULT b'0' COMMENT '性别 0 ：女  1：男',
  `age` tinyint(4) DEFAULT '0' COMMENT '年龄',
  `real_nname` varchar(40) DEFAULT NULL COMMENT '真实姓名',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `id_number` varchar(20) DEFAULT NULL COMMENT '身份证号码',
  `address` varchar(60) DEFAULT NULL COMMENT '家庭地址',
  `nation_id` tinyint(4) DEFAULT '0' COMMENT '民族',
  `photo` varchar(50) DEFAULT NULL COMMENT '头像',
  `work_model` varchar(25) DEFAULT NULL COMMENT '手机号码',
  `work_address` varchar(60) DEFAULT NULL COMMENT '工作地址',
  `work_email` varchar(100) DEFAULT NULL COMMENT '工作邮箱',
  `court_id` int(11) DEFAULT '0' COMMENT '所属单位',
  `subordinate_department` varchar(100) DEFAULT NULL COMMENT '所属部门',
  `deartment_id` int(11) DEFAULT '0' COMMENT '部门id',
  `position` varchar(100) DEFAULT NULL COMMENT '职务',
  `office_telephone` varchar(20) DEFAULT NULL COMMENT '办公电话',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '上次登录ip',
  `login_count` int(11) DEFAULT NULL COMMENT '登陆次数',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登陆时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(4) DEFAULT '0' COMMENT '0:启用 -1:不启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of t_supervisor
-- ----------------------------
INSERT INTO `t_supervisor` VALUES ('1', '2016-01-11 11:09:39', 'admin', '6917157811410f82f0c8be73e78f4b56', '', '22', '管理员', '2016-01-12 11:10:18', '530113197710277438', '上海市虹漕路', '1', '8d07f0a4-26ec-4ee3-9ab0-c9879b412f58.jpg', '15134212111', '深圳', '123@qq.com', '1', '执法部', '1', '老板', '0755-7518834', '192.168.1.102', '1', '2016-01-11 11:11:05', 'admin', '0');
INSERT INTO `t_supervisor` VALUES ('22', '2016-05-18 10:08:00', 'gfjf', '6917157811410f82f0c8be73e78f4b56', '', '0', '高法接访', null, null, null, '0', '', '15134212156', null, '123@qq.com', '1', '执法部', '47', null, null, null, '0', null, null, '0');
INSERT INTO `t_supervisor` VALUES ('23', '2016-05-18 10:09:00', 'zfyy', '6917157811410f82f0c8be73e78f4b56', '', '0', '中法预约', null, null, null, '0', '', '15134212156', null, '123@qq.com', '61', '', null, null, null, null, '0', null, null, '0');
INSERT INTO `t_supervisor` VALUES ('24', '2016-05-18 10:10:00', 'zfjf', '6917157811410f82f0c8be73e78f4b56', '', '0', '中法接访', null, null, null, '0', '', '15134212156', null, '123@qq.com', '61', '财务部', '48', null, null, null, '0', null, null, '0');
INSERT INTO `t_supervisor` VALUES ('25', '2016-05-20 11:14:00', 'gfsp', '6917157811410f82f0c8be73e78f4b56', '', '0', '高发审批', null, null, null, '0', '', '15134212156', null, '123@qq.com', '1', null, '47', null, null, null, '0', null, null, '0');

-- ----------------------------
-- Table structure for `t_supervisor_language`
-- ----------------------------
DROP TABLE IF EXISTS `t_supervisor_language`;
CREATE TABLE `t_supervisor_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supervisor_id` int(11) DEFAULT '0' COMMENT '管理员ID',
  `content` varchar(225) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理员常用语';

-- ----------------------------
-- Records of t_supervisor_language
-- ----------------------------
INSERT INTO `t_supervisor_language` VALUES ('10', '1', 'how old are you ?');
INSERT INTO `t_supervisor_language` VALUES ('11', '1', '你好啊！');

-- ----------------------------
-- Table structure for `t_supervisor_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_supervisor_role`;
CREATE TABLE `t_supervisor_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supervisor_id` int(11) DEFAULT '-1' COMMENT '管理员id',
  `role_id` int(11) DEFAULT '-1' COMMENT '权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='管理员对应角色';

-- ----------------------------
-- Records of t_supervisor_role
-- ----------------------------
INSERT INTO `t_supervisor_role` VALUES ('30', '22', '4');
INSERT INTO `t_supervisor_role` VALUES ('31', '23', '2');
INSERT INTO `t_supervisor_role` VALUES ('32', '24', '4');
INSERT INTO `t_supervisor_role` VALUES ('33', '25', '3');

-- ----------------------------
-- Table structure for `t_video`
-- ----------------------------
DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `court_id` tinyint(4) DEFAULT '0' COMMENT '法院id',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `model` varchar(50) DEFAULT NULL COMMENT '录像机型号',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态；0：使用中；-100：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='录播机';

-- ----------------------------
-- Records of t_video
-- ----------------------------
INSERT INTO `t_video` VALUES ('1', '1', '160录像机', '172.16.40.160', '			s	', 'VRS2000B-S', '0');
INSERT INTO `t_video` VALUES ('2', '1', 'm录像机', '172.16.40.161', '				m', 'VRS2000B-M', '0');
INSERT INTO `t_video` VALUES ('3', '1', '中级m录像机', '172.16.40.121', '中级', 'VRS2000B-M', '0');
INSERT INTO `t_video` VALUES ('4', '1', '发大水1', '172.12.12.13', 'fdsa fdsa ', 'VRS2000B-M', '0');
INSERT INTO `t_video` VALUES ('5', '1', 'fs ', '172.12.1.1', 'fds', 'VRS2000B-M', '0');
INSERT INTO `t_video` VALUES ('6', '1', 'vfssfd', '172.16.40.1', 'fsda', 'VRS2000B-M', '0');

-- ----------------------------
-- Table structure for `t_video_of_room_of_mcu`
-- ----------------------------
DROP TABLE IF EXISTS `t_video_of_room_of_mcu`;
CREATE TABLE `t_video_of_room_of_mcu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mcu_id` int(11) DEFAULT '0' COMMENT 'mcuid',
  `room_id` int(11) DEFAULT '0' COMMENT '终端',
  `video_id` int(11) DEFAULT '0' COMMENT '录像机id',
  `is_formal` bit(1) DEFAULT b'0' COMMENT '0: 正式  1:临时',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='录像机MCU终端绑定';

-- ----------------------------
-- Records of t_video_of_room_of_mcu
-- ----------------------------

-- ----------------------------
-- Table structure for `t_video_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `t_video_parameter`;
CREATE TABLE `t_video_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '模板名称',
  `is_default` bit(1) DEFAULT b'0' COMMENT '是否默认模板',
  `video_format_id` int(11) DEFAULT '0' COMMENT '视频格式ID',
  `resolution_id` int(11) DEFAULT '0' COMMENT '分辨率ID',
  `frame_rate_id` int(11) DEFAULT '0' COMMENT '帧率ID',
  `audio_format_id` int(11) DEFAULT '0' COMMENT '音频格式ID',
  `code_rate_id` int(11) DEFAULT '0' COMMENT '码率ID',
  `is_both_conference` bit(1) DEFAULT b'0' COMMENT '是否开启双速会议',
  `auxiliary_code_rate_id` int(11) DEFAULT '0' COMMENT '辅助码率',
  `is_hp` bit(1) DEFAULT b'0' COMMENT '是否是HP',
  `d_video_format_id` int(11) DEFAULT '0' COMMENT '双流视频格式ID',
  `d_resolution_id` int(11) DEFAULT '0' COMMENT '双流分辨率',
  `d_max_frame_rate_id` int(11) DEFAULT '0' COMMENT '双流最大帧率',
  `d_video_quality` int(11) DEFAULT '0' COMMENT '双流视频质量0：速度优先，1：质量优先',
  `d_code_rate_id` int(11) DEFAULT '0' COMMENT '双流视频码率 \r\n0:0%，\r\n1:10%，\r\n2:20%，\r\n3:30%，\r\n4:40%，\r\n5:50%，\r\n6:60%，\r\n7:70%，\r\n8:80%，\r\n9:90%，\r\n10:100%',
  `d_spokesman` int(11) DEFAULT '0' COMMENT '发言人接收\r\n0:自己图像',
  `d_is_take_audio` bit(1) DEFAULT b'1' COMMENT '是否带音频',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='录像参数（会议模板，必须存在ID为1的默认值）';

-- ----------------------------
-- Records of t_video_parameter
-- ----------------------------
INSERT INTO `t_video_parameter` VALUES ('4', '默认模版', '', '106', '32', '20', '96', '1024', '', '0', '', '1', '32', '25', '1', '60', '0', '');
INSERT INTO `t_video_parameter` VALUES ('5', '新模板1-1', '', '31', '3', '1', '0', '1024', '', '0', '', '1', '3', '1', '0', '0', '0', '');

-- ----------------------------
-- Table structure for `t_visit`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit`;
CREATE TABLE `t_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '状态改变时间',
  `supervisor_id` int(11) DEFAULT '0' COMMENT '预约管理员ID',
  `to_supervisor_id` int(11) DEFAULT '0' COMMENT '接访管理员ID',
  `case_id` int(11) DEFAULT '0' COMMENT '案件类型ID',
  `visit_amount` smallint(6) DEFAULT '0' COMMENT '上访人数',
  `rep_amount` smallint(6) DEFAULT '0' COMMENT '代表（representative）人数',
  `involve_amount` smallint(6) DEFAULT '0' COMMENT '涉及人数',
  `incident_time` datetime DEFAULT NULL COMMENT '事发时间',
  `incident_place` varchar(60) DEFAULT NULL COMMENT '事发地点',
  `incident_describe` varchar(255) DEFAULT NULL COMMENT '事件描述',
  `visit_time` datetime DEFAULT NULL COMMENT '期望接访时间',
  `visit_place` varchar(60) DEFAULT NULL COMMENT '期望接访地点',
  `is_public_visit` bit(1) DEFAULT b'0' COMMENT '是否公网预约',
  `title` varchar(50) DEFAULT NULL COMMENT '上访主题',
  `purpose_id` tinyint(4) DEFAULT '0' COMMENT '接访目的',
  `court_id` int(11) DEFAULT '0' COMMENT '受理法院ID（公网预约）',
  `is_public` bit(1) DEFAULT b'0' COMMENT '是否公开',
  `model` tinyint(4) DEFAULT '0' COMMENT '接访模式\r\n0：本地单点\r\n1：本地点对点\r\n2：远程点对点\r\n3：远程多点',
  `is_handle` bit(1) DEFAULT b'0' COMMENT '是否直接处理',
  `handle_info` varchar(255) DEFAULT NULL COMMENT '直接处理意见',
  `is_record` bit(1) DEFAULT b'0' COMMENT '是否开启电子笔录 0：关闭，1：开启',
  `is_open_mcu` bit(1) DEFAULT b'0' COMMENT '是否开启muc录像 0：不开启；1：开启',
  `video_par_id` int(11) DEFAULT '0' COMMENT '会议模板ID',
  `start_time` datetime DEFAULT NULL COMMENT '开始接访时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束接访时间',
  `is_open_record` bit(1) DEFAULT b'0' COMMENT '是否自动刻录标示 0：关闭，1：开启',
  `record_door` tinyint(4) DEFAULT '0' COMMENT '自动刻录舱门',
  `record_name` varchar(50) DEFAULT NULL COMMENT '记录人名称',
  `record_detail` text COMMENT '笔录内容',
  `autograph_time` varchar(100) DEFAULT NULL COMMENT '签名时间（电子笔录）',
  `revocation` varchar(255) DEFAULT NULL COMMENT '撤销原因',
  `feedback` varchar(255) DEFAULT NULL COMMENT '反馈信息（信息补充）',
  `examine_sup_id` int(11) DEFAULT '0' COMMENT '下一审批管理员ID（冗余）',
  `name` varchar(20) DEFAULT NULL COMMENT '代表人用户名冗余',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态：\r\n0:预约，\r\n1:提交，\r\n2:本地接访，\r\n3:远程接访，\r\n4:远程申请，\r\n41.审批通过，续审批，\r\n42:审批通过，\r\n5:开启接访，\r\n6:结束接访，\r\n7:归档，\r\n8:查看记录，\r\n-1:被驳回，\r\n-100 删除\r\n-4:审批不通过',
  `meeting_start` datetime DEFAULT NULL,
  `meeting_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='接访登记';

-- ----------------------------
-- Records of t_visit
-- ----------------------------
INSERT INTO `t_visit` VALUES ('3', '2016-05-21 15:53:36', '1', '22', '1', '1', '1', '1', '2016-05-21 15:53:00', 'fsad', 'sfad', null, '', '', '高级人民法院对test1的接访会议', '0', '1', '', '2', '', null, '', '', '4', '2016-05-21 15:54:00', '2016-05-22 15:54:00', '', '0', null, null, null, 'fds', null, '0', 'test1', '-4', '2016-05-21 15:54:41', null);

-- ----------------------------
-- Table structure for `t_visit_apply`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_apply`;
CREATE TABLE `t_visit_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '申请时间',
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `room_id` int(11) DEFAULT '0' COMMENT '接访室ID',
  `supervisor_id` int(11) DEFAULT NULL COMMENT '申请人ID',
  `to_supervisor_id` int(11) DEFAULT '0' COMMENT '审批管理员ID',
  `start_time` datetime DEFAULT NULL COMMENT '接访时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态0：申请中；1：已处理；',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访远程申请记录表';

-- ----------------------------
-- Records of t_visit_apply
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_approve`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_approve`;
CREATE TABLE `t_visit_approve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `supervisor_id` int(11) DEFAULT '0' COMMENT '审批人',
  `to_supervisor_id` int(11) DEFAULT '0' COMMENT '指派下一个审核管理员的ID（不存在则为0）',
  `visit_supervisor_id` int(11) DEFAULT '0' COMMENT '审核通过确定的本地接访管理员（不存在则为0）',
  `reason` varchar(600) DEFAULT NULL COMMENT '审批原因',
  `status` tinyint(4) DEFAULT '0' COMMENT '审批状态：0：申请中；1：通过；-1：不通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访远程申请审批记录';

-- ----------------------------
-- Records of t_visit_approve
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_attachment`;
CREATE TABLE `t_visit_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) DEFAULT '0' COMMENT '上访ID',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型\r\n0:登记证据材料，\r\n101:笔录附件，\r\n102:上访人签名，\r\n103:上访人指纹签名',
  `name` varchar(50) DEFAULT NULL COMMENT '名称显示名称',
  `file` varchar(50) DEFAULT NULL COMMENT '文件url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访相关附件';

-- ----------------------------
-- Records of t_visit_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_detail`;
CREATE TABLE `t_visit_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `content` text COMMENT '笔录内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访笔录问答';

-- ----------------------------
-- Records of t_visit_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_manager`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_manager`;
CREATE TABLE `t_visit_manager` (
  `manager_id` int(11) DEFAULT NULL COMMENT '接访员ID',
  `visit_id` int(11) DEFAULT NULL COMMENT '预约案子ID',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_visit_manager
-- ----------------------------
INSERT INTO `t_visit_manager` VALUES ('22', '3', '4');
INSERT INTO `t_visit_manager` VALUES ('22', '3', '5');

-- ----------------------------
-- Table structure for `t_visit_purpose`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_purpose`;
CREATE TABLE `t_visit_purpose` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访目的（公网预约）';

-- ----------------------------
-- Records of t_visit_purpose
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_read_letter`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_read_letter`;
CREATE TABLE `t_visit_read_letter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `time` varchar(255) DEFAULT NULL COMMENT '接访时间',
  `company` varchar(255) DEFAULT NULL COMMENT '接访单位',
  `leader` varchar(255) DEFAULT NULL COMMENT '接访领导',
  `post` varchar(255) DEFAULT NULL COMMENT '职务',
  `participate_leader` varchar(255) DEFAULT NULL COMMENT '参与接访领导',
  `name` varchar(255) DEFAULT NULL COMMENT '上访人姓名',
  `sex` bit(1) DEFAULT b'0' COMMENT '0：女；1：男',
  `age` tinyint(4) DEFAULT '0' COMMENT '年龄',
  `nation` varchar(255) DEFAULT NULL COMMENT '名族',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系方式',
  `id_number` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `digest` varchar(255) DEFAULT NULL COMMENT '问题摘要',
  `to_opinion` varchar(255) DEFAULT NULL COMMENT '拟办意见',
  `examine_opinion` varchar(255) DEFAULT NULL,
  `leader_examine` varchar(255) DEFAULT NULL COMMENT '上级领导审批',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访阅笺';

-- ----------------------------
-- Records of t_visit_read_letter
-- ----------------------------

-- ----------------------------
-- Table structure for `t_visit_room`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_room`;
CREATE TABLE `t_visit_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `room_id` int(11) DEFAULT '0' COMMENT '会议室ID',
  `video_id` int(11) DEFAULT '0' COMMENT '录像机ID',
  `is_videotape` bit(1) DEFAULT b'0' COMMENT '录像标示；0：关闭；1：开启',
  `is_dualflow` bit(1) DEFAULT b'0' COMMENT '双流标示 0：关闭双流，1：开启双流',
  `is_spokesman` bit(1) DEFAULT b'0' COMMENT '指定了发言人标示',
  `is_temporary` bit(1) DEFAULT b'0' COMMENT '是否临时会议室',
  `is_terminal` bit(1) DEFAULT b'0' COMMENT '是否操作过终端标示（主要用于多点会议结束接访）',
  `status` tinyint(4) DEFAULT '0' COMMENT '0:预约，1:会议中，-1:已结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='接访预约接访室';

-- ----------------------------
-- Records of t_visit_room
-- ----------------------------
INSERT INTO `t_visit_room` VALUES ('3', '2016-05-21 15:54:41', '3', '19', '0', '', '', '', '', '', '0');
INSERT INTO `t_visit_room` VALUES ('4', '2016-05-21 15:54:41', '3', '25', '0', '', '', '', '', '', '0');

-- ----------------------------
-- Table structure for `t_visit_transfe`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_transfe`;
CREATE TABLE `t_visit_transfe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `time` datetime DEFAULT NULL COMMENT '操作时间',
  `name` varchar(255) DEFAULT NULL COMMENT '操作人员',
  `type` varchar(255) DEFAULT NULL COMMENT '操作类型',
  `status` varchar(255) DEFAULT NULL COMMENT '当前状态',
  `content` varchar(255) DEFAULT NULL COMMENT '描述',
  `number` bigint(20) DEFAULT '0' COMMENT '节点编号',
  PRIMARY KEY (`id`),
  KEY `idx_number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='接访流转记录';

-- ----------------------------
-- Records of t_visit_transfe
-- ----------------------------
INSERT INTO `t_visit_transfe` VALUES ('5', '3', '2016-05-21 15:53:36', '管理员', '新建预约', '提交', '提交了您的接访会议', '0');
INSERT INTO `t_visit_transfe` VALUES ('6', '3', '2016-05-21 15:54:41', '管理员', '预约处理', '远程接访（已安排接访室）', '安排了您的远程接访会议', '0');

-- ----------------------------
-- Table structure for `t_visit_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_user`;
CREATE TABLE `t_visit_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` bigint(20) DEFAULT '0' COMMENT '信访编号',
  `visit_id` int(11) DEFAULT '0' COMMENT '接访ID',
  `photo` varchar(50) DEFAULT NULL COMMENT '图像',
  `name` varchar(225) DEFAULT NULL COMMENT '姓名',
  `sex` bit(1) DEFAULT b'0' COMMENT '性别',
  `nation_id` tinyint(4) DEFAULT '0' COMMENT '名族',
  `id_number` varchar(18) DEFAULT NULL COMMENT '身份证',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号码/电话号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `census` varchar(10) DEFAULT NULL COMMENT '户籍',
  `address` varchar(60) DEFAULT NULL COMMENT '家庭地址',
  `company` varchar(60) DEFAULT NULL COMMENT '单位',
  `fingerprint` varchar(255) DEFAULT NULL COMMENT '指纹',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_number` (`number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='接访登记上访人';

-- ----------------------------
-- Records of t_visit_user
-- ----------------------------
INSERT INTO `t_visit_user` VALUES ('3', '1463817216637', '3', 'photo.png', 'test1', '', '1', '411323199108072114', '15134212156', null, null, 'test1', 'test1', '');

-- ----------------------------
-- Table structure for `t_visit_video_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_visit_video_file`;
CREATE TABLE `t_visit_video_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) DEFAULT '0' COMMENT '会议id',
  `video_ip` varchar(100) DEFAULT '0' COMMENT '录像机的id',
  `room_ip` varchar(100) DEFAULT '0' COMMENT '会议室id （冗余）',
  `file` varchar(255) DEFAULT NULL COMMENT '返回的文件名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接访室视频文件';

-- ----------------------------
-- Records of t_visit_video_file
-- ----------------------------

-- ----------------------------
-- Procedure structure for `dowhile`
-- ----------------------------
DROP PROCEDURE IF EXISTS `dowhile`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dowhile`()
begin 
  declare i int default 0;
  start transaction;
   while i<50 do
    
	INSERT INTO `remote_general`.`t_supervisor` ( `time`, `name`, `password`, `sex`, `age`, `real_nname`, `birthday`, `id_number`, `address`, `nation_id`, `work_model`, `work_address`, `work_email`, `court`, `court_id`, `subordinate_department`, `subordinate_units`, `position`, `office_telephone`, `last_login_ip`, `login_count`, `last_login_time`, `role_id`, `remark`, `status`) VALUES ( '2016-01-11 11:09:39', 'xieshaohui', 'a8932b0f2da5f77c9b0fbefdd264fd3c', '', '22', '谢少辉', '2016-01-12 11:10:18', '530113197710277438', '湖北省恩施市鹤峰县', '1', '13477269668', '深圳', 'xieshaohui!@163.com', '2', '1', '执法部门', '深圳市中级人民法院', '老板', '0755-7518834', '192.168.1.102', '1', '2016-01-11 11:11:05', '2', '最诚实的人是谢少辉', '0');
 
		
    set i=i+1; 
   
end while; 
  commit;
 end
;;
DELIMITER ;
