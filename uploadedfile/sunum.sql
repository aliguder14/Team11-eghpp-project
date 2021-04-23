-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5.1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema messaging
--

CREATE DATABASE IF NOT EXISTS messaging;
USE messaging;

--
-- Definition of table `messaging`.`auth_group`
--

DROP TABLE IF EXISTS `messaging`.`auth_group`;
CREATE TABLE  `messaging`.`auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_group`
--

/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
LOCK TABLES `auth_group` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_group_permissions`
--

DROP TABLE IF EXISTS `messaging`.`auth_group_permissions`;
CREATE TABLE  `messaging`.`auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `permission_id_refs_id_5886d21f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_group_permissions`
--

/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
LOCK TABLES `auth_group_permissions` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_message`
--

DROP TABLE IF EXISTS `messaging`.`auth_message`;
CREATE TABLE  `messaging`.`auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_message`
--

/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
LOCK TABLES `auth_message` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_permission`
--

DROP TABLE IF EXISTS `messaging`.`auth_permission`;
CREATE TABLE  `messaging`.`auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_permission`
--

/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
LOCK TABLES `auth_permission` WRITE;
INSERT INTO `messaging`.`auth_permission` VALUES  (1,'Can add permission',1,'add_permission'),
 (2,'Can change permission',1,'change_permission'),
 (3,'Can delete permission',1,'delete_permission'),
 (4,'Can add group',2,'add_group'),
 (5,'Can change group',2,'change_group'),
 (6,'Can delete group',2,'delete_group'),
 (7,'Can add user',3,'add_user'),
 (8,'Can change user',3,'change_user'),
 (9,'Can delete user',3,'delete_user'),
 (10,'Can add message',4,'add_message'),
 (11,'Can change message',4,'change_message'),
 (12,'Can delete message',4,'delete_message'),
 (13,'Can add content type',5,'add_contenttype'),
 (14,'Can change content type',5,'change_contenttype'),
 (15,'Can delete content type',5,'delete_contenttype'),
 (16,'Can add session',6,'add_session'),
 (17,'Can change session',6,'change_session'),
 (18,'Can delete session',6,'delete_session'),
 (19,'Can add site',7,'add_site'),
 (20,'Can change site',7,'change_site'),
 (21,'Can delete site',7,'delete_site'),
 (22,'Can add poll',8,'add_poll'),
 (23,'Can change poll',8,'change_poll');
INSERT INTO `messaging`.`auth_permission` VALUES  (24,'Can delete poll',8,'delete_poll'),
 (25,'Can add choice',9,'add_choice'),
 (26,'Can change choice',9,'change_choice'),
 (27,'Can delete choice',9,'delete_choice'),
 (28,'Can add poll1',10,'add_poll1'),
 (29,'Can change poll1',10,'change_poll1'),
 (30,'Can delete poll1',10,'delete_poll1'),
 (31,'Can add choice1',11,'add_choice1'),
 (32,'Can change choice1',11,'change_choice1'),
 (33,'Can delete choice1',11,'delete_choice1'),
 (34,'Can add message',12,'add_message'),
 (35,'Can change message',12,'change_message'),
 (36,'Can delete message',12,'delete_message'),
 (37,'Can add log entry',13,'add_logentry'),
 (38,'Can change log entry',13,'change_logentry'),
 (39,'Can delete log entry',13,'delete_logentry'),
 (40,'Can add poll',14,'add_poll'),
 (41,'Can change poll',14,'change_poll'),
 (42,'Can delete poll',14,'delete_poll'),
 (43,'Can add choice',15,'add_choice'),
 (44,'Can change choice',15,'change_choice'),
 (45,'Can delete choice',15,'delete_choice'),
 (46,'Can add poll1',16,'add_poll1');
