/*
SQLyog Enterprise - MySQL GUI v8.02 RC
MySQL - 5.0.92-community-log : Database - delivery_danden
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`delivery_danden` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `delivery_danden`;

/*Table structure for table `acc` */

DROP TABLE IF EXISTS `acc`;

CREATE TABLE `acc` (
  `idacc` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idacc`)
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
  PRIMARY KEY  (`idart`,`idpro`),
  KEY `fk_art_prov_art1` (`idart`),
  KEY `fk_art_prov_pro1` (`idpro`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='articulos x proveedor';

/*Data for the table `art_prov` */

/*Table structure for table `articulo` */

DROP TABLE IF EXISTS `articulo`;

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL auto_increment,
  `idcategoria` int(11) NOT NULL,
  `idcombo` int(11) default NULL,
  `idunidad` int(11) NOT NULL,
  `codigo` char(15) NOT NULL,
  `nombre` char(100) NOT NULL,
  `descripcion` varchar(150) default NULL,
  `precioventa` decimal(10,2) default NULL,
  `preciocompra` decimal(10,2) default NULL,
  `cantidad` smallint(6) NOT NULL,
  `stock_min` smallint(6) default NULL,
  `peso` decimal(10,2) default NULL,
  `ubicacion` char(4) default NULL,
  `fla` int(11) default NULL,
  `imagen` char(200) default NULL,
  `slug` char(200) default NULL,
  `slugbusqueda` text,
  `idsubcategoria` int(11) default NULL,
  `flagportada` int(1) default '0',
  `flagoferta` int(11) default NULL,
  `preciooferta` int(11) default NULL,
  PRIMARY KEY  (`idarticulo`),
  KEY `fk_art_sub_fam` (`idcategoria`),
  KEY `fk_art_combo1` (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

insert  into `articulo`(`idarticulo`,`idcategoria`,`idcombo`,`idunidad`,`codigo`,`nombre`,`descripcion`,`precioventa`,`preciocompra`,`cantidad`,`stock_min`,`peso`,`ubicacion`,`fla`,`imagen`,`slug`,`slugbusqueda`,`idsubcategoria`,`flagportada`,`flagoferta`,`preciooferta`) values (1,32,NULL,0,'','coca cola descartable medio litro','nuevo','123.00','1233.00',115,NULL,NULL,NULL,1,'coca-cola-descartable-medio-litro-1.jpg','coca-cola-descartable-medio-litro-1','bebida soda gaseosa helada',42,1,1,12),(2,32,NULL,0,'','pepsi medio litro','pepsi medio litro','123.00','123.00',-8,NULL,NULL,NULL,1,'pepsi-medio-litro-2.jpg','pepsi-medio-litro-2','pepsi medio litro soda helada gaseosa',42,0,0,0),(3,33,NULL,0,'','Cristal 355 mL 12pack','Cristal 355 mL 12pack','3.45','1.34',-5,NULL,NULL,NULL,1,'cristal-355-ml-12pack-3.jpg','cristal-355-ml-12pack-3','cristal 355 ml 12pack cerveza chela',34,1,1,23),(4,33,NULL,0,'','Cusqueña 355 mL12pack','Cusqueña 355 mL12pack','2.45','1.34',-17,NULL,NULL,NULL,1,'cusquena-355-ml12pack-4.jpg','cusquena-355-ml12pack-4','cusquena 355 ml12pack',34,1,NULL,NULL),(5,33,NULL,0,'','Barena 330 mL 6pack','Barena 330 mL 6pack','2.45','0.00',0,NULL,NULL,NULL,1,'barena-330-ml-6pack-5.jpg','barena-330-ml-6pack-5','barena 330 ml 6pack chela six pack sixpack',34,1,NULL,NULL),(6,33,NULL,0,'','Pilsen Callao 355 mL 12pack','Pilsen Callao 355 mL 12pack','23.00','21.00',0,NULL,NULL,NULL,1,'pilsen-callao-355-ml-12pack-6.jpg','pilsen-callao-355-ml-12pack-6','pilsen callao 355 ml 12pack cerveza chela licor',34,1,NULL,NULL),(7,33,NULL,0,'','Whisky Johnnie Walker Red Label','Whisky Johnnie Walker Red Label','150.00','100.00',0,NULL,NULL,NULL,1,'whisky-johnnie-walker-red-label-7.jpg','whisky-johnnie-walker-red-label-7','whisky johnnie walker red label',38,1,NULL,NULL);

/*Table structure for table `banner` */

DROP TABLE IF EXISTS `banner`;

CREATE TABLE `banner` (
  `idbanner` int(11) NOT NULL auto_increment,
  `nombre` varchar(150) collate utf8_unicode_ci default NULL,
  `descripcion` text collate utf8_unicode_ci,
  `imagen` varchar(600) collate utf8_unicode_ci default NULL,
  `url` varchar(600) collate utf8_unicode_ci default NULL,
  `precio` double default NULL,
  `orden` tinyint(4) default NULL,
  `estado` tinyint(4) default NULL,
  PRIMARY KEY  (`idbanner`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `banner` */

insert  into `banner`(`idbanner`,`nombre`,`descripcion`,`imagen`,`url`,`precio`,`orden`,`estado`) values (1,'foto 1',NULL,'pame.jpg',NULL,NULL,1,1),(4,'Banner4','esto es un banner','banner4-4.jpg','www.google.com',150,NULL,1);

/*Table structure for table `car` */

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `idcar` int(11) NOT NULL default '0',
  `pla` varchar(50) default NULL,
  `mar` varchar(50) NOT NULL,
  `mdl` varchar(50) NOT NULL,
  PRIMARY KEY  (`idcar`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `car` */

/*Table structure for table `categoria` */

DROP TABLE IF EXISTS `categoria`;

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL auto_increment,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(50) default NULL,
  `nombre` char(50) default NULL,
  `estado` int(1) default '1',
  `idpadre` int(11) default NULL,
  PRIMARY KEY  (`idcategoria`),
  FULLTEXT KEY `cod` (`codigo`),
  FULLTEXT KEY `des` (`descripcion`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

/*Data for the table `categoria` */

insert  into `categoria`(`idcategoria`,`codigo`,`descripcion`,`nombre`,`estado`,`idpadre`) values (38,'','Whisky','Whisky',1,33),(42,'','Gaseosas','Gaseosas',1,32),(41,'','Pisco','Pisco',1,33),(40,'','Ron','Ron',1,33),(39,'','Vodka','Vodka',1,33),(37,'','Hielo y Otros','Hielo y Otros',1,NULL),(43,'CG','CIgarrillos de diferentes marcas','Cigarros',1,NULL),(35,'','Snacks y Piqueos','Snacks y Piqueos',1,NULL),(34,'','Cerveza','Cerveza',1,33),(33,'','Licores','Licores',1,NULL),(32,'','bebidas','Bebidas',1,NULL),(44,'','energizantess','Energizantes',1,32);

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL auto_increment,
  `apellidomaterno` char(50) default NULL,
  `apellidopaterno` varchar(50) default NULL,
  `nombre` varchar(50) default NULL,
  `direccion` varchar(50) default NULL,
  `dni` char(18) default NULL,
  `web` varchar(50) default NULL,
  `correo` varchar(100) default NULL,
  `telefono1` varchar(15) default NULL,
  `telefono2` varchar(15) default NULL,
  `movil` varchar(15) default NULL,
  `flagactivo` int(11) default NULL,
  `ruc` char(14) default NULL,
  `estado` tinyint(4) default '1',
  `razonsocial` varchar(100) default NULL,
  PRIMARY KEY  (`idcliente`)
) ENGINE=MyISAM AUTO_INCREMENT=462 DEFAULT CHARSET=utf8;

/*Data for the table `cliente` */

insert  into `cliente`(`idcliente`,`apellidomaterno`,`apellidopaterno`,`nombre`,`direccion`,`dni`,`web`,`correo`,`telefono1`,`telefono2`,`movil`,`flagactivo`,`ruc`,`estado`,`razonsocial`) values (452,'huaman','jara','asdfasfa','sdfasdfasdf','44513557','','nazartjb@hotmail.com','12312333','','4234234234',0,'',1,NULL),(454,'dgsdgsd','sdfgsdgsd','jorge','sdgsdfg','445855587','','','sdgsdgsdfg','','',0,'',1,NULL),(455,'asdasdasd','asdadasd','asdasdasd','asdasdasd','44513555','','nazartajb@hotmail.com','123123123','','',0,'',1,NULL),(456,'asdasdfasfadf','sdfasdfaf','sdsdfsdf','dfasfdf','asdfdfsd','asdfsdfsd','nazaratjsb@hotmail.com','sdfsdf','','',0,'',1,NULL),(457,'jara','huaman','nazart','av. cajaranda','44513558','www.elcomercio.pe','nazart.villano@ec.pe','2355165','','',0,'',1,NULL),(458,'javier','carlo','nuevo','av. caasda asdasd','44513552','','','445121555','','',0,'',1,NULL),(459,'adaasdad','asdasdada','asdasdad','2332323','22334333','','naza@hotmailss.com','asadasd','','',0,'',1,NULL),(460,'asdasd','jara','nazart jhonn bryam','2342342423','44513555',NULL,'nazarjb@hotmail.com','234234',NULL,NULL,NULL,NULL,1,NULL),(461,'jara','huaman','nazart jhonn bryam','adasdasdasd asdasdasd asdasdasd asdasdasd','44513555',NULL,'nazartj@gmail.com','213123',NULL,NULL,NULL,NULL,1,NULL);

/*Table structure for table `cobro` */

DROP TABLE IF EXISTS `cobro`;

CREATE TABLE `cobro` (
  `idcobro` int(11) NOT NULL auto_increment,
  `idmdo` int(11) NOT NULL,
  `idemp` int(11) NOT NULL,
  `fec` date NOT NULL,
  `act` int(11) NOT NULL,
  PRIMARY KEY  (`idcobro`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `cobro` */

/*Table structure for table `combo` */

DROP TABLE IF EXISTS `combo`;

CREATE TABLE `combo` (
  `idcombo` int(11) NOT NULL auto_increment,
  `nom` varchar(250) NOT NULL,
  `fla` char(1) NOT NULL,
  PRIMARY KEY  (`idcombo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `combo` */

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `idconfig` int(11) NOT NULL auto_increment,
  `igv` float default NULL,
  `precioenvio` float default NULL,
  `tipocambio` float default NULL,
  `nombreoferta` varchar(200) default NULL,
  PRIMARY KEY  (`idconfig`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `config` */

insert  into `config`(`idconfig`,`igv`,`precioenvio`,`tipocambio`,`nombreoferta`) values (1,18,6,2.27,'Oferta de Verano');

/*Table structure for table `core_session` */

DROP TABLE IF EXISTS `core_session`;

CREATE TABLE `core_session` (
  `Id` varchar(32) NOT NULL,
  `save_path` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL default '',
  `Modified` int(11) default NULL,
  `LifeTime` int(11) default NULL,
  `Data` text,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `core_session` */

insert  into `core_session`(`Id`,`save_path`,`name`,`Modified`,`LifeTime`,`Data`) values ('0b19fb8d954f347e9673683cda748881','','',1328470566,1440,''),('0e55d8609557b02e2038a2267ccbb6fd','','',1328480796,1440,''),('126079caa291ced853a57267e261bc03','','',1328497621,1440,''),('25f97692b010571c87a14ce5a4020b24','','',1328497462,1440,''),('2892c0ce1807c70cdfa5c702ce9342a8','','',1328483289,1440,''),('319aba85b2b635e6413350782f7a279b','','',1328489772,1440,''),('397e19447dc8eb6c3141c2f94122201f','','',1328471101,1440,''),('3ac3c164fa166434100f93f9186c3c5e','','',1328491979,1440,''),('4a0da62fe65211dc8270d70bf11242d8','','',1328480174,1440,''),('4d327742ed2e6f416396bf8999a328ca','','',1328449245,1440,''),('59c4b82c229f3fb3a1cea25d93505515','','',1328484087,1440,''),('6036c0b5a6a5f28812cbef78c203d073','','',1328431683,1440,''),('61fu4ti9i6l4q77u30em55rso2','','',1328497606,1440,''),('63697e56274f222b3eeceac17dc3198e','','',1328479440,1440,''),('674d8aae02444c944536d5e1762aec71','','',1328472017,1440,''),('697544016104d41c855a8fa2ec4f0020','','',1328484091,1440,''),('6c2be47ad806891c0e22afce448f9e22','','',1328489656,1440,''),('6e96c3771d9d488019659c81225c4f9d','','',1328471330,1440,''),('8a7470860bcac91bbcd6d230ade2b9a2','','',1328484074,1440,''),('8ccb7653d8ea5fe5ba3d9fabe97f9867','','',1328481016,1440,''),('8dea65fbc67f9f3ff43f9a02db5fa212','','',1328490455,1440,''),('8dfb632a9a926741d93492674d297b50','','',1328489693,1440,''),('90323edff37aa4277b352b0511c5a335','','',1328492435,1440,''),('97776fd95d31f21d77defe607a4a73fa','','',1328480799,1440,''),('9bb79f7330f1bc1aaaa4891422ff92b3','','',1328484086,1440,''),('9bb931a6bb53524f88e34b7359ed88f5','','',1328443510,1440,''),('9c65b53e0321a9e9c99861c3eaf4ba54','','',1328484079,1440,''),('a22da2cd8af1ce7559ff3ff504774fe8','','',1328479443,1440,''),('b478e0733f8977e0e8739c2afe7b6309','','',1328430790,1440,''),('b84a3f6b695fbcd318527bfa1d2d0792','','',1328494340,1440,''),('bc36517053ace3d8137cb905110a1189','','',1328435130,1440,''),('beb027ac0e230820b092dac479af31b3','','',1328479442,1440,''),('c1de88736f6e14adf72e40576270989c','','',1328489738,1440,''),('c7dbfd9bcf7468a997ef0ab78c8b69c2','','',1328443508,1440,''),('c7ef1bae196fd1b1a416bd89d5fac535','','',1328484088,1440,''),('cbb677144260e6e64e44e738b2ecf622','','',1328443506,1440,''),('d4147746b93f9f35ca1bfed395d12b30','','',1328443506,1440,''),('dfa5436d7a7f26256504c461984b3e95','','',1328431011,1440,''),('dff03c79363616c4e2b012d5464c06c3','','',1328435131,1440,''),('e914e47d8334331e01b83958bb5c09e8','','',1328479441,1440,''),('e9a4eac8350333b61a861cdfc9c0e3a4','','',1328469803,1440,''),('tjsobbriqmbt3td3q1llmm1qo0','','',1328476482,1440,'dojo|a:2:{s:13:\"listaArticulo\";a:1:{i:4;a:22:{s:10:\"idarticulo\";s:1:\"4\";s:11:\"idcategoria\";s:2:\"33\";s:7:\"idcombo\";N;s:8:\"idunidad\";s:1:\"0\";s:6:\"codigo\";s:0:\"\";s:6:\"nombre\";s:22:\"Cusqueña 355 mL12pack\";s:11:\"descripcion\";s:22:\"Cusqueña 355 mL12pack\";s:11:\"precioventa\";s:4:\"2.45\";s:12:\"preciocompra\";s:4:\"1.34\";s:8:\"cantidad\";s:3:\"-17\";s:9:\"stock_min\";N;s:4:\"peso\";N;s:9:\"ubicacion\";N;s:3:\"fla\";s:1:\"1\";s:6:\"imagen\";s:27:\"cusquena-355-ml12pack-4.jpg\";s:4:\"slug\";s:23:\"cusquena-355-ml12pack-4\";s:12:\"slugbusqueda\";s:21:\"cusquena 355 ml12pack\";s:14:\"idsubcategoria\";s:2:\"34\";s:11:\"flagportada\";s:1:\"1\";s:10:\"flagoferta\";N;s:12:\"preciooferta\";N;s:16:\"cantidadArticulo\";s:1:\"1\";}}s:15:\"articuloEnLista\";a:0:{}}Zend_Auth|a:1:{s:7:\"storage\";O:8:\"stdClass\":10:{s:9:\"idusuario\";s:1:\"1\";s:6:\"nombre\";s:6:\"nazart\";s:15:\"apellidopaterno\";s:6:\"huaman\";s:15:\"apellidomaterno\";s:4:\"jara\";s:13:\"idtipousuario\";N;s:6:\"estado\";s:1:\"1\";s:5:\"login\";s:19:\"nazarjb@hotmail.com\";s:8:\"telefono\";s:8:\"22312223\";s:6:\"correo\";s:19:\"nazarjb@hotmail.com\";s:16:\"FlagSuperUsuario\";s:1:\"1\";}}');

/*Table structure for table `crg` */

DROP TABLE IF EXISTS `crg`;

CREATE TABLE `crg` (
  `idcrg` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idcrg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `crg` */

/*Table structure for table `detalledocumentopago` */

DROP TABLE IF EXISTS `detalledocumentopago`;

CREATE TABLE `detalledocumentopago` (
  `iddetalledocumento` int(11) NOT NULL auto_increment,
  `iddocumento` int(11) NOT NULL,
  `cantidad` smallint(6) default '0',
  `importe` smallint(6) default NULL,
  `peso` decimal(10,2) default NULL,
  `precio` decimal(10,2) default NULL,
  `idarticulo` int(11) default NULL,
  PRIMARY KEY  (`iddetalledocumento`),
  KEY `fk_det_doc_doc1` (`iddocumento`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*Data for the table `detalledocumentopago` */

insert  into `detalledocumentopago`(`iddetalledocumento`,`iddocumento`,`cantidad`,`importe`,`peso`,`precio`,`idarticulo`) values (23,19,1,123,NULL,'123.00',1),(22,19,1,123,NULL,'123.00',2),(24,20,1,123,NULL,'123.00',2),(25,20,1,123,NULL,'123.00',1),(26,21,1,123,NULL,'123.00',2),(27,21,1,123,NULL,'123.00',1),(28,22,1,2,NULL,'2.45',4),(29,22,1,150,NULL,'150.00',7),(30,23,1,123,NULL,'123.00',2),(31,24,1,2,NULL,'2.45',5),(32,24,1,3,NULL,'3.45',3),(33,25,1,3,NULL,'3.45',3),(34,26,2,5,NULL,'2.45',4),(35,27,2,5,NULL,'2.45',4),(36,28,3,7,NULL,'2.45',4),(37,28,1,3,NULL,'3.45',3),(38,29,3,7,NULL,'2.45',4),(39,29,1,3,NULL,'3.45',3),(40,30,3,7,NULL,'2.45',4),(41,30,1,3,NULL,'3.45',3),(42,31,3,7,NULL,'2.45',4),(43,31,1,3,NULL,'3.45',3),(44,32,3,7,NULL,'2.45',4),(45,32,1,3,NULL,'3.45',3),(46,33,1,3,NULL,'3.45',3),(47,34,1,3,NULL,'3.45',3),(48,35,1,3,NULL,'3.45',3),(49,36,1,3,NULL,'3.45',3),(50,37,1,3,NULL,'3.45',3),(51,38,1,3,NULL,'3.45',3),(52,39,1,3,NULL,'3.45',3),(53,40,1,3,NULL,'3.45',3),(54,41,1,3,NULL,'3.45',3),(55,42,1,3,NULL,'3.45',3),(56,43,1,3,NULL,'3.45',3),(57,44,1,3,NULL,'3.45',3),(58,45,1,2,NULL,'2.45',4),(59,46,1,2,NULL,'2.45',4),(60,47,1,2,NULL,'2.45',4),(61,48,1,2,NULL,'2.45',4),(62,49,1,2,NULL,'2.45',4),(63,50,1,2,NULL,'2.45',4),(64,51,1,2,NULL,'2.45',4),(65,52,1,2,NULL,'2.45',4),(66,53,1,2,NULL,'2.45',4);

/*Table structure for table `detalleslug` */

DROP TABLE IF EXISTS `detalleslug`;

CREATE TABLE `detalleslug` (
  `iddetalleslug` int(11) NOT NULL auto_increment,
  `idarticulo` int(11) default NULL,
  `idslug` int(11) default NULL,
  PRIMARY KEY  (`iddetalleslug`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `detalleslug` */

insert  into `detalleslug`(`iddetalleslug`,`idarticulo`,`idslug`) values (8,6282,5),(9,6282,1),(10,6282,2),(11,6282,8),(12,6282,9),(13,6283,10),(14,6283,1),(15,6283,2),(16,6283,8),(17,6283,9),(18,6283,11),(291,5,25),(292,5,26),(293,5,27),(294,5,28),(295,5,22),(296,5,23),(297,5,24),(298,5,29),(304,4,30),(305,4,31),(306,4,32),(313,0,34),(314,0,35),(315,0,31),(316,0,27),(317,0,33),(318,0,19),(319,0,36),(320,6,34),(321,6,35),(322,6,31),(323,6,27),(324,6,33),(325,6,19),(326,6,22),(327,6,37),(338,7,38),(339,7,39),(340,7,40),(341,7,41),(342,7,42),(352,2,11),(353,2,8),(354,2,9),(355,2,15),(356,2,18),(357,2,7),(367,1,1),(368,1,2),(369,1,16),(370,1,8),(371,1,9),(372,1,10),(373,1,15),(374,1,7),(375,1,18),(376,3,20),(377,3,31),(378,3,27),(379,3,33),(380,3,19),(381,3,22);

/*Table structure for table `documentopago` */

DROP TABLE IF EXISTS `documentopago`;

CREATE TABLE `documentopago` (
  `iddocumento` int(11) NOT NULL auto_increment,
  `numeroserie` varchar(10) default NULL,
  `numerocomprobante` int(11) default NULL,
  `fechacreacion` date default NULL,
  `fecvencimiento` date default NULL,
  `total` decimal(10,2) default NULL,
  `idtipodocumento` int(11) default NULL,
  `idempresa` tinyint(4) default NULL,
  `idcliente` int(11) default NULL,
  `idestado` int(11) default NULL COMMENT '0 pedido, 1 entregado, 2 eliminado',
  `flagactivo` int(11) default NULL,
  `moneda` char(10) default NULL,
  `tipocambio` decimal(10,2) default NULL,
  `idvendedor` varchar(150) default NULL,
  `IGV` char(3) default 'SIN',
  `comentario` varchar(250) default NULL,
  `idpedido` int(11) default NULL COMMENT 'en caso de que el comprobante viene de un pedido',
  `direccion` text,
  `flagdespacho` int(11) default '0',
  `hora` time default NULL,
  PRIMARY KEY  (`iddocumento`),
  KEY `fk_doc_tip_doc1` (`idtipodocumento`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

/*Data for the table `documentopago` */

insert  into `documentopago`(`iddocumento`,`numeroserie`,`numerocomprobante`,`fechacreacion`,`fecvencimiento`,`total`,`idtipodocumento`,`idempresa`,`idcliente`,`idestado`,`flagactivo`,`moneda`,`tipocambio`,`idvendedor`,`IGV`,`comentario`,`idpedido`,`direccion`,`flagdespacho`,`hora`) values (20,'02',1212,'0000-00-00',NULL,NULL,2,0,452,1,1,'','0.00','1','18',NULL,NULL,NULL,1,NULL),(19,'02',123123123,'0000-00-00',NULL,NULL,2,0,454,1,1,'','0.00','1','18',NULL,NULL,NULL,1,NULL),(22,'02',1,'0000-00-00',NULL,'152.45',2,0,457,1,1,'','0.00','1','18','qweqweqwe',NULL,'sdasdasd',NULL,NULL),(23,'01',2312312,'0000-00-00',NULL,'123.00',1,0,454,1,1,'','0.00','1','18','dq',NULL,'Los Olivos',NULL,NULL),(24,'02',2324234,'0000-00-00',NULL,'5.90',2,0,457,1,1,'','0.00','1','18','err',NULL,'',0,NULL),(25,'01',123,'0000-00-00',NULL,'3.45',1,0,458,1,1,'','0.00','1','18','wewewefwf',NULL,'',0,NULL),(29,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',1,NULL),(27,NULL,NULL,'2012-07-21',NULL,'4.90',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdasdadasd',1,'00:00:01'),(28,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',1,NULL),(30,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,NULL),(32,'1',2334323,'0000-00-00',NULL,'10.80',2,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadasdasd',1,'13:30:00'),(33,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(34,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(35,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(36,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(37,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(38,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(39,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(40,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(41,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(42,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(43,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(44,NULL,NULL,'2012-02-22',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(45,NULL,NULL,'2012-02-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(46,NULL,NULL,'2012-03-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(47,NULL,NULL,'2012-04-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(48,NULL,NULL,'2012-05-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(49,NULL,NULL,'2012-06-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(50,NULL,NULL,'2012-06-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(51,NULL,NULL,'2012-07-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(52,NULL,NULL,'2012-08-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(53,NULL,NULL,'0000-00-00',NULL,'8.45',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00');

/*Table structure for table `empresa` */

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `idempresa` int(11) NOT NULL auto_increment,
  `codigo` varchar(50) default NULL,
  `apellido` varchar(50) default NULL,
  `nombre` varchar(50) default NULL,
  `direccion` varchar(50) default NULL,
  `dni` varchar(50) default NULL,
  `ruc` varchar(10) default NULL,
  `tlf_fij` varchar(50) default NULL,
  `tlf_mov` varchar(50) default NULL,
  `fec_ing` date default NULL,
  `act` int(11) default NULL,
  PRIMARY KEY  (`idempresa`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

/*Data for the table `empresa` */

/*Table structure for table `est_per` */

DROP TABLE IF EXISTS `est_per`;

CREATE TABLE `est_per` (
  `idest_per` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idest_per`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `est_per` */

/*Table structure for table `estado` */

DROP TABLE IF EXISTS `estado`;

CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL auto_increment,
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idestado`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `estado` */

insert  into `estado`(`idestado`,`des`) values (1,'pendiente'),(2,'pagado');

/*Table structure for table `kardex` */

DROP TABLE IF EXISTS `kardex`;

CREATE TABLE `kardex` (
  `idkardex` int(11) NOT NULL auto_increment,
  `iddoc` int(11) default NULL,
  `cantidadtotal` int(11) default NULL,
  `stock` int(11) default NULL,
  `fecha` date default NULL,
  `idarticulo` int(11) NOT NULL,
  `fla` int(11) default NULL COMMENT '1 ingreso / 2 egreso',
  `motivo` text NOT NULL,
  PRIMARY KEY  (`idkardex`),
  KEY `fk_kar_doc1` (`iddoc`),
  KEY `fk_kar_art1` (`idarticulo`)
) ENGINE=MyISAM AUTO_INCREMENT=4462 DEFAULT CHARSET=utf8;

/*Data for the table `kardex` */

insert  into `kardex`(`idkardex`,`iddoc`,`cantidadtotal`,`stock`,`fecha`,`idarticulo`,`fla`,`motivo`) values (4434,0,NULL,123,NULL,1,1,'asdfafd'),(4435,NULL,NULL,1,NULL,2,2,'Despacho '),(4436,NULL,NULL,1,NULL,1,2,'Despacho '),(4437,NULL,NULL,1,NULL,2,2,'Despacho '),(4438,NULL,NULL,1,NULL,1,2,'Despacho '),(4439,NULL,NULL,1,NULL,2,2,'Despacho '),(4440,NULL,NULL,1,NULL,1,2,'Despacho '),(4441,NULL,NULL,1,NULL,1,2,'Despacho '),(4442,NULL,NULL,1,NULL,2,2,'Despacho '),(4443,NULL,NULL,1,NULL,2,2,'Despacho '),(4444,NULL,NULL,1,NULL,1,2,'Despacho '),(4445,NULL,NULL,1,NULL,2,2,'Despacho '),(4446,NULL,NULL,1,NULL,1,2,'Despacho '),(4447,NULL,NULL,1,NULL,1,2,'Despacho '),(4448,NULL,NULL,1,NULL,2,2,'Despacho '),(4449,NULL,NULL,1,NULL,2,2,'Despacho '),(4450,NULL,NULL,1,NULL,1,2,'Despacho '),(4451,NULL,NULL,2,NULL,4,2,'Despacho '),(4452,NULL,NULL,3,NULL,4,2,'Despacho '),(4453,NULL,NULL,1,NULL,3,2,'Despacho '),(4454,NULL,NULL,3,NULL,4,2,'Despacho '),(4455,NULL,NULL,1,NULL,3,2,'Despacho '),(4456,NULL,NULL,3,NULL,4,2,'Despacho '),(4457,NULL,NULL,1,NULL,3,2,'Despacho '),(4458,NULL,NULL,3,NULL,4,2,'Despacho '),(4459,NULL,NULL,1,NULL,3,2,'Despacho '),(4460,NULL,NULL,3,NULL,4,2,'Despacho '),(4461,NULL,NULL,1,NULL,3,2,'Despacho ');

/*Table structure for table `mantenimientopagina` */

DROP TABLE IF EXISTS `mantenimientopagina`;

CREATE TABLE `mantenimientopagina` (
  `idpagina` int(11) NOT NULL auto_increment,
  `nombrepagina` varchar(200) collate utf8_unicode_ci default NULL,
  `descripcion` text collate utf8_unicode_ci,
  PRIMARY KEY  (`idpagina`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mantenimientopagina` */

insert  into `mantenimientopagina`(`idpagina`,`nombrepagina`,`descripcion`) values (1,'Zonas de Reparto',NULL),(2,'Politicas',NULL);

/*Table structure for table `mdo` */

DROP TABLE IF EXISTS `mdo`;

CREATE TABLE `mdo` (
  `idmdo` int(11) NOT NULL default '0',
  `des` varchar(20) default NULL,
  PRIMARY KEY  (`idmdo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `mdo` */

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL auto_increment,
  `nombre` char(50) collate utf8_unicode_ci default NULL,
  `url` char(200) collate utf8_unicode_ci default NULL,
  `orden` int(11) default NULL,
  PRIMARY KEY  (`idmenu`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `menu` */

insert  into `menu`(`idmenu`,`nombre`,`url`,`orden`) values (1,'Categoriás','/admin/categoria',2),(2,'Clientes','/admin/cliente',3),(3,'Artículo','/admin/articulo',4),(4,'Pedidos','/admin/pedidos',5),(5,'Comprobantes','/admin/comprobante',6),(6,'Usuario','/admin/usuario',7),(7,'Reportes','/admin/reportes',8),(8,'Admin','/admin/index',1),(9,'SubCategorias','/admin/subcategoria',NULL),(10,'Banner','/admin/admin-web',NULL),(11,'Configuracion','/admin/config',9);

/*Table structure for table `niv_acc` */

DROP TABLE IF EXISTS `niv_acc`;

CREATE TABLE `niv_acc` (
  `idniv_acc` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idniv_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `niv_acc` */

/*Table structure for table `numeroserie` */

DROP TABLE IF EXISTS `numeroserie`;

CREATE TABLE `numeroserie` (
  `idnumeroserie` int(11) NOT NULL auto_increment,
  `idtip_doc` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `serie` char(2) NOT NULL,
  `desde` int(11) default NULL,
  `hasta` int(11) default NULL,
  `num` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  PRIMARY KEY  (`idnumeroserie`),
  KEY `fk_nse_sucur1` (`idsucursal`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `numeroserie` */

insert  into `numeroserie`(`idnumeroserie`,`idtip_doc`,`idsucursal`,`serie`,`desde`,`hasta`,`num`,`flag`) values (1,1,0,'01',1,50,1,0),(2,2,0,'02',1,50,2,0);

/*Table structure for table `perfil` */

DROP TABLE IF EXISTS `perfil`;

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL auto_increment,
  `idusuario` int(11) default NULL,
  `idmenu` int(11) default NULL,
  PRIMARY KEY  (`idperfil`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `perfil` */

insert  into `perfil`(`idperfil`,`idusuario`,`idmenu`) values (12,5,8),(11,5,2),(10,5,1);

/*Table structure for table `pre_cli` */

DROP TABLE IF EXISTS `pre_cli`;

CREATE TABLE `pre_cli` (
  `idcli` int(11) NOT NULL,
  `idart` int(11) NOT NULL,
  `pre` decimal(10,2) default NULL,
  PRIMARY KEY  (`idcli`,`idart`),
  KEY `fk_pre_cli_cli1` (`idcli`),
  KEY `fk_pre_cli_art1` (`idart`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `pre_cli` */

/*Table structure for table `pro` */

DROP TABLE IF EXISTS `pro`;

CREATE TABLE `pro` (
  `idpro` int(11) NOT NULL auto_increment,
  `raz` varchar(50) default NULL,
  `ruc` varchar(50) default NULL,
  `web` varchar(50) default NULL,
  `ema` varchar(100) NOT NULL,
  `tlf` varchar(50) default NULL,
  `dir` text,
  PRIMARY KEY  (`idpro`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `pro` */

/*Table structure for table `rec` */

DROP TABLE IF EXISTS `rec`;

CREATE TABLE `rec` (
  `idrec` int(11) NOT NULL auto_increment,
  `num` int(11) default NULL,
  `fec` date default NULL,
  `pag` decimal(10,3) default NULL,
  `iddoc` int(11) default NULL,
  `idemp` int(11) default NULL,
  `fla` int(11) NOT NULL,
  PRIMARY KEY  (`idrec`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

/*Data for the table `rec` */

/*Table structure for table `relacionararticulo` */

DROP TABLE IF EXISTS `relacionararticulo`;

CREATE TABLE `relacionararticulo` (
  `idrelacionarticulo` int(11) NOT NULL auto_increment,
  `idarticulo` int(11) default NULL,
  `idarticulorelacionado` int(11) default NULL,
  PRIMARY KEY  (`idrelacionarticulo`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `relacionararticulo` */

insert  into `relacionararticulo`(`idrelacionarticulo`,`idarticulo`,`idarticulorelacionado`) values (7,3,4),(8,3,5),(9,3,6),(10,3,7),(11,7,3),(12,7,4),(13,7,5),(14,7,6);

/*Table structure for table `slug` */

DROP TABLE IF EXISTS `slug`;

CREATE TABLE `slug` (
  `idslug` int(11) NOT NULL auto_increment,
  `nombreslug` char(50) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`idslug`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `slug` */

insert  into `slug`(`idslug`,`nombreslug`) values (1,'coca'),(2,'cola'),(3,'wisky'),(4,'ron'),(5,'bebidas'),(6,'pisco'),(7,'gaseosa'),(8,'medio'),(9,'litro'),(10,'bebida'),(11,'pepsi'),(12,'1'),(13,'2'),(14,'cocagaseosabebidasoda'),(15,'soda'),(16,'descartable'),(17,'bebidasodagaseosahelada'),(18,'helada'),(19,'cerveza'),(20,'cristal'),(21,'litros'),(22,'chela'),(23,'six'),(24,'pack'),(25,'barena'),(26,'330'),(27,'ml'),(28,'6pack'),(29,'sixpack'),(30,'cusquena'),(31,'355'),(32,'ml12pack'),(33,'12pack'),(34,'pilsen'),(35,'callao'),(36,'licores'),(37,'licor'),(38,'whisky'),(39,'johnnie'),(40,'walker'),(41,'red'),(42,'label');

/*Table structure for table `sto` */

DROP TABLE IF EXISTS `sto`;

CREATE TABLE `sto` (
  `idsto` int(11) NOT NULL default '0',
  `num` int(11) default NULL,
  PRIMARY KEY  (`idsto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sto` */

/*Table structure for table `sub_fam` */

DROP TABLE IF EXISTS `sub_fam`;

CREATE TABLE `sub_fam` (
  `idsubcategoria` int(11) NOT NULL auto_increment,
  `idcategoria` int(11) NOT NULL default '0',
  `cod` varchar(50) NOT NULL,
  `des` varchar(50) default NULL,
  `dcto` int(11) NOT NULL,
  PRIMARY KEY  (`idsubcategoria`,`idcategoria`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `sub_fam` */

/*Table structure for table `sucur` */

DROP TABLE IF EXISTS `sucur`;

CREATE TABLE `sucur` (
  `idsucur` int(11) NOT NULL auto_increment,
  `des` varchar(250) NOT NULL,
  PRIMARY KEY  (`idsucur`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sucur` */

/*Table structure for table `tip_cam` */

DROP TABLE IF EXISTS `tip_cam`;

CREATE TABLE `tip_cam` (
  `idtip_cam` int(11) NOT NULL auto_increment,
  `mon` decimal(10,2) NOT NULL,
  `fec` date NOT NULL,
  PRIMARY KEY  (`idtip_cam`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `tip_cam` */

/*Table structure for table `tip_cli` */

DROP TABLE IF EXISTS `tip_cli`;

CREATE TABLE `tip_cli` (
  `idtip_cli` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idtip_cli`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_cli` */

/*Table structure for table `tip_doc` */

DROP TABLE IF EXISTS `tip_doc`;

CREATE TABLE `tip_doc` (
  `idtip_doc` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idtip_doc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tip_doc` */

insert  into `tip_doc`(`idtip_doc`,`des`) values (1,'Boleta'),(2,'Factura'),(3,'Gia Remision'),(4,'Pedido');

/*Table structure for table `unidad` */

DROP TABLE IF EXISTS `unidad`;

CREATE TABLE `unidad` (
  `idunidad` int(11) NOT NULL default '0',
  `des` varchar(50) default NULL,
  PRIMARY KEY  (`idunidad`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `unidad` */

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL auto_increment,
  `nombre` char(50) collate utf8_unicode_ci default NULL,
  `apellidopaterno` char(50) collate utf8_unicode_ci default NULL,
  `apellidomaterno` char(50) collate utf8_unicode_ci default NULL,
  `idtipousuario` int(11) default NULL,
  `estado` int(11) default '1',
  `login` char(20) collate utf8_unicode_ci default NULL,
  `password` char(20) collate utf8_unicode_ci default NULL,
  `telefono` char(15) collate utf8_unicode_ci default NULL,
  `correo` char(100) collate utf8_unicode_ci default NULL,
  `FlagSuperUsuario` int(1) default '0',
  PRIMARY KEY  (`idusuario`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `usuario` */

insert  into `usuario`(`idusuario`,`nombre`,`apellidopaterno`,`apellidomaterno`,`idtipousuario`,`estado`,`login`,`password`,`telefono`,`correo`,`FlagSuperUsuario`) values (1,'nazart','huaman','jara',NULL,1,'nazarjb@hotmail.com','123123','22312223','nazarjb@hotmail.com',1),(5,'nazart','huaman','jara',NULL,1,'nazart.villano@ec.pe','123456','54645656','nazart.villano@ec.pe',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
