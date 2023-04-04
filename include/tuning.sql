-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.44


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema database
--

CREATE DATABASE IF NOT EXISTS database;
USE database;

--
-- Definition of table `cars`
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(3) unsigned NOT NULL default '0',
  `modelid` int(3) NOT NULL default '0',
  `x` decimal(10,6) NOT NULL default '0.000000',
  `y` decimal(10,6) NOT NULL default '0.000000',
  `z` decimal(10,6) NOT NULL default '0.000000',
  `ang` decimal(10,6) default NULL,
  `cor1` int(3) NOT NULL default '0',
  `cor2` int(3) NOT NULL default '0',
  `pintura` int(2) NOT NULL default '0',
  `t1` int(6) NOT NULL default '0',
  `t2` int(6) NOT NULL default '0',
  `t3` int(6) NOT NULL default '0',
  `t4` int(6) NOT NULL default '0',
  `t5` int(6) NOT NULL default '0',
  `t6` int(6) NOT NULL default '0',
  `t7` int(6) NOT NULL default '0',
  `t8` int(6) NOT NULL default '0',
  `t9` int(6) NOT NULL default '0',
  `t10` int(6) NOT NULL default '0',
  `t11` int(6) NOT NULL default '0',
  `t12` int(6) NOT NULL default '0',
  `t13` int(6) NOT NULL default '0',
  `t14` int(6) NOT NULL default '0',
  `t15` int(6) NOT NULL default '0',
  `t16` int(6) NOT NULL default '0',
  `t17` int(6) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `cars`
--

/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
INSERT INTO `cars` (`id`,`modelid`,`x`,`y`,`z`,`ang`,`cor1`,`cor2`,`dono`,`placa`,`gasolina`,`ipva`,`pintura`,`t1`,`t2`,`t3`,`t4`,`t5`,`t6`,`t7`,`t8`,`t9`,`t10`,`t11`,`t12`,`t13`,`t14`,`t15`,`t16`,`t17`) VALUES 
 /*!40000 ALTER TABLE `cars` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