INSERT INTO `messaging`.`auth_permission` VALUES  (47,'Can change poll1',16,'change_poll1'),
 (48,'Can delete poll1',16,'delete_poll1'),
 (49,'Can add choice1',17,'add_choice1'),
 (50,'Can change choice1',17,'change_choice1'),
 (51,'Can delete choice1',17,'delete_choice1'),
 (52,'Can add message',18,'add_message'),
 (53,'Can change message',18,'change_message'),
 (54,'Can delete message',18,'delete_message'),
 (55,'Can add poll1',19,'add_poll1'),
 (56,'Can change poll1',19,'change_poll1'),
 (57,'Can delete poll1',19,'delete_poll1'),
 (58,'Can add choice1',20,'add_choice1'),
 (59,'Can change choice1',20,'change_choice1'),
 (60,'Can delete choice1',20,'delete_choice1'),
 (61,'Can add message',21,'add_message'),
 (62,'Can change message',21,'change_message'),
 (63,'Can delete message',21,'delete_message');
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_user`
--

DROP TABLE IF EXISTS `messaging`.`auth_user`;
CREATE TABLE  `messaging`.`auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `first_name` blob,
  `last_name` blob,
  `email` varchar(75) DEFAULT NULL,
  `password` varchar(128) CHARACTER SET latin1 DEFAULT NULL,
  `is_staff` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `date_joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`auth_user`
--

/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
LOCK TABLES `auth_user` WRITE;
INSERT INTO `messaging`.`auth_user` VALUES  (1,'admin',0x426F7261,0x47C3BC6E67C3B672656E,'admin@portakalteknoloji.com','sha1$106cc$b6ba98d58dc03f29ca9ed70c58e18b1120d8a5b9',1,1,1,'2010-05-02 18:07:48','2010-03-06 15:15:21'),
 (10,'oberker',0xC3966DC3BC72,0x4265726B6572,'oberker@portakalteknoloji.com','sha1$aecd7$b7d1f4d42b7bb81ac6dd1743452fdb684aeebb8d',1,1,0,'2010-05-02 13:37:04','2010-04-28 10:22:13'),
 (11,'aguder',0x416C69,0x47C3BC646572,'aguder@portakalteknoloji.com','sha1$38e46$6dcf7a74063d33fb1a6342fedd677f9f3a37be27',1,1,0,'2010-05-02 18:08:33','2010-04-28 10:35:19'),
 (12,'o_tugrul',0x4FC49F757A,0x5475C49F72756C,'o_tugrul@portakalteknoloji.com','sha1$4c0ab$78663b4216e6be77abc72593442c197af696615c',1,1,0,'2010-05-01 12:53:44','2010-04-28 10:45:25');
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_user_groups`
--

DROP TABLE IF EXISTS `messaging`.`auth_user_groups`;
CREATE TABLE  `messaging`.`auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `group_id_refs_id_f116770` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_user_groups`
--

/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
LOCK TABLES `auth_user_groups` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;


--
-- Definition of table `messaging`.`auth_user_user_permissions`
--

DROP TABLE IF EXISTS `messaging`.`auth_user_user_permissions`;
CREATE TABLE  `messaging`.`auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `permission_id_refs_id_67e79cb` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`auth_user_user_permissions`
--

/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
LOCK TABLES `auth_user_user_permissions` WRITE;
INSERT INTO `messaging`.`auth_user_user_permissions` VALUES  (1,2,33),
 (2,2,3),
 (3,2,4),
 (4,2,37),
 (5,2,10),
 (6,2,11),
 (7,2,12),
 (8,2,13),
 (9,2,14),
 (10,2,16),
 (11,2,17),
 (12,2,18),
 (13,2,31),
 (43,3,36),
 (42,3,25),
 (41,3,18),
 (40,3,17),
 (39,3,16),
 (38,3,15),
 (37,3,14),
 (36,3,13),
 (35,3,12),
 (34,3,11),
 (33,3,10),
 (32,3,39),
 (31,3,38),
 (30,3,37),
 (29,3,4);
UNLOCK TABLES;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;


--
-- Definition of table `messaging`.`deleteMessage`
--

DROP TABLE IF EXISTS `messaging`.`deleteMessage`;
CREATE TABLE  `messaging`.`deleteMessage` (
  `deletedItem` bigint(250) NOT NULL AUTO_INCREMENT,
  `messageItem` bigint(250) NOT NULL,
  `delete_from` varchar(150) DEFAULT NULL,
  `user` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `isread` char(1) DEFAULT NULL,
  PRIMARY KEY (`deletedItem`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`deleteMessage`
--

/*!40000 ALTER TABLE `deleteMessage` DISABLE KEYS */;
LOCK TABLES `deleteMessage` WRITE;
INSERT INTO `messaging`.`deleteMessage` VALUES  (90,155,'inbox',0x616775646572,'+'),
 (91,153,'outbox',0x616775646572,'+'),
 (92,174,'outbox',0x616775646572,'+'),
 (93,152,'inbox',0x616775646572,'+'),
 (94,175,'inbox',0x616775646572,'-'),
 (95,145,'inbox',0x616775646572,'+'),
 (96,176,'outbox',0x616775646572,'+'),
 (97,150,'inbox',0x616775646572,'+'),
 (98,177,'inbox',0x616775646572,'-'),
 (99,151,'outbox',0x616775646572,'+'),
 (100,171,'outbox',0x616775646572,'+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `deleteMessage` ENABLE KEYS */;


--
-- Definition of table `messaging`.`deletedComplete`
--

DROP TABLE IF EXISTS `messaging`.`deletedComplete`;
CREATE TABLE  `messaging`.`deletedComplete` (
  `deletedItem` bigint(250) NOT NULL AUTO_INCREMENT,
  `messageItem` bigint(250) NOT NULL,
  `deleted_from` varchar(150) NOT NULL,
  `user` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `isread` char(1) NOT NULL,
  PRIMARY KEY (`deletedItem`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`deletedComplete`
--

/*!40000 ALTER TABLE `deletedComplete` DISABLE KEYS */;
LOCK TABLES `deletedComplete` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `deletedComplete` ENABLE KEYS */;


--
-- Definition of table `messaging`.`django_admin_log`
--

DROP TABLE IF EXISTS `messaging`.`django_admin_log`;
CREATE TABLE  `messaging`.`django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_user_id` (`user_id`),
  KEY `django_admin_log_content_type_id` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`django_admin_log`
--

/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
LOCK TABLES `django_admin_log` WRITE;
INSERT INTO `messaging`.`django_admin_log` VALUES  (1,'2010-03-06 17:49:28',1,3,'2','aa',1,''),
 (2,'2010-03-06 17:52:34',1,3,'2','aa',2,'Changed first_name, last_name, email, is_staff, user_permissions, last_login and date_joined.'),
 (3,'2010-03-06 17:53:21',1,3,'1','ali',2,'Changed first_name, last_name and last_login.'),
 (4,'2010-03-06 17:53:55',1,3,'3','tem',1,''),
 (5,'2010-03-06 17:56:37',1,3,'3','tem',2,'Changed first_name, last_name, email, is_staff, user_permissions, last_login and date_joined.'),
 (6,'2010-03-06 17:57:46',1,3,'1','ali',2,'No fields changed.'),
 (7,'2010-03-06 17:57:57',1,3,'1','ali',2,'No fields changed.'),
 (8,'2010-03-06 18:01:34',1,3,'1','ali',2,'Changed email.'),
 (9,'2010-04-07 21:00:12',1,3,'3','tem',2,'No fields changed.'),
 (10,'2010-04-07 21:01:14',1,3,'5','okobal',2,'No fields changed.');
UNLOCK TABLES;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;


--
-- Definition of table `messaging`.`django_content_type`
--

DROP TABLE IF EXISTS `messaging`.`django_content_type`;
CREATE TABLE  `messaging`.`django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`django_content_type`
--

