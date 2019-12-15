CREATE DATABASE  IF NOT EXISTS `green` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `green`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: green
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contest`
--

DROP TABLE IF EXISTS `contest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contest` (
  `contest_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `participation_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `starting_date` datetime NOT NULL,
  `ending_date` datetime NOT NULL,
  `is_contest_free` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contest`
--

LOCK TABLES `contest` WRITE;
/*!40000 ALTER TABLE `contest` DISABLE KEYS */;
INSERT INTO `contest` VALUES (1,200,'2019-02-11 03:39:51','2019-02-11 03:39:51',0),(2,300,'2019-02-11 03:39:51','2019-02-11 03:39:51',0),(3,347,'2017-01-23 14:34:56','2017-01-23 14:34:56',0),(4,347,'2017-01-23 14:34:56','2017-01-23 14:34:56',0);
/*!40000 ALTER TABLE `contest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contest_prize`
--

DROP TABLE IF EXISTS `contest_prize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contest_prize` (
  `prize_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_contest_id` int(10) unsigned NOT NULL,
  `position` int(10) NOT NULL DEFAULT '0',
  `prize` double NOT NULL DEFAULT '0',
  `prize_description` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'money',
  `sponsor` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'weroar',
  PRIMARY KEY (`prize_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contest_prize`
--

LOCK TABLES `contest_prize` WRITE;
/*!40000 ALTER TABLE `contest_prize` DISABLE KEYS */;
INSERT INTO `contest_prize` VALUES (2,1,2,270,'money','weroar'),(3,1,3,180,'money','weroar'),(4,1,1,370,'money','weroar'),(5,1,4,100,'money','weroar'),(6,1,5,80,'money','weroar'),(7,2,1,0,'money','weroar'),(8,2,2,0,'money','weroar'),(9,2,3,0,'money','weroar'),(10,2,4,0,'money','weroar'),(11,2,5,0,'money','weroar');
/*!40000 ALTER TABLE `contest_prize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contest_user`
--

DROP TABLE IF EXISTS `contest_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contest_user` (
  `fk_contest_id` int(10) unsigned NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL,
  `points_won_from_green_distance` int(15) unsigned NOT NULL DEFAULT '0',
  `points_won_from_events` int(15) unsigned NOT NULL DEFAULT '0',
  `total_points` int(15) NOT NULL DEFAULT '0',
  `in_the_prizes` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fk_contest_id`,`fk_user_id`),
  KEY `user_fk_idx` (`fk_user_id`),
  CONSTRAINT `contestuser_contest_fk` FOREIGN KEY (`fk_contest_id`) REFERENCES `contest` (`contest_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contestuser_user_fk` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contest_user`
--

LOCK TABLES `contest_user` WRITE;
/*!40000 ALTER TABLE `contest_user` DISABLE KEYS */;
INSERT INTO `contest_user` VALUES (1,1,0,0,0,0),(1,3,3,5,63,1),(1,4,25,2,59,0),(1,5,0,0,0,0),(1,6,0,0,0,0);
/*!40000 ALTER TABLE `contest_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_statistics`
--

DROP TABLE IF EXISTS `daily_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `daily_statistics` (
  `date` date NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL,
  `daily_points` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`date`,`fk_user_id`),
  KEY `dailystatistics_user_fk_idx` (`fk_user_id`),
  CONSTRAINT `dailystatistics_user_fk` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_statistics`
--

LOCK TABLES `daily_statistics` WRITE;
/*!40000 ALTER TABLE `daily_statistics` DISABLE KEYS */;
INSERT INTO `daily_statistics` VALUES ('2019-02-11',1,200),('2019-07-11',1,0),('2019-12-14',1,75);
/*!40000 ALTER TABLE `daily_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_contest_id` int(10) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `prize` int(15) NOT NULL DEFAULT '0',
  `duration_event_minutes` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `fk_event_contest_idx` (`fk_contest_id`),
  CONSTRAINT `event_contest_fk` FOREIGN KEY (`fk_contest_id`) REFERENCES `contest` (`contest_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,1,'Dentrofyteusi','2019-02-11 03:39:51',20,0),(2,1,'paralia','2019-02-11 03:39:51',18,0);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_user`
--

DROP TABLE IF EXISTS `event_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `event_user` (
  `fk_event_id` int(10) unsigned NOT NULL,
  `fk_user_id` int(10) unsigned NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  PRIMARY KEY (`fk_event_id`,`fk_user_id`),
  KEY `eventuser_user_fk_idx` (`fk_user_id`),
  CONSTRAINT `eventuser_event_fk` FOREIGN KEY (`fk_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventuser_user_fk` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_user`
--

LOCK TABLES `event_user` WRITE;
/*!40000 ALTER TABLE `event_user` DISABLE KEYS */;
INSERT INTO `event_user` VALUES (1,1,'2019-12-10 22:48:28','2019-12-10 22:48:44'),(1,3,'2019-02-11 03:39:51','2019-02-11 04:39:51');
/*!40000 ALTER TABLE `event_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `statistics` (
  `statistics_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(10) unsigned NOT NULL,
  `overal_points_from_green_distance` int(15) unsigned NOT NULL DEFAULT '0',
  `overal_points_from_events` int(15) unsigned NOT NULL DEFAULT '0',
  `overal_points` int(30) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`statistics_id`),
  UNIQUE KEY `fk_user_id_UNIQUE` (`fk_user_id`),
  KEY `statistics_user_fk_idx` (`fk_user_id`),
  CONSTRAINT `statistics_user_fk` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
INSERT INTO `statistics` VALUES (3,1,525,0,525);
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `surname` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'trixakias','1234','theo','bouras','damcbour@hotmail.com'),(3,'trixakias2','1234','theo','bouras','damcbousr@hotmail.com'),(4,'trixakias3','1234','theo','bouras','damcbou3sr@hotmail.com'),(5,'trixakias24','12334','theo','bouras','damcbouffsr@hotmail.com'),(6,'trixakidas24','12334','theo','bouras','damcdbouffsr@hotmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wallet` (
  `wallet_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(10) unsigned NOT NULL,
  `balance` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `fk_user_id_UNIQUE` (`fk_user_id`),
  KEY `user_fk_wallet_idx` (`fk_user_id`),
  CONSTRAINT `wallet_user_fk` FOREIGN KEY (`fk_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (2,6,0),(4,1,5400);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-14 22:10:34
