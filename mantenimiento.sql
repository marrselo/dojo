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

/*Table structure for table `mantenimientopagina` */

DROP TABLE IF EXISTS `mantenimientopagina`;

CREATE TABLE `mantenimientopagina` (
  `idpagina` int(11) NOT NULL AUTO_INCREMENT,
  `nombrepagina` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`idpagina`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mantenimientopagina` */

insert  into `mantenimientopagina`(`idpagina`,`nombrepagina`,`descripcion`) values (1,'Zonas de Reparto',NULL),(2,'Politicas',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
