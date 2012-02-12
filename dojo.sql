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

insert  into `articulo`(`idarticulo`,`idcategoria`,`idcombo`,`idunidad`,`codigo`,`nombre`,`descripcion`,`precioventa`,`preciocompra`,`cantidad`,`stock_min`,`peso`,`ubicacion`,`fla`,`imagen`,`slug`,`slugbusqueda`,`idsubcategoria`,`flagportada`,`flagoferta`,`preciooferta`) values (1,32,NULL,0,'','coca cola descartable medio litro','nuevo','123.00','1233.00',115,NULL,NULL,NULL,1,'coca-cola-descartable-medio-litro-1.jpg','coca-cola-descartable-medio-litro-1','bebida soda gaseosa helada',42,1,1,0),(2,32,NULL,0,'','pepsi medio litroo','pepsi medio litro','123.00','123.00',-8,NULL,NULL,NULL,1,'pepsi-medio-litroo-2.jpg','pepsi-medio-litroo-2','pepsi medio litro soda helada gaseosa',42,0,0,0),(3,33,NULL,0,'','Cristal 355 mL 12pack','Cristal 355 mL 12pack','3.45','1.34',-5,NULL,NULL,NULL,1,'cristal-355-ml-12pack-3.jpg','cristal-355-ml-12pack-3','cristal 355 ml 12pack cerveza chela',34,1,1,23),(4,33,NULL,0,'','Cusqueña 355 mL12pack','Cusqueña 355 mL12pack','2.45','1.34',-17,NULL,NULL,NULL,1,'cusquena-355-ml12pack-4.jpg','cusquena-355-ml12pack-4','cusquena 355 ml12pack',34,1,NULL,NULL),(5,33,NULL,0,'','Barena 330 mL 6pack','Barena 330 mL 6pack','2.45','0.00',0,NULL,NULL,NULL,1,'barena-330-ml-6pack-5.jpg','barena-330-ml-6pack-5','barena 330 ml 6pack chela six pack sixpack',34,1,NULL,NULL),(6,33,NULL,0,'','Pilsen Callao 355 mL 12pack','Pilsen Callao 355 mL 12pack','23.00','21.00',0,NULL,NULL,NULL,1,'pilsen-callao-355-ml-12pack-6.jpg','pilsen-callao-355-ml-12pack-6','pilsen callao 355 ml 12pack cerveza chela licor',34,1,NULL,NULL),(7,33,NULL,0,'','Whisky Johnnie Walker Red Label','Whisky Johnnie Walker Red Label','150.00','100.00',0,NULL,NULL,NULL,1,'whisky-johnnie-walker-red-label-7.jpg','whisky-johnnie-walker-red-label-7','whisky johnnie walker red label',38,1,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `banner` */

insert  into `banner`(`idbanner`,`nombre`,`descripcion`,`imagen`,`url`,`precio`,`orden`,`estado`) values (1,'foto 1',NULL,'pame.jpg',NULL,NULL,1,1),(4,'Banner4','esto es un banner','banner4-4.jpg','www.google.com',150,NULL,1),(5,'chelo','gae','chelo-5.jpg','asdasdas',25,2,1);

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
) ENGINE=MyISAM AUTO_INCREMENT=465 DEFAULT CHARSET=utf8;

/*Data for the table `cliente` */

insert  into `cliente`(`idcliente`,`apellidomaterno`,`apellidopaterno`,`nombre`,`direccion`,`dni`,`web`,`correo`,`telefono1`,`telefono2`,`movil`,`flagactivo`,`ruc`,`estado`,`razonsocial`) values (452,'huaman','jara','asdfasfa','sdfasdfasdf','44513557','','nazartjb@hotmail.com','12312333','','4234234234',0,'',1,NULL),(454,'dgsdgsd','sdfgsdgsd','jorge','sdgsdfg','445855587','','','sdgsdgsdfg','','',0,'',1,NULL),(455,'asdasdasd','asdadasd','asdasdasd','asdasdasd','44513555','','nazartajb@hotmail.com','123123123','','',0,'',1,NULL),(456,'asdasdfasfadf','sdfasdfaf','sdsdfsdf','dfasfdf','asdfdfsd','asdfsdfsd','nazaratjsb@hotmail.com','sdfsdf','','',0,'',1,NULL),(457,'jara','huaman','nazart','av. cajaranda','44513558','www.elcomercio.pe','nazart.villano@ec.pe','2355165','','',0,'',1,NULL),(458,'javier','carlo','nuevo','av. caasda asdasd','44513552','','','445121555','','',0,'',1,NULL),(459,'adaasdad','asdasdada','asdasdad','2332323','22334333','','naza@hotmailss.com','asadasd','','',0,'',1,NULL),(460,'jara','huaman','nazart jhonn bryam','sdadasd','44513555',NULL,'nazarjb@hotmail.com','213123',NULL,NULL,NULL,NULL,1,NULL),(462,'franz jultie','erssd','gilberto','av la mar san isidro','25465656',NULL,'leo_osx@hotmail.com','74845656',NULL,NULL,NULL,NULL,1,NULL),(461,'asdasdsa','asdadasd','adasda','adasdasdasd asdasdasd asdasdasd asdasdasd','44513555',NULL,'nazartj@gmail.com','213123',NULL,NULL,NULL,NULL,1,NULL),(463,'carranza','torres','marcelo','los olivos','53543546',NULL,'marrselo@gmail.com','6546546',NULL,NULL,NULL,NULL,1,NULL),(464,'barrientos','sanchez','carlos','jesus maria','43468034',NULL,'carlosbars@hotmail.com','43468034',NULL,NULL,NULL,NULL,1,NULL);

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

