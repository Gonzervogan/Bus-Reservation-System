-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	6.0.3-alpha-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema bus_reservation_system2
--

CREATE DATABASE IF NOT EXISTS bus_reservation_system2;
USE bus_reservation_system2;

--
-- Definition of table `booking_history`
--

DROP TABLE IF EXISTS `booking_history`;
CREATE TABLE `booking_history` (
  `user_id` int(10) unsigned NOT NULL,
  `pnr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dep_time` varchar(45) NOT NULL,
  `route_id` int(10) unsigned NOT NULL,
  `date` varchar(45) NOT NULL,
  `fare` int(10) unsigned NOT NULL,
  `bus_id` int(10) unsigned NOT NULL,
  `seat_nums` varchar(45) NOT NULL,
  `num_of_seats` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pnr`),
  KEY `FK_booking_history_1` (`user_id`),
  KEY `FK_booking_history_2` (`route_id`),
  KEY `FK_booking_history_3` (`bus_id`),
  CONSTRAINT `FK_booking_history_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_booking_history_2` FOREIGN KEY (`route_id`) REFERENCES `route_master` (`route_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_booking_history_3` FOREIGN KEY (`bus_id`) REFERENCES `bus_master` (`bus_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking_history`
--

/*!40000 ALTER TABLE `booking_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_history` ENABLE KEYS */;


--
-- Definition of table `bus_master`
--

DROP TABLE IF EXISTS `bus_master`;
CREATE TABLE `bus_master` (
  `bus_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bus_num` varchar(45) NOT NULL,
  `bus_type` int(10) unsigned NOT NULL,
  `total_seats` int(10) unsigned NOT NULL,
  `bus_name` varchar(45) NOT NULL,
  `route_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bus_id`),
  KEY `FK_bus_master_1` (`bus_type`),
  KEY `FK_bus_master_2` (`route_id`),
  CONSTRAINT `FK_bus_master_1` FOREIGN KEY (`bus_type`) REFERENCES `bus_types` (`bus_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bus_master_2` FOREIGN KEY (`route_id`) REFERENCES `route_master` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bus_master`
--

/*!40000 ALTER TABLE `bus_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `bus_master` ENABLE KEYS */;


--
-- Definition of table `bus_types`
--

DROP TABLE IF EXISTS `bus_types`;
CREATE TABLE `bus_types` (
  `bus_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bus_type` varchar(45) NOT NULL,
  `speed` int(10) unsigned NOT NULL,
  `ac` tinyint(1) NOT NULL,
  `fare_per_km` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bus_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bus_types`
--

/*!40000 ALTER TABLE `bus_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `bus_types` ENABLE KEYS */;


--
-- Definition of table `route_master`
--

DROP TABLE IF EXISTS `route_master`;
CREATE TABLE `route_master` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_loc` varchar(45) NOT NULL,
  `to_loc` varchar(45) NOT NULL,
  `distance` int(10) unsigned NOT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `route_master`
--

/*!40000 ALTER TABLE `route_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `route_master` ENABLE KEYS */;


--
-- Definition of table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `day` varchar(45) NOT NULL,
  `dep_time` varchar(45) NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `bus_type` int(10) unsigned NOT NULL,
  `bus_id` int(10) unsigned NOT NULL,
  `fare` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bus_id`,`day`,`dep_time`),
  KEY `FK_schedule_2` (`route_id`),
  KEY `FK_schedule_3` (`bus_type`),
  CONSTRAINT `FK_schedule_1` FOREIGN KEY (`bus_id`) REFERENCES `bus_master` (`bus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_schedule_2` FOREIGN KEY (`route_id`) REFERENCES `route_master` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_schedule_3` FOREIGN KEY (`bus_type`) REFERENCES `bus_types` (`bus_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;


--
-- Definition of table `seat_tracking`
--

DROP TABLE IF EXISTS `seat_tracking`;
CREATE TABLE `seat_tracking` (
  `bus_id` int(10) unsigned NOT NULL,
  `journey_id` varchar(45) NOT NULL,
  `seats_available` varchar(100) NOT NULL,
  PRIMARY KEY (`bus_id`,`journey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `seat_tracking`
--

/*!40000 ALTER TABLE `seat_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_tracking` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `pwd` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
