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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`auth_user`
--

/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
LOCK TABLES `auth_user` WRITE;
INSERT INTO `messaging`.`auth_user` VALUES  (1,'admin',0x426F7261,0x47C3BC6E67C3B672656E,'admin@portakalteknoloji.com','sha1$106cc$b6ba98d58dc03f29ca9ed70c58e18b1120d8a5b9',1,1,1,'2010-05-07 12:09:03','2010-03-06 15:15:21'),
 (10,'oberker',0xC3966DC3BC72,0x4265726B6572,'oberker@portakalteknoloji.com','sha1$16907$ee4ce3bdf847d75226572a56f39e1f527d626d96',1,1,0,'2010-05-07 12:17:58','2010-04-28 10:22:13'),
 (11,'aguder',0x416C69,0x47C3BC646572,'aguder@portakalteknoloji.com','sha1$a3dc5$7645403d60a39f757b6efe538224b2464f0bcca2',1,1,0,'2010-05-07 12:17:49','2010-04-28 10:35:19'),
 (12,'o_tugrul',0x4FC49F757A,0x5475C49F72756C,'o_tugrul@portakalteknoloji.com','sha1$4c0ab$78663b4216e6be77abc72593442c197af696615c',1,1,0,'2010-05-05 16:56:52','2010-04-28 10:45:25'),
 (13,'scanli',0x536962656C,0x43616E6CC4B1,'scanli@portakalteknoloji.com','sha1$313be$f36fd67ab3688767d5b9c5d932b55e5bc9f542fe',1,1,0,'2010-05-07 01:40:08','2010-05-06 21:32:17'),
 (14,'erdem_y',0x657264656D,0x79C4B16C6D617A,'erdem@portakalteknoloji.com','sha1$2fc6f$89b6130f8c5c537635ff38358fed1f8d2d3eb4ba',1,1,0,'2010-05-07 12:15:49','2010-05-07 09:10:32');
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
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`deleteMessage`
--

/*!40000 ALTER TABLE `deleteMessage` DISABLE KEYS */;
LOCK TABLES `deleteMessage` WRITE;
INSERT INTO `messaging`.`deleteMessage` VALUES  (107,155,'inbox',0x616775646572,'+'),
 (91,153,'outbox',0x616775646572,'+'),
 (92,174,'outbox',0x616775646572,'+'),
 (93,152,'inbox',0x616775646572,'+'),
 (102,175,'inbox',0x616775646572,'+'),
 (95,145,'inbox',0x616775646572,'+'),
 (106,176,'outbox',0x616775646572,'+'),
 (97,150,'inbox',0x616775646572,'+'),
 (115,198,'inbox',0x61646D696E,'+'),
 (99,151,'outbox',0x616775646572,'+'),
 (100,171,'outbox',0x616775646572,'+'),
 (101,145,'inbox',0x616775646572,'-'),
 (103,172,'inbox',0x616775646572,'-'),
 (104,173,'inbox',0x616775646572,'-'),
 (108,184,'inbox',0x6F6265726B6572,'+'),
 (109,166,'inbox',0x6F6265726B6572,'+'),
 (110,151,'inbox',0x6F6265726B6572,'+'),
 (111,185,'outbox',0x6F6265726B6572,'+'),
 (112,177,'outbox',0x616775646572,'+'),
 (119,228,'inbox',0x616775646572,'-'),
 (117,211,'inbox',0x61646D696E,'+'),
 (120,227,'inbox',0x616775646572,'+'),
 (122,236,'inbox',0x6F6265726B6572,'-'),
 (123,235,'inbox',0x6F6265726B6572,'-'),
 (124,225,'inbox',0x6F6265726B6572,'+'),
 (125,221,'inbox',0x6F6265726B6572,'-');
INSERT INTO `messaging`.`deleteMessage` VALUES  (126,241,'inbox',0x6F6265726B6572,'+'),
 (127,237,'inbox',0x6F6265726B6572,'+'),
 (128,5830,'outbox',0x61646D696E,'+'),
 (129,194,'inbox',0x6F6265726B6572,'-');
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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`deletedComplete`
--

/*!40000 ALTER TABLE `deletedComplete` DISABLE KEYS */;
LOCK TABLES `deletedComplete` WRITE;
INSERT INTO `messaging`.`deletedComplete` VALUES  (4,189,'inbox',0x61646D696E,'-'),
 (5,179,'inbox',0x616775646572,'+'),
 (6,177,'inbox',0x616775646572,'-'),
 (7,226,'inbox',0x6F6265726B6572,'-');
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
INSERT INTO `messaging`.`django_session` VALUES  ('df2a764bcb536daccf150b0101c684a4','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEKdS5iODg4ZTA3YmZlNTliODRkY2Mz\nY2IzNTgyMjk5MjQ4NQ==\n','2010-05-16 18:26:06'),
 ('1b3d8c71151fa5f38a167c4a7152ebd9','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS45OWU0M2I0ZWMwY2YxNGM5ZTJi\nMmNmZWNiYTA1Yjc4NA==\n','2010-05-17 17:53:55'),
 ('eba9c2efecba63b4b5b090513e42a144','gAJ9cQEuZDc0YmUxYjI3MTJmZWFlMjU2ZWQ4NmNiMjdmOTJhYjU=\n','2010-05-21 00:13:32'),
 ('9b27f501858d03827ad0c2151c5a63dd','gAJ9cQEuZDc0YmUxYjI3MTJmZWFlMjU2ZWQ4NmNiMjdmOTJhYjU=\n','2010-05-21 09:18:57');
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
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`draft`
--

/*!40000 ALTER TABLE `draft` DISABLE KEYS */;
LOCK TABLES `draft` WRITE;
INSERT INTO `messaging`.`draft` VALUES  (73,161,'inbox',0x6F6265726B6572,'+'),
 (72,154,'inbox',0x616775646572,'+'),
 (71,149,'outbox',0x6F5F74756772756C,'+'),
 (89,199,'outbox',0x61646D696E,'+'),
 (90,194,'outbox',0x61646D696E,'+'),
 (91,207,'inbox',0x61646D696E,'+'),
 (92,201,'inbox',0x61646D696E,'+'),
 (93,216,'outbox',0x616775646572,'+'),
 (80,179,'outbox',0x61646D696E,'+'),
 (97,217,'inbox',0x6F6265726B6572,'+');
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
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin5;

