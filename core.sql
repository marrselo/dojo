/*
SQLyog Enterprise - MySQL GUI v8.02 RC
MySQL - 5.5.15-log : Database - dojo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`dojo` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `dojo`;

/*Table structure for table `core_session` */

DROP TABLE IF EXISTS `core_session`;

CREATE TABLE `core_session` (
  `Id` varchar(32) NOT NULL,
  `save_path` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `Modified` int(11) DEFAULT NULL,
  `LifeTime` int(11) DEFAULT NULL,
  `Data` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `core_session` */

insert  into `core_session`(`Id`,`save_path`,`name`,`Modified`,`LifeTime`,`Data`) values ('7ovrq0apeh89t2k3ut32cc5vd5','','',1323639536,1440,'Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}dojo|a:1:{s:15:\"articuloEnLista\";a:0:{}}'),('fhp21sl0uvadciulim2buc1ra5','','',1323624973,1440,'');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
