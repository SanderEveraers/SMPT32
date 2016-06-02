-- phpMyAdmin SQL Dump
-- version 4.5.3.1
-- http://www.phpmyadmin.net
--
-- Host: mysql4.mijnhostingpartner.nl
-- Generation Time: Jun 02, 2016 at 09:12 AM
-- Server version: 5.1.56-community-log
-- PHP Version: 7.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `vangastewordflip`
--

-- --------------------------------------------------------

--
-- Table structure for table `klas`
--

CREATE TABLE `klas` (
  `ID` int(11) NOT NULL,
  `GegevenVak` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `klas`
--

INSERT INTO `klas` (`ID`, `GegevenVak`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `leerling`
--

CREATE TABLE `leerling` (
  `ID` int(11) NOT NULL,
  `Gebruikersnaam` varchar(30) NOT NULL,
  `Wachtwoord` varchar(64) NOT NULL,
  `LaatstIngelogd` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leerling`
--

INSERT INTO `leerling` (`ID`, `Gebruikersnaam`, `Wachtwoord`, `LaatstIngelogd`) VALUES
(6, 'Sander', 'sanderiscool', '2016-05-27 11:57:17'),
(7, 'Bram', 'bramiscool', '2016-05-27 11:57:17'),
(8, 'Rob', 'robiscool', '2016-05-27 11:57:17'),
(9, 'Stan', 'staniscool', '2016-05-27 11:57:17'),
(10, 'Joris', 'jorisiscool', '2016-05-27 11:57:17');

-- --------------------------------------------------------

--
-- Table structure for table `leerling_klas`
--

CREATE TABLE `leerling_klas` (
  `Leerling_ID` int(11) NOT NULL,
  `Klas_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leerling_klas`
--

INSERT INTO `leerling_klas` (`Leerling_ID`, `Klas_ID`) VALUES
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tip_vd_dag`
--

CREATE TABLE `tip_vd_dag` (
  `ID` int(11) NOT NULL,
  `Tip` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `toets`
--

CREATE TABLE `toets` (
  `ID` int(11) NOT NULL,
  `Naam` varchar(255) NOT NULL,
  `Aanmaakdatum` datetime NOT NULL,
  `Toetsdatum` datetime NOT NULL,
  `Klas_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toets`
--

INSERT INTO `toets` (`ID`, `Naam`, `Aanmaakdatum`, `Toetsdatum`, `Klas_ID`) VALUES
(1, 'Unit 1', '2016-05-27 12:02:07', '2016-05-30 11:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `toets_vraag`
--

CREATE TABLE `toets_vraag` (
  `Toets_ID` int(11) NOT NULL,
  `Vraag_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toets_vraag`
--

INSERT INTO `toets_vraag` (`Toets_ID`, `Vraag_ID`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `vak`
--

CREATE TABLE `vak` (
  `ID` int(11) NOT NULL,
  `Naam` varchar(30) NOT NULL,
  `Leerjaar` int(11) NOT NULL,
  `Niveau` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vak`
--

INSERT INTO `vak` (`ID`, `Naam`, `Leerjaar`, `Niveau`) VALUES
(1, 'Engels', 4, 'Havo');

-- --------------------------------------------------------

--
-- Table structure for table `vraag`
--

CREATE TABLE `vraag` (
  `ID` int(11) NOT NULL,
  `Vraag` varchar(255) NOT NULL,
  `Antwoord` varchar(255) NOT NULL,
  `ContextZin` varchar(500) DEFAULT NULL,
  `ContextAfb` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vraag`
--

INSERT INTO `vraag` (`ID`, `Vraag`, `Antwoord`, `ContextZin`, `ContextAfb`) VALUES
(1, 'independence', 'onafhankelijkheid', NULL, NULL),
(2, 'city', 'stad', 'Welcome to the city Amsterdam', NULL),
(3, 'rhythm', 'ritme', 'That music has nice rhythm', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vraag_beantwoord`
--

CREATE TABLE `vraag_beantwoord` (
  `ID` int(11) NOT NULL,
  `Leerling_ID` int(11) NOT NULL,
  `Vraag_ID` int(11) NOT NULL,
  `GegevenAntwoord` varchar(255) NOT NULL,
  `Tijdsduur` time NOT NULL,
  `Datum` datetime NOT NULL,
  `GoedBeantwoord` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `klas`
--
ALTER TABLE `klas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_VAKKLAS` (`GegevenVak`);

--
-- Indexes for table `leerling`
--
ALTER TABLE `leerling`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UQ_LEERLING` (`Gebruikersnaam`);

--
-- Indexes for table `leerling_klas`
--
ALTER TABLE `leerling_klas`
  ADD PRIMARY KEY (`Leerling_ID`,`Klas_ID`),
  ADD KEY `FK_LEERLINGKLASKLAS` (`Klas_ID`);

--
-- Indexes for table `tip_vd_dag`
--
ALTER TABLE `tip_vd_dag`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `toets`
--
ALTER TABLE `toets`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_TOETSKLAS` (`Klas_ID`);

--
-- Indexes for table `toets_vraag`
--
ALTER TABLE `toets_vraag`
  ADD PRIMARY KEY (`Toets_ID`,`Vraag_ID`),
  ADD KEY `FK_TOETSVRAAGVRAAG` (`Vraag_ID`);

--
-- Indexes for table `vak`
--
ALTER TABLE `vak`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UQ_VAK` (`Naam`,`Leerjaar`,`Niveau`);

--
-- Indexes for table `vraag`
--
ALTER TABLE `vraag`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `vraag_beantwoord`
--
ALTER TABLE `vraag_beantwoord`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_VBLEERLING` (`Leerling_ID`),
  ADD KEY `FK_VBVRAAG` (`Vraag_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `klas`
--
ALTER TABLE `klas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `leerling`
--
ALTER TABLE `leerling`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tip_vd_dag`
--
ALTER TABLE `tip_vd_dag`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `toets`
--
ALTER TABLE `toets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `vak`
--
ALTER TABLE `vak`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `vraag`
--
ALTER TABLE `vraag`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `vraag_beantwoord`
--
ALTER TABLE `vraag_beantwoord`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `klas`
--
ALTER TABLE `klas`
  ADD CONSTRAINT `FK_VAKKLAS` FOREIGN KEY (`GegevenVak`) REFERENCES `vak` (`ID`);

--
-- Constraints for table `leerling_klas`
--
ALTER TABLE `leerling_klas`
  ADD CONSTRAINT `FK_LEERLINGKLASLEERLING` FOREIGN KEY (`Leerling_ID`) REFERENCES `leerling` (`ID`),
  ADD CONSTRAINT `FK_LEERLINGKLASKLAS` FOREIGN KEY (`Klas_ID`) REFERENCES `klas` (`ID`);

--
-- Constraints for table `toets`
--
ALTER TABLE `toets`
  ADD CONSTRAINT `FK_TOETSKLAS` FOREIGN KEY (`Klas_ID`) REFERENCES `klas` (`ID`);

--
-- Constraints for table `toets_vraag`
--
ALTER TABLE `toets_vraag`
  ADD CONSTRAINT `FK_TOETSVRAAGTOETS` FOREIGN KEY (`Toets_ID`) REFERENCES `toets` (`ID`),
  ADD CONSTRAINT `FK_TOETSVRAAGVRAAG` FOREIGN KEY (`Vraag_ID`) REFERENCES `vraag` (`ID`);

--
-- Constraints for table `vraag_beantwoord`
--
ALTER TABLE `vraag_beantwoord`
  ADD CONSTRAINT `FK_VBLEERLING` FOREIGN KEY (`Leerling_ID`) REFERENCES `leerling` (`ID`),
  ADD CONSTRAINT `FK_VBVRAAG` FOREIGN KEY (`Vraag_ID`) REFERENCES `vraag` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
