-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 02, 2025 at 09:45 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_CreateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CreateAllergeen` (IN `p_name` VARCHAR(50), IN `p_description` VARCHAR(255))   BEGIN
    INSERT INTO Allergeen (Naam, Omschrijving)
    VALUES (p_name, p_description);

    SELECT LAST_INSERT_ID() AS new_id;
END$$

DROP PROCEDURE IF EXISTS `sp_DeleteAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteAllergeen` (IN `p_id` INT)   BEGIN
    DELETE FROM Allergeen
    WHERE Id = p_id;

    SELECT ROW_COUNT() AS affected;
END$$

DROP PROCEDURE IF EXISTS `Sp_GetAllAllergenen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetAllAllergenen` ()   BEGIN
    SELECT ALGE.Id,
           ALGE.Naam,
           ALGE.Omschrijving
    FROM Allergeen AS ALGE;
END$$

DROP PROCEDURE IF EXISTS `Sp_GetAllergeenById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetAllergeenById` (IN `p_id` INT)   BEGIN
    SELECT ALGE.Id,
           ALGE.Naam,
           ALGE.Omschrijving
    FROM Allergeen AS ALGE
    WHERE ALGE.Id = p_id;
END$$

DROP PROCEDURE IF EXISTS `sp_GetAllergenenByProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllergenenByProduct` (IN `p_productId` INT)   BEGIN
    SELECT PROD.Id AS ProductId,
           PROD.Naam AS ProductNaam,
           PROD.Barcode,
           ALGE.Naam AS AllergeenNaam,
           ALGE.Omschrijving AS AllergeenOmschrijving
    FROM Product AS PROD
    LEFT JOIN ProductPerAllergeen AS PPA ON PPA.ProductId = PROD.Id
    LEFT JOIN Allergeen AS ALGE ON ALGE.Id = PPA.AllergeenId
    WHERE PROD.Id = p_productId;
END$$

DROP PROCEDURE IF EXISTS `sp_GetAllProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllProducts` ()   BEGIN
    SELECT PROD.Id,
           PROD.Naam,
           PROD.Barcode,
           MAGA.VerpakkingsEenheid,
           MAGA.AantalAanwezig
    FROM Product AS PROD
    INNER JOIN Magazijn AS MAGA ON PROD.Id = MAGA.ProductId;
END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverancierInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverancierInfo` (IN `p_productId` INT)   BEGIN
    SELECT PROD.Naam,
           PPLE.DatumLevering,
           PPLE.Aantal,
           PPLE.DatumEerstVolgendeLevering,
           MAGA.AantalAanwezig
    FROM Product AS PROD
    INNER JOIN ProductPerLeverancier AS PPLE ON PPLE.ProductId = PROD.Id
    INNER JOIN Magazijn AS MAGA ON MAGA.ProductId = PROD.Id
    WHERE PROD.Id = p_productId;
END$$

DROP PROCEDURE IF EXISTS `sp_GetLeverantieInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetLeverantieInfo` (IN `p_Id` INT)   BEGIN
    SELECT DISTINCT LEVE.Id,
                    LEVE.Naam,
                    LEVE.Contactpersoon,
                    LEVE.Leveranciernummer,
                    LEVE.Mobiel
    FROM Leverancier AS LEVE
    INNER JOIN ProductPerLeverancier AS PPLE ON LEVE.Id = PPLE.LeverancierId
    WHERE PPLE.ProductId = p_Id;
END$$