/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
LOCK TABLES `django_content_type` WRITE;
INSERT INTO `messaging`.`django_content_type` VALUES  (1,'permission','auth','permission'),
 (2,'group','auth','group'),
 (3,'user','auth','user'),
 (4,'message','auth','message'),
 (5,'content type','contenttypes','contenttype'),
 (6,'session','sessions','session'),
 (7,'site','sites','site'),
 (8,'poll','polls','poll'),
 (9,'choice','polls','choice'),
 (10,'poll1','polls1','poll1'),
 (11,'choice1','polls1','choice1'),
 (12,'message','polls1','message'),
 (13,'log entry','admin','logentry'),
 (14,'poll','login','poll'),
 (15,'choice','login','choice'),
 (16,'poll1','logout','poll1'),
 (17,'choice1','logout','choice1'),
 (18,'message','logout','message'),
 (19,'poll1','inbox','poll1'),
 (20,'choice1','inbox','choice1'),
 (21,'message','inbox','message');
UNLOCK TABLES;
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;


--
-- Definition of table `messaging`.`django_session`
--

DROP TABLE IF EXISTS `messaging`.`django_session`;
CREATE TABLE  `messaging`.`django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`django_session`
--

/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
LOCK TABLES `django_session` WRITE;
INSERT INTO `messaging`.`django_session` VALUES  ('c6ca4325e520717963c238be10308f55','gAJ9cQEuZDc0YmUxYjI3MTJmZWFlMjU2ZWQ4NmNiMjdmOTJhYjU=\n','2010-04-03 23:44:19'),
 ('5681f5b4e521a2ace18b69ab62f59f9f','gAJ9cQEuZDc0YmUxYjI3MTJmZWFlMjU2ZWQ4NmNiMjdmOTJhYjU=\n','2010-04-23 19:08:06'),
 ('ed32e1ced9a33f2bc20c60fe098fdd58','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS45OWU0M2I0ZWMwY2YxNGM5ZTJi\nMmNmZWNiYTA1Yjc4NA==\n','2010-05-04 15:43:15'),
 ('f8fc737a25aaf431ba60676f956e017c','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEHdS42MWI3NDY1ZWExOWQ0ODE4YWFm\nNDIzOGI3ZjIxYjZhMA==\n','2010-05-10 18:15:58'),
 ('0b7fd9e6bbd85a59e264e2e26f6d10d3','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigELdS42YmM5YTcxMTNiZTI5MzUxOThj\nMzRjMDM2NjIwMWE4Mg==\n','2010-05-12 20:29:35'),
 ('4518b4bd6cd5244e37f38c68f5fb1474','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigELdS42YmM5YTcxMTNiZTI5MzUxOThj\nMzRjMDM2NjIwMWE4Mg==\n','2010-05-16 15:08:33');
UNLOCK TABLES;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;


--
-- Definition of table `messaging`.`django_site`
--

DROP TABLE IF EXISTS `messaging`.`django_site`;
CREATE TABLE  `messaging`.`django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`django_site`
--

