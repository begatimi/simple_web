CREATE DATABASE  IF NOT EXISTS `pkps` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pkps`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: pkps
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  `semester` varchar(45) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `university` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `enroll`
--

DROP TABLE IF EXISTS `enroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enroll` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`eid`),
  UNIQUE KEY `uq_enroll` (`cid`,`sid`),
  KEY `ecid_idx` (`cid`),
  KEY `enroll_sid_idx` (`sid`),
  CONSTRAINT `enroll_cid` FOREIGN KEY (`cid`) REFERENCES `classes` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enroll_sid` FOREIGN KEY (`sid`) REFERENCES `students` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructors` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `instructors_uid_idx` (`uid`),
  CONSTRAINT `instructors_uid` FOREIGN KEY (`uid`) REFERENCES `university` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `lectures`
--

DROP TABLE IF EXISTS `lectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`lid`),
  UNIQUE KEY `unique_lectures` (`cid`,`pid`),
  KEY `lectures_pid_idx` (`pid`),
  KEY `lectures_cid_idx` (`cid`),
  CONSTRAINT `lectures_cid` FOREIGN KEY (`cid`) REFERENCES `classes` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lectures_pid` FOREIGN KEY (`pid`) REFERENCES `instructors` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `post_reply`
--

DROP TABLE IF EXISTS `post_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_reply` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `postid` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `replyer` varchar(45) NOT NULL,
  `replymessage` varchar(255) NOT NULL,
  `replytime` datetime NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `pr_postid_idx` (`postid`),
  KEY `pr_pid_idx` (`pid`),
  KEY `pr_sid_idx` (`sid`),
  CONSTRAINT `pr_pid` FOREIGN KEY (`pid`) REFERENCES `instructors` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pr_postid` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pr_sid` FOREIGN KEY (`sid`) REFERENCES `students` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `ptype` varchar(45) NOT NULL,
  `pto` varchar(45) NOT NULL,
  `poster` varchar(45) NOT NULL,
  `title` varchar(85) NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`postid`),
  KEY `post_cid_idx` (`cid`),
  KEY `post_uid_idx` (`uid`),
  KEY `post_sid_idx` (`sid`),
  KEY `post_pid_idx` (`pid`),
  CONSTRAINT `post_cid` FOREIGN KEY (`cid`) REFERENCES `classes` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_pid` FOREIGN KEY (`pid`) REFERENCES `instructors` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `post_sid` FOREIGN KEY (`sid`) REFERENCES `students` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `post_uid` FOREIGN KEY (`uid`) REFERENCES `university` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `student_uid_idx` (`uid`),
  CONSTRAINT `student_uid` FOREIGN KEY (`uid`) REFERENCES `university` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `domain` varchar(45) DEFAULT NULL,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (1,'Universiteti i Prishtines','uni-pr.edu','Kosovo'),(2,'Universiteti i Tiranes','uni-tr.edu','Shqiperi');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-20 22:09:33