insert  into `core_session`(`Id`,`save_path`,`name`,`Modified`,`LifeTime`,`Data`) values ('015553f6c2f550a0fa620f2d877f840c','','',1328999619,1440,''),('01d6a771724c838319b3be3f7e033ba3','','',1328944464,1440,''),('02154f632f6f912c79a1da34cfd0e241','','',1328999035,1440,''),('0a0e5567b7afc7498abedccbad5fbd0d','','',1328942887,1440,''),('16702a7349fda4e9ec0445108fe0baf1','','',1328980499,1440,''),('16afe17a3a12c79a602ba96ff55a25c8','','',1328999856,1440,'CuLrcbJb6ylm83tEdMJ-4GSjqWQXIWKR5LrI3vEWenI9QFFEjZTwKIs1CgfeC5cv_vkXRWX4CVUq-1ecUuE2Sg..'),('181027b12252e4b126546f3dd3cafb66','','',1329062989,1440,''),('1b9ed99e8e5984a5b419fce15f895535','','',1328946334,1440,''),('1d8e3991ef6b1b64e543ecf6b2bf5add','','',1328946319,1440,''),('1f0398a230034d2200d09a772daaae17','','',1328944046,1440,''),('21fd60bfa7f1a561982165d087c9bbf2','','',1328999619,1440,''),('241ab36058a7efdecf8c79bbd6b50466','','',1328944047,1440,''),('2504a14256db157955d202bc9a37e1b6','','',1328999746,1440,''),('2aee8ec2d7e5972a1bc2f01ebef1b058','','',1329001724,1440,''),('332bfb2322cf4aff6a10d9113b90d5df','','',1329036373,1440,''),('3d1aebbb3656573091c09143ef167ac9','','',1329000274,1440,''),('3e7c17af9c12d159c8b32b5e0f9fe08f','','',1328944047,1440,''),('42e697ebbea2f23c091fc958f9820aca','','',1328973978,1440,''),('471dcd4c505bc0f040bb448563e5dc47','','',1329051493,1440,'g7og6vh1iXjRyrb8ebQj5ScJKL4u_48GpCOiXn_Usj_M1ayv--HAuPKmE4luF450ME7B6g3M06OKbnZD5_iQeQ..'),('4dcd283c5ff1438c6f19ae3ac16e9bfb','','',1329000270,1440,''),('4fd90b864f4ce864a7f8af6962df0a67','','',1329000288,1440,''),('5ddd0ed550080db239cea62669e0e07a','','',1328996529,1440,''),('6073bae505333c762dab4da67926548f','','',1328944566,1440,'AhWFn1fren46i91dXS4S_CIeNuNpthOI9O3RMCq3cUjc3rbG6mXZYq6l9qr4iRRfA2y0QxsW3YbHA3PPMteBr2GeYbqDzeIAGnOaCdJSuVFyM81EgFoh8Wc9CDow1gAii9HUzBbWO-A3jHtedx9Kwn1FH4h_Uj0kVhStNrm8uaDENPZz5W76wLu4chRqd-JlUPuEKhx4Mse3LgRcgO858upuUCLTEVGqbSqv2lzI8bui7WgJ6lwHo9KlI0jssW2dqLpDD86ShldzeKoJiLF73H415sg3Oc_zYa3nbSUjjFjdk7oG-4S1_UmgsbDZCtNDDENJ3uDbKdDMkFBgMepvHHBkFwDY26PVIClRYoFlPoliwSWkU9C0Cbm6zwNhXNQxlz7Ih4Bn7D3kYzwYGMGaDd0goQvZwflO49zasKX384sXFw3TS4dUf7ufgO5anYLCykM6YF5j1zEjXJ1CMOBX4XC5HlEV6uabEqV95C8QIKABpjDoQ0EfByk6FMhJC63gH3JiCpM-ftwTQVZGyz7JOFyacjJm4yN3wN1VUsk6LiQpXrbyG_JplArKflQkIkFoO97QO6IzYwCg5Ht5rI6sjC7ip47YKrbuwe9nXoLZ2kytY32jScZzLKvEragJcW_wNZnBsNjKNGkRCGeeo5O6c-_zP1Ylg6KJO-s5xbZ0Upne5028Se8lSxLpP5mRaGv78F4KvYFu3iRrn-pWBdjHzD8NzPf-G7qrBpfYiNUoy5jEtZlkbGg654g6FK-jl-Da4ASvYXgU7fRtBwp4aOHH6FCCHeuWYnEZamQ1moqL8A7ibVbkHaVUCC3XAIW4B1kOD_3o7ajNJGvDKiWkqoL0DDlwdo2SX1EgiffyLabtryM7G5mgLoVLNor4tjun6kZhAkroEL9B3OvEO-N0y7EmSfXIeNV8CZB1g-GMC5lJh6u40r62MVs09w4sBhgLiG9IXUl6UnEIPrgVVY7rqxnJ2GSSFPpF5vYTCgUYd4ZY4Y2P6xOohayQm1sbKaizZ9pKK6_rWUTTKBDX_1n2zER00WCE998brVRMfTOlY-R6k0OE37ybkxUCn5xP_6GXgs3lb7Zq7eHXXoRq1S2PYbkmrb96RLMXNqSq8bf_tslkCIxT55i7hFKdO0a83BH3Ek1uZcF3Cqsu_7JSOIFd8yHhmAzqLf7msBpdmwxISjlYYp03K7-Og_u5JNlyYWybDCl7xiXVe4oIQ8V9EYDh6h7E3E_SbCozRMJIdY2m-WsZ6-huqe1JpoBjy1fGx_4JbP0rtdNKqU1dJH3JUgHtqls_gy0dUqiv_trkdhZchzC2wHZqk1OTIY9r-ISnKC2cSyda8FE5FwAFNbuvayZEtXZK4IkeKbpvzBlli4IeY2xA-IVXrpndPDJ4OyBDgl3fzRjt-COmqsGy_Lqt5HK-boLepr5qFLjV1l-hEmBHwfhnb-rq0US5rc9zTKjxr2E9thVQgtNqmCyIh_eYmj_22eOM_908n4DNpzR6aI55ClV-2V2iRDLwZBsDQs0a1kVoQc9gfDSKUGoyP1peE2Oj40ucgcua3UcOiYi5L-UuW2Fy_xTJBCDyNU1rEy_mzBEKRsx1vMYJT4QTDjQclvyo8MpGm_FyVSbhob5cpxuu8cIptxUMgf8fbq0KhIt1NoNU4ZOYPqc5YTGZ5QmG7p94WZD5tP3_zayOab9_PYPJJX5iEehlQ1Zlfa1LhLnHy635FXI46zKykN-l_5P6yw39OJF-B7sH0QbNXxto32pNIxVp0I4q_zLS4fGAupdXRQFwaDnAh_O8p5gJRhLxYDBHzWLGYsJprg_gKvW1S7CTRV_ZD3az2ZX_B_ZGVUCIvSqUI4Rpds0UhBnWr6Gjk3itFZuDTuQ0KEZnnN8D8mlv40oiV9rp2uUhErZeJUOxvUvInq_YE0rLmoWHpkmcteqiu5Ho03NECB1fkxXvKrpyBTId2wwC3kwSHeQDnRVyGzwKaH7NvpV0ZVzj0FtBkz7f4QXHyeZBIXexMvI8qP2Rzrkg4fWVnDDUv3Q5TRmRg7XkZPA0JdMi4JA0q7YT-tMvHTIse1FHloPJdwziLPvfAkkArL9u1NNkfKXEiuGXLW8yLolliI2Bdnnp6xgusDZh6v2YqcdlAzCsepJ4EOalqi_HkwIIoshgX-okFoqzOKGIp_sLEjzpr2Rd82d-_pEtPyjc6IjIO-UZ9ht2jL2dahieBc-ONVW_afQDg1NLfCgWnYdmT9MyWr5mPfx42ia66oLLBqSbSJfhNwt6U_grkLbHYIrLwy-bGDvRqcJNwyOXW1DVjpOMgIxVE8F7pbv-5RF_WA..'),('620bf8241529c252203df7619cc9e809','','',1328994905,1440,''),('632e70282f66cb602f43fe9a06139122','','',1328995657,1440,''),('645f720e5617ec26ac02fa47bd1d59f6','','',1329003274,1440,''),('657b64737003c77507c7a62ae4c51c55','','',1329000069,1440,''),('6f38c99f73c5cc8ac5b16c5b3600ec90','','',1329001540,1440,'okjbjwBLHaW8iDULmP_ee66VkwWHIga9BXwjXnNI8W6OAt3JQnbB3xdJ-0zOlKb9qEK-weeIOIs-tndpUxeTfxwwrhde70sy5b_eIYO7Km3KWmKn-HySuTC5QiSAb1z84awQz4jGiwS9ac7oWGcmvWuMPXFHkwD-VZfA80w1aDGI-PisHinSO1yn0jHdUDyoN96B7iMrBjiMyhDzZ7lu2-aQmWL51qSy_Qg9AEmyK71xrdKrFY-xAoiw6sbiO9wnSmWvDuqZzTqBzoSVyFVi1oFyUMzVI07R6K9-ouW-dM4kKLF6_Wr5iSnUnBpBjtU2KuaqKkixC4FqYpKCAlvGIlFdKik3oDMn_8M-IJV9KbaK92-AfYZNQI0wrBHUEIXNGnGjKMlGfs6tYJQ6nQq-bT-5D3lW1Q3XYqLGSvE2A4rOh-rPKwVV6jjH9_GL8F-thyqa9livziEeyjSW-5hwKD2GpbGDgIB_Y2kbe9Ytgi91nkwMZZZHmTv9VA4PF8GkOpRMylfRvfycsHRPf4db_3Jxg4ELnsLPrtp16i203JtRVkUwKsep_Gsxgwl6C4FmGcLlVkxSl3QecmrUFU_eJRKpmsOme_5kDOM4j9lDrR81hWUUQuy4bdDH-GEI0w9_QGgRUWEW1wn7-ORpSxaB4yeEDXHbdFO199LGyg_ikB4S3954jjV-KjjPUfDza2OyxHfdUOEk3B0uncIcWB2hnMxOHwWIE401PViqCRAYlw17fDx-wQq_6LuC3g_Iok7NSsm8L7oZa_r01__llBBRlGE-xOB1Lvjkz7eJxzmORW7VzwEos1c8fuV8__DmYCBnQD7Yd3KUFl7B2yy-6m_7Ia4tNrIje4kAYNnGxE75FJX-X6nS6fhfruFTUnslyzm6GEUqLrbmHrULI99zO5u9EXGiFPsggtjp5wQtRO-QfrB1SBSTYyClzBJ_n6OoHvx5'),('731d79998836d5eee81b71360f5e76e0','','',1329001392,1440,'h3o086Y1hCgTg2QyZ5DIrp2sBmLcDUuePLG-k6qrB-KHdVqnlgpsB9UoAm2VLefhvToxgzsT9bvCaOetPsHKBMUxAdUerEnAKjkXS-lxdHTW40nmYFX9970qu6GnJBH7JzVajW-KFehVzq7TvGpQ_hIsbvghh1FODFr0VumOrZskqw3-0hWmlVRH5YGm-oRrtZjXINwVRQACZC4inzdYOk-c40aVgu_Z1HJwn_gqZPFRiyak9yMpqxgqCBgCsiCCLq8JHk_vA-qItnmfJEJZbZA0bieSv15yOVVkcmbH-Etaa9I3ZoDKx7JOlYyEoM7rYDVonCn4j7ALQ86UeYXwhbEF_rWGBaUovMF95QGXFIp8j-1qenb69feiQUu-pq5KRbPO6I52enHhKNK9w9Xy10ZpI0jrAOfe9mBCa6eIyzvBMRgFUTSJIJcaOjTiMLRKPLehEuRDcEz6tmMGdgwIkG_g7nRr8bfDH6w1vZ1H_Yk3QIwFakuL2Zh5gy-MBFnljxjtWAK8b1PPT79b5n3D_ExH94V--891yUquo5W3QHMWoffH88RyJsVsj4ZG5GZHyTMG7pIeJqnaV0v_Cco0r4AWML_k3ZU-WFuJC1vsRwMb98st9WqNe5EW7Zz-A0Yd_NaXkWHTTix3SH8VX5F7c8XnUoChM2olPfKTx_2JcHBSj_ayF5FX8CXB7gxOKmY_n4Ufb1w2KWvGU0OQrCoRwDGPTTpeTHPaR5iGV96dy2RcvyLNqARnOQ_sOmjNIqW40VlfkGGBQ1Mrt66gVWVUYK0bDPCMI_yYqRULW8SYqsZ4euFH2QWZG2lfmIn4hebZ7Xcs5hetpE6crDX2wllm8OYLKI2wjvt2SIWInP77G2MQ0qAinatagPkptidJHcMTZckcUEN4Uo3CEgBtG38BncyowRwOOF3R96Toezlz3DrF8DVTWk-xJIkgU-FjrjLPzm4ogIvTbDl93HgxSu_8xQ..'),('77746d0f84221b36d476d13744c67db5','','',1328946312,1440,''),('78d3a606d99800a83cd55d54c6dc5d7c','','',1328999765,1440,''),('8185d67308a75c931058e49dd1a242dd','','',1329000312,1440,''),('8389821a7071b7548f7eb76c8a970898','','',1329034575,1440,''),('8ff05e61f0bc61fca147c95fe8a81c6d','','',1329000448,1440,''),('993ac9581aba144397b1492fc670e56e','','',1328946368,1440,''),('9d454865961536bf87b6c2fbe7efb8e4','','',1328943352,1440,'_OOsjsKlJDvXuMw-jW5DF2IU6raz8kI9kNPp9WZTqvFV7webUWxp6Xwiudn4x3Zr1Dh4QFk8bTtqCQfYTVvPLw..'),('9eb8ab014c1c65801148ac6b2f67e013','','',1328943675,1440,''),('a1ccf465e9405a5562891182fb8e7229','','',1329033118,1440,''),('a2e5353f4e039dc198efaa090a343bf6','','',1329005097,1440,''),('a2fd2ebd019c12542705b0cd90b5e019','','',1328973978,1440,''),('ad6dbdd25849a604a74200cf39aeb460','','',1328943666,1440,''),('ad8d850d11ff6e0680e1263068c294e2','','',1328944394,1440,''),('b9ab0d686121768942f388e8a8f6d00c','','',1329060480,1440,''),('c34c5b90ec05c4684a9f1b62248a759b','','',1328946385,1440,'QNKPI6GQVr-QXwB8PsfqPLvRpVU1G3eXIu-jtaQgG-jNeVeq7OcJwZbxWVy2pSsmwmO1a0Qnrh4PY_wTYHyIDg..'),('c4d1b32014d6a4800a3f02b2fe627ce3','','',1329000070,1440,''),('c50fd94402d51befc0726df64eb0c9a7','','',1329051547,1440,''),('c6535a792d7b32105090f6775be53ceb','','',1328999394,1440,''),('c72f2ef6916761ebce78f29d4ea9925a','','',1329000295,1440,''),('cb50db09a0a02743d81353286b3a76d5','','',1329001708,1440,''),('cd4434943fbe1d293f17a380bf4bba45','','',1329000280,1440,''),('cd943cd656686622abe8889d6d82f89a','','',1328999804,1440,''),('cq610o4kr2o7ii3oid37k3rtd3','','',1329064882,1440,''),('d0afe194eb662f6a8608ef6a9b8e2916','','',1329000305,1440,''),('d4a9b106157dd39218584bbd21e7ad38','','',1329063805,1440,''),('d8b5826852ba37bed4dfabb588778919','','',1328985566,1440,''),('de7510bf9e5e2ff3cb4fa204332d17f1','','',1329001722,1440,'8HtNmt2lHbSNbobNQV5X_2bGqg5tER6WH-sSBwXqEzmzIounDsSgqNrIefbMcK1OM2bzj-TwJzVlWpD-a1d7AQ..'),('e23235cb4a4a55739da2a3be4c1175e8','','',1328946237,1440,''),('e23a52c469beccb143a8753e19b89320','','',1329000308,1440,''),('ef3394d49e28a30d7dd42e4515b291fc','','',1329001300,1440,'Ar8Q1Cl0pC4nh-9Y19tlP3LtKmCf1rx7iX6BPmKtKweYmAY_PtqGkd4vDgYgOQjhmXA3VALh2_fB3Ufdpzl0Bwha3LyMS_3ZJU7VhMIb8xn1FbsTjgVOjiQcJqSF2O3vn3fn-26H6hUGbXlDdwteZnp25j4VEZ8iJZKIjrXCmHt6J98j5TrtpexIgWQopl5LuddamyWoW9ArV17WDQHuLyFvwDdWfvlx5ZexbKR3-iK9dU5InHWDzDXlfT_gfOwmasgdmfcJFVuiua32RN4S2p9uVi9RiVk8dn4zHNYQzBOFPw2fKVTFqmS5bZ68zM0zdxUVMJOvPCtG0gjS0Wok5BHzKFZyl6chQavUT-Blm5oUgOSg_ZHnZuhX8bfzAVBECgkjghvzRxpNmYnXfT_VkE0n09HSl79kTYX4qnCEBn79jQDr_cRWiDXhc8xVjtRb-F_F4wMgVu-jSyxN5pFcgSuhf3KdDSyJ9aU4wNK7pfHjeisOBXfz0eJ7X1gqMHy2UrQSi-0MrYfgwCou975J3L5rwRol7IWZ3YamAXRczcToH8GH2Cjvog3v1LzHEugOLGLNwdTjbKULQeyA-2J2vrJLgfce2qKTEBKnQcOrwg-xMISgWzJuN3VyKxlSDUu1V7TsfeSS4rMPxeXRL-9S_q9Di5wPRPDXxrNzHrszu296cz2CmJi5O9xZWNUEODdeXdYCaDtOJX3HTZMUqiDe-G-R-tBy5w058uGfCWiyE1esYhnCgGVK19OmKE7sbjw1ETxp529wYkAfljaaMY7-oiQ206XViTKiaMCKs_u6DkYInnt7PTs7OSY6fvGxTNUwHEMPlQWlWDth11YbJ1yikTi5dfQb8VEeZoerNyE0ZsrgTUKPpAAGpYGgaadpVJr9PaKiTtR9BCmikYFimjcJlkime9kqhm9NuaLyeGYGVggxYHaStPeC6Gdbt3HrIL9qy9OvRX9qvxp0oP47x2_adUNcbw0dHK1KTsPgmY2lTc7AFBRz9WH1G0KcEIQXbv3P7vM7pbbuBk-zWE2-8EAUvblCDhQ3RsVDnMrdO23DcXaJxKhEIY3WX2H_usGZoUq1MbS_rywtNb2QMbyZ0w8J4UloCsFU8R6MfIBgvud4nszMwNH7QnFpI-n-1VE4od-zDlXqX2asj3KVDioRGUgCpl2KvbwI3weu0Y4dMwMG7mOVVi4APj93zhNK__7FNARFyrtOxapPit_EhdlxnQ3VbM93lnB92n0vvwoX8FKfb3kkzVRRdEWxu5Sqm4b9_7o0iuPcKzyVN-xSygQfsqK_sW2FGhyAQBYHXbY4vaxAOqhovT9Imfhs_ImMx-3FJl6Tx7YyIMTIum1ocI_ioHO3sASr2cj9tGrlumqi6QO1oNzX1msAvKm99cWV48FfPZa9uI9GqEpUw--f40fwMCFNAYRTryw6bI2dqpNr8Anzb9GloypDsu7ULnQwNmc1JOt8J3Ea-FC2bwZpga3gcvaDx8aaGGttOPGxuq8oo-mgUp2IOO-1fenRqAUT7gD7qUr4kzB24zReaU3KI9UPpQXuz822SbF07EpEha1jRJzu1YC2BEH8tQZ74kJQEIQh0KOfHjaMaPqF6gManIzl9efMCAD8Uy1VA7um5_80_cXKAVdgAUdg4y2qFgg4CtT1rOAVysUs-mIWSAEcIM44jqLLc33FXl4XOzPVSHLhIEBQGj_Wt6evryym2gtKE_Bcdw1cKXvNnBUhPfGC2mjmNmp5CmlJWtwlMFh1y1dC0jCgKrxcjd-nhj_cak0SF6CFOyLwBDKmpI2n15efgshFAVNfTA..'),('f287c415952fbf5c0478b479584e6785','','',1329000449,1440,'');

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
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

