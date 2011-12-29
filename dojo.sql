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

/*Data for the table `acc` */

LOCK TABLES `acc` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `art_prov` WRITE;

UNLOCK TABLES;

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

/*Data for the table `articulo` */

LOCK TABLES `articulo` WRITE;

insert  into `articulo`(`idarticulo`,`idcategoria`,`idcombo`,`idunidad`,`codigo`,`nombre`,`descripcion`,`precioventa`,`preciocompra`,`cantidad`,`stock_min`,`peso`,`ubicacion`,`fla`,`imagen`,`slug`,`slugbusqueda`,`idsubcategoria`,`slugporada`) values (1,9,NULL,0,'','coca cola descartable medio litro','nuevo','123.00','1233.00',123,NULL,NULL,NULL,1,'coca-cola-descartable-medio-litro-1.jpg','coca-cola-descartable-medio-litro-1','bebida soda gaseosa helada',NULL,NULL),(2,9,NULL,0,'','pepsi medio litro','pepsi medio litro','123.00','123.00',0,NULL,NULL,NULL,1,'pepsi-medio-litro-2.jpg','pepsi-medio-litro-2','pepsi medio litro soda helada gaseosa',NULL,NULL),(3,33,NULL,0,'','Cristal 355 mL 12pack','Cristal 355 mL 12pack','3.45','1.34',0,NULL,NULL,NULL,1,'cristal-355-ml-12pack-3.jpg','cristal-355-ml-12pack-3','cristal 355 ml 12pack cerveza chela',34,NULL),(4,33,NULL,0,'','Cusqueña 355 mL12pack','Cusqueña 355 mL12pack','2.45','1.34',0,NULL,NULL,NULL,1,'cusquena-355-ml12pack-4.jpg','cusquena-355-ml12pack-4','cusquena 355 ml12pack',34,NULL),(5,33,NULL,0,'','Barena 330 mL 6pack','Barena 330 mL 6pack','2.45','0.00',0,NULL,NULL,NULL,1,'barena-330-ml-6pack-5.jpg','barena-330-ml-6pack-5','barena 330 ml 6pack chela six pack sixpack',34,NULL),(6,33,NULL,0,'','Pilsen Callao 355 mL 12pack','Pilsen Callao 355 mL 12pack','23.00','21.00',0,NULL,NULL,NULL,1,'pilsen-callao-355-ml-12pack-6.jpg','pilsen-callao-355-ml-12pack-6','pilsen callao 355 ml 12pack cerveza chela licor',34,0);

UNLOCK TABLES;

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

LOCK TABLES `car` WRITE;

UNLOCK TABLES;

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

/*Data for the table `categoria` */

LOCK TABLES `categoria` WRITE;

insert  into `categoria`(`idcategoria`,`codigo`,`descripcion`,`nombre`,`estado`,`idpadre`) values (38,'','Whisky','Whisky',1,33),(42,'','Gaseosas','Gaseosas',1,32),(41,'','Pisco','Pisco',1,33),(40,'','Ron','Ron',1,33),(39,'','Vodka','Vodka',1,33),(37,'','Hielo y Otros','Hielo y Otros',1,NULL),(36,'','Cigarros','Cigarros',1,NULL),(35,'','Snacks y Piqueos','Snacks y Piqueos',1,NULL),(34,'','Cerveza','Cerveza',1,33),(33,'','Licores','Licores',1,NULL),(32,'','bebidas','bebidas y aguas',1,NULL);

UNLOCK TABLES;

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

LOCK TABLES `cliente` WRITE;

insert  into `cliente`(`idcliente`,`apellidomaterno`,`apellidopaterno`,`nombre`,`direccion`,`dni`,`web`,`correo`,`telefono1`,`telefono2`,`movil`,`flagactivo`,`ruc`,`estado`,`razonsocial`) values (452,'huaman','jara','asdfasfa','sdfasdfasdf','44513557','','nazartjb@hotmail.com','12312333','','4234234234',0,'',1,NULL),(454,'dgsdgsd','sdfgsdgsd','jorge','sdgsdfg','445855587','','','sdgsdgsdfg','','',0,'',1,NULL),(455,'asdasdasd','asdadasd','asdasdasd','asdasdasd','44513555','','nazartajb@hotmail.com','123123123','','',0,'',1,NULL),(456,'asdasdfasfadf','sdfasdfaf','sdsdfsdf','dfasfdf','asdfdfsd','asdfsdfsd','nazaratjsb@hotmail.com','sdfsdf','','',0,'',1,NULL),(457,'jara','huaman','nazart','av. cajaranda','44513558','www.elcomercio.pe','nazart.villano@ec.pe','2355165','','',0,'',1,NULL),(458,'javier','carlo','nuevo','av. caasda asdasd','44513552','','','445121555','','',0,'',1,NULL),(459,'adaasdad','asdasdada','asdasdad','2332323','22334333','','naza@hotmailss.com','asadasd','','',0,'',1,NULL);

