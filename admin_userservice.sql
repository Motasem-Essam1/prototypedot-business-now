-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 12, 2024 at 08:10 AM
-- Server version: 8.0.36
-- PHP Version: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_userservice`
--

CREATE DATABASE IF NOT EXISTS `admin_userservice`;

USE `admin_userservice`;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `display_name`, `phone`, `profile`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 'Elalfee', '010940706235', NULL, 1, 1, '2024-01-22 08:21:03', '2024-01-22 08:21:03'),
(2, 'test', '123456789012', NULL, 22, 1, '2024-03-10 08:56:19', '2024-03-10 08:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` bigint UNSIGNED NOT NULL,
  `type` enum('product','service','required_service') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` enum('egypt','morocco') COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `sub_category_id` int DEFAULT NULL,
  `views` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `company_id` int DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `promotion_expiry` date DEFAULT NULL,
  `promotion_price` decimal(8,2) DEFAULT NULL,
  `promotion_plan_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `type`, `title`, `description`, `price`, `city`, `region`, `category_id`, `sub_category_id`, `views`, `user_id`, `user_type`, `company_id`, `approved`, `promotion_expiry`, `promotion_price`, `promotion_plan_id`, `created_at`, `updated_at`) VALUES
(1, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, 0, 12, 1, 'company', 24, 0, NULL, NULL, NULL, '2024-02-11 08:28:19', '2024-03-10 14:49:13'),
(2, 'product', 'Test', 'jsshhshxxhxushshsuxuxujsjsbedgxyyxudhevdhxudhsvdhxhdhdhevdvxhxjdbvbr', 30.00, 'Maadi', 'egypt', 1, 0, 8, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-18 12:03:46', '2024-02-20 12:50:55'),
(3, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, 0, 11, 1, 'company', 24, 0, NULL, NULL, NULL, '2024-02-18 14:00:48', '2024-03-10 14:55:15'),
(4, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:17:27', '2024-02-20 15:17:27'),
(5, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:17:49', '2024-02-20 15:17:49'),
(6, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:19:54', '2024-02-20 15:19:54'),
(7, 'product', 'test', 'testddddddddddddda', 55.00, 'egypt', 'egypt', 11, 0, 0, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-20 15:38:03', '2024-02-20 15:39:17'),
(8, 'product', 'ad test', 'test desc', 510.00, 'egypt', 'egypt', 2, NULL, 0, 10, 'user', NULL, 0, NULL, NULL, NULL, '2024-02-20 15:40:40', '2024-02-20 15:40:40'),
(9, 'product', 'test', 'test', 56.00, 'egypt', 'egypt', 2, NULL, 5, 10, 'user', NULL, 0, NULL, NULL, NULL, '2024-02-20 15:43:42', '2024-03-10 15:48:54'),
(10, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 2, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:44:59', '2024-02-21 08:23:14'),
(11, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 2, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:45:14', '2024-03-10 15:50:43'),
(12, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:45:39', '2024-02-20 15:45:39'),
(13, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:45:54', '2024-02-20 15:45:54'),
(16, 'service', 'test', 'test', 77.00, 'egypt', 'egypt', 1, NULL, 0, 10, 'user', NULL, 0, NULL, NULL, NULL, '2024-02-20 15:47:38', '2024-02-20 15:47:38'),
(17, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 0, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-20 15:49:17', '2024-02-20 15:49:17'),
(19, 'service', 'test', 'test', 66.00, 'egypt', 'egypt', 2, 0, 50, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-20 15:51:05', '2024-03-10 15:46:52'),
(20, 'service', 'test', 'test', 46.00, 'egypt', 'egypt', 2, 0, 119, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-21 08:09:53', '2024-03-10 15:48:43'),
(21, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 47, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-21 08:16:21', '2024-03-10 15:48:42'),
(22, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, NULL, 3, 2, 'user', 24, 0, NULL, NULL, NULL, '2024-02-21 08:17:52', '2024-03-10 15:48:41'),
(23, 'service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, 0, 2, 1, 'company', 24, 0, NULL, NULL, NULL, '2024-02-21 08:18:00', '2024-03-10 15:48:07'),
(24, 'required_service', 'test', 'hello h', 20.00, 'egypt', 'egypt', 12, 0, 2, 1, 'company', 24, 0, NULL, NULL, NULL, '2024-02-21 08:18:30', '2024-03-01 18:14:35'),
(25, 'required_service', 'test', 'test', 44.00, 'egypt', 'egypt', 1, 0, 10, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-21 08:20:26', '2024-03-10 15:48:36'),
(26, 'product', 'test', 'hello h', 20.00, 'egypt', 'egypt', 2, 2, 6, 2, 'user', NULL, 0, NULL, NULL, NULL, '2024-02-25 08:16:10', '2024-03-10 15:38:32'),
(27, 'product', 'Abdelrahman', 'Mercedes car good condition, white color, 2000 CC, Turbo, ABS', 20000.00, 'Cairo', 'egypt', 4, 0, 3, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-26 09:38:12', '2024-02-28 07:20:07'),
(28, 'service', 'test15', 'lorem ipsum', 55.00, 'egypt', 'egypt', 7, 0, 4, 1, 'admin', NULL, 0, NULL, NULL, NULL, '2024-02-28 07:58:59', '2024-03-10 15:12:00');

-- --------------------------------------------------------

--
-- Table structure for table `ad_attribute`
--

CREATE TABLE `ad_attribute` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_id` bigint UNSIGNED NOT NULL,
  `attribute_id` bigint UNSIGNED NOT NULL,
  `attribute_option_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ad_attribute`
--

INSERT INTO `ad_attribute` (`id`, `ad_id`, `attribute_id`, `attribute_option_id`, `created_at`, `updated_at`) VALUES
(5, 7, 35, 670, NULL, NULL),
(6, 8, 4, 346, NULL, NULL),
(7, 9, 3, 344, NULL, NULL),
(12, 16, 1, 338, NULL, NULL),
(14, 19, 2, 342, NULL, NULL),
(15, 20, 4, 347, NULL, NULL),
(20, 25, 1, 339, NULL, NULL),
(21, 26, 7, 360, NULL, NULL),
(22, 27, 11, 399, NULL, NULL),
(23, 27, 12, 461, NULL, NULL),
(24, 27, 13, 473, NULL, NULL),
(25, 27, 14, 480, NULL, NULL),
(26, 27, 15, 488, NULL, NULL),
(27, 27, 16, 557, NULL, NULL),
(28, 27, 17, 567, NULL, NULL),
(29, 27, 18, 572, NULL, NULL),
(30, 27, 19, 90, NULL, NULL),
(31, 27, 20, 575, NULL, NULL),
(32, 28, 28, 622, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ad_images`
--

CREATE TABLE `ad_images` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ad_images`
--

INSERT INTO `ad_images` (`id`, `ad_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 'https://business-egy.com/service/images/product/11697034119.jpg', '2024-02-11 08:28:19', '2024-02-11 08:28:19'),
(2, 1, 'https://business-egy.com/service/images/product/11697034119.jpg', '2024-02-11 08:28:19', '2024-02-11 08:28:19'),
(3, 2, 'https://business-egy.com/service/images/product/01708257826.png', '2024-02-18 12:03:46', '2024-02-18 12:03:46'),
(4, 3, 'https://business-egy.com/service/images/product/01708264848.png', '2024-02-18 14:00:48', '2024-02-18 14:00:48'),
(5, 3, 'https://business-egy.com/service/images/product/11708264848.png', '2024-02-18 14:00:48', '2024-02-18 14:00:48'),
(6, 4, 'https://business-egy.com/service/images/product/01708442247.png', '2024-02-20 15:17:27', '2024-02-20 15:17:27'),
(7, 4, 'https://business-egy.com/service/images/product/11708442247.png', '2024-02-20 15:17:27', '2024-02-20 15:17:27'),
(8, 5, 'https://business-egy.com/service/images/product/01708442269.png', '2024-02-20 15:17:49', '2024-02-20 15:17:49'),
(9, 5, 'https://business-egy.com/service/images/product/11708442269.png', '2024-02-20 15:17:49', '2024-02-20 15:17:49'),
(10, 6, 'https://business-egy.com/service/images/product/01708442395.png', '2024-02-20 15:19:55', '2024-02-20 15:19:55'),
(11, 6, 'https://business-egy.com/service/images/product/11708442395.png', '2024-02-20 15:19:55', '2024-02-20 15:19:55'),
(12, 7, 'https://business-egy.com/service/images/product/01708443483.png', '2024-02-20 15:38:03', '2024-02-20 15:38:03'),
(13, 8, 'https://business-egy.com/service/images/product/01708443640.png', '2024-02-20 15:40:40', '2024-02-20 15:40:40'),
(14, 9, 'https://business-egy.com/service/images/product/01708443822.png', '2024-02-20 15:43:42', '2024-02-20 15:43:42'),
(15, 10, 'https://business-egy.com/service/images/product/01708443899.png', '2024-02-20 15:44:59', '2024-02-20 15:44:59'),
(16, 10, 'https://business-egy.com/service/images/product/11708443899.png', '2024-02-20 15:44:59', '2024-02-20 15:44:59'),
(17, 11, 'https://business-egy.com/service/images/product/01708443914.png', '2024-02-20 15:45:14', '2024-02-20 15:45:14'),
(18, 11, 'https://business-egy.com/service/images/product/11708443914.png', '2024-02-20 15:45:14', '2024-02-20 15:45:14'),
(19, 12, 'https://business-egy.com/service/images/product/01708443939.png', '2024-02-20 15:45:39', '2024-02-20 15:45:39'),
(20, 12, 'https://business-egy.com/service/images/product/11708443939.png', '2024-02-20 15:45:39', '2024-02-20 15:45:39'),
(21, 13, 'https://business-egy.com/service/images/product/01708443954.png', '2024-02-20 15:45:54', '2024-02-20 15:45:54'),
(22, 13, 'https://business-egy.com/service/images/product/11708443954.png', '2024-02-20 15:45:54', '2024-02-20 15:45:54'),
(23, 16, 'https://business-egy.com/service/images/product/01708444058.png', '2024-02-20 15:47:38', '2024-02-20 15:47:38'),
(24, 17, 'https://business-egy.com/service/images/product/01708444157.png', '2024-02-20 15:49:17', '2024-02-20 15:49:17'),
(25, 17, 'https://business-egy.com/service/images/product/11708444157.png', '2024-02-20 15:49:17', '2024-02-20 15:49:17'),
(26, 19, 'https://business-egy.com/service/images/product/01708444265.png', '2024-02-20 15:51:05', '2024-02-20 15:51:05'),
(27, 20, 'https://business-egy.com/service/images/product/01708502993.png', '2024-02-21 08:09:53', '2024-02-21 08:09:53'),
(28, 21, 'https://business-egy.com/service/images/product/01708503381.png', '2024-02-21 08:16:21', '2024-02-21 08:16:21'),
(29, 21, 'https://business-egy.com/service/images/product/11708503381.png', '2024-02-21 08:16:21', '2024-02-21 08:16:21'),
(30, 22, 'https://business-egy.com/service/images/product/01708503472.png', '2024-02-21 08:17:52', '2024-02-21 08:17:52'),
(31, 22, 'https://business-egy.com/service/images/product/11708503472.png', '2024-02-21 08:17:52', '2024-02-21 08:17:52'),
(32, 23, 'https://business-egy.com/service/images/product/01708503480.png', '2024-02-21 08:18:00', '2024-02-21 08:18:00'),
(33, 23, 'https://business-egy.com/service/images/product/11708503480.png', '2024-02-21 08:18:00', '2024-02-21 08:18:00'),
(34, 24, 'https://business-egy.com/service/images/product/01708503510.png', '2024-02-21 08:18:30', '2024-02-21 08:18:30'),
(35, 24, 'https://business-egy.com/service/images/product/11708503510.png', '2024-02-21 08:18:30', '2024-02-21 08:18:30'),
(36, 25, 'https://business-egy.com/service/images/product/01708503626.png', '2024-02-21 08:20:26', '2024-02-21 08:20:26'),
(37, 26, 'https://business-egy.com/service/images/product/01708848970.png', '2024-02-25 08:16:10', '2024-02-25 08:16:10'),
(38, 27, 'https://business-egy.com/service/images/product/01708940292.png', '2024-02-26 09:38:12', '2024-02-26 09:38:12'),
(39, 28, 'https://business-egy.com/service/images/product/01709107139.png', '2024-02-28 07:58:59', '2024-02-28 07:58:59');

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint UNSIGNED NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_fr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `name_en`, `name_ar`, `name_fr`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Condition', 'الحالة', 'État', 1, NULL, NULL),
(2, 'Is land sorted', 'هل الأرض مصنفة', 'Le terrain est-il trié', 2, NULL, NULL),
(3, 'Have maps', 'هل لديك خرائط', 'Avez-vous des cartes', 2, NULL, NULL),
(4, 'Number of streets', 'عدد الشوارع', 'Nombre de rues', 2, NULL, NULL),
(5, 'Payment system', 'نظام الدفع', 'Système de paiement', 2, NULL, NULL),
(6, 'Furnishing', 'الفرش', 'Ameublement', 3, NULL, NULL),
(7, 'Levels', 'المستويات', 'Niveaux', 3, NULL, NULL),
(8, 'Bathrooms', 'الحمامات', 'Salles de bains', 3, NULL, NULL),
(9, 'Finishing', 'التشطيب', 'Finition', 3, NULL, NULL),
(10, 'Property Type', 'نوع العقار', 'Type de propriété', 3, NULL, NULL),
(11, 'Car Type', 'نوع السيارة', 'Type de voiture', 4, NULL, NULL),
(12, 'Gear Type', 'نوع الجير', 'Type de transmission', 4, NULL, NULL),
(13, 'Color', 'اللون', 'Couleur', 4, NULL, NULL),
(14, 'Number of Cylinders', 'عدد الأسطوانات', 'Nombre de cylindres', 4, NULL, NULL),
(15, 'Fuel Type', 'نوع الوقود', 'Type de carburant', 4, NULL, NULL),
(16, 'Engine Capacity', 'سعة المحرك', 'Capacité du moteur', 4, NULL, NULL),
(17, 'Condition', 'حالة السلعة', 'État', 4, NULL, NULL),
(18, 'Guarantee', 'الضمان', 'Garantie', 4, NULL, NULL),
(19, 'Manufacture year', 'سنة التصنيع', 'Année de fabrication', 4, NULL, NULL),
(20, 'Kilometers', 'الكيلومترات', 'Kilomètres', 4, NULL, NULL),
(21, 'Condition', 'حالة السلعة', 'État', 6, NULL, NULL),
(22, 'Gear', 'الجير', 'Boîte de vitesses', 6, NULL, NULL),
(23, 'Engine Size', 'حجم المحرك', 'Taille du moteur', 6, NULL, NULL),
(24, 'Engine power', 'قوة المحرك', 'Puissance du moteur', 6, NULL, NULL),
(25, 'Manufacture year', 'سنة التصنيع', 'Année de fabrication', 6, NULL, NULL),
(26, 'Kilometers', 'الكيلومترات', 'Kilomètres', 6, NULL, NULL),
(27, 'Condition', 'حالة السلعة', 'État', 7, NULL, NULL),
(28, 'Quality', 'جودة السلعة', 'Qualité', 7, NULL, NULL),
(29, 'Country of origin', 'بلد المنشأ', 'Pays d\'origine', 7, NULL, NULL),
(30, 'Manufacturers', 'الشركات المصنعة', 'Fabricants', 7, NULL, NULL),
(31, 'Condition', 'حالة السلعة', 'État', 8, NULL, NULL),
(32, 'Condition', 'الحالة', 'État', 9, NULL, NULL),
(33, 'Manufacture year', 'سنة التصنيع', 'Année de fabrication', 9, NULL, NULL),
(34, 'Unit Type', 'نوع الوحدة', 'Type d\'unité', 11, NULL, NULL),
(35, 'Condition', 'الحالة', 'État', 11, NULL, NULL),
(36, 'Guarantee', 'الضمان', 'Garantie', 11, NULL, NULL),
(37, 'Investment', 'الاستثمار', 'Investissement', 20, NULL, NULL),
(38, 'Payment', 'الدفع', 'Paiement', 20, NULL, NULL),
(39, 'Available Visa', 'التأشيرة المتاحة', 'Visa disponible', 20, NULL, NULL),
(40, 'Rent/M', 'الإيجار/شهر', 'Loyer/mois', 20, NULL, NULL),
(41, 'Salaries/M', 'الرواتب/شهر', 'Salaires/mois', 20, NULL, NULL),
(42, 'Income/M', 'الدخل/شهر', 'Revenu/mois', 20, NULL, NULL),
(43, 'Profit/M', 'الربح/شهر', 'Profit/mois', 20, NULL, NULL),
(44, 'Area (M2)', 'المساحة (م2)', 'Surface (m2)', 20, NULL, NULL),
(45, 'Gender', 'الجنس', 'Genre', 23, NULL, NULL),
(46, 'Nationality', 'الجنسية', 'Nationalité', 23, NULL, NULL),
(47, 'Qualification', 'المؤهل', 'Qualification', 23, NULL, NULL),
(48, 'Experience Years', 'سنوات الخبرة', 'Années d\'expérience', 23, NULL, NULL),
(49, 'Expected Salary', 'الراتب المتوقع', 'Salaire attendu', 23, NULL, NULL),
(50, 'Career Level', 'مستوى الوظيفة', 'Niveau de carrière', 23, NULL, NULL),
(51, 'Driver License', 'رخصة القيادة', 'Permis de conduire', 23, NULL, NULL),
(52, 'Job Type', 'نوع الوظيفة', 'Type d\'emploi', 23, NULL, NULL),
(53, 'Gender', 'الجنس', 'Genre', 24, NULL, NULL),
(54, 'Nationality', 'الجنسية', 'Nationalité', 24, NULL, NULL),
(55, 'Qualification', 'المؤهل', 'Qualification', 24, NULL, NULL),
(56, 'Experience Years', 'سنوات الخبرة', 'Années d\'expérience', 24, NULL, NULL),
(57, 'Expected Salary', 'الراتب المتوقع', 'Salaire attendu', 24, NULL, NULL),
(58, 'Career Level', 'مستوى الوظيفة', 'Niveau de carrière', 24, NULL, NULL),
(59, 'Driver License', 'رخصة القيادة', 'Permis de conduire', 24, NULL, NULL),
(60, 'Job Type', 'نوع الوظيفة', 'Type d\'emploi', 24, NULL, NULL),
(61, 'Delivery Cost', 'تكلفة التوصيل', 'Coût de livraison', 29, NULL, NULL),
(62, 'Time of Request', 'وقت الطلب', 'Heure de la demande', 29, NULL, NULL),
(63, 'Condition', 'الحالة', 'État', 30, NULL, NULL),
(64, 'Guarantee', 'الضمان', 'Garantie', 30, NULL, NULL),
(65, 'Condition', 'الحالة', 'État', 31, NULL, NULL),
(66, 'SIM Type', 'نوع الشريحة', 'Type de carte SIM', 31, NULL, NULL),
(67, 'Storage Capacity', 'سعة التخزين', 'Capacité de stockage', 31, NULL, NULL),
(68, 'Camera Resolution', 'دقة الكاميرا', 'Résolution de la caméra', 31, NULL, NULL),
(69, 'Guarantee', 'الضمان', 'Garantie', 31, NULL, NULL),
(70, 'Operating System', 'نظام التشغيل', 'Système d\'exploitation', 31, NULL, NULL),
(71, 'Mobile RAM', 'ذاكرة الوصول العشوائي للهاتف المحمول', 'RAM mobile', 31, NULL, NULL),
(72, 'Mobile Screen Size', 'حجم شاشة الهاتف المحمول', 'Taille de l\'écran mobile', 31, NULL, NULL),
(73, 'Battery Capacity', 'سعة البطارية', 'Capacité de la batterie', 31, NULL, NULL),
(74, 'Secondary', 'ثانوي', 'Secondaire', 31, NULL, NULL),
(75, 'Condition', 'الحالة', 'État', 32, NULL, NULL),
(76, 'Guarantee', 'الضمان', 'Garantie', 32, NULL, NULL),
(77, 'Condition', 'الحالة', 'État', 33, NULL, NULL),
(78, 'Mega Pixel', 'ميجا بيكسل', 'Méga Pixel', 33, NULL, NULL),
(79, 'Optical Zoom', 'تكبير بصري', 'Zoom optique', 33, NULL, NULL),
(80, 'Wifi Support', 'دعم الواي فاي', 'Prise en charge du Wifi', 33, NULL, NULL),
(81, 'Bluetooth', 'بلوتوث', 'Bluetooth', 33, NULL, NULL),
(82, 'Guarantee', 'الضمان', 'Garantie', 33, NULL, NULL),
(83, 'Condition', 'الحالة', 'État', 35, NULL, NULL),
(84, 'Condition', 'الحالة', 'État', 37, NULL, NULL),
(85, 'Count of Wheels', 'عدد العجلات', 'Nombre de roues', 37, NULL, NULL),
(86, 'Bluetooth', 'بلوتوث', 'Bluetooth', 37, NULL, NULL),
(87, 'Charging Period', 'فترة الشحن', 'Période de charge', 37, NULL, NULL),
(88, 'Guarantee', 'ضمان', 'Garantie', 37, NULL, NULL),
(89, 'Condition', 'الحالة', 'État', 39, NULL, NULL),
(90, 'Age', 'العمر', 'Âge', 40, NULL, NULL),
(91, 'Age', 'العمر', 'Âge', 41, NULL, NULL),
(92, 'Age', 'العمر', 'Âge', 42, NULL, NULL),
(93, 'Sex', 'الجنس', 'Sexe', 42, NULL, NULL),
(94, 'Material', 'المادة', 'Matériau', 45, NULL, NULL),
(95, 'Pattern', 'النمط', 'Motif', 45, NULL, NULL),
(96, 'Scarcity', 'الندرة', 'Rareté', 45, NULL, NULL),
(97, 'Condition', 'الحالة', 'État', 45, NULL, NULL),
(98, 'Production Year', 'سنة الإنتاج', 'Année de production', 45, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `attribute_options`
--

CREATE TABLE `attribute_options` (
  `id` bigint UNSIGNED NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_fr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_options`
--

INSERT INTO `attribute_options` (`id`, `name_en`, `name_ar`, `name_fr`, `attribute_id`, `created_at`, `updated_at`) VALUES
(66, '2024', '2024', '2024', 19, NULL, NULL),
(67, '2023', '2023', '2023', 19, NULL, NULL),
(68, '2022', '2022', '2022', 19, NULL, NULL),
(69, '2021', '2021', '2021', 19, NULL, NULL),
(70, '2020', '2020', '2020', 19, NULL, NULL),
(71, '2019', '2019', '2019', 19, NULL, NULL),
(72, '2018', '2018', '2018', 19, NULL, NULL),
(73, '2017', '2017', '2017', 19, NULL, NULL),
(74, '2016', '2016', '2016', 19, NULL, NULL),
(75, '2015', '2015', '2015', 19, NULL, NULL),
(76, '2014', '2014', '2014', 19, NULL, NULL),
(77, '2013', '2013', '2013', 19, NULL, NULL),
(78, '2012', '2012', '2012', 19, NULL, NULL),
(79, '2011', '2011', '2011', 19, NULL, NULL),
(80, '2010', '2010', '2010', 19, NULL, NULL),
(81, '2009', '2009', '2009', 19, NULL, NULL),
(82, '2008', '2008', '2008', 19, NULL, NULL),
(83, '2007', '2007', '2007', 19, NULL, NULL),
(84, '2006', '2006', '2006', 19, NULL, NULL),
(85, '2005', '2005', '2005', 19, NULL, NULL),
(86, '2004', '2004', '2004', 19, NULL, NULL),
(87, '2003', '2003', '2003', 19, NULL, NULL),
(88, '2002', '2002', '2002', 19, NULL, NULL),
(89, '2001', '2001', '2001', 19, NULL, NULL),
(90, '2000', '2000', '2000', 19, NULL, NULL),
(91, '1999', '1999', '1999', 19, NULL, NULL),
(92, '1998', '1998', '1998', 19, NULL, NULL),
(93, '1997', '1997', '1997', 19, NULL, NULL),
(94, '1996', '1996', '1996', 19, NULL, NULL),
(95, '1995', '1995', '1995', 19, NULL, NULL),
(96, '1930', '1930', '1930', 25, NULL, NULL),
(97, '1931', '1931', '1931', 25, NULL, NULL),
(98, '1932', '1932', '1932', 25, NULL, NULL),
(99, '1933', '1933', '1933', 25, NULL, NULL),
(100, '1934', '1934', '1934', 25, NULL, NULL),
(101, '1935', '1935', '1935', 25, NULL, NULL),
(102, '1936', '1936', '1936', 25, NULL, NULL),
(103, '1937', '1937', '1937', 25, NULL, NULL),
(104, '1938', '1938', '1938', 25, NULL, NULL),
(105, '1939', '1939', '1939', 25, NULL, NULL),
(106, '1940', '1940', '1940', 25, NULL, NULL),
(107, '1941', '1941', '1941', 25, NULL, NULL),
(108, '1942', '1942', '1942', 25, NULL, NULL),
(109, '1943', '1943', '1943', 25, NULL, NULL),
(110, '1944', '1944', '1944', 25, NULL, NULL),
(111, '1945', '1945', '1945', 25, NULL, NULL),
(112, '1946', '1946', '1946', 25, NULL, NULL),
(113, '1947', '1947', '1947', 25, NULL, NULL),
(114, '1948', '1948', '1948', 25, NULL, NULL),
(115, '1949', '1949', '1949', 25, NULL, NULL),
(116, '1950', '1950', '1950', 25, NULL, NULL),
(117, '1951', '1951', '1951', 25, NULL, NULL),
(118, '1952', '1952', '1952', 25, NULL, NULL),
(119, '1953', '1953', '1953', 25, NULL, NULL),
(120, '1954', '1954', '1954', 25, NULL, NULL),
(121, '1955', '1955', '1955', 25, NULL, NULL),
(122, '1956', '1956', '1956', 25, NULL, NULL),
(123, '1957', '1957', '1957', 25, NULL, NULL),
(124, '1958', '1958', '1958', 25, NULL, NULL),
(125, '1959', '1959', '1959', 25, NULL, NULL),
(126, '1960', '1960', '1960', 25, NULL, NULL),
(127, '1961', '1961', '1961', 25, NULL, NULL),
(128, '1962', '1962', '1962', 25, NULL, NULL),
(129, '1963', '1963', '1963', 25, NULL, NULL),
(130, '1964', '1964', '1964', 25, NULL, NULL),
(131, '1965', '1965', '1965', 25, NULL, NULL),
(132, '1966', '1966', '1966', 25, NULL, NULL),
(133, '1967', '1967', '1967', 25, NULL, NULL),
(134, '1968', '1968', '1968', 25, NULL, NULL),
(135, '1969', '1969', '1969', 25, NULL, NULL),
(136, '1970', '1970', '1970', 25, NULL, NULL),
(137, '1971', '1971', '1971', 25, NULL, NULL),
(138, '1972', '1972', '1972', 25, NULL, NULL),
(139, '1973', '1973', '1973', 25, NULL, NULL),
(140, '1974', '1974', '1974', 25, NULL, NULL),
(141, '1975', '1975', '1975', 25, NULL, NULL),
(142, '1976', '1976', '1976', 25, NULL, NULL),
(143, '1977', '1977', '1977', 25, NULL, NULL),
(144, '1978', '1978', '1978', 25, NULL, NULL),
(145, '1979', '1979', '1979', 25, NULL, NULL),
(146, '1980', '1980', '1980', 25, NULL, NULL),
(147, '1981', '1981', '1981', 25, NULL, NULL),
(148, '1982', '1982', '1982', 25, NULL, NULL),
(149, '1983', '1983', '1983', 25, NULL, NULL),
(150, '1984', '1984', '1984', 25, NULL, NULL),
(151, '1985', '1985', '1985', 25, NULL, NULL),
(152, '1986', '1986', '1986', 25, NULL, NULL),
(153, '1987', '1987', '1987', 25, NULL, NULL),
(154, '1988', '1988', '1988', 25, NULL, NULL),
(155, '1989', '1989', '1989', 25, NULL, NULL),
(156, '1990', '1990', '1990', 25, NULL, NULL),
(157, '1991', '1991', '1991', 25, NULL, NULL),
(158, '1992', '1992', '1992', 25, NULL, NULL),
(159, '1993', '1993', '1993', 25, NULL, NULL),
(160, '1994', '1994', '1994', 25, NULL, NULL),
(161, '1995', '1995', '1995', 25, NULL, NULL),
(162, '1996', '1996', '1996', 25, NULL, NULL),
(163, '1997', '1997', '1997', 25, NULL, NULL),
(164, '1998', '1998', '1998', 25, NULL, NULL),
(165, '1999', '1999', '1999', 25, NULL, NULL),
(166, '2000', '2000', '2000', 25, NULL, NULL),
(167, '2001', '2001', '2001', 25, NULL, NULL),
(168, '2002', '2002', '2002', 25, NULL, NULL),
(169, '2003', '2003', '2003', 25, NULL, NULL),
(170, '2004', '2004', '2004', 25, NULL, NULL),
(171, '2005', '2005', '2005', 25, NULL, NULL),
(172, '2006', '2006', '2006', 25, NULL, NULL),
(173, '2007', '2007', '2007', 25, NULL, NULL),
(174, '2008', '2008', '2008', 25, NULL, NULL),
(175, '2009', '2009', '2009', 25, NULL, NULL),
(176, '2010', '2010', '2010', 25, NULL, NULL),
(177, '2011', '2011', '2011', 25, NULL, NULL),
(178, '2012', '2012', '2012', 25, NULL, NULL),
(179, '2013', '2013', '2013', 25, NULL, NULL),
(180, '2014', '2014', '2014', 25, NULL, NULL),
(181, '2015', '2015', '2015', 25, NULL, NULL),
(182, '2016', '2016', '2016', 25, NULL, NULL),
(183, '2017', '2017', '2017', 25, NULL, NULL),
(184, '2018', '2018', '2018', 25, NULL, NULL),
(185, '2019', '2019', '2019', 25, NULL, NULL),
(186, '2020', '2020', '2020', 25, NULL, NULL),
(187, '2021', '2021', '2021', 25, NULL, NULL),
(188, '2022', '2022', '2022', 25, NULL, NULL),
(189, '2023', '2023', '2023', 25, NULL, NULL),
(190, '2024', '2024', '2024', 25, NULL, NULL),
(191, '1930', '1930', '1930', 33, NULL, NULL),
(192, '1931', '1931', '1931', 33, NULL, NULL),
(193, '1932', '1932', '1932', 33, NULL, NULL),
(194, '1933', '1933', '1933', 33, NULL, NULL),
(195, '1934', '1934', '1934', 33, NULL, NULL),
(196, '1935', '1935', '1935', 33, NULL, NULL),
(197, '1936', '1936', '1936', 33, NULL, NULL),
(198, '1937', '1937', '1937', 33, NULL, NULL),
(199, '1938', '1938', '1938', 33, NULL, NULL),
(200, '1939', '1939', '1939', 33, NULL, NULL),
(201, '1940', '1940', '1940', 33, NULL, NULL),
(202, '1941', '1941', '1941', 33, NULL, NULL),
(203, '1942', '1942', '1942', 33, NULL, NULL),
(204, '1943', '1943', '1943', 33, NULL, NULL),
(205, '1944', '1944', '1944', 33, NULL, NULL),
(206, '1945', '1945', '1945', 33, NULL, NULL),
(207, '1946', '1946', '1946', 33, NULL, NULL),
(208, '1947', '1947', '1947', 33, NULL, NULL),
(209, '1948', '1948', '1948', 33, NULL, NULL),
(210, '1949', '1949', '1949', 33, NULL, NULL),
(211, '1950', '1950', '1950', 33, NULL, NULL),
(212, '1951', '1951', '1951', 33, NULL, NULL),
(213, '1952', '1952', '1952', 33, NULL, NULL),
(214, '1953', '1953', '1953', 33, NULL, NULL),
(215, '1954', '1954', '1954', 33, NULL, NULL),
(216, '1955', '1955', '1955', 33, NULL, NULL),
(217, '1956', '1956', '1956', 33, NULL, NULL),
(218, '1957', '1957', '1957', 33, NULL, NULL),
(219, '1958', '1958', '1958', 33, NULL, NULL),
(220, '1959', '1959', '1959', 33, NULL, NULL),
(221, '1960', '1960', '1960', 33, NULL, NULL),
(222, '1961', '1961', '1961', 33, NULL, NULL),
(223, '1962', '1962', '1962', 33, NULL, NULL),
(224, '1963', '1963', '1963', 33, NULL, NULL),
(225, '1964', '1964', '1964', 33, NULL, NULL),
(226, '1965', '1965', '1965', 33, NULL, NULL),
(227, '1966', '1966', '1966', 33, NULL, NULL),
(228, '1967', '1967', '1967', 33, NULL, NULL),
(229, '1968', '1968', '1968', 33, NULL, NULL),
(230, '1969', '1969', '1969', 33, NULL, NULL),
(231, '1970', '1970', '1970', 33, NULL, NULL),
(232, '1971', '1971', '1971', 33, NULL, NULL),
(233, '1972', '1972', '1972', 33, NULL, NULL),
(234, '1973', '1973', '1973', 33, NULL, NULL),
(235, '1974', '1974', '1974', 33, NULL, NULL),
(236, '1975', '1975', '1975', 33, NULL, NULL),
(237, '1976', '1976', '1976', 33, NULL, NULL),
(238, '1977', '1977', '1977', 33, NULL, NULL),
(239, '1978', '1978', '1978', 33, NULL, NULL),
(240, '1979', '1979', '1979', 33, NULL, NULL),
(241, '1980', '1980', '1980', 33, NULL, NULL),
(242, '1981', '1981', '1981', 33, NULL, NULL),
(243, '1982', '1982', '1982', 33, NULL, NULL),
(244, '1983', '1983', '1983', 33, NULL, NULL),
(245, '1984', '1984', '1984', 33, NULL, NULL),
(246, '1985', '1985', '1985', 33, NULL, NULL),
(247, '1986', '1986', '1986', 33, NULL, NULL),
(248, '1987', '1987', '1987', 33, NULL, NULL),
(249, '1988', '1988', '1988', 33, NULL, NULL),
(250, '1989', '1989', '1989', 33, NULL, NULL),
(251, '1990', '1990', '1990', 33, NULL, NULL),
(252, '1991', '1991', '1991', 33, NULL, NULL),
(253, '1992', '1992', '1992', 33, NULL, NULL),
(254, '1993', '1993', '1993', 33, NULL, NULL),
(255, '1994', '1994', '1994', 33, NULL, NULL),
(256, '1995', '1995', '1995', 33, NULL, NULL),
(257, '1996', '1996', '1996', 33, NULL, NULL),
(258, '1997', '1997', '1997', 33, NULL, NULL),
(259, '1998', '1998', '1998', 33, NULL, NULL),
(260, '1999', '1999', '1999', 33, NULL, NULL),
(261, '2000', '2000', '2000', 33, NULL, NULL),
(262, '2001', '2001', '2001', 33, NULL, NULL),
(263, '2002', '2002', '2002', 33, NULL, NULL),
(264, '2003', '2003', '2003', 33, NULL, NULL),
(265, '2004', '2004', '2004', 33, NULL, NULL),
(266, '2005', '2005', '2005', 33, NULL, NULL),
(267, '2006', '2006', '2006', 33, NULL, NULL),
(268, '2007', '2007', '2007', 33, NULL, NULL),
(269, '2008', '2008', '2008', 33, NULL, NULL),
(270, '2009', '2009', '2009', 33, NULL, NULL),
(271, '2010', '2010', '2010', 33, NULL, NULL),
(272, '2011', '2011', '2011', 33, NULL, NULL),
(273, '2012', '2012', '2012', 33, NULL, NULL),
(274, '2013', '2013', '2013', 33, NULL, NULL),
(275, '2014', '2014', '2014', 33, NULL, NULL),
(276, '2015', '2015', '2015', 33, NULL, NULL),
(277, '2016', '2016', '2016', 33, NULL, NULL),
(278, '2017', '2017', '2017', 33, NULL, NULL),
(279, '2018', '2018', '2018', 33, NULL, NULL),
(280, '2019', '2019', '2019', 33, NULL, NULL),
(281, '2020', '2020', '2020', 33, NULL, NULL),
(282, '2021', '2021', '2021', 33, NULL, NULL),
(283, '2022', '2022', '2022', 33, NULL, NULL),
(284, '2023', '2023', '2023', 33, NULL, NULL),
(285, '2024', '2024', '2024', 33, NULL, NULL),
(286, '1', '1', '1', 39, NULL, NULL),
(287, '2', '2', '2', 39, NULL, NULL),
(288, '3', '3', '3', 39, NULL, NULL),
(289, '4', '4', '4', 39, NULL, NULL),
(290, '5', '5', '5', 39, NULL, NULL),
(291, '6', '6', '6', 39, NULL, NULL),
(292, '7', '7', '7', 39, NULL, NULL),
(293, '8', '8', '8', 39, NULL, NULL),
(294, '9', '9', '9', 39, NULL, NULL),
(295, '10', '10', '10', 39, NULL, NULL),
(296, '11', '11', '11', 39, NULL, NULL),
(297, '12', '12', '12', 39, NULL, NULL),
(298, '13', '13', '13', 39, NULL, NULL),
(299, '14', '14', '14', 39, NULL, NULL),
(300, '15', '15', '15', 39, NULL, NULL),
(301, '16', '16', '16', 39, NULL, NULL),
(302, '17', '17', '17', 39, NULL, NULL),
(303, '18', '18', '18', 39, NULL, NULL),
(304, '19', '19', '19', 39, NULL, NULL),
(305, '20', '20', '20', 39, NULL, NULL),
(306, '21', '21', '21', 39, NULL, NULL),
(307, '22', '22', '22', 39, NULL, NULL),
(308, '23', '23', '23', 39, NULL, NULL),
(309, '24', '24', '24', 39, NULL, NULL),
(310, '25', '25', '25', 39, NULL, NULL),
(311, '26', '26', '26', 39, NULL, NULL),
(312, '27', '27', '27', 39, NULL, NULL),
(313, '28', '28', '28', 39, NULL, NULL),
(314, '29', '29', '29', 39, NULL, NULL),
(315, '30', '30', '30', 39, NULL, NULL),
(316, '31', '31', '31', 39, NULL, NULL),
(317, '32', '32', '32', 39, NULL, NULL),
(318, '33', '33', '33', 39, NULL, NULL),
(319, '34', '34', '34', 39, NULL, NULL),
(320, '35', '35', '35', 39, NULL, NULL),
(321, '36', '36', '36', 39, NULL, NULL),
(322, '37', '37', '37', 39, NULL, NULL),
(323, '38', '38', '38', 39, NULL, NULL),
(324, '39', '39', '39', 39, NULL, NULL),
(325, '40', '40', '40', 39, NULL, NULL),
(326, '41', '41', '41', 39, NULL, NULL),
(327, '42', '42', '42', 39, NULL, NULL),
(328, '43', '43', '43', 39, NULL, NULL),
(329, '44', '44', '44', 39, NULL, NULL),
(330, '45', '45', '45', 39, NULL, NULL),
(331, '46', '46', '46', 39, NULL, NULL),
(332, '47', '47', '47', 39, NULL, NULL),
(333, '48', '48', '48', 39, NULL, NULL),
(334, '49', '49', '49', 39, NULL, NULL),
(335, '50', '50', '50', 39, NULL, NULL),
(336, 'New', 'جديد', 'Nouveau', 1, NULL, NULL),
(337, 'Used- Perfect', 'مستعمل - مثالي', 'Utilisé - Parfait', 1, NULL, NULL),
(338, 'Used- Good', 'مستعمل - جيد', 'Utilisé - Bon', 1, NULL, NULL),
(339, 'Used- Not working', 'مستعمل - غير يعمل', 'Utilisé - Ne fonctionne pas', 1, NULL, NULL),
(340, 'Sorted', 'مرتب', 'Trier', 2, NULL, NULL),
(341, 'Under sorting', 'تحت الترتيب', 'En cours de tri', 2, NULL, NULL),
(342, 'Not sorted', 'غير مرتب', 'Non trié', 2, NULL, NULL),
(343, 'Yes', 'نعم', 'Oui', 3, NULL, NULL),
(344, 'No', 'لا', 'Non', 3, NULL, NULL),
(345, '1', '1', '1', 4, NULL, NULL),
(346, '2', '2', '2', 4, NULL, NULL),
(347, '3', '3', '3', 4, NULL, NULL),
(348, '4', '4', '4', 4, NULL, NULL),
(349, 'Cash', 'نقدًا', 'Espèces', 5, NULL, NULL),
(350, 'Installment 1year', 'تقسيط 1 سنة', 'Paiement échelonné sur 1 an', 5, NULL, NULL),
(351, 'Installment 2years', 'تقسيط 2 سنة', 'Paiement échelonné sur 2 ans', 5, NULL, NULL),
(352, 'Installment 3years', 'تقسيط 3 سنة', 'Paiement échelonné sur 3 ans', 5, NULL, NULL),
(353, 'Installment 4years', 'تقسيط 4 سنة', 'Paiement échelonné sur 4 ans', 5, NULL, NULL),
(354, 'Installment 5years', 'تقسيط 5 سنة', 'Paiement échelonné sur 5 ans', 5, NULL, NULL),
(355, 'Installment over 5years', 'تقسيط أكثر من 5 سنوات', 'Paiement échelonné sur plus de 5 ans', 5, NULL, NULL),
(356, 'Furnished', 'مفروشة', 'Meublé', 6, NULL, NULL),
(357, 'Semi Furnished', 'نصف مفروشة', 'Semi-meublé', 6, NULL, NULL),
(358, 'Not Furnished', 'غير مفروشة', 'Non meublé', 6, NULL, NULL),
(359, '1', '1', '1', 7, NULL, NULL),
(360, '2', '2', '2', 7, NULL, NULL),
(361, '3', '3', '3', 7, NULL, NULL),
(362, '4', '4', '4', 7, NULL, NULL),
(363, '5', '5', '5', 7, NULL, NULL),
(364, '6', '6', '6', 7, NULL, NULL),
(365, '7', '7', '7', 7, NULL, NULL),
(366, '8', '8', '8', 7, NULL, NULL),
(367, '9', '9', '9', 7, NULL, NULL),
(368, '10', '10', '10', 7, NULL, NULL),
(369, 'Not applicable', 'غير مطبق', 'Non applicable', 7, NULL, NULL),
(370, '1', '1', '1', 8, NULL, NULL),
(371, '2', '2', '2', 8, NULL, NULL),
(372, '3', '3', '3', 8, NULL, NULL),
(373, '4', '4', '4', 8, NULL, NULL),
(374, '5', '5', '5', 8, NULL, NULL),
(375, '6', '6', '6', 8, NULL, NULL),
(376, '7', '7', '7', 8, NULL, NULL),
(377, '8', '8', '8', 8, NULL, NULL),
(378, 'Not applicable', 'غير مطبق', 'Non applicable', 8, NULL, NULL),
(379, 'Fully Finished', 'تشطيب كامل', 'Entièrement fini', 9, NULL, NULL),
(380, 'Semi-Finished', 'تشطيب نصفي', 'Semi-finis', 9, NULL, NULL),
(381, 'Core & Shell', 'أساسي وهيكل', 'Noyau et structure', 9, NULL, NULL),
(382, 'Commercial', 'تجاري', 'Commercial', 10, NULL, NULL),
(383, 'Residential', 'سكني', 'Résidentiel', 10, NULL, NULL),
(384, 'CMC', 'سي إم سي', 'CMC', 11, NULL, NULL),
(385, 'Geely', 'جيلي', 'Geely', 11, NULL, NULL),
(386, 'Changan Auto', 'شانجان أوتو', 'Changan Auto', 11, NULL, NULL),
(387, 'GAC', 'جي أي سي', 'GAC', 11, NULL, NULL),
(388, 'Bugatti', 'بوغاتي', 'Bugatti', 11, NULL, NULL),
(389, 'Great Wall', 'جريت وول', 'Great Wall', 11, NULL, NULL),
(390, 'Ashok', 'أشوك', 'Ashok', 11, NULL, NULL),
(391, 'Daewoo', 'ديو', 'Daewoo', 11, NULL, NULL),
(392, 'Opel', 'أوبل', 'Opel', 11, NULL, NULL),
(393, 'Alfa Romeo', 'ألفا روميو', 'Alfa Romeo', 11, NULL, NULL),
(394, 'Vanderhall', 'فاندرهال', 'Vanderhall', 11, NULL, NULL),
(395, 'King Long', 'كينج لونج', 'King Long', 11, NULL, NULL),
(396, 'ZXauto', 'زد إكس أوتو', 'ZXauto', 11, NULL, NULL),
(397, 'Pontiac', 'بونتياك', 'Pontiac', 11, NULL, NULL),
(398, 'McLaren', 'ماكلارين', 'McLaren', 11, NULL, NULL),
(399, 'MayBach', 'مايباخ', 'MayBach', 11, NULL, NULL),
(400, 'Foton', 'فوتون', 'Foton', 11, NULL, NULL),
(401, 'Buick', 'بويك', 'Buick', 11, NULL, NULL),
(402, 'Lotus', 'لوتس', 'Lotus', 11, NULL, NULL),
(403, 'Borgward', 'بورجوارد', 'Borgward', 11, NULL, NULL),
(404, 'BAIC', 'بي أي سي', 'BAIC', 11, NULL, NULL),
(405, 'Lamborghini', 'لامبورغيني', 'Lamborghini', 11, NULL, NULL),
(406, 'Genesis', 'جينيسيس', 'Genesis', 11, NULL, NULL),
(407, 'Smart', 'سمارت', 'Smart', 11, NULL, NULL),
(408, 'Ferrari', 'فيراري', 'Ferrari', 11, NULL, NULL),
(409, 'Datsun', 'داتسون', 'Datsun', 11, NULL, NULL),
(410, 'Aston Marti', 'أستون مارتن', 'Aston Marti', 11, NULL, NULL),
(411, 'Lincoln', 'لينكولن', 'Lincoln', 11, NULL, NULL),
(412, 'TATA', 'تاتا', 'TATA', 11, NULL, NULL),
(413, 'SSangyong', 'سانغيونغ', 'SSangyong', 11, NULL, NULL),
(414, 'Great Wall', 'جريت وول', 'Great Wall', 11, NULL, NULL),
(415, 'Citroen', 'سيتروين', 'Citroen', 11, NULL, NULL),
(416, 'Rolls Royce', 'رولز رويس', 'Rolls Royce', 11, NULL, NULL),
(417, 'Proton', 'بروتون', 'Proton', 11, NULL, NULL),
(418, 'Daihatsu', 'دايهاتسو', 'Daihatsu', 11, NULL, NULL),
(419, 'Seat', 'سيات', 'Seat', 11, NULL, NULL),
(420, 'Fiat', 'فيات', 'Fiat', 11, NULL, NULL),
(421, 'Skoda', 'سكودا', 'Skoda', 11, NULL, NULL),
(422, 'Maserati', 'مازيراتي', 'Maserati', 11, NULL, NULL),
(423, 'Chrysler', 'كرايسلر', 'Chrysler', 11, NULL, NULL),
(424, 'Tesla', 'تسلا', 'Tesla', 11, NULL, NULL),
(425, 'Jaguar', 'جاكوار', 'Jaguar', 11, NULL, NULL),
(426, 'JAC', 'جاك', 'JAC', 11, NULL, NULL),
(427, 'Bentley', 'بنتلي', 'Bentley', 11, NULL, NULL),
(428, 'Classic cars', 'سيارات كلاسيكية', 'Classic cars', 11, NULL, NULL),
(429, 'Subaru', 'سوبارو', 'Subaru ', 11, NULL, NULL),
(430, 'MG', 'إم جي', 'MG', 11, NULL, NULL),
(431, 'Hummer', 'همر', 'Hummer', 11, NULL, NULL),
(432, 'Volvo', 'فولفو', 'Volvo', 11, NULL, NULL),
(433, 'Range Rover', 'رينج روفر', 'Range Rover', 11, NULL, NULL),
(434, 'Peugeot', 'بيجو', 'Peugeot', 11, NULL, NULL),
(435, 'Isuzu', 'ايسوزو', 'Isuzu', 11, NULL, NULL),
(436, 'Chery', 'شيري', 'Chery', 11, NULL, NULL),
(437, 'Mazda', 'مازدا', 'Mazda', 11, NULL, NULL),
(438, 'Mini', 'ميني', 'Mini', 11, NULL, NULL),
(439, 'Infinity', 'انفينيتي', 'Infinity', 11, NULL, NULL),
(440, 'Audi', 'أودي', 'Audi', 11, NULL, NULL),
(441, 'Cadillac', 'كاديلاك', 'Cadillac', 11, NULL, NULL),
(442, 'Porsche', 'بورش', 'Porsche', 11, NULL, NULL),
(443, 'Renault', 'رينو', 'Renault', 11, NULL, NULL),
(444, 'Hyundai', 'هيونداي', 'Hyundai', 11, NULL, NULL),
(445, 'Dodge', 'دودج', 'Dodge', 11, NULL, NULL),
(446, 'Jeep', 'جيب', 'Jeep', 11, NULL, NULL),
(447, 'Volkswagen', 'فولكس واجن', 'Volkswagen', 11, NULL, NULL),
(448, 'Suzuki', 'سوزوكي', 'Suzuki', 11, NULL, NULL),
(449, 'Land rover', 'لاند روفر', 'Land Rover', 11, NULL, NULL),
(450, 'Honda', 'هوندا', 'Honda', 11, NULL, NULL),
(451, 'Bmw', 'بي إم دبليو', 'BMW', 11, NULL, NULL),
(452, 'Kia', 'كيا', 'Kia', 11, NULL, NULL),
(453, 'Ford', 'فورد', 'Ford', 11, NULL, NULL),
(454, 'Lexus', 'لكزس', 'Lexus', 11, NULL, NULL),
(455, 'Mercedes Benz', 'مرسيدس بنز', 'Mercedes-Benz', 11, NULL, NULL),
(456, 'Gmc', 'جي أم سي', 'GMC', 11, NULL, NULL),
(457, 'Mitsubishi', 'ميتسوبيشي', 'Mitsubishi', 11, NULL, NULL),
(458, 'Chevrolet', 'شفروليه', 'Chevrolet', 11, NULL, NULL),
(459, 'Nissan', 'نيسان', 'Nissan', 11, NULL, NULL),
(460, 'Toyota', 'تويوتا', 'Toyota', 11, NULL, NULL),
(461, 'Automatic', 'أوتوماتيكي', 'Automatique', 12, NULL, NULL),
(462, 'Manual', 'يدوي', 'Manuel', 12, NULL, NULL),
(463, 'Tiptronic', 'تيبترونيك', 'Tiptronic', 12, NULL, NULL),
(464, 'White', 'أبيض', 'Blanc', 13, NULL, NULL),
(465, 'Red', 'أحمر', 'Rouge', 13, NULL, NULL),
(466, 'Green', 'أخضر', 'Vert', 13, NULL, NULL),
(467, 'Blue', 'أزرق', 'Bleu', 13, NULL, NULL),
(468, 'Black', 'أسود', 'Noir', 13, NULL, NULL),
(469, 'Yellow', 'أصفر', 'Jaune', 13, NULL, NULL),
(470, 'Orange', 'برتقالي', 'Orange', 13, NULL, NULL),
(471, 'Brown', 'بني', 'Marron', 13, NULL, NULL),
(472, 'Beige', 'بيج', 'Beige', 13, NULL, NULL),
(473, 'Gold', 'ذهبي', 'Or', 13, NULL, NULL),
(474, 'Gray', 'رمادي', 'Gris', 13, NULL, NULL),
(475, 'Silver', 'فضي', 'Argent', 13, NULL, NULL),
(476, 'Dark blue', 'أزرق غامق', 'Bleu foncé', 13, NULL, NULL),
(477, 'Mocha', 'موكا', 'Moka', 13, NULL, NULL),
(478, 'Maroon', 'مارون', 'Marron', 13, NULL, NULL),
(479, 'Other', 'آخر', 'Autre', 13, NULL, NULL),
(480, '4', '4', '4', 14, NULL, NULL),
(481, '5', '5', '5', 14, NULL, NULL),
(482, '6', '6', '6', 14, NULL, NULL),
(483, '8', '8', '8', 14, NULL, NULL),
(484, '10', '10', '10', 14, NULL, NULL),
(485, '12', '12', '12', 14, NULL, NULL),
(486, '16', '16', '16', 14, NULL, NULL),
(487, 'Gasoline', 'بنزين', 'Essence', 15, NULL, NULL),
(488, 'Diesel', 'ديزل', 'Diesel', 15, NULL, NULL),
(489, 'Electric', 'كهربائي', 'Électrique', 15, NULL, NULL),
(490, 'Hybrid', 'هجين', 'Hybride', 15, NULL, NULL),
(491, 'Natural Gas', 'غاز طبيعي', 'Gaz naturel', 15, NULL, NULL),
(492, '1000 cc', '1000 سي سي', '1000 cc', 16, NULL, NULL),
(493, '1100 cc', '1100 سي سي', '1100 cc', 16, NULL, NULL),
(494, '1200 cc', '1200 سي سي', '1200 cc', 16, NULL, NULL),
(495, '1300 cc', '1300 سي سي', '1300 cc', 16, NULL, NULL),
(496, '1400 cc', '1400 سي سي', '1400 cc', 16, NULL, NULL),
(497, '1500 cc', '1500 سي سي', '1500 cc', 16, NULL, NULL),
(498, '1600 cc', '1600 سي سي', '1600 cc', 16, NULL, NULL),
(499, '1700 cc', '1700 سي سي', '1700 cc', 16, NULL, NULL),
(500, '1800 cc', '1800 سي سي', '1800 cc', 16, NULL, NULL),
(501, '1900 cc', '1900 سي سي', '1900 cc', 16, NULL, NULL),
(502, '2000 cc', '2000 سي سي', '2000 cc', 16, NULL, NULL),
(503, '2200 cc', '2200 سي سي', '2200 cc', 16, NULL, NULL),
(504, '2400 cc', '2400 سي سي', '2400 cc', 16, NULL, NULL),
(505, '2500 cc', '2500 سي سي', '2500 cc', 16, NULL, NULL),
(506, '2600 cc', '2600 سي سي', '2600 cc', 16, NULL, NULL),
(507, '2700 cc', '2700 سي سي', '2700 cc', 16, NULL, NULL),
(508, '2800 cc', '2800 سي سي', '2800 cc', 16, NULL, NULL),
(509, '2900 cc', '2900 سي سي', '2900 cc', 16, NULL, NULL),
(510, '3000 cc', '3000 سي سي', '3000 cc', 16, NULL, NULL),
(511, '3100 cc', '3100 سي سي', '3100 cc', 16, NULL, NULL),
(512, '3200 cc', '3200 سي سي', '3200 cc', 16, NULL, NULL),
(513, '3300 cc', '3300 سي سي', '3300 cc', 16, NULL, NULL),
(514, '3400 cc', '3400 سي سي', '3400 cc', 16, NULL, NULL),
(515, '3500 cc', '3500 سي سي', '3500 cc', 16, NULL, NULL),
(516, '3600 cc', '3600 سي سي', '3600 cc', 16, NULL, NULL),
(517, '3700 cc', '3700 سي سي', '3700 cc', 16, NULL, NULL),
(518, '3800 cc', '3800 سي سي', '3800 cc', 16, NULL, NULL),
(519, '3900 cc', '3900 سي سي', '3900 cc', 16, NULL, NULL),
(520, '4000 cc', '4000 سي سي', '4000 cc', 16, NULL, NULL),
(521, '4100 cc', '4100 سي سي', '4100 cc', 16, NULL, NULL),
(522, '4200 cc', '4200 سي سي', '4200 cc', 16, NULL, NULL),
(523, '4300 cc', '4300 سي سي', '4300 cc', 16, NULL, NULL),
(524, '4400 cc', '4400 سي سي', '4400 cc', 16, NULL, NULL),
(525, '4500 cc', '4500 سي سي', '4500 cc', 16, NULL, NULL),
(526, '4600 cc', '4600 سي سي', '4600 cc', 16, NULL, NULL),
(527, '4700 cc', '4700 سي سي', '4700 cc', 16, NULL, NULL),
(528, '4800 cc', '4800 سي سي', '4800 cc', 16, NULL, NULL),
(529, '4900 cc', '4900 سي سي', '4900 cc', 16, NULL, NULL),
(530, '5000 cc', '5000 سي سي', '5000 cc', 16, NULL, NULL),
(531, '5100 cc', '5100 سي سي', '5100 cc', 16, NULL, NULL),
(532, '5200 cc', '5200 سي سي', '5200 cc', 16, NULL, NULL),
(533, '5700 cc', '5700 سي سي', '5700 cc', 16, NULL, NULL),
(534, '5800 cc', '5800 سي سي', '5800 cc', 16, NULL, NULL),
(535, '5900 cc', '5900 سي سي', '5900 cc', 16, NULL, NULL),
(536, '6000 cc', '6000 سي سي', '6000 cc', 16, NULL, NULL),
(537, '6100 cc', '6100 سي سي', '6100 cc', 16, NULL, NULL),
(538, '6200 cc', '6200 سي سي', '6200 cc', 16, NULL, NULL),
(539, '6500 cc', '6500 سي سي', '6500 cc', 16, NULL, NULL),
(540, '6600 cc', '6600 سي سي', '6600 cc', 16, NULL, NULL),
(541, '6900 cc', '6900 سي سي', '6900 cc', 16, NULL, NULL),
(542, '7000 cc', '7000 سي سي', '7000 cc', 16, NULL, NULL),
(543, '7400 cc', '7400 سي سي', '7400 cc', 16, NULL, NULL),
(544, '7500 cc', '7500 سي سي', '7500 cc', 16, NULL, NULL),
(545, '7600 cc', '7600 سي سي', '7600 cc', 16, NULL, NULL),
(546, '7700 cc', '7700 سي سي', '7700 cc', 16, NULL, NULL),
(547, '8100 cc', '8100 سي سي', '8100 cc', 16, NULL, NULL),
(548, '8200 cc', '8200 سي سي', '8200 cc', 16, NULL, NULL),
(549, '8600 cc', '8600 سي سي', '8600 cc', 16, NULL, NULL),
(550, '9000 cc', '9000 سي سي', '9000 cc', 16, NULL, NULL),
(551, '9300 cc', '9300 سي سي', '9300 cc', 16, NULL, NULL),
(552, '10000 cc', '10000 سي سي', '10000 cc', 16, NULL, NULL),
(553, '10400 cc', '10400 سي سي', '10400 cc', 16, NULL, NULL),
(554, '11000 cc', '11000 سي سي', '11000 cc', 16, NULL, NULL),
(555, '11500 cc', '11500 سي سي', '11500 cc', 16, NULL, NULL),
(556, '12000 cc', '12000 سي سي', '12000 cc', 16, NULL, NULL),
(557, '12100 cc', '12100 سي سي', '12100 cc', 16, NULL, NULL),
(558, '13900 cc', '13900 سي سي', '13900 cc', 16, NULL, NULL),
(559, '14000 cc', '14000 سي سي', '14000 cc', 16, NULL, NULL),
(560, '14100 cc', '14100 سي سي', '14100 cc', 16, NULL, NULL),
(561, '14600 cc', '14600 سي سي', '14600 cc', 16, NULL, NULL),
(562, '14800 cc', '14800 سي سي', '14800 cc', 16, NULL, NULL),
(563, '15100 cc', '15100 سي سي', '15100 cc', 16, NULL, NULL),
(564, '15200 cc', '15200 سي سي', '15200 cc', 16, NULL, NULL),
(565, '18000 cc', '18000 سي سي', '18000 cc', 16, NULL, NULL),
(566, '18800 cc', '18800 سي سي', '18800 cc', 16, NULL, NULL),
(567, 'New', 'جديد', 'Neuf', 17, NULL, NULL),
(568, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 17, NULL, NULL),
(569, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon état', 17, NULL, NULL),
(570, 'Used- Not working', 'مستعمل - لا يعمل', 'Occasion - Défectueux', 17, NULL, NULL),
(571, 'Yes', 'نعم', 'Oui', 18, NULL, NULL),
(572, 'No', 'لا', 'Non', 18, NULL, NULL),
(573, 'Less than 50', 'أقل من 50', 'Moins de 50', 20, NULL, NULL),
(574, '50 - 100', '50 - 100', '50 - 100', 20, NULL, NULL),
(575, '101 - 150', '101 - 150', '101 - 150', 20, NULL, NULL),
(576, '151 - 200', '151 - 200', '151 - 200', 20, NULL, NULL),
(577, '201 - 250', '201 - 250', '201 - 250', 20, NULL, NULL),
(578, '251 - 300', '251 - 300', '251 - 300', 20, NULL, NULL),
(579, '301 - 350', '301 - 350', '301 - 350', 20, NULL, NULL),
(580, '351 - 400', '351 - 400', '351 - 400', 20, NULL, NULL),
(581, 'more than 400', 'أكثر من 400', 'Plus de 400', 20, NULL, NULL),
(582, 'New', 'جديد', 'Neuf', 21, NULL, NULL),
(583, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 21, NULL, NULL),
(584, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon état', 21, NULL, NULL),
(585, 'Used- Not working', 'مستعمل - لا يعمل', 'Occasion - Défectueux', 21, NULL, NULL),
(586, 'Automatic', 'أوتوماتيكي', 'Automatique', 22, NULL, NULL),
(587, 'Manual', 'يدوي', 'Manuel', 22, NULL, NULL),
(588, '250cc or less', '250 سي سي أو أقل', '250cc ou moins', 23, NULL, NULL),
(589, '251- 500cc', '251- 500 سي سي', '251- 500cc', 23, NULL, NULL),
(590, '501- 600cc', '501- 600 سي سي', '501- 600cc', 23, NULL, NULL),
(591, '601- 750cc', '601- 750 سي سي', '601- 750cc', 23, NULL, NULL),
(592, '751- 1000cc', '751- 1000 سي سي', '751- 1000cc', 23, NULL, NULL),
(593, '1001- 1250cc', '1001- 1250 سي سي', '1001- 1250cc', 23, NULL, NULL),
(594, '1251- 1500cc', '1251- 1500 سي سي', '1251- 1500cc', 23, NULL, NULL),
(595, '1501-1750cc', '1501-1750 سي سي', '1501-1750cc', 23, NULL, NULL),
(596, '1751- 2000cc', '1751- 2000 سي سي', '1751- 2000cc', 23, NULL, NULL),
(597, '2001- 2500cc', '2001- 2500 سي سي', '2001- 2500cc', 23, NULL, NULL),
(598, '2501- 3000cc', '2501- 3000 سي سي', '2501- 3000cc', 23, NULL, NULL),
(599, 'Over 3000cc', 'أكثر من 3000 سي سي', 'Plus de 3000cc', 23, NULL, NULL),
(600, '1- 25hp', '1- 25 حصان', '1- 25 ch', 24, NULL, NULL),
(601, '26- 50hp', '26- 50 حصان', '26- 50 ch', 24, NULL, NULL),
(602, '51- 75hp', '51- 75 حصان', '51- 75 ch', 24, NULL, NULL),
(603, '76- 100hp', '76- 100 حصان', '76- 100 ch', 24, NULL, NULL),
(604, '101- 125hp', '101- 125 حصان', '101- 125 ch', 24, NULL, NULL),
(605, '126- 150hp', '126- 150 حصان', '126- 150 ch', 24, NULL, NULL),
(606, '151- 175hp', '151- 175 حصان', '151- 175 ch', 24, NULL, NULL),
(607, 'Over 200hp', 'أكثر من 200 حصان', 'Plus de 200 ch', 24, NULL, NULL),
(608, 'Less than 50', 'أقل من 50', 'Moins de 50', 26, NULL, NULL),
(609, '50 - 100', '50 - 100', '50 - 100', 26, NULL, NULL),
(610, '101 - 150', '101 - 150', '101 - 150', 26, NULL, NULL),
(611, '151 - 200', '151 - 200', '151 - 200', 26, NULL, NULL),
(612, '201 - 250', '201 - 250', '201 - 250', 26, NULL, NULL),
(613, '251 - 300', '251 - 300', '251 - 300', 26, NULL, NULL),
(614, '301 - 350', '301 - 350', '301 - 350', 26, NULL, NULL),
(615, '351 - 400', '351 - 400', '351 - 400', 26, NULL, NULL),
(616, 'more than 400', 'أكثر من 400', 'Plus de 400', 26, NULL, NULL),
(617, 'New', 'جديد', 'Neuf', 27, NULL, NULL),
(618, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 27, NULL, NULL),
(619, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon état', 27, NULL, NULL),
(620, 'Used- Not working', 'مستعمل - لا يعمل', 'Occasion - Non fonctionnel', 27, NULL, NULL),
(621, 'Original', 'أصلي', 'Original', 28, NULL, NULL),
(622, 'Copy', 'نسخة', 'Copie', 28, NULL, NULL),
(623, 'UNITED STATES', 'الولايات المتحدة', 'ÉTATS-UNIS', 29, NULL, NULL),
(624, 'GERMANY', 'ألمانيا', 'ALLEMAGNE', 29, NULL, NULL),
(625, 'UNITED KINGDOM', 'المملكة المتحدة', 'ROYAUME-UNI', 29, NULL, NULL),
(626, 'JAPAN', 'اليابان', 'JAPON', 29, NULL, NULL),
(627, 'NIGERIA', 'نيجيريا', 'NIGÉRIA', 29, NULL, NULL),
(628, 'RUSSIA', 'روسيا', 'RUSSIE', 29, NULL, NULL),
(629, 'FRANCE', 'فرنسا', 'FRANCE', 29, NULL, NULL),
(630, 'CHINA', 'الصين', 'CHINE', 29, NULL, NULL),
(631, 'SWEDEN', 'السويد', 'SUÈDE', 29, NULL, NULL),
(632, 'SOUTH KOREA', 'كوريا الجنوبية', 'CORÉE DU SUD', 29, NULL, NULL),
(633, 'MALAYSIA', 'ماليزيا', 'MALAISIE', 29, NULL, NULL),
(634, 'QATAR', 'قطر', 'QATAR', 29, NULL, NULL),
(635, 'Goodyear', 'جوديير', 'Goodyear', 30, NULL, NULL),
(636, 'Bridgestone', 'بريدجستون', 'Bridgestone', 30, NULL, NULL),
(637, 'Firestone', 'فايرستون', 'Firestone', 30, NULL, NULL),
(638, 'Hankook', 'هانكوك', 'Hankook', 30, NULL, NULL),
(639, 'Pirelli', 'بيريللي', 'Pirelli', 30, NULL, NULL),
(640, 'Yokohama', 'يوكوهاما', 'Yokohama', 30, NULL, NULL),
(641, 'Gt', 'جي تي', 'Gt', 30, NULL, NULL),
(642, 'Tatko', 'تاتكو', 'Tatko', 30, NULL, NULL),
(643, 'Sumitomo', 'سوميتومو', 'Sumitomo', 30, NULL, NULL),
(644, 'Starmaxx', 'ستارماكس', 'Starmaxx', 30, NULL, NULL),
(645, 'Kumho', 'كومهو', 'Kumho', 30, NULL, NULL),
(646, 'Genuine', 'أصلي', 'Authentique', 30, NULL, NULL),
(647, 'Michelin', 'ميشلان', 'Michelin', 30, NULL, NULL),
(648, 'Dunlop', 'دنلوب', 'Dunlop', 30, NULL, NULL),
(649, 'Wagner', 'واجنر', 'Wagner', 30, NULL, NULL),
(650, 'Roadstone', 'روودستون', 'Roadstone', 30, NULL, NULL),
(651, 'Goodride', 'جودرايد', 'Goodride', 30, NULL, NULL),
(652, 'Marshal', 'مارشال', 'Marshal', 30, NULL, NULL),
(653, 'Tigar', 'تايجر', 'Tigar', 30, NULL, NULL),
(654, 'Kenda', 'كندا', 'Kenda', 30, NULL, NULL),
(655, 'Boto', 'بوتو', 'Boto', 30, NULL, NULL),
(656, 'Others', 'آخر', 'Autres', 30, NULL, NULL),
(657, 'New', 'جديد', 'Neuf', 31, NULL, NULL),
(658, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 31, NULL, NULL),
(659, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 31, NULL, NULL),
(660, 'Used- Not working', 'مستعمل - غير صالح للعمل', 'Occasion - Ne fonctionne pas', 31, NULL, NULL),
(661, 'New', 'جديد', 'Neuf', 32, NULL, NULL),
(662, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 32, NULL, NULL),
(663, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 32, NULL, NULL),
(664, 'Used- Not working', 'مستعمل - غير صالح للعمل', 'Occasion - Ne fonctionne pas', 32, NULL, NULL),
(665, 'Split', 'منفصل', 'Split', 34, NULL, NULL),
(666, 'Window', 'نافذة', 'Fenêtre', 34, NULL, NULL),
(667, 'Central air conditioning', 'تكييف مركزي', 'Climatisation centrale', 34, NULL, NULL),
(668, 'New', 'جديد', 'Neuf', 35, NULL, NULL),
(669, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 35, NULL, NULL),
(670, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 35, NULL, NULL),
(671, 'Used- Not working', 'مستعمل - غير صالح للعمل', 'Occasion - Ne fonctionne pas', 35, NULL, NULL),
(672, 'Yes', 'نعم', 'Oui', 36, NULL, NULL),
(673, 'No', 'لا', 'Non', 36, NULL, NULL),
(674, 'Selling Full Project', 'بيع المشروع بالكامل', 'Vente du projet complet', 37, NULL, NULL),
(675, 'Partnership', 'شراكة', 'Partenariat', 37, NULL, NULL),
(676, 'Investment', 'استثمار', 'Investissement', 37, NULL, NULL),
(677, 'Selling Equipment Only', 'بيع المعدات فقط', 'Vente d\'équipement uniquement', 37, NULL, NULL),
(678, 'Selling Place Only', 'بيع المكان فقط', 'Vente de l\'emplacement uniquement', 37, NULL, NULL),
(679, 'Others', 'آخر', 'Autres', 37, NULL, NULL),
(680, 'Cheques', 'شيكات', 'Chèques', 38, NULL, NULL),
(681, 'Cash', 'نقداً', 'Espèces', 38, NULL, NULL),
(682, 'Installments', 'أقساط', 'Paiements échelonnés', 38, NULL, NULL),
(683, '1K - 4.9K', '1 ألف - 4.9 ألف', '1K - 4.9K', 40, NULL, NULL),
(684, '5K - 9.9K', '5 ألف - 9.9 ألف', '5K - 9.9K', 40, NULL, NULL),
(685, '10K - 14.9K', '10 ألف - 14.9 ألف', '10K - 14.9K', 40, NULL, NULL),
(686, '15K - 19.9K', '15 ألف - 19.9 ألف', '15K - 19.9K', 40, NULL, NULL),
(687, '20K - 24.9K', '20 ألف - 24.9 ألف', '20K - 24.9K', 40, NULL, NULL),
(688, '25K - 29.9K', '25 ألف - 29.9 ألف', '25K - 29.9K', 40, NULL, NULL),
(689, '30K & Above', '30 ألف وأكثر', '30K et plus', 40, NULL, NULL),
(690, '1K - 4.9K', '1 ألف - 4.9 ألف', '1K - 4.9K', 41, NULL, NULL),
(691, '5K - 9.9K', '5 ألف - 9.9 ألف', '5K - 9.9K', 41, NULL, NULL),
(692, '10K - 14.9K', '10 ألف - 14.9 ألف', '10K - 14.9K', 41, NULL, NULL),
(693, '15K - 19.9K', '15 ألف - 19.9 ألف', '15K - 19.9K', 41, NULL, NULL),
(694, '20K - 24.9K', '20 ألف - 24.9 ألف', '20K - 24.9K', 41, NULL, NULL),
(695, '25K - 29.9K', '25 ألف - 29.9 ألف', '25K - 29.9K', 41, NULL, NULL),
(696, '30K - 34.9K', '30 ألف - 34.9 ألف', '30K - 34.9K', 41, NULL, NULL),
(697, '35K - 39.9K', '35 ألف - 39.9 ألف', '35K - 39.9K', 41, NULL, NULL),
(698, '40K - 44.9K', '40 ألف - 44.9 ألف', '40K - 44.9K', 41, NULL, NULL),
(699, '45K - 49.9K', '45 ألف - 49.9 ألف', '45K - 49.9K', 41, NULL, NULL),
(700, '50K - 54.9K', '50 ألف - 54.9 ألف', '50K - 54.9K', 41, NULL, NULL),
(701, '55K - 59.9K', '55 ألف - 59.9 ألف', '55K - 59.9K', 41, NULL, NULL),
(702, '60K - 64.9K', '60 ألف - 64.9 ألف', '60K - 64.9K', 41, NULL, NULL),
(703, '65K - 69.9K', '65 ألف - 69.9 ألف', '65K - 69.9K', 41, NULL, NULL),
(704, '70K - 74.9K', '70 ألف - 74.9 ألف', '70K - 74.9K', 41, NULL, NULL),
(705, '75K - 79.9K', '75 ألف - 79.9 ألف', '75K - 79.9K', 41, NULL, NULL),
(706, '80K - 84.9K', '80 ألف - 84.9 ألف', '80K - 84.9K', 41, NULL, NULL),
(707, '85K - 89.9K', '85 ألف - 89.9 ألف', '85K - 89.9K', 41, NULL, NULL),
(708, '90K - 94.9K', '90 ألف - 94.9 ألف', '90K - 94.9K', 41, NULL, NULL),
(709, '95K - 99.9K', '95 ألف - 99.9 ألف', '95K - 99.9K', 41, NULL, NULL),
(710, '100K & Above', '100 ألف وأكثر', '100K et plus', 41, NULL, NULL),
(711, '10K - 40.9K', '10 ألف - 40.9 ألف', '10K - 40.9K', 42, NULL, NULL),
(712, '50K - 99.9K', '50 ألف - 99.9 ألف', '50K - 99.9K', 42, NULL, NULL),
(713, '100K - 149.9K', '100 ألف - 149.9 ألف', '100K - 149.9K', 42, NULL, NULL),
(714, '150K - 199.9K', '150 ألف - 199.9 ألف', '150K - 199.9K', 42, NULL, NULL),
(715, '200K - 249.9K ', '200 ألف - 249.9 ألف', '200K - 249.9K', 42, NULL, NULL),
(716, '50K - 299.9K', '50 ألف - 299.9 ألف', '50K - 299.9K', 42, NULL, NULL),
(717, '300K - 349.9K', '300 ألف - 349.9 ألف', '300K - 349.9K', 42, NULL, NULL),
(718, '350K - 399.9K', '350 ألف - 399.9 ألف', '350K - 399.9K', 42, NULL, NULL),
(719, '400K - 449.9K', '400 ألف - 449.9 ألف', '400K - 449.9K', 42, NULL, NULL),
(720, '450K - 499.9K', '450 ألف - 499.9 ألف', '450K - 499.9K', 42, NULL, NULL),
(721, '500K - 549.9K', '500 ألف - 549.9 ألف', '500K - 549.9K', 42, NULL, NULL),
(722, '550K - 599.9K', '550 ألف - 599.9 ألف', '550K - 599.9K', 42, NULL, NULL),
(723, '600K - 649.9K', '600 ألف - 649.9 ألف', '600K - 649.9K', 42, NULL, NULL),
(724, '650K - 699.9K', '650 ألف - 699.9 ألف', '650K - 699.9K', 42, NULL, NULL),
(725, '700K - 749.9K', '700 ألف - 749.9 ألف', '700K - 749.9K', 42, NULL, NULL),
(726, '750K - 799.9K', '750 ألف - 799.9 ألف', '750K - 799.9K', 42, NULL, NULL),
(727, '800K - 849.9K', '800 ألف - 849.9 ألف', '800K - 849.9K', 42, NULL, NULL),
(728, '850K - 899.9K', '850 ألف - 899.9 ألف', '850K - 899.9K', 42, NULL, NULL),
(729, '900K - 949.9K', '900 ألف - 949.9 ألف', '900K - 949.9K', 42, NULL, NULL),
(730, '950K - 999.9K', '950 ألف - 999.9 ألف', '950K - 999.9K', 42, NULL, NULL),
(731, '1M & Above', '1 مليون وما فوق', '1M & Above', 42, NULL, NULL),
(732, '10K - 40.9K', '10 ألف - 40.9 ألف', '10K - 40.9K', 43, NULL, NULL),
(733, '50K - 99.9K', '50 ألف - 99.9 ألف', '50K - 99.9K', 43, NULL, NULL),
(734, '100K - 149.9K', '100 ألف - 149.9 ألف', '100K - 149.9K', 43, NULL, NULL),
(735, '150K - 199.9K', '150 ألف - 199.9 ألف', '150K - 199.9K', 43, NULL, NULL),
(736, '200K - 249.9K ', '200 ألف - 249.9 ألف', '200K - 249.9K', 43, NULL, NULL),
(737, '50K - 299.9K', '50 ألف - 299.9 ألف', '50K - 299.9K', 43, NULL, NULL),
(738, '300K - 349.9K', '300 ألف - 349.9 ألف', '300K - 349.9K', 43, NULL, NULL),
(739, '350K - 399.9K', '350 ألف - 399.9 ألف', '350K - 399.9K', 43, NULL, NULL),
(740, '400K - 449.9K', '400 ألف - 449.9 ألف', '400K - 449.9K', 43, NULL, NULL),
(741, '450K - 499.9K', '450 ألف - 499.9 ألف', '450K - 499.9K', 43, NULL, NULL),
(742, '500K - 549.9K', '500 ألف - 549.9 ألف', '500K - 549.9K', 43, NULL, NULL),
(743, '550K - 599.9K', '550 ألف - 599.9 ألف', '550K - 599.9K', 43, NULL, NULL),
(744, '600K - 649.9K', '600 ألف - 649.9 ألف', '600K - 649.9K', 43, NULL, NULL),
(745, '650K - 699.9K', '650 ألف - 699.9 ألف', '650K - 699.9K', 43, NULL, NULL),
(746, '700K - 749.9K', '700 ألف - 749.9 ألف', '700K - 749.9K', 43, NULL, NULL),
(747, '750K - 799.9K', '750 ألف - 799.9 ألف', '750K - 799.9K', 43, NULL, NULL),
(748, '800K - 849.9K', '800 ألف - 849.9 ألف', '800K - 849.9K', 43, NULL, NULL),
(749, '850K - 899.9K', '850 ألف - 899.9 ألف', '850K - 899.9K', 43, NULL, NULL),
(750, '900K - 949.9K', '900 ألف - 949.9 ألف', '900K - 949.9K', 43, NULL, NULL),
(751, '950K - 999.9K', '950 ألف - 999.9 ألف', '950K - 999.9K', 43, NULL, NULL),
(752, '1M & Above', '1 مليون وأكثر', '1M & Above', 43, NULL, NULL),
(753, '50 - 99', '50 - 99', '50 - 99', 44, NULL, NULL),
(754, '100 - 299', '100 - 299', '100 - 299', 44, NULL, NULL),
(755, '300 - 499', '300 - 499', '300 - 499', 44, NULL, NULL),
(756, '500 - 699', '500 - 699', '500 - 699', 44, NULL, NULL),
(757, '700 - 899', '700 - 899', '700 - 899', 44, NULL, NULL),
(758, '900 - 999', '900 - 999', '900 - 999', 44, NULL, NULL),
(759, '1000 & Above', '1000 وأكثر', '1000 & Above', 44, NULL, NULL),
(760, 'Male', 'ذكر', 'Homme', 45, NULL, NULL),
(761, 'Female', 'أنثى', 'Femme', 45, NULL, NULL),
(762, 'Both Genders', 'كلا الجنسين', 'Les deux sexes', 45, NULL, NULL),
(763, 'Arabic', 'عربي', 'Arabe', 46, NULL, NULL),
(764, 'Asian', 'آسيوي', 'Asiatique', 46, NULL, NULL),
(765, 'East Asia', 'شرق آسيا', 'Asie de l\'Est', 46, NULL, NULL),
(766, 'African', 'أفريقي', 'Africain', 46, NULL, NULL),
(767, 'Any nationality', 'أي جنسية', 'Toute nationalité', 46, NULL, NULL),
(768, 'High School', 'المدرسة الثانوية', 'Lycée', 47, NULL, NULL),
(769, 'Diploma degree', 'شهادة الدبلوم', 'Diplôme', 47, NULL, NULL),
(770, 'Bachelor degree', 'درجة البكالوريوس', 'Licence', 47, NULL, NULL),
(771, 'Master degree', 'درجة الماجستير', 'Master', 47, NULL, NULL),
(772, 'Any qualification', 'أي مؤهل', 'Toute qualification', 47, NULL, NULL),
(773, '1 year', 'سنة واحدة', '1 an', 48, NULL, NULL),
(774, '2 years', 'سنتين', '2 ans', 48, NULL, NULL),
(775, '3 years', '3 سنوات', '3 ans', 48, NULL, NULL),
(776, '5 years', '5 سنوات', '5 ans', 48, NULL, NULL),
(777, 'More than 5 years', 'أكثر من 5 سنوات', 'Plus de 5 ans', 48, NULL, NULL),
(778, 'Undefined', 'غير محدد', 'Non défini', 48, NULL, NULL),
(779, 'After the interview', 'بعد المقابلة', 'Après l\'entretien', 49, NULL, NULL),
(780, 'Commission only', 'عمولة فقط', 'Commission uniquement', 49, NULL, NULL),
(781, 'Undefined', 'غير محدد', 'Non défini', 49, NULL, NULL),
(782, '500-1000', '500-1000', '500-1000', 49, NULL, NULL),
(783, '1000-1500', '1000-1500', '1000-1500', 49, NULL, NULL),
(784, '1500-2000', '1500-2000', '1500-2000', 49, NULL, NULL),
(785, '2000-2500', '2000-2500', '2000-2500', 49, NULL, NULL),
(786, '2500-3000', '2500-3000', '2500-3000', 49, NULL, NULL),
(787, '3000-3500', '3000-3500', '3000-3500', 49, NULL, NULL),
(788, '3500-4000', '3500-4000', '3500-4000', 49, NULL, NULL),
(789, 'More than 4000', 'أكثر من 4000', 'Plus de 4000', 49, NULL, NULL),
(790, 'Student', 'طالب', 'Étudiant', 50, NULL, NULL),
(791, 'Entry Level', 'مستوى الدخول', 'Niveau débutant', 50, NULL, NULL),
(792, 'Experienced (non-manager)', 'متمرس (غير مدير)', 'Expérimenté (non-manager)', 50, NULL, NULL),
(793, 'Manager', 'مدير', 'Manager', 50, NULL, NULL),
(794, 'Senior Management', 'الإدارة العليا', 'Direction supérieure', 50, NULL, NULL),
(795, 'Yes', 'نعم', 'Oui', 51, NULL, NULL),
(796, 'No', 'لا', 'Non', 51, NULL, NULL),
(797, 'Full Time', 'دوام كامل', 'Temps plein', 52, NULL, NULL),
(798, 'Part Time', 'دوام جزئي', 'Temps partiel', 52, NULL, NULL),
(799, 'One Time', 'مرة واحدة', 'Une fois', 52, NULL, NULL),
(800, 'Freelance', 'عمل حر', 'Indépendant', 52, NULL, NULL),
(801, 'Internship', 'تدريب', 'Stage', 52, NULL, NULL),
(802, 'Volunteer', 'متطوع', 'Bénévole', 52, NULL, NULL),
(803, 'Consultancy', 'استشارة', 'Consultation', 52, NULL, NULL),
(804, 'Male', 'ذكر', 'Homme', 53, NULL, NULL),
(805, 'Female', 'أنثى', 'Femme', 53, NULL, NULL),
(806, 'Both Genders', 'كلا الجنسين', 'Les deux sexes', 53, NULL, NULL),
(807, 'Arabic', 'العربية', 'Arabe', 54, NULL, NULL),
(808, 'Asian', 'آسيوي', 'Asiatique', 54, NULL, NULL),
(809, 'East Asia', 'شرق آسيا', 'Asie de l\'Est', 54, NULL, NULL),
(810, 'African', 'أفريقي', 'Africain', 54, NULL, NULL),
(811, 'Any nationality', 'أي جنسية', 'Toute nationalité', 54, NULL, NULL),
(812, 'High School', 'المدرسة الثانوية', 'Lycée', 55, NULL, NULL),
(813, 'Diploma degree', 'شهادة دبلوم', 'Diplôme', 55, NULL, NULL),
(814, 'Bachelor degree', 'شهادة البكالوريوس', 'Licence', 55, NULL, NULL),
(815, 'Master degree', 'شهادة الماجستير', 'Master', 55, NULL, NULL),
(816, 'Any qualification', 'أي مؤهل', 'Toute qualification', 55, NULL, NULL),
(817, '1 year', 'سنة واحدة', '1 an', 56, NULL, NULL),
(818, '2 years', 'سنتين', '2 ans', 56, NULL, NULL),
(819, '3 years', '3 سنوات', '3 ans', 56, NULL, NULL),
(820, '5 years', '5 سنوات', '5 ans', 56, NULL, NULL),
(821, 'More than 5 years', 'أكثر من 5 سنوات', 'Plus de 5 ans', 56, NULL, NULL),
(822, 'Undefined', 'غير محدد', 'Non défini', 56, NULL, NULL),
(823, 'After the interview', 'بعد المقابلة', 'Après l\'entretien', 57, NULL, NULL),
(824, 'Commission only', 'عمولة فقط', 'Uniquement à la commission', 57, NULL, NULL),
(825, 'Undefined', 'غير محدد', 'Non défini', 57, NULL, NULL),
(826, '500-1000', '500-1000', '500-1000', 57, NULL, NULL),
(827, '1000-1500', '1000-1500', '1000-1500', 57, NULL, NULL),
(828, '1500-2000', '1500-2000', '1500-2000', 57, NULL, NULL),
(829, '2000-2500', '2000-2500', '2000-2500', 57, NULL, NULL),
(830, '2500-3000', '2500-3000', '2500-3000', 57, NULL, NULL),
(831, '3000-3500', '3000-3500', '3000-3500', 57, NULL, NULL),
(832, '3500-4000', '3500-4000', '3500-4000', 57, NULL, NULL),
(833, 'More than 4000', 'أكثر من 4000', 'Plus de 4000', 57, NULL, NULL),
(834, 'Student', 'طالب', 'Étudiant', 58, NULL, NULL),
(835, 'Entry Level', 'مستوى الدخول', 'Niveau d\'entrée', 58, NULL, NULL),
(836, 'Experienced (non-manager)', 'خبير (غير مدير)', 'Expérimenté (non-manager)', 58, NULL, NULL),
(837, 'Manager', 'مدير', 'Gérant', 58, NULL, NULL),
(838, 'Senior Management', 'الإدارة العليا', 'Direction supérieure', 58, NULL, NULL),
(839, 'Yes', 'نعم', 'Oui', 59, NULL, NULL),
(840, 'No', 'لا', 'Non', 59, NULL, NULL),
(841, 'Full Time', 'بدوام كامل', 'Temps plein', 60, NULL, NULL),
(842, 'Part Time', 'بدوام جزئي', 'Temps partiel', 60, NULL, NULL),
(843, 'One Time', 'مرة واحدة', 'Une fois', 60, NULL, NULL),
(844, 'Freelance', 'عمل حر', 'Freelance', 60, NULL, NULL),
(845, 'Internship', 'تدريب', 'Stage', 60, NULL, NULL),
(846, 'Volunteer', 'تطوع', 'Volontaire', 60, NULL, NULL),
(847, 'Consultancy', 'استشارات', 'Consultance', 60, NULL, NULL),
(848, 'No delivery', 'بدون توصيل', 'Sans livraison', 61, NULL, NULL),
(849, 'Free delivery', 'توصيل مجاني', 'Livraison gratuite', 61, NULL, NULL),
(850, '10', '10', '10', 61, NULL, NULL),
(851, '20', '20', '20', 61, NULL, NULL),
(852, '30', '30', '30', 61, NULL, NULL),
(853, '40', '40', '40', 61, NULL, NULL),
(854, '50', '50', '50', 61, NULL, NULL),
(855, 'Immediate request', 'طلب فوري', 'Demande immédiate', 62, NULL, NULL),
(856, 'Request a day before', 'طلب قبل يوم واحد', 'Demande un jour avant', 62, NULL, NULL),
(857, 'Request 2 days before', 'طلب قبل يومين', 'Demande deux jours avant', 62, NULL, NULL),
(858, 'New', 'جديد', 'Neuf', 63, NULL, NULL),
(859, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 63, NULL, NULL),
(860, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 63, NULL, NULL),
(861, 'Used- Not working', 'مستعمل - لا يعمل', 'Occasion - Ne fonctionne pas', 63, NULL, NULL),
(862, 'Yes', 'نعم', 'Oui', 64, NULL, NULL),
(863, 'No', 'لا', 'Non', 64, NULL, NULL),
(864, 'New', 'جديد', 'Neuf', 65, NULL, NULL),
(865, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 65, NULL, NULL),
(866, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 65, NULL, NULL),
(867, 'Used- Not working', 'مستعمل - لا يعمل', 'Occasion - Ne fonctionne pas', 65, NULL, NULL),
(868, 'Single SIM', 'SIM واحدة', 'SIM unique', 66, NULL, NULL),
(869, 'Dual SIMs', 'شريحتين', 'Double SIM', 66, NULL, NULL),
(870, 'Triple SIMs', 'ثلاث شرائح', 'Triple SIM', 66, NULL, NULL),
(871, 'No SIM', 'بدون شريحة', 'Pas de SIM', 66, NULL, NULL),
(872, 'More than 256 GB', 'أكثر من 256 جيجابايت', 'Plus de 256 Go', 67, NULL, NULL),
(873, '256 GB', '256 جيجابايت', '256 Go', 67, NULL, NULL),
(874, '128 GB', '128 جيجابايت', '128 Go', 67, NULL, NULL),
(875, '64 GB', '64 جيجابايت', '64 Go', 67, NULL, NULL),
(876, '32 GB', '32 جيجابايت', '32 Go', 67, NULL, NULL),
(877, '16 GB', '16 جيجابايت', '16 Go', 67, NULL, NULL),
(878, '8 GB', '8 جيجابايت', '8 Go', 67, NULL, NULL),
(879, 'Without Camera', 'بدون كاميرا', 'Sans appareil photo', 68, NULL, NULL),
(880, 'Less than 2 MP', 'أقل من 2 ميجابيكسل', 'Moins de 2 MP', 68, NULL, NULL),
(881, '2 - 4.9 MP', '2 - 4.9 ميجابيكسل', '2 - 4.9 MP', 68, NULL, NULL),
(882, '5 - 7.9 MP', '5 - 7.9 ميجابيكسل', '5 - 7.9 MP', 68, NULL, NULL),
(883, '8 - 11.9 MP', '8 - 11.9 ميجابيكسل', '8 - 11.9 MP', 68, NULL, NULL),
(884, '12 - 15.9 MP', '12 - 15.9 ميجابيكسل', '12 - 15.9 MP', 68, NULL, NULL),
(885, '16 - 19.9 MP', '16 - 19.9 ميجابيكسل', '16 - 19.9 MP', 68, NULL, NULL),
(886, '20 MP & More', '20 ميجابيكسل وأكثر', '20 MP et plus', 68, NULL, NULL),
(887, '48 - 63.9 MP', '48 - 63.9 ميجابيكسل', '48 - 63.9 MP', 68, NULL, NULL),
(888, '64 MP & More', '64 ميجابيكسل وأكثر', '64 MP et plus', 68, NULL, NULL),
(889, 'Others', 'آخر', 'Autres', 68, NULL, NULL),
(890, 'Yes', 'نعم', 'Oui', 69, NULL, NULL),
(891, 'No', 'لا', 'Non', 69, NULL, NULL),
(892, 'IOS', 'آي أو إس', 'IOS', 70, NULL, NULL),
(893, 'Android', 'أندرويد', 'Android', 70, NULL, NULL),
(894, 'Other', 'أخرى', 'Autre', 70, NULL, NULL),
(895, '2 GB', '2 جيجابايت', '2 Go', 71, NULL, NULL),
(896, '4 GB', '4 جيجابايت', '4 Go', 71, NULL, NULL),
(897, '6 GB', '6 جيجابايت', '6 Go', 71, NULL, NULL),
(898, '8 GB', '8 جيجابايت', '8 Go', 71, NULL, NULL),
(899, '12 GB & More', '12 جيجابايت أو أكثر', '12 Go et plus', 71, NULL, NULL),
(900, 'Others', 'آخر', 'Autre', 71, NULL, NULL),
(901, '3 - 3.9 Inches', '3 - 3.9 بوصة', '3 - 3.9 pouces', 72, NULL, NULL),
(902, '4 - 4.9 Inches', '4 - 4.9 بوصة', '4 - 4.9 pouces', 72, NULL, NULL),
(903, '5 - 5.9 Inches', '5 - 5.9 بوصة', '5 - 5.9 pouces', 72, NULL, NULL),
(904, '6 - 6.9 Inches', '6 - 6.9 بوصة', '6 - 6.9 pouces', 72, NULL, NULL),
(905, '7 - 7.9 Inches', '7 - 7.9 بوصة', '7 - 7.9 pouces', 72, NULL, NULL),
(906, '8 - 8.9 Inches', '8 - 8.9 بوصة', '8 - 8.9 pouces', 72, NULL, NULL),
(907, '9 - 9.9 Inches', '9 - 9.9 بوصة', '9 - 9.9 pouces', 72, NULL, NULL),
(908, '10 & Above', '10 وما فوق', '10 et plus', 72, NULL, NULL),
(909, 'Others', 'آخر', 'Autre', 72, NULL, NULL),
(910, '2000 - 2999 mAh', '2000 - 2999 مللي أمبير', '2000 - 2999 mAh', 73, NULL, NULL),
(911, '3000 - 3999 mAh', '3000 - 3999 مللي أمبير', '3000 - 3999 mAh', 73, NULL, NULL),
(912, '4000 - 4999 mAh', '4000 - 4999 مللي أمبير', '4000 - 4999 mAh', 73, NULL, NULL),
(913, '5000 - 5999 mAh', '5000 - 5999 مللي أمبير', '5000 - 5999 mAh', 73, NULL, NULL),
(914, '6000 - 6999 mAh', '6000 - 6999 مللي أمبير', '6000 - 6999 mAh', 73, NULL, NULL),
(915, '7000 & Above', '7000 وأكثر', '7000 mAh et plus', 73, NULL, NULL),
(916, 'Others', 'آخر', 'Autres', 73, NULL, NULL),
(917, 'Less than 2 MP', 'أقل من 2 ميجابكسل', 'Moins de 2 MP', 74, NULL, NULL),
(918, '2 - 4.9 MP', '2 - 4.9 ميجابكسل', '2 - 4.9 MP', 74, NULL, NULL),
(919, '5 - 7.9 MP', '5 - 7.9 ميجابكسل', '5 - 7.9 MP', 74, NULL, NULL),
(920, '8 - 11.9 MP', '8 - 11.9 ميجابكسل', '8 - 11.9 MP', 74, NULL, NULL),
(921, '12 - 15.9 MP', '12 - 15.9 ميجابكسل', '12 - 15.9 MP', 74, NULL, NULL),
(922, '16 - 31.9 MP', '16 - 31.9 ميجابكسل', '16 - 31.9 MP', 74, NULL, NULL),
(923, '32 MP & Above', '32 ميجابكسل وأعلى', '32 MP et plus', 74, NULL, NULL),
(924, 'Others', 'آخر', 'Autres', 74, NULL, NULL),
(925, 'New', 'جديد', 'Neuf', 75, NULL, NULL),
(926, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 75, NULL, NULL),
(927, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 75, NULL, NULL),
(928, 'Used- Not working', 'مستعمل - غير قائم بالعمل', 'Occasion - Non fonctionnel', 75, NULL, NULL),
(929, 'Yes', 'نعم', 'Oui', 76, NULL, NULL),
(930, 'No', 'لا', 'Non', 76, NULL, NULL),
(931, 'New', 'جديد', 'Neuf', 77, NULL, NULL),
(932, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 77, NULL, NULL),
(933, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 77, NULL, NULL),
(934, 'Used- Not working', 'مستعمل - غير قائم بالعمل', 'Occasion - Non fonctionnel', 77, NULL, NULL),
(935, 'Less than 3MP', 'أقل من 3 ميجابكسل', 'Moins de 3 MP', 78, NULL, NULL),
(936, '3 - 6.9 MP', '3 - 6.9 ميجابكسل', '3 - 6.9 MP', 78, NULL, NULL),
(937, '7 - 11.9 MP', '7 - 11.9 ميجابكسل', '7 - 11.9 MP', 78, NULL, NULL),
(938, '12 - 13.9 MP', '12 - 13.9 ميجابكسل', '12 - 13.9 MP', 78, NULL, NULL),
(939, '14 - 16.9 MP', '14 - 16.9 ميجابكسل', '14 - 16.9 MP', 78, NULL, NULL),
(940, '17 - 20 MP', '17 - 20 ميجابكسل', '17 - 20 MP', 78, NULL, NULL),
(941, 'More than 20 MP', 'أكثر من 20 ميجابكسل', 'Plus de 20 MP', 78, NULL, NULL),
(942, 'Less than 3x', 'أقل من 3 مرات', 'Moins de 3x', 79, NULL, NULL),
(943, '3 - 9.9x', '3 - 9.9 مرات', '3 - 9.9x', 79, NULL, NULL),
(944, '10 - 19.9x', '10 - 19.9 مرات', '10 - 19.9x', 79, NULL, NULL),
(945, '20 - 29.9x', '20 - 29.9 مرات', '20 - 29.9x', 79, NULL, NULL),
(946, '30 - 40x', '30 - 40 مرة', '30 - 40x', 79, NULL, NULL),
(947, 'More than 40x', 'أكثر من 40 مرة', 'Plus de 40x', 79, NULL, NULL),
(948, 'Yes', 'نعم', 'Oui', 80, NULL, NULL),
(949, 'No', 'لا', 'Non', 80, NULL, NULL),
(950, 'Yes', 'نعم', 'Oui', 81, NULL, NULL),
(951, 'No', 'لا', 'Non', 81, NULL, NULL),
(952, 'Yes', 'نعم', 'Oui', 82, NULL, NULL),
(953, 'No', 'لا', 'Non', 82, NULL, NULL),
(954, 'New', 'جديد', 'Neuf', 83, NULL, NULL),
(955, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 83, NULL, NULL),
(956, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 83, NULL, NULL),
(957, 'Used- Not working', 'مستعمل - غير قائم بالعمل', 'Occasion - Non fonctionnel', 83, NULL, NULL),
(958, 'New', 'جديد', 'Neuf', 84, NULL, NULL),
(959, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 84, NULL, NULL),
(960, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 84, NULL, NULL),
(961, 'Used- Not working', 'مستعمل - غير قائم بالعمل', 'Occasion - Non fonctionnel', 84, NULL, NULL);
INSERT INTO `attribute_options` (`id`, `name_en`, `name_ar`, `name_fr`, `attribute_id`, `created_at`, `updated_at`) VALUES
(962, '1', '1', '1', 85, NULL, NULL),
(963, '2', '2', '2', 85, NULL, NULL),
(964, '3', '3', '3', 85, NULL, NULL),
(965, '4', '4', '4', 85, NULL, NULL),
(966, 'Yes', 'نعم', 'Oui', 86, NULL, NULL),
(967, 'No', 'لا', 'Non', 86, NULL, NULL),
(968, 'Nothing', 'لا شيء', 'Rien', 87, NULL, NULL),
(969, '0 - 1 Hour', '0 - 1 ساعة', '0 - 1 heure', 87, NULL, NULL),
(970, '1 - 2 Hours', '1 - 2 ساعة', '1 - 2 heures', 87, NULL, NULL),
(971, '2 - 3 Hours', '2 - 3 ساعة', '2 - 3 heures', 87, NULL, NULL),
(972, 'More than 3 Hours', 'أكثر من 3 ساعات', 'Plus de 3 heures', 87, NULL, NULL),
(973, 'Yes', 'نعم', 'Oui', 88, NULL, NULL),
(974, 'No', 'لا', 'Non', 88, NULL, NULL),
(975, 'New', 'جديد', 'Neuf', 89, NULL, NULL),
(976, 'Used- Perfect', 'مستعمل - مثالي', 'Occasion - Parfait', 89, NULL, NULL),
(977, 'Used- Good', 'مستعمل - جيد', 'Occasion - Bon', 89, NULL, NULL),
(978, 'Used- Not working', 'مستعمل - غير قائم بالعمل', 'Occasion - Non fonctionnel', 89, NULL, NULL),
(979, 'Less than 1 Month', 'أقل من شهر واحد', 'Moins d\'un mois', 90, NULL, NULL),
(980, '1-3 Months', '1-3 أشهر', '1-3 mois', 90, NULL, NULL),
(981, '3-6 Months', '3-6 أشهر', '3-6 mois', 90, NULL, NULL),
(982, '6-12 Months', '6-12 أشهر', '6-12 mois', 90, NULL, NULL),
(983, '1 Year', '1 سنة', '1 an', 90, NULL, NULL),
(984, '2 Years', '2 سنة', '2 ans', 90, NULL, NULL),
(985, '3 Years', '3 سنوات', '3 ans', 90, NULL, NULL),
(986, '4 Years', '4 سنوات', '4 ans', 90, NULL, NULL),
(987, '5 Years', '5 سنوات', '5 ans', 90, NULL, NULL),
(988, '6 Years & more', '6 سنوات وأكثر', '6 ans et plus', 90, NULL, NULL),
(989, 'Less than 1 Month', 'أقل من شهر واحد', 'Moins d\'un mois', 91, NULL, NULL),
(990, '1-3 Months', '1-3 أشهر', '1-3 mois', 91, NULL, NULL),
(991, '3-6 Months', '3-6 أشهر', '3-6 mois', 91, NULL, NULL),
(992, '6-12 Months', '6-12 أشهر', '6-12 mois', 91, NULL, NULL),
(993, '1 Year', '1 سنة', '1 an', 91, NULL, NULL),
(994, '2 Years', '2 سنة', '2 ans', 91, NULL, NULL),
(995, '3 Years', '3 سنوات', '3 ans', 91, NULL, NULL),
(996, '4 Years', '4 سنوات', '4 ans', 91, NULL, NULL),
(997, '5 Years', '5 سنوات', '5 ans', 91, NULL, NULL),
(998, '6 Years & more', '6 سنوات وأكثر', '6 ans et plus', 91, NULL, NULL),
(999, 'Less than 1 Month', 'أقل من شهر واحد', 'Moins d\'un mois', 92, NULL, NULL),
(1000, '1-3 Months', '1-3 أشهر', '1-3 mois', 92, NULL, NULL),
(1001, '3-6 Months', '3-6 أشهر', '3-6 mois', 92, NULL, NULL),
(1002, '6-12 Months', '6-12 أشهر', '6-12 mois', 92, NULL, NULL),
(1003, '1 Year', '1 سنة', '1 an', 92, NULL, NULL),
(1004, '2 Years', '2 سنة', '2 ans', 92, NULL, NULL),
(1005, '3 Years', '3 سنوات', '3 ans', 92, NULL, NULL),
(1006, '4 Years', '4 سنوات', '4 ans', 92, NULL, NULL),
(1007, '5 Years', '5 سنوات', '5 ans', 92, NULL, NULL),
(1008, '6 Years & more', '6 سنوات وأكثر', '6 ans et plus', 92, NULL, NULL),
(1009, 'Male', 'ذكر', 'Homme', 93, NULL, NULL),
(1010, 'Female', 'أنثى', 'Femme', 93, NULL, NULL),
(1011, 'Not Specified', 'غير محدد', 'Non spécifié', 93, NULL, NULL),
(1012, 'Metal', 'معدن', 'Métal', 94, NULL, NULL),
(1013, 'Wooden', 'خشبي', 'Bois', 94, NULL, NULL),
(1014, 'Glass', 'زجاج', 'Verre', 94, NULL, NULL),
(1015, 'Paper', 'ورق', 'Papier', 94, NULL, NULL),
(1016, 'Pottery', 'فخار', 'Poterie', 94, NULL, NULL),
(1017, 'Mosaic', 'فسيفساء', 'Mosaïque', 94, NULL, NULL),
(1018, 'Others', 'أخرى', 'Autres', 94, NULL, NULL),
(1019, 'Smooth', 'ناعم', 'Lisse', 95, NULL, NULL),
(1020, 'Embossed', 'منقوش', 'Relevé', 95, NULL, NULL),
(1021, 'Draw', 'رسم', 'Dessin', 95, NULL, NULL),
(1022, 'Others', 'أخرى', 'Autres', 95, NULL, NULL),
(1023, 'Rare', 'نادر', 'Rare', 96, NULL, NULL),
(1024, 'Not rare', 'غير نادر', 'Pas rare', 96, NULL, NULL),
(1025, 'Excellent', 'ممتاز', 'Excellent', 97, NULL, NULL),
(1026, 'Damaged', 'تالف', 'Endommagé', 97, NULL, NULL),
(1027, 'Restoration', 'ترميم', 'Restauration', 97, NULL, NULL),
(1028, 'B.C.', 'ق.م.', 'Av. J.-C.', 98, NULL, NULL),
(1029, '0 – 500', '0 – 500', '0 – 500', 98, NULL, NULL),
(1030, '501 – 1000', '501 – 1000', '501 – 1000', 98, NULL, NULL),
(1031, '1001 – 1100', '1001 – 1100', '1001 – 1100', 98, NULL, NULL),
(1032, '1101 - 1200', '1101 - 1200', '1101 - 1200', 98, NULL, NULL),
(1033, '1201 - 1300', '1201 - 1300', '1201 - 1300', 98, NULL, NULL),
(1034, '1301 - 1400', '1301 - 1400', '1301 - 1400', 98, NULL, NULL),
(1035, '1401 - 1500', '1401 - 1500', '1401 - 1500', 98, NULL, NULL),
(1036, '1501 - 1600', '1501 - 1600', '1501 - 1600', 98, NULL, NULL),
(1037, '1601 - 1700', '1601 - 1700', '1601 - 1700', 98, NULL, NULL),
(1038, '1701 - 1800', '1701 - 1800', '1701 - 1800', 98, NULL, NULL),
(1039, '1801 - 1900', '1801 - 1900', '1801 - 1900', 98, NULL, NULL),
(1040, '1901 - 2000', '1901 - 2000', '1901 - 2000', 98, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` enum('url','product','profile','whatsapp') COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `image`, `action_type`, `action`, `expiry_date`, `created_at`, `updated_at`) VALUES
(26, 'https://business-egy.com/service/images/banner/1708946907.png', 'product', 'dkmc', NULL, '2024-02-26 11:28:27', '2024-02-26 11:28:27'),
(43, 'https://business-egy.com/service/images/banner/1709040724.png', 'product', 'ad1', NULL, '2024-02-27 13:32:04', '2024-02-27 13:32:04'),
(44, 'https://business-egy.com/service/images/banner/1709040742.png', 'product', 'Ad22', NULL, '2024-02-27 13:32:22', '2024-02-27 13:32:22'),
(45, 'https://business-egy.com/service/images/banner/1709040759.png', 'product', 'ADD33', NULL, '2024-02-27 13:32:39', '2024-02-27 13:32:39'),
(46, 'https://business-egy.com/service/images/banner/1709040776.png', 'product', 'ADD4', NULL, '2024-02-27 13:32:56', '2024-02-27 13:32:56'),
(47, 'https://business-egy.com/service/images/banner/1709040795.png', 'product', 'ADD5', NULL, '2024-02-27 13:33:15', '2024-02-27 13:33:15'),
(48, 'https://business-egy.com/service/images/banner/1710067874.png', 'product', 'dkmc', NULL, '2024-03-10 10:51:14', '2024-03-10 10:51:14'),
(49, 'https://business-egy.com/service/images/banner/1710068543.png', 'product', 'action', NULL, '2024-03-10 11:02:23', '2024-03-10 11:02:23'),
(50, 'https://business-egy.com/service/images/banner/1710070696.png', 'product', 'action', NULL, '2024-03-10 11:38:16', '2024-03-10 11:38:16'),
(51, 'https://business-egy.com/service/images/banner/1710078441.png', 'product', 'action', NULL, '2024-03-10 13:47:21', '2024-03-10 13:47:21');

-- --------------------------------------------------------

--
-- Table structure for table `banner_prices`
--

CREATE TABLE `banner_prices` (
  `id` bigint UNSIGNED NOT NULL,
  `one_day_price` decimal(8,2) NOT NULL,
  `three_day_price` decimal(8,2) NOT NULL,
  `seven_day_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banner_prices`
--

INSERT INTO `banner_prices` (`id`, `one_day_price`, `three_day_price`, `seven_day_price`, `created_at`, `updated_at`) VALUES
(1, 80.00, 150.00, 200.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `image_app` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image_web` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_fr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `image_app`, `image_web`, `name_en`, `name_ar`, `name_fr`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, 'Furniture', 'الأثاث', 'Mobilier', NULL, NULL),
(2, NULL, NULL, NULL, 'Lands', 'الأراضي', 'Terrains', NULL, NULL),
(3, NULL, NULL, NULL, 'Property', 'العقارات', 'Propriétés', NULL, NULL),
(4, NULL, NULL, NULL, 'Cars', 'السيارات', 'Voitures', NULL, NULL),
(5, NULL, NULL, NULL, 'Car Showrooms', 'معارض السيارات', 'Salles d\'exposition de voitures', NULL, NULL),
(6, NULL, NULL, NULL, 'Motorcycles', 'الدراجات النارية', 'Motocyclettes', NULL, NULL),
(7, NULL, NULL, NULL, 'Spare Parts', 'قطع الغيار', 'Pièces de rechange', NULL, NULL),
(8, NULL, NULL, NULL, 'Offshore Tools', 'أدوات البحرية', 'Outils offshore', NULL, NULL),
(9, NULL, NULL, NULL, 'Heavy Equipment', 'المعدات الثقيلة', 'Équipement lourd', NULL, NULL),
(10, NULL, NULL, NULL, 'Pesticides & Pest Control', 'المبيدات ومكافحة الآفات', 'Pesticides et lutte antiparasitaire', NULL, NULL),
(11, NULL, NULL, NULL, 'Air Conditioner', 'تكييف', 'Climatiseur', NULL, NULL),
(12, NULL, NULL, NULL, 'Cleaning Services', 'خدمات التنظيف', NULL, NULL, NULL),
(13, NULL, NULL, NULL, 'Occasions', 'مناسبات', 'Occasions', NULL, NULL),
(14, NULL, NULL, NULL, 'Construction', 'البناء', 'Construction', NULL, NULL),
(15, NULL, NULL, NULL, 'Move Furniture', 'نقل الأثاث', 'Démenagement', NULL, NULL),
(16, NULL, NULL, NULL, 'Transport SRV', 'خدمات النقل', 'Services de transport', NULL, NULL),
(17, NULL, NULL, NULL, 'Decor & Interior Design', 'ديكور وتصميم داخلي', 'Décoration et design d\'intérieur', NULL, NULL),
(18, NULL, NULL, NULL, 'Gardening & Agriculture', 'الحدائق والزراعة', 'Jardins et agriculture', NULL, NULL),
(19, NULL, NULL, NULL, 'Education', 'تعليم', 'Éducation', NULL, NULL),
(20, NULL, NULL, NULL, 'Selling Projects', 'مشاريع للبيع', 'Projets à vendre', NULL, NULL),
(21, NULL, NULL, NULL, 'Commercial Services', 'خدمات تجارية', 'Services commerciaux', NULL, NULL),
(22, NULL, NULL, NULL, 'Maintenance Services', 'خدمات الصيانة', 'Services de maintenance', NULL, NULL),
(23, NULL, NULL, NULL, 'Employers', 'أرباب العمل', 'Employeurs', NULL, NULL),
(24, NULL, NULL, '/Services/jobApplicants.png', 'Job Applicants', 'الباحثون عن عمل', 'Demandeurs d\'emploi', NULL, NULL),
(25, NULL, NULL, '/family/men.png', 'Men Stuff', 'أشياء الرجال', 'Affaires d\'hommes', NULL, NULL),
(26, NULL, NULL, '/family/women.png', 'Women Stuff', 'أشياء النساء', 'Affaires de femmes', NULL, NULL),
(27, NULL, NULL, '/family/kids.png', 'Kids Stuff', 'أشياء الأطفال', 'Affaires d\'enfants', NULL, NULL),
(28, NULL, NULL, '/family/gifts.png', 'Gifts', 'الهدايا', 'Cadeaux', NULL, NULL),
(29, NULL, NULL, '/family/foods.png', 'Foods', 'الأطعمة', 'Aliments', NULL, NULL),
(30, NULL, NULL, '/electronics/electronics.png', 'Electronics', 'الإلكترونيات', 'Électronique', NULL, NULL),
(31, NULL, NULL, '/electronics/mobiles.png', 'Mobiles', 'الموبايلات', 'Mobiles', NULL, NULL),
(32, NULL, NULL, '/electronics/homeAppliances.png', 'Home Appliance', 'أجهزة المنزل', 'Appareils ménagers', NULL, NULL),
(33, NULL, NULL, '/electronics/homeAppliances.png', 'Camera & Videos', 'كاميرات و فيديوهات', 'Appareils photo et vidéos', NULL, NULL),
(34, NULL, NULL, '/electronics/electronicGames.png', 'Electronic Games', 'ألعاب الكترونية', 'Jeux électroniques', NULL, NULL),
(35, NULL, NULL, '/sportAndFitness/sportAndFitness.png', 'Sport & Fitness', 'الرياضة واللياقة البدنية', 'Sport et remise en forme', NULL, NULL),
(36, NULL, NULL, '/sportAndFitness/health.png', 'Health', 'الصحة', 'Santé', NULL, NULL),
(37, NULL, NULL, '/sportAndFitness/smartAndBicycle.png', 'Smart & Bicycle', 'الدراجات الذكية', 'Vélo intelligent', NULL, NULL),
(38, NULL, NULL, '/travel/airplan.png', 'Tourism', 'السياحة', 'Tourisme', NULL, NULL),
(39, NULL, NULL, '/travel/camping.png', 'Trip & Camping', 'الرحلات والتخييم', 'Voyages et camping', NULL, NULL),
(40, NULL, NULL, '/animals/camal.png', 'Horses, Sheep & Camels', 'الخيل والأغنام والجمال', 'Chevaux, moutons et chameaux', NULL, NULL),
(41, NULL, NULL, '/animals/rabbit.png', 'Other Animals', 'حيوانات أخرى', 'Autres animaux', NULL, NULL),
(42, NULL, NULL, '/animals/bird.png', 'Birds', 'الطيور', 'Oiseaux', NULL, NULL),
(43, NULL, NULL, '/others/book.png', 'Others', 'أخرى', 'Autres', NULL, NULL),
(44, NULL, NULL, '/others/coins.png', 'Special Coins', 'عملات خاصة', 'Pièces spéciales', NULL, NULL),
(45, NULL, NULL, '/others/antiques.png', 'Antiques', 'العتيقة', 'Antiquités', NULL, NULL),
(46, NULL, NULL, '/others/charitable.png', 'Charity', 'الخيرية', 'Charité', NULL, NULL),
(47, NULL, NULL, '/others/inquires.png', 'Inquiry', 'استفسار', 'Demande', NULL, NULL),
(48, NULL, NULL, 'national_product.png', 'National Product', 'منتج وطني', 'Produit National', NULL, NULL),
(57, 3, '1709735514.png', '1709735514.png', 'Workers housing', 'سكن العمال', 'Logement des travailleurs', NULL, '2024-03-06 14:31:55'),
(59, 3, '1709735499.png', '1709735499.png', 'Other property', 'ممتلكات أخرى', 'Autre propriété', NULL, '2024-03-06 14:31:40'),
(60, 2, '1709735577.png', '1709735577.png', 'Residential Land', 'أراضي سكنية', 'Terrains résidentiels', NULL, '2024-03-06 14:32:57'),
(61, 2, '1709735592.png', '1709735591.png', 'Commercial land', 'أراضي تجارية', 'Terrains', NULL, '2024-03-06 14:33:12'),
(62, 2, '1709735607.png', '1709735607.png', 'Agricultural Land', 'أراضي زراعية', 'Terrains agricoles', NULL, '2024-03-06 14:33:27'),
(63, 2, '1709735613.png', '1709735613.png', 'Industrial land', 'أراضي صناعية', 'Terrains industriels', NULL, '2024-03-06 14:33:35'),
(64, 2, '1709735635.png', '1709735635.png', 'Lands Outside Egypt', 'أراضي خارج مصر', 'Terrains à l`extérieur du Egypte', NULL, '2024-03-06 14:33:55'),
(65, 2, '1709735664.png', '1709735663.png', 'Other Lands', 'أراضي أخرى', 'Autres terrains', NULL, '2024-03-06 14:34:24'),
(66, 1, '1709115517.png', '1709115517.png', 'Beds & Mattress', 'الأسرّة والمراتب', 'Lits et matelas', NULL, '2024-02-28 10:18:37'),
(67, 1, '1709110203.png', '1709110203.png', 'Sofas & Chairs', 'الأرائك والكراسي', 'Canapés et chaises', NULL, '2024-02-28 08:50:03'),
(68, 1, '1709110220.png', '1709110220.png', 'Tables', 'الطاولات', 'Tables', NULL, '2024-02-28 08:50:21'),
(69, 1, '1709110230.png', '1709110230.png', 'Rugs, Mats & Flooring', 'السجاد والموكيت والأرضيات', 'Tapis, paillassons et revêtements de sol', NULL, '2024-02-28 08:50:30'),
(70, 1, '1709115626.png', '1709115626.png', 'Textiles', 'المنسوجات', 'Textiles', NULL, '2024-02-28 10:20:27'),
(71, 1, '1709115635.png', '1709115635.png', 'Lighting', 'الإضاءة', 'Éclairage', NULL, '2024-02-28 10:20:35'),
(72, 1, '1709110277.png', '1709110277.png', 'TV & Gaming Furniture', 'أثاث التلفزيون والألعاب', 'Meubles TV et de jeu', NULL, '2024-02-28 08:51:17'),
(73, 1, '1709110308.png', '1709110308.png', 'Cabinets & Wardrobe', 'الخزائن والملابس', 'Armoires et garde-robes', NULL, '2024-02-28 08:51:48'),
(74, 1, '1709110316.png', '1709110316.png', 'Crafts & Decor', 'أثاث التلفزيون والألعاب', 'Artisanat et décoration', NULL, '2024-02-28 08:51:56'),
(75, 1, '1709110326.png', '1709110326.png', 'Office Furniture', 'أثاث المكاتب', 'Mobilier de bureau', NULL, '2024-02-28 08:52:06'),
(76, 1, '1709119503.png', '1709119503.png', 'Outdoor Furniture', 'أثاث الهواء الطلق', 'Mobilier d`extérieur', NULL, '2024-02-28 11:25:03'),
(77, 1, '1709119389.png', '1709119389.png', 'Rooms', 'الغرف', 'Chambres', NULL, '2024-02-28 11:23:09'),
(78, 1, '1709119407.png', '1709119407.png', 'Kitchen & Tableware', 'مطابخ وأواني طعام', 'Cuisine et vaisselle', NULL, '2024-02-28 11:23:27'),
(79, 1, '1709735759.png', '1709735759.png', 'Bathroom Essentials', 'ضروريات الحمام', 'Éléments essentiels de la salle de bain', NULL, '2024-03-06 14:35:59'),
(80, 1, NULL, NULL, 'Other furniture', 'أثاث آخر', 'Autres meubles', NULL, NULL),
(81, 4, '21.png', 'Mercedes.png', 'Mercedes', 'مرسيدس', 'Mercedes', NULL, NULL),
(82, 4, '19.png', 'BMW.png', '	\r\nBMW', 'بي ام دبليو', '	\r\nBMW', NULL, NULL),
(83, 4, '13.png', NULL, 'Hyundai', 'هيونداي', 'Hyundai', NULL, NULL),
(84, 4, '28.png', '', 'Toyota', 'تايوتا', 'Toyota', NULL, NULL),
(85, 4, '27.png', '27.png', 'Nissan', 'نيسان', 'Nissan', NULL, NULL),
(86, 4, '20.png', '', 'Kia\r\n 	', 'كيا', 'kia', NULL, NULL),
(87, 4, '65.png', 'Range Rover', 'Range Rover', 'رنجروفر', 'Range Rover', NULL, NULL),
(88, 4, '59.png', NULL, 'GAC', 'جاك', 'GAC', NULL, NULL),
(89, 4, '7.png', NULL, 'Bugatti', 'باغاتي', 'Bugatti', NULL, NULL),
(90, 4, '11.png', NULL, 'Great Wall', 'جريت وواال', 'Great Wall', NULL, NULL),
(91, 4, '12.png', NULL, 'Ashok', 'اشوك', 'Ashok', NULL, NULL),
(92, 4, '4.png', '', 'Alfa Romeo', 'الفا ريمو', 'Alfa Romeo', NULL, NULL),
(93, 4, '36.png', NULL, 'Vanderhall', 'Vanderhall', 'Vanderhall', NULL, NULL),
(94, 4, '10.png', '', 'King Long', 'كينجلونج', 'King Long', NULL, NULL),
(95, 4, '29.png', NULL, 'ZXauto', 'زكسا وتو', 'ZXauto', NULL, NULL),
(96, 4, '30.png', '', 'Pontiac', 'بوناتك', 'Pontiac', NULL, NULL),
(97, 4, '31.png', '', 'McLaren', 'McLaren', 'McLaren', NULL, NULL),
(98, 4, '32.png', NULL, 'MayBach\r\n', 'MayBach\r\n', 'MayBach\r\n', NULL, NULL),
(99, 4, '33.png', NULL, 'Foton', 'فوتون', 'Foton', NULL, NULL),
(100, 4, '1708862690.png', '1708862690.png', 'Buick', 'بيك', 'Borgward', NULL, '2024-02-25 12:04:50'),
(101, 4, '1708862835.png', '1708862835.png', 'BAIC', 'بي أي سي', 'BAIC', NULL, '2024-02-25 12:07:15'),
(102, 4, '1708863045.png', '1708863045.png', 'Lamborghini', 'لامبورغيني', 'Lamborghini', NULL, '2024-02-25 12:10:45'),
(103, 4, '1708863205.png', '1708863205.png', 'Genesis', 'جينيسيس', 'Genesis', NULL, '2024-02-25 12:13:25'),
(104, 4, '1708863339.png', '1708863339.png', 'Smart', 'سمارت', 'Smart', NULL, '2024-02-25 12:15:39'),
(105, 4, '1708940652.png', '1708940652.png', 'Ferrari', 'فيراري', 'Ferrari', NULL, '2024-02-26 09:44:12'),
(106, 4, '1708864349.png', '1708864349.png', 'Datsun', 'داتسون', 'Datsun', NULL, '2024-02-25 12:32:29'),
(107, 4, '1708864714.png', '1708864714.png', 'Aston Martin', 'أستون مارتن', 'Aston Martin', NULL, '2024-02-25 12:38:34'),
(108, 4, '1708864940.png', '1708864940.png', 'Lincoln', 'لينكولن', 'Lincoln', NULL, '2024-02-25 12:42:20'),
(109, 4, '1708864976.png', '1708864976.png', 'TATA', 'تاتا', 'TATA', NULL, '2024-02-25 12:42:56'),
(110, 4, '1708865045.png', '1708865045.png', 'SSangyoung', 'سانغيونغ', 'SSangyoung', NULL, '2024-02-25 12:44:05'),
(111, 4, '1708865210.png', '1708865210.png', 'Great Wall', 'جريت وول', 'Great Wall', NULL, '2024-02-25 12:46:50'),
(112, 4, '1708874327.png', '1708874327.png', 'Citroen', 'سيتروين', 'Citroen', NULL, '2024-02-25 15:18:47'),
(113, 4, '1708874563.png', '1708874563.png', 'Rolls Royce', 'رولز رويس', 'Rolls Royce', NULL, '2024-02-25 15:22:43'),
(114, 4, '1708940523.png', NULL, 'Proton', 'بروتون', 'Proton', NULL, '2024-02-26 09:42:03'),
(115, 4, '1708867353.png', '1708867353.png', 'Daihatsu', 'دايهاتسو', 'Daihatsu', NULL, '2024-02-25 13:22:33'),
(116, 4, '1708940097.png', '1708940097.png', 'Seat', 'سيات', 'Seat', NULL, '2024-02-26 09:34:57'),
(118, 4, '1708939983.png', '1708939983.png', 'Skoda', 'سكودا', 'Skoda', NULL, '2024-02-26 09:33:03'),
(119, 4, '1708873682.png', '1708873682.png', 'Maserati', 'مازيراتي', 'Maserati', NULL, '2024-02-25 15:08:02'),
(120, 4, '1708867605.png', '1708867605.png', 'Chrysler', 'كرايسلر', 'Chrysler', NULL, '2024-02-25 13:26:45'),
(121, 4, '1708873608.png', '1708873608.png', 'Tesla', 'تسلا', 'Tesla', NULL, '2024-02-25 15:06:48'),
(122, 4, '1708873560.png', '1708873560.png', 'Jaguar', 'جاكوار', 'Jaguar', NULL, '2024-02-25 15:06:00'),
(123, 4, '1709035129.png', '1709035129.png', 'Geely', 'جيلي', 'Geely', NULL, '2024-02-27 11:58:49'),
(124, 4, '1708867782.png', '1708867782.png', 'Bentley', 'بنتلي', 'Bentley', NULL, '2024-02-25 13:29:42'),
(125, 4, '1708867822.png', '1708867822.png', 'Classic cars', 'سيارات كلاسيكية', 'Classic cars', NULL, '2024-02-25 13:30:22'),
(126, 4, '1708873448.png', '1708873448.png', 'Subaru', 'سوبارو', 'Subaru', NULL, '2024-02-25 15:04:08'),
(127, 4, '1708867996.png', '1708867996.png', 'MG', 'إم جي', 'MG', NULL, '2024-02-25 13:33:16'),
(128, 4, '1708868023.png', '1708868023.png', 'Hummer', 'همر', 'Hummer', NULL, '2024-02-25 13:33:43'),
(129, 4, '1708868155.png', '1708868155.png', 'Volvo', 'فولفو', 'Volvo', NULL, '2024-02-25 13:35:56'),
(130, 4, '1709035522.png', NULL, 'Mistubishi', 'ميتويسشي', 'Mistubishi', NULL, '2024-02-27 12:05:22'),
(131, 4, '1708868251.png', '1708868251.png', 'Peugeot', 'بيجو', 'Peugeot', NULL, '2024-02-25 13:37:31'),
(132, 4, '1708868286.png', '1708868286.png', 'Isuzu', 'ايسوزو', 'Isuzu', NULL, '2024-02-25 13:38:06'),
(133, 4, '1708873388.png', NULL, 'Chery', 'شيري', 'Chery', NULL, '2024-02-25 15:03:08'),
(134, 4, '1708940726.png', '1708940726.png', 'Mazda', 'مازدا', 'Mazda', NULL, '2024-02-26 09:45:26'),
(135, 4, '1708874996.png', '1708874996.png', 'Mini', 'ميني', 'Mini', NULL, '2024-02-25 15:29:56'),
(136, 4, '1708868433.png', '1708868433.png', 'Infinity', 'انفينيتي', 'Infinity', NULL, '2024-02-25 13:40:33'),
(137, 4, '1708868469.png', '1708868469.png', 'Audi', 'أودي', 'Audi', NULL, '2024-02-25 13:41:09'),
(138, 4, '1708868499.png', '1708868499.png', 'Cadillac', 'كاديلاك', 'Cadillac', NULL, '2024-02-25 13:41:40'),
(139, 4, '1708868618.png', '1708868618.png', 'Porsche', 'بورش', 'Porsche', NULL, '2024-02-25 13:43:38'),
(140, 4, '1708939634.png', NULL, 'Renault', 'رينو', 'Renault', NULL, '2024-02-26 09:27:14'),
(141, 4, '1709037078.png', '1709037078.png', 'Changan', 'شانجان', 'Changan', NULL, '2024-02-27 12:31:18'),
(142, 4, '1708868745.png', '1708868745.png', 'Dodge', 'دودج', 'Dodge', NULL, '2024-02-25 13:45:45'),
(143, 4, '1708868796.png', '1708868796.png', 'Jeep', 'جيب', 'Jeep', NULL, '2024-02-25 13:46:36'),
(144, 4, '1708868846.png', '1708868846.png', 'Volkswagen', 'فولكس واجن', 'Volkswagen', NULL, '2024-02-25 13:47:26'),
(145, 4, '1708868918.png', '1708868918.png', 'Suzuki', 'سوزوكي', 'Suzuki', NULL, '2024-02-25 13:48:38'),
(146, 4, '1708868961.png', '1708868961.png', 'Land rover', 'لاند روفر', 'Land Rover', NULL, '2024-02-25 13:49:21'),
(147, 4, '1708869035.png', '1708869035.png', 'Honda', 'هوندا', 'Honda', NULL, '2024-02-25 13:50:35'),
(148, 4, '1708940911.png', '1708940911.png', 'BYD', 'بي واي دي', 'BYD', NULL, '2024-02-26 09:48:31'),
(149, 4, '1709036899.png', '1709036899.png', 'Chana', 'شانا', 'Chana', NULL, '2024-02-27 12:28:19'),
(150, 4, '1708869301.png', '1708869301.png', 'Ford', 'فورد', 'Ford', NULL, '2024-02-25 13:55:01'),
(151, 4, '1708869528.png', '1708869528.png', 'Lexus', 'لكزس', 'Lexus', NULL, '2024-02-25 13:58:48'),
(152, 4, '1709036558.png', '1709036558.png', 'Bestune', 'بيستون', 'Bestune', NULL, '2024-02-27 12:22:38'),
(153, 4, '1708869740.png', '1708869739.png', 'Gmc', 'جي أم سي', 'GMC', NULL, '2024-02-25 14:02:20'),
(154, 4, '1709036316.png', '1709036316.png', 'Brilliance', 'بريليانس', 'Jetour', NULL, '2024-02-27 12:18:36'),
(155, 4, '1708869825.png', '1708869825.png', 'Chevrolet', 'شفروليه', 'Chevrolet', NULL, '2024-02-25 14:03:45'),
(156, 4, '1709039763.png', '1709039763.png', 'Cupra', 'كوبرا', 'Cupra', NULL, '2024-02-27 13:16:03'),
(157, 4, '1709036259.png', '1709036259.png', 'Jetour', 'جيتور', 'Jetour', NULL, '2024-02-27 12:17:39'),
(158, 4, NULL, NULL, 'Other cars', 'سيارات أخرى', 'Autres voitures', NULL, NULL),
(159, 6, '1709548226.png', NULL, 'KTM', 'كي تي إم', 'KTM', NULL, '2024-03-04 10:30:26'),
(160, 6, '1709548260.png', '1709548260.png', 'DUCATI', 'دوكاتي', 'DUCATI', NULL, '2024-03-04 10:31:04'),
(161, 6, 'Can-Am-Logo.png', 'Can-Am-Logo.png', 'Can-Am', 'كان أم', 'Can-Am', NULL, NULL),
(162, 6, 'Artic.png', 'Artic.png', 'Arctic Cat', 'أركتيك كات', 'Arctic Cat', NULL, NULL),
(163, 6, '1709549141.png', '1709549141.png', 'Big Bear Choppers', 'بيغ بير تشوبيرز', 'Big Bear Choppers', NULL, '2024-03-04 10:45:41'),
(164, 6, '1709548311.png', '1709548311.png', 'MV Agusta', 'إم في أغوستا', 'MV Agusta', NULL, '2024-03-04 10:31:51'),
(165, 6, '1708942386.png', '1708942386.png', 'Aprilia', 'أبريليا', 'Aprilia', NULL, '2024-02-26 10:13:06'),
(166, 6, 'Bajaj-Logo.png', 'Bajaj-Logo.png', 'Bajaj', 'باجاج', 'Bajaj', NULL, NULL),
(167, 6, '1709548275.png', '1709548275.png', 'Beta', 'بيتا', 'Beta', NULL, '2024-03-04 10:31:16'),
(168, 6, 'Gilera-Logo.png', 'Gilera-Logo.png', 'Gilera', 'جيليرا', 'Gilera', NULL, NULL),
(169, 6, '1708942458.png', '1708942458.png', 'Hisun', 'هيسون', 'Hisun', NULL, '2024-02-26 10:14:18'),
(170, 6, 'piaggio.png', 'piaggio.png', 'Piaggio', 'بياجيو', 'Piaggio', NULL, NULL),
(171, 6, 'pitsterpro.png', 'pitsterpro.png', 'Pitster Pro', 'بيتستر برو', 'Pitster Pro', NULL, NULL),
(172, 6, '1709548968.png', '1709548968.png', 'Royal Enfield', 'رويال إنفيلد', 'Royal Enfield', NULL, '2024-03-04 10:42:48'),
(173, 6, 'Logo_Triumph.png', 'Logo_Triumph.png', 'Triumph', 'تريومف', 'Triumph', NULL, NULL),
(174, 6, 'TVS.png', 'TVS.png', 'TVS', 'تي في إس', 'TVS', NULL, NULL),
(175, 6, '1708942660.png', '1708942660.png', 'Vespa', 'فيسبا', 'Vespa', NULL, '2024-02-26 10:17:40'),
(176, 6, 'TGB.png', 'TGB.png', 'TGB', 'تي جي بي', 'TGB', NULL, NULL),
(177, 6, 'KAWAS.png', 'KAWAS.png', 'Kawasaki', 'كاواساكي', 'Kawasaki', NULL, NULL),
(178, 6, '1708942979.png', '1708942979.png', 'BMW', 'بي إم دبليو', 'BMW', NULL, '2024-02-26 10:22:59'),
(179, 6, 'Honda.png', 'Honda.png', 'Honda', 'هوندا', 'Honda', NULL, NULL),
(180, 6, '1709548339.png', '1709548339.png', 'Harley Davidson', 'هارلي ديفيدسون', 'Harley Davidson', NULL, '2024-03-04 10:32:20'),
(181, 6, 'YAMAHA.png', 'YAMAHA.png', 'Yamaha', 'ياماها', 'Yamaha', NULL, NULL),
(182, 6, '1709548360.png', '1709548360.png', 'Suzuki', 'سوزوكي', 'Suzuki', NULL, '2024-03-04 10:32:41'),
(183, 6, '1708942728.png', '1708942728.png', 'Buggy', 'باغي', 'Buggy', NULL, '2024-02-26 10:18:48'),
(184, 6, '1708942764.png', '1708942764.png', 'Polaris', 'بولاريس', 'Polaris', NULL, '2024-02-26 10:19:24'),
(185, 6, NULL, NULL, 'Others', 'أخرى', 'Autres', NULL, NULL),
(186, 7, '1709126071.png', '1709126071.png', 'Brakes', 'الفرامل', 'Freins', NULL, '2024-02-28 13:14:31'),
(187, 7, '1709126083.png', '1709126083.png', 'Cooling System', 'نظام التبريد', 'Système de refroidissement', NULL, '2024-02-28 13:14:44'),
(188, 7, '1709129051.png', '1709129051.png', 'Batteries & Accessories', 'البطاريات والملحقات', 'Batteries et accessoires', NULL, '2024-02-28 14:04:11'),
(189, 7, '1709126122.png', '1709126122.png', 'Transmission & Gearing', 'نقل الحركة والتروس', 'Transmission et engrenages', NULL, '2024-02-28 13:15:23'),
(190, 7, '1709126133.png', '1709126133.png', 'Oils and Fluids', 'الزيوت والسوائل', 'Huiles et liquides', NULL, '2024-02-28 13:15:33'),
(191, 7, '1709127978.png', '1709127978.png', 'Cables', 'الكابلات', 'Câbles', NULL, '2024-02-28 13:46:18'),
(192, 7, '1709128631.png', '1709128631.png', 'Glasses and mirrors', 'النظارات والمرايا', 'Verres et miroirs', NULL, '2024-02-28 13:57:11'),
(193, 7, '1709128662.png', '1709128662.png', 'Interior & Accessories', 'الداخلية والإكسسوارات', 'Intérieur et accessoires', NULL, '2024-02-28 13:57:43'),
(194, 7, '1709128680.png', '1709128680.png', 'Filters', 'المرشحات', 'Filtres', NULL, '2024-02-28 13:58:01'),
(195, 7, '1709128736.png', '1709128736.png', 'Electric Vehicle Parts', 'قطع غيار السيارات الكهربائية', 'Pièces pour véhicules électriques', NULL, '2024-02-28 13:58:56'),
(196, 7, '1709126833.png', '1709126833.png', 'Exterior & Spares', 'الخارجية والقطع البديلة', 'Extérieur et pièces de rechange', NULL, '2024-02-28 13:27:14'),
(197, 7, '1709126887.png', '1709126887.png', 'Tyres', 'الإطارات', 'Pneus', NULL, '2024-02-28 13:28:08'),
(198, 7, '1709126915.png', '1709126915.png', 'Lighting', 'الإضاءة', 'Éclairage', NULL, '2024-02-28 13:28:36'),
(199, 7, '1709126930.png', '1709126930.png', 'Rims', 'الجنوط', 'Jantes', NULL, '2024-02-28 13:28:50'),
(200, 7, '1709126943.png', '1709126943.png', 'Engines', 'المحركات', 'Moteurs', NULL, '2024-02-28 13:29:03'),
(201, 7, '1709126953.png', '1709126953.png', 'Workshops', 'ورش العمل', 'Ateliers', NULL, '2024-02-28 13:29:14'),
(202, 7, '1709126965.png', '1709126965.png', 'Other Parts', 'قطع أخرى', 'Autres pièces', NULL, '2024-02-28 13:29:26'),
(203, 8, '1709131301.png', '1709131301.png', 'Diving Tools', 'أدوات الغوص', 'Outils de plongée', NULL, '2024-02-28 14:41:41'),
(204, 8, '1709131331.png', '1709131331.png', 'Wooden Boat', 'القوارب الخشبية', 'Bateau en bois', NULL, '2024-02-28 14:42:11'),
(205, 8, '1709131479.png', '1709131479.png', 'Fishing tools', 'أدوات الصيد', 'Outils de pêche', NULL, '2024-02-28 14:44:40'),
(206, 8, '1709131555.png', '1709131555.png', 'Jet Ski', 'الجت سكي', 'Jet ski', NULL, '2024-02-28 14:45:58'),
(207, 8, '1709131565.png', '1709131565.png', 'Cruisers & Yachts', 'القوارب الرحلات البحرية واليخوت', 'Croisières et yachts', NULL, '2024-02-28 14:46:05'),
(208, 8, NULL, NULL, 'Other', 'أخرى', 'Autres', NULL, NULL),
(209, 9, '1709135293.png', '1709135293.png', 'Concrete Equipment', 'معدات الخرسانة', 'Équipement en béton', NULL, '2024-02-28 15:48:13'),
(210, 9, '1709135307.png', '1709135307.png', 'Spare Parts', 'قطع غيار', 'Pièces de rechange', NULL, '2024-02-28 15:48:28'),
(211, 9, '1709134914.png', '1709134914.png', 'Forklifts', 'رافعات شوكية', 'Chariots élévateurs', NULL, '2024-02-28 15:41:55'),
(212, 9, '1709134931.png', '1709134931.png', 'Trailers', 'مقطورات', 'Remorques', NULL, '2024-02-28 15:42:11'),
(213, 9, '1709134939.png', '1709134939.png', 'Buses', 'حافلات', 'Autobus', NULL, '2024-02-28 15:42:19'),
(214, 9, '1709134951.png', '1709134951.png', 'Cranes', 'رافعات', 'Grues', NULL, '2024-02-28 15:42:31'),
(215, 9, '1709135324.png', '1709135324.png', 'Tippers & Excavators', 'شاحنات نقل وحفارات', 'Bennes et excavatrices', NULL, '2024-02-28 15:48:44'),
(216, 9, '1709134982.png', '1709134982.png', 'Trucks', 'شاحنات', 'Camions', NULL, '2024-02-28 15:43:02'),
(217, 9, '1709134998.png', '1709134998.png', 'Other equipment', 'معدات أخرى', 'Autres équipements', NULL, '2024-02-28 15:43:18'),
(218, 10, NULL, NULL, 'Pest Control', 'مكافحة الحشرات', 'Contrôle des parasites', NULL, NULL),
(219, 11, '1708960939.png', '1708960939.png', 'Daewoo', 'دايو', 'Daewoo', NULL, '2024-02-26 15:22:19'),
(220, 11, '1709803265.png', NULL, 'Midea', 'ميديا', 'Midea', NULL, '2024-03-07 09:21:06'),
(221, 11, '1708961069.png', '1708961069.png', 'ORYX', 'أوريكس', 'ORYX', NULL, '2024-02-26 15:24:29'),
(222, 11, '1708961116.png', '1708961116.png', 'Panasonic', 'باناسونيك', 'Panasonic', NULL, '2024-02-26 15:25:16'),
(223, 11, '1708961251.png', '1708961251.png', 'Sharp', 'شارب', 'Sharp', NULL, '2024-02-26 15:27:31'),
(224, 11, '1708961333.png', '1708961333.png', 'Mitsubishi Electric', 'ميتسوبيشي الكتريك', 'Mitsubishi Electric', NULL, '2024-02-26 15:28:53'),
(225, 11, '1708961376.png', '1708961376.png', 'Carrier', 'كارير', 'Carrier', NULL, '2024-02-26 15:29:36'),
(226, 11, '1708961477.png', '1708961477.png', 'Samsung', 'سامسونج', 'Samsung', NULL, '2024-02-26 15:31:17'),
(227, 11, '1708961509.png', '1708961509.png', 'Hitachi', 'هيتاشي', 'Hitachi', NULL, '2024-02-26 15:31:49'),
(228, 11, '1708961571.png', '1708961571.png', 'Gree', 'جري', 'Gree', NULL, '2024-02-26 15:32:51'),
(229, 11, '1708961611.png', '1708961611.png', 'General', 'جنرال', 'General', NULL, '2024-02-26 15:33:31'),
(230, 11, '1708961688.png', '1708961688.png', 'LG', 'إل جي', 'LG', NULL, '2024-02-26 15:34:48'),
(231, 11, NULL, NULL, 'Other', 'أخرى', 'Autre', NULL, NULL),
(232, 12, NULL, NULL, 'Houses cleaning', 'تنظيف المنازل', 'Nettoyage des maisons', NULL, NULL),
(233, 12, NULL, NULL, 'Carpets & Furnishings cleaning', 'تنظيف السجاد والمفروشات', 'Nettoyage des tapis et des meubles', NULL, NULL),
(234, 12, NULL, NULL, 'Water tanks cleaning', 'تنظيف خزانات المياه', 'Nettoyage des réservoirs d\'eau', NULL, NULL),
(235, 12, NULL, NULL, 'Swimming pools cleaning', 'تنظيف حمامات السباحة', 'Nettoyage des piscines', NULL, NULL),
(236, 12, NULL, NULL, 'Interfaces cleaning', 'تنظيف الواجهات', 'Nettoyage des interfaces', NULL, NULL),
(237, 13, '1709209885.png', NULL, 'Sofas & Chairs', 'أرائك وكراسي', 'Canapés et chaises', NULL, '2024-02-29 12:31:25'),
(238, 13, '1709210337.png', '1709210337.png', 'Photography & display', 'تصوير وعرض', 'Photographie et affichage', NULL, '2024-02-29 12:38:58'),
(239, 13, '1709209913.png', '1709209913.png', 'Lighting & Laser', 'إضاءة وليزر', 'Éclairage et laser', NULL, '2024-02-29 12:31:53'),
(240, 13, '1709209925.png', '1709209925.png', 'Decorations', 'ديكورات', 'Décorations', NULL, '2024-02-29 12:32:05'),
(241, 13, '1709210172.png', '1709210172.png', 'Hospitality SRV', 'خدمات الضيافة', 'Services d\'hospitalité', NULL, '2024-02-29 12:36:13'),
(242, 13, '1709210193.png', '1709210193.png', 'Halls & Tents', 'قاعات وخيم', 'Salles et tentes', NULL, '2024-02-29 12:36:33'),
(243, 13, '1709210227.png', '1709210227.png', 'Others', 'أخرى', 'Autres', NULL, '2024-02-29 12:37:08'),
(244, 14, '1709047840.png', '1709047840.png', 'Building Tools', 'أدوات البناء', 'Outils de construction', NULL, '2024-02-27 15:30:40'),
(245, 14, '1709046842.png', '1709046842.png', 'Marble & Stone', 'رخام وحجر', 'Marbre et pierre', NULL, '2024-02-27 15:14:02'),
(246, 14, '1709046834.png', '1709046834.png', 'Engineering & Design', 'هندسة وتصميم', 'Ingénierie et conception', NULL, '2024-02-27 15:13:54'),
(247, 14, '1709049639.png', '1709049639.png', 'Building Materials', 'مواد البناء', 'Matériaux de construction', NULL, '2024-02-27 16:00:39'),
(248, 14, '1709111872.png', '1709111872.png', 'Construction Services', 'خدمات البناء والإنشاءات', 'Services de construction et d\'construction', NULL, '2024-02-28 09:17:52'),
(249, 15, '1709210561.png', '1709210561.png', 'Move Inside country', 'نقل داخل البلاد', 'Déplacer à l\'intérieur du pays', NULL, '2024-02-29 12:42:42'),
(250, 15, '1709210571.png', '1709210571.png', 'Move outside country', 'التحرك خارج البلاد', 'Déplacer hors du pays', NULL, '2024-02-29 12:42:51'),
(251, 15, '1709210582.png', '1709210582.png', 'Other', 'أخرى', 'Autre', NULL, '2024-02-29 12:43:02'),
(252, 16, '1709210687.png', '1709210687.png', 'Companies transport', 'نقل الشركات', 'Transport d\'entreprises', NULL, '2024-02-29 12:44:47'),
(253, 16, '1709210695.png', '1709210695.png', 'Women`s Taxi', 'تاكسي النساء', 'Taxi pour femmes', NULL, '2024-02-29 12:44:55'),
(254, 16, '1709210710.png', '1709210710.png', 'Students transport', 'نقل الطلاب', 'Transport d\'étudiants', NULL, '2024-02-29 12:45:11'),
(255, 16, '1709210727.png', '1709210726.png', 'Individual Transport', 'نقل فردي', 'Transport individuel', NULL, '2024-02-29 12:45:27'),
(256, 17, '1709212947.png', '1709212947.png', 'Home decor', 'ديكور المنزل', 'Décoration d\'intérieur', NULL, '2024-02-29 13:22:28'),
(257, 17, '1709212958.png', '1709212958.png', 'Entrance decor', 'ديكور المدخل', 'Décoration d\'entrée', NULL, '2024-02-29 13:22:38'),
(258, 17, '1709214302.png', '1709214302.png', 'Outdoor decor', 'ديكور خارجي', 'Décoration extérieure', NULL, '2024-02-29 13:45:03'),
(259, 17, '1709212996.png', '1709212996.png', 'Wallpapers', 'خلفيات', 'Papiers peints', NULL, '2024-02-29 13:23:16'),
(260, 17, '1709213050.png', '1709213050.png', 'Gypsum', 'جبس', 'Plâtre', NULL, '2024-02-29 13:24:10'),
(261, 17, '1709213301.png', '1709213301.png', 'Curtains', 'ستائر', 'Rideaux', NULL, '2024-02-29 13:28:22'),
(262, 17, '1709213311.png', '1709213311.png', 'Others', 'أخرى', 'Autres', NULL, '2024-02-29 13:28:31'),
(263, 18, '1709214318.png', '1709214318.png', 'Seeds & seedlings', 'بذور وشتلات', 'Graines et plants', NULL, '2024-02-29 13:45:18'),
(264, 18, '1709214329.png', '1709214329.png', 'Fertilizers', 'أسمدة', 'Engrais', NULL, '2024-02-29 13:45:30'),
(265, 18, '1709214335.png', '1709214335.png', 'Irrigation', 'ري', 'Irrigation', NULL, '2024-02-29 13:45:35'),
(266, 18, '1709214343.png', '1709214343.png', 'Gardening', 'حدائق', 'Jardinage', NULL, '2024-02-29 13:45:43'),
(267, 18, '1709214363.png', '1709214363.png', 'Garden decor', 'ديكور الحدائق', 'Décoration de jardin', NULL, '2024-02-29 13:46:06'),
(268, 18, '1709214381.png', '1709214381.png', 'Others', 'أخرى', 'Autres', NULL, '2024-02-29 13:46:22'),
(269, 19, '1709220652.png', '1709220652.png', 'Physics', 'فيزياء', 'Physique', NULL, '2024-02-29 15:30:52'),
(270, 19, '1709220667.png', '1709220667.png', 'Computer', 'حاسوب', 'Informatique', NULL, '2024-02-29 15:31:07'),
(271, 19, '1709220677.png', '1709220677.png', 'Science', 'علوم', 'Sciences', NULL, '2024-02-29 15:31:17'),
(272, 19, '1709220689.png', '1709220689.png', 'Chemistry', 'كيمياء', 'Chimie', NULL, '2024-02-29 15:31:29'),
(273, 19, '1709220699.png', '1709220699.png', 'Islamic', 'إسلامي', 'Islamique', NULL, '2024-02-29 15:31:39'),
(274, 19, '1709220714.png', '1709220714.png', 'University study', 'الدراسة الجامعية', 'Études universitaires', NULL, '2024-02-29 15:31:54'),
(275, 19, '1709220726.png', '1709220726.png', 'Mathematics', 'رياضيات', 'Mathématiques', NULL, '2024-02-29 15:32:06'),
(276, 19, '1709220738.png', '1709220738.png', 'English language', 'اللغة الإنجليزية', 'Langue anglaise', NULL, '2024-02-29 15:32:18'),
(277, 19, '1709220749.png', '1709220749.png', 'Arabic Language', 'اللغة العربية', 'Langue arabe', NULL, '2024-02-29 15:32:29'),
(278, 19, '1709220760.png', '1709220760.png', 'Other languages', 'لغات أخرى', 'Autres langues', NULL, '2024-02-29 15:32:40'),
(279, 19, NULL, NULL, 'Other Education', 'تعليم آخر', 'Autres enseignements', NULL, NULL),
(280, 20, '1709803411.png', '1709803411.png', 'Agriculture', 'الزراعة', 'Agriculture', NULL, '2024-03-07 09:23:33'),
(281, 20, '1709460840.png', '1709460840.png', 'Restaurants & Cafes', 'المطاعم والمقاهي', 'Restaurants et Cafés', NULL, '2024-03-03 10:14:01'),
(282, 20, '1709803437.png', '1709803437.png', 'Industry', 'الصناعة', 'Industrie', NULL, '2024-03-07 09:24:00'),
(283, 20, '1709460668.png', NULL, 'Services', 'الخدمات', 'Services', NULL, '2024-03-03 10:11:09'),
(284, 20, '1709460682.png', '1709460682.png', 'Animal Husbandry', 'تربية الحيوانات', 'Élevage', NULL, '2024-03-03 10:11:23'),
(285, 20, '1709460692.png', '1709460692.png', 'Laundry Shops', 'مغاسل', 'Pressings', NULL, '2024-03-03 10:11:32'),
(286, 20, '1709460704.png', '1709460704.png', 'Gyms', 'الصالات الرياضية', 'Salles de Sport', NULL, '2024-03-03 10:11:45'),
(287, 20, '1709460711.png', '1709460711.png', 'Websites & Mobile Apps', 'مواقع الويب وتطبيقات الهاتف المحمول', 'Sites Web et Applications Mobiles', NULL, '2024-03-03 10:11:51'),
(288, 20, '1709460730.png', '1709460730.png', 'Jewelry Shops', 'محلات المجوهرات', 'Bijouteries', NULL, '2024-03-03 10:12:10'),
(289, 20, '1709470088.png', '1709470088.png', 'Studios', 'استوديوهات', 'Studios', NULL, '2024-03-03 12:48:08'),
(290, 20, '1709470108.png', '1709470108.png', 'Salon & Spa', 'صالون وسبا', 'Salon et Spa', NULL, '2024-03-03 12:48:30'),
(291, 20, '1709470134.png', '1709470134.png', 'Bakery & Kitchens', 'مخابز ومطابخ', 'Boulangeries et Cuisines', NULL, '2024-03-03 12:48:54'),
(292, 20, '1709470151.png', '1709470151.png', 'Retail Stores', 'محلات بيع بالتجزئة', 'Magasins de détail', NULL, '2024-03-03 12:49:11'),
(293, 20, '1709470167.png', '1709470167.png', 'Tailor', 'خياط', 'Tailleur', NULL, '2024-03-03 12:49:28'),
(294, 20, '1709470179.png', '1709470179.png', 'Hospitality', 'ضيافة', 'Hôtellerie', NULL, '2024-03-03 12:49:39'),
(295, 20, NULL, NULL, 'Other Projects', 'مشاريع أخرى', 'Autres projets', NULL, NULL),
(296, 21, '1709470221.png', '1709470221.png', 'Translation services', 'خدمات الترجمة', 'Services de traduction', NULL, '2024-03-03 12:50:21'),
(297, 21, '1709470240.png', '1709470239.png', 'Clearing Services', 'خدمات التخليص', 'Services de dédouanement', NULL, '2024-03-03 12:50:44'),
(298, 21, '1709470258.png', '1709470258.png', 'Companies Services', 'خدمات الشركات', 'Services aux entreprises', NULL, '2024-03-03 12:50:58'),
(299, 21, NULL, NULL, 'Other Services', 'خدمات أخرى', 'Autres services', NULL, NULL),
(300, 22, '1709471268.png', '1709471268.png', 'Sanitation', 'تطهير', 'Assainissement', NULL, '2024-03-03 13:07:48'),
(301, 22, '1709471276.png', '1709471276.png', 'Aluminum works', 'أعمال الألمنيوم', 'Travaux d\'aluminium', NULL, '2024-03-03 13:07:57'),
(302, 22, '1709471294.png', '1709471294.png', 'Blacksmith works', 'أعمال الحدادة', 'Travaux de serrurerie', NULL, '2024-03-03 13:08:15'),
(303, 22, '1709471308.png', '1709471308.png', 'Plumbing', 'سباكة', 'Plomberie', NULL, '2024-03-03 13:08:28'),
(304, 22, '1709471322.png', '1709471322.png', 'Electricity works', 'أعمال الكهرباء', 'Travaux d\'électricité', NULL, '2024-03-03 13:08:42'),
(305, 22, '1709471342.png', '1709471342.png', 'Carpentry', 'نجارة', 'Menuiserie', NULL, '2024-03-03 13:09:02'),
(306, 22, '1709471926.png', '1709471926.png', 'Painting works', 'أعمال الطلاء', 'Travaux de peinture', NULL, '2024-03-03 13:18:46'),
(307, 22, '1709471938.png', '1709471938.png', 'Others', 'أخرى', 'Autres', NULL, '2024-03-03 13:18:58'),
(308, 23, '1709477385.png', NULL, 'Spa & Saloon', 'صالون وسبا', 'Spa & Salon', NULL, '2024-03-03 14:49:45'),
(309, 23, '1709477408.png', '1709477408.png', 'Sales & Retail', 'المبيعات والتجزئة', 'Ventes et vente au détail', NULL, '2024-03-03 14:50:08'),
(310, 23, '1709477421.png', '1709477421.png', 'Media & Journalism', 'وسائط الإعلام والصحافة', 'Médias et journalisme', NULL, '2024-03-03 14:50:21'),
(311, 23, '1709477437.png', '1709477437.png', 'Customer Service', 'خدمة العملاء', 'Service client', NULL, '2024-03-03 14:50:37'),
(312, 23, '1709477450.png', '1709477450.png', 'Hospitality', 'ضيافة', 'Hôtellerie', NULL, '2024-03-03 14:50:50'),
(313, 23, '1709477526.png', '1709477526.png', 'Logistics', 'الخدمات اللوجستية', 'Logistique', NULL, '2024-03-03 14:52:06'),
(314, 23, '1709477537.png', '1709477537.png', 'Guards & Security', 'حراسة وأمن', 'Gardiens et sécurité', NULL, '2024-03-03 14:52:17'),
(315, 23, '1709477551.png', '1709477551.png', 'Education & Training', 'التعليم والتدريب', 'Éducation et formation', NULL, '2024-03-03 14:52:31'),
(316, 23, '1709477561.png', '1709477561.png', 'Human Resources', 'الموارد البشرية', 'Ressources humaines', NULL, '2024-03-03 14:52:41'),
(317, 23, '1709477573.png', '1709477573.png', 'Industrial Manufacturing', 'تصنيع صناعي', 'Fabrication industrielle', NULL, '2024-03-03 14:52:53'),
(318, 23, '1709477588.png', '1709477588.png', 'Technicians & Workers', 'فنيون وعمال', 'Techniciens et ouvriers', NULL, '2024-03-03 14:53:08'),
(319, 23, '1709477606.png', '1709477606.png', 'Nanny', 'جليسة أطفال', 'Nounou', NULL, '2024-03-03 14:53:27'),
(320, 23, '1709477620.png', '1709477620.png', 'Legal', 'قانوني', 'Juridique', NULL, '2024-03-03 14:53:40'),
(321, 23, '1709477640.png', '1709477640.png', 'Drivers & Delivery', 'السائقين والتوصيل', 'Chauffeurs et livraison', NULL, '2024-03-03 14:54:00'),
(322, 23, '1709477652.png', '1709477652.png', 'Healthcare & Nursing', 'الرعاية الصحية والتمريض', 'Santé et soins infirmiers', NULL, '2024-03-03 14:54:12'),
(323, 23, '1709477760.png', '1709477760.png', 'Design & Art', 'تصميم وفنون', 'Design et art', NULL, '2024-03-03 14:56:00'),
(324, 23, '1709477780.png', '1709477780.png', 'Administration', 'الإدارة', 'Administration', NULL, '2024-03-03 14:56:20'),
(325, 23, '1709803544.png', '1709803544.png', 'IT & Technology', 'تكنولوجيا المعلومات والاتصالات', 'Informatique et technologie', NULL, '2024-03-07 09:25:44'),
(326, 23, '1709736133.png', '1709736133.png', 'Marketing & PR', 'التسويق والعلاقات العامة', 'Marketing et relations publiques', NULL, '2024-03-06 14:42:17'),
(327, 23, '1709736154.png', '1709736154.png', 'Engineering', 'هندسة', 'Ingénierie', NULL, '2024-03-06 14:42:34'),
(328, 23, '1709736126.png', '1709736126.png', 'Accounting & Finance', 'المحاسبة والتمويل', 'Comptabilité et finance', NULL, '2024-03-06 14:42:08'),
(329, 23, NULL, NULL, 'Other Business Jobs', 'وظائف أخرى في مجال الأعمال', 'Autres emplois d\'affaires', NULL, NULL),
(330, 24, '1709803864.png', '1709803864.png', 'Spa & Saloon', 'صالون وسبا', 'Spa & Salon', NULL, '2024-03-07 09:31:11'),
(331, 24, '1709803876.png', '1709803876.png', 'Industrial Manufacturing', 'تصنيع صناعي', 'Fabrication industrielle', NULL, '2024-03-07 09:31:18'),
(332, 24, '1709803889.png', '1709803889.png', 'Human Resources', 'الموارد البشرية', 'Ressources humaines', NULL, '2024-03-07 09:31:29'),
(333, 24, '1709803915.png', '1709803915.png', 'Education & Training', 'التعليم والتدريب', 'Éducation et formation', NULL, '2024-03-07 09:31:56'),
(334, 24, '1709803932.png', '1709803932.png', 'Guards & Security', 'حراسة وأمن', 'Gardiens et sécurité', NULL, '2024-03-07 09:32:12'),
(335, 24, '1709803941.png', '1709803941.png', 'Legal', 'قانوني', 'Juridique', NULL, '2024-03-07 09:32:22'),
(336, 24, '1709803956.png', '1709803956.png', 'Nanny', 'مربية', 'Nounou', NULL, '2024-03-07 09:32:36'),
(337, 24, '1709803973.png', '1709803973.png', 'Logistics', 'الخدمات اللوجستية', 'Logistique', NULL, '2024-03-07 09:32:53'),
(338, 24, '1709804002.png', '1709804001.png', 'IT & Technology', 'تكنولوجيا المعلومات والاتصالات', 'Informatique et technologie', NULL, '2024-03-07 09:33:24'),
(339, 24, '1709804009.png', '1709804009.png', 'Healthcare & Nursing', 'الرعاية الصحية والتمريض', 'Santé et soins infirmiers', NULL, '2024-03-07 09:33:29'),
(340, 24, '1709804026.png', '1709804025.png', 'Design & Art', 'تصميم وفنون', 'Design et art', NULL, '2024-03-07 09:33:46'),
(341, 24, '1709804038.png', '1709804038.png', 'Drivers & Delivery', 'السائقين والتوصيل', 'Chauffeurs et livraison', NULL, '2024-03-07 09:33:58'),
(342, 24, '1709804054.png', '1709804054.png', 'Engineering', 'هندسة', 'Ingénierie', NULL, '2024-03-07 09:34:14'),
(343, 24, '1709804224.png', '1709804224.png', 'Technicians & Workers', 'فنيون وعمال', 'Techniciens et ouvriers', NULL, '2024-03-07 09:37:09'),
(344, 24, '1709804255.png', '1709804255.png', 'Hospitality', 'ضيافة', 'Hospitalité', NULL, '2024-03-07 09:37:35'),
(345, 24, '1709804091.png', '1709804091.png', 'Accounting & Finance', 'المحاسبة والتمويل', 'Comptabilité et finance', NULL, '2024-03-07 09:34:52'),
(346, 24, '1709804116.png', '1709804116.png', 'Marketing & PR', 'التسويق والعلاقات العامة', 'Marketing et relations publiques', NULL, '2024-03-07 09:35:16'),
(347, 24, '1709804268.png', '1709804268.png', 'Sales & Retail', 'المبيعات والتجزئة', 'Ventes et vente au détail', NULL, '2024-03-07 09:37:48'),
(348, 24, '1709804288.png', '1709804288.png', 'Customer Service', 'خدمة العملاء', 'Service client', NULL, '2024-03-07 09:38:08'),
(349, 24, '1709804343.png', '1709804343.png', 'Media & Journalism', 'وسائط الإعلام والصحافة', 'Médias et journalisme', NULL, '2024-03-07 09:39:13'),
(350, 24, NULL, NULL, 'Other Jobs', 'وظائف أخرى', 'Autres emplois', NULL, NULL),
(351, 25, '1709552866.png', '1709552866.png', 'Activewear', 'ملابس رياضية', 'Vêtements de sport', NULL, '2024-03-04 11:47:46'),
(352, 25, '1709552889.png', '1709552889.png', 'Men\'s Accessories', 'إكسسوارات الرجال', 'Accessoires pour hommes', NULL, '2024-03-04 11:48:09'),
(353, 25, '1709552898.png', '1709552898.png', 'Men\'s Grooming', 'العناية بالرجل', 'Soins pour hommes', NULL, '2024-03-04 11:48:22'),
(354, 25, '1709552911.png', '1709552911.png', 'Belts', 'الأحزمة', 'Ceintures', NULL, '2024-03-04 11:48:32'),
(355, 25, '1709552933.png', '1709552933.png', 'Suits', 'البدلات', 'Costumes', NULL, '2024-03-04 11:48:53'),
(356, 25, '1709552952.png', '1709552952.png', 'Coats & Jackets', 'المعاطف والجواكيت', 'Manteaux et vestes', NULL, '2024-03-04 11:49:13'),
(357, 25, '1709552962.png', '1709552962.png', 'Shorts and Pants', 'الشورتات والبناطيل', 'Shorts et pantalons', NULL, '2024-03-04 11:49:23'),
(358, 25, '1709553003.png', '1709553003.png', 'Tops & Tees', 'القمم والتيشيرتات', 'Hauts et t-shirts', NULL, '2024-03-04 11:50:04'),
(359, 25, '1709553013.png', '1709553007.png', 'Arabian Clothing', 'الملابس العربية', 'Vêtements arabes', NULL, '2024-03-04 11:50:14'),
(360, 25, '1709553021.png', '1709553021.png', 'Masbha', 'مسبحة', 'Masbaha', NULL, '2024-03-04 11:50:21'),
(361, 25, '1709553048.png', '1709553048.png', 'Wallets & Bags', 'محافظ وحقائب', 'Portefeuilles et sacs', NULL, '2024-03-04 11:50:49'),
(362, 25, '1709553057.png', '1709553057.png', 'Eyewear', 'النظارات', 'Lunettes', NULL, '2024-03-04 11:50:57'),
(363, 25, '1709553085.png', '1709553085.png', 'Footwear', 'الأحذية', 'Chaussures', NULL, '2024-03-04 11:51:25'),
(364, 25, '1709553098.png', '1709553098.png', 'Fragrances', 'العطور', 'Parfums', NULL, '2024-03-04 11:51:38'),
(365, 25, '1709553172.png', '1709553172.png', 'Watches', 'الساعات', 'Montres', NULL, '2024-03-04 11:52:53'),
(366, 25, NULL, NULL, 'Other Men stuff', 'أشياء أخرى للرجال', 'Autres articles pour hommes', NULL, NULL),
(367, 26, '1709736238.png', '1709736238.png', 'Bottoms', 'القاع', 'Bas', NULL, '2024-03-06 14:44:00'),
(368, 26, '1709736266.png', '1709736266.png', 'Loungewear & Nightwear', 'ملابس المنزل والنوم', 'Vêtements de détente et de nuit', NULL, '2024-03-06 14:44:26'),
(369, 26, '1709556535.png', '1709556533.png', 'Activewear', 'ملابس رياضية', 'Vêtements de sport', NULL, '2024-03-04 12:49:05'),
(370, 26, '1709556601.png', '1709556601.png', 'Coats', 'معاطف', 'Manteaux', NULL, '2024-03-04 12:50:01'),
(371, 26, '1709556676.png', '1709556676.png', 'Jackets & Vests', 'جاكيتات وسترات', 'Vestes et gilets', NULL, '2024-03-04 12:51:17'),
(372, 26, '1709556678.png', '1709556678.png', 'Tops & Blouses', 'بلوزات وقمصان', 'Hauts et chemisiers', NULL, '2024-03-04 12:51:19'),
(373, 26, '1709556694.png', '1709556694.png', 'Beauty and Personal Care', 'الجمال والعناية الشخصية', 'Beauté et soins personnels', NULL, '2024-03-04 12:51:34'),
(374, 26, '1709556705.png', '1709556705.png', 'Women Accessories', 'إكسسوارات النساء', 'Accessoires pour femmes', NULL, '2024-03-04 12:51:47'),
(375, 26, '1709556733.png', '1709556733.png', 'Gold & Silver', 'ذهب وفضة', 'Or et argent', NULL, '2024-03-04 12:52:13'),
(376, 26, '1709556738.png', '1709556737.png', 'Jewelry', 'مجوهرات', 'Bijoux', NULL, '2024-03-04 12:52:18'),
(377, 26, '1709556761.png', '1709556761.png', 'Islamic & Modest Wear', 'الملابس الإسلامية والمتواضعة', 'Vêtements islamiques et modestes', NULL, '2024-03-04 12:52:42'),
(378, 26, '1709556784.png', '1709556784.png', 'Wallets', 'محافظ', 'Portefeuilles', NULL, '2024-03-04 12:53:05'),
(379, 26, '1709556896.png', '1709556896.png', 'Eyewear', 'نظارات', 'Lunettes', NULL, '2024-03-04 12:54:57'),
(380, 26, '1709556915.png', '1709556915.png', 'Fragrances', 'عطور', 'Parfums', NULL, '2024-03-04 12:55:15'),
(381, 26, '1709556971.png', '1709556971.png', 'Footwear', 'أحذية', 'Chaussures', NULL, '2024-03-04 12:56:11'),
(382, 26, '1709557117.png', '1709557117.png', 'Bags', 'حقائب', 'Sacs', NULL, '2024-03-04 12:58:39'),
(383, 26, '1709557132.png', '1709557132.png', 'Watches', 'ساعات', 'Montres', NULL, '2024-03-04 12:58:52'),
(384, 26, NULL, NULL, 'Dresses', 'فساتين', 'Robes', NULL, NULL),
(385, 26, '1709557225.png', '1709557225.png', 'Other Women Stuff', 'أشياء نسائية أخرى', 'Autres articles pour femmes', NULL, '2024-03-04 13:00:25'),
(386, 27, '1709557358.png', '1709557357.png', 'Toys & Games', 'ألعاب وألعاب', 'Jouets et jeux', NULL, '2024-03-04 13:02:41'),
(387, 27, '1709557378.png', '1709557378.png', 'Girls Fashion', 'أزياء الفتيات', 'Mode pour filles', NULL, '2024-03-04 13:02:59'),
(388, 27, '1709557397.png', '1709557397.png', 'Boys Fashion', 'أزياء الأولاد', 'Mode pour garçons', NULL, '2024-03-04 13:03:18'),
(389, 27, '1709736330.png', '1709736330.png', 'Baby Stuff', 'أشياء الأطفال', 'Affaires de bébé', NULL, '2024-03-06 14:45:30'),
(390, 27, NULL, NULL, 'Other kids Stuff', 'أشياء أطفال أخرى', 'Autres affaires pour enfants', NULL, NULL),
(391, 28, '1709636946.png', NULL, 'Kids Gifts', 'هدايا الأطفال', 'Cadeaux pour enfants', NULL, '2024-03-05 11:09:06'),
(392, 28, '1709636960.png', '1709636960.png', 'Home Gifts', 'هدايا المنزل', 'Cadeaux pour la maison', NULL, '2024-03-05 11:09:23'),
(393, 28, '1709636971.png', '1709636971.png', 'Men Gifts', 'هدايا الرجال', 'Cadeaux pour hommes', NULL, '2024-03-05 11:09:31'),
(394, 28, '1709636979.png', '1709636979.png', 'Flowers', 'زهور', 'Fleurs', NULL, '2024-03-05 11:09:39'),
(395, 28, '1709637007.png', '1709637007.png', 'Women Gifts', 'هدايا النساء', 'Cadeaux pour femmes', NULL, '2024-03-05 11:10:07'),
(396, 28, NULL, NULL, 'Other gifts', 'هدايا أخرى', 'Autres cadeaux', NULL, NULL),
(397, 29, '1709560621.png', '1709560621.png', 'Pizza', 'بيتزا', 'Pizza', NULL, '2024-03-04 13:57:02'),
(398, 29, '1709560637.png', '1709560637.png', 'Chocolate', 'شوكولاتة', 'Chocolat', NULL, '2024-03-04 13:57:17'),
(399, 29, '1709560691.png', '1709560691.png', 'Sandwiches', 'سندويشات', 'Sandwiches', NULL, '2024-03-04 13:58:12'),
(400, 29, '1709560703.png', '1709560703.png', 'Cookers', 'مواقد', 'Cuisinières', NULL, '2024-03-04 13:58:25'),
(401, 29, '1709560737.png', '1709560737.png', 'Lebanese Food', 'طعام لبناني', 'Nourriture libanaise', NULL, '2024-03-04 13:58:59'),
(402, 29, '1709560749.png', '1709560749.png', 'Cake', 'كعكة', 'Gâteau', NULL, '2024-03-04 13:59:12'),
(403, 29, '1709560772.png', '1709560772.png', 'Biscuit', 'بسكويت', 'Biscuit', NULL, '2024-03-04 13:59:33'),
(404, 29, '1709560784.png', '1709560784.png', 'Herbs and spices', 'أعشاب وتوابل', 'Herbes et épices', NULL, '2024-03-04 13:59:45'),
(405, 29, '1709560791.png', '1709560791.png', 'Egyptian Food', 'طعام مصري', 'Nourriture égyptienne', NULL, '2024-03-04 13:59:52'),
(406, 29, NULL, NULL, 'Gulf Food', 'طعام خليجي', 'Nourriture du Golfe', NULL, NULL),
(407, 29, '1709560813.png', '1709560813.png', 'Desserts', 'حلويات', 'Desserts', NULL, '2024-03-04 14:00:13'),
(408, 29, '1709560834.png', '1709560834.png', 'Arabian Food', 'طعام عربي', 'Nourriture arabe', NULL, '2024-03-04 14:00:34'),
(409, 29, '1709560843.png', '1709560842.png', 'Other Foods', 'أطعمة أخرى', 'Autres aliments', NULL, '2024-03-04 14:00:44'),
(410, 30, NULL, NULL, 'Headphones', 'سماعات رأس', 'Casques', NULL, NULL),
(411, 30, NULL, NULL, 'Smart Watches & Bands', 'ساعات ذكية وأشرطة', 'Montres intelligentes et bracelets', NULL, NULL),
(412, 30, NULL, NULL, 'Realme', 'ريلمي', 'Realme', NULL, NULL),
(413, 30, NULL, NULL, 'Xiaomi', 'شاومي', 'Xiaomi', NULL, NULL),
(414, 30, NULL, NULL, 'Huawei', 'هواوي', 'Huawei', NULL, NULL),
(415, 30, NULL, NULL, 'Samsung', 'سامسونج', 'Samsung', NULL, NULL),
(416, 30, NULL, NULL, 'Android Tablet', 'جهاز لوحي بنظام أندرويد', 'Tablette Android', NULL, NULL),
(417, 30, NULL, NULL, 'iPad', 'آيباد', 'iPad', NULL, NULL),
(418, 30, NULL, NULL, 'iPhone', 'آيفون', 'iPhone', NULL, NULL),
(419, 30, NULL, NULL, 'Other Android Mobiles', 'هواتف أندرويد أخرى', 'Autres téléphones Android', NULL, NULL),
(420, 30, NULL, NULL, 'Others', 'أخرى', 'Autres', NULL, NULL),
(423, 31, NULL, NULL, 'Printers & Ink', 'طابعات وحبر', 'Imprimantes et encre', NULL, NULL),
(424, 31, NULL, NULL, 'Computer Accessories', 'ملحقات الكمبيوتر', 'Accessoires informatiques', NULL, NULL),
(425, 31, NULL, NULL, 'Computers', 'حواسيب', 'Ordinateurs', NULL, NULL),
(426, 31, NULL, NULL, 'Laptops', 'أجهزة الكمبيوتر المحمولة', 'Ordinateurs portables', NULL, NULL),
(427, 31, NULL, NULL, 'Drones', 'طائرات بدون طيار', 'Drones', NULL, NULL),
(428, 31, NULL, NULL, 'Others electronics', 'إلكترونيات أخرى', 'Autres électroniques', NULL, NULL),
(429, 32, '1709805330.png', '1709805328.png', 'Dishwashers & Dryers', 'غسالات الصحون والمجففات', 'Lave-vaisselle et sèche-linge', NULL, '2024-03-07 09:55:30'),
(430, 32, '1709805336.png', '1709805335.png', 'Ranges', 'مواقد', 'Plaques de cuisson', NULL, '2024-03-07 09:55:36'),
(431, 32, '1709805344.png', '1709805344.png', 'Ovens & Microwaves', 'أفران وميكروويف', 'Fours et micro-ondes', NULL, '2024-03-07 09:55:46'),
(432, 32, '1709805359.png', '1709805359.png', 'Refrigerators & Freezers', 'ثلاجات ومجمدات', 'Réfrigérateurs et congélateurs', NULL, '2024-03-07 09:56:00'),
(433, 32, '1709805377.png', '1709805376.png', 'Kitchen Appliances', 'أجهزة المطبخ', 'Appareils de cuisine', NULL, '2024-03-07 09:56:21'),
(434, 32, '1709805392.png', '1709805392.png', 'Water Dispensers & Coolers', 'موزعات الماء ومبردات', 'Distributeurs et refroidisseurs d\'eau', NULL, '2024-03-07 09:56:32'),
(435, 32, '1709805414.png', '1709805414.png', 'Vacuum Cleaners', 'مكانس كهربائية', 'Aspirateurs', NULL, '2024-03-07 09:56:56'),
(436, 32, '1709805426.png', '1709805426.png', 'Water Heaters', 'سخانات المياه', 'Chauffe-eau', NULL, '2024-03-07 09:57:07'),
(437, 32, '1709805447.png', '1709805447.png', 'Washing Machines & Dryers', 'غسالات ومجففات', 'Lave-linge et sèche-linge', NULL, '2024-03-07 09:57:28'),
(438, 32, '1709805455.png', '1709805455.png', 'Parts & Accessories', 'قطع وملحقات', 'Pièces et accessoires', NULL, '2024-03-07 09:57:36'),
(439, 32, '1709805468.png', '1709805468.png', 'Televisions', 'أجهزة التلفزيون', 'Télévisions', NULL, '2024-03-07 09:57:49'),
(440, 32, '1709805478.png', '1709805478.png', 'Satellite & Accessories', 'أقمار صناعية وملحقات', 'Satellite et accessoires', NULL, '2024-03-07 09:57:59'),
(441, 32, NULL, NULL, 'Other Appliances', 'أجهزة أخرى', 'Autres appareils', NULL, NULL),
(442, 33, '1709649411.png', '1709649411.png', 'Security Cameras', 'كاميرات مراقبة', 'Caméras de sécurité', NULL, '2024-03-05 14:36:51'),
(443, 33, '1709649399.png', '1709649399.png', 'Canon', 'كانون', 'Canon', NULL, '2024-03-05 14:36:40'),
(444, 33, '1709649418.png', '1709649418.png', 'Nikon', 'نيكون', 'Nikon', NULL, '2024-03-05 14:36:58'),
(445, 33, '1709649432.png', '1709649432.png', 'Sony', 'سوني', 'Sony', NULL, '2024-03-05 14:37:12'),
(446, 33, '1709649443.png', '1709649443.png', 'GoPro', 'غوبرو', 'GoPro', NULL, '2024-03-05 14:37:23'),
(447, 33, '1709649463.png', '1709649463.png', 'FujiFilm', 'فوجي فيلم', 'FujiFilm', NULL, '2024-03-05 14:37:46'),
(448, 33, '1709649485.png', '1709649485.png', 'Leica', 'لايكا', 'Leica', NULL, '2024-03-05 14:38:05'),
(449, 33, '1709649504.png', '1709649504.png', 'Other Cameras', 'كاميرات أخرى', 'Autres appareils photo', NULL, '2024-03-05 14:38:24'),
(450, 34, '1709736523.png', '1709736523.png', 'PlayStation Games', 'ألعاب بلاي ستيشن', 'Jeux PlayStation', NULL, '2024-03-06 14:48:44'),
(451, 34, '1709649568.png', '1709649568.png', 'Playstation Devices', 'أجهزة بلاي ستيشن', 'Appareils PlayStation', NULL, '2024-03-05 14:39:29'),
(452, 34, '1709649578.png', '1709649578.png', 'Other Electronics Games', 'ألعاب إلكترونية أخرى', 'Autres jeux électroniques', NULL, '2024-03-05 14:39:39'),
(453, 34, '1709649597.png', '1709649597.png', 'XBox Games', 'ألعاب إكس بوكس', 'Jeux Xbox', NULL, '2024-03-05 14:39:57'),
(454, 34, '1709649605.png', '1709649605.png', 'XBox Devices', 'أجهزة إكس بوكس', 'Appareils Xbox', NULL, '2024-03-05 14:40:06'),
(455, 34, '1709736539.png', '1709736539.png', 'Wii Games', 'ألعاب وي', 'Jeux Wii', NULL, '2024-03-06 14:48:59'),
(456, 34, '1709649630.png', '1709649630.png', 'Wii Devices', 'أجهزة وي', 'Appareils Wii', NULL, '2024-03-05 14:40:31'),
(457, 35, '1709717110.png', '1709717109.png', 'Fitness Equipment', 'معدات اللياقة البدنية', 'Équipement de fitness', NULL, '2024-03-06 09:25:10'),
(458, 35, '1709717122.png', '1709717122.png', 'Sports', 'الرياضات', 'Sports', NULL, '2024-03-06 09:25:22');
INSERT INTO `categories` (`id`, `parent_id`, `image_app`, `image_web`, `name_en`, `name_ar`, `name_fr`, `created_at`, `updated_at`) VALUES
(459, 35, '1709717134.png', '1709717134.png', 'Sports Clothes & Shoes', 'ملابس وأحذية رياضية', 'Vêtements et chaussures de sport', NULL, '2024-03-06 09:25:34'),
(460, 35, '1709717140.png', '1709717140.png', 'Match Tickets', 'تذاكر المباريات', 'Billets de match', NULL, '2024-03-06 09:25:40'),
(461, 35, '1709717153.png', '1709717153.png', 'Massage & Relaxation', 'تدليك واسترخاء', 'Massage et relaxation', NULL, '2024-03-06 09:25:56'),
(462, 35, NULL, NULL, 'Others', 'أخرى', 'Autres', NULL, NULL),
(463, 36, '1709649724.png', '1709649724.png', 'Nursing Service', 'خدمة التمريض', 'Service de soins infirmiers', NULL, '2024-03-05 14:42:05'),
(464, 36, '1709649735.png', '1709649734.png', 'Special Needs', 'احتياجات خاصة', 'Besoins spéciaux', NULL, '2024-03-05 14:42:15'),
(465, 36, '1709649751.png', '1709649751.png', 'Alternative Medicine', 'الطب البديل', 'Médecine alternative', NULL, '2024-03-05 14:42:32'),
(466, 36, '1709649765.png', '1709649765.png', 'Healthy food', 'طعام صحي', 'Alimentation saine', NULL, '2024-03-05 14:42:46'),
(467, 36, '1709649780.png', '1709649780.png', 'Medical devices', 'أجهزة طبية', 'Appareils médicaux', NULL, '2024-03-05 14:43:01'),
(468, 36, NULL, NULL, 'Others', 'أخرى', 'Autres', NULL, NULL),
(469, 37, '1709724454.png', '1709724454.png', 'Kids Electric cars', 'سيارات كهربائية للأطفال', 'Voitures électriques pour enfants', NULL, '2024-03-06 11:27:34'),
(470, 37, '1709724461.png', '1709724461.png', 'Scooter', 'سكوتر', 'Scooter', NULL, '2024-03-06 11:27:41'),
(471, 37, '1709724481.png', '1709724481.png', 'Bicycle', 'دراجة هوائية', 'Vélo', NULL, '2024-03-06 11:28:01'),
(472, 37, '1709724520.png', '1709724520.png', 'Other Smart & Bicycle', 'أخرى', 'Autres', NULL, '2024-03-06 11:28:40'),
(473, 38, '1709724624.png', '1709724624.png', 'Hajj And Omara', 'الحج والعمرة', 'Hajj et Omara', NULL, '2024-03-06 11:30:25'),
(474, 38, '1709724631.png', '1709724631.png', 'Africa Tourism', 'سياحة أفريقيا', 'Tourisme en Afrique', NULL, '2024-03-06 11:30:32'),
(475, 38, '1709724644.png', '1709724644.png', 'Asia Tourism', 'سياحة آسيا', 'Tourisme en Asie', NULL, '2024-03-06 11:30:45'),
(476, 38, '1709724663.png', '1709724663.png', 'Internal Tourism', 'سياحة داخلية', 'Tourisme interne', NULL, '2024-03-06 11:31:03'),
(477, 38, '1709724683.png', '1709724683.png', 'Hotels', 'فنادق', 'Hôtels', NULL, '2024-03-06 11:31:24'),
(478, 38, '1709724695.png', '1709724693.png', 'Europe Tourism', 'سياحة أوروبا', 'Tourisme en Europe', NULL, '2024-03-06 11:31:35'),
(479, 38, '1709725289.png', '1709725289.png', 'Air Tickets', 'تذاكر طيران', 'Billets d\'avion', NULL, '2024-03-06 11:41:30'),
(480, 38, '1709724735.png', '1709724735.png', 'Tourist Services', 'خدمات سياحية', 'Services touristiques', NULL, '2024-03-06 11:32:15'),
(481, 38, '1709724752.png', '1709724752.png', 'Other Outside Tourism', 'أخرى', 'Autres', NULL, '2024-03-06 11:32:33'),
(482, 39, '1709725331.png', '1709725331.png', 'Tables & Chairs', 'طاولات وكراسي', 'Tables et chaises', NULL, '2024-03-06 11:42:12'),
(483, 39, '1709725348.png', '1709725348.png', 'Camping Kitchen', 'مطبخ التخييم', 'Cuisine de camping', NULL, '2024-03-06 11:42:29'),
(484, 39, '1709725354.png', '1709725354.png', 'Camping Coolers', 'مبردات التخييم', 'Glacières de camping', NULL, '2024-03-06 11:42:35'),
(485, 39, '1709725363.png', '1709725363.png', 'Flashlights & Lanterns', 'مصابيح يدوية ومشاعل', 'Lampes de poche et lanternes', NULL, '2024-03-06 11:42:44'),
(486, 39, '1709725369.png', '1709725369.png', 'Mattresses & Sleeping Bags', 'فرش وأكياس نوم', 'Matelas et sacs de couchage', NULL, '2024-03-06 11:42:49'),
(487, 39, '1709725396.png', '1709725396.png', 'Generators & Camping Needs', 'مولدات واحتياجات التخييم', 'Générateurs et besoins de camping', NULL, '2024-03-06 11:43:17'),
(488, 39, '1709725407.png', '1709725407.png', 'Tents', 'خيام', 'Tentes', NULL, '2024-03-06 11:43:28'),
(489, 39, '1709725434.png', '1709725434.png', 'Cabins', 'كبائن', 'Cabines', NULL, '2024-03-06 11:43:55'),
(490, 40, '1709725629.png', '1709725629.png', 'Cows', 'أبقار', 'Vaches', NULL, '2024-03-06 11:47:09'),
(491, 40, '1709725638.png', '1709725638.png', 'Horses', 'خيول', 'Chevaux', NULL, '2024-03-06 11:47:22'),
(492, 40, '1709725652.png', '1709725651.png', 'Camels', 'جمال', 'Chameaux', NULL, '2024-03-06 11:47:32'),
(493, 40, '1709725661.png', '1709725661.png', 'Sheep', 'خراف', 'Moutons', NULL, '2024-03-06 11:47:44'),
(494, 41, '1709725712.png', '1709725712.png', 'Deer', 'غزلان', 'Cerfs', NULL, '2024-03-06 11:48:32'),
(495, 41, '1709725750.png', '1709725750.png', 'Reptiles and amphibians', 'زواحف وبرمائيات', 'Reptiles et amphibiens', NULL, '2024-03-06 11:49:11'),
(496, 41, '1709725771.png', '1709725768.png', 'Rabbits', 'أرانب', 'Lapins', NULL, '2024-03-06 11:49:32'),
(497, 41, '1709725781.png', '1709725779.png', 'Turtles', 'سلاحف', 'Tortues', NULL, '2024-03-06 11:49:41'),
(498, 41, '1709725792.png', '1709725791.png', 'Cages', 'أقفاص', 'Cages', NULL, '2024-03-06 11:49:52'),
(499, 41, '1709725810.png', '1709725810.png', 'Fish', 'أسماك', 'Poissons', NULL, '2024-03-06 11:50:10'),
(500, 41, '1709725841.png', '1709725841.png', 'Cats', 'قطط', 'Chats', NULL, '2024-03-06 11:50:41'),
(501, 41, '1709726136.png', '1709726136.png', 'Guard Dogs', 'كلاب حراسة', 'Chiens de garde', NULL, '2024-03-06 11:55:37'),
(502, 41, '1709726152.png', '1709726152.png', 'Other Animals', 'حيوانات أخرى', 'Autres animaux', NULL, '2024-03-06 11:55:53'),
(503, 42, '1709726232.png', '1709726232.png', 'Conure', 'كونور', 'Conure', NULL, '2024-03-06 11:57:19'),
(504, 42, '1709726254.png', '1709726254.png', 'Ostrich', 'نعامة', 'Autruche', NULL, '2024-03-06 11:57:36'),
(505, 42, '1709726260.png', '1709726259.png', 'Myna bird', 'طائر المينا', 'Oiseau Myna', NULL, '2024-03-06 11:57:40'),
(506, 42, '1709726274.png', '1709726274.png', 'Poultry products', 'منتجات الدواجن', 'Produits avicoles', NULL, '2024-03-06 11:57:54'),
(507, 42, '1709729468.png', '1709729468.png', 'Albulabl', 'البلبل', 'Rossignol', NULL, '2024-03-06 12:51:08'),
(508, 42, '1709726597.png', '1709726597.png', 'Turkey', 'ديك رومي', 'Dinde', NULL, '2024-03-06 12:03:17'),
(509, 42, '1709726612.png', '1709726612.png', 'Ducks and geese', 'البط والأوز', 'Canards et oies', NULL, '2024-03-06 12:03:33'),
(510, 42, '1709726640.png', '1709726623.png', 'Hassoun', 'حسون', 'Hassoun', NULL, '2024-03-06 12:04:01'),
(511, 42, '1709726666.png', '1709726666.png', 'Birds Alfeins', 'طيور الفين', 'Oiseaux Alfeins', NULL, '2024-03-06 12:04:27'),
(512, 42, '1709726678.png', '1709726678.png', 'Macaws', 'الببغاوات', 'Ara', NULL, '2024-03-06 12:04:39'),
(513, 42, '1709726689.png', '1709726689.png', 'Amazonian', 'الأمازونية', 'Amazone', NULL, '2024-03-06 12:04:49'),
(514, 42, '1709726725.png', '1709726725.png', 'Cocktail And Curlew', 'كوكتيل وكركي', 'Cocktail et courlis', NULL, '2024-03-06 12:05:25'),
(515, 42, '1709726762.png', '1709726762.png', 'Love birds', 'طيور الحب', 'Perruches d\'amour', NULL, '2024-03-06 12:06:02'),
(516, 42, '1709726807.png', '1709726807.png', 'Albadji', 'البجي', 'Albadji', NULL, '2024-03-06 12:06:47'),
(517, 42, '1709726831.png', '1709726831.png', 'Cockat', 'الكاكاتوس', 'Cacatoès', NULL, '2024-03-06 12:07:11'),
(518, 42, '1709726840.png', '1709726839.png', 'Alexandrine', 'ألكساندراين', 'Alexandrine', NULL, '2024-03-06 12:07:20'),
(519, 42, '1709736699.png', '1709736699.png', 'Alcasko', 'الكسكو', 'Alcasko', NULL, '2024-03-06 14:51:41'),
(520, 42, '1709736708.png', '1709736708.png', 'Canary', 'الكناري', 'Canari', NULL, '2024-03-06 14:51:49'),
(521, 42, '1709726879.png', '1709726879.png', 'Hawks', 'الصقور', 'Faucons', NULL, '2024-03-06 12:08:00'),
(522, 42, '1709726883.png', '1709726883.png', 'Chicken', 'الدجاج', 'Poulet', NULL, '2024-03-06 12:08:05'),
(523, 42, '1709726896.png', '1709726896.png', 'Cages & animal accessories', 'أقفاص ومستلزمات الحيوانات', 'Cages et accessoires pour animaux', NULL, '2024-03-06 12:08:16'),
(524, 42, '1709729086.png', '1709729086.png', 'Pigeons and doves', 'الحمام والحمائم', 'Pigeons et colombes', NULL, '2024-03-06 12:44:46'),
(525, 42, '1709726931.png', '1709726931.png', 'Other Birds', 'طيور أخرى', 'Autres oiseaux', NULL, '2024-03-06 12:08:51'),
(526, 43, '1709729537.png', '1709729537.png', 'Books', 'كتب', 'Livres', NULL, '2024-03-06 12:52:18'),
(527, 43, '1709729552.png', '1709729552.png', 'Other Items', 'عناصر أخرى', 'Autres articles', NULL, '2024-03-06 12:52:33'),
(528, 44, '1709729178.png', '1709729178.png', 'Old Foreign Coins', 'عملات أجنبية قديمة', 'Vieilles pièces étrangères', NULL, '2024-03-06 12:46:19'),
(529, 44, '1709728722.png', '1709728722.png', 'Other Coins', 'عملات أخرى', 'Autres pièces', NULL, '2024-03-06 12:38:43'),
(530, 44, '1709728727.png', '1709728727.png', 'Old Stamps', 'طوابع قديمة', 'Vieux timbres', NULL, '2024-03-06 12:38:48'),
(531, 44, '1709728744.png', '1709728744.png', 'Old Arab Notes', 'أوراق عربية قديمة', 'Anciens billets arabes', NULL, '2024-03-06 12:39:04'),
(532, 44, '1709728758.png', '1709728758.png', 'Old Foreign Notes', 'أوراق أجنبية قديمة', 'Anciens billets étrangers', NULL, '2024-03-06 12:39:18'),
(533, 44, '1709728772.png', '1709728772.png', 'Old Arab coins', 'عملات عربية قديمة', 'Anciennes pièces arabes', NULL, '2024-03-06 12:39:34'),
(534, 45, '1709728799.png', '1709728799.png', 'Islamic Antique', 'تحف إسلامية', 'Antiquité islamique', NULL, '2024-03-06 12:39:59'),
(535, 45, '1709728816.png', '1709728816.png', 'Arab Antique', 'تحف عربية', 'Antiquité arabe', NULL, '2024-03-06 12:40:17'),
(536, 45, '1709728832.png', '1709728832.png', 'Foreign Antique', 'تحف أجنبية', 'Antiquité étrangère', NULL, '2024-03-06 12:40:33'),
(537, 45, '1709728840.png', '1709728840.png', 'Modern Antiques', 'تحف حديثة', 'Antiquités modernes', NULL, '2024-03-06 12:40:58'),
(538, 45, '1709728873.png', '1709728873.png', 'Monuments', 'معالم', 'Monuments', NULL, '2024-03-06 12:41:14'),
(539, 46, '1709728917.png', '1709728916.png', 'Food donations', 'تبرعات غذائية', 'Dons alimentaires', NULL, '2024-03-06 12:41:57'),
(540, 46, '1709728921.png', '1709728921.png', 'Lost and Found', 'الأشياء المفقودة والمعثور عليها', 'Objets perdus et trouvés', NULL, '2024-03-06 12:42:05'),
(541, 46, '1709728948.png', '1709728947.png', 'Clothing donations', 'تبرعات الملابس', 'Dons de vêtements', NULL, '2024-03-06 12:42:28'),
(542, 46, '1709728969.png', '1709728969.png', 'Furniture donations', 'تبرعات الأثاث', 'Dons de meubles', NULL, '2024-03-06 12:42:49'),
(543, 46, '1709728988.png', '1709728988.png', 'Other donations', 'تبرعات أخرى', 'Autres dons', NULL, '2024-03-06 12:43:09'),
(544, 47, '1709732711.png', NULL, 'Men stuff', 'أشياء الرجال', 'Affaires pour hommes', NULL, '2024-03-06 13:45:11'),
(545, 47, '1709732719.png', '1709732719.png', 'Special coins', 'عملات خاصة', 'Pièces spéciales', NULL, '2024-03-06 13:45:19'),
(546, 47, '1709732732.png', '1709732732.png', 'Mobiles numbers', 'أرقام المحمول', 'Numéros de téléphone mobiles', NULL, '2024-03-06 13:45:32'),
(547, 47, '1709732743.png', '1709732743.png', 'Decor & Agriculture', 'ديكور وزراعة', 'Décoration et agriculture', NULL, '2024-03-06 13:45:43'),
(548, 47, '1709732776.png', '1709732776.png', 'Lands', 'أراضي', 'Terrains', NULL, '2024-03-06 13:46:18'),
(549, 47, '1709732821.png', '1709732821.png', 'Camera & videos', 'كاميرا وفيديو', 'Appareil photo et vidéos', NULL, '2024-03-06 13:47:02'),
(550, 47, '1709732851.png', '1709732850.png', 'Tourism', 'سياحة', 'Tourisme', NULL, '2024-03-06 13:47:31'),
(551, 47, '1709732893.png', '1709732893.png', 'Move Furniture', 'نقل الأثاث', 'Déménagement de meubles', NULL, '2024-03-06 13:48:14'),
(552, 47, '1709733033.png', '1709733033.png', 'Occasions', 'مناسبات', 'Occasions', NULL, '2024-03-06 13:50:33'),
(553, 47, '1709733055.png', '1709733055.png', 'Gifts', 'هدايا', 'Cadeaux', NULL, '2024-03-06 13:50:55'),
(554, 47, '1709733070.png', '1709733070.png', 'Offshore Tools', 'أدوات البحرية', 'Outils offshore', NULL, '2024-03-06 13:51:10'),
(555, 47, '1709733073.png', '1709733073.png', 'Motorcycles', 'دراجات نارية', 'Motos', NULL, '2024-03-06 13:51:13'),
(556, 47, '1709733092.png', '1709733092.png', 'Heavy equipment', 'معدات ثقيلة', 'Équipement lourd', NULL, '2024-03-06 13:51:36'),
(557, 47, '1709733098.png', '1709733098.png', 'Smart & Bicycle', 'ذكي ودراجة', 'Smart & Vélo', NULL, '2024-03-06 13:51:51'),
(558, 47, '1709733155.png', '1709733155.png', 'Cleaning services', 'خدمات التنظيف', 'Services de nettoyage', NULL, '2024-03-06 13:52:35'),
(559, 47, '1709733174.png', '1709733174.png', 'Health', 'صحة', 'Santé', NULL, '2024-03-06 13:52:54'),
(560, 47, '1709733206.png', '1709733206.png', 'Electric tools', 'أدوات كهربائية', 'Outils électriques', NULL, '2024-03-06 13:53:26'),
(561, 47, '1709733207.png', '1709733206.png', 'Building materials', 'مواد بناء', 'Matériaux de construction', NULL, '2024-03-06 13:53:27'),
(562, 47, '1709733217.png', '1709733217.png', 'Wedding', 'زفاف', 'Mariage', NULL, '2024-03-06 13:53:38'),
(563, 47, '1709733231.png', '1709733231.png', 'Antiques', 'تحف', 'Antiquités', NULL, '2024-03-06 13:53:54'),
(564, 47, '1709733262.png', '1709733262.png', 'Games & Toys', 'ألعاب ولعب', 'Jeux et jouets', NULL, '2024-03-06 13:54:23'),
(565, 47, '1709733282.png', '1709733282.png', 'Sports & Hobbies', 'رياضات وهوايات', 'Sports et loisirs', NULL, '2024-03-06 13:54:42'),
(566, 47, '1709733300.png', '1709733298.png', 'Tickets & Vouchers', 'تذاكر وقسائم', 'Billets et bons', NULL, '2024-03-06 13:55:04'),
(567, 47, '1709733329.png', '1709733329.png', 'Books & Magazines', 'كتب ومجلات', 'Livres et magazines', NULL, '2024-03-06 13:55:29'),
(568, 47, '1709733390.png', '1709733389.png', 'Collectibles', 'تحف ومقتنيات', 'Objets de collection', NULL, '2024-03-06 13:56:30'),
(569, 47, '1709733410.png', '1709733410.png', 'Musical instruments', 'آلات موسيقية', 'Instruments de musique', NULL, '2024-03-06 13:56:50'),
(570, 47, '1709733425.png', '1709733425.png', 'Business & Industrial', 'أعمال وصناعة', 'Affaires et industrie', NULL, '2024-03-06 13:57:06'),
(571, 47, '1709736818.png', '1709736818.png', 'Services', 'خدمات', 'Services', NULL, '2024-03-06 14:53:38'),
(572, 47, '1709733444.png', '1709733444.png', 'Animals', 'حيوانات', 'Animaux', NULL, '2024-03-06 13:57:25'),
(573, 47, '1709733462.png', '1709733462.png', 'Electronics & Home Appliances', 'إلكترونيات وأجهزة منزلية', 'Électronique et électroménager', NULL, '2024-03-06 13:57:46'),
(574, 47, '1709733476.png', '1709733476.png', 'Cars', 'سيارات', 'Voitures', NULL, '2024-03-06 13:57:57'),
(575, 47, '1709733504.png', '1709733504.png', 'Real estate for sale', 'عقارات للبيع', 'Immobilier à vendre', NULL, '2024-03-06 13:58:24'),
(576, 47, '1709733534.png', '1709733534.png', 'Real estate for rent', 'عقارات للإيجار', 'Immobilier à louer', NULL, '2024-03-06 13:58:54'),
(577, 47, '1709733553.png', '1709733553.png', 'Jobs', 'وظائف', 'Emplois', NULL, '2024-03-06 13:59:13'),
(589, NULL, '1707309795.png', '1707309795.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:15', '2024-02-07 12:43:15'),
(590, NULL, '1707309800.png', '1707309800.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:20', '2024-02-07 12:43:20'),
(591, NULL, '1707309802.png', '1707309802.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:22', '2024-02-07 12:43:22'),
(592, NULL, '1707309804.png', '1707309804.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:25', '2024-02-07 12:43:25'),
(593, NULL, '1707309805.png', '1707309805.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:25', '2024-02-07 12:43:25'),
(594, NULL, '1707309809.png', '1707309809.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:29', '2024-02-07 12:43:29'),
(595, NULL, '1707309810.png', '1707309810.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:30', '2024-02-07 12:43:30'),
(596, NULL, '1707309812.png', '1707309812.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:32', '2024-02-07 12:43:32'),
(597, NULL, '1707309813.png', '1707309813.png', 'motor', 'موتور', 'motor', '2024-02-07 12:43:33', '2024-02-07 12:43:33'),
(598, NULL, '1707930271.png', '1707930271.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:31', '2024-02-14 17:04:31'),
(599, NULL, '1707930276.png', '1707930276.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:36', '2024-02-14 17:04:36'),
(600, NULL, '1707930282.png', '1707930282.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:42', '2024-02-14 17:04:42'),
(601, NULL, '1707930282.png', '1707930282.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:42', '2024-02-14 17:04:42'),
(602, NULL, '1707930282.png', '1707930282.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:42', '2024-02-14 17:04:42'),
(603, NULL, '1707930282.png', '1707930282.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:42', '2024-02-14 17:04:42'),
(604, NULL, '1707930282.png', '1707930282.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:04:43', '2024-02-14 17:04:43'),
(605, NULL, '1707930526.png', '1707930526.png', 'Test', 'تجربة', 'Test', '2024-02-14 17:08:46', '2024-02-14 17:08:46'),
(606, NULL, NULL, '1708502501.png', 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:01:41', '2024-02-21 08:01:41'),
(607, NULL, NULL, '1708502522.png', 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:02', '2024-02-21 08:02:02'),
(608, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:13', '2024-02-21 08:02:13'),
(609, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:14', '2024-02-21 08:02:14'),
(610, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:14', '2024-02-21 08:02:14'),
(611, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:14', '2024-02-21 08:02:14'),
(612, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:24', '2024-02-21 08:02:24'),
(613, NULL, NULL, NULL, 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:02:30', '2024-02-21 08:02:30'),
(614, NULL, NULL, '1708502599.png', 'Muhammad', 'محمد', 'Muhammad', '2024-02-21 08:03:19', '2024-02-21 08:03:19'),
(617, NULL, NULL, '1708605649.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:40:49', '2024-02-22 12:40:49'),
(618, NULL, NULL, '1708605671.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:41:11', '2024-02-22 12:41:11'),
(619, NULL, NULL, NULL, 'test english', 'test arabic', 'test french', '2024-02-22 12:44:30', '2024-02-22 12:44:30'),
(620, NULL, NULL, NULL, 'test english', 'test arabic', 'test french', '2024-02-22 12:51:14', '2024-02-22 12:51:14'),
(621, NULL, NULL, NULL, 'test english', 'test arabic', 'test french', '2024-02-22 12:51:21', '2024-02-22 12:51:21'),
(622, NULL, NULL, NULL, 'test english', 'test arabic', 'test french', '2024-02-22 12:51:23', '2024-02-22 12:51:23'),
(623, NULL, NULL, NULL, 'test english', 'test arabic', 'test french', '2024-02-22 12:51:31', '2024-02-22 12:51:31'),
(624, NULL, NULL, '1708606307.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:51:47', '2024-02-22 12:51:47'),
(625, NULL, NULL, '1708606317.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:51:57', '2024-02-22 12:51:57'),
(626, NULL, NULL, '1708606318.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:51:58', '2024-02-22 12:51:58'),
(627, NULL, NULL, '1708606319.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:51:59', '2024-02-22 12:51:59'),
(628, NULL, NULL, '1708606327.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:52:07', '2024-02-22 12:52:07'),
(629, NULL, NULL, '1708606328.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:52:08', '2024-02-22 12:52:08'),
(630, NULL, NULL, '1708606342.png', 'test english', 'test arabic', 'test french', '2024-02-22 12:52:22', '2024-02-22 12:52:22'),
(631, NULL, NULL, '1708607114.png', 'Muhammad', 'محمد', 'Muhammad', '2024-02-22 13:05:14', '2024-02-22 13:05:14'),
(632, NULL, NULL, NULL, 'test', 'test', 'test', '2024-02-22 13:12:44', '2024-02-22 13:12:44'),
(633, NULL, NULL, '1708607670.png', 'category', 'category', 'category', '2024-02-22 13:14:30', '2024-02-22 13:14:30'),
(636, NULL, '1708640336.png', '1708640336.png', 'lorem', 'lorem', 'lorem', '2024-02-22 22:18:56', '2024-02-22 22:18:56'),
(638, NULL, NULL, 'national_product.png', 'National Product', 'منتج وطني', 'Produit National', NULL, NULL),
(639, NULL, '1708955850.png', NULL, 'Mercedes', 'ميرسيدس', 'Mercedes', '2024-02-26 13:57:30', '2024-02-26 13:57:30'),
(640, NULL, '1708955980.png', NULL, 'Mercedes', 'ميرسيدس', 'Mercedes', '2024-02-26 13:59:40', '2024-02-26 13:59:40'),
(641, NULL, '1708956028.png', NULL, 'ah', 'ay', 'ah', '2024-02-26 14:00:28', '2024-02-26 14:00:28'),
(642, NULL, '1708956029.png', NULL, 'ah', 'ay', 'ah', '2024-02-26 14:00:29', '2024-02-26 14:00:29'),
(643, NULL, '1708956278.png', NULL, 'Mercedes', 'ميرسيدس', 'Mercedes', '2024-02-26 14:04:38', '2024-02-26 14:04:38');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` bigint UNSIGNED NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile` longtext COLLATE utf8mb4_unicode_ci,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `display_name`, `phone`, `profile`, `address`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Reham Ali', '01023284256', NULL, 'test', 'active', 2, '2024-01-22 11:41:39', '2024-03-10 08:29:51'),
(2, 'Reham Ali', '01023284265', 'https://business-egy.com/service/images/profiles/1708440120.png', NULL, 'active', 3, '2024-02-13 15:15:19', '2024-02-20 14:42:00'),
(3, 'Assem', '01125522530', NULL, NULL, 'active', 4, '2024-02-13 15:15:32', '2024-02-13 15:15:32'),
(4, 'Abdelrahman', '01016117548', NULL, NULL, 'active', 5, '2024-02-15 14:38:41', '2024-02-15 14:38:41'),
(5, 'lolllll', '01288965588', NULL, NULL, 'active', 8, '2024-02-15 14:50:44', '2024-02-15 14:50:44'),
(8, 'ahmed', '01000819184', NULL, NULL, 'active', 11, '2024-02-22 22:54:59', '2024-02-22 22:54:59'),
(9, 'Arplight', '01003793312', 'https://business-egy.com/service/images/profiles/1709107193.png', '71 port said.st', 'active', 12, '2024-02-25 08:10:59', '2024-02-28 08:00:04'),
(12, 'testy', '0100000000', NULL, NULL, 'active', 15, '2024-02-25 10:41:18', '2024-02-25 10:41:18'),
(13, 'hayam', '010232824789', NULL, NULL, 'active', 16, '2024-02-25 10:45:44', '2024-02-25 10:45:44'),
(14, 'M Mohsen', '01234567890', NULL, NULL, 'active', 17, '2024-03-10 07:26:30', '2024-03-10 07:26:30'),
(16, 'M Mohsen', '01234567890', NULL, NULL, 'active', 19, '2024-03-10 08:12:47', '2024-03-10 08:12:47'),
(17, 'M Mohsen', '01234567890', NULL, NULL, 'active', 20, '2024-03-10 08:13:22', '2024-03-10 08:13:22'),
(18, 'Reham Ali', '01023284265', NULL, NULL, 'active', 21, '2024-03-10 08:42:18', '2024-03-10 08:42:18'),
(19, 'Hello', '12345678912', NULL, NULL, 'active', 23, '2024-03-12 08:01:36', '2024-03-12 08:01:36');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint UNSIGNED NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile` longtext COLLATE utf8mb4_unicode_ci,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 10, '2024-02-20 12:34:44', '2024-02-20 12:34:44'),
(2, 12, '2024-02-26 12:33:57', '2024-02-26 12:33:57');

-- --------------------------------------------------------

--
-- Table structure for table `favourite_items`
--

CREATE TABLE `favourite_items` (
  `id` bigint UNSIGNED NOT NULL,
  `favourite_id` bigint UNSIGNED NOT NULL,
  `ad_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favourite_items`
--

INSERT INTO `favourite_items` (`id`, `favourite_id`, `ad_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2024-02-20 12:34:44', '2024-02-20 12:34:44'),
(2, 2, 21, '2024-02-26 12:33:57', '2024-02-26 12:33:57');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_05_14_081230_create_categories_table', 1),
(6, '2023_05_17_135302_create_roles_table', 1),
(7, '2023_05_17_135853_create_clients_table', 1),
(8, '2023_05_17_135900_create_admins_table', 1),
(9, '2023_05_21_095320_create_companies_table', 1),
(10, '2023_06_08_123301_add_fcm_tokens_to_users', 1),
(11, '2023_06_12_072114_create_promotion_plans_table', 1),
(12, '2023_06_12_073147_create_ads_table', 1),
(13, '2023_06_12_073405_create_attributes_table', 1),
(14, '2023_06_12_073406_create_attribute_options_table', 1),
(15, '2023_06_12_074614_create_ad_attribute_table', 1),
(16, '2023_06_12_082332_create_ad_images_table', 1),
(17, '2023_06_12_114623_create_likes_table', 1),
(18, '2023_06_12_114644_create_comments_table', 1),
(19, '2023_06_12_120423_create_banners_table', 1),
(20, '2023_06_22_115434_create_transactions_table', 1),
(21, '2023_06_25_101324_create_banner_prices_table', 1),
(22, '2023_06_25_113130_create_splash_ad_prices_table', 1),
(23, '2023_06_25_113137_create_splash_ads_table', 1),
(24, '2023_10_22_090123_drop_fcm_token_users', 1),
(25, '2023_11_09_123913_create_favourites_table', 1),
(26, '2023_11_09_125821_create_favourite_items_table', 1),
(27, '2023_11_12_133302_add_user_name_to_comments_table', 1),
(29, '2024_01_29_120716_create_wallets_table', 2),
(30, '2024_01_31_102754_create_jobs_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'API token of Reham Ali', '3e92fc4f9940d4e977421fb6a5a4d660f8f7eb6cd007ed354400496da3f80118', '[\"*\"]', '2024-01-23 06:30:12', NULL, '2024-01-22 11:41:39', '2024-01-23 06:30:12'),
(2, 'App\\Models\\User', 2, 'API token of Reham Ali', 'e7653f97b443ca8cde594982536a4ca213c9d9324db7cd08ff757f62fe846cc3', '[\"*\"]', '2024-01-25 06:32:20', NULL, '2024-01-23 06:45:54', '2024-01-25 06:32:20'),
(3, 'App\\Models\\User', 2, 'API token of Reham Ali', '8a0e65586e400519e319d396ac856a0d3248a9ba2b272881a3866c28a8b344ef', '[\"*\"]', NULL, NULL, '2024-02-04 10:17:13', '2024-02-04 10:17:13'),
(4, 'App\\Models\\User', 2, 'API token of Reham Ali', '854d17b9337e5d3e6ad06f61eefa0f3df8f58969320f3c9399476160ce2b702b', '[\"*\"]', NULL, NULL, '2024-02-04 10:28:28', '2024-02-04 10:28:28'),
(5, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a1c76c41fcdf7dfa8384b4d7bd2daee12c225b0400eb79f86b68887d85cd6f2c', '[\"*\"]', '2024-02-07 07:55:14', NULL, '2024-02-07 07:53:49', '2024-02-07 07:55:14'),
(6, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '932b9876c0880ef0f19c6f39fdb3f510a6a34fd02f2198482089c5d0f33034c7', '[\"*\"]', '2024-02-07 13:01:19', NULL, '2024-02-07 08:22:50', '2024-02-07 13:01:19'),
(9, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '060a7491dde9d511a717fb0c9c8f0c748d3b98768da2cf3012a393b08cb6fe33', '[\"*\"]', '2024-02-07 10:51:43', NULL, '2024-02-07 10:51:15', '2024-02-07 10:51:43'),
(10, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '0b264868a3460ea4b5cb50a538aa359e0b76bdf6d55ad59b2a566d64e683d134', '[\"*\"]', NULL, NULL, '2024-02-11 08:08:36', '2024-02-11 08:08:36'),
(11, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '723c90b0a79a6090ad7bad4220ff285732c99a2e6badb1c210dc278b6ab49c11', '[\"*\"]', '2024-02-11 08:44:57', NULL, '2024-02-11 08:12:46', '2024-02-11 08:44:57'),
(12, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '25dfbb034cfece10e41652ac7c91fd6ecf43b0d936bcda580475e4819d2ed663', '[\"*\"]', '2024-02-11 08:28:19', NULL, '2024-02-11 08:17:58', '2024-02-11 08:28:19'),
(13, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'ecc98c05cc39c34388a146b3502fa6b24428f1f82f344f630a5ce7b7b5b085b0', '[\"*\"]', NULL, NULL, '2024-02-11 09:10:43', '2024-02-11 09:10:43'),
(14, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'd7aa7d2c58881ad4daf8a234869a0e41d2af1c9da1ad4cad290465d000565885', '[\"*\"]', '2024-02-11 12:07:42', NULL, '2024-02-11 09:18:42', '2024-02-11 12:07:42'),
(15, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '40841dc239fccaaae93b973d0bddee094be2b156f27dc04d8628d284916d5026', '[\"*\"]', NULL, NULL, '2024-02-11 09:26:34', '2024-02-11 09:26:34'),
(16, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '43a48d082df1efeae981029b40f88e46c1d2412937c7a24a1761b5a00586cc1a', '[\"*\"]', '2024-02-12 12:34:46', NULL, '2024-02-12 12:29:28', '2024-02-12 12:34:46'),
(17, 'App\\Models\\User', 3, 'API token of Reham Ali', '21698f3875e547d4909fa15551d01c257e8f0f13821f0178d54899dce4c128e2', '[\"*\"]', NULL, NULL, '2024-02-13 15:15:19', '2024-02-13 15:15:19'),
(18, 'App\\Models\\User', 4, 'API token of Assem', '19c910287ca29364c93fb3e51afdee8876e2af4522f3210717d3ec5033df8873', '[\"*\"]', '2024-02-14 10:25:28', NULL, '2024-02-13 15:15:32', '2024-02-14 10:25:28'),
(19, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e8f479a9fdf8626989f28eb21e1894f0d5b275ac7c10207ed1ad43911bf7b86f', '[\"*\"]', '2024-03-10 10:51:13', NULL, '2024-02-13 15:15:57', '2024-03-10 10:51:13'),
(20, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '6004f887faae9090233ea45df4d90a308c4ad62cdec2584aa14e2d3c01c98912', '[\"*\"]', '2024-02-13 22:08:01', NULL, '2024-02-13 20:25:28', '2024-02-13 22:08:01'),
(21, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '6c7a05f3d8e6e74b3b151c4839acdbb70d3366c79b09f743d8555f40569ba4bc', '[\"*\"]', '2024-02-14 11:30:34', NULL, '2024-02-14 06:46:43', '2024-02-14 11:30:34'),
(22, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '17611ee41476b3c35e0138afe15c1b3a5bd63cdc50559d6d1fc871a354f1ef3a', '[\"*\"]', '2024-02-14 12:15:33', NULL, '2024-02-14 12:14:50', '2024-02-14 12:15:33'),
(23, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c2cfab48ff415e6dc62539e7d7be9e6020fb5755473f64d3cb6a3933f57b2b68', '[\"*\"]', '2024-02-14 13:32:40', NULL, '2024-02-14 13:04:13', '2024-02-14 13:32:40'),
(24, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '345fa99d4a50dc00a1008a3b3ed42d78e8360a25dac59a06a319b7006e62a3d4', '[\"*\"]', '2024-02-14 15:27:35', NULL, '2024-02-14 14:11:52', '2024-02-14 15:27:35'),
(25, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a31e7384f72a4176cde132416ebbf62109bf01df57b25b7eb6cb1422720bc2c0', '[\"*\"]', '2024-02-14 15:28:37', NULL, '2024-02-14 15:28:26', '2024-02-14 15:28:37'),
(26, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8df9f5b8b018415b1258d94c157bbcf80c50758cf43e1a3adf4020b24d3ce78b', '[\"*\"]', '2024-02-14 15:30:48', NULL, '2024-02-14 15:30:36', '2024-02-14 15:30:48'),
(27, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f0af6f58d21dc2e290074f845186fa567cc22dcb2f8b8053b715e5de2c52a358', '[\"*\"]', NULL, NULL, '2024-02-14 15:39:13', '2024-02-14 15:39:13'),
(28, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e19e2dd48f78b693086f21adf699809139f1127345e1e23d0a89b7070050d859', '[\"*\"]', '2024-02-14 15:41:43', NULL, '2024-02-14 15:41:29', '2024-02-14 15:41:43'),
(29, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '7393703bbec6930a6ae3e157c005fcdd6be022a6d896741aaf015bfa9ff00a36', '[\"*\"]', '2024-02-14 16:28:10', NULL, '2024-02-14 16:27:31', '2024-02-14 16:28:10'),
(30, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '533c79f12f75d018fc12630d865faa2b55bea349db6f4cb2f0564a9aac8fded3', '[\"*\"]', '2024-02-14 16:37:44', NULL, '2024-02-14 16:37:29', '2024-02-14 16:37:44'),
(31, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '4afc488a26e8babe604d1a48d1f0749f9cf79772d96604baf8126eb213f0730f', '[\"*\"]', '2024-02-14 16:56:29', NULL, '2024-02-14 16:42:15', '2024-02-14 16:56:29'),
(32, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'cd256f2169440f604d63fd0f32510faf4b85fdd3336428f8474181487ee10d39', '[\"*\"]', '2024-02-14 18:03:53', NULL, '2024-02-14 18:02:57', '2024-02-14 18:03:53'),
(33, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '703d33cd27ca03073c99fa503cb2b70269ab9b048cbf13131c4b5ed477dae9e3', '[\"*\"]', '2024-02-14 18:05:11', NULL, '2024-02-14 18:04:24', '2024-02-14 18:05:11'),
(34, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'aec2e9dbd9108853a4e2dc7c39f683056988b313aa520f25b2608a4b4631375d', '[\"*\"]', '2024-02-15 10:28:50', NULL, '2024-02-15 08:23:15', '2024-02-15 10:28:50'),
(35, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c22b6943ee6a39c62d7b6e226dd649bac0f78b44646962dbadedb3e2169d2774', '[\"*\"]', '2024-02-15 13:40:08', NULL, '2024-02-15 13:37:48', '2024-02-15 13:40:08'),
(36, 'App\\Models\\User', 5, 'API token of Abdelrahman', 'bf8907134c4e23ae54e68d58a781e5bf2f167545a6abebaf3abfa8f11b23ae8a', '[\"*\"]', '2024-02-26 10:23:23', NULL, '2024-02-15 14:38:41', '2024-02-26 10:23:23'),
(37, 'App\\Models\\User', 8, 'API token of lolllll', '5824f648add6002171c96cbcddc3d0c10ee39ee9a1990433a0ae35b493b9da4c', '[\"*\"]', '2024-02-15 14:50:46', NULL, '2024-02-15 14:50:44', '2024-02-15 14:50:46'),
(38, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '4f34da8a2079cd2875754f943390866b235376cb8bf4a9c4bca3ff79ffa02d52', '[\"*\"]', '2024-02-18 12:48:22', NULL, '2024-02-18 07:50:14', '2024-02-18 12:48:22'),
(39, 'App\\Models\\User', 2, 'API token of Reham Ali', '2c4d2bb6061630024f8a93637a3cade311f79c01d3a99fc1c5da64badf766681', '[\"*\"]', '2024-03-10 14:59:54', NULL, '2024-02-18 11:26:36', '2024-03-10 14:59:54'),
(41, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '0c84c13ea720e1aec10b2ca64fe3e22b82ce814c036a29cbee512587e342ebda', '[\"*\"]', '2024-02-18 12:08:29', NULL, '2024-02-18 12:07:53', '2024-02-18 12:08:29'),
(42, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c37bc529322f5687124683f77f1c93cf77f2ee3cecb297ed8ebc67306f42e237', '[\"*\"]', '2024-02-18 12:51:33', NULL, '2024-02-18 12:50:31', '2024-02-18 12:51:33'),
(43, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8ede3d6db7d52c85f92ee4ec715dd209186ad1697a35e221c3db6e7dff813d3e', '[\"*\"]', '2024-02-18 13:51:05', NULL, '2024-02-18 13:25:25', '2024-02-18 13:51:05'),
(44, 'App\\Models\\User', 2, 'API token of Reham Ali', 'cf80ed56cf7b6a224d98af6083623616a5997f97f51f7dabc16b016c3dea7e6f', '[\"*\"]', '2024-02-18 14:00:48', NULL, '2024-02-18 14:00:20', '2024-02-18 14:00:48'),
(45, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'fe0499e2ba3b40643cae2561df93abc80420251e7f57b734dddf1caddd69b5bd', '[\"*\"]', '2024-02-18 14:45:45', NULL, '2024-02-18 14:45:32', '2024-02-18 14:45:45'),
(46, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'b1b337ff5c7e30774fbc641802519b875bd8693878de47e8e7d8b7ae3ad12df7', '[\"*\"]', '2024-02-18 14:53:52', NULL, '2024-02-18 14:48:49', '2024-02-18 14:53:52'),
(47, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a767b45a6b6787e788033f907b8be6e876eb9f6887decb31fa4725ee908f155a', '[\"*\"]', '2024-02-18 15:06:03', NULL, '2024-02-18 15:05:40', '2024-02-18 15:06:03'),
(48, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '5c688b1a65df0afcffa953efbdc440f03afb7c062775bae23523c88a395588e3', '[\"*\"]', '2024-02-18 15:13:16', NULL, '2024-02-18 15:13:04', '2024-02-18 15:13:16'),
(49, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '13588383c498eb63f618086e13530be47d79c9dadaac8a90f7817466129e2bd2', '[\"*\"]', '2024-02-18 15:15:18', NULL, '2024-02-18 15:15:12', '2024-02-18 15:15:18'),
(50, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '9d05399b0fe2dbe2bbcccb91ab3c8710267df529ad7e508c4384103ca1fdc0e6', '[\"*\"]', '2024-02-18 15:21:23', NULL, '2024-02-18 15:18:48', '2024-02-18 15:21:23'),
(51, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a18fa3e8a51f391eb600297779cf230074d0d0b3ae15e98918071da5dc39e780', '[\"*\"]', '2024-02-18 15:30:20', NULL, '2024-02-18 15:28:23', '2024-02-18 15:30:20'),
(52, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '795864f8770a8e56bc376895880a67240a946256c72900b6fb963258b420629a', '[\"*\"]', '2024-02-18 15:57:29', NULL, '2024-02-18 15:29:12', '2024-02-18 15:57:29'),
(53, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2563cb60988daac885e11a7ae4b204a27f0e8307b821cc3f59cd80978b20e29c', '[\"*\"]', '2024-02-18 16:00:49', NULL, '2024-02-18 15:30:56', '2024-02-18 16:00:49'),
(54, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '23c3347b5508848df6c3ac072989f606e3225751678547537587ca8e177a294f', '[\"*\"]', '2024-02-19 07:31:23', NULL, '2024-02-19 07:31:06', '2024-02-19 07:31:23'),
(55, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '5d3a454ba1219a829337d93fef3aaebc79d55f30d10c2861d3009501f7b2814a', '[\"*\"]', '2024-02-19 09:01:20', NULL, '2024-02-19 07:54:53', '2024-02-19 09:01:20'),
(56, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c5d7e78cbfffc47895d53604e01a9e3c0c0efdb89f8f6d8d79b00d3887551630', '[\"*\"]', '2024-02-19 08:41:03', NULL, '2024-02-19 08:41:01', '2024-02-19 08:41:03'),
(58, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f3fe8639343b5591f3edd45f4b8d0c7705681081c6bf2687dd64e788bceb4166', '[\"*\"]', '2024-02-19 09:06:48', NULL, '2024-02-19 09:04:47', '2024-02-19 09:06:48'),
(59, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'fa02ba68e7144cf18a16d23bc2c18bf7ac548663deedba9d9e431a50c2179ffe', '[\"*\"]', '2024-02-19 13:18:08', NULL, '2024-02-19 10:14:30', '2024-02-19 13:18:08'),
(60, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '18f08f22469843e6e762cca3498373b5ffee8f7528de3db48c365609a262a5ef', '[\"*\"]', '2024-02-19 13:25:03', NULL, '2024-02-19 13:18:30', '2024-02-19 13:25:03'),
(61, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '181d04bbd66d11c85d6b783a7334f1cd612bf9e558b0a69b8377a916d63fede7', '[\"*\"]', '2024-02-19 13:24:25', NULL, '2024-02-19 13:23:26', '2024-02-19 13:24:25'),
(62, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'd2d0981b42213bcfc05c428c689bad876565571da804f93ef69c0d50c2171657', '[\"*\"]', '2024-02-19 13:32:42', NULL, '2024-02-19 13:32:39', '2024-02-19 13:32:42'),
(63, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '47893f74f11734462f430cce4a69456b0e99aa1e5d1ffcba3f6ebe7659b80059', '[\"*\"]', '2024-02-19 13:50:02', NULL, '2024-02-19 13:34:44', '2024-02-19 13:50:02'),
(64, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '583c33c3df7f61487eb57f7c3d41487437cf852570ed4b431326676547801f51', '[\"*\"]', NULL, NULL, '2024-02-19 13:57:27', '2024-02-19 13:57:27'),
(65, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'dadc3371f4f00f02dea69504298d95517d79396c61e02bd00e492e42e2fecbad', '[\"*\"]', NULL, NULL, '2024-02-19 14:58:05', '2024-02-19 14:58:05'),
(66, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'dbaf34e5ae38f56446e2743e0752a1d446bd0c8a44edbfc88c1ed09b1bf86223', '[\"*\"]', NULL, NULL, '2024-02-19 14:58:45', '2024-02-19 14:58:45'),
(67, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '9f944de310633060f757e5c44f45fe22c49c509cba28c28aa66c99a2a218c3c5', '[\"*\"]', '2024-02-19 18:58:36', NULL, '2024-02-19 18:46:17', '2024-02-19 18:58:36'),
(68, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '138a5fb20f3ef2aca52b225d8c1dc9b7a2490efffdada1f0b49b63cfae61f12b', '[\"*\"]', '2024-02-19 21:03:21', NULL, '2024-02-19 19:51:18', '2024-02-19 21:03:21'),
(69, 'App\\Models\\User', 2, 'API token of Reham Ali', 'e6c7f4e703992d245ea5b0302cd423ed81c63c2fe9ab7620573cbfda80c79dbb', '[\"*\"]', NULL, NULL, '2024-02-19 21:14:23', '2024-02-19 21:14:23'),
(70, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '7ba8d6c0343a9720d66e03d49f864821aa20acb48725c088a1cdf4d4c6ceb681', '[\"*\"]', '2024-02-20 10:13:25', NULL, '2024-02-20 10:12:41', '2024-02-20 10:13:25'),
(71, 'App\\Models\\User', 9, 'API token of user', '3a93f527314fb4b06e2948597d6d3f3bf5a820c654bbda52d3a1236717fa5363', '[\"*\"]', NULL, NULL, '2024-02-20 11:25:00', '2024-02-20 11:25:00'),
(72, 'App\\Models\\User', 9, 'API token of user', '8afad2448065e299942201c509f147ceda3e631a4f03d3440e111acf90e64a66', '[\"*\"]', NULL, NULL, '2024-02-20 11:25:29', '2024-02-20 11:25:29'),
(73, 'App\\Models\\User', 9, 'API token of user', 'e4bd6446960eaf1039ced188f75aefb75817c56c7f28e516d33ac674149f104d', '[\"*\"]', '2024-02-20 11:36:26', NULL, '2024-02-20 11:27:11', '2024-02-20 11:36:26'),
(74, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '517ffbdbb4e6cc7d0469be95d5cd862c0493eced5c5fdf212d089eedbd42dcc4', '[\"*\"]', '2024-02-20 11:39:56', NULL, '2024-02-20 11:36:38', '2024-02-20 11:39:56'),
(75, 'App\\Models\\User', 9, 'API token of user', '189d8d37de7ce8ae69fc3e3fcd7e4c910c274889904a07631899ab7caeaab912', '[\"*\"]', '2024-02-20 11:44:09', NULL, '2024-02-20 11:42:51', '2024-02-20 11:44:09'),
(76, 'App\\Models\\User', 9, 'API token of user', '5c3db2254ddd03d57952fa8c9fb67beaed457f28d602218ec5093c67d6051f8c', '[\"*\"]', '2024-02-20 12:21:45', NULL, '2024-02-20 11:51:09', '2024-02-20 12:21:45'),
(77, 'App\\Models\\User', 10, 'API token of muhammad', '2307acfd40140371bc54d4af5530b2fdb27170bb2e1d2f3409626cee8f8f4b19', '[\"*\"]', NULL, NULL, '2024-02-20 12:30:35', '2024-02-20 12:30:35'),
(78, 'App\\Models\\User', 10, 'API token of muhammad', 'fde8ec9e5e2a054424619ec82fb0819f8e22ed9389cb31e3e32cc3ebfbb447a3', '[\"*\"]', '2024-02-20 15:51:42', NULL, '2024-02-20 12:30:53', '2024-02-20 15:51:42'),
(79, 'App\\Models\\User', 2, 'API token of Reham Ali', '78ecb7645b885bf36a10769b65c3ab17f44b2721e7b690388b32820e7b120321', '[\"*\"]', '2024-02-20 13:57:28', NULL, '2024-02-20 13:52:32', '2024-02-20 13:57:28'),
(80, 'App\\Models\\User', 2, 'API token of Reham Ali', 'f67d593bae38778390d55867f319af06aabc9e73d8a7f31868ab4779efc9d647', '[\"*\"]', '2024-02-20 13:58:20', NULL, '2024-02-20 13:57:49', '2024-02-20 13:58:20'),
(81, 'App\\Models\\User', 2, 'API token of Reham Ali', 'bf1fd91cd8518a5285821f011d1331d5dcbd9381cec749842dd1c0d3ff479355', '[\"*\"]', '2024-02-20 14:00:24', NULL, '2024-02-20 13:59:17', '2024-02-20 14:00:24'),
(82, 'App\\Models\\User', 2, 'API token of Reham Ali', 'e4c90e9a5d76ce96f77ac54d954a3391ef9eb1f04fa4eec552ecaccffb2d348e', '[\"*\"]', '2024-02-20 14:05:37', NULL, '2024-02-20 14:02:45', '2024-02-20 14:05:37'),
(83, 'App\\Models\\User', 2, 'API token of Reham Ali', '83f9a6a4a3c0e3cbf400342051e41ec4f1794af9695892fc684526c2ade47d1a', '[\"*\"]', '2024-02-20 14:05:56', NULL, '2024-02-20 14:04:34', '2024-02-20 14:05:56'),
(84, 'App\\Models\\User', 2, 'API token of Reham Ali', 'c3850f4893f911a05dc060287f9543281cf8185977acc6b0182aba9e93c65c33', '[\"*\"]', '2024-02-20 14:13:49', NULL, '2024-02-20 14:06:29', '2024-02-20 14:13:49'),
(85, 'App\\Models\\User', 2, 'API token of Reham Ali', '892b98a535fd81baca556a023a58497f836733afc0ca9526c28b156da712e36d', '[\"*\"]', '2024-02-20 14:14:27', NULL, '2024-02-20 14:13:12', '2024-02-20 14:14:27'),
(86, 'App\\Models\\User', 2, 'API token of Reham Ali', '108e1902888a22f9a9d14e9e60a78399212cb4bb652a30bdde47abbb5d003e72', '[\"*\"]', NULL, NULL, '2024-02-20 14:16:10', '2024-02-20 14:16:10'),
(87, 'App\\Models\\User', 2, 'API token of Reham Ali', '80993dd1b068ab9e86fb06bf9e891cbf323ab9025cd5b33e6b3d2a22a5167e12', '[\"*\"]', '2024-02-20 14:17:41', NULL, '2024-02-20 14:16:18', '2024-02-20 14:17:41'),
(88, 'App\\Models\\User', 2, 'API token of Reham Ali', 'a0620eaee66f7b867b7e61aede9a53897ce62f17f8e0754744aea6b0aac5a93a', '[\"*\"]', '2024-02-20 14:42:00', NULL, '2024-02-20 14:40:32', '2024-02-20 14:42:00'),
(89, 'App\\Models\\User', 4, 'API token of Assem', 'c6a38b1e194b79e5d9cb6a65326ad3949e39d5952953070634a3c40f8ae8e2e2', '[\"*\"]', '2024-02-20 14:41:47', NULL, '2024-02-20 14:40:38', '2024-02-20 14:41:47'),
(90, 'App\\Models\\User', 2, 'API token of Reham Ali', 'bdd961711c8e91a99696522c7d4cb0b3405b1fb42f4a119cb30fcb5ef3d51e27', '[\"*\"]', '2024-02-20 15:49:17', NULL, '2024-02-20 15:16:53', '2024-02-20 15:49:17'),
(91, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2379ef1556109650a494e2077a5f3e28912bdf391b9952ff050f9c34a8791f11', '[\"*\"]', '2024-02-20 15:39:17', NULL, '2024-02-20 15:38:26', '2024-02-20 15:39:17'),
(92, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '65fa4a229c1a4bb99117756430e2d54d5fe1a40b25dedb7ef3e6fda7bb826900', '[\"*\"]', '2024-02-20 16:01:26', NULL, '2024-02-20 15:55:30', '2024-02-20 16:01:26'),
(93, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '3495bf92c48ca1b9df3a8aa204a376c7aab58e4cd0d0244f5b6994f36fddf2e8', '[\"*\"]', '2024-02-21 08:57:21', NULL, '2024-02-20 16:02:29', '2024-02-21 08:57:21'),
(94, 'App\\Models\\User', 9, 'API token of user', 'f8570fa58c871759a9225576b8c94636fcd1a21e59e3d5e69d761755f68f2623', '[\"*\"]', '2024-02-21 08:20:26', NULL, '2024-02-21 07:12:57', '2024-02-21 08:20:26'),
(95, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'fa93500fe8f5ff3193f8d49bb9da5a04c0f3e19bbde018d1b7b388f67d28edfc', '[\"*\"]', '2024-02-21 08:32:46', NULL, '2024-02-21 07:37:22', '2024-02-21 08:32:46'),
(96, 'App\\Models\\User', 2, 'API token of Reham Ali', '3f1f9e844cb4cfc46731dc91c9dda70a3573d33e09f22e525786bbcaea9670b4', '[\"*\"]', '2024-02-21 07:50:08', NULL, '2024-02-21 07:43:13', '2024-02-21 07:50:08'),
(97, 'App\\Models\\User', 2, 'API token of Reham Ali', '1969065bf1785bd17ce0b6b6e600a4945b60a40eee4201ad84a5b1bbde9b9ee1', '[\"*\"]', '2024-02-21 07:51:10', NULL, '2024-02-21 07:50:18', '2024-02-21 07:51:10'),
(98, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '79dcfbeb3f8a1ba44063af6c64d23ce9f4b53fcd105bfd3068f1d5e816e408c2', '[\"*\"]', '2024-02-21 08:04:40', NULL, '2024-02-21 07:53:50', '2024-02-21 08:04:40'),
(99, 'App\\Models\\User', 2, 'API token of Reham Ali', 'e2e33379b028863d1f28a93fd1e7449bf558b3fcbe09e20ad5d24fb717e78905', '[\"*\"]', '2024-02-21 08:18:30', NULL, '2024-02-21 08:16:07', '2024-02-21 08:18:30'),
(100, 'App\\Models\\User', 9, 'API token of user', 'e2d1e8f3fab9e39307b759a12a454f33454f1474d8266167ed1684f2bf02d930', '[\"*\"]', NULL, NULL, '2024-02-21 08:42:25', '2024-02-21 08:42:25'),
(101, 'App\\Models\\User', 9, 'API token of user', 'dde3c6d60d369d91c29ef377f5075c06ad7e467c96116c2f1978b4a66daeed72', '[\"*\"]', NULL, NULL, '2024-02-21 08:54:36', '2024-02-21 08:54:36'),
(102, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e6bc1ed1fb6d9e3ef1a6ad444534b44dedbc5c1cb27ddb4df3548f8b9c4049e5', '[\"*\"]', '2024-02-21 09:56:19', NULL, '2024-02-21 09:42:05', '2024-02-21 09:56:19'),
(103, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'b305f0cd8a5a92d707e24791670afcc7ba728f38330589a129fca64a95588f65', '[\"*\"]', NULL, NULL, '2024-02-21 10:37:52', '2024-02-21 10:37:52'),
(104, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f92ea3ac729fae13e9a086129f5fc98de313bdaf6153d6274797794668823b52', '[\"*\"]', '2024-02-21 10:38:55', NULL, '2024-02-21 10:38:52', '2024-02-21 10:38:55'),
(105, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8825dbb661278b6bac7cccd03b247ef7d7831c9ce98914e7d5bd880f5e52d0d7', '[\"*\"]', NULL, NULL, '2024-02-21 10:41:23', '2024-02-21 10:41:23'),
(106, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '807bdc8a520e8f73ee724a575760da4abeb9a41d998383f75d3d43a505c54b51', '[\"*\"]', '2024-02-22 16:10:05', NULL, '2024-02-22 07:50:15', '2024-02-22 16:10:05'),
(107, 'App\\Models\\User', 2, 'API token of Reham Ali', '1b702c79f083e164cd67c9ce33ef05364a1b0da38a7a4696d8a89d9ed7cafcc1', '[\"*\"]', NULL, NULL, '2024-02-22 07:56:46', '2024-02-22 07:56:46'),
(108, 'App\\Models\\User', 2, 'API token of Reham Ali', '63a39b5b041cc06e191dee220c7125a9637e80b6d0fc7d36ab0b4b8ef459fc29', '[\"*\"]', NULL, NULL, '2024-02-22 12:26:44', '2024-02-22 12:26:44'),
(109, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '086e51060563d16e0c3e9ac0a5d48947780ee4c8f288bf7c23b47fc771a0d91c', '[\"*\"]', NULL, NULL, '2024-02-22 14:59:14', '2024-02-22 14:59:14'),
(110, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '05aa50abc6e47140b7ea96f256d3e17f4fd4796bbbb9de063aa057024002778c', '[\"*\"]', '2024-02-22 16:06:09', NULL, '2024-02-22 15:57:16', '2024-02-22 16:06:09'),
(111, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '85c3509643bf32a3c7cc157859412280fbbba3fce04c8215bbb180134949618d', '[\"*\"]', NULL, NULL, '2024-02-22 16:27:10', '2024-02-22 16:27:10'),
(112, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'fee443ec697c7081266f12713d819195339c35d97cfca891cf06ec10d13baf99', '[\"*\"]', NULL, NULL, '2024-02-22 16:44:41', '2024-02-22 16:44:41'),
(113, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '5ba3d5345a09ea13df2b6efed67c587be94c36cf91acadef431ae43856746939', '[\"*\"]', NULL, NULL, '2024-02-22 20:23:33', '2024-02-22 20:23:33'),
(114, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a41ec44a8065255fcd314a2b6f7c963b21cc22fb7b5feaea14ffde92fad78727', '[\"*\"]', NULL, NULL, '2024-02-22 20:57:01', '2024-02-22 20:57:01'),
(115, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '993bf90174439011501098e5d76a072acb4eeb9853295f91a1958eae14db2a2c', '[\"*\"]', NULL, NULL, '2024-02-22 21:16:05', '2024-02-22 21:16:05'),
(116, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '335f33accb5389971b6f8c53ee25540c054bf998891350721f76b0aa8f418f9a', '[\"*\"]', NULL, NULL, '2024-02-22 21:42:41', '2024-02-22 21:42:41'),
(117, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'dd4e20683b1035ec541cb2b37d051aaf95986f821c4d553023a17b421f285d8e', '[\"*\"]', NULL, NULL, '2024-02-22 21:49:07', '2024-02-22 21:49:07'),
(118, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '1e092992adeea246921295cd39e5b4d75e26e4b0677a382ce49ece35dc197b40', '[\"*\"]', '2024-02-22 22:12:20', NULL, '2024-02-22 22:03:40', '2024-02-22 22:12:20'),
(119, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'aee134a347fc2df8bff8dffb3918447fd8215e86890ee124864c4c26fa80e59e', '[\"*\"]', NULL, NULL, '2024-02-22 22:04:28', '2024-02-22 22:04:28'),
(120, 'App\\Models\\User', 11, 'API token of ahmed', 'aee5b8c48107b514111ad60cd099f5da9530ed3ac4a9c55e3ab47d2fd5d565d3', '[\"*\"]', '2024-02-25 13:35:11', NULL, '2024-02-22 22:54:59', '2024-02-25 13:35:11'),
(121, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '88c3659cd3f6b963def95847d17e6ca7b4c1fbead0adae5d1d81a34cfeee108a', '[\"*\"]', NULL, NULL, '2024-02-23 11:30:39', '2024-02-23 11:30:39'),
(124, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'bd9a704dc733bb194f8504977d0d39cdc200ac5979318f9fdfd4415a9f41f0d4', '[\"*\"]', '2024-02-24 12:06:10', NULL, '2024-02-24 12:03:52', '2024-02-24 12:06:10'),
(125, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'a9467331d081953f3c318a26802249c0744f26f530f3d003aed55647e44c1c18', '[\"*\"]', NULL, NULL, '2024-02-24 14:59:50', '2024-02-24 14:59:50'),
(126, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'fccb4ce01a273731277bb66708f08693e697789bcc5db636929b76693024fae8', '[\"*\"]', '2024-02-24 15:41:34', NULL, '2024-02-24 15:40:09', '2024-02-24 15:41:34'),
(127, 'App\\Models\\User', 4, 'API token of Assem', '7b13a172001927770a3c7160989f8109b82811afccb95f3f900626513ee8d235', '[\"*\"]', '2024-03-05 08:24:16', NULL, '2024-02-24 19:05:59', '2024-03-05 08:24:16'),
(128, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f0e2bda0ca4aeb0143dd739b79a45f4277e6fce4471fc5fcae6685a1eb36c4dc', '[\"*\"]', '2024-02-24 19:34:04', NULL, '2024-02-24 19:33:59', '2024-02-24 19:34:04'),
(129, 'App\\Models\\User', 2, 'API token of Reham Ali', '885dfb2cb8ad5bb92757efd7f083a7e1933dd36b5e23186d2ff513e7cdde42f7', '[\"*\"]', NULL, NULL, '2024-02-24 19:40:51', '2024-02-24 19:40:51'),
(130, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '995a39011b0888f03d9d7f61d248af1bc74e37d9f3dd31059017081bb00224f3', '[\"*\"]', NULL, NULL, '2024-02-24 19:42:03', '2024-02-24 19:42:03'),
(131, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'b8fd8deb9a66fe1ba787960d106f2a8e81482775f3585f2c8f4a9a5da6f74142', '[\"*\"]', '2024-02-24 19:47:43', NULL, '2024-02-24 19:44:11', '2024-02-24 19:47:43'),
(132, 'App\\Models\\User', 2, 'API token of Reham Ali', 'c315a80b3c5bfd65db960543d967636254ab19dc061727f461f84ced2548a735', '[\"*\"]', '2024-02-24 19:52:13', NULL, '2024-02-24 19:50:02', '2024-02-24 19:52:13'),
(133, 'App\\Models\\User', 2, 'API token of Reham Ali', 'e7f5d6187aa84634961a3c523cd24a5cce7ec713cfd0ff83493eb8e9afd549b0', '[\"*\"]', '2024-02-24 20:18:03', NULL, '2024-02-24 20:00:40', '2024-02-24 20:18:03'),
(134, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f1127fa644d69a60e95b135a8f4a03ba9e4efe53c7815a7df67828a2886be067', '[\"*\"]', NULL, NULL, '2024-02-25 08:00:20', '2024-02-25 08:00:20'),
(135, 'App\\Models\\User', 12, 'API token of Muhammad', 'fba86b08bfd698c973fe2d2f1ee477024dc33caf13e96b0b0d349f98edce8974', '[\"*\"]', NULL, NULL, '2024-02-25 08:10:59', '2024-02-25 08:10:59'),
(136, 'App\\Models\\User', 12, 'API token of Muhammad', '6d08d0f3d5f10e6851bfbea3fceab52af632ee3414d34cc534b8c42bfd473efb', '[\"*\"]', '2024-02-25 08:19:07', NULL, '2024-02-25 08:11:09', '2024-02-25 08:19:07'),
(137, 'App\\Models\\User', 12, 'API token of Muhammad', '4d9e327a5c7e25fc38d2e2b0cbf968df6619abbfb76c82e18bd7288c06af3f2e', '[\"*\"]', '2024-02-25 08:37:46', NULL, '2024-02-25 08:36:57', '2024-02-25 08:37:46'),
(138, 'App\\Models\\User', 12, 'API token of Muhammad', 'e93500623c8697be350c3bbc562225355b97d99d51f9d9ed95f7e1abd838d47c', '[\"*\"]', '2024-02-25 09:09:16', NULL, '2024-02-25 09:01:50', '2024-02-25 09:09:16'),
(139, 'App\\Models\\User', 12, 'API token of Muhammad', '3859d86d701894bdb6a0590bcb0e5d1c5dc7b3a15ae8b85621b008b8f243beba', '[\"*\"]', '2024-02-25 09:33:13', NULL, '2024-02-25 09:10:24', '2024-02-25 09:33:13'),
(140, 'App\\Models\\User', 12, 'API token of Muhammad', '361834cf7d32296228299e8cad59281637b1c5e29c224d79a8ad55ecfa801861', '[\"*\"]', '2024-02-25 09:37:03', NULL, '2024-02-25 09:36:57', '2024-02-25 09:37:03'),
(141, 'App\\Models\\User', 12, 'API token of Muhammad', '8a05c50d165dbb859c04ababfc26ae676d670084ada7d0db3d4a2fbc2c6faa6b', '[\"*\"]', NULL, NULL, '2024-02-25 09:38:02', '2024-02-25 09:38:02'),
(142, 'App\\Models\\User', 12, 'API token of Muhammad', '1a565046a0188861ac92c77049ea3ab6d20ac16a370bc4ee5b4a6c59ee69ac9c', '[\"*\"]', '2024-02-25 09:38:23', NULL, '2024-02-25 09:38:17', '2024-02-25 09:38:23'),
(143, 'App\\Models\\User', 12, 'API token of Muhammad', '29f4fa2617693dbe68dc97f1ac4c541b247c933b180e0f25e1b9215084fefb77', '[\"*\"]', '2024-02-25 09:38:55', NULL, '2024-02-25 09:38:51', '2024-02-25 09:38:55'),
(144, 'App\\Models\\User', 12, 'API token of Muhammad', '898d4b06b4c1d668e865c297fb50e9dbe9034c7a86f0a90252be4fd60ce779c0', '[\"*\"]', NULL, NULL, '2024-02-25 09:45:19', '2024-02-25 09:45:19'),
(145, 'App\\Models\\User', 12, 'API token of Muhammad', 'c1c40910ee6887cd39417bb89e409a73db2b085ab78fb4a8ca066b40846711be', '[\"*\"]', '2024-02-25 09:47:01', NULL, '2024-02-25 09:45:26', '2024-02-25 09:47:01'),
(146, 'App\\Models\\User', 12, 'API token of Muhammad', '20a4be61eafb89af41b941f06694cf736603ada3ce4ea88493c263b4d5d25295', '[\"*\"]', '2024-02-25 09:47:26', NULL, '2024-02-25 09:47:21', '2024-02-25 09:47:26'),
(147, 'App\\Models\\User', 12, 'API token of Muhammad', 'cbf8b5d6b04ff51590e919c28aaacc71a4da961024959286bb108856ecbda573', '[\"*\"]', NULL, NULL, '2024-02-25 09:48:53', '2024-02-25 09:48:53'),
(148, 'App\\Models\\User', 12, 'API token of Muhammad', 'e3cafef34f97e5667c77c32cc82b4c8af7e3226ef6110ff828aa4d98b057d661', '[\"*\"]', NULL, NULL, '2024-02-25 09:57:36', '2024-02-25 09:57:36'),
(149, 'App\\Models\\User', 12, 'API token of Muhammad', '17972c54c139ddd225a2ed0c6daa240fe7602f5b718f79deb45bcd56cdc49109', '[\"*\"]', NULL, NULL, '2024-02-25 09:58:51', '2024-02-25 09:58:51'),
(150, 'App\\Models\\User', 12, 'API token of Muhammad', 'c6cb2c9b0d1aabb7f8a2064172a989b6196152cad709ebda53fdb8f33aea0625', '[\"*\"]', '2024-02-25 10:06:04', NULL, '2024-02-25 09:59:44', '2024-02-25 10:06:04'),
(151, 'App\\Models\\User', 12, 'API token of Muhammad', '01c897f0a160c8ea26500867b1b1a4dc8c321bc392ebc3444c0977d834ce233c', '[\"*\"]', '2024-02-25 10:07:13', NULL, '2024-02-25 10:07:01', '2024-02-25 10:07:13'),
(152, 'App\\Models\\User', 12, 'API token of Muhammad', '0f20da8c3cacfe7fb293443501b87e90bbaab0a4682b09956123681e208a797d', '[\"*\"]', '2024-02-25 10:07:47', NULL, '2024-02-25 10:07:40', '2024-02-25 10:07:47'),
(153, 'App\\Models\\User', 12, 'API token of Muhammad', 'd68aa532b4b5f54928bb280b105e237863c8f3f9e268dbe9e3f63a1818b7373f', '[\"*\"]', NULL, NULL, '2024-02-25 10:08:36', '2024-02-25 10:08:36'),
(154, 'App\\Models\\User', 12, 'API token of Muhammad', 'd71da0043fd06a095429b936d6458cadc1462a4d22a242502d34deac3cfb8b2c', '[\"*\"]', NULL, NULL, '2024-02-25 10:11:40', '2024-02-25 10:11:40'),
(155, 'App\\Models\\User', 12, 'API token of Muhammad', 'ce3f8c3992032c718fd110aa31b6d95fcd0ada1e725efb8fc166b75bbafc56fb', '[\"*\"]', '2024-02-25 10:13:34', NULL, '2024-02-25 10:13:24', '2024-02-25 10:13:34'),
(156, 'App\\Models\\User', 13, 'API token of client1', '732de2b4933704348c1235560cf3fdb4ec5e74d90c344f80b97d78de6bfc2aed', '[\"*\"]', NULL, NULL, '2024-02-25 10:16:38', '2024-02-25 10:16:38'),
(157, 'App\\Models\\User', 14, 'API token of Muhammad', '8988d6a2d394f592cc35066359ae64f5349b2f5ac6647f3107cca616a1900b77', '[\"*\"]', NULL, NULL, '2024-02-25 10:19:31', '2024-02-25 10:19:31'),
(158, 'App\\Models\\User', 14, 'API token of Muhammad', 'e0c0584ba91df4d3fafc834a8e573ede7be656a85369574eb423b5059f46e26d', '[\"*\"]', '2024-02-25 10:20:07', NULL, '2024-02-25 10:19:54', '2024-02-25 10:20:07'),
(159, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2abd32384693456a0a1e0250542cd969e0b837f5282aace9055197bc466c0181', '[\"*\"]', '2024-02-25 10:21:01', NULL, '2024-02-25 10:20:20', '2024-02-25 10:21:01'),
(160, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '0f0f7382dba9408834636e2264985ea7b8023715d135fd6a4e9b405f3166f6bd', '[\"*\"]', NULL, NULL, '2024-02-25 10:25:35', '2024-02-25 10:25:35'),
(161, 'App\\Models\\User', 15, 'API token of testy', '2b12584250eaa19862537ad07b7eec122d428f81f62f01e6f7043bdc31a25aca', '[\"*\"]', NULL, NULL, '2024-02-25 10:41:18', '2024-02-25 10:41:18'),
(162, 'App\\Models\\User', 15, 'API token of testy', '4b16513e9557cae7011f4bbb0dc2a44c33e0b75f6975e982797b94a0394d256f', '[\"*\"]', '2024-02-25 10:43:51', NULL, '2024-02-25 10:41:29', '2024-02-25 10:43:51'),
(163, 'App\\Models\\User', 16, 'API token of hayam', '26378e1d285838bef8e922d13274804995c26d3551949d230d682d6027c43e53', '[\"*\"]', NULL, NULL, '2024-02-25 10:45:44', '2024-02-25 10:45:44'),
(164, 'App\\Models\\User', 16, 'API token of hayam', 'f48c12a4ec275983baea7b210713f91bbf39380c005b92cfcd0187488d7bd358', '[\"*\"]', NULL, NULL, '2024-02-25 10:46:03', '2024-02-25 10:46:03'),
(165, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2625ac43b028b72b7fe1ddb5d14f2cc17c6b6d9d3ee710e20fe1d70c837f4e7c', '[\"*\"]', '2024-02-27 13:35:48', NULL, '2024-02-25 11:25:01', '2024-02-27 13:35:48'),
(166, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '53ab9fc6fbb152f249984a7099555f2e502600a5cf43f93e09b4ca5e9c87eb99', '[\"*\"]', '2024-02-25 11:34:38', NULL, '2024-02-25 11:34:34', '2024-02-25 11:34:38'),
(167, 'App\\Models\\User', 12, 'API token of Muhammad', '07d4a1ccc679cef44e6e6c199c66fa866326bfe06f27764631f8df36d15473b7', '[\"*\"]', '2024-02-25 12:06:37', NULL, '2024-02-25 12:06:33', '2024-02-25 12:06:37'),
(168, 'App\\Models\\User', 12, 'API token of Muhammad', 'f10a241a20407a74debe97c482433ed02725cdc65c1edd46b6e8d3cbde46288d', '[\"*\"]', '2024-02-25 12:21:14', NULL, '2024-02-25 12:21:09', '2024-02-25 12:21:14'),
(169, 'App\\Models\\User', 12, 'API token of Muhammad', '37cef145febe053eb07f30f66367ae791cbb707090f06d8d3781233177635828', '[\"*\"]', '2024-02-25 13:16:32', NULL, '2024-02-25 12:51:35', '2024-02-25 13:16:32'),
(170, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '9454fd290618ff87146daee64f8599a10cc1057b1d94419772b5847ac73ebc04', '[\"*\"]', '2024-02-25 13:19:29', NULL, '2024-02-25 13:17:49', '2024-02-25 13:19:29'),
(171, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '05da5ca2c59759403e7b049a3c0622a1e7f993ad42aea107f67ab82adf0180d8', '[\"*\"]', '2024-02-25 13:55:22', NULL, '2024-02-25 13:28:49', '2024-02-25 13:55:22'),
(172, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '6bac084e4ee42dd1c9f686dab5d27f334377cb61e4e5ea60f438f3247f7cb275', '[\"*\"]', '2024-02-25 13:45:20', NULL, '2024-02-25 13:45:02', '2024-02-25 13:45:20'),
(173, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f99884b0b9fedd84de0beffac5fcbb6b8e4a8412caacfb7f3f1a5e4d6b1fd086', '[\"*\"]', NULL, NULL, '2024-02-25 13:59:17', '2024-02-25 13:59:17'),
(174, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8b6f41a4aef048e904d9d055c0663b3050ce32bc276b61627aa7599327e3ab21', '[\"*\"]', '2024-02-25 15:15:06', NULL, '2024-02-25 15:02:21', '2024-02-25 15:15:06'),
(175, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '59e61e3000584606beca6e306a67d4f5fbafef914c705ed6c87f62a271d71dad', '[\"*\"]', '2024-02-25 16:05:35', NULL, '2024-02-25 15:31:54', '2024-02-25 16:05:35'),
(176, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2d78dc8b7df96f6a800e16b994cc4ace7bdb3868d1678e3ad30466e7e1144796', '[\"*\"]', '2024-02-25 15:54:40', NULL, '2024-02-25 15:48:05', '2024-02-25 15:54:40'),
(177, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f928e415d866e805252b2b83533743acae4d38042821116c09482fa6ce54045d', '[\"*\"]', '2024-02-26 07:09:40', NULL, '2024-02-26 07:03:17', '2024-02-26 07:09:40'),
(178, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'ba2bea92bf43205bb6a544d30e42ba1412e0747948bd1c6c5265631fd73c422b', '[\"*\"]', '2024-02-26 07:15:04', NULL, '2024-02-26 07:13:57', '2024-02-26 07:15:04'),
(179, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '3f4d8cc81bed0459bc826d7feedb21ddc3df8464999861850b2c6ed5e9c7b605', '[\"*\"]', '2024-02-26 07:20:27', NULL, '2024-02-26 07:17:57', '2024-02-26 07:20:27'),
(180, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '5c5fb99309ff027d64338893f1f82ff1f3829e7b0378511ae2a95a99d3670e10', '[\"*\"]', '2024-02-26 07:27:40', NULL, '2024-02-26 07:26:42', '2024-02-26 07:27:40'),
(181, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '6e4f1e479525ef06de24ede66159a7ab98a3110f3ef3a88fbeb5a0e3f70d3374', '[\"*\"]', NULL, NULL, '2024-02-26 08:28:44', '2024-02-26 08:28:44'),
(182, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'de4309b170a4a428a40b6f77c330a7a85f821223d7ec2e298ebc0647f349f153', '[\"*\"]', '2024-02-26 09:07:42', NULL, '2024-02-26 08:50:24', '2024-02-26 09:07:42'),
(183, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f57a30da552c1f33c8bab156a1ba2daf8df460efed2c995477b662a820879087', '[\"*\"]', '2024-02-26 09:10:49', NULL, '2024-02-26 09:10:07', '2024-02-26 09:10:49'),
(184, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f4b14b818ca6eec9b5953a0227253cd8d07085352ba8bc86e277b983cec38d4d', '[\"*\"]', '2024-02-26 09:14:20', NULL, '2024-02-26 09:12:38', '2024-02-26 09:14:20'),
(185, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e0590fd4a9d95897f06d1195898962c8d71b7794630548b33b5251758a5d6e82', '[\"*\"]', NULL, NULL, '2024-02-26 09:16:56', '2024-02-26 09:16:56'),
(186, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '45979331376b16a29c2994712d20719b0c8a7bf3a0bd932493564b9b6481726d', '[\"*\"]', '2024-02-26 09:25:17', NULL, '2024-02-26 09:20:27', '2024-02-26 09:25:17'),
(187, 'App\\Models\\User', 12, 'API token of Muhammad', '2377713cb651bd97306bd51a06ff426a4a3e27f918eb5db43bc03c9b0f7ec03a', '[\"*\"]', '2024-02-26 10:34:15', NULL, '2024-02-26 10:09:02', '2024-02-26 10:34:15'),
(188, 'App\\Models\\User', 12, 'API token of Muhammad', '283ce8e4050eeb5c59a2df8949e77723d846aba3be5e7dd4b38b0875bf41b353', '[\"*\"]', '2024-02-26 10:34:38', NULL, '2024-02-26 10:34:21', '2024-02-26 10:34:38'),
(189, 'App\\Models\\User', 12, 'API token of Muhammad', 'f8f467a51e6837fa4560a98e4981e0a861f8ada52dd8bf7549b095437ae26c99', '[\"*\"]', NULL, NULL, '2024-02-26 10:35:10', '2024-02-26 10:35:10'),
(190, 'App\\Models\\User', 12, 'API token of Muhammad', '046bfe1d9c876605db576f01293f60e46fa034b60f6c5da7849d9749cbf3240d', '[\"*\"]', NULL, NULL, '2024-02-26 11:41:42', '2024-02-26 11:41:42'),
(191, 'App\\Models\\User', 12, 'API token of Muhammad', '9b5e99bdca033434febad2bb9901e40c4f29397d7cc13966d2d05ef01bcc02fa', '[\"*\"]', '2024-02-26 13:12:13', NULL, '2024-02-26 12:29:16', '2024-02-26 13:12:13'),
(192, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'd6c5dc836fb78e42f80e4e5cd3391ba6f7cfd94f61b6e6f0a72f47b81719f3f0', '[\"*\"]', '2024-02-26 14:18:40', NULL, '2024-02-26 13:45:20', '2024-02-26 14:18:40'),
(193, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e8f7d4d32660f6dee5102c2fe1370e91bd4d3e403bf84fe61beed11d8c502bcd', '[\"*\"]', '2024-02-26 15:25:54', NULL, '2024-02-26 15:25:26', '2024-02-26 15:25:54'),
(194, 'App\\Models\\User', 12, 'API token of Muhammad', 'c5fc5b1dd23f496aae28d9836e56e0dbf6a2d25f8438a2fefd02df51b00d2ec5', '[\"*\"]', NULL, NULL, '2024-02-26 15:42:30', '2024-02-26 15:42:30'),
(195, 'App\\Models\\User', 12, 'API token of Muhammad', 'b925379a71f3f4461f6102909bb55dcd5ee44027a5f5568d66bdd5b9ccb7ae0f', '[\"*\"]', '2024-02-26 15:52:33', NULL, '2024-02-26 15:52:21', '2024-02-26 15:52:33'),
(196, 'App\\Models\\User', 12, 'API token of Muhammad', '1be247eac2afb3d041aabe7306d61c599da899bffc03edc5e6e4ded3d9a0825b', '[\"*\"]', '2024-02-26 15:53:34', NULL, '2024-02-26 15:53:28', '2024-02-26 15:53:34'),
(197, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '7dd32fa023f40c3acd04c26c16dd1ae6f28e39dfbce756a96f0b55ecfcc07d95', '[\"*\"]', '2024-02-26 20:57:44', NULL, '2024-02-26 20:57:32', '2024-02-26 20:57:44'),
(198, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8ff04c995588b6dedfaebca31ba594bd6fbcbeebc34d64a270f37384c231aad8', '[\"*\"]', NULL, NULL, '2024-02-26 20:58:26', '2024-02-26 20:58:26'),
(199, 'App\\Models\\User', 12, 'API token of Muhammad', '4b2399b08d431b3e9af9ec4d0585fbf6d8e860997fb6fce540b357ba74c662d8', '[\"*\"]', NULL, NULL, '2024-02-27 07:06:36', '2024-02-27 07:06:36'),
(200, 'App\\Models\\User', 12, 'API token of Muhammad', '9800059066fb25a8def8507bce824f4c47d05cb6067862a3580b1883821c4cf4', '[\"*\"]', '2024-02-27 08:10:03', NULL, '2024-02-27 07:30:19', '2024-02-27 08:10:03'),
(201, 'App\\Models\\User', 12, 'API token of Muhammad', '9bb4e9899a7bcb07b805b39253f18bf3813628dc9de270d6f8bae8882648b8c0', '[\"*\"]', NULL, NULL, '2024-02-27 08:11:04', '2024-02-27 08:11:04'),
(202, 'App\\Models\\User', 12, 'API token of Muhammad', '658d938373c8c3a62ab8d59849c42e4bb33e7bb21ec1b136aee71411ab114c16', '[\"*\"]', NULL, NULL, '2024-02-27 08:36:11', '2024-02-27 08:36:11'),
(203, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '3a6a1edcb76e5dc8a3e9b7139a643e72187f15573a93b314fe6e3697c8b06e3a', '[\"*\"]', '2024-02-27 14:27:36', NULL, '2024-02-27 09:08:19', '2024-02-27 14:27:36'),
(204, 'App\\Models\\User', 12, 'API token of Muhammad', 'a90e21fcab4f95ccc3cc4899b968d27727d5461ae7bc4d2ad4642f4d3e5e1d28', '[\"*\"]', NULL, NULL, '2024-02-27 10:21:06', '2024-02-27 10:21:06'),
(205, 'App\\Models\\User', 12, 'API token of Muhammad', '4e7bf24eb557db7f61f4a670060324ae27d99c2fde15d7e6665866dfc05fde4b', '[\"*\"]', NULL, NULL, '2024-02-27 10:21:07', '2024-02-27 10:21:07'),
(206, 'App\\Models\\User', 12, 'API token of Muhammad', '4ad81c8dfb965ef7933cf9901f9f6e9528f43d8186aae587d51b4171f89a9b2d', '[\"*\"]', NULL, NULL, '2024-02-27 10:21:07', '2024-02-27 10:21:07'),
(207, 'App\\Models\\User', 12, 'API token of Muhammad', 'f589e50f99b806929518ee9819498668d421766af07d514f9f1a01053a21374d', '[\"*\"]', NULL, NULL, '2024-02-27 10:33:36', '2024-02-27 10:33:36'),
(208, 'App\\Models\\User', 12, 'API token of Muhammad', '5d21c5c1f32535467e85aed63700b3e13c80cd25ab53013cf35fde3cfca352ad', '[\"*\"]', NULL, NULL, '2024-02-27 10:34:43', '2024-02-27 10:34:43'),
(209, 'App\\Models\\User', 12, 'API token of Muhammad', '2cbb29e41302a6519ce1756012cc3928927cd11391d0a02eaa93a000129934c4', '[\"*\"]', NULL, NULL, '2024-02-27 10:38:15', '2024-02-27 10:38:15'),
(210, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '4fafd621957dad8aa2673ffa1bb1c59e0802575af8a5036162849030360254d2', '[\"*\"]', NULL, NULL, '2024-02-28 07:25:34', '2024-02-28 07:25:34'),
(211, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f493731fc9c7a741711f46f262fcbc89ef0e82e1901f49610405ce09aaa7d4f0', '[\"*\"]', NULL, NULL, '2024-02-28 07:25:34', '2024-02-28 07:25:34'),
(212, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '3c29bdf57e88a0f9afa5ee6bb406f824fbb7f7bf0f168813cf60dc00903b9e64', '[\"*\"]', NULL, NULL, '2024-02-28 07:25:34', '2024-02-28 07:25:34'),
(213, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8e2026ea0b0ef72d9333050f50eb75b8aeb062f6a1f7406707ac6a5580364626', '[\"*\"]', NULL, NULL, '2024-02-28 07:25:34', '2024-02-28 07:25:34'),
(214, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '481404ddad7b870e23406fe1f1f00bcd72916e72207646bb33349b193894326c', '[\"*\"]', '2024-02-28 07:26:55', NULL, '2024-02-28 07:25:38', '2024-02-28 07:26:55'),
(215, 'App\\Models\\User', 12, 'API token of Muhammad', '2f6a4621fe56deb5596dfe26976e0d1dfc2e961f0f4d9a319b494c707bf8c9ca', '[\"*\"]', '2024-02-28 07:31:15', NULL, '2024-02-28 07:28:24', '2024-02-28 07:31:15'),
(216, 'App\\Models\\User', 12, 'API token of Muhammad', 'a1528af3f834743e416f1361473f5d3bade5bd8a456caa940d7fffee85ac6501', '[\"*\"]', '2024-02-28 07:42:42', NULL, '2024-02-28 07:42:01', '2024-02-28 07:42:42'),
(217, 'App\\Models\\User', 12, 'API token of Muhammad', 'bed21f408187a9d7f9c527465e3a03226a867d4b913a0e8211f882a68f041156', '[\"*\"]', '2024-02-28 07:44:38', NULL, '2024-02-28 07:42:50', '2024-02-28 07:44:38'),
(218, 'App\\Models\\User', 12, 'API token of Muhammad', 'f30ce481bb14770b7c102e76124c3cb87ff15a2d5b93a151177601d631b81091', '[\"*\"]', NULL, NULL, '2024-02-28 07:45:57', '2024-02-28 07:45:57'),
(219, 'App\\Models\\User', 12, 'API token of Muhammad', '77fbc5bec349c3e21fd6e48740b23dffa202cee69bd5577d6046bfc60e8fd181', '[\"*\"]', NULL, NULL, '2024-02-28 07:46:00', '2024-02-28 07:46:00'),
(220, 'App\\Models\\User', 12, 'API token of Muhammad', '758b93fa458e0aa7f78cb5057fc7f8681d2dde0d701f23945a65607dbb24dcec', '[\"*\"]', NULL, NULL, '2024-02-28 07:48:58', '2024-02-28 07:48:58'),
(221, 'App\\Models\\User', 12, 'API token of Muhammad', '49bc90e67ed3466076193790547c8acc8c2f14c4e19a231b2f7ea351940d24ce', '[\"*\"]', '2024-02-28 07:50:08', NULL, '2024-02-28 07:49:27', '2024-02-28 07:50:08'),
(222, 'App\\Models\\User', 12, 'API token of Muhammad', '17ae4a12df8a321b1292fdde52bae4750f60499ded748f3919ee50f6eb35205e', '[\"*\"]', NULL, NULL, '2024-02-28 07:50:50', '2024-02-28 07:50:50'),
(223, 'App\\Models\\User', 12, 'API token of Muhammad', 'ce2659511413a087888371b45f4f00f3a8d3f5bf9d0e9f02e9871023b48bd7c4', '[\"*\"]', '2024-02-28 07:56:07', NULL, '2024-02-28 07:52:38', '2024-02-28 07:56:07'),
(224, 'App\\Models\\User', 12, 'API token of Muhammad', '26482a53f0b4e76ab88169c3b8c2e4fab44941479d849dcd111f605fdb36b3cb', '[\"*\"]', '2024-02-28 08:01:01', NULL, '2024-02-28 07:57:05', '2024-02-28 08:01:01'),
(225, 'App\\Models\\User', 12, 'API token of Muhammad osama', '9cdfc2fdd1cc1279dcdb25391561f7d86ff61d4ecc2124d37042c040726aba7d', '[\"*\"]', NULL, NULL, '2024-02-28 11:21:58', '2024-02-28 11:21:58'),
(226, 'App\\Models\\User', 12, 'API token of Muhammad osama', '9a3dbeafe24cc9481d7d0c19b1c8c3c06a7c877c6ec7c96af95d80a8f1c1eba9', '[\"*\"]', '2024-02-28 11:42:52', NULL, '2024-02-28 11:24:24', '2024-02-28 11:42:52'),
(227, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '12b49deaaa83d57679d698c4e5346b886fc556bd66dfc4ff8df2936fc556f308', '[\"*\"]', NULL, NULL, '2024-02-28 11:46:42', '2024-02-28 11:46:42'),
(228, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c365fa818d436763e2f681c4d930f286fcc190c8f841e859e71983c611f17ae9', '[\"*\"]', '2024-02-28 12:07:32', NULL, '2024-02-28 12:04:29', '2024-02-28 12:07:32'),
(229, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'be0047950bf0626ca7fbf953d3aab470c741ebf4ea73b34b1e17a2f467bd644d', '[\"*\"]', '2024-02-28 12:11:04', NULL, '2024-02-28 12:09:40', '2024-02-28 12:11:04'),
(230, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e23799d9caffb169f7a13db645ddb2418214e1b4f7db42d226163ad736c5e1a4', '[\"*\"]', NULL, NULL, '2024-02-29 12:30:12', '2024-02-29 12:30:12'),
(231, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'bb6fa8674a71b33a30a1cef774512763280eedd1a250cf1705b9116ec89d7831', '[\"*\"]', NULL, NULL, '2024-03-03 10:09:19', '2024-03-03 10:09:19'),
(232, 'App\\Models\\User', 12, 'API token of Muhammad osama', 'ec9e1a50ddd6ce1f8d12e760e76407644968298fc9ce1cd6321263591e70b09c', '[\"*\"]', NULL, NULL, '2024-03-03 12:08:13', '2024-03-03 12:08:13'),
(233, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '097f0c80e01bb8cfdc28558e0e42b5aaf170986e25ca1efe32467799f07fe0b8', '[\"*\"]', '2024-03-03 12:43:01', NULL, '2024-03-03 12:09:06', '2024-03-03 12:43:01'),
(234, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'bf59a37f244625ddb78e93ae761e443fef7c9bdc39384d7ad7f21fdfa847e6c4', '[\"*\"]', NULL, NULL, '2024-03-03 14:26:52', '2024-03-03 14:26:52'),
(235, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '1469a32a2126a0d490ba5f442b970f960163f22dae289cf9eb8400ccc93bafba', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:30', '2024-03-04 10:22:30'),
(236, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '632e7de7661acf0450a7380fd4d97743dab87496e2966144f488f3c3fbbc535d', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:33', '2024-03-04 10:22:33'),
(237, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '08a419420fc9577a39bdf0cd066bd09c3d22cd789d94e056b4c3d3fac2096518', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:33', '2024-03-04 10:22:33'),
(238, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'bb7f8f1b7ceb584249bbc7ac4ea436cf6bbe36946abad63cfdc561d1acbacb58', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:35', '2024-03-04 10:22:35'),
(239, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '60080abd7587d2090ad99f4341a20f33e99573afde8a8e67caa7513cf6f74171', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:38', '2024-03-04 10:22:38'),
(240, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '52ce9b7b4fc069cbf691deba4963e779bf15f392beeba950143cef9c8af3cab1', '[\"*\"]', NULL, NULL, '2024-03-04 10:22:38', '2024-03-04 10:22:38'),
(241, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'd2cce67317d88a90d92c60494db50df872bb8141c546a12fce17605c8038a757', '[\"*\"]', '2024-03-04 14:39:00', NULL, '2024-03-04 10:22:45', '2024-03-04 14:39:00'),
(242, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '9593299f2885de914a71e701f019ab2a57566277f43d48fffa329148d9defdf0', '[\"*\"]', NULL, NULL, '2024-03-05 11:07:22', '2024-03-05 11:07:22'),
(243, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '8710d999bbaf2ef370a19af3f3a043f5c3e0ee3a3fdbda262d9721010fa8eca3', '[\"*\"]', NULL, NULL, '2024-03-06 09:15:44', '2024-03-06 09:15:44'),
(244, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'f99ce93fb49648c16ccbc869353dbf16245489d753edb61ee022fb2dda532f89', '[\"*\"]', NULL, NULL, '2024-03-07 09:16:56', '2024-03-07 09:16:56'),
(245, 'App\\Models\\User', 17, 'API token of M Mohsen', '865c68b031bc2ee2ca41aa6b9992ff37d48cedb868a5b62c5fc47ab0ac742d1d', '[\"*\"]', NULL, NULL, '2024-03-10 07:26:34', '2024-03-10 07:26:34'),
(246, 'App\\Models\\User', 18, 'API token of M Mohsen', 'd14c15f460d300466e0373b2dbdf06e70cad384bd8749d411c8c92fca1c8e636', '[\"*\"]', NULL, NULL, '2024-03-10 07:28:55', '2024-03-10 07:28:55');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(247, 'App\\Models\\User', 18, 'API token of M Mohsen', '09b8128a4c5ab1e0a3acee791d19530650c98ff722f50b91305dc8594a0320e8', '[\"*\"]', NULL, NULL, '2024-03-10 07:31:08', '2024-03-10 07:31:08'),
(248, 'App\\Models\\User', 18, 'API token of M Mohsen', '4a9e626075089a1293dfda1df09f9020dc4d842bd583667d482b2ec162285b04', '[\"*\"]', NULL, NULL, '2024-03-10 07:31:24', '2024-03-10 07:31:24'),
(249, 'App\\Models\\User', 18, 'API token of M Mohsen', '26b0c85992616bdc8b11f3485aa5ae000c705300c8114a27dded6b4eb3f0fd45', '[\"*\"]', NULL, NULL, '2024-03-10 07:31:31', '2024-03-10 07:31:31'),
(250, 'App\\Models\\User', 18, 'API token of M Mohsen', 'f7b0b57bbdf59d61d3a5097b6c78556fd9693f99669d9a292f27ea91aaef1e12', '[\"*\"]', NULL, NULL, '2024-03-10 07:31:40', '2024-03-10 07:31:40'),
(251, 'App\\Models\\User', 18, 'API token of M Mohsen', '767b430756b33e30d9f3d52a8f10544381e48b831923061dcec5c1019f97cf23', '[\"*\"]', NULL, NULL, '2024-03-10 07:31:48', '2024-03-10 07:31:48'),
(252, 'App\\Models\\User', 18, 'API token of M Mohsen', 'a6d80c68e79167180ee8a2c3f350495e0b23c6fee8b0c73567c88654abda8473', '[\"*\"]', NULL, NULL, '2024-03-10 07:32:22', '2024-03-10 07:32:22'),
(253, 'App\\Models\\User', 18, 'API token of M Mohsen', 'c6869d7c55da2af84f376be0afb7c0be538289df658ff5f0a613c5bc515d66fc', '[\"*\"]', NULL, NULL, '2024-03-10 07:33:51', '2024-03-10 07:33:51'),
(254, 'App\\Models\\User', 18, 'API token of M Mohsen', '72169620f69867bfe9636ba09bac3d75299e1d805511a0e8c00f6ee6f3b3ae62', '[\"*\"]', NULL, NULL, '2024-03-10 07:33:58', '2024-03-10 07:33:58'),
(255, 'App\\Models\\User', 18, 'API token of M Mohsen', 'f726d2d12e576c7c6a0475159eed94ace023a422e05643315e005093b7802bf0', '[\"*\"]', NULL, NULL, '2024-03-10 07:34:08', '2024-03-10 07:34:08'),
(256, 'App\\Models\\User', 18, 'API token of M Mohsen', '4912cdbdbeeeab84b46106ace335501f8fcf604674709c5e65f13fd45baeefc5', '[\"*\"]', NULL, NULL, '2024-03-10 07:34:19', '2024-03-10 07:34:19'),
(257, 'App\\Models\\User', 18, 'API token of M Mohsen', '623fea778cb6e29a6b6819c4e9328d958c028a5dbc23171c61d9d26c685ba8d3', '[\"*\"]', NULL, NULL, '2024-03-10 07:34:35', '2024-03-10 07:34:35'),
(258, 'App\\Models\\User', 18, 'API token of M Mohsen', 'b758df49e9b80751e0d0057c87a351cba7fee45bbb3c92fbca6e2c398b7a4654', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:00', '2024-03-10 07:35:00'),
(259, 'App\\Models\\User', 18, 'API token of M Mohsen', '59022c9daa469735e6445a0f7c214bfaf046a8c48ba3e83581883a946c246958', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:14', '2024-03-10 07:35:14'),
(260, 'App\\Models\\User', 18, 'API token of M Mohsen', '39420b89c1242775640fedf65d97e787b05434316f98c78f8b4bf916d4aeae88', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:29', '2024-03-10 07:35:29'),
(261, 'App\\Models\\User', 18, 'API token of M Mohsen', '972fbf9241f6f754736fcd4763f434236abec1b1945e6ca1c6d8e8369ca275b6', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:41', '2024-03-10 07:35:41'),
(262, 'App\\Models\\User', 18, 'API token of M Mohsen', '7eab82783fcc9d092617131e0df85b8d76ceacaffa8618f0621804a680dc7fb4', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:49', '2024-03-10 07:35:49'),
(263, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '14eeb9f5fb94ac5d142ad6eff0c0e4e4c877fd9b2d44c999f7cf538ccc945769', '[\"*\"]', '2024-03-10 09:08:31', NULL, '2024-03-10 07:35:54', '2024-03-10 09:08:31'),
(264, 'App\\Models\\User', 18, 'API token of M Mohsen', '5346590f6797d872efe710513734c41261b8794730e7d580ea0012383c56e654', '[\"*\"]', NULL, NULL, '2024-03-10 07:35:57', '2024-03-10 07:35:57'),
(265, 'App\\Models\\User', 18, 'API token of M Mohsen', 'f926aa87fc39a9e8bfa039ca465cb36d53aef1b1f79758d3095de715e4fa9ffb', '[\"*\"]', NULL, NULL, '2024-03-10 07:36:06', '2024-03-10 07:36:06'),
(267, 'App\\Models\\User', 18, 'API token of M Mohsen', 'ddb681b0d89d2069c2c8d37ef703f25c32d4804d9964557e00a045df6ff7cea7', '[\"*\"]', '2024-03-10 07:40:57', NULL, '2024-03-10 07:40:35', '2024-03-10 07:40:57'),
(268, 'App\\Models\\User', 18, 'API token of M Mohsen', '7bc157329da454db74925c3111c9b6c81062351888bbfdc82dd6e9b8869bcfca', '[\"*\"]', '2024-03-10 07:50:48', NULL, '2024-03-10 07:43:17', '2024-03-10 07:50:48'),
(269, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '80dab6b9cff81a496f43e82dc00afaee4cd6703bec8d8201c233e678961c653a', '[\"*\"]', NULL, NULL, '2024-03-10 07:46:26', '2024-03-10 07:46:26'),
(270, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e508766e35d78e06363cb37466d6b9693b64642b9f350bb4249783adea4b55e4', '[\"*\"]', NULL, NULL, '2024-03-10 07:46:27', '2024-03-10 07:46:27'),
(271, 'App\\Models\\User', 2, 'API token of Reham Ali', '2d964e92da8116bea9469404fab97bc812f1fd2ece8b78b97f82cff284a7e55e', '[\"*\"]', NULL, NULL, '2024-03-10 07:51:50', '2024-03-10 07:51:50'),
(272, 'App\\Models\\User', 2, 'API token of Reham Ali', '75326ba109ae47db0e3c63b5fe71c64f1f7df6dee571a993623d00f8cb972a71', '[\"*\"]', NULL, NULL, '2024-03-10 07:52:58', '2024-03-10 07:52:58'),
(273, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '25bfe672a90a80639ed66a1e46a4a850f90856da829ab7990891566c9db7c554', '[\"*\"]', '2024-03-10 07:58:04', NULL, '2024-03-10 07:53:53', '2024-03-10 07:58:04'),
(274, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '1d753e5b390cc2e128b8fcd28cb7bb46418882b9cca19bfaca0ef3206768bc30', '[\"*\"]', NULL, NULL, '2024-03-10 08:01:02', '2024-03-10 08:01:02'),
(275, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '2cdad3f4799b72f98143d34918fd3733d3daa9c5dab6c3bb3576243aa320e9e5', '[\"*\"]', '2024-03-10 08:09:58', NULL, '2024-03-10 08:06:45', '2024-03-10 08:09:58'),
(276, 'App\\Models\\User', 19, 'API token of M Mohsen', '0c90e69a12e87302a4483d865f200584c537a297ab808cb74f47747c36dd08c2', '[\"*\"]', NULL, NULL, '2024-03-10 08:12:48', '2024-03-10 08:12:48'),
(277, 'App\\Models\\User', 20, 'API token of M Mohsen', '8d0328606a32540811d486d754fd642d6ea35c933d98fdd6645dbb5199700885', '[\"*\"]', NULL, NULL, '2024-03-10 08:13:22', '2024-03-10 08:13:22'),
(278, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'e69bdce6b28fa1d1b01d106ce80ba98c26f2450b77354305066d5c8b286ea458', '[\"*\"]', '2024-03-10 09:04:45', NULL, '2024-03-10 08:14:15', '2024-03-10 09:04:45'),
(279, 'App\\Models\\User', 21, 'API token of Reham Ali', 'ed62344fcd095ffd8ba5e91d0d0e3ad62a5ecf2886d9999f814d01521fd34e9f', '[\"*\"]', NULL, NULL, '2024-03-10 08:42:18', '2024-03-10 08:42:18'),
(280, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '223148333fdfa3e7962b427adfcd398d9fe853e6d17e320953ac022ca6bca074', '[\"*\"]', '2024-03-10 08:56:25', NULL, '2024-03-10 08:53:30', '2024-03-10 08:56:25'),
(281, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', 'c63684586f14ffcbabfd71c93422305008b0bc205f894dede09a949aeef64b06', '[\"*\"]', '2024-03-10 09:53:41', NULL, '2024-03-10 09:19:39', '2024-03-10 09:53:41'),
(282, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '39a0c9f4218787531456ff9e77127a334a2f8966527697b76c1b91569c1ccfa9', '[\"*\"]', '2024-03-10 12:54:03', NULL, '2024-03-10 09:57:01', '2024-03-10 12:54:03'),
(283, 'App\\Models\\User', 1, 'API token of Abdelrahman Elalfee', '09ac9e0c10c268a99b3b06af3a9afcca54b3d637e9ff027f4576936a6f1f660e', '[\"*\"]', '2024-03-10 15:11:58', NULL, '2024-03-10 13:31:22', '2024-03-10 15:11:58'),
(284, 'App\\Models\\User', 23, 'API token of Hello', '30e3fdd102f09e9420008e0daba1efff741c9e2b0cbcb64d4d7fd16c04618f66', '[\"*\"]', NULL, NULL, '2024-03-12 08:01:43', '2024-03-12 08:01:43'),
(285, 'App\\Models\\User', 23, 'API token of Hello', '2325113fc0e1bb42c8b3dd671a7d522ae32758f169cb9250ca849300420c61ec', '[\"*\"]', NULL, NULL, '2024-03-12 08:02:33', '2024-03-12 08:02:33');

-- --------------------------------------------------------

--
-- Table structure for table `promotion_plans`
--

CREATE TABLE `promotion_plans` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `one_day_price` decimal(8,2) NOT NULL,
  `three_day_price` decimal(8,2) NOT NULL,
  `seven_day_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotion_plans`
--

INSERT INTO `promotion_plans` (`id`, `name`, `one_day_price`, `three_day_price`, `seven_day_price`, `created_at`, `updated_at`) VALUES
(1, 'gold', 15.99, 39.99, 69.99, NULL, NULL),
(2, 'silver', 10.99, 29.99, 49.99, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `read` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `update` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `delete` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `create`, `read`, `update`, `delete`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '[\"*\"]', '[\"*\"]', '[\"*\"]', '[\"*\"]', '2024-01-22 08:21:03', '2024-01-22 08:21:03');

-- --------------------------------------------------------

--
-- Table structure for table `splash_ads`
--

CREATE TABLE `splash_ads` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` enum('url','product','profile','whatsapp') COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `splash_ad_prices`
--

CREATE TABLE `splash_ad_prices` (
  `id` bigint UNSIGNED NOT NULL,
  `one_day_price` decimal(8,2) NOT NULL,
  `three_day_price` decimal(8,2) NOT NULL,
  `seven_day_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `splash_ad_prices`
--

INSERT INTO `splash_ad_prices` (`id`, `one_day_price`, `three_day_price`, `seven_day_price`, `created_at`, `updated_at`) VALUES
(1, 80.00, 150.00, 200.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `type` enum('ad_promotion','banner','splash_ad') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ad_id` bigint UNSIGNED DEFAULT NULL,
  `banner_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `amount` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('admin','client','company') COLLATE utf8mb4_unicode_ci NOT NULL,
  `wallet` double DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fcm_token` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `type`, `wallet`, `remember_token`, `created_at`, `updated_at`, `fcm_token`) VALUES
(1, 'Abdelrahman Elalfee', 'elalfee@business.com', NULL, '$2y$10$8h.q0CKTNq6twNuIpEsYQuOD8rrgM7uO9ln/BUKRK5CM2EccoeW1.', 'admin', 0, NULL, '2024-01-22 08:21:03', '2024-01-22 08:21:03', NULL),
(2, 'Reham Ali', 'reham@business.com', NULL, '$2y$10$/bMEXSTKYp.8f0E/UOZnq.B37YhO1Dfqu8FdgCYIirlCSa0GyH7x.', 'client', 5, NULL, '2024-01-22 11:41:39', '2024-01-22 11:41:39', NULL),
(3, 'Reham Ali', 'rehamali@business.com', NULL, '$2y$10$Sehwazxu/QrdtuTkNW9q0eeOKWu5M8hjnINlZSqW/WzUR9fNQkHeS', 'client', NULL, NULL, '2024-02-13 15:15:19', '2024-02-13 15:15:19', NULL),
(4, 'Assem', 'assem@gmail.com', NULL, '$2y$10$IVQzyB6oRuRo76mRMdtf8.5fdHmH2fDsLu0SOdOPh2X8H68wAgQu2', 'client', NULL, NULL, '2024-02-13 15:15:32', '2024-02-13 15:15:32', NULL),
(5, 'Abdelrahman', 'aebussiness01@gmail.com', NULL, '$2y$10$EyOU9Hg23u9K0k7XCB8jsu.EAGOr.vugCw9pkmCGMdPA7uFl3APPi', 'client', NULL, NULL, '2024-02-15 14:38:41', '2024-02-15 14:38:41', NULL),
(8, 'lolllll', 'aaa@gmail.com', NULL, '$2y$10$uoEZN1qLwN.Vcy7dH87Jn.SjIXHRVR8bHJkNnRy1nqWTeTJf.kfXy', 'client', NULL, NULL, '2024-02-15 14:50:44', '2024-02-15 14:50:44', NULL),
(11, 'ahmed', 'ahmedsedky330@gmail.com', NULL, '$2y$10$Ac41F.dctQ8S5eRwZBHpzOMN3ZxmOfz1Jv/oRHbsVzim8fHcNF6NW', 'client', NULL, NULL, '2024-02-22 22:54:59', '2024-02-22 22:54:59', NULL),
(12, 'Muhammad osama', 'user@example.com', NULL, '$2y$10$3QPu8u/fhnm.WCMyzl0ULuVlXtFBBTEkRIAEybSazByQk/eF1AlRW', 'client', NULL, NULL, '2024-02-25 08:10:59', '2024-02-28 08:00:04', NULL),
(15, 'testy', 'testy@business.com', NULL, '$2y$10$FrsFJObmsjnJYDhl63NOu.wBtuxpnb2klEjaqSb6V1mCkllhnbkc6', 'client', NULL, NULL, '2024-02-25 10:41:18', '2024-02-25 10:41:18', NULL),
(16, 'hayam', 'hayam@business.com', NULL, '$2y$10$wKsK1c5JAe120tfCL6jkKeuZ3NIXsmWxZ/NQ/mYfwgmVVrnKaIaPa', 'client', NULL, NULL, '2024-02-25 10:45:44', '2024-02-25 10:45:44', NULL),
(17, 'M Mohsen', 'm.mohsen@gmail.com', NULL, '$2y$10$GlZFphXtKI48gOgEH0W5A.XLWWpclLW.sOCE3GVg2/21CjrfLqos.', 'client', NULL, NULL, '2024-03-10 07:26:28', '2024-03-10 07:26:28', NULL),
(19, 'M Mohsen', 'm.mohsen2@gmail.com', NULL, '$2y$10$wjZ3gnGQD5GrOtHIqnK15uhNbxVR0Sv4wlVv1Gl4iLTG8SR3siNTq', 'client', NULL, NULL, '2024-03-10 08:12:47', '2024-03-10 08:12:47', NULL),
(20, 'M Mohsen', 'm.mohsen3@gmail.com', NULL, '$2y$10$ycNVlFX9uRziYNbEItYyguO7ljUhN7lVFLGSQFDU3vxZc/SAQUWgi', 'client', NULL, NULL, '2024-03-10 08:13:22', '2024-03-10 08:13:22', NULL),
(21, 'Reham Ali', 'test@test.com', NULL, '$2y$10$bhHSfdIm99pbHqDH4Sd7xudfONjWrAhLn/hxUIY4/iNjRY59CjTlC', 'client', NULL, NULL, '2024-03-10 08:42:17', '2024-03-10 08:42:17', NULL),
(22, 'test', 'admin@test.com', NULL, '$2y$10$4oAMB6FKCJYVZl5snjg5p.0htkvONVYdTt9B5W3HNE.KGpvH/yHbG', 'admin', NULL, NULL, '2024-03-10 08:56:18', '2024-03-10 08:56:18', NULL),
(23, 'Hello', 'Hello@example.com', NULL, '$2y$10$VAb2QvLs8Sj85Q/QaoizFO5PS073NTXazRx0CbWV4fVyS5FZMO.CK', 'client', NULL, NULL, '2024-03-12 08:01:33', '2024-03-12 08:01:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admins_user_id_foreign` (`user_id`),
  ADD KEY `admins_role_id_foreign` (`role_id`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ads_category_id_foreign` (`category_id`),
  ADD KEY `ads_promotion_plan_id_foreign` (`promotion_plan_id`);

--
-- Indexes for table `ad_attribute`
--
ALTER TABLE `ad_attribute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ad_attribute_ad_id_foreign` (`ad_id`),
  ADD KEY `ad_attribute_attribute_id_foreign` (`attribute_id`),
  ADD KEY `ad_attribute_attribute_option_id_foreign` (`attribute_option_id`);

--
-- Indexes for table `ad_images`
--
ALTER TABLE `ad_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ad_images_ad_id_foreign` (`ad_id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attributes_category_id_foreign` (`category_id`);

--
-- Indexes for table `attribute_options`
--
ALTER TABLE `attribute_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attribute_options_attribute_id_foreign` (`attribute_id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banner_prices`
--
ALTER TABLE `banner_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_user_id_foreign` (`user_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_ad_id_foreign` (`ad_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `companies_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favourite_items`
--
ALTER TABLE `favourite_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `favourite_items_favourite_id_foreign` (`favourite_id`),
  ADD KEY `favourite_items_ad_id_foreign` (`ad_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_ad_id_foreign` (`ad_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `promotion_plans`
--
ALTER TABLE `promotion_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `splash_ads`
--
ALTER TABLE `splash_ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `splash_ad_prices`
--
ALTER TABLE `splash_ad_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_ad_id_foreign` (`ad_id`),
  ADD KEY `transactions_banner_id_foreign` (`banner_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `ad_attribute`
--
ALTER TABLE `ad_attribute`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `ad_images`
--
ALTER TABLE `ad_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `attribute_options`
--
ALTER TABLE `attribute_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1041;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `banner_prices`
--
ALTER TABLE `banner_prices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=644;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `favourite_items`
--
ALTER TABLE `favourite_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=286;

--
-- AUTO_INCREMENT for table `promotion_plans`
--
ALTER TABLE `promotion_plans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `splash_ads`
--
ALTER TABLE `splash_ads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `splash_ad_prices`
--
ALTER TABLE `splash_ad_prices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `admins_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `ads_promotion_plan_id_foreign` FOREIGN KEY (`promotion_plan_id`) REFERENCES `promotion_plans` (`id`);

--
-- Constraints for table `ad_attribute`
--
ALTER TABLE `ad_attribute`
  ADD CONSTRAINT `ad_attribute_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ad_attribute_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ad_attribute_attribute_option_id_foreign` FOREIGN KEY (`attribute_option_id`) REFERENCES `attribute_options` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ad_images`
--
ALTER TABLE `ad_images`
  ADD CONSTRAINT `ad_images_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`);

--
-- Constraints for table `attributes`
--
ALTER TABLE `attributes`
  ADD CONSTRAINT `attributes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `attribute_options`
--
ALTER TABLE `attribute_options`
  ADD CONSTRAINT `attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`);

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favourite_items`
--
ALTER TABLE `favourite_items`
  ADD CONSTRAINT `favourite_items_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`),
  ADD CONSTRAINT `favourite_items_favourite_id_foreign` FOREIGN KEY (`favourite_id`) REFERENCES `favourites` (`id`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ad_id_foreign` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_banner_id_foreign` FOREIGN KEY (`banner_id`) REFERENCES `banners` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
