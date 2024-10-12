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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_account`
--

LOCK TABLES `accounts_account` WRITE;
/*!40000 ALTER TABLE `accounts_account` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser`
--

LOCK TABLES `accounts_customuser` WRITE;
/*!40000 ALTER TABLE `accounts_customuser` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add group',1,'add_group'),(2,'Can change group',1,'change_group'),(3,'Can delete group',1,'delete_group'),(4,'Can view group',1,'view_group'),(5,'Can add post',2,'add_post'),(6,'Can change post',2,'change_post'),(7,'Can delete post',2,'delete_post'),(8,'Can view post',2,'view_post'),(9,'Can add network',3,'add_network'),(10,'Can change network',3,'change_network'),(11,'Can delete network',3,'delete_network'),(12,'Can view network',3,'view_network'),(13,'Can add root auth',4,'add_rootauth'),(14,'Can change root auth',4,'change_rootauth'),(15,'Can delete root auth',4,'delete_rootauth'),(16,'Can view root auth',4,'view_rootauth'),(17,'Can add group membership',5,'add_groupmembership'),(18,'Can change group membership',5,'change_groupmembership'),(19,'Can delete group membership',5,'delete_groupmembership'),(20,'Can view group membership',5,'view_groupmembership'),(21,'Can add add network',6,'add_addnetwork'),(22,'Can change add network',6,'change_addnetwork'),(23,'Can delete add network',6,'delete_addnetwork'),(24,'Can view add network',6,'view_addnetwork'),(25,'Can add network post',7,'add_networkpost'),(26,'Can change network post',7,'change_networkpost'),(27,'Can delete network post',7,'delete_networkpost'),(28,'Can view network post',7,'view_networkpost'),(29,'Can add making',8,'add_making'),(30,'Can change making',8,'change_making'),(31,'Can delete making',8,'delete_making'),(32,'Can view making',8,'view_making'),(33,'Can add custom user',9,'add_customuser'),(34,'Can change custom user',9,'change_customuser'),(35,'Can delete custom user',9,'delete_customuser'),(36,'Can view custom user',9,'view_customuser'),(37,'Can add account',10,'add_account'),(38,'Can change account',10,'change_account'),(39,'Can delete account',10,'delete_account'),(40,'Can view account',10,'view_account'),(41,'Can add log entry',11,'add_logentry'),(42,'Can change log entry',11,'change_logentry'),(43,'Can delete log entry',11,'delete_logentry'),(44,'Can view log entry',11,'view_logentry'),(45,'Can add permission',12,'add_permission'),(46,'Can change permission',12,'change_permission'),(47,'Can delete permission',12,'delete_permission'),(48,'Can view permission',12,'view_permission'),(49,'Can add group',13,'add_group'),(50,'Can change group',13,'change_group'),(51,'Can delete group',13,'delete_group'),(52,'Can view group',13,'view_group'),(53,'Can add content type',14,'add_contenttype'),(54,'Can change content type',14,'change_contenttype'),(55,'Can delete content type',14,'delete_contenttype'),(56,'Can view content type',14,'view_contenttype'),(57,'Can add session',15,'add_session'),(58,'Can change session',15,'change_session'),(59,'Can delete session',15,'delete_session'),(60,'Can view session',15,'view_session'),(61,'Can add site',16,'add_site'),(62,'Can change site',16,'change_site'),(63,'Can delete site',16,'delete_site'),(64,'Can view site',16,'view_site'),(65,'Can add email address',17,'add_emailaddress'),(66,'Can change email address',17,'change_emailaddress'),(67,'Can delete email address',17,'delete_emailaddress'),(68,'Can view email address',17,'view_emailaddress'),(69,'Can add email confirmation',18,'add_emailconfirmation'),(70,'Can change email confirmation',18,'change_emailconfirmation'),(71,'Can delete email confirmation',18,'delete_emailconfirmation'),(72,'Can view email confirmation',18,'view_emailconfirmation'),(73,'Can add social account',19,'add_socialaccount'),(74,'Can change social account',19,'change_socialaccount'),(75,'Can delete social account',19,'delete_socialaccount'),(76,'Can view social account',19,'view_socialaccount'),(77,'Can add social application',20,'add_socialapp'),(78,'Can change social application',20,'change_socialapp'),(79,'Can delete social application',20,'delete_socialapp'),(80,'Can view social application',20,'view_socialapp'),(81,'Can add social application token',21,'add_socialtoken'),(82,'Can change social application token',21,'change_socialtoken'),(83,'Can delete social application token',21,'delete_socialtoken'),(84,'Can view social application token',21,'view_socialtoken');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (17,'account','emailaddress'),(18,'account','emailconfirmation'),(10,'accounts','account'),(9,'accounts','customuser'),(11,'admin','logentry'),(13,'auth','group'),(12,'auth','permission'),(14,'contenttypes','contenttype'),(6,'flexblock','addnetwork'),(1,'flexblock','group'),(5,'flexblock','groupmembership'),(8,'flexblock','making'),(3,'flexblock','network'),(7,'flexblock','networkpost'),(2,'flexblock','post'),(4,'flexblock','rootauth'),(15,'sessions','session'),(16,'sites','site'),(19,'socialaccount','socialaccount'),(20,'socialaccount','socialapp'),(21,'socialaccount','socialtoken');
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
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-10-12 09:35:28.024449'),(2,'contenttypes','0002_remove_content_type_name','2024-10-12 09:35:28.177466'),(3,'auth','0001_initial','2024-10-12 09:35:28.607020'),(4,'auth','0002_alter_permission_name_max_length','2024-10-12 09:35:28.754040'),(5,'auth','0003_alter_user_email_max_length','2024-10-12 09:35:28.768804'),(6,'auth','0004_alter_user_username_opts','2024-10-12 09:35:28.786694'),(7,'auth','0005_alter_user_last_login_null','2024-10-12 09:35:28.799370'),(8,'auth','0006_require_contenttypes_0002','2024-10-12 09:35:28.805304'),(9,'auth','0007_alter_validators_add_error_messages','2024-10-12 09:35:28.816396'),(10,'auth','0008_alter_user_username_max_length','2024-10-12 09:35:28.828481'),(11,'auth','0009_alter_user_last_name_max_length','2024-10-12 09:35:28.843787'),(12,'auth','0010_alter_group_name_max_length','2024-10-12 09:35:28.872636'),(13,'auth','0011_update_proxy_permissions','2024-10-12 09:35:28.881764'),(14,'auth','0012_alter_user_first_name_max_length','2024-10-12 09:35:28.890979'),(15,'accounts','0001_initial','2024-10-12 09:35:29.710380'),(16,'account','0001_initial','2024-10-12 09:35:30.102282'),(17,'account','0002_email_max_length','2024-10-12 09:35:30.131165'),(18,'account','0003_alter_emailaddress_create_unique_verified_email','2024-10-12 09:35:30.184468'),(19,'account','0004_alter_emailaddress_drop_unique_email','2024-10-12 09:35:30.236073'),(20,'account','0005_emailaddress_idx_upper_email','2024-10-12 09:35:30.286737'),(21,'account','0006_emailaddress_lower','2024-10-12 09:35:30.310340'),(22,'account','0007_emailaddress_idx_email','2024-10-12 09:35:30.381697'),(23,'account','0008_emailaddress_unique_primary_email_fixup','2024-10-12 09:35:30.402701'),(24,'account','0009_emailaddress_unique_primary_email','2024-10-12 09:35:30.415603'),(25,'accounts','0002_alter_customuser_first_name_and_more','2024-10-12 09:35:30.616107'),(26,'accounts','0003_customuser_is_admin_alter_customuser_email_and_more','2024-10-12 09:35:30.788760'),(27,'accounts','0004_remove_customuser_is_admin_alter_customuser_email_and_more','2024-10-12 09:35:31.242924'),(28,'accounts','0005_alter_customuser_first_name_and_more','2024-10-12 09:35:31.393554'),(29,'accounts','0006_alter_customuser_first_name_and_more','2024-10-12 09:35:31.472232'),(30,'accounts','0007_alter_customuser_first_name_and_more','2024-10-12 09:35:31.550959'),(31,'accounts','0008_alter_customuser_first_name_and_more','2024-10-12 09:35:31.707983'),(32,'admin','0001_initial','2024-10-12 09:35:31.942104'),(33,'admin','0002_logentry_remove_auto_add','2024-10-12 09:35:31.953980'),(34,'admin','0003_logentry_add_action_flag_choices','2024-10-12 09:35:31.942414'),(35,'flexblock','0001_initial','2024-10-12 09:35:32.613060'),(36,'flexblock','0002_network','2024-10-12 09:35:32.967487'),(37,'flexblock','0003_remove_network_mainteam_remove_network_subteam','2024-10-12 09:35:33.247144'),(38,'flexblock','0004_network_visibility','2024-10-12 09:35:33.294322'),(39,'flexblock','0005_network_mygroup_alter_network_index_addnetwork','2024-10-12 09:35:33.740800'),(40,'flexblock','0006_alter_addnetwork_options_addnetwork_created_at','2024-10-12 09:35:33.801707'),(41,'flexblock','0007_rootauth','2024-10-12 09:35:34.063707'),(42,'flexblock','0008_alter_rootauth_target_user','2024-10-12 09:35:34.216919'),(43,'flexblock','0009_alter_rootauth_target_user','2024-10-12 09:35:34.348084'),(44,'flexblock','0010_group_visibility','2024-10-12 09:35:34.413968'),(45,'flexblock','0011_alter_group_options','2024-10-12 09:35:34.429010'),(46,'flexblock','0012_alter_group_options','2024-10-12 09:35:34.448239'),(47,'flexblock','0013_groupmembership','2024-10-12 09:35:34.717457'),(48,'flexblock','0014_alter_groupmembership_account','2024-10-12 09:35:34.866959'),(49,'flexblock','0015_alter_groupmembership_account','2024-10-12 09:35:35.009737'),(50,'flexblock','0016_alter_addnetwork_group','2024-10-12 09:35:35.031363'),(51,'flexblock','0017_network_target_group','2024-10-12 09:35:35.305807'),(52,'flexblock','0018_alter_network_target_group','2024-10-12 09:35:35.325483'),(53,'flexblock','0019_alter_network_options_remove_network_mygroup_and_more','2024-10-12 09:35:35.886348'),(54,'flexblock','0020_network_mygroup_network_target_group','2024-10-12 09:35:36.277259'),(55,'flexblock','0021_alter_network_options_remove_network_explain','2024-10-12 09:35:36.332410'),(56,'flexblock','0022_remove_network_managername_remove_network_mygroup_and_more','2024-10-12 09:35:36.970404'),(57,'flexblock','0023_network_hub','2024-10-12 09:35:37.089591'),(58,'flexblock','0024_alter_post_destination','2024-10-12 09:35:37.270390'),(59,'flexblock','0025_alter_post_destination_networkpost','2024-10-12 09:35:37.841697'),(60,'flexblock','0026_making','2024-10-12 09:35:38.339235'),(61,'flexblock','0027_networkpost_group','2024-10-12 09:35:38.504332'),(62,'flexblock','0028_alter_networkpost_group','2024-10-12 09:35:38.712276'),(63,'flexblock','0029_alter_networkpost_group','2024-10-12 09:35:38.865965'),(64,'flexblock','0030_alter_networkpost_group','2024-10-12 09:35:39.025605'),(65,'flexblock','0031_alter_making_hub','2024-10-12 09:35:39.191643'),(66,'flexblock','0032_alter_making_hub','2024-10-12 09:35:39.367781'),(67,'flexblock','0033_remove_addnetwork_created_at_and_more','2024-10-12 09:35:39.503936'),(68,'flexblock','0034_alter_making_hub_alter_making_name_alter_making_sub','2024-10-12 09:35:39.547155'),(69,'flexblock','0035_remove_group_transaction_hash_group_comanager_and_more','2024-10-12 09:35:39.811669'),(70,'flexblock','0036_remove_group_comanager_group_comanager','2024-10-12 09:35:40.243408'),(71,'flexblock','0037_remove_group_comanager_remove_group_group_type','2024-10-12 09:35:40.337891'),(72,'flexblock','0038_remove_group_explain_remove_group_icon_and_more','2024-10-12 09:35:40.585429'),(73,'flexblock','0039_group_group_type','2024-10-12 09:35:40.646389'),(74,'flexblock','0040_group_comanager','2024-10-12 09:35:40.830330'),(75,'flexblock','0041_alter_group_comanager','2024-10-12 09:35:41.010680'),(76,'flexblock','0042_remove_group_comanager_group_comanager','2024-10-12 09:35:41.448203'),(77,'flexblock','0043_alter_group_comanager','2024-10-12 09:35:41.622286'),(78,'flexblock','0044_alter_group_comanager','2024-10-12 09:35:41.646402'),(79,'flexblock','0045_rootauth_is_denied','2024-10-12 09:35:41.698258'),(80,'flexblock','0046_addnetwork_is_denied','2024-10-12 09:35:41.756758'),(81,'flexblock','0047_alter_group_web_site','2024-10-12 09:35:41.879134'),(82,'flexblock','0048_remove_group_comanager_remove_group_group_type_and_more','2024-10-12 09:35:42.468686'),(83,'flexblock','0049_remove_cogroup_mainuser','2024-10-12 09:35:42.512331'),(84,'flexblock','0050_delete_cogroup','2024-10-12 09:35:42.557279'),(85,'flexblock','0051_group_comanager_group_type','2024-10-12 09:35:42.911140'),(86,'flexblock','0052_alter_group_type','2024-10-12 09:35:42.929372'),(87,'flexblock','0053_group_mainusers','2024-10-12 09:35:43.167775'),(88,'flexblock','0054_alter_group_mainusers','2024-10-12 09:35:43.186635'),(89,'flexblock','0055_remove_group_mainusers','2024-10-12 09:35:43.242356'),(90,'flexblock','0056_delete_category','2024-10-12 09:35:43.277041'),(91,'flexblock','0057_alter_group_comanager','2024-10-12 09:35:43.443274'),(92,'flexblock','0058_alter_group_comanager','2024-10-12 09:35:43.621339'),(93,'flexblock','0059_alter_group_comanager','2024-10-12 09:35:43.885897'),(94,'flexblock','0060_alter_group_comanager','2024-10-12 09:35:43.912905'),(95,'flexblock','0061_alter_group_comanager','2024-10-12 09:35:44.080358'),(96,'flexblock','0062_alter_group_managername','2024-10-12 09:35:44.102682'),(97,'flexblock','0063_remove_group_comanager_alter_rootauth_target_user_and_more','2024-10-12 09:35:44.621975'),(98,'flexblock','0064_alter_group_comanager','2024-10-12 09:35:44.778095'),(99,'flexblock','0065_alter_group_comanager','2024-10-12 09:35:44.915210'),(100,'flexblock','0066_remove_group_comanager_group_comanager','2024-10-12 09:35:45.284348'),(101,'flexblock','0067_alter_group_name_alter_network_name','2024-10-12 09:35:45.375615'),(102,'flexblock','0068_alter_group_comanager','2024-10-12 09:35:45.416570'),(103,'sessions','0001_initial','2024-10-12 09:35:45.502589'),(104,'sites','0001_initial','2024-10-12 09:35:45.538854'),(105,'sites','0002_alter_domain_unique','2024-10-12 09:35:45.566659'),(106,'socialaccount','0001_initial','2024-10-12 09:35:46.449343'),(107,'socialaccount','0002_token_max_lengths','2024-10-12 09:35:46.520419'),(108,'socialaccount','0003_extra_data_default_dict','2024-10-12 09:35:46.541239'),(109,'socialaccount','0004_app_provider_id_settings','2024-10-12 09:35:46.848987'),(110,'socialaccount','0005_socialtoken_nullable_app','2024-10-12 09:35:47.095228'),(111,'socialaccount','0006_alter_socialaccount_extra_data','2024-10-12 09:35:47.230937');
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
  UNIQUE KEY `flexblock_group_name_3520082c_uniq` (`name`),
  KEY `flexblock_group_mainuser_id_de975294_fk_accounts_customuser_id` (`mainuser_id`),
  KEY `flexblock_group_managername_id_28223862_fk_accounts_account_id` (`managername_id`),
  CONSTRAINT `flexblock_group_mainuser_id_de975294_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_group_managername_id_28223862_fk_accounts_account_id` FOREIGN KEY (`managername_id`) REFERENCES `accounts_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_group`
--

LOCK TABLES `flexblock_group` WRITE;
/*!40000 ALTER TABLE `flexblock_group` DISABLE KEYS */;
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
  UNIQUE KEY `flexblock_network_name_8be8e51b_uniq` (`name`),
  KEY `flexblock_network_mainuser_id_3a79bedf_fk_accounts_customuser_id` (`mainuser_id`),
  KEY `flexblock_network_hub_id_38f4b26c_fk_flexblock_group_id` (`hub_id`),
  CONSTRAINT `flexblock_network_hub_id_38f4b26c_fk_flexblock_group_id` FOREIGN KEY (`hub_id`) REFERENCES `flexblock_group` (`id`),
  CONSTRAINT `flexblock_network_mainuser_id_3a79bedf_fk_accounts_customuser_id` FOREIGN KEY (`mainuser_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `target_user_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `is_denied` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flexblock_rootauth_user_id_target_user_id_b66ef195_uniq` (`user_id`,`target_user_id`),
  KEY `flexblock_rootauth_target_user_id_a814cb59_fk_accounts_` (`target_user_id`),
  CONSTRAINT `flexblock_rootauth_target_user_id_a814cb59_fk_accounts_` FOREIGN KEY (`target_user_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `flexblock_rootauth_user_id_2a219c8d_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexblock_rootauth`
--

LOCK TABLES `flexblock_rootauth` WRITE;
/*!40000 ALTER TABLE `flexblock_rootauth` DISABLE KEYS */;
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
INSERT INTO `users` VALUES (1,'admin','admin@example.com','2024-10-12 09:35:16');
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

-- Dump completed on 2024-10-12  9:38:08
