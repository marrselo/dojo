/*
SQLyog Enterprise - MySQL GUI v8.02 RC
MySQL - 5.5.15-log : Database - dojo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `acc` */

DROP TABLE IF EXISTS `acc`;

CREATE TABLE `acc` (
  `idacc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idacc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `art_prov` */

DROP TABLE IF EXISTS `art_prov`;

CREATE TABLE `art_prov` (
  `idart` int(11) NOT NULL,
  `idpro` int(11) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `pre_cos` decimal(10,2) NOT NULL,
  `pre_ven` decimal(10,2) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idart`,`idpro`),
  KEY `fk_art_prov_art1` (`idart`),
  KEY `fk_art_prov_pro1` (`idpro`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='articulos x proveedor';

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
  `slugporada` int(1) DEFAULT '0',
  PRIMARY KEY (`idarticulo`),
  KEY `fk_art_sub_fam` (`idcategoria`),
  KEY `fk_art_combo1` (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `car` */

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `idcar` int(11) NOT NULL DEFAULT '0',
  `pla` varchar(50) DEFAULT NULL,
  `mar` varchar(50) NOT NULL,
  `mdl` varchar(50) NOT NULL,
  PRIMARY KEY (`idcar`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `categoria` */

DROP TABLE IF EXISTS `categoria`;

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `nombre` char(50) DEFAULT NULL,
  `estado` int(1) DEFAULT '1',
  `idpadre` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcategoria`),
  FULLTEXT KEY `cod` (`codigo`),
  FULLTEXT KEY `des` (`descripcion`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `apellidomaterno` char(50) DEFAULT NULL,
  `apellidopaterno` varchar(50) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `dni` char(18) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono1` varchar(15) DEFAULT NULL,
  `telefono2` varchar(15) NOT NULL,
  `movil` varchar(15) DEFAULT NULL,
  `flagactivo` int(11) NOT NULL,
  `ruc` char(14) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1',
  `razonsocial` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idcliente`)
) ENGINE=MyISAM AUTO_INCREMENT=460 DEFAULT CHARSET=utf8;

/*Table structure for table `cobro` */

DROP TABLE IF EXISTS `cobro`;

CREATE TABLE `cobro` (
  `idcobro` int(11) NOT NULL AUTO_INCREMENT,
  `idmdo` int(11) NOT NULL,
  `idemp` int(11) NOT NULL,
  `fec` date NOT NULL,
  `act` int(11) NOT NULL,
  PRIMARY KEY (`idcobro`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Table structure for table `combo` */

DROP TABLE IF EXISTS `combo`;

CREATE TABLE `combo` (
  `idcombo` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) NOT NULL,
  `fla` char(1) NOT NULL,
  PRIMARY KEY (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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

/*Table structure for table `crg` */

DROP TABLE IF EXISTS `crg`;

CREATE TABLE `crg` (
  `idcrg` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcrg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `detalledocumentopago` */

DROP TABLE IF EXISTS `detalledocumentopago`;

CREATE TABLE `detalledocumentopago` (
  `iddetalledocumento` int(11) NOT NULL AUTO_INCREMENT,
  `iddocumento` int(11) NOT NULL,
  `cantidad` smallint(6) DEFAULT '0',
  `importe` smallint(6) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  PRIMARY KEY (`iddetalledocumento`),
  KEY `fk_det_doc_doc1` (`iddocumento`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Table structure for table `detalleslug` */

DROP TABLE IF EXISTS `detalleslug`;

CREATE TABLE `detalleslug` (
  `iddetalleslug` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) DEFAULT NULL,
  `idslug` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddetalleslug`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `documentopago` */

DROP TABLE IF EXISTS `documentopago`;

CREATE TABLE `documentopago` (
  `iddocumento` int(11) NOT NULL AUTO_INCREMENT,
  `numeroserie` varchar(10) NOT NULL,
  `numerocomprobante` int(11) NOT NULL,
  `fechacreacion` date NOT NULL,
  `fecvencimiento` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `idtipodocumento` int(11) NOT NULL,
  `idempresa` tinyint(4) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idestado` int(11) NOT NULL COMMENT '0 pedido, 1 entregado, 2 eliminado',
  `flagactivo` int(11) DEFAULT NULL,
  `moneda` char(10) NOT NULL,
  `tipocambio` decimal(10,2) NOT NULL,
  `idvendedor` varchar(150) NOT NULL,
  `IGV` char(3) NOT NULL DEFAULT 'SIN',
  `comentario` varchar(250) DEFAULT NULL,
  `idpedido` int(11) DEFAULT NULL COMMENT 'en caso de que el comprobante viene de un pedido',
  `direccion` text,
  PRIMARY KEY (`iddocumento`),
  KEY `fk_doc_tip_doc1` (`idtipodocumento`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Table structure for table `empresa` */

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `dni` varchar(50) DEFAULT NULL,
  `ruc` varchar(10) DEFAULT NULL,
  `tlf_fij` varchar(50) DEFAULT NULL,
  `tlf_mov` varchar(50) DEFAULT NULL,
  `fec_ing` date DEFAULT NULL,
  `act` int(11) DEFAULT NULL,
  PRIMARY KEY (`idempresa`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

/*Table structure for table `est` */

DROP TABLE IF EXISTS `est`;

CREATE TABLE `est` (
  `idest` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `est_per` */

DROP TABLE IF EXISTS `est_per`;

CREATE TABLE `est_per` (
  `idest_per` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest_per`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `kardex` */

DROP TABLE IF EXISTS `kardex`;

CREATE TABLE `kardex` (
  `idkardex` int(11) NOT NULL AUTO_INCREMENT,
  `iddoc` int(11) NOT NULL,
  `cantidadtotal` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `idarticulo` int(11) NOT NULL,
  `fla` int(11) DEFAULT NULL COMMENT '1 ingreso / 2 egreso',
  `motivo` text NOT NULL,
  PRIMARY KEY (`idkardex`),
  KEY `fk_kar_doc1` (`iddoc`),
  KEY `fk_kar_art1` (`idarticulo`)
) ENGINE=MyISAM AUTO_INCREMENT=4435 DEFAULT CHARSET=utf8;

/*Table structure for table `mantenimientopagina` */

DROP TABLE IF EXISTS `mantenimientopagina`;

CREATE TABLE `mantenimientopagina` (
  `idpagina` int(11) NOT NULL AUTO_INCREMENT,
  `nombrepagina` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`idpagina`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `mdo` */

DROP TABLE IF EXISTS `mdo`;

CREATE TABLE `mdo` (
  `idmdo` int(11) NOT NULL DEFAULT '0',
  `des` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idmdo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` char(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmenu`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `niv_acc` */

DROP TABLE IF EXISTS `niv_acc`;

CREATE TABLE `niv_acc` (
  `idniv_acc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idniv_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `numeroserie` */

DROP TABLE IF EXISTS `numeroserie`;

CREATE TABLE `numeroserie` (
  `idnumeroserie` int(11) NOT NULL AUTO_INCREMENT,
  `idtip_doc` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `serie` char(2) NOT NULL,
  `desde` int(11) DEFAULT NULL,
  `hasta` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  PRIMARY KEY (`idnumeroserie`),
  KEY `fk_nse_sucur1` (`idsucursal`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `perfil` */

DROP TABLE IF EXISTS `perfil`;

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) DEFAULT NULL,
  `idmenu` int(11) DEFAULT NULL,
  PRIMARY KEY (`idperfil`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `pre_cli` */

DROP TABLE IF EXISTS `pre_cli`;

CREATE TABLE `pre_cli` (
  `idcli` int(11) NOT NULL,
  `idart` int(11) NOT NULL,
  `pre` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idcli`,`idart`),
  KEY `fk_pre_cli_cli1` (`idcli`),
  KEY `fk_pre_cli_art1` (`idart`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `pro` */

DROP TABLE IF EXISTS `pro`;

CREATE TABLE `pro` (
  `idpro` int(11) NOT NULL AUTO_INCREMENT,
  `raz` varchar(50) DEFAULT NULL,
  `ruc` varchar(50) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `ema` varchar(100) NOT NULL,
  `tlf` varchar(50) DEFAULT NULL,
  `dir` text,
  PRIMARY KEY (`idpro`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `rec` */

DROP TABLE IF EXISTS `rec`;

CREATE TABLE `rec` (
  `idrec` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) DEFAULT NULL,
  `fec` date DEFAULT NULL,
  `pag` decimal(10,3) DEFAULT NULL,
  `iddoc` int(11) DEFAULT NULL,
  `idemp` int(11) DEFAULT NULL,
  `fla` int(11) NOT NULL,
  PRIMARY KEY (`idrec`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

/*Table structure for table `slug` */

DROP TABLE IF EXISTS `slug`;

CREATE TABLE `slug` (
  `idslug` int(11) NOT NULL AUTO_INCREMENT,
  `nombreslug` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idslug`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `sto` */

DROP TABLE IF EXISTS `sto`;

CREATE TABLE `sto` (
  `idsto` int(11) NOT NULL DEFAULT '0',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sub_fam` */

DROP TABLE IF EXISTS `sub_fam`;

CREATE TABLE `sub_fam` (
  `idsubcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL DEFAULT '0',
  `cod` varchar(50) NOT NULL,
  `des` varchar(50) DEFAULT NULL,
  `dcto` int(11) NOT NULL,
  PRIMARY KEY (`idsubcategoria`,`idcategoria`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Table structure for table `sucur` */

DROP TABLE IF EXISTS `sucur`;

CREATE TABLE `sucur` (
  `idsucur` int(11) NOT NULL AUTO_INCREMENT,
  `des` varchar(250) NOT NULL,
  PRIMARY KEY (`idsucur`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `tip_cam` */

DROP TABLE IF EXISTS `tip_cam`;

CREATE TABLE `tip_cam` (
  `idtip_cam` int(11) NOT NULL AUTO_INCREMENT,
  `mon` decimal(10,2) NOT NULL,
  `fec` date NOT NULL,
  PRIMARY KEY (`idtip_cam`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Table structure for table `tip_cli` */

DROP TABLE IF EXISTS `tip_cli`;

CREATE TABLE `tip_cli` (
  `idtip_cli` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_cli`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `tip_doc` */

DROP TABLE IF EXISTS `tip_doc`;

CREATE TABLE `tip_doc` (
  `idtip_doc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_doc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `unidad` */

DROP TABLE IF EXISTS `unidad`;

CREATE TABLE `unidad` (
  `idunidad` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idunidad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellidopaterno` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellidomaterno` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idtipousuario` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT '1',
  `login` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` char(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `correo` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FlagSuperUsuario` int(1) DEFAULT '0',
  PRIMARY KEY (`idusuario`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/* Trigger structure for table `kardex` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `TG_actualizarStock` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `TG_actualizarStock` BEFORE INSERT ON `kardex` FOR EACH ROW BEGIN
DECLARE cantidadTotal INT;
DECLARE cantidadFinal INT;
SELECT cantidad INTO cantidadTotal FROM articulo WHERE idarticulo = new.idarticulo;
IF new.fla = 2 THEN
   SET cantidadFinal = (cantidadTotal - new.stock) ;
ELSE
   SET cantidadFinal = (new.stock + cantidadTotal) ;
END IF;
UPDATE articulo SET cantidad = cantidadFinal WHERE idarticulo= new.idarticulo;
END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
