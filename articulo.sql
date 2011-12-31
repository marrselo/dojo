/*
SQLyog Enterprise - MySQL GUI v8.02 RC
MySQL - 5.5.15-log : Database - dojo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `articulo` */

DROP TABLE IF EXISTS `articulo`;

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL,
  `idcombo` int(11) DEFAULT NULL,
  `idunidad` int(11) NOT NULL,
  `codigo` char(15) NOT NULL,
  `nombre` char(100) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `precioventa` decimal(10,2) DEFAULT NULL,
  `preciocompra` decimal(10,2) DEFAULT NULL,
  `cantidad` smallint(6) NOT NULL,
  `stock_min` smallint(6) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `ubicacion` char(4) DEFAULT NULL,
  `fla` int(11) DEFAULT NULL,
  `imagen` char(200) DEFAULT NULL,
  `slug` char(200) DEFAULT NULL,
  `slugbusqueda` text,
  `idsubcategoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`idarticulo`),
  KEY `fk_art_sub_fam` (`idcategoria`),
  KEY `fk_art_combo1` (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