--
-- Dumping data for table `messaging`.`draftToReceiver`
--

/*!40000 ALTER TABLE `draftToReceiver` DISABLE KEYS */;
LOCK TABLES `draftToReceiver` WRITE;
INSERT INTO `messaging`.`draftToReceiver` VALUES  (30,149,'draft','','+'),
 (31,176,'draft','','+'),
 (32,179,'draft',0x6F6265726B6572,'+'),
 (33,179,'draft',0x616775646572,'+'),
 (34,199,'draft',0x66676667,'+'),
 (35,216,'draft','','+'),
 (36,5830,'draft','','+');
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
INSERT INTO `messaging`.`employee` VALUES  (23564589947,0xC3966DC3BC72,0x4265726B6572,3032788566394,4521124777,0x4F6474C3BC20536974657369,0x5475726B6579,0x34323235363131,0x6F6265726B657240686F746D61696C2E636F6D),
 (14559625771,0x457264656D,0x59C4B16C6D617A,2236833319452,8998475474,0x45746C696B,0x5475726B6579,0x33343536373233,0x657264656D40676D61696C2E636F6D),
 (11458994325,0x4FC49F757A,0x5475C49F72756C,3448923465197,4565762884,0xC39C6D69746BC3B679,0x5475726B6579,0x32333531313330,0x6F5F74756772756C40686F746D61696C2E636F6D),
 (45127834257,0x416C69,0x47C3BC646572,3437224490253,6567766884,0x42696C6B656E742D33,0x5475726B6579,0x32333331323334,0x61677564657240686F746D61696C2E636F6D),
 (15895045348,0x5975737566,0x42696C67696E,3435892126713,7885558896,0x4B65C3A769C3B672656E,0x5475726B6579,0x33353632333131,0x797573756662696C40676D61696C2E636F6D),
 (22848725206,0x536962656C,0x43616E6CC4B1,4556225671772,4657331930,0x426168C3A7656C6965766C6572,0x5475726B6579,0x32333331323435,0x736962656C40686F746D61696C2E636F6D);
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
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`guest`
--

/*!40000 ALTER TABLE `guest` DISABLE KEYS */;
LOCK TABLES `guest` WRITE;
INSERT INTO `messaging`.`guest` VALUES  (24,23564589947,0xC3966DC3BC72,0x4265726B6572,3032,4521,0x5475726B6579,0x34323235363131,0x6F6265726B657240686F746D61696C2E636F6D,'2010-04-28','13:18:32',0x617070726F766564),
 (25,45127834257,0x416C69,0x47C3BC646572,1112,2312,0x5475726B6579,0x32333331323334,0x61677564657240686F746D61696C2E636F6D,'2010-04-28','13:33:33',0x617070726F766564),
 (27,11458994325,0x4FC49F757A,0x5475C49F72756C,3412,2310,0x5475726B6579,0x32333531313330,0x6F5F74756772756C40686F746D61696C2E636F6D,'2010-04-28','13:43:36',0x617070726F766564),
 (33,22848725206,0x536962656C,0x43616E6CC4B1,4556225671772,4657331930,0x5475726B6579,0x32333331323435,0x736962656C40686F746D61696C2E636F6D,'2010-05-07','00:29:44',0x617070726F766564),
 (38,14559625771,0x457264656D,0x59C4B16C6D617A,2236833319452,8998475474,0x5475726B6579,0x33343536373233,0x657264656D40676D61696C2E636F6D,'2010-05-07','12:07:12',0x617070726F766564),
 (39,15895045348,0x5975737566,0x42696C67696E6572,3435892126713,788555896,0x5475726B6579,0x33353632333131,0x797573756662696C40676D61696C2E636F6D,'2010-05-07','12:08:31',0x646973617070726F766564);
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
) ENGINE=MyISAM AUTO_INCREMENT=629 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`inbox`
--

/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
LOCK TABLES `inbox` WRITE;
INSERT INTO `messaging`.`inbox` VALUES  (506,144,'inbox',0x6F6265726B6572,'+'),
 (545,181,'inbox',0x616775646572,'-'),
 (508,146,'inbox',0x6F6265726B6572,'+'),
 (509,147,'inbox',0x6F5F74756772756C,'+'),
 (510,148,'inbox',0x6F5F74756772756C,'+'),
 (511,150,'inbox',0x616775646572,'-'),
 (549,185,'inbox',0x616775646572,'-'),
 (513,152,'inbox',0x616775646572,'-'),
 (514,153,'inbox',0x6F6265726B657274,'-'),
 (515,154,'inbox',0x616775646572,'+'),
 (543,177,'outbox',0x616775646572,'+'),
 (517,156,'inbox',0x6F6265726B6572,'+'),
 (518,157,'inbox',0x61646D696E,'-'),
 (519,158,'inbox',0x6F5F74756772756C,'+'),
 (520,159,'inbox',0x61646D696E,'-'),
 (521,160,'inbox',0x61646D696E,'-'),
 (523,162,'inbox',0x61646D696E,'+'),
 (524,163,'inbox',0x61646D696E,'+'),
 (525,164,'inbox',0x61646D696E,'+'),
 (526,165,'inbox',0x61646D696E,'-'),
 (550,186,'inbox',0x6F6265726B6572,'-'),
 (529,167,'inbox',0x61646D696E,'+'),
 (530,168,'inbox',0x61646D696E,'+'),
 (531,169,'inbox',0x61646D696E,'+'),
 (533,171,'inbox',0x6F5F74756772756C,'+'),
 (544,180,'inbox',0x6F6265726B6572,'+');
