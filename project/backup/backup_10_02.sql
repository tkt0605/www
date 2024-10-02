-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: main
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  KEY `account_emailaddress_email_03be32b2` (`email`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
INSERT INTO `account_emailaddress` VALUES (1,'takato.komada2005@outlook.jp',1,1,1),(2,'aaa@example.com',1,1,2),(3,'takato_2005@icloud.com',1,1,3),(4,'kmada_0605@icloud.com',1,1,4);
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_account`
--

DROP TABLE IF EXISTS `accounts_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(15) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `infomation` longtext,
  `hobby` varchar(8) NOT NULL,
  `detail` varchar(8) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `mainuser_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mainuser_id` (`mainuser_id`),
  CONSTRAINT `accounts_account_mainuser_id_f8edf31a_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_account`
--

LOCK TABLES `accounts_account` WRITE;
/*!40000 ALTER TABLE `accounts_account` DISABLE KEYS */;
INSERT INTO `accounts_account` VALUES (1,'駒田隆人','image/sample.jpg','icon/5770f01a32c3c53e90ecda61483ccb08.jpg','・・・・','・・・・','・・・・','2024-08-30 06:27:46.626747',1),(2,'example1','image/sample.jpg','icon/5770f01a32c3c53e90ecda61483ccb08.jpg','・・・・','・・・・','・・・・','2024-09-03 07:00:25.704436',2),(3,'takato','image/sample.jpg','icon/5770f01a32c3c53e90ecda61483ccb08.jpg','・・・・','・・・・','・・・・','2024-10-01 21:46:19.664692',3),(4,'tkt0605','image/sample.jpg','icon/5770f01a32c3c53e90ecda61483ccb08.jpg','・・・・','・・・・','・・・・','2024-10-01 21:48:45.331349',4);
/*!40000 ALTER TABLE `accounts_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_customuser`
--

DROP TABLE IF EXISTS `accounts_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser`
--

LOCK TABLES `accounts_customuser` WRITE;
/*!40000 ALTER TABLE `accounts_customuser` DISABLE KEYS */;
INSERT INTO `accounts_customuser` VALUES (1,'pbkdf2_sha256$870000$LhN0eQ6k8NeNr2ValPOkYY$dnXkHzN0WfJojxT81WU34voD6fjTZ3c9MR/eaT9BO0M=','2024-10-01 21:47:37.956685',1,'takato.komada2005@outlook.jp','駒田隆人','','',1,1,'2024-08-30 06:27:46.335631'),(2,'pbkdf2_sha256$870000$S8e33dRJFFgONiVFER4nB3$iqHeL6K1q0NH5/YYkUFB6wKlgSFw9dcyuu1XhVp2UfQ=','2024-09-03 07:01:08.384653',0,'aaa@example.com','example1','','',1,0,'2024-09-03 07:00:25.429653'),(3,'pbkdf2_sha256$870000$4XMPye12ShqHU9xxZ1IIdI$hcDlw1Bl1wtVozrTNwK3j7maU/++F4bPhmt04Brxcdg=','2024-10-01 21:50:37.796166',0,'takato_2005@icloud.com','takato','NoFirstName','NoLastName',1,0,'2024-10-01 21:46:19.376510'),(4,'pbkdf2_sha256$870000$B2DBVKrhixjaNilEjxRJxB$+Ss9mKU6jEcO/mofuE3E2N5kFsTnJfLUy4P7kPuvhTc=','2024-10-01 21:49:09.507314',0,'kmada_0605@icloud.com','tkt0605','NoFirstName','NoLastName',1,0,'2024-10-01 21:48:45.058366');
/*!40000 ALTER TABLE `accounts_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_customuser_groups`
--

DROP TABLE IF EXISTS `accounts_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customuser_groups_customuser_id_group_id_c074bdcb_uniq` (`customuser_id`,`group_id`),
  KEY `accounts_customuser_groups_group_id_86ba5f9e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_customuser__customuser_id_bc55088e_fk_accounts_` FOREIGN KEY (`customuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `accounts_customuser_groups_group_id_86ba5f9e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser_groups`
--

LOCK TABLES `accounts_customuser_groups` WRITE;
/*!40000 ALTER TABLE `accounts_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_customuser_user_permissions`
--

DROP TABLE IF EXISTS `accounts_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customuser_user_customuser_id_permission_9632a709_uniq` (`customuser_id`,`permission_id`),
  KEY `accounts_customuser__permission_id_aea3d0e5_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_customuser__customuser_id_0deaefae_fk_accounts_` FOREIGN KEY (`customuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `accounts_customuser__permission_id_aea3d0e5_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser_user_permissions`
--

LOCK TABLES `accounts_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add custom user',1,'add_customuser'),(2,'Can change custom user',1,'change_customuser'),(3,'Can delete custom user',1,'delete_customuser'),(4,'Can view custom user',1,'view_customuser'),(5,'Can add account',2,'add_account'),(6,'Can change account',2,'change_account'),(7,'Can delete account',2,'delete_account'),(8,'Can view account',2,'view_account'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add content type',6,'add_contenttype'),(22,'Can change content type',6,'change_contenttype'),(23,'Can delete content type',6,'delete_contenttype'),(24,'Can view content type',6,'view_contenttype'),(25,'Can add session',7,'add_session'),(26,'Can change session',7,'change_session'),(27,'Can delete session',7,'delete_session'),(28,'Can view session',7,'view_session'),(29,'Can add site',8,'add_site'),(30,'Can change site',8,'change_site'),(31,'Can delete site',8,'delete_site'),(32,'Can view site',8,'view_site'),(33,'Can add email address',9,'add_emailaddress'),(34,'Can change email address',9,'change_emailaddress'),(35,'Can delete email address',9,'delete_emailaddress'),(36,'Can view email address',9,'view_emailaddress'),(37,'Can add email confirmation',10,'add_emailconfirmation'),(38,'Can change email confirmation',10,'change_emailconfirmation'),(39,'Can delete email confirmation',10,'delete_emailconfirmation'),(40,'Can view email confirmation',10,'view_emailconfirmation'),(41,'Can add social account',11,'add_socialaccount'),(42,'Can change social account',11,'change_socialaccount'),(43,'Can delete social account',11,'delete_socialaccount'),(44,'Can view social account',11,'view_socialaccount'),(45,'Can add social application',12,'add_socialapp'),(46,'Can change social application',12,'change_socialapp'),(47,'Can delete social application',12,'delete_socialapp'),(48,'Can view social application',12,'view_socialapp'),(49,'Can add social application token',13,'add_socialtoken'),(50,'Can change social application token',13,'change_socialtoken'),(51,'Can delete social application token',13,'delete_socialtoken'),(52,'Can view social application token',13,'view_socialtoken'),(53,'Can add category',14,'add_category'),(54,'Can change category',14,'change_category'),(55,'Can delete category',14,'delete_category'),(56,'Can view category',14,'view_category'),(57,'Can add group',15,'add_group'),(58,'Can change group',15,'change_group'),(59,'Can delete group',15,'delete_group'),(60,'Can view group',15,'view_group'),(61,'Can add post',16,'add_post'),(62,'Can change post',16,'change_post'),(63,'Can delete post',16,'delete_post'),(64,'Can view post',16,'view_post'),(65,'Can add network',17,'add_network'),(66,'Can change network',17,'change_network'),(67,'Can delete network',17,'delete_network'),(68,'Can view network',17,'view_network'),(69,'Can add add network',18,'add_addnetwork'),(70,'Can change add network',18,'change_addnetwork'),(71,'Can delete add network',18,'delete_addnetwork'),(72,'Can view add network',18,'view_addnetwork'),(73,'Can add root auth',19,'add_rootauth'),(74,'Can change root auth',19,'change_rootauth'),(75,'Can delete root auth',19,'delete_rootauth'),(76,'Can view root auth',19,'view_rootauth'),(77,'Can add group membership',20,'add_groupmembership'),(78,'Can change group membership',20,'change_groupmembership'),(79,'Can delete group membership',20,'delete_groupmembership'),(80,'Can view group membership',20,'view_groupmembership'),(81,'Can add network post',21,'add_networkpost'),(82,'Can change network post',21,'change_networkpost'),(83,'Can delete network post',21,'delete_networkpost'),(84,'Can view network post',21,'view_networkpost'),(85,'Can add making',22,'add_making'),(86,'Can change making',22,'change_making'),(87,'Can delete making',22,'delete_making'),(88,'Can view making',22,'view_making');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-09-03 07:39:56.099110','3','xlink.com',3,'',17,1),(2,'2024-09-03 07:39:56.099154','2','GitHub',3,'',17,1),(3,'2024-09-04 06:28:43.642318','4','精密_4064_駒田隆人_科学実験',3,'',17,1),(4,'2024-09-04 06:28:43.642382','1','Alphabet',3,'',17,1),(5,'2024-09-30 22:22:57.537711','2','iLovePDF',3,'',15,1),(6,'2024-09-30 22:22:57.537831','1','flexBlock',3,'',15,1),(7,'2024-09-30 22:27:47.198084','5','PDF Creaters',3,'',17,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (9,'account','emailaddress'),(10,'account','emailconfirmation'),(2,'accounts','account'),(1,'accounts','customuser'),(3,'admin','logentry'),(5,'auth','group'),(4,'auth','permission'),(6,'contenttypes','contenttype'),(18,'flexblock','addnetwork'),(14,'flexblock','category'),(15,'flexblock','group'),(20,'flexblock','groupmembership'),(22,'flexblock','making'),(17,'flexblock','network'),(21,'flexblock','networkpost'),(16,'flexblock','post'),(19,'flexblock','rootauth'),(7,'sessions','session'),(8,'sites','site'),(11,'socialaccount','socialaccount'),(12,'socialaccount','socialapp'),(13,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-08-30 05:05:55.534289'),(2,'contenttypes','0002_remove_content_type_name','2024-08-30 05:05:56.199367'),(3,'auth','0001_initial','2024-08-30 05:05:58.650256'),(4,'auth','0002_alter_permission_name_max_length','2024-08-30 05:05:59.363577'),(5,'auth','0003_alter_user_email_max_length','2024-08-30 05:05:59.507186'),(6,'auth','0004_alter_user_username_opts','2024-08-30 05:05:59.606715'),(7,'auth','0005_alter_user_last_login_null','2024-08-30 05:05:59.678019'),(8,'auth','0006_require_contenttypes_0002','2024-08-30 05:05:59.720957'),(9,'auth','0007_alter_validators_add_error_messages','2024-08-30 05:05:59.805421'),(10,'auth','0008_alter_user_username_max_length','2024-08-30 05:05:59.875926'),(11,'auth','0009_alter_user_last_name_max_length','2024-08-30 05:05:59.938014'),(12,'auth','0010_alter_group_name_max_length','2024-08-30 05:06:00.092321'),(13,'auth','0011_update_proxy_permissions','2024-08-30 05:06:00.168937'),(14,'auth','0012_alter_user_first_name_max_length','2024-08-30 05:06:00.225950'),(15,'accounts','0001_initial','2024-08-30 05:06:04.537017'),(16,'account','0001_initial','2024-08-30 05:06:06.303032'),(17,'account','0002_email_max_length','2024-08-30 05:06:06.515964'),(18,'account','0003_alter_emailaddress_create_unique_verified_email','2024-08-30 05:06:06.947235'),(19,'account','0004_alter_emailaddress_drop_unique_email','2024-08-30 05:06:07.344569'),(20,'account','0005_emailaddress_idx_upper_email','2024-08-30 05:06:07.595732'),(21,'account','0006_emailaddress_lower','2024-08-30 05:06:07.736114'),(22,'account','0007_emailaddress_idx_email','2024-08-30 05:06:08.264518'),(23,'account','0008_emailaddress_unique_primary_email_fixup','2024-08-30 05:06:08.426429'),(24,'account','0009_emailaddress_unique_primary_email','2024-08-30 05:06:08.527590'),(25,'admin','0001_initial','2024-08-30 05:06:09.761082'),(26,'admin','0002_logentry_remove_auto_add','2024-08-30 05:06:09.848983'),(27,'admin','0003_logentry_add_action_flag_choices','2024-08-30 05:06:09.945631'),(28,'sessions','0001_initial','2024-08-30 05:06:10.276358'),(29,'sites','0001_initial','2024-08-30 05:06:10.452476'),(30,'sites','0002_alter_domain_unique','2024-08-30 05:06:10.590258'),(31,'socialaccount','0001_initial','2024-08-30 05:06:14.162412'),(32,'socialaccount','0002_token_max_lengths','2024-08-30 05:06:14.704373'),(33,'socialaccount','0003_extra_data_default_dict','2024-08-30 05:06:14.786939'),(34,'socialaccount','0004_app_provider_id_settings','2024-08-30 05:06:16.260784'),(35,'socialaccount','0005_socialtoken_nullable_app','2024-08-30 05:06:17.527531'),(36,'socialaccount','0006_alter_socialaccount_extra_data','2024-08-30 05:06:18.125302'),(37,'flexblock','0001_initial','2024-08-30 07:17:47.200413'),(38,'flexblock','0002_network','2024-09-03 00:19:27.729678'),(39,'flexblock','0003_remove_network_mainteam_remove_network_subteam','2024-09-03 01:31:33.495152'),(40,'flexblock','0004_network_visibility','2024-09-03 01:40:18.688855'),(41,'flexblock','0005_network_mygroup_alter_network_index_addnetwork','2024-09-03 05:22:08.793225'),(42,'flexblock','0006_alter_addnetwork_options_addnetwork_created_at','2024-09-03 07:09:29.305822'),(43,'flexblock','0007_rootauth','2024-09-12 00:29:08.262236'),(44,'flexblock','0008_alter_rootauth_target_user','2024-09-12 00:29:08.383244'),(45,'flexblock','0009_alter_rootauth_target_user','2024-09-12 00:29:08.503491'),(46,'flexblock','0010_group_visibility','2024-09-12 00:29:08.558295'),(47,'flexblock','0011_alter_group_options','2024-09-12 00:29:08.572614'),(48,'flexblock','0012_alter_group_options','2024-09-12 00:29:08.588801'),(49,'flexblock','0013_groupmembership','2024-09-12 00:29:08.831585'),(50,'flexblock','0014_alter_groupmembership_account','2024-09-12 00:29:08.970612'),(51,'flexblock','0015_alter_groupmembership_account','2024-09-12 00:29:09.096178'),(52,'flexblock','0016_alter_addnetwork_group','2024-09-12 00:29:09.116485'),(53,'flexblock','0017_network_target_group','2024-09-12 00:29:09.314413'),(54,'flexblock','0018_alter_network_target_group','2024-09-12 00:29:09.334173'),(55,'flexblock','0019_alter_network_options_remove_network_mygroup_and_more','2024-09-12 00:29:09.926970'),(56,'flexblock','0020_network_mygroup_network_target_group','2024-09-12 00:29:10.210641'),(57,'flexblock','0021_alter_network_options_remove_network_explain','2024-09-12 00:29:10.257879'),(58,'flexblock','0022_remove_network_managername_remove_network_mygroup_and_more','2024-09-12 00:29:10.843569'),(59,'flexblock','0023_network_hub','2024-09-12 00:29:10.952764'),(60,'flexblock','0024_alter_post_destination','2024-09-16 02:47:57.521377'),(61,'flexblock','0025_alter_post_destination_networkpost','2024-09-16 02:47:57.973261'),(62,'accounts','0002_alter_customuser_first_name_and_more','2024-09-30 22:20:59.911672'),(63,'accounts','0003_customuser_is_admin_alter_customuser_email_and_more','2024-09-30 22:21:00.703418'),(64,'flexblock','0026_making','2024-09-30 22:21:01.500379'),(65,'flexblock','0027_networkpost_group','2024-09-30 22:21:01.847208'),(66,'flexblock','0028_alter_networkpost_group','2024-09-30 22:21:02.272288'),(67,'flexblock','0029_alter_networkpost_group','2024-09-30 22:21:03.074744'),(68,'flexblock','0030_alter_networkpost_group','2024-09-30 22:21:03.455080'),(69,'flexblock','0031_alter_making_hub','2024-09-30 22:21:03.915164'),(70,'flexblock','0032_alter_making_hub','2024-09-30 22:21:04.350830'),(71,'flexblock','0033_remove_addnetwork_created_at_and_more','2024-09-30 22:21:04.719778'),(72,'flexblock','0034_alter_making_hub_alter_making_name_alter_making_sub','2024-09-30 22:21:04.930978'),(73,'flexblock','0035_remove_group_transaction_hash_group_comanager_and_more','2024-09-30 22:21:05.688919'),(74,'flexblock','0036_remove_group_comanager_group_comanager','2024-09-30 22:21:06.733218'),(75,'flexblock','0037_remove_group_comanager_remove_group_group_type','2024-09-30 22:21:07.036113'),(76,'flexblock','0038_remove_group_explain_remove_group_icon_and_more','2024-09-30 22:21:07.673633'),(77,'flexblock','0039_group_group_type','2024-09-30 22:21:07.888359'),(78,'flexblock','0040_group_comanager','2024-09-30 22:21:08.216888'),(79,'flexblock','0041_alter_group_comanager','2024-09-30 22:21:08.628874'),(80,'flexblock','0042_remove_group_comanager_group_comanager','2024-09-30 22:21:09.706560'),(81,'flexblock','0043_alter_group_comanager','2024-09-30 22:21:10.257666'),(82,'flexblock','0044_alter_group_comanager','2024-09-30 22:21:10.350169'),(83,'flexblock','0045_rootauth_is_denied','2024-09-30 22:21:10.509177'),(84,'flexblock','0046_addnetwork_is_denied','2024-09-30 22:21:10.811915'),(85,'flexblock','0047_alter_group_web_site','2024-09-30 22:21:11.387235'),(86,'flexblock','0048_remove_group_comanager_remove_group_group_type_and_more','2024-09-30 22:21:13.206520'),(87,'flexblock','0049_remove_cogroup_mainuser','2024-09-30 22:21:13.340802'),(88,'flexblock','0050_delete_cogroup','2024-09-30 22:21:13.478399'),(89,'flexblock','0051_group_comanager_group_type','2024-09-30 22:21:14.459518'),(90,'flexblock','0052_alter_group_type','2024-09-30 22:21:14.522443'),(91,'flexblock','0053_group_mainusers','2024-09-30 22:21:15.242582'),(92,'flexblock','0054_alter_group_mainusers','2024-09-30 22:21:15.331920'),(93,'flexblock','0055_remove_group_mainusers','2024-09-30 22:21:15.588295'),(94,'flexblock','0056_delete_category','2024-09-30 22:21:15.655899'),(95,'flexblock','0057_alter_group_comanager','2024-09-30 22:21:16.030237'),(96,'flexblock','0058_alter_group_comanager','2024-09-30 22:21:50.706424'),(97,'accounts','0004_remove_customuser_is_admin_alter_customuser_email_and_more','2024-09-30 22:44:48.601850');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('66a1tc2g7jt7piyu74pb0fflb3fr0v28','.eJxVkEFuwyAQRe8yawsZAhi8qrrvCarKGmBSE9tgGay2inL3xm022Y3mv3kj_Sug93lPdcC9jpRq9FhjTsNCdcyhQP9-hf8ZelixlK-8BWgAK_S8E53hVqiOWamssQ3QgnG-kxUnrJlNecGAom3VS97rnPPELivcPhr4-zfshbYhHmoOTzuHfqJ0BOGC6TMzn1PdomMHwh5pYW850Pz6YJ8EI5bxfi21MVZ6NCRP2mv00qEWxp2JexcUdyooYQWeROjk-RwQg5CctHTkHNd0SAuVclRC32vcfqBvb78uRmfv:1svkiX:zEUlnZf_V5ZX0AqXGSrZfuTXowsShM_HGxtLzQKn70I','2024-10-15 21:47:37.961965'),('gguh70r99wj920xtiz46jebtf4cpq7v8','.eJxVkEtuwzAMBe_CtSFYiiR_VkX3PUFRGJTE1Ipt0bBktEWQuzdus8mO4BsOgXcF9J73VAbcy0ipRI8lchoWKiOHDP37Ff5n6GHFnL94C1ABFuhlo6w2urON0KrRTWcqoAXjfEcLTlhYTLxgQFXX5oX3MjNP4rLC7aOCv4fDnmkb4uGW8LRz6CdKRxAumD5ZeE5li04ciHikWbxxoPn1wT4JRszj_Vrbtu20x5b0yXqLXju0qnVnkt4FI50JRnUKTyo0-nwOiEFpSVY7ck5aOqSZcj46oe81bj_Q17dfcDZoGw:1sq1nr:he5B_U97qeyyVbV9Ozwh7LM8vY5S3VqX7Njhdwv-aGE','2024-09-30 02:49:27.450789'),('lditljg0p6ob4e1gocfclaqzre04k9o0','.eJxVkEtuhDAMhu_iNUKEEJJhVc2-J6gqZGJT0kKCSGinGs3dC1PUx876X5_kK6C1YfWpfefF9Y6p5QndCI1fxzH7cdfICzRQwq-EaxrYJ2cxueDbidMQKELzdIXve8vPGONHWGivJWiELpWsalObXCpxKpXJ4MABIj7wBad55NyGCW7PGdwZd3br6MD_0Tq0b-x3g17Rv4St59PiunyP5Icb88dAPJ6P7L-BAeOwtbWQSpWyMwWfuNKV5I5MT1RryWS1kVVRk5BslKVKn3QhBEthVGEl931f7aORY9zfwJfZLZ_QFLcvJyBzxA:1slNXI:ULuDN1phnnxq7XujeGAUjoqb15YsBs6PblLWD_byI2k','2024-09-17 07:01:08.392008'),('o49rd3eo34xlddj8a89kjn45u83892qe','.eJyNUEFuhDAM_IvPKCIhBMKp2ntfUFXISUzJAgkiQW212r8X1L3sqb1ZM-PxjG-A1sY95B73PFLI3mL2MfQL5TG6BN3bDX5n6GDFlD7j5qAAzNDxRkitdVU1rOGyUgXQgn4-hBknzJFNcUGHoizrl7jnOcaJXVe4F39bSs2kagWvqv-avhfQJ0rpDE9fq9--oSsP7OzV74m23p_3ODxhBu1E4STcFcNHZDaGvHnDTgl7sIm9Rkfz5aF9Mhgxjcf2EbbV0mJLxx-sQisNKtGagbg1ruamdrXQAivhGjkMDtEJyUlJQ8ZwRXD_AVj7gek:1sjv89:UY9ZmFfoHjv2OjX09x-oeGJCKSVb8Q4p_EGu8U3r908','2024-09-13 06:29:09.500570'),('tmsg462lmv3zdoq7b5p4dqctt5s6aok0','.eJxVkMFugzAMht_FZxSRkKSU07T7nmCakJOYkQIxIkHbVPXdV7ZeerP8f_4s_VdA73lPpce9jJRK9Fgip36hMnLI0L1f4X-GDlbM-Yu3ABVggU6elJG1aWsjjJGmaVUFtGCc72jBCQuLiRcMqOravPBeZuZJXFa4fVTw97DfM219PNwSnnYO_UTpCMIF0ycLz6ls0YkDEY80izcONL8-2CfBiHm8X2vbtmftsSXdWG_Ra4dWtW4g6V0w0plg1Flho8JJD0NADEpLstqRc9LSIc2U89EJfa9x-4Guvv0CV81oAQ:1skMpB:kIHPp_hl2hgDfY6WdoxvuMwXkR5EUaZDfQEEE1ilhks','2024-09-14 12:03:25.572367'),('x6otjotznp2xe6cfzxfykrt8yuyhf8g2','.eJxVkMFugzAMht_FZxSRNEkDp2n3PcE0IScxgwIxIkHbVPXdV7ZeerP8f_4s_VfAEHhPpcO9DJTKGLCMnLqFysAxQ_t-hf8ZWlgx5y_eIlSABVp5VuaknVFOyLqprayAFhznO1lwwsJi4gUjqro2L7yXmXkSlxVuHxX8_ev2TFs3HmoJTzuPYaJ0BPGC6ZNF4FS20YsDEY80izeONL8-2CfBgHm4X2vrXKMDOtInGywG7dEq53uSwUcjvYlGNQpPKp5130fEqLQkqz15Ly0d0kw5H5XQ9zpuP9DWt18RmmfQ:1slNy4:1OfV5z90g6EuXc34-8JRI9a9S-lRD3Gp5qaFGB-lTaM','2024-09-17 07:28:48.139874'),('xgvk03bcnxw8c7kq3yz1sgc9j74l3vl1','.eJxVkMtugzAQRf9l1gjhFzasquz7BVVkDfZQ3IAdYaO0ivLvhTab7EZzzz0jzR3QubTFYnErE8USHJaQol2oTMln6D_u8D9DD1fM-ZZWDxVggZ5prg3rpNC1NpIpJiqgBcO8owUvWJLlTaPegpvT5muXFnicK_g7ZbdMqw2HVcDLbkB3oXgE_gvjZ9p7saxhqA-kfqa5fk-e5tOTfRFMmKe9LVun0HTIhdfokcxIqAX3YmylEbpzw6i4YroZ-egNNzRIQ5K3elBCacYPaaacj2_Q9zWsP9A3j1-RyWR8:1svklR:cKB9YXshpGS_Ab8jPSbq_AJw2jDZZZQ0eRgdGSIHyJg','2024-10-15 21:50:37.802799'),('yx7sw5tkmka23bnruvclm39huze9i2h4','.eJxVkMFugzAMht_FZxSRNEkDp2n3PcE0IScxgwIxIkHbVPXdV7ZeerP8f_4s_VfAEHhPpcO9DJTKGLCMnLqFysAxQ_t-hf8ZWlgx5y_eIlSABVp5VqZujHRK1Fo3zqkKaMFxvqMFJywsJl4woqpr88J7mZkncVnh9lHB38Nuz7R14-GW8LTzGCZKRxAvmD5ZBE5lG704EPFIs3jjSPPrg30SDJiH-7W2zjU6oCN9ssFi0B6tcr4nGXw00ptoVKPwpOJZ931EjEpLstqT99LSIc2U89EJfa_j9gNtffsFYwFoDQ:1skK3q:NEdKeSYDvFb13tQcfc75V9suNmE708zG3B84hrea5Go','2024-09-14 09:06:22.065652');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_addnetwork`
--

DROP TABLE IF EXISTS `flexblock_addnetwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_addnetwork` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` bigint DEFAULT NULL,
  `name_id` bigint DEFAULT NULL,
  `is_approved_by_target` tinyint(1) NOT NULL,
  `is_approved_by_user` tinyint(1) NOT NULL,
  `is_denied` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_addnetwork_group_id_531d40c0_fk_flexblock_group_id` (`group_id`),
  KEY `flexblock_addnetwork_name_id_639adc17_fk_flexblock_network_id` (`name_id`),
  CONSTRAINT `flexblock_addnetwork_group_id_531d40c0_fk_flexblock_group_id` FOREIGN KEY (`group_id`) REFERENCES `flexblock_group` (`id`),
  CONSTRAINT `flexblock_addnetwork_name_id_639adc17_fk_flexblock_network_id` FOREIGN KEY (`name_id`) REFERENCES `flexblock_network` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_addnetwork`
--

LOCK TABLES `flexblock_addnetwork` WRITE;
/*!40000 ALTER TABLE `flexblock_addnetwork` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_addnetwork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_group`
--

DROP TABLE IF EXISTS `flexblock_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `category` varchar(15) DEFAULT NULL,
  `web_site` longtext NOT NULL,
  `backimage` varchar(100) NOT NULL,
  `index` varchar(100) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `mainuser_id` bigint DEFAULT NULL,
  `managername_id` bigint DEFAULT NULL,
  `visibility` varchar(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_group_mainuser_id_de975294_fk_accounts_customuser_id` (`mainuser_id`),
  KEY `flexblock_group_managername_id_28223862_fk_accounts_account_id` (`managername_id`),
  CONSTRAINT `flexblock_group_mainuser_id_de975294_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_group_managername_id_28223862_fk_accounts_account_id` FOREIGN KEY (`managername_id`) REFERENCES `accounts_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_group`
--

LOCK TABLES `flexblock_group` WRITE;
/*!40000 ALTER TABLE `flexblock_group` DISABLE KEYS */;
INSERT INTO `flexblock_group` VALUES (3,'oasis','サイト','@https://voice.cst.nihon-u.ac.jp/@https://classroom.google.com/@https://www.oasis.com','backimage/Oasis_logo_transparent-removebg-preview_vcBzh4v.png','oasisは、コミュニチィ同士を繋げるオンライン名簿です。','2024-10-01',1,1,'public','single');
/*!40000 ALTER TABLE `flexblock_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_group_comanager`
--

DROP TABLE IF EXISTS `flexblock_group_comanager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_group_comanager` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` bigint NOT NULL,
  `account_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flexblock_group_comanager_group_id_account_id_4b0ef76b_uniq` (`group_id`,`account_id`),
  KEY `flexblock_group_coma_account_id_ab06ef16_fk_accounts_` (`account_id`),
  CONSTRAINT `flexblock_group_coma_account_id_ab06ef16_fk_accounts_` FOREIGN KEY (`account_id`) REFERENCES `accounts_account` (`id`),
  CONSTRAINT `flexblock_group_coma_group_id_586b2c22_fk_flexblock` FOREIGN KEY (`group_id`) REFERENCES `flexblock_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_group_comanager`
--

LOCK TABLES `flexblock_group_comanager` WRITE;
/*!40000 ALTER TABLE `flexblock_group_comanager` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_group_comanager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_groupmembership`
--

DROP TABLE IF EXISTS `flexblock_groupmembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_groupmembership` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `join_date` datetime(6) DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flexblock_groupmembership_account_id_group_id_0dac8f9b_uniq` (`account_id`,`group_id`),
  KEY `flexblock_groupmembe_group_id_710f5a8a_fk_flexblock` (`group_id`),
  CONSTRAINT `flexblock_groupmembe_account_id_eac3f217_fk_accounts_` FOREIGN KEY (`account_id`) REFERENCES `accounts_account` (`id`),
  CONSTRAINT `flexblock_groupmembe_group_id_710f5a8a_fk_flexblock` FOREIGN KEY (`group_id`) REFERENCES `flexblock_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_groupmembership`
--

LOCK TABLES `flexblock_groupmembership` WRITE;
/*!40000 ALTER TABLE `flexblock_groupmembership` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_groupmembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_making`
--

DROP TABLE IF EXISTS `flexblock_making`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_making` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `hub_id` bigint DEFAULT NULL,
  `name_id` bigint DEFAULT NULL,
  `sub_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_making_name_id_7e28dc34_fk_flexblock_network_id` (`name_id`),
  KEY `flexblock_making_sub_id_fe4c0329_fk_flexblock_group_id` (`sub_id`),
  KEY `flexblock_making_hub_id_90fb7c5f_fk_flexblock_group_id` (`hub_id`),
  CONSTRAINT `flexblock_making_hub_id_90fb7c5f_fk_flexblock_group_id` FOREIGN KEY (`hub_id`) REFERENCES `flexblock_group` (`id`),
  CONSTRAINT `flexblock_making_name_id_7e28dc34_fk_flexblock_network_id` FOREIGN KEY (`name_id`) REFERENCES `flexblock_network` (`id`),
  CONSTRAINT `flexblock_making_sub_id_fe4c0329_fk_flexblock_group_id` FOREIGN KEY (`sub_id`) REFERENCES `flexblock_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_making`
--

LOCK TABLES `flexblock_making` WRITE;
/*!40000 ALTER TABLE `flexblock_making` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_making` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_network`
--

DROP TABLE IF EXISTS `flexblock_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_network` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `index` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `mainuser_id` bigint DEFAULT NULL,
  `visibility` varchar(10) NOT NULL,
  `hub_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_network_mainuser_id_3a79bedf_fk_accounts_customuser_id` (`mainuser_id`),
  KEY `flexblock_network_hub_id_38f4b26c_fk_flexblock_group_id` (`hub_id`),
  CONSTRAINT `flexblock_network_hub_id_38f4b26c_fk_flexblock_group_id` FOREIGN KEY (`hub_id`) REFERENCES `flexblock_group` (`id`),
  CONSTRAINT `flexblock_network_mainuser_id_3a79bedf_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_network`
--

LOCK TABLES `flexblock_network` WRITE;
/*!40000 ALTER TABLE `flexblock_network` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_networkpost`
--

DROP TABLE IF EXISTS `flexblock_networkpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_networkpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext,
  `image` varchar(100) DEFAULT NULL,
  `video` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `destination_id` bigint NOT NULL,
  `mainuser_id` bigint DEFAULT NULL,
  `username_id` bigint DEFAULT NULL,
  `group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_networkpos_destination_id_b9e7b338_fk_flexblock` (`destination_id`),
  KEY `flexblock_networkpos_mainuser_id_a908ac69_fk_accounts_` (`mainuser_id`),
  KEY `flexblock_networkpos_username_id_246ddbe4_fk_accounts_` (`username_id`),
  KEY `flexblock_networkpos_group_id_34b55bf1_fk_flexblock` (`group_id`),
  CONSTRAINT `flexblock_networkpos_destination_id_b9e7b338_fk_flexblock` FOREIGN KEY (`destination_id`) REFERENCES `flexblock_network` (`id`),
  CONSTRAINT `flexblock_networkpos_group_id_34b55bf1_fk_flexblock` FOREIGN KEY (`group_id`) REFERENCES `flexblock_addnetwork` (`id`),
  CONSTRAINT `flexblock_networkpos_mainuser_id_a908ac69_fk_accounts_` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_networkpos_username_id_246ddbe4_fk_accounts_` FOREIGN KEY (`username_id`) REFERENCES `accounts_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_networkpost`
--

LOCK TABLES `flexblock_networkpost` WRITE;
/*!40000 ALTER TABLE `flexblock_networkpost` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_networkpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_post`
--

DROP TABLE IF EXISTS `flexblock_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext,
  `image` varchar(100) DEFAULT NULL,
  `video` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `destination_id` bigint NOT NULL,
  `mainuser_id` bigint DEFAULT NULL,
  `username_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flexblock_post_mainuser_id_c8d8fc9d_fk_accounts_customuser_id` (`mainuser_id`),
  KEY `flexblock_post_username_id_a53f6ca0_fk_accounts_account_id` (`username_id`),
  KEY `flexblock_post_destination_id_6c284e7b_fk_flexblock_group_id` (`destination_id`),
  CONSTRAINT `flexblock_post_destination_id_6c284e7b_fk_flexblock_group_id` FOREIGN KEY (`destination_id`) REFERENCES `flexblock_group` (`id`),
  CONSTRAINT `flexblock_post_mainuser_id_c8d8fc9d_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_post_username_id_a53f6ca0_fk_accounts_account_id` FOREIGN KEY (`username_id`) REFERENCES `accounts_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_post`
--

LOCK TABLES `flexblock_post` WRITE;
/*!40000 ALTER TABLE `flexblock_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexblock_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexblock_rootauth`
--

DROP TABLE IF EXISTS `flexblock_rootauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexblock_rootauth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_approved_by_user` tinyint(1) NOT NULL,
  `is_approved_by_target` tinyint(1) NOT NULL,
  `target_user_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `is_denied` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flexblock_rootauth_user_id_target_user_id_b66ef195_uniq` (`user_id`,`target_user_id`),
  KEY `flexblock_rootauth_target_user_id_a814cb59_fk_accounts_` (`target_user_id`),
  CONSTRAINT `flexblock_rootauth_target_user_id_a814cb59_fk_accounts_` FOREIGN KEY (`target_user_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_rootauth_user_id_2a219c8d_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_rootauth`
--

LOCK TABLES `flexblock_rootauth` WRITE;
/*!40000 ALTER TABLE `flexblock_rootauth` DISABLE KEYS */;
INSERT INTO `flexblock_rootauth` VALUES (1,1,1,1,3,0),(2,1,1,1,4,0),(3,1,1,3,4,0);
/*!40000 ALTER TABLE `flexblock_rootauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` json NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_social_user_id_8146e70c_fk_accounts_` (`user_id`),
  CONSTRAINT `socialaccount_social_user_id_8146e70c_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin@example.com','2024-08-30 05:02:33');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-02 12:44:07