UNLOCK TABLES;

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

LOCK TABLES `cobro` WRITE;

UNLOCK TABLES;

/*Table structure for table `combo` */

DROP TABLE IF EXISTS `combo`;

CREATE TABLE `combo` (
  `idcombo` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) NOT NULL,
  `fla` char(1) NOT NULL,
  PRIMARY KEY (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `combo` */

LOCK TABLES `combo` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `core_session` WRITE;

insert  into `core_session`(`Id`,`save_path`,`name`,`Modified`,`LifeTime`,`Data`) values ('nps3rd5tk5r51aarhg2n3bsub2','','',1325142181,1440,'dojo|a:1:{s:13:\"listaArticulo\";a:1:{i:3;a:20:{s:10:\"idarticulo\";s:1:\"3\";s:11:\"idcategoria\";s:2:\"33\";s:7:\"idcombo\";N;s:8:\"idunidad\";s:1:\"0\";s:6:\"codigo\";s:0:\"\";s:6:\"nombre\";s:21:\"Cristal 355 mL 12pack\";s:11:\"descripcion\";s:21:\"Cristal 355 mL 12pack\";s:11:\"precioventa\";s:4:\"3.45\";s:12:\"preciocompra\";s:4:\"1.34\";s:8:\"cantidad\";s:1:\"0\";s:9:\"stock_min\";N;s:4:\"peso\";N;s:9:\"ubicacion\";N;s:3:\"fla\";s:1:\"1\";s:6:\"imagen\";s:27:\"cristal-355-ml-12pack-3.jpg\";s:4:\"slug\";s:23:\"cristal-355-ml-12pack-3\";s:12:\"slugbusqueda\";s:35:\"cristal 355 ml 12pack cerveza chela\";s:14:\"idsubcategoria\";s:2:\"34\";s:10:\"slugporada\";N;s:16:\"cantidadArticulo\";i:20;}}}'),('vc54kokouukac9gilmkfc1bcb6','','',1325175999,1440,'dojo|a:1:{s:13:\"listaArticulo\";a:1:{i:4;a:20:{s:10:\"idarticulo\";s:1:\"4\";s:11:\"idcategoria\";s:2:\"33\";s:7:\"idcombo\";N;s:8:\"idunidad\";s:1:\"0\";s:6:\"codigo\";s:0:\"\";s:6:\"nombre\";s:22:\"Cusqueña 355 mL12pack\";s:11:\"descripcion\";s:22:\"Cusqueña 355 mL12pack\";s:11:\"precioventa\";s:4:\"2.45\";s:12:\"preciocompra\";s:4:\"1.34\";s:8:\"cantidad\";s:1:\"0\";s:9:\"stock_min\";N;s:4:\"peso\";N;s:9:\"ubicacion\";N;s:3:\"fla\";s:1:\"1\";s:6:\"imagen\";s:27:\"cusquena-355-ml12pack-4.jpg\";s:4:\"slug\";s:23:\"cusquena-355-ml12pack-4\";s:12:\"slugbusqueda\";s:21:\"cusquena 355 ml12pack\";s:14:\"idsubcategoria\";s:2:\"34\";s:10:\"slugporada\";N;s:16:\"cantidadArticulo\";s:1:\"5\";}}}Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}');

UNLOCK TABLES;

/*Table structure for table `crg` */

DROP TABLE IF EXISTS `crg`;

CREATE TABLE `crg` (
  `idcrg` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcrg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `crg` */

LOCK TABLES `crg` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `detalledocumentopago` WRITE;

insert  into `detalledocumentopago`(`iddetalledocumento`,`iddocumento`,`cantidad`,`importe`,`peso`,`precio`,`idarticulo`) values (23,19,1,123,NULL,'123.00',1),(22,19,1,123,NULL,'123.00',2),(24,20,1,123,NULL,'123.00',2),(25,20,1,123,NULL,'123.00',1),(26,21,1,123,NULL,'123.00',2),(27,21,1,123,NULL,'123.00',1);

UNLOCK TABLES;

/*Table structure for table `detalleslug` */

DROP TABLE IF EXISTS `detalleslug`;

CREATE TABLE `detalleslug` (
  `iddetalleslug` int(11) NOT NULL AUTO_INCREMENT,
  `idarticulo` int(11) DEFAULT NULL,
  `idslug` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddetalleslug`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `detalleslug` */

LOCK TABLES `detalleslug` WRITE;

insert  into `detalleslug`(`iddetalleslug`,`idarticulo`,`idslug`) values (8,6282,5),(9,6282,1),(10,6282,2),(11,6282,8),(12,6282,9),(13,6283,10),(14,6283,1),(15,6283,2),(16,6283,8),(17,6283,9),(18,6283,11),(253,1,1),(254,1,2),(255,1,16),(256,1,8),(257,1,9),(258,1,10),(259,1,15),(260,1,7),(261,1,18),(271,2,11),(272,2,8),(273,2,9),(274,2,15),(275,2,18),(276,2,7),(291,5,25),(292,5,26),(293,5,27),(294,5,28),(295,5,22),(296,5,23),(297,5,24),(298,5,29),(304,4,30),(305,4,31),(306,4,32),(307,3,20),(308,3,31),(309,3,27),(310,3,33),(311,3,19),(312,3,22),(313,0,34),(314,0,35),(315,0,31),(316,0,27),(317,0,33),(318,0,19),(319,0,36),(320,6,34),(321,6,35),(322,6,31),(323,6,27),(324,6,33),(325,6,19),(326,6,22),(327,6,37);

UNLOCK TABLES;

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

LOCK TABLES `documentopago` WRITE;

insert  into `documentopago`(`iddocumento`,`numeroserie`,`numerocomprobante`,`fechacreacion`,`fecvencimiento`,`total`,`idtipodocumento`,`idempresa`,`idcliente`,`idestado`,`flagactivo`,`moneda`,`tipocambio`,`idvendedor`,`IGV`,`comentario`,`idpedido`,`direccion`) values (21,'02',12333,'2011-07-14',NULL,NULL,2,0,454,1,1,'','0.00','1','18','sadadadasdasd',NULL,NULL),(20,'02',1212,'0000-00-00',NULL,NULL,2,0,452,1,1,'','0.00','1','18',NULL,NULL,NULL),(19,'02',123123123,'0000-00-00',NULL,NULL,2,0,454,1,1,'','0.00','1','18',NULL,NULL,NULL);

UNLOCK TABLES;

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

LOCK TABLES `empresa` WRITE;

UNLOCK TABLES;

/*Table structure for table `est` */

DROP TABLE IF EXISTS `est`;

CREATE TABLE `est` (
  `idest` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `est` */

LOCK TABLES `est` WRITE;

UNLOCK TABLES;

/*Table structure for table `est_per` */

DROP TABLE IF EXISTS `est_per`;

CREATE TABLE `est_per` (
  `idest_per` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idest_per`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `est_per` */

LOCK TABLES `est_per` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `kardex` WRITE;

insert  into `kardex`(`idkardex`,`iddoc`,`cantidadtotal`,`stock`,`fecha`,`idarticulo`,`fla`,`motivo`) values (4434,0,NULL,123,NULL,1,1,'asdfafd');

UNLOCK TABLES;

/*Table structure for table `mantenimientopagina` */

DROP TABLE IF EXISTS `mantenimientopagina`;

CREATE TABLE `mantenimientopagina` (
  `idpagina` int(11) NOT NULL AUTO_INCREMENT,
  `nombrepagina` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`idpagina`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mantenimientopagina` */

LOCK TABLES `mantenimientopagina` WRITE;

insert  into `mantenimientopagina`(`idpagina`,`nombrepagina`,`descripcion`) values (1,'Zonas de Reparto',NULL),(2,'Politicas',NULL);

UNLOCK TABLES;

/*Table structure for table `mdo` */

DROP TABLE IF EXISTS `mdo`;

CREATE TABLE `mdo` (
  `idmdo` int(11) NOT NULL DEFAULT '0',
  `des` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idmdo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `mdo` */

LOCK TABLES `mdo` WRITE;

UNLOCK TABLES;

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` char(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmenu`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `menu` */

LOCK TABLES `menu` WRITE;

insert  into `menu`(`idmenu`,`nombre`,`url`,`orden`) values (1,'Categoriás','/admin/categoria',2),(2,'Clientes','/admin/cliente',3),(3,'Artículo','/admin/articulo',4),(4,'Pedidos','/admin/pedidos',5),(5,'Comprobantes','/admin/comprobante',6),(6,'Usuario','/admin/usuario',7),(7,'Reportes','/admin/reportes',8),(8,'Admin','/admin/index',1),(9,'SubCategorias','/admin/subcategoria',NULL);

UNLOCK TABLES;

/*Table structure for table `niv_acc` */

DROP TABLE IF EXISTS `niv_acc`;

CREATE TABLE `niv_acc` (
  `idniv_acc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idniv_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `niv_acc` */

LOCK TABLES `niv_acc` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `numeroserie` WRITE;

insert  into `numeroserie`(`idnumeroserie`,`idtip_doc`,`idsucursal`,`serie`,`desde`,`hasta`,`num`,`flag`) values (1,1,0,'01',1,50,1,0),(2,2,0,'02',1,50,2,0);

UNLOCK TABLES;

/*Table structure for table `perfil` */

DROP TABLE IF EXISTS `perfil`;

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) DEFAULT NULL,
  `idmenu` int(11) DEFAULT NULL,
  PRIMARY KEY (`idperfil`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `perfil` */

LOCK TABLES `perfil` WRITE;

insert  into `perfil`(`idperfil`,`idusuario`,`idmenu`) values (12,5,8),(11,5,2),(10,5,1);

UNLOCK TABLES;

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

LOCK TABLES `pre_cli` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `pro` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `rec` WRITE;

UNLOCK TABLES;

/*Table structure for table `slug` */

DROP TABLE IF EXISTS `slug`;

CREATE TABLE `slug` (
  `idslug` int(11) NOT NULL AUTO_INCREMENT,
  `nombreslug` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idslug`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `slug` */

LOCK TABLES `slug` WRITE;

insert  into `slug`(`idslug`,`nombreslug`) values (1,'coca'),(2,'cola'),(3,'wisky'),(4,'ron'),(5,'bebidas'),(6,'pisco'),(7,'gaseosa'),(8,'medio'),(9,'litro'),(10,'bebida'),(11,'pepsi'),(12,'1'),(13,'2'),(14,'cocagaseosabebidasoda'),(15,'soda'),(16,'descartable'),(17,'bebidasodagaseosahelada'),(18,'helada'),(19,'cerveza'),(20,'cristal'),(21,'litros'),(22,'chela'),(23,'six'),(24,'pack'),(25,'barena'),(26,'330'),(27,'ml'),(28,'6pack'),(29,'sixpack'),(30,'cusquena'),(31,'355'),(32,'ml12pack'),(33,'12pack'),(34,'pilsen'),(35,'callao'),(36,'licores'),(37,'licor');

UNLOCK TABLES;

/*Table structure for table `sto` */

DROP TABLE IF EXISTS `sto`;

CREATE TABLE `sto` (
  `idsto` int(11) NOT NULL DEFAULT '0',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sto` */

LOCK TABLES `sto` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `sub_fam` WRITE;

UNLOCK TABLES;

/*Table structure for table `sucur` */

DROP TABLE IF EXISTS `sucur`;

CREATE TABLE `sucur` (
  `idsucur` int(11) NOT NULL AUTO_INCREMENT,
  `des` varchar(250) NOT NULL,
  PRIMARY KEY (`idsucur`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sucur` */

LOCK TABLES `sucur` WRITE;

UNLOCK TABLES;

/*Table structure for table `tip_cam` */

DROP TABLE IF EXISTS `tip_cam`;

CREATE TABLE `tip_cam` (
  `idtip_cam` int(11) NOT NULL AUTO_INCREMENT,
  `mon` decimal(10,2) NOT NULL,
  `fec` date NOT NULL,
  PRIMARY KEY (`idtip_cam`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `tip_cam` */

LOCK TABLES `tip_cam` WRITE;

UNLOCK TABLES;

/*Table structure for table `tip_cli` */

DROP TABLE IF EXISTS `tip_cli`;

CREATE TABLE `tip_cli` (
  `idtip_cli` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_cli`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_cli` */

LOCK TABLES `tip_cli` WRITE;

UNLOCK TABLES;

/*Table structure for table `tip_doc` */

DROP TABLE IF EXISTS `tip_doc`;

CREATE TABLE `tip_doc` (
  `idtip_doc` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtip_doc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_doc` */

LOCK TABLES `tip_doc` WRITE;

insert  into `tip_doc`(`idtip_doc`,`des`) values (1,'Boleta'),(2,'Factura'),(3,'Gia Remision');

UNLOCK TABLES;

/*Table structure for table `unidad` */

DROP TABLE IF EXISTS `unidad`;

CREATE TABLE `unidad` (
  `idunidad` int(11) NOT NULL DEFAULT '0',
  `des` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idunidad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `unidad` */

LOCK TABLES `unidad` WRITE;

UNLOCK TABLES;

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

LOCK TABLES `usuario` WRITE;

insert  into `usuario`(`idusuario`,`nombre`,`apellidopaterno`,`apellidomaterno`,`idtipousuario`,`estado`,`login`,`password`,`telefono`,`correo`,`FlagSuperUsuario`) values (1,'nazart','huaman','jara',NULL,1,'nazarjb@hotmail.com','123123','22312223','nazarjb@hotmail.com',1),(5,'nazart','huaman','jara',NULL,1,'nazart.villano@ec.pe','123456','54645656','nazart.villano@ec.pe',0);

UNLOCK TABLES;

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
