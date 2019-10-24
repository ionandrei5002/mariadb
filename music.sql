-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 24, 2019 at 08:10 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `music`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
CREATE TABLE IF NOT EXISTS `album` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SINGER_ID` bigint(10) NOT NULL,
  `TITLE` varchar(100) NOT NULL,
  `RELEASE_DATE` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UQ_SINGER_ALBUM_1` (`SINGER_ID`,`TITLE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`ID`, `SINGER_ID`, `TITLE`, `RELEASE_DATE`) VALUES
(5, 1, 'Battle Studies', '2009-11-17'),
(6, 2, ' From The Cradle ', '1994-09-13');

-- --------------------------------------------------------

--
-- Table structure for table `singer`
--

DROP TABLE IF EXISTS `singer`;
CREATE TABLE IF NOT EXISTS `singer` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `singer`
--

INSERT INTO `singer` (`id`, `first_name`, `last_name`, `birth_date`) VALUES
(1, 'John', 'Mayer', '1977-10-16'),
(2, 'Eric', 'Clapton', '1945-03-30'),
(3, 'John', 'Butler', '1975-04-01');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `FK_ALBUM` FOREIGN KEY (`SINGER_ID`) REFERENCES `singer` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
