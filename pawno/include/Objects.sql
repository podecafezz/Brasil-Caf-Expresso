-- phpMyAdmin SQL Dump
-- version 3.3.7deb6
-- http://www.phpmyadmin.net
--
-- Vert: localhost
-- Generert den: 25. Apr, 2012 18:01 PM
-- Tjenerversjon: 5.1.49
-- PHP-Versjon: 5.3.3-7+squeeze3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `Objects`
--

CREATE TABLE IF NOT EXISTS `Objects` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ObjectID` int(11) NOT NULL,
  `fX` float NOT NULL,
  `fY` float NOT NULL,
  `fZ` float NOT NULL,
  `rX` float NOT NULL,
  `rY` float NOT NULL,
  `rZ` float NOT NULL,
  `Description` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dataark for tabell `Objects`
--