INSERT INTO `messaging`.`inbox` VALUES  (542,155,'inbox',0x616775646572,'+'),
 (536,174,'inbox',0x6F6265726B6572,'-'),
 (539,178,'inbox',0x616775646572,'-'),
 (540,166,'outbox',0x61646D696E,'+'),
 (541,158,'outbox',0x61646D696E,'+'),
 (546,182,'inbox',0x616775646572,'-'),
 (547,183,'inbox',0x616775646572,'-'),
 (551,187,'inbox',0x6F6265726B6572,'-'),
 (552,188,'inbox',0x6F6265726B6572,'+'),
 (555,190,'inbox',0x6F5F74756772756C,'+'),
 (556,191,'inbox',0x616775646572,'+'),
 (557,192,'inbox',0x616775646572,'+'),
 (558,193,'inbox',0x61646D696E,'-'),
 (559,194,'inbox',0x616775646572,'+'),
 (560,195,'inbox',0x61646D696E,'+'),
 (624,5831,'inbox',0x616775646572,'+'),
 (562,196,'inbox',0x61646D696E,'-'),
 (563,197,'inbox',0x616775646572,'+'),
 (565,200,'inbox',0x616775646572,'-'),
 (575,210,'inbox',0x616775646572,'+'),
 (567,202,'inbox',0x61646D696E,'-'),
 (568,203,'inbox',0x61646D696E,'-'),
 (625,5832,'inbox',0x6F6265726B6572,'-'),
 (570,205,'inbox',0x61646D696E,'+'),
 (571,206,'inbox',0x6F5F74756772756C,'-'),
 (578,212,'inbox',0x61646D696E,'+');
INSERT INTO `messaging`.`inbox` VALUES  (626,5831,'inbox',0x6F5F74756772756C,'-'),
 (574,209,'inbox',0x616775646572,'+'),
 (579,213,'inbox',0x616775646572,'+'),
 (580,214,'inbox',0x61646D696E,'+'),
 (581,215,'inbox',0x61646D696E,'+'),
 (583,218,'inbox',0x61646D696E,'+'),
 (584,219,'inbox',0x61646D696E,'-'),
 (585,220,'inbox',0x6F5F74756772756C,'-'),
 (591,222,'inbox',0x616775646572,'-'),
 (588,223,'inbox',0x616775646572,'+'),
 (589,224,'inbox',0x6572726574,'-'),
 (600,234,'inbox',0x616775646572,'+'),
 (595,229,'inbox',0x61646D696E,'+'),
 (596,230,'inbox',0x616775646572,'+'),
 (597,231,'inbox',0x616775646572,'+'),
 (598,232,'inbox',0x61646D696E,'-'),
 (599,233,'inbox',0x61646D696E,'-'),
 (602,234,'inbox',0x6F5F74756772756C,'-'),
 (605,238,'inbox',0x616775646572,'+'),
 (606,239,'inbox',0x616775646572,'+'),
 (607,240,'inbox',0x616775646572,'+'),
 (609,242,'inbox',0x616775646572,'+'),
 (610,243,'inbox',0x6F5F74756772756C,'-'),
 (611,244,'inbox',0x616775646572,'+'),
 (612,245,'inbox',0x6F5F74756772756C,'-'),
 (613,246,'inbox',0x616775646572,'+');
INSERT INTO `messaging`.`inbox` VALUES  (614,247,'inbox',0x61646D696E,'+'),
 (615,248,'inbox',0x61646D696E,'+'),
 (616,249,'inbox',0x616775646572,'+'),
 (617,248,'inbox',0x6F5F74756772756C,'-'),
 (618,250,'inbox',0x616775646572,'+'),
 (619,251,'inbox',0x616775646572,'-'),
 (621,253,'inbox',0x616775646572,'-'),
 (623,255,'inbox',0x616775646572,'-'),
 (622,254,'inbox',0x616775646572,'-'),
 (627,5833,'inbox',0x6F6265726B6572,'+'),
 (628,5834,'inbox',0x6F6265726B6572,'+');
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
) ENGINE=MyISAM AUTO_INCREMENT=5835 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`message`
--