DROP PROCEDURE IF EXISTS `sp_UpdateAllergeen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateAllergeen` (IN `p_id` INT, IN `p_naam` VARCHAR(50), IN `p_omschrijving` VARCHAR(255))   BEGIN
    UPDATE Allergeen
    SET Naam = p_naam,
        Omschrijving = p_omschrijving,
        DatumGewijzigd = SYSDATE(6)
    WHERE Id = p_id;

    SELECT ROW_COUNT() AS affected;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Omschrijving` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', 1, NULL, '2025-11-02 21:20:09.316648', '2025-11-02 21:35:52.167585'),
(2, 'Gelatine', 'Dit product bevat gelatine', 1, NULL, '2025-11-02 21:20:09.316648', '2025-11-02 21:20:09.316648'),
(3, 'AZO-kleurstof', 'Dit product bevat AZO-kleurstof', 1, NULL, '2025-11-02 21:20:09.316648', '2025-11-02 21:20:09.316648'),
(4, 'Lactose', 'Dit product bevat lactose', 1, NULL, '2025-11-02 21:20:09.316648', '2025-11-02 21:20:09.316648'),
(5, 'Soja', 'Dit product bevat soja', 1, NULL, '2025-11-02 21:20:09.316648', '2025-11-02 21:20:09.316648');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_jayavandepol@hotmail.com|127.0.0.1:timer', 'i:1762119424;', 1762119424),
('laravel_cache_jayavandepol@hotmail.com|127.0.0.1', 'i:1;', 1762119424);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Contactpersoon` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Leveranciernummer` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Mobiel` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Leverancier_Leveranciernummer` (`Leveranciernummer`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `Contactpersoon`, `Leveranciernummer`, `Mobiel`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751'),
(6, 'Quality Street', 'Johan Nooij', 'L1029234586', '06-23458456', 1, NULL, '2025-11-02 21:20:09.321751', '2025-11-02 21:20:09.321751');

-- --------------------------------------------------------

--
-- Table structure for table `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `VerpakkingsEenheid` decimal(4,1) NOT NULL,
  `AantalAanwezig` smallint UNSIGNED DEFAULT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_Magazijn_ProductId_Product_Id` (`ProductId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakkingsEenheid`, `AantalAanwezig`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 5.0, 453, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(2, 2, 2.5, 400, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(3, 3, 5.0, 1, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(4, 4, 1.0, 800, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(5, 5, 3.0, 234, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(6, 6, 2.0, 345, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(7, 7, 1.0, 795, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(8, 8, 10.0, 233, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(9, 9, 2.5, 123, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(10, 10, 3.0, NULL, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(11, 11, 2.0, 367, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(12, 12, 1.0, 467, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447'),
(13, 13, 5.0, 20, 1, NULL, '2025-11-02 21:20:09.324447', '2025-11-02 21:20:09.324447');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_02_000003_create_allergen_stored_procedures', 1),
(5, '2025_11_02_000004_create_jamin_domain_tables', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Barcode` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Product_Barcode` (`Barcode`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(2, 'Schoolkrijt', '8719587326713', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(3, 'Honingdrop', '8719587327836', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(4, 'Zure Beren', '8719587321441', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(5, 'Cola Flesjes', '8719587321237', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(6, 'Turtles', '8719587322245', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(7, 'Witte Muizen', '8719587328256', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(8, 'Reuzen Slangen', '8719587325641', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(9, 'Zoute Rijen', '8719587322739', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(10, 'Winegums', '8719587327527', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(11, 'Drop Munten', '8719587322345', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(12, 'Kruis Drop', '8719587322265', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235'),
(13, 'Zoute Ruitjes', '8719587323256', 1, NULL, '2025-11-02 21:20:09.319235', '2025-11-02 21:20:09.319235');

-- --------------------------------------------------------

--
-- Table structure for table `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `AllergeenId` smallint UNSIGNED NOT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerAllergeen_ProductId_Product_Id` (`ProductId`),
  KEY `FK_ProductPerAllergeen_AllergeenId_Allergeen_Id` (`AllergeenId`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(2, 1, 1, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(3, 1, 3, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(4, 3, 4, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(5, 6, 5, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(6, 9, 2, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(7, 9, 5, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(8, 10, 2, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(9, 12, 4, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(10, 13, 1, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(11, 13, 4, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483'),
(12, 13, 5, 1, NULL, '2025-11-02 21:20:09.326483', '2025-11-02 21:20:09.326483');

-- --------------------------------------------------------

--
-- Table structure for table `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `LeverancierId` smallint UNSIGNED NOT NULL,
  `ProductId` mediumint UNSIGNED NOT NULL,
  `DatumLevering` date NOT NULL,
  `Aantal` int UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date DEFAULT NULL,
  `IsActief` tinyint(1) NOT NULL DEFAULT '1',
  `Opmerkingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DatumAangemaakt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `FK_ProductPerLeverancier_LeverancierId_Leverancier_Id` (`LeverancierId`),
  KEY `FK_ProductPerLeverancier_ProductId_Product_Id` (`ProductId`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `LeverancierId`, `ProductId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `IsActief`, `Opmerkingen`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(3, 1, 2, '2024-10-09', 12, '2024-10-16', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(4, 1, 3, '2024-10-10', 11, '2024-10-17', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(5, 2, 4, '2024-10-14', 16, '2024-10-21', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(6, 2, 4, '2024-10-21', 23, '2024-10-28', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(7, 2, 5, '2024-10-14', 45, '2024-10-21', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(8, 2, 6, '2024-10-14', 30, '2024-10-21', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(9, 3, 7, '2024-10-12', 12, '2024-10-19', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(10, 3, 7, '2024-10-19', 23, '2024-10-26', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(11, 3, 8, '2024-10-10', 12, '2024-10-17', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(12, 3, 9, '2024-10-11', 1, '2024-10-18', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(13, 4, 10, '2024-10-16', 24, '2024-10-30', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(14, 5, 11, '2024-10-10', 47, '2024-10-17', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(15, 5, 11, '2024-10-19', 60, '2024-10-26', 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(16, 5, 12, '2024-10-11', 45, NULL, 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081'),
(17, 5, 13, '2024-10-12', 23, NULL, 1, NULL, '2025-11-02 21:20:09.329081', '2025-11-02 21:20:09.329081');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('MjFoyBrazdV46rMIh42tSZN2tsNIhPdFR6QNhjaW', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidVlnZHFOdm9IalBKNmpHQlVVelBOQWdKSGF6Q1hyMmVwT25HdXRMWiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1762119763);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', '2025-11-02 20:20:09', '$2y$12$hDdGnzP11cCMuPf93t0LjOiHgUAfg5Bd20dCsrEZAX7BSdLGk4aYW', 'KqpUfkk3gqi99tOj7oskIKqY8JExzG1W35pwy3QFLX9awwsaz8ha3kubCFCG', '2025-11-02 20:20:09', '2025-11-02 20:20:09');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