/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
LOCK TABLES `django_site` WRITE;
INSERT INTO `messaging`.`django_site` VALUES  (1,'example.com','example.com');
UNLOCK TABLES;
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;


--
-- Definition of table `messaging`.`draft`
--

DROP TABLE IF EXISTS `messaging`.`draft`;
CREATE TABLE  `messaging`.`draft` (
  `draftId` bigint(249) NOT NULL AUTO_INCREMENT,
  `messageId` bigint(249) NOT NULL,
  `draft_from` varchar(150) CHARACTER SET latin5 NOT NULL,
  `user` varchar(200) COLLATE utf8_bin NOT NULL,
  `isread` char(1) CHARACTER SET latin5 NOT NULL,
  PRIMARY KEY (`draftId`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`draft`
--

/*!40000 ALTER TABLE `draft` DISABLE KEYS */;
LOCK TABLES `draft` WRITE;
INSERT INTO `messaging`.`draft` VALUES  (71,149,'outbox',0x6F5F74756772756C,'+'),
 (72,154,'inbox',0x616775646572,'+'),
 (73,161,'inbox',0x6F6265726B6572,'+'),
 (80,179,'outbox',0x61646D696E,'+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `draft` ENABLE KEYS */;


--
-- Definition of table `messaging`.`draftToReceiver`
--

DROP TABLE IF EXISTS `messaging`.`draftToReceiver`;
CREATE TABLE  `messaging`.`draftToReceiver` (
  `item` int(11) NOT NULL AUTO_INCREMENT,
  `messageItem` int(11) NOT NULL,
  `draft_from` varchar(300) DEFAULT NULL,
  `user` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `isread` char(1) DEFAULT NULL,
  PRIMARY KEY (`item`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`draftToReceiver`
--

/*!40000 ALTER TABLE `draftToReceiver` DISABLE KEYS */;
LOCK TABLES `draftToReceiver` WRITE;
INSERT INTO `messaging`.`draftToReceiver` VALUES  (30,149,'draft','','+'),
 (31,176,'draft','','+'),
 (32,179,'draft',0x6F6265726B6572,'+'),
 (33,179,'draft',0x616775646572,'+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `draftToReceiver` ENABLE KEYS */;


--
-- Definition of table `messaging`.`employee`
--

DROP TABLE IF EXISTS `messaging`.`employee`;
CREATE TABLE  `messaging`.`employee` (
  `perId` bigint(12) NOT NULL,
  `firstname` varchar(150) COLLATE utf8_bin NOT NULL,
  `lastname` varchar(150) COLLATE utf8_bin NOT NULL,
  `insNum` bigint(12) NOT NULL,
  `taxNum` bigint(12) NOT NULL,
  `address` text COLLATE utf8_bin NOT NULL,
  `country` varchar(150) COLLATE utf8_bin NOT NULL,
  `phoneNum` varchar(150) COLLATE utf8_bin NOT NULL,
  `email` varchar(150) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`perId`,`insNum`,`taxNum`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`employee`
--

/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
LOCK TABLES `employee` WRITE;
INSERT INTO `messaging`.`employee` VALUES  (2356,0xC3966DC3BC72,0x4265726B6572,3032,4521,0x4F6474C3BC20536974657369,0x5475726B6579,0x343232203536203131,0x6F6265726B657240686F746D61696C2E636F6D),
 (1455,0x457264656D,0x59C4B16C6D617A,1245,1190,0x45746C696B,0x5475726B6579,0x333435203637203233,0x657264656D40676D61696C2E636F6D),
 (1145,0x4FC49F757A,0x5475C49F72756C,3412,2310,0xC39C6D69746BC3B679,0x5475726B6579,0x323335203131203330,0x6F5F74756772756C40686F746D61696C2E636F6D),
 (4512,0x416C69,0x47C3BC646572,1112,2312,0x42696C6B656E742D33,0x5475726B6579,0x323333203132203334,0x61677564657240686F746D61696C2E636F6D),
 (1589,0x5975737566,0x42696C67696E,3412,4523,0x4B65C3A769C3B672656E,0x5475726B6579,0x333536203233203131,0x797573756662696C40676D61696C2E636F6D),
 (2284,0x536962656C,0x43616E6CC4B1,2345,8816,0x426168C3A7656C6965766C6572,0x5475726B6579,0x323333203132203435,0x736962656C40686F746D61696C2E636F6D);
UNLOCK TABLES;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


--
-- Definition of table `messaging`.`guest`
--

DROP TABLE IF EXISTS `messaging`.`guest`;
CREATE TABLE  `messaging`.`guest` (
  `item` bigint(250) NOT NULL AUTO_INCREMENT,
  `perId` bigint(12) NOT NULL,
  `firstname` varchar(150) COLLATE utf8_bin NOT NULL,
  `lastname` varchar(150) COLLATE utf8_bin NOT NULL,
  `insNum` bigint(12) NOT NULL,
  `taxNum` bigint(12) NOT NULL,
  `country` varchar(150) COLLATE utf8_bin NOT NULL,
  `phoneNum` varchar(150) COLLATE utf8_bin NOT NULL,
  `email` varchar(150) COLLATE utf8_bin NOT NULL,
  `applyDate` date NOT NULL,
  `applyTime` time NOT NULL,
  `status` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`item`,`perId`,`insNum`,`taxNum`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`guest`
--

/*!40000 ALTER TABLE `guest` DISABLE KEYS */;
LOCK TABLES `guest` WRITE;
INSERT INTO `messaging`.`guest` VALUES  (24,2356,0xC3966DC3BC72,0x4265726B6572,3032,4521,0x5475726B6579,0x343232203536203131,0x6F6265726B657240686F746D61696C2E636F6D,'2010-04-28','13:18:32',0x617070726F766564),
 (25,4512,0x416C69,0x47C3BC646572,1112,2312,0x5475726B6579,0x323333203132203334,0x61677564657240686F746D61696C2E636F6D,'2010-04-28','13:33:33',0x617070726F766564),
 (27,1145,0x4FC49F757A,0x5475C49F72756C,3412,2310,0x5475726B6579,0x323335203131203330,0x6F5F74756772756C40686F746D61696C2E636F6D,'2010-04-28','13:43:36',0x617070726F766564);
UNLOCK TABLES;
/*!40000 ALTER TABLE `guest` ENABLE KEYS */;


--
-- Definition of table `messaging`.`inbox`
--

DROP TABLE IF EXISTS `messaging`.`inbox`;
CREATE TABLE  `messaging`.`inbox` (
  `inboxItem` bigint(250) NOT NULL AUTO_INCREMENT,
  `messageItem` bigint(250) NOT NULL,
  `inbox_from` varchar(200) CHARACTER SET latin5 NOT NULL,
  `user` varchar(200) COLLATE utf8_bin NOT NULL,
  `isread` char(1) CHARACTER SET latin5 NOT NULL,
  PRIMARY KEY (`inboxItem`)
) ENGINE=MyISAM AUTO_INCREMENT=542 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`inbox`
--

/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
LOCK TABLES `inbox` WRITE;
INSERT INTO `messaging`.`inbox` VALUES  (506,144,'inbox',0x6F6265726B6572,'+'),
 (539,178,'inbox',0x616775646572,'-'),
 (508,146,'inbox',0x6F6265726B6572,'+'),
 (509,147,'inbox',0x6F5F74756772756C,'+'),
 (510,148,'inbox',0x6F5F74756772756C,'+'),
 (541,158,'outbox',0x61646D696E,'+'),
 (512,151,'inbox',0x6F6265726B6572,'+'),
 (511,150,'inbox',0x616775646572,'-'),
 (514,153,'inbox',0x6F6265726B657274,'-'),
 (531,169,'inbox',0x61646D696E,'+'),
 (517,156,'inbox',0x6F6265726B6572,'+'),
 (518,157,'inbox',0x61646D696E,'-'),
 (519,158,'inbox',0x6F5F74756772756C,'+'),
 (520,159,'inbox',0x61646D696E,'-'),
 (521,160,'inbox',0x61646D696E,'-'),
 (523,162,'inbox',0x61646D696E,'-'),
 (524,163,'inbox',0x61646D696E,'+'),
 (525,164,'inbox',0x61646D696E,'+'),
 (526,165,'inbox',0x61646D696E,'-'),
 (528,166,'inbox',0x6F6265726B6572,'+'),
 (529,167,'inbox',0x61646D696E,'+'),
 (530,168,'inbox',0x61646D696E,'+'),
 (540,166,'outbox',0x61646D696E,'+'),
 (533,171,'inbox',0x6F5F74756772756C,'+'),
 (534,172,'inbox',0x616775646572,'-'),
 (535,173,'inbox',0x616775646572,'-');
INSERT INTO `messaging`.`inbox` VALUES  (536,174,'inbox',0x6F6265726B6572,'-'),
 (507,145,'inbox',0x616775646572,'-'),
 (513,152,'inbox',0x616775646572,'-'),
 (515,154,'inbox',0x616775646572,'+'),
 (516,155,'inbox',0x616775646572,'+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `inbox` ENABLE KEYS */;


--
-- Definition of table `messaging`.`message`
--

DROP TABLE IF EXISTS `messaging`.`message`;
CREATE TABLE  `messaging`.`message` (
  `item` int(11) NOT NULL AUTO_INCREMENT,
  `content` blob NOT NULL,
  `issue` varchar(100) COLLATE utf8_bin NOT NULL,
  `sender` varchar(100) COLLATE utf8_bin NOT NULL,
  `sent_date` date NOT NULL,
  `sent_time` time NOT NULL,
  `messagekey` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `mailbox_sender` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `isread` char(1) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`item`)
) ENGINE=MyISAM AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`message`
--

/*!40000 ALTER TABLE `message` DISABLE KEYS */;
LOCK TABLES `message` WRITE;
INSERT INTO `messaging`.`message` VALUES  (145,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32380A526563656976652054696D653A2032323A35373A35380A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-28','22:57:58','notenc','outbox',NULL),
 (147,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32380A526563656976652054696D653A2032323A35393A35320A5375626A6563743A20696C6B206D6573616A,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-28','22:59:52','notenc','outbox',NULL),
 (148,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A20696C6B206D6573616A,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-28','23:00:29','notenc','outbox',NULL),
 (150,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-28','23:29:12','notenc','outbox',NULL),
 (144,0xBB6C10485D0835,0x4E6F205375626A656374,0x616775646572,'2010-04-28','22:57:58','181635827316177','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (146,0xFF6454EA03A6536DF253CC10EE19B8E1,0x696C6B206D6573616A,0x6F5F74756772756C,'2010-04-28','22:59:52','197714263444783','outbox',NULL),
 (149,0x6A6B6C,0x4E6F207375626A656374,0x6F5F74756772756C,'2010-04-28','23:02:17','notenc','draft',NULL),
 (151,0x67864715DC3CB11EEC2A70F53ABE8C5F30E633815B75A8F4271A,0x33343334202066676667,0x616775646572,'2010-04-29','11:49:31','182932218998418','deleted','+'),
 (152,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031313A34393A33310A5375626A6563743A2033343334202066676667,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','11:49:31','notenc','outbox','+'),
 (153,0xB5E2F5AD9345E0298437DE6DAC21CE4F12A15468CDEE58C662A70AFDDEBD285A3AD5,0x353637382020666466646664,0x616775646572,'2010-04-29','11:50:25','208318346214332','deleted','+'),
 (154,0x4D657373616765206973206E6F742064656C69766572656420746F203A276F6265726B6572742720426563656175736520276F6265726B65727427206973206E6F74207265676973746572656420696E207468652073797374656D,0x7265706F72743A6E6F7473656E74,0x45474850502053797374656D,'2010-04-29','11:50:25','notenc','outbox','+'),
 (155,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A2033343334202066676667,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','11:51:02','notenc','outbox','+');
INSERT INTO `messaging`.`message` VALUES  (156,0xBF91EC,0x64656E656D65206F6D7572,0x61646D696E,'2010-04-29','12:21:03','214176640774087','outbox','+'),
 (157,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031323A32313A30330A5375626A6563743A2064656E656D65206F6D7572,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','12:21:03','notenc','outbox','+'),
 (158,0x807B81F6ADC70277000407A05E1EE69E3C3F06FFEEDC68F8FFEC,0x64656E656D6520706F67757A,0x61646D696E,'2010-04-29','12:23:21','227194727517728','inbox','+'),
 (159,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031323A32333A32310A5375626A6563743A2064656E656D6520706F67757A,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','12:23:21','notenc','outbox','+'),
 (160,0x4D65737361676520697320726561642066726F6D203A6F5F74756772756C0A5375626A6563743A2064656E656D6520706F67757A,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','12:23:36','notenc','outbox','+'),
 (161,0x36483391FB7AF7D1802FE058D6EE3CEBFA4E239AF8309A6B6CED,0x6861742020203738,0x61646D696E,'2010-04-29','18:03:20','238821600840280','outbox','+');
INSERT INTO `messaging`.`message` VALUES  (162,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031383A30333A32300A5375626A6563743A206861742020203738,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','18:03:20','notenc','outbox','+'),
 (163,'',0x6F72746120222074C4B1726E616B6CC4B1,0x61646D696E,'2010-04-29','18:09:31','notenc','outbox','+'),
 (164,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A61646D696E0A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031383A30393A33310A5375626A6563743A206F72746120222074C4B1726E616B6CC4B1,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','18:09:31','notenc','outbox','+'),
 (165,0x4D65737361676520697320726561642066726F6D203A61646D696E0A5375626A6563743A206F72746120222074C4B1726E616B6CC4B1,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','18:09:37','notenc','outbox','+'),
 (166,0xC59F69726B657420696C6520696C67696C6920646F7379616C6172C4B120796F6C6C61796162696C69726D6973696E0D0A,0x6261C59F6B612064656E656D65,0x61646D696E,'2010-05-01','00:26:23','notenc','inbox','+');
INSERT INTO `messaging`.`message` VALUES  (167,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2030303A32363A32330A5375626A6563743A206261C59F6B612064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','00:26:23','notenc','outbox','+'),
 (168,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A206261C59F6B612064656E656D65,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:05','notenc','outbox','+'),
 (169,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A206861742020203738,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:37','notenc','outbox','+'),
 (170,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A2064656E656D65206F6D7572,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:51','notenc','outbox','+'),
 (171,0x457672616B6C61722064757275796F72206D753F,0xC3966E656D6C69,0x616775646572,'2010-05-01','12:53:28','notenc','deleted','+'),
 (172,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031323A35333A32380A5375626A6563743A20C3966E656D6C69,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','12:53:28','notenc','outbox','+');
INSERT INTO `messaging`.`message` VALUES  (173,0x4D65737361676520697320726561642066726F6D203A6F5F74756772756C0A5375626A6563743A20C3966E656D6C69,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','12:53:49','notenc','outbox','+'),
 (174,0x68666768666768206768666866676866,0x657272727272,0x616775646572,'2010-05-01','17:37:29','notenc','deleted','+'),
 (175,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031373A33373A32390A5375626A6563743A20657272727272,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','17:37:29','notenc','outbox','+'),
 (176,0x686174616C6172C4B12067C3B6726562696C64696D2E,0x736164656365207461736C616B,0x616775646572,'2010-05-01','18:01:58','notenc','deleted','+'),
 (177,0x64656E656D65206D6573616AC4B1,0x64656E656D65,0x616775646572,'2010-05-01','18:10:22','notenc','outbox','+'),
 (178,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031383A31303A32320A5375626A6563743A2064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','18:10:22','notenc','outbox','+'),
 (179,0x627520C59F656B696C6465206461686120697969206F7475727572,0x4E6F207375626A656374,0x61646D696E,'2010-05-02','14:05:04','notenc','draft','+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;


--
-- Definition of table `messaging`.`outbox`
--

DROP TABLE IF EXISTS `messaging`.`outbox`;
CREATE TABLE  `messaging`.`outbox` (
  `outboxItem` bigint(250) NOT NULL AUTO_INCREMENT,
  `messageItem` bigint(250) NOT NULL,
  `outbox_from` varchar(200) CHARACTER SET latin5 NOT NULL,
  `user` varchar(200) COLLATE utf8_bin NOT NULL,
  `isread` char(1) CHARACTER SET latin5 NOT NULL,
  PRIMARY KEY (`outboxItem`)
) ENGINE=MyISAM AUTO_INCREMENT=263 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`outbox`
--

/*!40000 ALTER TABLE `outbox` DISABLE KEYS */;
LOCK TABLES `outbox` WRITE;
INSERT INTO `messaging`.`outbox` VALUES  (246,144,'outbox',0x616775646572,'+'),
 (247,146,'outbox',0x6F5F74756772756C,'+'),
 (262,170,'inbox',0x61646D696E,'+'),
 (250,156,'outbox',0x61646D696E,'+'),
 (248,151,'outbox',0x616775646572,'+'),
 (252,161,'outbox',0x61646D696E,'+'),
 (253,163,'outbox',0x61646D696E,'+'),
 (249,153,'outbox',0x616775646572,'+'),
 (261,177,'outbox',0x616775646572,'+');
UNLOCK TABLES;
/*!40000 ALTER TABLE `outbox` ENABLE KEYS */;


--
-- Definition of table `messaging`.`receiveMessage`
--

DROP TABLE IF EXISTS `messaging`.`receiveMessage`;
CREATE TABLE  `messaging`.`receiveMessage` (
  `receiver` varchar(200) COLLATE utf8_bin NOT NULL,
  `MessageItem` bigint(249) NOT NULL,
  `receive_date` date NOT NULL,
  `receive_time` time NOT NULL,
  `mailbox_receiver` varchar(180) CHARACTER SET latin1 DEFAULT NULL,
  `isread` char(1) CHARACTER SET latin1 DEFAULT NULL,
  `is_decrypt` char(1) CHARACTER SET latin5 DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`receiveMessage`
--

/*!40000 ALTER TABLE `receiveMessage` DISABLE KEYS */;
LOCK TABLES `receiveMessage` WRITE;
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x6F6265726B6572,144,'2010-04-28','22:57:58','inbox','+',NULL),
 (0x616775646572,145,'2010-04-28','22:57:58','inbox','-',NULL),
 (0x6F6265726B6572,146,'2010-04-28','22:59:52','inbox','+',NULL),
 (0x6F5F74756772756C,147,'2010-04-28','22:59:52','inbox','-',NULL),
 (0x6F5F74756772756C,148,'2010-04-28','23:00:29','inbox','-',NULL),
 (0x616775646572,150,'2010-04-28','23:29:12','deleted','-',NULL),
 ('',149,'2010-04-28','23:02:17','draft','+',NULL),
 (0x6F6265726B6572,151,'2010-04-29','11:49:31','inbox','+','0'),
 (0x616775646572,152,'2010-04-29','11:49:31','deleted','-',NULL),
 (0x6F6265726B657274,153,'2010-04-29','11:50:25','inbox','-','0'),
 (0x616775646572,154,'2010-04-29','11:50:25','outbox','-',NULL),
 (0x616775646572,155,'2010-04-29','11:51:02','deleted','-',NULL),
 (0x6F6265726B6572,156,'2010-04-29','12:21:03','inbox','+','0'),
 (0x61646D696E,157,'2010-04-29','12:21:03','inbox','-',NULL),
 (0x6F5F74756772756C,158,'2010-04-29','12:23:21','inbox','+','0'),
 (0x61646D696E,159,'2010-04-29','12:23:21','inbox','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x61646D696E,160,'2010-04-29','12:23:36','inbox','-',NULL),
 (0x6F6265726B6572,161,'2010-04-29','18:03:20','draft','+','0'),
 (0x61646D696E,162,'2010-04-29','18:03:20','inbox','-',NULL),
 (0x61646D696E,163,'2010-04-29','18:09:31','inbox','+','0'),
 (0x61646D696E,164,'2010-04-29','18:09:31','inbox','-',NULL),
 (0x61646D696E,165,'2010-04-29','18:09:37','inbox','-',NULL),
 (0x6F6265726B6572,166,'2010-05-01','00:26:23','inbox','+','0'),
 (0x61646D696E,167,'2010-05-01','00:26:23','inbox','-',NULL),
 (0x61646D696E,168,'2010-05-01','01:17:05','inbox','-',NULL),
 (0x61646D696E,169,'2010-05-01','01:17:37','inbox','-',NULL),
 (0x61646D696E,170,'2010-05-01','01:17:51','outbox','-',NULL),
 (0x6F5F74756772756C,171,'2010-05-01','12:53:28','inbox','+','0'),
 (0x616775646572,172,'2010-05-01','12:53:28','inbox','-',NULL),
 (0x616775646572,173,'2010-05-01','12:53:49','inbox','-',NULL),
 (0x6F6265726B6572,174,'2010-05-01','17:37:29','inbox','-','0'),
 (0x616775646572,175,'2010-05-01','17:37:29','deleted','-',NULL),
 ('',176,'2010-05-01','18:01:58','draft','+',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x616775646572,177,'2010-05-01','18:10:22','deleted','-','0'),
 (0x616775646572,178,'2010-05-01','18:10:22','inbox','-',NULL),
 (0x6F6265726B6572,179,'2010-05-02','14:05:04','draft','+',NULL),
 (0x616775646572,179,'2010-05-02','14:05:04','draft','+',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `receiveMessage` ENABLE KEYS */;


--
-- Definition of table `messaging`.`sentFile`
--

DROP TABLE IF EXISTS `messaging`.`sentFile`;
CREATE TABLE  `messaging`.`sentFile` (
  `fileItem` bigint(250) NOT NULL AUTO_INCREMENT,
  `filename` varchar(250) CHARACTER SET latin1 NOT NULL,
  `messageId` int(11) NOT NULL,
  `filesize` varchar(300) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(300) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`fileItem`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`sentFile`
--

/*!40000 ALTER TABLE `sentFile` DISABLE KEYS */;
LOCK TABLES `sentFile` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `sentFile` ENABLE KEYS */;


--
-- Definition of table `messaging`.`uploadedFile`
--

DROP TABLE IF EXISTS `messaging`.`uploadedFile`;
CREATE TABLE  `messaging`.`uploadedFile` (
  `fileItem` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(300) NOT NULL,
  `user` varchar(300) NOT NULL,
  `filesize` varchar(300) DEFAULT NULL,
  `filetype` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`fileItem`)
) ENGINE=MyISAM AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messaging`.`uploadedFile`
--

/*!40000 ALTER TABLE `uploadedFile` DISABLE KEYS */;
LOCK TABLES `uploadedFile` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `uploadedFile` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