/*Data for the table `detalledocumentopago` */

insert  into `detalledocumentopago`(`iddetalledocumento`,`iddocumento`,`cantidad`,`importe`,`peso`,`precio`,`idarticulo`) values (23,19,1,123,NULL,'123.00',1),(22,19,1,123,NULL,'123.00',2),(24,20,1,123,NULL,'123.00',2),(25,20,1,123,NULL,'123.00',1),(26,21,1,123,NULL,'123.00',2),(27,21,1,123,NULL,'123.00',1),(28,22,1,2,NULL,'2.45',4),(29,22,1,150,NULL,'150.00',7),(30,23,1,123,NULL,'123.00',2),(31,24,1,2,NULL,'2.45',5),(32,24,1,3,NULL,'3.45',3),(33,25,1,3,NULL,'3.45',3),(34,26,2,5,NULL,'2.45',4),(35,27,2,5,NULL,'2.45',4),(36,28,3,7,NULL,'2.45',4),(37,28,1,3,NULL,'3.45',3),(38,29,3,7,NULL,'2.45',4),(39,29,1,3,NULL,'3.45',3),(40,30,3,7,NULL,'2.45',4),(41,30,1,3,NULL,'3.45',3),(42,31,3,7,NULL,'2.45',4),(43,31,1,3,NULL,'3.45',3),(44,32,3,7,NULL,'2.45',4),(45,32,1,3,NULL,'3.45',3),(46,33,1,3,NULL,'3.45',3),(47,34,1,3,NULL,'3.45',3),(48,35,1,3,NULL,'3.45',3),(49,36,1,3,NULL,'3.45',3),(50,37,1,3,NULL,'3.45',3),(51,38,1,3,NULL,'3.45',3),(52,39,1,3,NULL,'3.45',3),(53,40,1,3,NULL,'3.45',3),(54,41,1,3,NULL,'3.45',3),(55,42,1,3,NULL,'3.45',3),(56,43,1,3,NULL,'3.45',3),(57,44,1,3,NULL,'3.45',3),(58,45,1,2,NULL,'2.45',4),(59,46,1,2,NULL,'2.45',4),(60,47,1,2,NULL,'2.45',4),(61,48,1,2,NULL,'2.45',4),(62,49,1,2,NULL,'2.45',4),(63,50,1,2,NULL,'2.45',4),(64,51,1,2,NULL,'2.45',4),(65,52,1,2,NULL,'2.45',4),(66,53,1,2,NULL,'2.45',4),(67,54,1,3,NULL,'3.45',3),(68,55,1,3,NULL,'3.45',3),(69,56,1,123,NULL,'123.00',1),(70,57,1,123,NULL,'123.00',1),(71,58,1,123,NULL,'123.00',1),(72,59,1,123,NULL,'123.00',1),(73,60,1,123,NULL,'123.00',1),(74,61,1,123,NULL,'123.00',1),(75,62,1,123,NULL,'123.00',1),(76,63,1,3,NULL,'3.45',3),(77,64,1,3,NULL,'3.45',3),(78,65,2,246,NULL,'123.00',1),(79,66,5,750,NULL,'150.00',7),(80,67,1,3,NULL,'3.45',3),(81,68,5,12,NULL,'2.45',5);