/*!40000 ALTER TABLE `message` DISABLE KEYS */;
LOCK TABLES `message` WRITE;
INSERT INTO `messaging`.`message` VALUES  (144,0xBB6C10485D0835,0x4E6F205375626A656374,0x616775646572,'2010-04-28','22:57:58','181635827316177','outbox',NULL),
 (146,0xFF6454EA03A6536DF253CC10EE19B8E1,0x696C6B206D6573616A,0x6F5F74756772756C,'2010-04-28','22:59:52','197714263444783','outbox',NULL),
 (147,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32380A526563656976652054696D653A2032323A35393A35320A5375626A6563743A20696C6B206D6573616A,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-28','22:59:52','notenc','outbox',NULL),
 (148,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A20696C6B206D6573616A,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-28','23:00:29','notenc','outbox',NULL),
 (150,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-28','23:29:12','notenc','outbox',NULL),
 (152,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031313A34393A33310A5375626A6563743A2033343334202066676667,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','11:49:31','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (153,0xB5E2F5AD9345E0298437DE6DAC21CE4F12A15468CDEE58C662A70AFDDEBD285A3AD5,0x353637382020666466646664,0x616775646572,'2010-04-29','11:50:25','208318346214332','deleted',NULL),
 (154,0x4D657373616765206973206E6F742064656C69766572656420746F203A276F6265726B6572742720426563656175736520276F6265726B65727427206973206E6F74207265676973746572656420696E207468652073797374656D,0x7265706F72743A6E6F7473656E74,0x45474850502053797374656D,'2010-04-29','11:50:25','notenc','outbox',NULL),
 (156,0xBF91EC,0x64656E656D65206F6D7572,0x61646D696E,'2010-04-29','12:21:03','214176640774087','outbox',NULL),
 (157,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031323A32313A30330A5375626A6563743A2064656E656D65206F6D7572,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','12:21:03','notenc','outbox',NULL),
 (158,0x807B81F6ADC70277,0x64656E656D6520706F67757A,0x61646D696E,'2010-04-29','12:23:21','227194727517728','inbox',NULL),
 (159,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031323A32333A32310A5375626A6563743A2064656E656D6520706F67757A,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','12:23:21','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (160,0x4D65737361676520697320726561642066726F6D203A6F5F74756772756C0A5375626A6563743A2064656E656D6520706F67757A,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','12:23:36','notenc','outbox',NULL),
 (162,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031383A30333A32300A5375626A6563743A206861742020203738,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','18:03:20','notenc','outbox',NULL),
 (163,'',0x6F72746120222074C4B1726E616B6CC4B1,0x61646D696E,'2010-04-29','18:09:31','notenc','outbox',NULL),
 (164,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A61646D696E0A5265636569766520446174653A20323031302D30342D32390A526563656976652054696D653A2031383A30393A33310A5375626A6563743A206F72746120222074C4B1726E616B6CC4B1,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-29','18:09:31','notenc','outbox',NULL),
 (165,0x4D65737361676520697320726561642066726F6D203A61646D696E0A5375626A6563743A206F72746120222074C4B1726E616B6CC4B1,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','18:09:37','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (167,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2030303A32363A32330A5375626A6563743A206261C59F6B612064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','00:26:23','notenc','outbox',NULL),
 (168,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A206261C59F6B612064656E656D65,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:05','notenc','outbox',NULL),
 (169,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A206861742020203738,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:37','notenc','outbox',NULL),
 (171,0x457672616B6C61722064757275796F72206D753F,0xC3966E656D6C69,0x616775646572,'2010-05-01','12:53:28','notenc','deleted',NULL),
 (174,0x68666768666768206768666866676866,0x657272727272,0x616775646572,'2010-05-01','17:37:29','notenc','deleted',NULL),
 (178,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031383A31303A32320A5375626A6563743A2064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','18:10:22','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (166,0xC59F69726B657420696C6520696C67696C6920646F7379616C6172C4B120796F6C6C61796162696C69726D6973696E0D0A,0x6261C59F6B612064656E656D65,0x61646D696E,'2010-05-01','00:26:23','notenc','inbox',NULL),
 (155,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A2033343334202066676667,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-04-29','11:51:02','notenc','outbox',NULL),
 (177,0x64656E656D65206D6573616AC4B1,0x64656E656D65,0x616775646572,'2010-05-01','18:10:22','notenc','inbox',NULL),
 (180,0xD726F7611A2E35,0x646F73796120697369,0x616775646572,'2010-05-02','21:17:37','290633040714160','outbox',NULL),
 (181,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30320A526563656976652054696D653A2032313A31373A33370A5375626A6563743A20646F73796120697369,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-02','21:17:37','notenc','outbox',NULL),
 (182,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A20646F73796120697369,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-02','21:26:08','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (183,0x6FD37562AEE9D7157E62D1CFF383CE0B987084,0x696B6920646F737961,0x6F6265726B6572,'2010-05-02','21:31:20','197121528861108','outbox',NULL),
 (185,0x5566616B206269722070726F626D6C656D207661722073616E6B692E2042616B6162696C69726D6973696E2E20,0x42697220736F72756E,0x6F6265726B6572,'2010-05-02','22:00:49','notenc','deleted',NULL),
 (186,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30320A526563656976652054696D653A2032323A30303A34390A5375626A6563743A2042697220736F72756E,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-02','22:00:49','notenc','outbox',NULL),
 (187,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A20696B6920646F737961,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-02','22:11:40','notenc','outbox',NULL),
 (188,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A2042697220736F72756E,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-02','22:20:51','notenc','outbox',NULL),
 (190,0xC59F7520646F73796179C4B12067C3B66E6465726562696C69726D6973696E,0x22C3B66E656D6C6922,0x616775646572,'2010-05-03','01:01:49','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (191,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030313A30313A34390A5375626A6563743A2022C3B66E656D6C6922,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','01:01:49','notenc','outbox',NULL),
 (192,0x62697220277365792064656E6564696D206F6C6163616B2067696269,0x2768617461796C6120696C67696C6927,0x61646D696E,'2010-05-03','01:45:47','notenc','outbox',NULL),
 (193,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030313A34353A34370A5375626A6563743A202768617461796C6120696C67696C6927,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','01:45:47','notenc','outbox',NULL),
 (194,0x134A45E19FE52A43A211E4586A5D27E06AA3BE2D90E850A9A83A81,0x27C59F696672656C692064656E656D6527,0x61646D696E,'2010-05-03','01:47:10','309084826187424','draft',NULL),
 (195,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030313A34373A31300A5375626A6563743A2027C59F696672656C692064656E656D6527,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','01:47:10','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (196,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030313A34373A31300A5375626A6563743A2027C59F696672656C692064656E656D6527,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','01:47:10','notenc','outbox',NULL),
 (197,0x105E83EA896C0E5DC65BE9D041D0CAE1C7D1078387BB88EE,0x6261C59F6B612069C59F,0x61646D696E,'2010-05-03','01:49:00','213822497166651','outbox',NULL),
 (200,0x4D65737361676520697320726561642066726F6D203A6F5F74756772756C0A5375626A6563743A2022C3B66E656D6C6922,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','09:57:56','notenc','outbox',NULL),
 (202,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A61646D696E0A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031303A31313A32360A5375626A6563743A20C3B6C3B6C3A7,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','10:11:26','notenc','outbox',NULL),
 (203,0x4D65737361676520697320726561642066726F6D203A61646D696E0A5375626A6563743A20C3B6C3B6C3A7,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','10:11:35','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (204,0xF915590901F5,0x78646466,0x61646D696E,'2010-05-03','10:40:16','263910437455765','outbox',NULL),
 (205,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031303A34303A31360A5375626A6563743A2078646466,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','10:40:16','notenc','outbox',NULL),
 (206,0x171D,0x666768,0x61646D696E,'2010-05-03','10:56:40','204298137427409','outbox',NULL),
 (208,0x3B11D3AEBD5E,0x64656E656D6531,0x616775646572,'2010-05-03','12:10:00','179863372372848','outbox',NULL),
 (209,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031323A31303A30300A5375626A6563743A2064656E656D6531,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','12:10:00','notenc','outbox',NULL),
 (210,0x9EFEB6E0906E177D05469F,0x64656565,0x61646D696E,'2010-05-03','13:19:44','199200865516246','outbox',NULL),
 (212,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A2064656565,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','13:20:27','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (213,0x6805E21866B02270C0C5D5,0x4E6F205375626A656374,0x61646D696E,'2010-05-03','14:04:56','252213791928725','outbox',NULL),
 (214,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031343A30343A35360A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','14:04:56','notenc','outbox',NULL),
 (215,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','14:05:27','notenc','outbox',NULL),
 (218,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031343A31313A34310A5375626A6563743A207765,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','14:11:41','notenc','outbox',NULL),
 (219,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A207765,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','14:31:29','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (220,0x2E,0x676867686768,0x6F6265726B6572,'2010-05-03','14:32:51','180363511335167','outbox',NULL),
 (223,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031343A34323A30360A5375626A6563743A2068636668,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','14:42:06','notenc','outbox',NULL),
 (224,'',0x7864666467,0x6F6265726B6572,'2010-05-03','14:50:50','notenc','outbox',NULL),
 (222,0xD8FF8269E5EC0584D4,0x68636668,0x616775646572,'2010-05-03','14:42:06','308863902935828','outbox',NULL),
 (229,0x6867686A676A6B676A676A,0x4E6F205375626A656374,0x616775646572,'2010-05-03','16:37:36','notenc','outbox',NULL),
 (230,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A61646D696E0A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031363A33373A33360A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','16:37:36','notenc','outbox',NULL),
 (231,0x4D65737361676520697320726561642066726F6D203A61646D696E0A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','21:06:45','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (232,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A2027C59F696672656C692064656E656D6527,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','12:03:06','notenc','outbox',NULL),
 (233,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A202768617461796C6120696C67696C6927,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','12:04:52','notenc','outbox',NULL),
 (234,0x776219743531F292CE,0x4E6F205375626A656374,0x6F6265726B6572,'2010-05-06','14:10:18','175163520775521','outbox',NULL),
 (238,0x67686A68676A670D0A373637353637,0x6E6F207669,0x616775646572,'2010-05-06','14:15:00','notenc','outbox',NULL),
 (239,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031343A31353A30300A5375626A6563743A206E6F207669,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','14:15:00','notenc','outbox',NULL),
 (240,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A206E6F207669,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','14:15:05','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (242,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031343A35303A35390A5375626A6563743A2066676B6C,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','14:50:59','notenc','outbox',NULL),
 (243,0x676867203637,0x64656E656D6532,0x616775646572,'2010-05-06','19:45:08','notenc','outbox',NULL),
 (244,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031393A34353A30380A5375626A6563743A2064656E656D6532,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','19:45:08','notenc','outbox',NULL),
 (245,0x0D0A54616BC4B16DC4B16DC4B17A3A0D0A416C692047C3BC6465720D0A4FC49F757A205475C49F72756C0D0AC3966DC3BC72204265726B6572,0x64656E656D65322074656B726172,0x616775646572,'2010-05-06','19:46:31','notenc','outbox',NULL),
 (246,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031393A34363A33310A5375626A6563743A2064656E656D65322074656B726172,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','19:46:31','notenc','outbox',NULL),
 (247,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A206261C59F6B612069C59F,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','20:32:43','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (248,0xFF95155C75591AF812997C7A8C1BF49CD2502B8FDB270DE538E6CA1F81709D5190FC86ECB053E5DE60894C8AC9233BD24A44F3F99C990A,0x64656E656D6533,0x616775646572,'2010-05-06','20:51:39','242739843473192','outbox',NULL),
 (249,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A61646D696E0A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2032303A35313A33390A5375626A6563743A2064656E656D6533,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','20:51:39','notenc','outbox',NULL),
 (250,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2032303A35313A33390A5375626A6563743A2064656E656D6533,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','20:51:39','notenc','outbox',NULL),
 (251,0x4D65737361676520697320726561642066726F6D203A61646D696E0A5375626A6563743A2064656E656D6533,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','21:01:38','notenc','outbox',NULL),
 (253,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2032333A32323A32320A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','23:22:22','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (254,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A2066676B6C,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','23:42:13','notenc','outbox',NULL),
 (255,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-07','01:33:13','notenc','outbox',NULL),
 (151,0x67864715DC3CB11EEC2A70F53ABE8C5F30E633815B75A8F4271A,0x33343334202066676667,0x616775646572,'2010-04-29','11:49:31','182932218998418','deleted',NULL),
 (161,0x36483391FB7AF7D1802FE058D6EE3CEBFA4E239AF8309A6B6CED,0x6861742020203738,0x61646D696E,'2010-04-29','18:03:20','238821600840280','outbox',NULL),
 (170,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A2064656E656D65206F6D7572,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','01:17:51','notenc','outbox',NULL),
 (179,0x627520C59F656B696C6465206461686120697969206F7475727572,0x4E6F207375626A656374,0x61646D696E,'2010-05-02','14:05:04','notenc','draft',NULL),
 (201,0x527C083FFB4B,0xC3B6C3B6C3A7,0x61646D696E,'2010-05-03','10:11:26','299471363185294','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (217,0x7A66FB793E3988CFDA,0x7765,0x61646D696E,'2010-05-03','14:11:41','296100533315581','outbox',NULL),
 (226,0x242104EC73098ED7048D5901,0x666467646667,0x616775646572,'2010-05-03','15:47:38','265675381794078','outbox',NULL),
 (241,0x686A0D0A626E,0x66676B6C,0x616775646572,'2010-05-06','14:50:59','notenc','outbox',NULL),
 (252,0xAC96787C2F26ED7AF5F73598138451AFE01B5BA8E95A8E5F9AE1F9F9C2F11F30B8440761300F570B2A7B,0x4E6F205375626A656374,0x616775646572,'2010-05-06','23:22:22','186032912692801','outbox',NULL),
 (149,0x6A6B6C,0x4E6F207375626A656374,0x6F5F74756772756C,'2010-04-28','23:02:17','notenc','draft',NULL),
 (199,0x427520646120276F6C6163616B,0x276F6C6163616B27,0x61646D696E,'2010-05-03','02:20:14','notenc','outbox',NULL),
 (207,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031303A35363A34300A5375626A6563743A20666768,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','10:56:40','notenc','outbox',NULL),
 (216,0x646673646664,0x4E6F207375626A656374,0x616775646572,'2010-05-03','14:06:08','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (145,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30342D32380A526563656976652054696D653A2032323A35373A35380A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-04-28','22:57:58','notenc','outbox',NULL),
 (175,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031373A33373A32390A5375626A6563743A20657272727272,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','17:37:29','notenc','outbox',NULL),
 (172,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30310A526563656976652054696D653A2031323A35333A32380A5375626A6563743A20C3966E656D6C69,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-01','12:53:28','notenc','outbox',NULL),
 (173,0x4D65737361676520697320726561642066726F6D203A6F5F74756772756C0A5375626A6563743A20C3966E656D6C69,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-01','12:53:49','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (176,0x686174616C6172C4B12067C3B6726562696C64696D2E,0x736164656365207461736C616B,0x616775646572,'2010-05-01','18:01:58','notenc','deleted',NULL),
 (184,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30320A526563656976652054696D653A2032313A33313A32300A5375626A6563743A20696B6920646F737961,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-02','21:31:20','notenc','outbox',NULL),
 (198,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030313A34393A30300A5375626A6563743A206261C59F6B612069C59F,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','01:49:00','notenc','outbox',NULL),
 (211,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031333A31393A34340A5375626A6563743A2064656565,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','13:19:44','notenc','outbox',NULL),
 (228,0x4D65737361676520697320726561642066726F6D203A6F6265726B65720A5375626A6563743A20666467646667,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-03','15:48:30','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (227,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F6265726B65720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031353A34373A33380A5375626A6563743A20666467646667,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','15:47:38','notenc','outbox',NULL),
 (236,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031343A31303A31380A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','14:10:18','notenc','outbox',NULL),
 (235,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30360A526563656976652054696D653A2031343A31303A31380A5375626A6563743A204E6F205375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-06','14:10:18','notenc','outbox',NULL),
 (225,0x4D657373616765206973206E6F742064656C69766572656420746F203A276572726574272042656365617573652027657272657427206973206E6F74207265676973746572656420696E207468652073797374656D,0x7265706F72743A6E6F7473656E74,0x45474850502053797374656D,'2010-05-03','14:50:50','notenc','outbox',NULL);
INSERT INTO `messaging`.`message` VALUES  (221,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2031343A33323A35310A5375626A6563743A20676867686768,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','14:32:51','notenc','outbox',NULL),
 (237,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A204E6F205375626A656374,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-06','14:10:38','notenc','outbox',NULL),
 (189,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30330A526563656976652054696D653A2030303A34313A33380A5375626A6563743A204E6F207375626A656374,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-03','00:41:38','notenc','outbox',NULL),
 (5830,0x7461736C616B20736F6E72612067C3B66E6465726963656D0D0A42696C67696E697A65,0x736F6E72612067656C6963656B,0x61646D696E,'2010-05-07','03:04:18','notenc','deleted','+'),
 (5831,0x57531948335F4452BAD616990511069B69854B76F15C0E3F68E199BAE2CD3DA36188A5,0x64656E656D65,0x6F6265726B6572,'2010-05-07','12:17:23','170874488419490','outbox','+');
INSERT INTO `messaging`.`message` VALUES  (5832,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6167756465720A5265636569766520446174653A20323031302D30352D30370A526563656976652054696D653A2031323A31373A32330A5375626A6563743A2064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-07','12:17:23','notenc','outbox','+'),
 (5833,0x4D6573736167652069732073656E74207375636365737366756C6C7920746F203A6F5F74756772756C0A5265636569766520446174653A20323031302D30352D30370A526563656976652054696D653A2031323A31373A32330A5375626A6563743A2064656E656D65,0x7265706F72743A73656E74,0x45474850502053797374656D,'2010-05-07','12:17:23','notenc','outbox','+'),
 (5834,0x4D65737361676520697320726561642066726F6D203A6167756465720A5375626A6563743A2064656E656D65,0x7265706F72743A72656164,0x45474850502053797374656D,'2010-05-07','12:17:52','notenc','outbox','+');
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
) ENGINE=MyISAM AUTO_INCREMENT=298 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`outbox`
--

/*!40000 ALTER TABLE `outbox` DISABLE KEYS */;
LOCK TABLES `outbox` WRITE;
INSERT INTO `messaging`.`outbox` VALUES  (263,144,'outbox',0x616775646572,'+'),
 (247,146,'outbox',0x6F5F74756772756C,'+'),
 (248,151,'outbox',0x616775646572,'+'),
 (249,153,'outbox',0x616775646572,'+'),
 (250,156,'outbox',0x61646D696E,'+'),
 (252,161,'outbox',0x61646D696E,'+'),
 (253,163,'outbox',0x61646D696E,'+'),
 (264,180,'outbox',0x616775646572,'+'),
 (262,170,'inbox',0x61646D696E,'+'),
 (265,183,'outbox',0x6F6265726B6572,'+'),
 (268,179,'outbox',0x61646D696E,'+'),
 (269,190,'outbox',0x616775646572,'+'),
 (270,192,'outbox',0x61646D696E,'+'),
 (273,201,'outbox',0x61646D696E,'+'),
 (272,197,'outbox',0x61646D696E,'+'),
 (274,204,'outbox',0x61646D696E,'+'),
 (275,206,'outbox',0x61646D696E,'+'),
 (276,208,'outbox',0x616775646572,'+'),
 (277,210,'outbox',0x61646D696E,'+'),
 (278,213,'outbox',0x61646D696E,'+'),
 (279,217,'outbox',0x61646D696E,'+'),
 (290,245,'outbox',0x616775646572,'+'),
 (281,222,'outbox',0x616775646572,'+'),
 (282,224,'outbox',0x6F6265726B6572,'+'),
 (283,226,'outbox',0x616775646572,'+'),
 (284,229,'outbox',0x616775646572,'+');
INSERT INTO `messaging`.`outbox` VALUES  (286,234,'outbox',0x6F6265726B6572,'+'),
 (287,238,'outbox',0x616775646572,'+'),
 (288,241,'outbox',0x616775646572,'+'),
 (289,243,'outbox',0x616775646572,'+'),
 (280,220,'outbox',0x6F6265726B6572,'+'),
 (291,248,'outbox',0x616775646572,'+'),
 (292,252,'outbox',0x616775646572,'+'),
 (294,252,'inbox',0x6F6265726B6572,'+'),
 (295,208,'inbox',0x6F6265726B6572,'-'),
 (296,204,'inbox',0x6F6265726B6572,'-'),
 (297,5831,'outbox',0x6F6265726B6572,'+');
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
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x616775646572,255,'2010-05-07','01:33:13','inbox','-',NULL),
 (0x616775646572,145,'2010-04-28','22:57:58','inbox','-',NULL),
 (0x6F6265726B6572,146,'2010-04-28','22:59:52','inbox','+',NULL),
 (0x6F5F74756772756C,147,'2010-04-28','22:59:52','inbox','-',NULL),
 (0x6F5F74756772756C,148,'2010-04-28','23:00:29','inbox','-',NULL),
 (0x616775646572,150,'2010-04-28','23:29:12','deleted','-',NULL),
 (0x6F6265726B6572,151,'2010-04-29','11:49:31','deleted','+',NULL),
 (0x616775646572,152,'2010-04-29','11:49:31','deleted','-',NULL),
 (0x6F6265726B657274,153,'2010-04-29','11:50:25','inbox','-',NULL),
 (0x616775646572,154,'2010-04-29','11:50:25','outbox','-',NULL),
 (0x616775646572,155,'2010-04-29','11:51:02','deleted','-',NULL),
 (0x6F6265726B6572,156,'2010-04-29','12:21:03','inbox','+',NULL),
 (0x61646D696E,157,'2010-04-29','12:21:03','inbox','-',NULL),
 (0x6F5F74756772756C,158,'2010-04-29','12:23:21','inbox','+',NULL),
 (0x61646D696E,159,'2010-04-29','12:23:21','inbox','-',NULL),
 (0x61646D696E,160,'2010-04-29','12:23:36','inbox','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x61646D696E,162,'2010-04-29','18:03:20','inbox','-',NULL),
 (0x61646D696E,163,'2010-04-29','18:09:31','inbox','+',NULL),
 (0x61646D696E,164,'2010-04-29','18:09:31','inbox','-',NULL),
 (0x61646D696E,165,'2010-04-29','18:09:37','inbox','-',NULL),
 (0x6F6265726B6572,166,'2010-05-01','00:26:23','deleted','+',NULL),
 (0x61646D696E,167,'2010-05-01','00:26:23','inbox','-',NULL),
 (0x61646D696E,168,'2010-05-01','01:17:05','inbox','-',NULL),
 (0x61646D696E,169,'2010-05-01','01:17:37','inbox','-',NULL),
 (0x6F5F74756772756C,171,'2010-05-01','12:53:28','inbox','+',NULL),
 (0x616775646572,172,'2010-05-01','12:53:28','deleted','-',NULL),
 (0x616775646572,173,'2010-05-01','12:53:49','deleted','-',NULL),
 (0x6F6265726B6572,174,'2010-05-01','17:37:29','inbox','-',NULL),
 (0x616775646572,178,'2010-05-01','18:10:22','inbox','-',NULL),
 (0x6F6265726B6572,161,'2010-04-29','18:03:20','draft','+',NULL),
 (0x616775646572,177,'2010-05-01','18:10:22','deletedcomplete','-',NULL),
 (0x61646D696E,170,'2010-05-01','01:17:51','outbox','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  ('',149,'2010-04-28','23:02:17','draft','+',NULL),
 (0x6F6265726B6572,179,'2010-05-02','14:05:04','draft','+',NULL),
 (0x616775646572,175,'2010-05-01','17:37:29','inbox','-',NULL),
 ('',176,'2010-05-01','18:01:58','draft','+',NULL),
 (0x616775646572,179,'2010-05-02','14:05:04','deletedcomplete','+',NULL),
 (0x6F6265726B6572,180,'2010-05-02','21:17:37','inbox','+','0'),
 (0x616775646572,181,'2010-05-02','21:17:37','inbox','-',NULL),
 (0x616775646572,182,'2010-05-02','21:26:08','inbox','-',NULL),
 (0x616775646572,183,'2010-05-02','21:31:20','inbox','-','0'),
 (0x6F6265726B6572,184,'2010-05-02','21:31:20','inbox','-',NULL),
 (0x616775646572,185,'2010-05-02','22:00:49','inbox','-','0'),
 (0x6F6265726B6572,186,'2010-05-02','22:00:49','inbox','-',NULL),
 (0x6F6265726B6572,187,'2010-05-02','22:11:40','inbox','-',NULL),
 (0x6F6265726B6572,188,'2010-05-02','22:20:51','inbox','-',NULL),
 (0x616775646572,179,'2010-05-03','00:41:38','deletedcomplete','-','0'),
 (0x61646D696E,189,'2010-05-03','00:41:38','deletedcomplete','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x6F5F74756772756C,190,'2010-05-03','01:01:49','inbox','+','0'),
 (0x616775646572,191,'2010-05-03','01:01:49','inbox','-',NULL),
 (0x616775646572,192,'2010-05-03','01:45:47','inbox','+','0'),
 (0x61646D696E,193,'2010-05-03','01:45:47','inbox','-',NULL),
 (0x616775646572,194,'2010-05-03','01:47:10','inbox','+','0'),
 (0x61646D696E,195,'2010-05-03','01:47:10','inbox','-',NULL),
 (0x6F6265726B6572,194,'2010-05-03','01:47:10','deleted','-','0'),
 (0x61646D696E,196,'2010-05-03','01:47:10','inbox','-',NULL),
 (0x616775646572,197,'2010-05-03','01:49:00','inbox','+','0'),
 (0x61646D696E,198,'2010-05-03','01:49:00','deleted','-',NULL),
 (0x66676667,199,'2010-05-03','02:20:14','draft','+',NULL),
 (0x616775646572,200,'2010-05-03','09:57:56','inbox','-',NULL),
 (0x61646D696E,201,'2010-05-03','10:11:26','draft','+','0'),
 (0x61646D696E,202,'2010-05-03','10:11:26','inbox','-',NULL),
 (0x61646D696E,203,'2010-05-03','10:11:35','inbox','-',NULL),
 (0x6F6265726B6572,204,'2010-05-03','10:40:16','outbox','-','0'),
 (0x61646D696E,205,'2010-05-03','10:40:16','inbox','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x6F5F74756772756C,206,'2010-05-03','10:56:40','inbox','-','0'),
 (0x61646D696E,207,'2010-05-03','10:56:40','draft','-',NULL),
 (0x6F6265726B6572,208,'2010-05-03','12:10:00','outbox','-','0'),
 (0x616775646572,209,'2010-05-03','12:10:00','inbox','-',NULL),
 (0x616775646572,210,'2010-05-03','13:19:44','inbox','+','0'),
 (0x61646D696E,211,'2010-05-03','13:19:44','deleted','-',NULL),
 (0x61646D696E,212,'2010-05-03','13:20:27','inbox','-',NULL),
 (0x616775646572,213,'2010-05-03','14:04:56','inbox','+','0'),
 (0x61646D696E,214,'2010-05-03','14:04:56','inbox','-',NULL),
 (0x61646D696E,215,'2010-05-03','14:05:27','inbox','-',NULL),
 ('',216,'2010-05-03','14:06:08','draft','+',NULL),
 (0x6F6265726B6572,217,'2010-05-03','14:11:41','draft','+','0'),
 (0x61646D696E,218,'2010-05-03','14:11:41','inbox','-',NULL),
 (0x61646D696E,219,'2010-05-03','14:31:29','inbox','-',NULL),
 (0x6F5F74756772756C,220,'2010-05-03','14:32:51','inbox','-','0'),
 (0x6F6265726B6572,221,'2010-05-03','14:32:51','deleted','-',NULL),
 (0x616775646572,222,'2010-05-03','14:42:06','inbox','-','0');
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x616775646572,223,'2010-05-03','14:42:06','inbox','-',NULL),
 (0x6572726574,224,'2010-05-03','14:50:50','inbox','-','0'),
 (0x6F6265726B6572,225,'2010-05-03','14:50:50','deleted','-',NULL),
 (0x6F6265726B6572,226,'2010-05-03','15:47:38','deletedcomplete','+','0'),
 (0x616775646572,227,'2010-05-03','15:47:38','deleted','-',NULL),
 (0x616775646572,228,'2010-05-03','15:48:30','deleted','-',NULL),
 (0x61646D696E,229,'2010-05-03','16:37:36','inbox','+','0'),
 (0x616775646572,230,'2010-05-03','16:37:36','inbox','-',NULL),
 (0x616775646572,231,'2010-05-03','21:06:45','inbox','-',NULL),
 (0x61646D696E,232,'2010-05-06','12:03:06','inbox','-',NULL),
 (0x61646D696E,233,'2010-05-06','12:04:52','inbox','-',NULL),
 (0x616775646572,234,'2010-05-06','14:10:18','inbox','+','0'),
 (0x6F6265726B6572,235,'2010-05-06','14:10:18','deleted','-',NULL),
 (0x6F5F74756772756C,234,'2010-05-06','14:10:18','inbox','-','0'),
 (0x6F6265726B6572,236,'2010-05-06','14:10:18','deleted','-',NULL),
 (0x6F6265726B6572,237,'2010-05-06','14:10:38','deleted','-',NULL);
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x616775646572,238,'2010-05-06','14:15:00','inbox','+','0'),
 (0x616775646572,239,'2010-05-06','14:15:00','inbox','-',NULL),
 (0x616775646572,240,'2010-05-06','14:15:05','inbox','-',NULL),
 (0x6F6265726B6572,241,'2010-05-06','14:50:59','deleted','+','0'),
 (0x616775646572,242,'2010-05-06','14:50:59','inbox','-',NULL),
 (0x6F5F74756772756C,243,'2010-05-06','19:45:08','inbox','-','0'),
 (0x616775646572,244,'2010-05-06','19:45:08','inbox','-',NULL),
 (0x6F5F74756772756C,245,'2010-05-06','19:46:31','inbox','-','0'),
 (0x616775646572,246,'2010-05-06','19:46:31','inbox','-',NULL),
 (0x61646D696E,247,'2010-05-06','20:32:43','inbox','-',NULL),
 (0x61646D696E,248,'2010-05-06','20:51:39','inbox','+','0'),
 (0x616775646572,249,'2010-05-06','20:51:39','inbox','-',NULL),
 (0x6F5F74756772756C,248,'2010-05-06','20:51:39','inbox','-','0'),
 (0x616775646572,250,'2010-05-06','20:51:39','inbox','-',NULL),
 (0x616775646572,251,'2010-05-06','21:01:38','inbox','-',NULL),
 (0x6F6265726B6572,252,'2010-05-06','23:22:22','outbox','+','0');
INSERT INTO `messaging`.`receiveMessage` VALUES  (0x616775646572,253,'2010-05-06','23:22:22','inbox','-',NULL),
 (0x616775646572,254,'2010-05-06','23:42:13','inbox','-',NULL),
 (0x6F6265726B6572,144,'2010-04-28','22:57:58','inbox','+',NULL),
 ('',5830,'2010-05-07','03:04:18','draft','+',NULL),
 (0x616775646572,5831,'2010-05-07','12:17:23','inbox','+','0'),
 (0x6F6265726B6572,5832,'2010-05-07','12:17:23','inbox','-',NULL),
 (0x6F5F74756772756C,5831,'2010-05-07','12:17:23','inbox','-','0'),
 (0x6F6265726B6572,5833,'2010-05-07','12:17:23','inbox','-',NULL),
 (0x6F6265726B6572,5834,'2010-05-07','12:17:52','inbox','-',NULL);
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
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `messaging`.`sentFile`
--

/*!40000 ALTER TABLE `sentFile` DISABLE KEYS */;
LOCK TABLES `sentFile` WRITE;
INSERT INTO `messaging`.`sentFile` VALUES  (11,'sunum.sql',180,'39037','text/x-sql'),
 (12,'examples.desktop',183,'167','application/octet-stream'),
 (13,'Template_for_Hw494.doc',183,'33792','application/msword'),
 (14,'examples.desktop',201,'167','application/octet-stream'),
 (15,'userpass.csv',229,'305','text/csv');
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
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

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
