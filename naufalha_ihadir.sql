-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 30, 2019 at 01:09 PM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `naufalha_ihadir`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `level`) VALUES
(1, 'naufal', '1234', 'admin'),
(2, 'hafizi', '1234', 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `try1`
--

CREATE TABLE `try1` (
  `idtry1` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `try1`
--

INSERT INTO `try1` (`idtry1`, `nama`) VALUES
(2, 'naaufaal');

-- --------------------------------------------------------

--
-- Table structure for table `try2`
--

CREATE TABLE `try2` (
  `idtry2` int(11) NOT NULL,
  `umur` varchar(50) NOT NULL,
  `idtry1` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `try2`
--

INSERT INTO `try2` (`idtry2`, `umur`, `idtry1`) VALUES
(1, '20', 2),
(2, '44', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `Teacher_email` varchar(50) DEFAULT NULL,
  `Teacher_password` varchar(50) NOT NULL,
  `Teacher_sekolah` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `Teacher_email`, `Teacher_password`, `Teacher_sekolah`) VALUES
(1, 'naufalhafizi@gmail.com', '1234', 'SMKbp'),
(2, 'afiq@gmail.com', 'abc123', 'SMKBT'),
(5, 'akil@gmail.com', 'uq', 'SMK. Sentul'),
(7, 'hafizi@gmail.com', '12345', 'SMK Kotaa'),
(8, 'ghazali@gmail.com', '848345', 'SMK Batu Pahat'),
(13, 'nabila@gmail.com', '12345', 'SMK Panji'),
(14, 'nadia@gmail.com', '8080', 'SMK Muar'),
(15, 'amir@gmail.com', '5050', 'SMK Tapang'),
(16, 'mama@gmail.com', '878787', 'SMK Permaisuri'),
(17, 'abah@gmail.com', '45464', 'SMK Wakaf Bharu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `try1`
--
ALTER TABLE `try1`
  ADD PRIMARY KEY (`idtry1`);

--
-- Indexes for table `try2`
--
ALTER TABLE `try2`
  ADD PRIMARY KEY (`idtry2`),
  ADD KEY `idtry1` (`idtry1`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `try1`
--
ALTER TABLE `try1`
  MODIFY `idtry1` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `try2`
--
ALTER TABLE `try2`
  MODIFY `idtry2` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `try2`
--
ALTER TABLE `try2`
  ADD CONSTRAINT `try2_ibfk_1` FOREIGN KEY (`idtry1`) REFERENCES `try1` (`idtry1`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
