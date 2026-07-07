-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2026 at 11:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ci4`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2026-05-12-094410', 'App\\Database\\Migrations\\User', 'default', 'App', 1778579485, 1),
(2, '2026-05-12-094424', 'App\\Database\\Migrations\\Product', 'default', 'App', 1778579485, 1),
(3, '2026-05-12-094431', 'App\\Database\\Migrations\\Transaction', 'default', 'App', 1778579485, 1),
(4, '2026-05-12-094452', 'App\\Database\\Migrations\\TransactionDetail', 'default', 'App', 1778579485, 1),
(5, '2026-05-19-095206', 'App\\Database\\Migrations\\AddDeletedAtToTables', 'default', 'App', 1779247786, 2),
(6, '2026-07-07-160000', 'App\\Database\\Migrations\\AddPpnAdminVoucherToTransaction', 'default', 'App', 1783410027, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `harga` double NOT NULL,
  `jumlah` int(5) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `nama`, `harga`, `jumlah`, `foto`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ASUS TUF A15 FA506NF', 10899000, 5, 'asus_tuf_a15.jpg', '2026-05-12 17:05:15', NULL, NULL),
(2, 'Asus Vivobook 14 A1404ZA', 6899000, 7, 'asus_vivobook_14.jpg', '2026-05-12 17:05:15', NULL, NULL),
(3, 'Lenovo IdeaPad Slim 3-14IAU7', 6299000, 5, 'lenovo_idepad_slim_3.jpg', '2026-05-12 17:05:15', NULL, NULL),
(4, 'Lenovo ThinkPad X1 Ultrabook', 3500000, 12, '1780379004_b97aeb547dfaab73f180.jpg', '2026-06-02 12:43:24', '2026-06-02 12:53:01', '2026-06-02 12:53:01');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `total_harga` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `biaya_admin` double DEFAULT NULL,
  `voucher_code` varchar(20) DEFAULT NULL,
  `diskon_voucher` double DEFAULT NULL,
  `alamat` text NOT NULL,
  `ongkir` double DEFAULT NULL,
  `status` int(1) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `username`, `total_harga`, `ppn`, `biaya_admin`, `voucher_code`, `diskon_voucher`, `alamat`, `ongkir`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ilham25', 10899000, NULL, NULL, NULL, NULL, 'Pangeran', 0, 0, '2026-06-23 15:04:48', '2026-06-23 15:04:48', NULL),
(2, 'ilham25', 33326546, 3596670, 261576, 'FLASH10', 3269700, 'Paku', 41000, 0, '2026-07-07 14:44:47', '2026-07-07 14:44:47', NULL),
(3, 'ramadhan25', 33326546, 3596670, 261576, 'FLASH10', 3269700, 'Paku', 41000, 0, '2026-07-07 16:04:03', '2026-07-07 16:04:03', NULL),
(4, 'ramadhan25', 7070684, 692890, 37794, NULL, 0, 'Komplek DPRD', 41000, 0, '2026-07-07 16:04:56', '2026-07-07 16:04:56', NULL),
(5, 'ramadhan25', 14059768, 1517780, 82788, 'FLASH10', 1379800, 'Komplek DPRD', 41000, 0, '2026-07-07 16:06:42', '2026-07-07 16:06:42', NULL),
(6, 'ramadhan25', 31650696, 3596670, 261576, 'FLASH15', 4904550, 'Kedaton', 0, 0, '2026-07-07 16:07:43', '2026-07-07 16:07:43', NULL),
(7, 'ramadhan25', 36596246, 3596670, 261576, NULL, 0, 'Sukadana', 41000, 0, '2026-07-07 16:08:42', '2026-07-07 16:08:42', NULL),
(8, 'ramadhan25', 50176400, 5994450, 544950, 'MEMBER20', 10899000, 'Paku', 41000, 0, '2026-07-07 16:09:44', '2026-07-07 16:09:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `id` int(11) UNSIGNED NOT NULL,
  `transaction_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `jumlah` int(5) NOT NULL,
  `diskon` double DEFAULT NULL,
  `subtotal_harga` double NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_detail`
--

INSERT INTO `transaction_detail` (`id`, `transaction_id`, `product_id`, `jumlah`, `diskon`, `subtotal_harga`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 0, 10899000, '2026-06-23 15:04:48', '2026-06-23 15:04:48', NULL),
(2, 2, 1, 3, 0, 32697000, '2026-07-07 14:44:47', '2026-07-07 14:44:47', NULL),
(3, 3, 1, 3, 0, 32697000, '2026-07-07 16:04:03', '2026-07-07 16:04:03', NULL),
(4, 4, 3, 1, 0, 6299000, '2026-07-07 16:04:56', '2026-07-07 16:04:56', NULL),
(5, 5, 2, 2, 0, 13798000, '2026-07-07 16:06:42', '2026-07-07 16:06:42', NULL),
(6, 6, 1, 3, 0, 32697000, '2026-07-07 16:07:43', '2026-07-07 16:07:43', NULL),
(7, 7, 1, 3, 0, 32697000, '2026-07-07 16:08:42', '2026-07-07 16:08:42', NULL),
(8, 8, 1, 5, 0, 54495000, '2026-07-07 16:09:44', '2026-07-07 16:09:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'warta.lestari', 'lintang97@laksmiwati.desa.id', '$2y$10$.IDOXdk5CFoh2dM.tqphE.LTKjrvJPg2AkWj5qWWxTSqZKr2.8yLa', 'guest', '2026-05-12 17:06:06', NULL, NULL),
(2, 'ramadhan25', 'ramadhan@gmail.com', '$2y$10$XcquGUuHUFpJxC2x.UFbGe2xp36l1RdX75fGdrJ8Ddlck8pSdgqsG', 'guest', '2026-05-12 17:06:06', NULL, NULL),
(3, 'dabukke.chelsea', 'cpratama@tarihoran.asia', '$2y$10$ZgmXCu/W210vuBPsAAObGu3cuwHtEKC/BihXtTFhWT3HPIGogKIKm', 'admin', '2026-05-12 17:06:07', NULL, NULL),
(4, 'karman.thamrin', 'pratiwi.syahrini@mayasari.web.id', '$2y$10$0YAgKpaGxtMM9MYMF9q/O..Yez75cPw0mUPN8L44Uncp3Q5qGzK0S', 'admin', '2026-05-12 17:06:07', NULL, NULL),
(5, 'zsihombing', 'olga.nasyiah@yahoo.co.id', '$2y$10$t8GZCwOq4zccviCGLdX.qefqXQIzUVRbuWlKvsqanlUkBBjBtib6q', 'admin', '2026-05-12 17:06:07', NULL, NULL),
(6, 'ilham25', 'ilham@gmail.com', '$2y$10$0/bJnJkuBXNT64opHehLquQCCFhfLfqv6Qtcv8VN9Y9cdntkWao46', 'admin', '2026-05-12 17:06:07', NULL, NULL),
(7, 'pertiwi.jayeng', 'rnashiruddin@uwais.ac.id', '$2y$10$aEuN83iZFyMdwzTbyWfG9OJHnSYzbnTFJ//vjBNYbejmaN2oPUfGK', 'guest', '2026-05-12 17:06:07', NULL, NULL),
(8, 'hidayanto.irwan', 'kezia.laksita@anggraini.biz', '$2y$10$ILLodjG/qfPjaFN10a/L8.pAXk2rsWpElzjUIhJ5dG88kZrtOCoL6', 'admin', '2026-05-12 17:06:07', NULL, NULL),
(9, 'kairav41', 'mardhiyah.laras@irawan.com', '$2y$10$nXN1evgM1E25lOxhtKdWu.On1cRpyj819tleFyHCOS.IQhnv4M4G.', 'guest', '2026-05-12 17:06:08', NULL, NULL),
(10, 'nnasyidah', 'srahmawati@yahoo.co.id', '$2y$10$Q3jFTDgzDOBHb94eBUyK/uFtgoCELgzdre8Mu3dcU8kzplYsA.p76', 'admin', '2026-05-12 17:06:08', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
