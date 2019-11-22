-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Nov 11, 2019 at 04:22 PM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- SET AUTOCOMMIT = 0;
-- START TRANSACTION;
-- SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_branamad`
--

-- --------------------------------------------------------

--
-- Table structure for table `Character`
--

CREATE TABLE `Character` (
  `character_id` int(20) NOT NULL,
  `guildmembership` int(20) DEFAULT NULL,
  `name` varchar(15) DEFAULT NULL,
  `raid_group` int(20) DEFAULT NULL,
  `player_id` int(20) NOT NULL,
  `class` varchar(12) NOT NULL,
  `race` varchar(9) NOT NULL,
  `level` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Character`
--

INSERT INTO `Character` (`character_id`, `guildmembership`, `name`, `raid_group`, `player_id`, `class`, `race`, `level`) VALUES
(1, NULL, 'Sunshine', NULL, 1, 'Night Elf', 'Druid', 47),
(2, 2, 'Sontiaro', 2, 2, 'Human', 'Mage', 67),
(3, 3, 'MegaDeath', 3, 3, 'Orc', 'Hunter', 23),
(4, 1, 'Shiromar', 1, 4, 'Orc', 'Warrior', 100),
(5, 1, 'Andrioch', NULL, 4, 'Undead', 'Rogue', 100),
(6, NULL, 'Redbull', NULL, 4, 'Tauren', 'Shaman', 100);

-- --------------------------------------------------------

--
-- Table structure for table `Guild`
--

CREATE TABLE `Guild` (
  `guild_id` int(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `raid_groups` int(100) DEFAULT NULL,
  `numberofcharacters` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Guild`
--

INSERT INTO `Guild` (`guild_id`, `name`, `raid_groups`, `numberofcharacters`) VALUES
(1, 'Subway eat flesh', 3, 80),
(2, 'Frank and friends', 1, 10),
(3, 'Tryhards', 2, 27);

-- --------------------------------------------------------

--
-- Table structure for table `Guild_Raid_Group`
--

CREATE TABLE `Guild_Raid_Group` (
  `guild_id` int(20) NOT NULL,
  `raid_group_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Guild_Raid_Group`
--

INSERT INTO `Guild_Raid_Group` (`guild_id`, `raid_group_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(3, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Player`
--

CREATE TABLE `Player` (
  `player_id` int(20) NOT NULL,
  `user_password` varchar(20) NOT NULL,
  `characters` int(20) DEFAULT NULL,
  `user_Name` varchar(20) NOT NULL,
  `endofpayedplaytime` date NOT NULL,
  `accountcreationDate` date NOT NULL,
  `accountlevel` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Player`
--

INSERT INTO `Player` (`player_id`, `user_password`, `characters`, `user_Name`, `endofpayedplaytime`, `accountcreationDate`, `accountlevel`) VALUES
(1, 'swordfish', 1, 'RuthieBear43', '2020-02-15', '2015-07-30', 3),
(2, 'WhatStaysINvEGAS', 1, 'GlitzGlam', '2020-03-03', '2017-04-05', 2),
(3, 'ImTheBest111', 1, 'MegaDestroyer', '2020-05-08', '2019-10-13', 1),
(4, 'scarablord07', 3, 'OldGuard', '2020-09-24', '2004-11-23', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Raid`
--

CREATE TABLE `Raid` (
  `raid_name` varchar(20) NOT NULL,
  `boss` varchar(20) NOT NULL,
  `experience` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Raid`
--

INSERT INTO `Raid` (`raid_name`, `boss`, `experience`) VALUES
('Ahn\'Qiraj', 'Cthun', 500),
('Icecrown', 'Arthas', 100),
('Molten Core', 'Ragnaros', 200),
('Onyxia\'s Lair', 'Onyxia', 250);

-- --------------------------------------------------------

--
-- Table structure for table `Raid_Group`
--

CREATE TABLE `Raid_Group` (
  `raid_group_id` int(20) NOT NULL,
  `raid_name` varchar(20) DEFAULT NULL,
  `raid_group_leader` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Raid_Group`
--

INSERT INTO `Raid_Group` (`raid_group_id`, `raid_name`, `raid_group_leader`) VALUES
(1, 'Ahn\'Qiraj', 4),
(2, 'Molten Core', 2),
(3, 'Icecrown', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Character`
--
ALTER TABLE `Character`
  ADD PRIMARY KEY (`character_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `guildmembership` (`guildmembership`),
  ADD KEY `raid_group` (`raid_group`);

--
-- Indexes for table `Guild`
--
ALTER TABLE `Guild`
  ADD PRIMARY KEY (`guild_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `Guild_Raid_Group`
--
ALTER TABLE `Guild_Raid_Group`
  ADD PRIMARY KEY (`guild_id`,`raid_group_id`),
  ADD KEY `raid_group_id` (`raid_group_id`);

--
-- Indexes for table `Player`
--
ALTER TABLE `Player`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `Raid`
--
ALTER TABLE `Raid`
  ADD PRIMARY KEY (`raid_name`);

--
-- Indexes for table `Raid_Group`
--
ALTER TABLE `Raid_Group`
  ADD PRIMARY KEY (`raid_group_id`),
  ADD KEY `raid_group_leader` (`raid_group_leader`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Character`
--
ALTER TABLE `Character`
  MODIFY `character_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Guild`
--
ALTER TABLE `Guild`
  MODIFY `guild_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Player`
--
ALTER TABLE `Player`
  MODIFY `player_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Raid_Group`
--
ALTER TABLE `Raid_Group`
  MODIFY `raid_group_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Character`
--
ALTER TABLE `Character`
  ADD CONSTRAINT `Character_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `Player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Character_ibfk_2` FOREIGN KEY (`guildmembership`) REFERENCES `Guild` (`guild_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Character_ibfk_3` FOREIGN KEY (`raid_group`) REFERENCES `Raid_Group` (`raid_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Guild_Raid_Group`
--
ALTER TABLE `Guild_Raid_Group`
  ADD CONSTRAINT `Guild_Raid_Group_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `Guild` (`guild_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Guild_Raid_Group_ibfk_2` FOREIGN KEY (`raid_group_id`) REFERENCES `Raid_Group` (`raid_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Raid_Group`
--
ALTER TABLE `Raid_Group`
  ADD CONSTRAINT `Raid_Group_ibfk_1` FOREIGN KEY (`raid_group_leader`) REFERENCES `Character` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
