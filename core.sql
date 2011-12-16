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

/*Table structure for table `acc` */

DROP TABLE IF EXISTS `acc`;

CREATE TABLE `acc` (
  `idacc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idacc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `acc` */

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

/*Data for the table `art_prov` */

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
  PRIMARY KEY (`idarticulo`),
  KEY `fk_art_sub_fam` (`idcategoria`),
  KEY `fk_art_combo1` (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

insert  into `articulo`(`idarticulo`,`idcategoria`,`idcombo`,`idunidad`,`codigo`,`nombre`,`descripcion`,`precioventa`,`preciocompra`,`cantidad`,`stock_min`,`peso`,`ubicacion`,`fla`,`imagen`,`slug`,`slugbusqueda`) values (1,9,NULL,0,'','coca cola descartable medio litro','nuevo','123.00','1233.00',123,NULL,NULL,NULL,1,'coca-cola-descartable-medio-litro-1.jpg','coca-cola-descartable-medio-litro-1','bebida soda gaseosa helada'),(2,9,NULL,0,'','pepsi medio litro','pepsi medio litro','123.00','123.00',0,NULL,NULL,NULL,1,'pepsi-medio-litro-2.jpg','pepsi-medio-litro-2','pepsi medio litro soda helada gaseosa');

/*Table structure for table `car` */

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `idcar` int(11) NOT NULL DEFAULT '0',
  `pla` varchar(50) DEFAULT NULL,
  `mar` varchar(50) NOT NULL,
  `mdl` varchar(50) NOT NULL,
  PRIMARY KEY (`idcar`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `car` */

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
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `categoria` */

insert  into `categoria`(`idcategoria`,`codigo`,`descripcion`,`nombre`,`estado`,`idpadre`) values (2,'12','categoria 1',NULL,NULL,NULL),(3,'23','categoria 2',NULL,NULL,NULL),(4,'','asdasd','asdasdd',NULL,2),(5,'','asdasd asdasd','asdasdd',NULL,NULL),(6,'',' asdasd asdasdasdasd','asdasdd',NULL,NULL),(7,'',' asdasd asdasdasdasd','asdasdd asdasd',NULL,NULL),(8,'',' asdasd asdasdasdasd','asdasdd asdasd asdasd',NULL,NULL),(9,'',' asdasd asdasdasdasd','sdfasdfasf',1,NULL),(10,'',' asdasd asdasdasdasd','sdfasdfasf asdasdas',1,NULL),(11,'','nazart asdasd','sdfasdfasf asdasd',1,NULL),(12,'','asdasd','asdasdasd',1,NULL),(13,'','asdasdasd','asdasdasdad',1,NULL),(14,'','asdasdasdasd','asdasdasdad',1,NULL),(15,'','asdfadf','asdasdasdfasdf',1,NULL),(19,'','asdfasdfdf','asdfasdf',1,NULL),(20,'','dfasdfasdfsdf','dfasdfasdfasdf',1,NULL);

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

/*Data for the table `cliente` */

insert  into `cliente`(`idcliente`,`apellidomaterno`,`apellidopaterno`,`nombre`,`direccion`,`dni`,`web`,`correo`,`telefono1`,`telefono2`,`movil`,`flagactivo`,`ruc`,`estado`,`razonsocial`) values (452,'huaman','jara','asdfasfa','sdfasdfasdf','44513557','','nazartjb@hotmail.com','12312333','','4234234234',0,'',1,NULL),(454,'dgsdgsd','sdfgsdgsd','jorge','sdgsdfg','445855587','','','sdgsdgsdfg','','',0,'',1,NULL),(455,'asdasdasd','asdadasd','asdasdasd','asdasdasd','44513555','','nazartajb@hotmail.com','123123123','','',0,'',1,NULL),(456,'asdasdfasfadf','sdfasdfaf','sdsdfsdf','dfasfdf','asdfdfsd','asdfsdfsd','nazaratjsb@hotmail.com','sdfsdf','','',0,'',1,NULL),(457,'jara','huaman','nazart','av. cajaranda','44513558','www.elcomercio.pe','nazart.villano@ec.pe','2355165','','',0,'',1,NULL),(458,'javier','carlo','nuevo','av. caasda asdasd','44513552','','','445121555','','',0,'',1,NULL),(459,'adaasdad','asdasdada','asdasdad','2332323','22334333','','naza@hotmailss.com','asadasd','','',0,'',1,NULL);

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

/*Data for the table `cobro` */

/*Table structure for table `combo` */

DROP TABLE IF EXISTS `combo`;

CREATE TABLE `combo` (
  `idcombo` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) NOT NULL,
  `fla` char(1) NOT NULL,
  PRIMARY KEY (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `combo` */

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

insert  into `core_session`(`Id`,`save_path`,`name`,`Modified`,`LifeTime`,`Data`) values ('7ovrq0apeh89t2k3ut32cc5vd5','','',1323643995,1440,'Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}'),('f7d175augm3rhqksb9dq5lgc40','','',1323931467,1440,'Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}dojo|a:1:{s:15:\"articuloEnLista\";a:0:{}}'),('fhp21sl0uvadciulim2buc1ra5','','',1323624973,1440,''),('lhnpd4d9m4j8kc6tqcsjb3pe67','','',1324005378,1440,''),('mlg2v3ehk76i71jqv6kab612g5','','',1324006604,1440,''),('n41cgnteg8avqp9r1topq7o7v1','','',1323917976,1440,'Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}dojo|a:1:{s:15:\"articuloEnLista\";a:0:{}}');

/*Table structure for table `crg` */

DROP TABLE IF EXISTS `crg`;

CREATE TABLE `crg` (
  `idcrg` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcrg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `crg` */

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

/*Data for the table `detalledocumentopago` */

insert  into `detalledocumentopago`(`iddetalledocumento`,`iddocumento`,`cantidad`,`importe`,`peso`,`precio`,`idarticulo`) values (23,19,1,123,NULL,'123.00',1),(22,19,1,123,NULL,'123.00',2),(24,20,1,123,NULL,'123.00',2),(25,20,1,123,NULL,'123.00',1),(26,21,1,123,NULL,'123.00',2),(27,21,1,123,NULL,'123.00',1);

/*Table structure for table `detalleslug` */

DROP TABLE IF EXISTS `detalleslug`;

CREATE TABLE `detalleslug` (
  `iddetalleslug` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) DEFAULT NULL,
  `idslug` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddetalleslug`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `detalleslug` */

insert  into `detalleslug`(`iddetalleslug`,`idarticulo`,`idslug`) values (7,3,5),(8,6282,5),(9,6282,1),(10,6282,2),(11,6282,8),(12,6282,9),(13,6283,10),(14,6283,1),(15,6283,2),(16,6283,8),(17,6283,9),(18,6283,11),(253,1,1),(254,1,2),(255,1,16),(256,1,8),(257,1,9),(258,1,10),(259,1,15),(260,1,7),(261,1,18),(271,2,11),(272,2,8),(273,2,9),(274,2,15),(275,2,18),(276,2,7);

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

/*Data for the table `documentopago` */

insert  into `documentopago`(`iddocumento`,`numeroserie`,`numerocomprobante`,`fechacreacion`,`fecvencimiento`,`total`,`idtipodocumento`,`idempresa`,`idcliente`,`idestado`,`flagactivo`,`moneda`,`tipocambio`,`idvendedor`,`IGV`,`comentario`,`idpedido`,`direccion`) values (21,'02',12333,'2011-07-14',NULL,NULL,2,0,454,1,1,'','0.00','1','18','sadadadasdasd',NULL,NULL),(20,'02',1212,'0000-00-00',NULL,NULL,2,0,452,1,1,'','0.00','1','18',NULL,NULL,NULL),(19,'02',123123123,'0000-00-00',NULL,NULL,2,0,454,1,1,'','0.00','1','18',NULL,NULL,NULL);

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

/*Data for the table `empresa` */

/*Table structure for table `est` */

DROP TABLE IF EXISTS `est`;

CREATE TABLE `est` (
  `idest` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `est` */

/*Table structure for table `est_per` */

DROP TABLE IF EXISTS `est_per`;

CREATE TABLE `est_per` (
  `idest_per` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest_per`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `est_per` */

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

/*Data for the table `kardex` */

insert  into `kardex`(`idkardex`,`iddoc`,`cantidadtotal`,`stock`,`fecha`,`idarticulo`,`fla`,`motivo`) values (4434,0,NULL,123,NULL,1,1,'asdfafd');

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

/*Table structure for table `mdo` */

DROP TABLE IF EXISTS `mdo`;

CREATE TABLE `mdo` (
  `idmdo` int(11) NOT NULL DEFAULT '0',
  `des` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idmdo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `mdo` */

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` char(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmenu`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `menu` */

insert  into `menu`(`idmenu`,`nombre`,`url`,`orden`) values (1,'Categoriás','/admin/categoria',2),(2,'Clientes','/admin/cliente',3),(3,'Artículo','/admin/articulo',4),(4,'Pedidos','/admin/pedidos',5),(5,'Comprobantes','/admin/comprobante',6),(6,'Usuario','/admin/usuario',7),(7,'Reportes','/admin/reportes',8),(8,'Admin','/admin/index',1);

/*Table structure for table `niv_acc` */

DROP TABLE IF EXISTS `niv_acc`;

CREATE TABLE `niv_acc` (
  `idniv_acc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idniv_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `niv_acc` */

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

/*Data for the table `numeroserie` */

insert  into `numeroserie`(`idnumeroserie`,`idtip_doc`,`idsucursal`,`serie`,`desde`,`hasta`,`num`,`flag`) values (1,1,0,'01',1,50,1,0),(2,2,0,'02',1,50,2,0);

/*Table structure for table `perfil` */

DROP TABLE IF EXISTS `perfil`;

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) DEFAULT NULL,
  `idmenu` int(11) DEFAULT NULL,
  PRIMARY KEY (`idperfil`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `perfil` */

insert  into `perfil`(`idperfil`,`idusuario`,`idmenu`) values (12,5,8),(11,5,2),(10,5,1);

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

/*Data for the table `pre_cli` */

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

/*Data for the table `pro` */

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

/*Data for the table `rec` */

/*Table structure for table `slug` */

DROP TABLE IF EXISTS `slug`;

CREATE TABLE `slug` (
  `idslug` int(11) NOT NULL AUTO_INCREMENT,
  `nombreslug` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idslug`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `slug` */

insert  into `slug`(`idslug`,`nombreslug`) values (1,'coca'),(2,'cola'),(3,'wisky'),(4,'ron'),(5,'bebidas'),(6,'pisco'),(7,'gaseosa'),(8,'medio'),(9,'litro'),(10,'bebida'),(11,'pepsi'),(12,'1'),(13,'2'),(14,'cocagaseosabebidasoda'),(15,'soda'),(16,'descartable'),(17,'bebidasodagaseosahelada'),(18,'helada');

/*Table structure for table `sto` */

DROP TABLE IF EXISTS `sto`;

CREATE TABLE `sto` (
  `idsto` int(11) NOT NULL DEFAULT '0',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sto` */

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

/*Data for the table `sub_fam` */

/*Table structure for table `sucur` */

DROP TABLE IF EXISTS `sucur`;

CREATE TABLE `sucur` (
  `idsucur` int(11) NOT NULL AUTO_INCREMENT,
  `des` varchar(250) NOT NULL,
  PRIMARY KEY (`idsucur`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sucur` */

/*Table structure for table `tip_cam` */

DROP TABLE IF EXISTS `tip_cam`;

CREATE TABLE `tip_cam` (
  `idtip_cam` int(11) NOT NULL AUTO_INCREMENT,
  `mon` decimal(10,2) NOT NULL,
  `fec` date NOT NULL,
  PRIMARY KEY (`idtip_cam`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `tip_cam` */

/*Table structure for table `tip_cli` */

DROP TABLE IF EXISTS `tip_cli`;

CREATE TABLE `tip_cli` (
  `idtip_cli` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_cli`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_cli` */

/*Table structure for table `tip_doc` */

DROP TABLE IF EXISTS `tip_doc`;

CREATE TABLE `tip_doc` (
  `idtip_doc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_doc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_doc` */

insert  into `tip_doc`(`idtip_doc`,`des`) values (1,'Boleta'),(2,'Factura'),(3,'Gia Remision');

/*Table structure for table `unidad` */

DROP TABLE IF EXISTS `unidad`;

CREATE TABLE `unidad` (
  `idunidad` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idunidad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `unidad` */

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

/*Data for the table `usuario` */

insert  into `usuario`(`idusuario`,`nombre`,`apellidopaterno`,`apellidomaterno`,`idtipousuario`,`estado`,`login`,`password`,`telefono`,`correo`,`FlagSuperUsuario`) values (1,'nazart','huaman','jara',NULL,1,'nazarjb@hotmail.com','123123','22312223','nazarjb@hotmail.com',1),(5,'nazart','huaman','jara',NULL,1,'nazart.villano@ec.pe','123456','54645656','nazart.villano@ec.pe',0);

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
