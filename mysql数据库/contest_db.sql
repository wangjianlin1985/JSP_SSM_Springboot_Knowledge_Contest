/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : contest_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-06 12:48:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_contest`
-- ----------------------------
DROP TABLE IF EXISTS `t_contest`;
CREATE TABLE `t_contest` (
  `contestId` int(11) NOT NULL auto_increment COMMENT '比赛id',
  `schoolObj` int(11) NOT NULL COMMENT '举办学校',
  `projectObj` int(11) NOT NULL COMMENT '比赛项目',
  `contestName` varchar(80) NOT NULL COMMENT '比赛名称',
  `contestDesc` varchar(5000) NOT NULL COMMENT '比赛介绍',
  `contestPlace` varchar(50) NOT NULL COMMENT '比赛地点',
  `personNumber` int(11) NOT NULL COMMENT '人数限制',
  `signUpTime` varchar(20) default NULL COMMENT '报名时间',
  `endTime` varchar(20) default NULL COMMENT '截止时间',
  PRIMARY KEY  (`contestId`),
  KEY `schoolObj` (`schoolObj`),
  KEY `projectObj` (`projectObj`),
  CONSTRAINT `t_contest_ibfk_1` FOREIGN KEY (`schoolObj`) REFERENCES `t_school` (`schoolId`),
  CONSTRAINT `t_contest_ibfk_2` FOREIGN KEY (`projectObj`) REFERENCES `t_project` (`projectId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_contest
-- ----------------------------
INSERT INTO `t_contest` VALUES ('1', '1', '1', '知识竞赛项目1比赛', '<p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p><p>4月20日在学校举行知识竞赛项目1比赛</p>', '学校体院馆', '40', '2018-02-21 22:59:04', '2018-04-20 22:59:16');
INSERT INTO `t_contest` VALUES ('2', '1', '2', '华东理工大学项目2知识竞赛', '<p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p>', '学校大操场', '40', '2017-12-31 01:28:35', '2018-04-20 01:28:36');
INSERT INTO `t_contest` VALUES ('3', '1', '2', '华东理工项目2知识竞赛', '<p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p><p>4月20日在学校举行知识竞赛项目2比赛</p>', '学校会议馆', '40', '2017-12-31 01:28:35', '2018-04-20 01:28:36');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `noticeType` varchar(20) NOT NULL COMMENT '新闻类别',
  `content` varchar(8000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '知识竞赛指南111111', '比赛指南', '<p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p><p>知识竞赛指南111111</p>', '2018-03-13 15:16:48');
INSERT INTO `t_notice` VALUES ('2', '网站公告1111111', '网站公告', '<p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p><p>网站公告1111111</p>', '2018-03-13 15:17:10');