/*Table structure for table `detalleslug` */

DROP TABLE IF EXISTS `detalleslug`;

CREATE TABLE `detalleslug` (
  `iddetalleslug` int(11) NOT NULL auto_increment,
  `idarticulo` int(11) default NULL,
  `idslug` int(11) default NULL,
  PRIMARY KEY  (`iddetalleslug`)
) ENGINE=InnoDB AUTO_INCREMENT=411 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `detalleslug` */

insert  into `detalleslug`(`iddetalleslug`,`idarticulo`,`idslug`) values (8,6282,5),(9,6282,1),(10,6282,2),(11,6282,8),(12,6282,9),(13,6283,10),(14,6283,1),(15,6283,2),(16,6283,8),(17,6283,9),(18,6283,11),(291,5,25),(292,5,26),(293,5,27),(294,5,28),(295,5,22),(296,5,23),(297,5,24),(298,5,29),(304,4,30),(305,4,31),(306,4,32),(313,0,34),(314,0,35),(315,0,31),(316,0,27),(317,0,33),(318,0,19),(319,0,36),(320,6,34),(321,6,35),(322,6,31),(323,6,27),(324,6,33),(325,6,19),(326,6,22),(327,6,37),(338,7,38),(339,7,39),(340,7,40),(341,7,41),(342,7,42),(376,3,20),(377,3,31),(378,3,27),(379,3,33),(380,3,19),(381,3,22),(395,2,11),(396,2,8),(397,2,43),(398,2,9),(399,2,15),(400,2,18),(401,2,7),(402,1,1),(403,1,2),(404,1,16),(405,1,8),(406,1,9),(407,1,10),(408,1,15),(409,1,7),(410,1,18);

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
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

