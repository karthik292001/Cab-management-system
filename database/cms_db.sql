-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2022 at 07:03 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cms_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getClients` (IN `flag` INT)  BEGIN
	SELECT * from client_list WHERE delete_flag=flag;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking_list`
--

CREATE TABLE `booking_list` (
  `id` int(30) NOT NULL,
  `ref_code` varchar(100) NOT NULL,
  `client_id` int(30) NOT NULL,
  `cab_id` int(30) NOT NULL,
  `pickup_zone` text NOT NULL,
  `drop_zone` text NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0 = Pending,\r\n1 = Driver has Confirmed,\r\n2 = Pickup,\r\n3 = drop-off,\r\n4 = cancelled',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking_list`
--

INSERT INTO `booking_list` (`id`, `ref_code`, `client_id`, `cab_id`, `pickup_zone`, `drop_zone`, `status`, `date_created`, `date_updated`) VALUES
(11, '202203-00002', 11, 6, 'Bengaluru', 'Mysore', 3, '2022-03-28 21:40:42', '2022-03-28 21:41:12'),
(13, '202203-00003', 11, 7, 'hassan', 'tumkur', 0, '2022-03-29 11:04:13', NULL),
(14, '202203-00003', 16, 6, 'koppa', 'banglore', 3, '2022-03-29 15:33:39', '2022-03-29 15:34:33');

--
-- Triggers `booking_list`
--
DELIMITER $$
CREATE TRIGGER `booking_del` AFTER DELETE ON `booking_list` FOR EACH ROW insert into booking_list_del values(OLD.id,OLD.ref_code,OLD.client_id,OLD.cab_id,OLD.pickup_zone,OLD.drop_zone,OLD.status,OLD.date_created,OLD.date_updated)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking_list_del`
--

CREATE TABLE `booking_list_del` (
  `id` int(32) NOT NULL,
  `ref_code` varchar(32) NOT NULL,
  `client_id` int(50) NOT NULL,
  `cab_id` int(50) NOT NULL,
  `pickup_zone` text NOT NULL,
  `drop_zone` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking_list_del`
--

INSERT INTO `booking_list_del` (`id`, `ref_code`, `client_id`, `cab_id`, `pickup_zone`, `drop_zone`, `status`, `date_created`, `date_updated`) VALUES
(3, '202202-00003', 1, 2, 'Sample Pickup Zone 1', 'Sample Drop off Zone 1', 3, '2022-02-16 15:33:10', '2022-02-16 15:40:01'),
(2, '202202-00003', 1, 2, 'Sample Pickup Zone 1', 'Sample Drop-off Zone 1', 4, '2022-02-16 13:53:27', '2022-02-16 15:01:16'),
(5, '202203-00001', 4, 1, 'Bengaluru', 'Koppa', 0, '2022-03-26 10:48:01', '2022-03-26 11:11:52'),
(9, '202203-00002', 6, 6, 'bengakuru', 'mysore', 3, '2022-03-26 12:05:48', '2022-03-26 12:06:23'),
(8, '202203-00002', 7, 6, 'ankola', 'dharmasthala', 3, '2022-03-26 11:47:53', '2022-03-26 11:51:43'),
(12, '202203-00002', 15, 6, 'koppa', 'ujire', 3, '2022-03-29 10:30:45', '2022-03-29 10:31:59');

-- --------------------------------------------------------

--
-- Table structure for table `cab_list`
--

CREATE TABLE `cab_list` (
  `id` int(30) NOT NULL,
  `reg_code` varchar(100) NOT NULL,
  `category_id` int(30) NOT NULL,
  `cab_reg_no` varchar(200) NOT NULL,
  `body_no` varchar(100) NOT NULL,
  `cab_model` text NOT NULL,
  `cab_driver` text NOT NULL,
  `driver_contact` text NOT NULL,
  `driver_address` text NOT NULL,
  `password` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cab_list`
--

INSERT INTO `cab_list` (`id`, `reg_code`, `category_id`, `cab_reg_no`, `body_no`, `cab_model`, `cab_driver`, `driver_contact`, `driver_address`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(6, '202203-00001', 2, '202202-00003', '1012', 'GBN-2307', 'Bob', '988991122', 'Ujire', '2acba7f51acfd4fd5102ad090fc612ee', NULL, 1, 0, '2022-03-26 11:07:21', NULL),
(7, '202203-00002', 2, '987654', '106', 'abc', 'shashi', '696969', 'kundapura', '25f9e794323b453885f5181f1b624d0b', NULL, 1, 0, '2022-03-29 10:34:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_list`
--

CREATE TABLE `category_list` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_list`
--

INSERT INTO `category_list` (`id`, `name`, `description`, `delete_flag`, `status`, `date_created`, `date_updated`) VALUES
(2, '6 Seater', 'Quisque iaculis ipsum egestas nisi pharetra, ac laoreet felis tincidunt. Cras id gravida justo. Nulla non gravida risus, vel finibus leo. Phasellus vel eros ligula. Fusce a erat sed quam vehicula convallis.', 0, 1, '2022-02-16 10:08:10', '2022-03-29 13:02:32'),
(3, '5 seater', 'Luxury', 1, 1, '2022-03-28 21:42:20', '2022-03-28 21:42:46'),
(4, '2 Seater', 'this vehical is noice', 1, 1, '2022-03-29 10:38:29', '2022-03-29 10:38:43');

-- --------------------------------------------------------

--
-- Table structure for table `client_list`
--

CREATE TABLE `client_list` (
  `id` int(30) NOT NULL,
  `firstname` text NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` text NOT NULL,
  `gender` text NOT NULL,
  `contact` text NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_added` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client_list`
--

INSERT INTO `client_list` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `contact`, `address`, `email`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_added`) VALUES
(11, 'Karthik', '', '', 'Male', '9883325664', 'Bengaluru', 'kar@gmail.xom', '8cff595e7389b246a0afb402676c0af8', NULL, 1, 0, '2022-03-28 21:31:32', NULL),
(13, 'Hithaish', '', '', 'Male', '7975117551', 'Ujire', 'hit@gmail.com', '811af4f09363550a7a082171ced529f1', NULL, 1, 1, '2022-03-28 21:37:06', '2022-03-28 21:38:29'),
(16, 'jai', '', '', 'Male', '123466', 'koppa', 'jaiganeshkn842@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', NULL, 1, 0, '2022-03-29 15:30:19', NULL);

--
-- Triggers `client_list`
--
DELIMITER $$
CREATE TRIGGER `client_list_del` AFTER DELETE ON `client_list` FOR EACH ROW insert into client_list_del values(OLD.id,OLD.firstname,OLD.middlename,OLD.lastname,OLD.gender,OLD.contact,OLD.address,OLD.email,OLD.password,OLD.image_path,OLD.status,OLD.delete_flag,OLD.date_created,OLD.date_added)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `client_list_del`
--

CREATE TABLE `client_list_del` (
  `id` int(30) NOT NULL,
  `firstname` text NOT NULL,
  `middlename` text NOT NULL,
  `lastname` text NOT NULL,
  `gender` text NOT NULL,
  `contact` text NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `delete_flag` tinyint(4) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client_list_del`
--

INSERT INTO `client_list_del` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `contact`, `address`, `email`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_added`) VALUES
(7, 'Manoj', 'Prakash', 'Male', '', '7975117551', 'ankola', 'manojgaonkar@gmail.com', '5e81f9859d223ea420aca993c647b839', NULL, 1, 0, '2022-03-26 11:45:50', NULL),
(6, 'Hithaish', '', 'Male', '', '9883325664', 'Mysore', 'hit@gmail.com', '811af4f09363550a7a082171ced529f1', NULL, 1, 1, '2022-03-26 11:14:32', '2022-03-28 21:23:05'),
(14, 'Manoj', '', 'Male', '', '8556654222', 'Ujire', 'man@gmail.com', 'b002a688af5c97e632a5adce23988189', NULL, 1, 1, '2022-03-28 21:59:46', '2022-03-28 22:00:59');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Cab Management System'),
(6, 'short_name', 'CMS'),
(11, 'logo', 'uploads\\download.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1644974880_wallpaper.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1624240500_avatar.png', NULL, 1, '2021-01-20 14:02:37', '2021-06-21 09:55:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_list`
--
ALTER TABLE `booking_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cab_id` (`cab_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `cab_list`
--
ALTER TABLE `cab_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `category_list`
--
ALTER TABLE `category_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_list`
--
ALTER TABLE `client_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`(191)) USING HASH;

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_list`
--
ALTER TABLE `booking_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cab_list`
--
ALTER TABLE `cab_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `category_list`
--
ALTER TABLE `category_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `client_list`
--
ALTER TABLE `client_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_list`
--
ALTER TABLE `booking_list`
  ADD CONSTRAINT `booking_list_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cab_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_list_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cab_list`
--
ALTER TABLE `cab_list`
  ADD CONSTRAINT `cab_list_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_list` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
