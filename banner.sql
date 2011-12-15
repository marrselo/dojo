/*
SQLyog Enterprise - MySQL GUI
MySQL - 5.5.16-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `banner` (
	`idbanner` double ,
	`nombre` varchar (150),
	`descripcion` blob ,
	`imagen` varchar (600),
	`url` varchar (600),
	`precio` double ,
	`orden` tinyint (4),
	`estado` tinyint (4)
); 
insert into `banner` (`idbanner`, `nombre`, `descripcion`, `imagen`, `url`, `precio`, `orden`, `estado`) values('1','foto 1',NULL,'pame.jpg',NULL,NULL,'1','1');
insert into `banner` (`idbanner`, `nombre`, `descripcion`, `imagen`, `url`, `precio`, `orden`, `estado`) values('2','foto 2',NULL,'pame2.jpg',NULL,NULL,'2','1');
insert into `banner` (`idbanner`, `nombre`, `descripcion`, `imagen`, `url`, `precio`, `orden`, `estado`) values('3','foto 3',NULL,'pame6.jpg',NULL,NULL,'3','1');
insert into `banner` (`idbanner`, `nombre`, `descripcion`, `imagen`, `url`, `precio`, `orden`, `estado`) values('4','gente','asdasd asdasd','gente','asda',NULL,NULL,'1');
insert into `banner` (`idbanner`, `nombre`, `descripcion`, `imagen`, `url`, `precio`, `orden`, `estado`) values('5','pa ra mi','too bueno','pa-ra-mi.jpg','asd',NULL,NULL,'1');