/*Data for the table `documentopago` */

insert  into `documentopago`(`iddocumento`,`numeroserie`,`numerocomprobante`,`fechacreacion`,`fecvencimiento`,`total`,`idtipodocumento`,`idempresa`,`idcliente`,`idestado`,`flagactivo`,`moneda`,`tipocambio`,`idvendedor`,`IGV`,`comentario`,`idpedido`,`direccion`,`flagdespacho`,`hora`) values (20,'02',1212,'0000-00-00',NULL,NULL,2,0,452,1,1,'','0.00','1','18',NULL,NULL,NULL,1,NULL),(19,'02',123123123,'0000-00-00',NULL,NULL,2,0,454,1,1,'','0.00','1','18',NULL,NULL,NULL,1,NULL),(22,'02',1,'0000-00-00',NULL,'152.45',2,0,457,1,1,'','0.00','1','18','qweqweqwe',NULL,'sdasdasd',NULL,NULL),(23,'01',2312312,'0000-00-00',NULL,'123.00',1,0,454,1,1,'','0.00','1','18','dq',NULL,'Los Olivos',NULL,NULL),(24,'02',2324234,'0000-00-00',NULL,'5.90',2,0,457,1,1,'','0.00','1','18','err',NULL,'',0,NULL),(25,'01',123,'0000-00-00',NULL,'3.45',1,0,458,1,1,'','0.00','1','18','wewewefwf',NULL,'',0,NULL),(29,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',1,NULL),(27,NULL,NULL,'2012-07-21',NULL,'4.90',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdasdadasd',1,'00:00:01'),(28,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',1,NULL),(30,NULL,NULL,'0000-00-00',NULL,'10.80',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,NULL),(32,'1',2334323,'0000-00-00',NULL,'10.80',2,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadasdasd',1,'13:30:00'),(33,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(34,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(35,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(36,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(37,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(38,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(39,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(40,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(41,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(42,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(43,NULL,NULL,'0000-00-00',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(44,NULL,NULL,'2012-02-22',NULL,'9.45',NULL,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'22:00:00'),(45,NULL,NULL,'2012-02-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(46,NULL,NULL,'2012-03-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(47,NULL,NULL,'2012-04-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(48,NULL,NULL,'2012-05-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(49,NULL,NULL,'2012-06-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(50,NULL,NULL,'2012-06-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(51,NULL,NULL,'2012-07-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(52,NULL,NULL,'2012-08-26',NULL,'8.45',NULL,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(53,NULL,NULL,'0000-00-00',NULL,'8.45',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'2342342423',0,'00:00:00'),(54,NULL,NULL,'0000-00-00',NULL,'9.45',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdsdadasd',0,'00:00:00'),(55,NULL,NULL,'2012-07-08',NULL,'9.45',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdad',0,'00:00:00'),(56,NULL,NULL,'0000-00-00',NULL,'129.00',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdasasd',0,'00:00:00'),(57,NULL,NULL,'0000-00-00',NULL,'129.00',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdasasd',0,'00:00:00'),(58,NULL,NULL,'0000-00-00',NULL,'129.00',2,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadad',0,'00:00:00'),(59,NULL,NULL,'0000-00-00',NULL,'129.00',2,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadad',0,'00:00:00'),(60,NULL,NULL,'0000-00-00',NULL,'129.00',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadasdad',0,'00:00:00'),(61,NULL,NULL,'0000-00-00',NULL,'129.00',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadasdad',0,'00:00:00'),(62,NULL,NULL,'0000-00-00',NULL,'129.00',1,NULL,461,1,1,NULL,NULL,NULL,'18',NULL,NULL,'asdadasdad',0,'00:00:00'),(63,NULL,NULL,'0000-00-00',NULL,'9.45',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'sdadasd',0,'00:00:00'),(64,NULL,NULL,'0000-00-00',NULL,'9.45',1,NULL,460,1,1,NULL,NULL,NULL,'18',NULL,NULL,'sdadasd',0,'00:00:00'),(65,NULL,NULL,'0000-00-00',NULL,'246.00',1,NULL,461,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'adasdasdasd asdasdasd asdasdasd asdasdasd',0,'00:00:00'),(66,NULL,NULL,'0000-00-00',NULL,'756.00',1,NULL,462,1,1,NULL,NULL,NULL,'18',NULL,NULL,'av la mar san isidro',0,'20:30:00'),(67,NULL,NULL,'0000-00-00',NULL,'9.45',1,NULL,463,1,1,NULL,NULL,NULL,'18',NULL,NULL,'los olivos',0,'01:00:00'),(68,NULL,NULL,'2012-05-11',NULL,'18.25',1,NULL,464,1,1,NULL,NULL,NULL,'18',NULL,NULL,'jesus maria',0,'00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `slug` */

insert  into `slug`(`idslug`,`nombreslug`) values (1,'coca'),(2,'cola'),(3,'wisky'),(4,'ron'),(5,'bebidas'),(6,'pisco'),(7,'gaseosa'),(8,'medio'),(9,'litro'),(10,'bebida'),(11,'pepsi'),(12,'1'),(13,'2'),(14,'cocagaseosabebidasoda'),(15,'soda'),(16,'descartable'),(17,'bebidasodagaseosahelada'),(18,'helada'),(19,'cerveza'),(20,'cristal'),(21,'litros'),(22,'chela'),(23,'six'),(24,'pack'),(25,'barena'),(26,'330'),(27,'ml'),(28,'6pack'),(29,'sixpack'),(30,'cusquena'),(31,'355'),(32,'ml12pack'),(33,'12pack'),(34,'pilsen'),(35,'callao'),(36,'licores'),(37,'licor'),(38,'whisky'),(39,'johnnie'),(40,'walker'),(41,'red'),(42,'label'),(43,'litroo');

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
