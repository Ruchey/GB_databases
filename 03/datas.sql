-- Generation time: Fri, 15 Nov 2019 10:44:56 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_25
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('17','alias'),
('11','aliquid'),
('18','distinctio'),
('16','eius'),
('7','esse'),
('10','esse'),
('3','et'),
('8','eum'),
('2','hic'),
('5','in'),
('15','in'),
('14','modi'),
('4','occaecati'),
('20','provident'),
('9','quaerat'),
('12','quasi'),
('13','qui'),
('1','rerum'),
('19','sunt'),
('6','ut'); 


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','unfriended','declined') COLLATE utf8_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `confirmed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `initiator_user_id` (`initiator_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `messages_from_user_id` (`from_user_id`),
  KEY `messages_to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_phone_idx` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` VALUES ('1','Alec','Rosenbaum','pamela56@example.org','1'),
('2','Dewayne','Schaefer','fay.kenna@example.com','818563'),
('3','Elyssa','Thompson','dorothea.littel@example.org','0'),
('4','Victoria','Von','ojacobs@example.com','1'),
('5','Austen','Bauch','norbert.abbott@example.com','4190034553'),
('6','Ruthe','Nitzsche','mankunding@example.net','0'),
('7','Gabe','Mills','nicklaus71@example.net','0'),
('8','Flossie','Waters','dock.schinner@example.com','159387'),
('9','Tommie','Effertz','vcorwin@example.net','0'),
('10','Toby','Bayer','jkohler@example.net','0'),
('11','Carissa','Wisoky','kheaney@example.net','0'),
('12','Braulio','Herzog','jayne.bayer@example.net','0'),
('13','Willow','Feest','jordyn91@example.net','75'),
('14','Earnestine','Durgan','jbruen@example.org','1'),
('15','Curt','Hessel','qlueilwitz@example.org','0'),
('16','Asa','Cremin','kendall.parisian@example.com','6614969828'),
('17','Lauryn','Klocko','christina88@example.net','1'),
('18','Darien','Carroll','earlene00@example.net','0'),
('19','Destiney','Corwin','jaylin.welch@example.net','0'),
('20','Lavon','Rowe','rau.ramona@example.com','973119'),
('21','Jon','Von','vonrueden.candelario@example.net','0'),
('22','Carmen','Bergnaum','ifay@example.org','0'),
('23','Ashly','Sanford','sabryna.reynolds@example.net','0'),
('24','Jerrod','Kerluke','francis.reinger@example.com','0'),
('25','Reva','Powlowski','amalia.corkery@example.net','53'),
('26','Weston','Padberg','considine.jorge@example.org','735'),
('27','Clarissa','Goodwin','geffertz@example.org','0'),
('28','Laurence','Barton','grady55@example.org','0'),
('29','Guadalupe','Rau','wisozk.moshe@example.org','1'),
('30','Kallie','Abshire','ocie.klocko@example.com','280'),
('31','Weston','Hyatt','nolan.rae@example.com','63'),
('32','Forrest','Swift','bosco.garret@example.net','0'),
('33','Berniece','Paucek','robyn.krajcik@example.com','62'),
('34','Courtney','Marvin','susanna.kuphal@example.net','0'),
('35','Maximilian','Williamson','paris.harber@example.org','0'),
('36','Krystel','Satterfield','gardner.daugherty@example.com','0'),
('37','Harmony','Klein','sporer.idell@example.net','1'),
('38','Leonie','Langworth','raquel73@example.net','0'),
('39','Juliana','Hermiston','pgrant@example.com','5324769006'),
('40','Natalia','Mann','king46@example.com','0'),
('41','Dovie','Spinka','reichert.sterling@example.net','1'),
('42','Winston','Klocko','vincent39@example.net','0'),
('43','Tom','Donnelly','rachael.emmerich@example.com','32'),
('44','Rodger','McLaughlin','lowe.pat@example.com','3431697161'),
('45','Evan','Labadie','heathcote.jena@example.net','1'),
('46','Ephraim','Russel','adeline60@example.net','295330'),
('47','Raina','Dicki','carlie.bauch@example.com','334381'),
('48','Gloria','Block','keagan18@example.com','9298935242'),
('49','Eryn','Torp','marley69@example.com','0'),
('50','Gust','Grimes','providenci.zulauf@example.net','1'),
('51','Giovanni','Shanahan','elisa.sawayn@example.org','2264795025'),
('52','Julia','Hahn','herminia.howe@example.com','2544493374'),
('53','Vida','Harvey','lernser@example.org','488'),
('54','Lenny','Rolfson','bo.rutherford@example.com','0'),
('55','Derek','Leffler','wolff.hyman@example.net','0'),
('56','Queenie','White','swiegand@example.com','1381589948'),
('57','Lindsey','Heaney','effertz.yesenia@example.net','0'),
('58','Krystal','Anderson','kunze.lavon@example.org','0'),
('59','Monserrat','Medhurst','zstrosin@example.net','1'),
('60','Sarai','Runolfsson','wuckert.alexis@example.net','0'),
('61','Krystal','Crooks','helga97@example.org','0'),
('62','Nola','Greenholt','oferry@example.org','0'),
('63','Macie','Steuber','hegmann.jorge@example.net','91'),
('64','Bo','Pfannerstill','jamison.simonis@example.org','0'),
('65','Dave','Fritsch','alang@example.net','1'),
('66','Maia','Raynor','katheryn.hammes@example.org','836'),
('67','Addison','Hermann','urban14@example.com','128020'),
('68','Royal','Larson','halie.kris@example.com','0'),
('69','Anastacio','Kuhn','marvin.little@example.com','0'),
('70','Joshuah','Cummerata','mohr.margarette@example.org','0'),
('71','Casey','Wolff','qo\'kon@example.net','0'),
('72','Candice','Predovic','dach.alfonso@example.org','0'),
('73','Hope','Effertz','murazik.paul@example.org','1'),
('74','Enid','Volkman','abdiel15@example.org','0'),
('75','Melissa','Mann','icrona@example.com','0'),
('76','Rudolph','Bauch','prosacco.lenore@example.org','6454255486'),
('77','Margie','Pagac','murphy.mayer@example.org','448666'),
('78','Audrey','Doyle','destiney06@example.net','59'),
('79','Cynthia','Kuhlman','dillan.mosciski@example.org','242'),
('80','Reese','Okuneva','predovic.modesto@example.net','1'),
('81','Gerda','Denesik','murphy66@example.com','1'),
('82','Brittany','Harvey','camden.kuhn@example.org','0'),
('83','Bernard','Legros','dana78@example.org','1'),
('84','Jacky','Monahan','violet05@example.net','0'),
('85','Warren','Heathcote','hand.damian@example.com','0'),
('86','Ellsworth','Jenkins','gwolf@example.net','0'),
('87','Myrtie','Zieme','katlyn74@example.org','0'),
('88','Ladarius','Trantow','ldeckow@example.com','0'),
('89','Lacey','Sipes','tbatz@example.com','0'),
('90','Antwon','Fritsch','antonietta.nader@example.org','0'),
('91','Verlie','West','kattie.heller@example.net','183310'),
('92','Quinten','Nolan','toy.nienow@example.net','0'),
('93','Gussie','McCullough','kherman@example.org','0'),
('94','Terrance','Casper','lucile80@example.net','0'),
('95','Melyna','Quitzon','eichmann.marion@example.org','0'),
('96','Theo','Wuckert','jackson.sawayn@example.net','0'),
('97','Wanda','Fisher','will.keely@example.net','0'),
('98','Athena','Turcotte','lesch.ella@example.com','1'),
('99','Ethan','Olson','amparo.baumbach@example.org','0'),
('100','Garnet','Dooley','friesen.liana@example.net','73'); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;





/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