-- ----------------------------
-- Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `projectId` int(11) NOT NULL auto_increment COMMENT '项目id',
  `projectName` varchar(20) NOT NULL COMMENT '项目名称',
  `projectDesc` varchar(20) NOT NULL COMMENT '项目介绍',
  PRIMARY KEY  (`projectId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_project
-- ----------------------------
INSERT INTO `t_project` VALUES ('1', '知识竞赛项目1', '知识竞赛项目1');
INSERT INTO `t_project` VALUES ('2', '知识竞赛项目2', '知识竞赛项目2');
INSERT INTO `t_project` VALUES ('3', '知识竞赛项目3', '知识竞赛项目3');

-- ----------------------------
-- Table structure for `t_school`
-- ----------------------------
DROP TABLE IF EXISTS `t_school`;
CREATE TABLE `t_school` (
  `schoolId` int(11) NOT NULL auto_increment COMMENT '学校id',
  `schoolName` varchar(20) NOT NULL COMMENT '学校名称',
  PRIMARY KEY  (`schoolId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_school
-- ----------------------------
INSERT INTO `t_school` VALUES ('1', '华东理工大学');
INSERT INTO `t_school` VALUES ('2', '上海应用技术大学');
INSERT INTO `t_school` VALUES ('3', '上海师范大学');

-- ----------------------------
-- Table structure for `t_score`
-- ----------------------------
DROP TABLE IF EXISTS `t_score`;
CREATE TABLE `t_score` (
  `scoreId` int(11) NOT NULL auto_increment COMMENT '成绩id',
  `contestObj` int(11) NOT NULL COMMENT '比赛名称',
  `studentObj` varchar(30) NOT NULL COMMENT '学生',
  `contentRound` varchar(20) NOT NULL COMMENT '比赛轮次',
  `scoreValue` float NOT NULL COMMENT '比赛积分',
  PRIMARY KEY  (`scoreId`),
  KEY `contestObj` (`contestObj`),
  KEY `studentObj` (`studentObj`),
  CONSTRAINT `t_score_ibfk_1` FOREIGN KEY (`contestObj`) REFERENCES `t_contest` (`contestId`),
  CONSTRAINT `t_score_ibfk_2` FOREIGN KEY (`studentObj`) REFERENCES `t_student` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_score
-- ----------------------------
INSERT INTO `t_score` VALUES ('1', '1', 'user1', '第1组第1场', '3');
INSERT INTO `t_score` VALUES ('2', '1', 'user1', '第1组第2场', '4');
INSERT INTO `t_score` VALUES ('3', '1', 'user2', '第1组第1场', '2');
INSERT INTO `t_score` VALUES ('4', '1', 'user2', '第1组第2场', '1');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `contest` int(11) NOT NULL COMMENT '报名比赛',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `signUpTime` varchar(20) default NULL COMMENT '报名时间',
  PRIMARY KEY  (`user_name`),
  KEY `contest` (`contest`),
  CONSTRAINT `t_student_ibfk_1` FOREIGN KEY (`contest`) REFERENCES `t_contest` (`contestId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('user1', '123', '1', '双小右', '男', '2017-12-06', 'upload/f503da1b-1ab1-45e0-9c86-fa471087b5e7.jpg', '13598342934', '四川成都红星路', '2018-03-01 23:00:09');
INSERT INTO `t_student` VALUES ('user2', '123', '1', '王晓静', '女', '2017-12-06', 'upload/cdd43cc4-6ba9-41df-91fc-09b34aee8de7.jpg', '13958303943', '四川达州', '2018-03-07 01:24:19');

-- ----------------------------
-- Table structure for `t_tiku`
-- ----------------------------
DROP TABLE IF EXISTS `t_tiku`;
CREATE TABLE `t_tiku` (
  `tikuId` int(11) NOT NULL auto_increment COMMENT '题库id',
  `tikuTypeObj` int(11) NOT NULL COMMENT '题库分类',
  `tikuName` varchar(20) NOT NULL COMMENT '题库名称',
  `tikuContent` varchar(8000) NOT NULL COMMENT '题库内容',
  `hitNum` int(11) NOT NULL COMMENT '点击率',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`tikuId`),
  KEY `tikuTypeObj` (`tikuTypeObj`),
  CONSTRAINT `t_tiku_ibfk_1` FOREIGN KEY (`tikuTypeObj`) REFERENCES `t_tikutype` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_tiku
-- ----------------------------
INSERT INTO `t_tiku` VALUES ('1', '1', '十九大知识竞赛竞赛试题', '<p>1、中国共产党人的初心和使命是：( &nbsp;)。</p><p><br/></p><p>2、“五位一体”总布局分别是( &nbsp;)建设、( &nbsp;)建设、( &nbsp;)建设、( &nbsp;)建设、( &nbsp;)建设。</p><p><br/></p><p>3、“四个全面”战略布局分别是：全面( &nbsp;)、全面( &nbsp;)、全面( &nbsp;)、全面( &nbsp;)。</p><p><br/></p><p>4、翻开习近平总书记从1969年下乡当知青，到2012年十八大召开时的工作履历，可以发现这44年中，每一层级都历经几年、都扎扎实实、都政绩卓著，每一岗位都干在实处、走在前列。1982年3月，习近平总书记从军委办公厅到( &nbsp;)，他自己也说“这是我从政起步的地方”。</p><p><br/></p><p>5、全面深化改革领导小组于2013年12月30日成立，到今年7月19日已经召开( &nbsp;)次会议，每次都是习近平总书记亲自主持。</p><p><br/></p><p>6、习近平强调，中国特色社会主义是改革开放以来党的全部理论和实践的主题，全党必须高举中国特色社会主义伟大旗帜，牢固树立中国特色社会主义( &nbsp;)自信、( &nbsp;)自信、( &nbsp;)自信、( &nbsp;)自信，确保党和国家事业始终沿着正确方向胜利前进。</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>1 答案：为中国人民谋幸福，为中华民族谋复兴</p><p>2 答案：经济、政治、文化、社会、生态文明</p><p>3 答案：建成小康社会、深化改革、依法治国、从严治党</p><p>4 答案：河北正定</p><p>5 答案：37</p><p>6 答案：道路、理论、制度、文化</p><p><br/></p>', '3', '2018-03-13 14:51:57');
INSERT INTO `t_tiku` VALUES ('2', '4', '五四团情知识竞赛题', '<p><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">1、1915年9月，陈独秀在上海创办了&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;，从此拉开了近代中国第一&nbsp;&nbsp;&nbsp;&nbsp;次思想解放运动——新文化运动的序幕。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.《新青年》&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.《青年杂志》&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;《青春》&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">2、正当新文化运动蓬勃发展，中国青年作为新的社会群体正在集结、形成之际，&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;的消息传到中国，把一个新的社会现实摆在中国人民面前。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;俄国十月革命胜利&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;第一次世界大战结束&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;订立《中日陆军共同防敌协定》&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">3、1918年5月21日，北京大学、北京高等师范学校等校学生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;前往总统府请愿，要求废止《中日陆军共同防敌协定》，并要求公布内容条文。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;20多人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;200多人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;2000多人&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">4、1918年5月21日的北京学生的请愿活动发生后，北京政府教育部训令各地学校&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学生集会和请愿，学生们的斗争没有取得什么结果。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;“严加取缔”&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;协助阻止&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;下令阻止&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">5、1918年夏，在经过要求废止《中日陆军共同防敌协定》斗争后，北京、天津学生经过一个多月的积极联络，组织了一个近乎全国性的学生团体&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（后改名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;）。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;救国会，爱国会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;爱国会，救国会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;报国会，救国会&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">6、1918年10月20日，学生救国会在北京大学组织&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;，在北京南池子欧美同学会会所召开成立大会。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;新潮杂志社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;国民杂志社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;《北京大学月刊》&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">7、1917年7月1日成立的五四时期历史最久、会员最多、分布最广、分化最显的青年社团是&nbsp;&nbsp;&nbsp;&nbsp;。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;少年中国学会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;少年学会&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;青年学会&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">8、1918年冬，&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在北京大学组织马尔克斯研究会。邀请几位教授参加，“它的对内活动是研究马克思学说，对外则是举办一些演讲会”。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;张申府&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;陈独秀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;李大钊&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">9、1919年3月，北京大学学生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;、廖书仓等人发起组织了“平民教育讲演团”，并且于当年开展了两次较大规模的讲演活动。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;高君宇&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;廖承志&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;邓中夏&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">10、1919年4月11日，北京政府驻日公使&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;自日本回国，中国留日学生300余名诗“卖国贼”旗帜和条幅赴东京车站，质问其签订卖国条约之罪。《每周评论》18日和19日发文点了亲日派的名字，揭露他们的卖国行径。&nbsp;</span><br/><span style=\"color: rgb(51, 51, 51); font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px; text-align: justify; background-color: rgb(255, 255, 255);\">A.&nbsp;曹汝霖&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.&nbsp;陆宗舆&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.&nbsp;章宗祥&nbsp;</span></p>', '2', '2018-03-13 14:55:11');

-- ----------------------------
-- Table structure for `t_tikutype`
-- ----------------------------
DROP TABLE IF EXISTS `t_tikutype`;
CREATE TABLE `t_tikutype` (
  `typeId` int(11) NOT NULL auto_increment COMMENT '题库类目id',
  `tikuTypeName` varchar(40) NOT NULL COMMENT '题库类目名称',
  PRIMARY KEY  (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_tikutype
-- ----------------------------
INSERT INTO `t_tikutype` VALUES ('1', '时事政治');
INSERT INTO `t_tikutype` VALUES ('2', '法律法规');
INSERT INTO `t_tikutype` VALUES ('3', '金融财经');
INSERT INTO `t_tikutype` VALUES ('4', '科技教育');
INSERT INTO `t_tikutype` VALUES ('5', '安全环保');
INSERT INTO `t_tikutype` VALUES ('6', '文史地理');
INSERT INTO `t_tikutype` VALUES ('7', '军事竞技');
INSERT INTO `t_tikutype` VALUES ('8', '日常生活');
INSERT INTO `t_tikutype` VALUES ('9', '智慧娱乐');

-- ----------------------------
-- Table structure for `t_weblink`
-- ----------------------------
DROP TABLE IF EXISTS `t_weblink`;
CREATE TABLE `t_weblink` (
  `linkId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `webName` varchar(50) NOT NULL COMMENT '网站名称',
  `webLogo` varchar(60) NOT NULL COMMENT '网站Logo',
  `webAddress` varchar(80) NOT NULL COMMENT '网站地址',
  PRIMARY KEY  (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_weblink
-- ----------------------------
INSERT INTO `t_weblink` VALUES ('1', '百度', 'upload/71f9c5a1-e168-492b-9d9b-62dbd5cd3f3b.jpg', 'http://www.baidu.com');
