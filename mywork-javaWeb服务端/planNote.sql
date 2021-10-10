-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: plannote
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `cowork`
--

DROP TABLE IF EXISTS `cowork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cowork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plan_id` int NOT NULL,
  PRIMARY KEY (`id`,`user_id`),
  UNIQUE KEY `cowork_id_uindex` (`id`),
  KEY `cowork_user_id_fk` (`user_id`),
  KEY `cowork_plan_id_fk` (`plan_id`),
  CONSTRAINT `cowork_plan_id_fk` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cowork_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cowork`
--

LOCK TABLES `cowork` WRITE;
/*!40000 ALTER TABLE `cowork` DISABLE KEYS */;
/*!40000 ALTER TABLE `cowork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `coworkfull`
--

DROP TABLE IF EXISTS `coworkfull`;
/*!50001 DROP VIEW IF EXISTS `coworkfull`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `coworkfull` AS SELECT 
 1 AS `id`,
 1 AS `plan_id`,
 1 AS `partner`,
 1 AS `host`,
 1 AS `plan_name`,
 1 AS `plan`,
 1 AS `planLog`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `goal`
--

DROP TABLE IF EXISTS `goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `goal_name` varchar(255) DEFAULT NULL,
  `goal` text,
  UNIQUE KEY `goal_pk` (`id`),
  UNIQUE KEY `goal_pk_2` (`user_id`,`goal_name`),
  CONSTRAINT `goal_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goal`
--

LOCK TABLES `goal` WRITE;
/*!40000 ALTER TABLE `goal` DISABLE KEYS */;
INSERT INTO `goal` VALUES (12,9,'测试修改','{\"type\":\"goal\",\"goal\":{\"goal_name\":\"测试修改\",\"goal_plans\":[\"测试计划\",\"测试计划\"],\"goal_text\":{\"desc\":\"测试测测测测\",\"res\":\"测试\"}}}');
/*!40000 ALTER TABLE `goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acceptor` int NOT NULL,
  `sender` int NOT NULL,
  `content` text NOT NULL,
  `type` int NOT NULL,
  `read` int NOT NULL,
  UNIQUE KEY `notice_id_uindex` (`id`),
  KEY `notice_user_id_fk` (`acceptor`),
  KEY `notice_user_id_fk_2` (`sender`),
  CONSTRAINT `notice_user_id_fk` FOREIGN KEY (`acceptor`) REFERENCES `user` (`id`),
  CONSTRAINT `notice_user_id_fk_2` FOREIGN KEY (`sender`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (99,17,15,'{\"time\":\"2021/9/23 16:45:54\",\"plan_name\":\"创建一个新的测试计划\",\"plan\":{\"memCount\":0,\"informed\":false,\"manager\":{\"phone\":\"123456\",\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"},\"endDate\":\"2021 年 09 月 30 日\",\"excutor\":{},\"name\":\"创建一个新的测试计划\",\"member\":[{\"phone\":\"123456\",\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"},{\"phone\":\"123456\",\"name\":\"曹逸\",\"id\":2,\"email\":\"1@qq.com\"}],\"startTime\":\"10:07:41\",\"endTime\":\"10:07:42\",\"type\":\"小组计划\",\"startDate\":\"2021 年 09 月 01 日\",\"desc\":\"这是一个新的测试计划的计划描述\"},\"pro\":{\"proMem\":[{\"phone\":\"123456\",\"name\":\"曹逸\",\"id\":2,\"email\":\"1@qq.com\",\"status\":2}],\"endDate\":\"2021 年 09 月 28 日\",\"startTime\":\"10:08:20\",\"id\":1,\"pro_text\":\"这是一个计划任务1\",\"endTime\":\"10:08:21\",\"startDate\":\"2021 年 09 月 02 日\",\"status\":2,\"pro_name\":\"计划任务1\"},\"extraMsg\":\"这是一条任务进度提醒，请您尽快完成指定任务，点击下方任务详情查看任务内容\",\"accepted\":false}',5,1),(130,17,15,'{\"cowork_id\":47,\"proId\":2,\"type\":\"acceptRequestInfo\",\"status\":1.5,\"plan_name\":\"测试计划\",\"pro_name\":\"添加任务2\",\"time\":\"2021/9/27 15:23:55\"}',3,1),(133,17,15,'{\"time\":\"2021/9/28 16:44:46\",\"pro\":[{\"proMem\":[{\"phone\":\"123456\",\"user_id\":17,\"name\":\"曹逸\",\"host\":false,\"id\":1,\"email\":\"1@qq.com\",\"status\":2}],\"endDate\":\"2021 年 09 月 24 日\",\"startTime\":\"19:15:41\",\"id\":1,\"pro_text\":\"这是一个测试任务\",\"endTime\":\"19:15:41\",\"startDate\":\"2021 年 09 月 09 日\",\"status\":2,\"pro_name\":\"测试任务\"},{\"proMem\":[{\"phone\":\"123456\",\"user_id\":17,\"name\":\"曹逸\",\"host\":false,\"id\":1,\"email\":\"1@qq.com\",\"status\":2},{\"phone\":\"123456\",\"user_id\":9,\"name\":\"厚礼谢\",\"id\":2,\"email\":\"1511500653@qq.com\",\"status\":0}],\"endDate\":\"2021 年 09 月 28 日\",\"excutors\":[],\"startTime\":\"15:21:05\",\"id\":2,\"pro_text\":\"添加任务2\",\"endTime\":\"15:21:06\",\"startdate\":\"\",\"startDate\":\"2021 年 09 月 03 日\",\"status\":1,\"pro_name\":\"添加任务2\"}],\"plan_name\":\"测试计划\",\"extraMsg\":\"\",\"plan\":{\"memCount\":0,\"informed\":false,\"manager\":{\"phone\":\"123456\",\"user_id\":15,\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"},\"endDate\":\"2021 年 09 月 30 日\",\"excutor\":{},\"name\":\"测试计划\",\"member\":[{\"phone\":\"123456\",\"user_id\":15,\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"},{\"phone\":\"123456\",\"user_id\":17,\"name\":\"曹逸\",\"host\":false,\"id\":1,\"email\":\"1@qq.com\"},{\"phone\":\"123456\",\"user_id\":9,\"name\":\"厚礼谢\",\"id\":2,\"email\":\"1511500653@qq.com\"}],\"startTime\":\"19:15:22\",\"endTime\":\"19:15:23\",\"type\":\"小组计划\",\"startDate\":\"2021 年 09 月 01 日\",\"desc\":\"这是一个测试计划123123123\"},\"accepted\":false}',2,0);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `noticeFull`
--

DROP TABLE IF EXISTS `noticeFull`;
/*!50001 DROP VIEW IF EXISTS `noticeFull`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `noticeFull` AS SELECT 
 1 AS `id`,
 1 AS `acceptor`,
 1 AS `sender`,
 1 AS `content`,
 1 AS `type`,
 1 AS `read`,
 1 AS `sender_name`,
 1 AS `sender_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plan_text` text,
  `planLog_text` text,
  `plan_name` varchar(255) NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `plan_pk` (`user_id`,`plan_name`),
  CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan`
--

LOCK TABLES `plan` WRITE;
/*!40000 ALTER TABLE `plan` DISABLE KEYS */;
INSERT INTO `plan` VALUES (90,9,'{\"process\":[{\"startTime\":\"16:52:18\",\"pro_text\":\"好的开始是成功的一半！\",\"startDate\":\"2021 年 09 月 01 日\",\"pro_name\":\"计划开始\"},{\"proMem\":[{\"engaged\":[],\"phone\":\"\",\"name\":\"曹逸\",\"email\":\"HelloWorld\"},{\"phone\":\"123\",\"name\":\"测试\",\"email\":\"123@qq.com\"}],\"endDate\":\"2021 年 09 月 16 日\",\"startTime\":\"16:52:35\",\"id\":1,\"pro_text\":\"测试任务\",\"endTime\":\"16:52:36\",\"startDate\":\"2021 年 09 月 08 日\",\"status\":0,\"pro_name\":\"测试任务\"},{\"startTime\":\"16:52:19\",\"pro_text\":\"坚持就是胜利！\",\"startDate\":\"2021 年 09 月 30 日\",\"pro_name\":\"计划结束\"}],\"type\":\"planItemTest2\",\"plan\":{\"memCount\":0,\"informed\":false,\"manager\":\"曹逸\",\"endDate\":\"2021 年 09 月 30 日\",\"excutor\":\"\",\"name\":\"测试计划\",\"member\":[{\"engaged\":[],\"phone\":\"\",\"name\":\"曹逸\",\"email\":\"HelloWorld\"},{\"phone\":\"123\",\"name\":\"测试\",\"email\":\"123@qq.com\"}],\"startTime\":\"16:52:18\",\"endTime\":\"16:52:19\",\"type\":\"小组计划\",\"startDate\":\"2021 年 09 月 01 日\",\"desc\":\"计划测试\"}}','{\"_id\":\"xryljU53X0VciEvW\",\"type\":\"planItemNotes\",\"dailyNotes\":{},\"plan\":\"测试计划\"}','测试计划'),(209,1,'{\"process\":[{\"startTime\":\"22:49:43\",\"pro_text\":\"好的开始是成功的一半！\",\"startDate\":\"2021 年 09 月 01 日\",\"pro_name\":\"计划开始\"},{\"proMem\":[{\"user_id\":1,\"name\":\"法克\",\"host\":true,\"id\":0,\"email\":\"Aa15340521294@163.com\",\"status\":0},{\"phone\":\"123456\",\"user_id\":9,\"name\":\"厚礼谢\",\"id\":1,\"email\":\"1511500653@qq.com\",\"status\":0}],\"endDate\":\"2021 年 09 月 22 日\",\"startTime\":\"22:49:52\",\"id\":1,\"pro_text\":\"创建测试任务\",\"endTime\":\"22:49:53\",\"startDate\":\"2021 年 09 月 09 日\",\"status\":0,\"pro_name\":\"测试任务\"},{\"startTime\":\"22:49:44\",\"pro_text\":\"坚持就是胜利！\",\"startDate\":\"2021 年 09 月 30 日\",\"pro_name\":\"计划结束\"}],\"type\":\"planItemTest2\",\"plan\":{\"memCount\":0,\"informed\":false,\"manager\":{\"informed\":true,\"user_id\":1,\"name\":\"法克\",\"host\":true,\"id\":0,\"email\":\"Aa15340521294@163.com\"},\"endDate\":\"2021 年 09 月 30 日\",\"excutor\":{},\"name\":\"创建测试计划\",\"member\":[{\"user_id\":1,\"name\":\"法克\",\"host\":true,\"id\":0,\"email\":\"Aa15340521294@163.com\"},{\"phone\":\"123456\",\"user_id\":9,\"name\":\"厚礼谢\",\"id\":1,\"email\":\"1511500653@qq.com\",\"informed\":true}],\"startTime\":\"22:49:43\",\"endTime\":\"22:49:44\",\"type\":\"小组计划\",\"startDate\":\"2021 年 09 月 01 日\",\"desc\":\"阿斯顿发顺丰\"},\"id\":209,\"_id\":\"z3ECB6ZB2WKFbXeY\"}','{\"_id\":\"rwBBHPDpq44J53dQ\",\"type\":\"planItemNotes\",\"dailyNotes\":{},\"plan\":\"创建测试计划\"}','创建测试计划'),(214,15,'{\"process\":[{\"startTime\":\"11:09:48\",\"pro_text\":\"好的开始是成功的一半！\",\"startDate\":\"2021 年 10 月 01 日\",\"pro_name\":\"计划开始\"},{\"proMem\":[],\"endDate\":\"2021 年 10 月 07 日\",\"startTime\":\"11:10:07\",\"id\":1,\"pro_text\":\"这是一个本地任务\",\"endTime\":\"11:10:11\",\"startDate\":\"2021 年 10 月 01 日\",\"status\":0,\"pro_name\":\"创建本地任务\"},{\"startTime\":\"11:09:50\",\"pro_text\":\"坚持就是胜利！\",\"startDate\":\"2021 年 10 月 31 日\",\"pro_name\":\"计划结束\"}],\"type\":\"planItemTest2\",\"plan\":{\"memCount\":0,\"informed\":false,\"manager\":{\"phone\":\"123456\",\"user_id\":15,\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"},\"endDate\":\"2021 年 10 月 31 日\",\"name\":\"创建本地计划\",\"member\":[{\"phone\":\"123456\",\"user_id\":15,\"name\":\"刘一刀\",\"host\":true,\"id\":0,\"email\":\"123@qq.com\"}],\"startTime\":\"11:09:48\",\"endTime\":\"11:09:50\",\"type\":\"小组计划\",\"startDate\":\"2021 年 10 月 01 日\",\"desc\":\"这是一个本地计划\"}}','{\"type\":\"planItemNotes\",\"dailyNotes\":{},\"plan\":\"创建本地计划\"}','创建本地计划');
/*!40000 ALTER TABLE `plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`email`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_pk` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Aa15340521294@163.com','456234',NULL,'法克'),(9,'1511500653@qq.com','456234',NULL,'厚礼谢'),(15,'123@qq.com','123456','123456','刘一刀'),(16,'123','123','123','曹逸'),(17,'1@qq.com','123456','123456','曹逸');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `coworkfull`
--

/*!50001 DROP VIEW IF EXISTS `coworkfull`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `coworkfull` AS select `c`.`id` AS `id`,`c`.`plan_id` AS `plan_id`,`c`.`user_id` AS `partner`,`p`.`user_id` AS `host`,`p`.`plan_name` AS `plan_name`,`p`.`plan_text` AS `plan`,`p`.`planLog_text` AS `planLog` from (`cowork` `c` join `plan` `p` on((`c`.`plan_id` = `p`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `noticefull`
--

/*!50001 DROP VIEW IF EXISTS `noticefull`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `noticefull` AS select `n`.`id` AS `id`,`n`.`acceptor` AS `acceptor`,`n`.`sender` AS `sender`,`n`.`content` AS `content`,`n`.`type` AS `type`,`n`.`read` AS `read`,`u`.`user_name` AS `sender_name`,`u`.`email` AS `sender_email` from (`notice` `n` join `user` `u`) where (`n`.`sender` = `u`.`id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-05  0:02:49
