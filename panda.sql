-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- HÃƒÂ´te : 127.0.0.1
-- GÃƒÂ©nÃƒÂ©rÃƒÂ© le : sam. 13 juin 2026 ÃƒÂ  17:29
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de donnÃƒÂ©es : `panda`
--

-- --------------------------------------------------------

--
-- Structure de la table `agencies`
--

CREATE TABLE `agencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `country` varchar(2) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agency_invitations`
--

CREATE TABLE `agency_invitations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `agency_id` bigint(20) UNSIGNED NOT NULL,
  `invited_by` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('admin','freelancer') NOT NULL DEFAULT 'freelancer',
  `token` varchar(64) NOT NULL,
  `status` enum('pending','accepted','declined','expired') NOT NULL DEFAULT 'pending',
  `expires_at` timestamp NULL DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agency_members`
--

CREATE TABLE `agency_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `agency_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('owner','admin','freelancer') NOT NULL DEFAULT 'freelancer',
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ai_histories`
--

CREATE TABLE `ai_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('proposal','search','match','summary','chat','cv_analysis') NOT NULL,
  `input` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`input`)),
  `output` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`output`)),
  `model` varchar(255) DEFAULT NULL,
  `tokens_used` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `ai_histories`
--

INSERT INTO `ai_histories` (`id`, `user_id`, `type`, `input`, `output`, `model`, `tokens_used`, `created_at`, `updated_at`) VALUES
(1, 18, 'proposal', '{\"job_id\":1,\"job_title\":\"Build a SaaS Dashboard with Laravel & React\"}', '{\"proposal\":\"Dear Hiring Manager,\\n\\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\\n\\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\\n\\nI look forward to discussing how I can contribute to your project\'s success.\\n\\nBest regards\"}', 'mistral', 117, '2026-05-22 14:34:00', '2026-05-22 14:34:00'),
(2, 34, 'proposal', '{\"job_id\":16,\"job_title\":\"firest jobe\"}', '{\"proposal\":\"Dear Hiring Manager,\\n\\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\\n\\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\\n\\nI look forward to discussing how I can contribute to your project\'s success.\\n\\nBest regards\"}', 'mistral', 117, '2026-06-10 18:16:09', '2026-06-10 18:16:09'),
(3, 34, 'proposal', '{\"job_id\":16,\"job_title\":\"firest jobe\"}', '{\"proposal\":\"Dear Hiring Manager,\\n\\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\\n\\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\\n\\nI look forward to discussing how I can contribute to your project\'s success.\\n\\nBest regards\"}', 'mistral', 117, '2026-06-11 00:54:13', '2026-06-11 00:54:13'),
(4, 34, 'proposal', '{\"job_id\":17,\"job_title\":\"TOW\"}', '{\"proposal\":\"Dear Hiring Manager,\\n\\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\\n\\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\\n\\nI look forward to discussing how I can contribute to your project\'s success.\\n\\nBest regards\"}', 'mistral', 117, '2026-06-11 15:23:21', '2026-06-11 15:23:21'),
(5, 34, 'proposal', '{\"job_id\":19,\"job_title\":\"3erd job\"}', '{\"proposal\":\"Dear Hiring Manager,\\n\\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\\n\\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\\n\\nI look forward to discussing how I can contribute to your project\'s success.\\n\\nBest regards\"}', 'mistral', 117, '2026-06-11 19:10:46', '2026-06-11 19:10:46');

-- --------------------------------------------------------

--
-- Structure de la table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `actor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `target_type` varchar(120) DEFAULT NULL,
  `target_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `actor_id`, `action`, `target_type`, `target_id`, `payload`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, NULL, 'auth.password.forgot_requested', NULL, NULL, '{\"email\":\"amksocanjib@gmail.com\",\"status\":\"passwords.user\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.123.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36', '2026-06-10 18:04:45'),
(2, 34, 'proposal.created', 'App\\Models\\Proposal', 2, '{\"job_id\":16,\"connects_used\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-10 18:16:39'),
(3, 35, 'proposal.accepted', 'App\\Models\\Proposal', 2, '{\"contract_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-11 01:34:50'),
(4, 34, 'proposal.created', 'App\\Models\\Proposal', 3, '{\"job_id\":17,\"connects_used\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-11 15:23:33'),
(5, 37, 'proposal.accepted', 'App\\Models\\Proposal', 3, '{\"contract_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-11 15:24:38'),
(6, 34, 'proposal.created', 'App\\Models\\Proposal', 4, '{\"job_id\":19,\"connects_used\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-11 19:11:05'),
(7, 35, 'proposal.accepted', 'App\\Models\\Proposal', 4, '{\"contract_id\":3}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-11 19:11:45');

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('panda-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', 1781281695),
('panda-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1781281695;', 1781281695),
('panda-cache-f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59', 'i:1;', 1781208703),
('panda-cache-f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59:timer', 'i:1781208703;', 1781208703);

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `catalog_orders`
--

CREATE TABLE `catalog_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `catalog_project_id` bigint(20) UNSIGNED NOT NULL,
  `buyer_id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `tier` enum('basic','standard','premium') NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `delivery_days` int(10) UNSIGNED NOT NULL,
  `revisions_allowed` int(10) UNSIGNED NOT NULL,
  `requirements` text DEFAULT NULL,
  `status` enum('pending_payment','in_progress','delivered','completed','cancelled','disputed') NOT NULL DEFAULT 'pending_payment',
  `stripe_session_id` varchar(255) DEFAULT NULL,
  `contract_id` bigint(20) UNSIGNED DEFAULT NULL,
  `conversation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `catalog_projects`
--

CREATE TABLE `catalog_projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `tier_basic` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tier_basic`)),
  `tier_standard` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tier_standard`)),
  `tier_premium` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tier_premium`)),
  `faq` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`faq`)),
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `status` enum('draft','pending_review','published','rejected','suspended') NOT NULL DEFAULT 'draft',
  `views_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `orders_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `avg_rating` decimal(3,2) NOT NULL DEFAULT 0.00,
  `reviews_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `moderated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `moderated_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `catalog_project_images`
--

CREATE TABLE `catalog_project_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `catalog_project_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `catalog_reviews`
--

CREATE TABLE `catalog_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `catalog_project_id` bigint(20) UNSIGNED NOT NULL,
  `catalog_order_id` bigint(20) UNSIGNED NOT NULL,
  `reviewer_id` bigint(20) UNSIGNED NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `icon`, `description`, `parent_id`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Development & IT', 'development-it', 'code', NULL, NULL, 0, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(2, 'Design & Creative', 'design-creative', 'design', NULL, NULL, 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(3, 'AI & Machine Learning', 'ai-ml', 'ai', NULL, NULL, 2, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(4, 'Writing & Translation', 'writing', 'write', NULL, NULL, 3, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(5, 'Sales & Marketing', 'sales-marketing', 'chart', NULL, NULL, 4, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(6, 'Mobile Development', 'mobile-dev', 'mobile', NULL, NULL, 5, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54');

-- --------------------------------------------------------

--
-- Structure de la table `client_profiles`
--

CREATE TABLE `client_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_size` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `total_jobs_posted` int(11) NOT NULL DEFAULT 0,
  `total_spent` int(11) NOT NULL DEFAULT 0,
  `avg_rating` decimal(3,2) NOT NULL DEFAULT 0.00,
  `total_reviews` int(11) NOT NULL DEFAULT 0,
  `payment_verified` tinyint(1) NOT NULL DEFAULT 0,
  `preferred_payment_method` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `client_profiles`
--

INSERT INTO `client_profiles` (`id`, `user_id`, `company_name`, `company_size`, `industry`, `about`, `total_jobs_posted`, `total_spent`, `avg_rating`, `total_reviews`, `payment_verified`, `preferred_payment_method`, `created_at`, `updated_at`) VALUES
(1, 12, 'NovaTech Solutions', NULL, 'Technology', NULL, 14, 45000, 4.60, 14, 1, NULL, '2026-05-22 14:22:00', '2026-05-22 14:22:00'),
(2, 13, 'Bloom Digital Agency', NULL, 'Marketing', NULL, 9, 28000, 4.70, 9, 1, NULL, '2026-05-22 14:22:00', '2026-05-22 14:22:00'),
(3, 14, 'Gulf Ventures Group', NULL, 'Finance', NULL, 21, 92000, 4.70, 21, 1, NULL, '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(4, 15, 'Pixel Dreams Studio', NULL, 'Gaming', NULL, 11, 38000, 4.80, 11, 1, NULL, '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(5, 16, 'HealthBridge Africa', NULL, 'Healthcare', NULL, 6, 18000, 4.70, 6, 1, NULL, '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(6, 17, 'Luxe Commerce SRL', NULL, 'E-Commerce', NULL, 8, 31000, 4.80, 8, 1, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02'),
(7, 24, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, 0, NULL, '2026-06-10 01:52:10', '2026-06-10 01:52:10'),
(8, 35, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, 0, NULL, '2026-06-10 18:13:39', '2026-06-10 18:13:39'),
(9, 36, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, 0, NULL, '2026-06-11 15:16:54', '2026-06-11 15:16:54'),
(10, 37, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, 0, NULL, '2026-06-11 15:17:54', '2026-06-11 15:17:54');

-- --------------------------------------------------------

--
-- Structure de la table `contracts`
--

CREATE TABLE `contracts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `proposal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `freelancer_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('hourly','fixed') NOT NULL DEFAULT 'fixed',
  `amount` decimal(12,2) NOT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  `weekly_limit` int(10) UNSIGNED DEFAULT NULL,
  `auto_invoice_at` timestamp NULL DEFAULT NULL,
  `billing_status` enum('active','paused','closed') NOT NULL DEFAULT 'active',
  `escrow_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','active','paused','completed','cancelled','disputed') NOT NULL DEFAULT 'pending',
  `started_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `deadline_at` timestamp NULL DEFAULT NULL,
  `terms` text DEFAULT NULL,
  `dispute_reason` text DEFAULT NULL,
  `disputed_at` timestamp NULL DEFAULT NULL,
  `dispute_opened_by` bigint(20) UNSIGNED DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `resolved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `resolution_outcome` varchar(32) DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `cancelled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `completed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `contracts`
--

INSERT INTO `contracts` (`id`, `job_id`, `proposal_id`, `client_id`, `freelancer_id`, `title`, `description`, `type`, `amount`, `hourly_rate`, `weekly_limit`, `auto_invoice_at`, `billing_status`, `escrow_amount`, `status`, `started_at`, `ended_at`, `archived_at`, `deadline_at`, `terms`, `dispute_reason`, `disputed_at`, `dispute_opened_by`, `resolved_at`, `resolved_by`, `resolution_outcome`, `cancellation_reason`, `cancelled_by`, `completed_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 16, 2, 35, 34, 'firest jobe', 'qwtyhbvxsyjnbchghjghjghjvhjvjvgjcgcvhcghcghcghcghfghgh', 'hourly', 13.00, NULL, NULL, NULL, 'active', 0.00, 'completed', '2026-06-11 01:34:50', '2026-06-11 01:37:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, '2026-06-11 01:34:50', '2026-06-11 01:37:13', NULL),
(2, 17, 3, 37, 34, 'TOW', 'XSNOANOJASNXJO SCSb uicbA UIIBIASC BAXSIBIJBCSJIAB', 'fixed', 14.00, NULL, NULL, NULL, 'active', 14.00, 'active', '2026-06-11 15:24:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-11 15:24:38', '2026-06-11 15:27:46', NULL),
(3, 19, 4, 35, 34, '3erd job', 'this is  for testing but stile not ofitinale jobe  fojcijxjn hibkx', 'fixed', 11.00, NULL, NULL, NULL, 'active', 0.00, 'active', '2026-06-11 19:11:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-11 19:11:45', '2026-06-11 19:11:45', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `contract_activities`
--

CREATE TABLE `contract_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `actor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(64) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `contract_activities`
--

INSERT INTO `contract_activities` (`id`, `contract_id`, `actor_id`, `type`, `data`, `created_at`) VALUES
(1, 1, 35, 'file.uploaded', '{\"file_id\":1,\"name\":\"LYCEE TECHNIQUE.docx\",\"size\":4232260}', '2026-06-11 01:36:49'),
(2, 1, 34, 'time.started', '{\"log_id\":1}', '2026-06-11 01:38:43'),
(3, 1, 34, 'time.stopped', '{\"log_id\":1,\"duration\":1047}', '2026-06-11 01:56:10'),
(4, 2, 34, 'time.started', '{\"log_id\":2}', '2026-06-11 15:25:48'),
(5, 2, 34, 'time.stopped', '{\"log_id\":2,\"duration\":12631}', '2026-06-11 18:56:19');

-- --------------------------------------------------------

--
-- Structure de la table `contract_extensions`
--

CREATE TABLE `contract_extensions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `requested_by` bigint(20) UNSIGNED NOT NULL,
  `new_deadline` timestamp NULL DEFAULT NULL,
  `additional_budget` decimal(12,2) NOT NULL DEFAULT 0.00,
  `new_milestones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_milestones`)),
  `reason` text DEFAULT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `responded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `response_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contract_files`
--

CREATE TABLE `contract_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `uploader_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_path` varchar(255) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `size_bytes` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `contract_files`
--

INSERT INTO `contract_files` (`id`, `contract_id`, `uploader_id`, `parent_id`, `original_name`, `stored_path`, `mime_type`, `size_bytes`, `version`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 35, NULL, 'LYCEE TECHNIQUE.docx', 'contracts/1/files/KvhIVxmba0UUVYTaIJKh41iU4GcqShrHLkKSmUb7.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 4232260, 1, NULL, '2026-06-11 01:36:49', '2026-06-11 01:36:49', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'direct',
  `contract_id` bigint(20) UNSIGNED DEFAULT NULL,
  `job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `conversations`
--

INSERT INTO `conversations` (`id`, `type`, `contract_id`, `job_id`, `title`, `last_message_at`, `created_at`, `updated_at`) VALUES
(1, 'direct', NULL, NULL, NULL, '2026-06-10 02:07:03', '2026-06-10 02:06:53', '2026-06-10 02:07:03'),
(2, 'direct', NULL, NULL, NULL, '2026-06-11 01:35:24', '2026-06-10 18:21:44', '2026-06-11 01:35:24'),
(3, 'contract', 1, 16, 'firest jobe', NULL, '2026-06-11 01:34:50', '2026-06-11 01:34:50'),
(4, 'direct', NULL, NULL, NULL, NULL, '2026-06-11 15:24:13', '2026-06-11 15:24:13'),
(5, 'contract', 2, 17, 'TOW', NULL, '2026-06-11 15:24:38', '2026-06-11 15:24:38'),
(6, 'contract', 3, 19, '3erd job', NULL, '2026-06-11 19:11:45', '2026-06-11 19:11:45');

-- --------------------------------------------------------

--
-- Structure de la table `conversation_participants`
--

CREATE TABLE `conversation_participants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `last_read_at` timestamp NULL DEFAULT NULL,
  `is_muted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `conversation_participants`
--

INSERT INTO `conversation_participants` (`id`, `conversation_id`, `user_id`, `last_read_at`, `is_muted`, `created_at`, `updated_at`) VALUES
(1, 1, 28, NULL, 0, '2026-06-10 02:06:53', '2026-06-10 02:06:53'),
(2, 1, 12, NULL, 0, '2026-06-10 02:06:53', '2026-06-10 02:06:53'),
(3, 2, 34, NULL, 0, '2026-06-10 18:21:44', '2026-06-10 18:21:44'),
(4, 2, 35, NULL, 0, '2026-06-10 18:21:44', '2026-06-10 18:21:44'),
(5, 3, 35, NULL, 0, '2026-06-11 01:34:50', '2026-06-11 01:34:50'),
(6, 3, 34, NULL, 0, '2026-06-11 01:34:50', '2026-06-11 01:34:50'),
(7, 4, 37, NULL, 0, '2026-06-11 15:24:13', '2026-06-11 15:24:13'),
(8, 4, 34, NULL, 0, '2026-06-11 15:24:13', '2026-06-11 15:24:13'),
(9, 5, 37, NULL, 0, '2026-06-11 15:24:38', '2026-06-11 15:24:38'),
(10, 5, 34, NULL, 0, '2026-06-11 15:24:38', '2026-06-11 15:24:38'),
(11, 6, 35, NULL, 0, '2026-06-11 19:11:45', '2026-06-11 19:11:45'),
(12, 6, 34, NULL, 0, '2026-06-11 19:11:45', '2026-06-11 19:11:45');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `freelancer_profiles`
--

CREATE TABLE `freelancer_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `specialties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`specialties`)),
  `bio` text DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  `experience_level` enum('entry','intermediate','expert') NOT NULL DEFAULT 'entry',
  `availability` varchar(255) NOT NULL DEFAULT 'full_time',
  `weekly_hours` int(11) NOT NULL DEFAULT 40,
  `success_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `total_jobs` int(11) NOT NULL DEFAULT 0,
  `total_earned` int(11) NOT NULL DEFAULT 0,
  `avg_rating` decimal(3,2) NOT NULL DEFAULT 0.00,
  `total_reviews` int(11) NOT NULL DEFAULT 0,
  `is_top_rated` tinyint(1) NOT NULL DEFAULT 0,
  `is_top_rated_plus` tinyint(1) NOT NULL DEFAULT 0,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `onboarding_completed` tinyint(1) NOT NULL DEFAULT 0,
  `profile_visibility` varchar(255) NOT NULL DEFAULT 'public',
  `languages` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`languages`)),
  `video_intro` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `github_url` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `certifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`certifications`)),
  `badges` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`badges`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `experience` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`experience`)),
  `education` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`education`)),
  `date_of_birth` date DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`address`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `freelancer_profiles`
--

INSERT INTO `freelancer_profiles` (`id`, `user_id`, `title`, `category`, `specialties`, `bio`, `hourly_rate`, `experience_level`, `availability`, `weekly_hours`, `success_rate`, `total_jobs`, `total_earned`, `avg_rating`, `total_reviews`, `is_top_rated`, `is_top_rated_plus`, `is_available`, `onboarding_completed`, `profile_visibility`, `languages`, `video_intro`, `linkedin_url`, `github_url`, `website_url`, `certifications`, `badges`, `created_at`, `updated_at`, `experience`, `education`, `date_of_birth`, `address`) VALUES
(1, 2, 'Senior Full-Stack Developer (Laravel & React)', NULL, NULL, 'Senior full-stack developer with 7+ years building scalable SaaS platforms. Specialist in Laravel APIs and React frontends. Delivered 50+ projects across fintech and e-commerce.', 85.00, 'expert', 'available', 40, 99.00, 58, 39440, 4.90, 58, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:55', '2026-05-22 14:21:55', NULL, NULL, NULL, NULL),
(2, 3, 'UI/UX Designer & Brand Identity Specialist', NULL, NULL, 'Award-winning designer crafting user-centric digital experiences. I turn complex problems into elegant interfaces. Worked with startups and Fortune 500 companies.', 65.00, 'expert', 'available', 40, 97.00, 44, 22880, 4.95, 44, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:56', '2026-05-22 14:21:56', NULL, NULL, NULL, NULL),
(3, 4, 'AI/ML Engineer & Data Scientist', NULL, NULL, 'Machine learning engineer specializing in NLP, computer vision, and production AI deployments. 5+ years of research and industry experience.', 90.00, 'expert', 'available', 40, 97.00, 27, 19440, 4.95, 27, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:56', '2026-05-22 14:21:56', NULL, NULL, NULL, NULL),
(4, 5, 'Backend & Cloud Infrastructure Engineer', NULL, NULL, 'DevOps engineer and backend specialist. Expert in Kubernetes, AWS, CI/CD pipelines, and microservices architecture. Passionate about performance and reliability.', 80.00, 'expert', 'available', 40, 98.00, 36, 23040, 4.85, 36, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:57', '2026-05-22 14:21:57', NULL, NULL, NULL, NULL),
(5, 6, 'React Native & Flutter Mobile Developer', NULL, NULL, 'Mobile developer with 4+ years shipping cross-platform apps. Built apps with 500k+ downloads. Strong focus on smooth animations and native-like performance.', 60.00, 'intermediate', 'available', 40, 95.00, 29, 13920, 4.80, 29, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:57', '2026-05-22 14:21:57', NULL, NULL, NULL, NULL),
(6, 7, 'Technical Writer & Content Strategist', NULL, NULL, 'Technical writer and content strategist with deep experience in SaaS documentation, blog content, and developer guides. Fluent in English, Arabic, and French.', 45.00, 'expert', 'available', 40, 100.00, 61, 21960, 4.90, 61, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', NULL, NULL, NULL, NULL),
(7, 8, 'Vue.js & Nuxt.js Frontend Engineer', NULL, NULL, 'Frontend engineer passionate about building fast, accessible web apps with Vue 3 and Nuxt. 5+ years experience with component libraries and SSR.', 70.00, 'expert', 'available', 40, 97.00, 33, 18480, 4.70, 33, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', NULL, NULL, NULL, NULL),
(8, 9, 'Data Scientist & Python Automation Expert', NULL, NULL, 'Data scientist with strong background in predictive modeling, data pipelines, and business intelligence. Experience at top tech companies in Bangalore and London.', 55.00, 'expert', 'available', 40, 99.00, 41, 18040, 4.88, 41, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', NULL, NULL, NULL, NULL),
(9, 10, 'Go & Rust Systems Engineer', NULL, NULL, 'Systems engineer building high-performance backends with Go and Rust. Specialized in real-time APIs, WebSockets, and distributed systems.', 95.00, 'expert', 'available', 40, 100.00, 19, 14440, 4.92, 19, 1, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:59', '2026-05-22 14:21:59', NULL, NULL, NULL, NULL),
(10, 11, 'Digital Marketing & SEO Strategist', NULL, NULL, 'Performance marketer helping SaaS and e-commerce brands grow through data-driven SEO, paid ads, and conversion optimization. 300%+ average ROI across clients.', 50.00, 'expert', 'available', 40, 100.00, 52, 20800, 4.82, 52, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:21:59', '2026-05-22 14:21:59', NULL, NULL, NULL, NULL),
(11, 18, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 14:32:30', '2026-05-22 14:32:30', NULL, NULL, NULL, NULL),
(12, 19, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-22 15:30:24', '2026-05-22 15:30:24', NULL, NULL, NULL, NULL),
(13, 20, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:42:03', '2026-06-10 01:42:03', NULL, NULL, NULL, NULL),
(14, 21, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:42:28', '2026-06-10 01:42:28', NULL, NULL, NULL, NULL),
(15, 23, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:47:24', '2026-06-10 01:47:24', NULL, NULL, NULL, NULL),
(16, 25, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:53:40', '2026-06-10 01:53:40', NULL, NULL, NULL, NULL),
(17, 26, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:57:06', '2026-06-10 01:57:06', NULL, NULL, NULL, NULL),
(18, 27, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 01:58:56', '2026-06-10 01:58:56', NULL, NULL, NULL, NULL),
(19, 28, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:02:42', '2026-06-10 02:02:42', NULL, NULL, NULL, NULL),
(20, 29, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:11:32', '2026-06-10 02:11:32', NULL, NULL, NULL, NULL),
(21, 30, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:23:48', '2026-06-10 02:23:48', NULL, NULL, NULL, NULL),
(22, 31, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:25:13', '2026-06-10 02:25:13', NULL, NULL, NULL, NULL),
(23, 32, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:32:20', '2026-06-10 02:32:20', NULL, NULL, NULL, NULL),
(24, 33, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 02:33:07', '2026-06-10 02:33:07', NULL, NULL, NULL, NULL),
(25, 34, 'hgjhbm', 'Admin Support', '[\"Data Entry\",\"Virtual Assistance\"]', 'tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt', 12.00, 'entry', 'full_time', 40, 0.00, 0, 0, 5.00, 1, 0, 0, 1, 1, 'public', '[{\"language\":\"English\",\"level\":\"Conversational\"}]', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-10 18:12:04', '2026-06-11 18:05:33', '[]', '[]', '2026-06-13', '{\"street\":\"Loat Ouislane\",\"apt\":null,\"city\":\"Meknes\",\"state\":null,\"zip\":\"50000\"}'),
(26, 38, NULL, NULL, NULL, NULL, NULL, 'entry', 'full_time', 40, 0.00, 0, 0, 0.00, 0, 0, 0, 1, 0, 'public', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-13 13:01:07', '2026-06-13 13:01:07', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `freelancer_skills`
--

CREATE TABLE `freelancer_skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `level` enum('beginner','intermediate','expert') NOT NULL DEFAULT 'intermediate',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `freelancer_skills`
--

INSERT INTO `freelancer_skills` (`id`, `user_id`, `skill_id`, `level`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(2, 2, 3, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(3, 2, 8, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(4, 2, 9, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(5, 2, 11, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(6, 3, 13, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(7, 3, 14, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(8, 3, 15, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(9, 3, 16, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(10, 4, 6, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(11, 4, 17, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(12, 4, 18, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(13, 4, 19, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(14, 4, 20, 'expert', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(15, 5, 5, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(16, 5, 10, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(17, 5, 11, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(18, 5, 12, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(19, 5, 25, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(20, 6, 7, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(21, 6, 8, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(22, 6, 21, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(23, 6, 22, 'expert', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(24, 7, 31, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(25, 7, 32, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(26, 7, 33, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(27, 8, 4, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(28, 8, 7, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(29, 8, 8, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(30, 8, 23, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(31, 9, 6, 'expert', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(32, 9, 10, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(33, 9, 17, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(34, 9, 20, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(35, 10, 10, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(36, 10, 11, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(37, 10, 24, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(38, 10, 26, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(39, 10, 27, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(40, 11, 31, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(41, 11, 33, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(42, 11, 34, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(43, 11, 35, 'expert', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(44, 19, 36, 'intermediate', '2026-05-22 15:30:51', '2026-05-22 15:30:53'),
(45, 34, 37, 'intermediate', '2026-06-11 18:05:33', '2026-06-11 18:05:33');

-- --------------------------------------------------------

--
-- Structure de la table `identity_verifications`
--

CREATE TABLE `identity_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `document_type` enum('passport','national_id','driving_license') NOT NULL DEFAULT 'national_id',
  `document_number` varchar(255) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `id_front_path` varchar(255) NOT NULL,
  `id_back_path` varchar(255) DEFAULT NULL,
  `selfie_path` varchar(255) NOT NULL,
  `status` enum('pending','in_review','approved','rejected') NOT NULL DEFAULT 'pending',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"3e4e46bf-7c68-4085-8abf-322b20ea8998\",\"displayName\":\"App\\\\Events\\\\MessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Message\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:1:{i:0;s:6:\\\"sender\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781060823,\"delay\":null}', 0, NULL, 1781060823, 1781060823),
(2, 'default', '{\"uuid\":\"dd0ea936-e68c-46d5-917e-c73d98cbddec\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:28;s:14:\\\"conversationId\\\";i:1;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:3:\\\"hhh\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:28;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 03:07:03.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781060823,\"delay\":null}', 0, NULL, 1781060824, 1781060824),
(3, 'default', '{\"uuid\":\"f348c6a2-6cb2-4272-a336-6fc98634188a\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:12;s:14:\\\"conversationId\\\";i:1;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:3:\\\"hhh\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:28;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 03:07:03.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781060824,\"delay\":null}', 0, NULL, 1781060824, 1781060824),
(4, 'default', '{\"uuid\":\"60fe51a4-c5d8-4254-b577-99bef3ef82b5\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:35;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"34c22325-fc79-4c63-984b-ad2c67ef2a7f\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-10T19:16:42+00:00\\\";s:4:\\\"icon\\\";s:4:\\\"file\\\";s:10:\\\"action_url\\\";s:18:\\\"\\/jobs\\/16\\/proposals\\\";s:4:\\\"type\\\";s:8:\\\"proposal\\\";s:5:\\\"title\\\";s:21:\\\"New proposal received\\\";s:4:\\\"body\\\";s:52:\\\"A freelancer submitted a proposal for \\\"firest jobe\\\".\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119004,\"delay\":null}', 0, NULL, 1781119004, 1781119004),
(5, 'default', '{\"uuid\":\"30bcc1ac-ed48-433f-b84f-1ce233a20498\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d7d45c71-cd7b-4109-bb4f-91afab11221f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781119004,\"delay\":null}', 0, NULL, 1781119005, 1781119005),
(6, 'default', '{\"uuid\":\"695594b1-95b0-479b-b0a7-93869f6101ad\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d7d45c71-cd7b-4109-bb4f-91afab11221f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781119005,\"delay\":null}', 0, NULL, 1781119005, 1781119005),
(7, 'default', '{\"uuid\":\"d8a889ca-986c-4c70-be3c-7a1f724c90e5\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d7d45c71-cd7b-4109-bb4f-91afab11221f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781119005,\"delay\":null}', 0, NULL, 1781119005, 1781119005),
(8, 'default', '{\"uuid\":\"f728aa2f-0fcb-4440-aa26-bc898b2df073\",\"displayName\":\"App\\\\Events\\\\MessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Message\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:1:{i:0;s:6:\\\"sender\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119319,\"delay\":null}', 0, NULL, 1781119319, 1781119319),
(9, 'default', '{\"uuid\":\"03b6ff59-b3c4-42fa-81f3-26b7b444a7d1\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:34;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:9:\\\"jbcajkx n\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:34;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:21:59.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119320,\"delay\":null}', 0, NULL, 1781119320, 1781119320),
(10, 'default', '{\"uuid\":\"16a88102-c738-4cb3-89dd-a3e9e00b6734\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:9:\\\"jbcajkx n\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:34;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:21:59.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119320,\"delay\":null}', 0, NULL, 1781119320, 1781119320),
(11, 'default', '{\"uuid\":\"1f9a0cf8-dbd2-4376-8137-3907ccb935cd\",\"displayName\":\"App\\\\Events\\\\MessageRead\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageRead\\\":3:{s:14:\\\"conversationId\\\";i:2;s:8:\\\"readerId\\\";i:35;s:6:\\\"readAt\\\";s:25:\\\"2026-06-10T19:22:18+00:00\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119338,\"delay\":null}', 0, NULL, 1781119338, 1781119338),
(12, 'default', '{\"uuid\":\"2e81ef58-bd82-4e07-806d-7dc1c3a91f21\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:34;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:9:\\\"jbcajkx n\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:34;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:21:59.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119338,\"delay\":null}', 0, NULL, 1781119338, 1781119338),
(13, 'default', '{\"uuid\":\"6289a326-eb97-4f71-abb9-2c9f8b35fddd\",\"displayName\":\"App\\\\Events\\\\MessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Message\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:1:{i:0;s:6:\\\"sender\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119358,\"delay\":null}', 0, NULL, 1781119358, 1781119358),
(14, 'default', '{\"uuid\":\"69679058-d35e-4989-945a-55851d7ffc99\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:34;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:7:\\\"jkghjhb\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:22:37.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119358,\"delay\":null}', 0, NULL, 1781119358, 1781119358),
(15, 'default', '{\"uuid\":\"b8a31936-700d-471e-ab9f-9509cb3dd50b\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:7:\\\"jkghjhb\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:22:37.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119358,\"delay\":null}', 0, NULL, 1781119358, 1781119358),
(16, 'default', '{\"uuid\":\"4f68594c-d0eb-4176-a339-38c34d929630\",\"displayName\":\"App\\\\Events\\\\MessageRead\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageRead\\\":3:{s:14:\\\"conversationId\\\";i:2;s:8:\\\"readerId\\\";i:34;s:6:\\\"readAt\\\";s:25:\\\"2026-06-10T19:23:06+00:00\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119386,\"delay\":null}', 0, NULL, 1781119386, 1781119386),
(17, 'default', '{\"uuid\":\"c5c67bef-63b7-4844-9cc1-884998d396f7\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:7:\\\"jkghjhb\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:22:37.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119386,\"delay\":null}', 0, NULL, 1781119386, 1781119386),
(18, 'default', '{\"uuid\":\"a3e43e1d-f003-4f9d-bcad-625224e0beea\",\"displayName\":\"App\\\\Events\\\\MessageReactionToggled\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:33:\\\"App\\\\Events\\\\MessageReactionToggled\\\":5:{s:14:\\\"conversationId\\\";i:2;s:9:\\\"messageId\\\";i:3;s:6:\\\"userId\\\";i:34;s:5:\\\"emoji\\\";s:4:\\\"Ã°ÂŸÂ˜Â‚\\\";s:6:\\\"action\\\";s:5:\\\"added\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119403,\"delay\":null}', 0, NULL, 1781119403, 1781119403),
(19, 'default', '{\"uuid\":\"96f3cf56-5154-4180-8ab4-ed7ada4220a0\",\"displayName\":\"App\\\\Events\\\\MessageReactionToggled\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:33:\\\"App\\\\Events\\\\MessageReactionToggled\\\":5:{s:14:\\\"conversationId\\\";i:2;s:9:\\\"messageId\\\";i:3;s:6:\\\"userId\\\";i:34;s:5:\\\"emoji\\\";s:6:\\\"Ã¢ÂÂ¤Ã¯Â¸Â\\\";s:6:\\\"action\\\";s:5:\\\"added\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119407,\"delay\":null}', 0, NULL, 1781119407, 1781119407),
(20, 'default', '{\"uuid\":\"e447a96c-117b-46f1-adad-6407e2970e46\",\"displayName\":\"App\\\\Events\\\\MessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Message\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:1:{i:0;s:6:\\\"sender\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119826,\"delay\":null}', 0, NULL, 1781119826, 1781119826),
(21, 'default', '{\"uuid\":\"c5bd7653-6229-4ca5-8207-db30fdd02779\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:34;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:2:\\\"hi\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:30:25.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119826,\"delay\":null}', 0, NULL, 1781119826, 1781119826),
(22, 'default', '{\"uuid\":\"d73e2bd5-ad39-4162-a3a5-62c151852456\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:2:\\\"hi\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:30:25.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781119826,\"delay\":null}', 0, NULL, 1781119826, 1781119826),
(23, 'default', '{\"uuid\":\"c5f30447-89a1-4a4a-ac5d-98a8b820c301\",\"displayName\":\"App\\\\Events\\\\MessageRead\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageRead\\\":3:{s:14:\\\"conversationId\\\";i:2;s:8:\\\"readerId\\\";i:34;s:6:\\\"readAt\\\";s:25:\\\"2026-06-11T02:10:22+00:00\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781143822,\"delay\":null}', 0, NULL, 1781143822, 1781143822),
(24, 'default', '{\"uuid\":\"6c0ebb23-d1d5-4268-a7a5-d3493659d5bc\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:2:\\\"hi\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-10 19:30:25.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781143822,\"delay\":null}', 0, NULL, 1781143822, 1781143822),
(25, 'default', '{\"uuid\":\"cffd0420-229b-4f67-aa2c-c8c9893cf1cd\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:34;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"51ad5a8c-47c2-433e-9d4c-bbe466e99e35\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T02:34:50+00:00\\\";s:4:\\\"icon\\\";s:9:\\\"briefcase\\\";s:10:\\\"action_url\\\";s:12:\\\"\\/contracts\\/1\\\";s:4:\\\"type\\\";s:8:\\\"contract\\\";s:5:\\\"title\\\";s:16:\\\"Contract created\\\";s:4:\\\"body\\\";s:73:\\\"Your proposal for \\\"firest jobe\\\" was accepted. The contract is now active.\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781145290,\"delay\":null}', 0, NULL, 1781145290, 1781145290),
(26, 'default', '{\"uuid\":\"ccf0fd2e-963e-4a21-8dfc-31a96b34b18c\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"b9928724-0c69-4ea4-b2c7-0d56532bef72\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781145290,\"delay\":null}', 0, NULL, 1781145290, 1781145290),
(27, 'default', '{\"uuid\":\"44cc6c9d-fde4-40c0-86ff-8a59aad8d6a3\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"b9928724-0c69-4ea4-b2c7-0d56532bef72\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781145290,\"delay\":null}', 0, NULL, 1781145290, 1781145290),
(28, 'default', '{\"uuid\":\"9a0d875d-cdfc-489f-af4a-77bf171f2aa5\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"b9928724-0c69-4ea4-b2c7-0d56532bef72\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781145290,\"delay\":null}', 0, NULL, 1781145290, 1781145290),
(29, 'default', '{\"uuid\":\"149b4150-e6ef-4f1e-950c-0efd0529b308\",\"displayName\":\"App\\\\Events\\\\MessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Message\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:1:{i:0;s:6:\\\"sender\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781145324,\"delay\":null}', 0, NULL, 1781145324, 1781145324),
(30, 'default', '{\"uuid\":\"3e2a04f7-11e0-428b-b5d1-c27f173ec183\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:34;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:1:\\\"H\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-11 02:35:24.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781145324,\"delay\":null}', 0, NULL, 1781145324, 1781145324),
(31, 'default', '{\"uuid\":\"9a391d0a-75bc-47c9-ae9f-28ce1893071b\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:1:\\\"H\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-11 02:35:24.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781145324,\"delay\":null}', 0, NULL, 1781145324, 1781145324),
(32, 'default', '{\"uuid\":\"b574bd37-6cf1-4824-b7fa-8baf3606914f\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:34;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"a68d87a2-d719-4d44-a4ea-2719550ce022\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T02:37:13+00:00\\\";s:4:\\\"icon\\\";s:12:\\\"check-circle\\\";s:10:\\\"action_url\\\";s:12:\\\"\\/contracts\\/1\\\";s:4:\\\"type\\\";s:8:\\\"contract\\\";s:5:\\\"title\\\";s:18:\\\"Contract completed\\\";s:4:\\\"body\\\";s:44:\\\"Contract \\\"firest jobe\\\" was marked completed.\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781145433,\"delay\":null}', 0, NULL, 1781145433, 1781145433),
(33, 'default', '{\"uuid\":\"5d901919-abb8-4cf4-98c4-fbb2a2383d8b\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:37;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"9a8e6257-28df-42ee-8695-f988c40b22fe\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T16:23:33+00:00\\\";s:4:\\\"icon\\\";s:4:\\\"file\\\";s:10:\\\"action_url\\\";s:18:\\\"\\/jobs\\/17\\/proposals\\\";s:4:\\\"type\\\";s:8:\\\"proposal\\\";s:5:\\\"title\\\";s:21:\\\"New proposal received\\\";s:4:\\\"body\\\";s:44:\\\"A freelancer submitted a proposal for \\\"TOW\\\".\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781195014,\"delay\":null}', 0, NULL, 1781195014, 1781195014),
(34, 'default', '{\"uuid\":\"fedb5a68-8978-46db-96c5-0dba34ed8a4b\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:37;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"28253329-3b3e-44be-9801-8ab71d7f70eb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781195015,\"delay\":null}', 0, NULL, 1781195015, 1781195015),
(35, 'default', '{\"uuid\":\"f3e62175-5ecf-43a8-bcc7-7a0a17fa2961\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:37;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"28253329-3b3e-44be-9801-8ab71d7f70eb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781195015,\"delay\":null}', 0, NULL, 1781195015, 1781195015),
(36, 'default', '{\"uuid\":\"561bf1ee-f7ad-4580-a040-14abf0c7b6fe\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:37;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"28253329-3b3e-44be-9801-8ab71d7f70eb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781195015,\"delay\":null}', 0, NULL, 1781195015, 1781195015);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(37, 'default', '{\"uuid\":\"dfc02879-97eb-4789-90e9-eb29b7240426\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:34;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"aec7b08d-85ac-42b6-a875-611ba841af83\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T16:24:38+00:00\\\";s:4:\\\"icon\\\";s:9:\\\"briefcase\\\";s:10:\\\"action_url\\\";s:12:\\\"\\/contracts\\/2\\\";s:4:\\\"type\\\";s:8:\\\"contract\\\";s:5:\\\"title\\\";s:16:\\\"Contract created\\\";s:4:\\\"body\\\";s:65:\\\"Your proposal for \\\"TOW\\\" was accepted. The contract is now active.\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781195079,\"delay\":null}', 0, NULL, 1781195079, 1781195079),
(38, 'default', '{\"uuid\":\"769b935e-499a-4a64-afc9-106c578a1bbf\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"ebb0e9e0-57af-46d3-be1c-3ce518fd472d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781195079,\"delay\":null}', 0, NULL, 1781195079, 1781195079),
(39, 'default', '{\"uuid\":\"36619865-1d19-477b-b8b3-d2210f28c598\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"ebb0e9e0-57af-46d3-be1c-3ce518fd472d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781195079,\"delay\":null}', 0, NULL, 1781195079, 1781195079),
(40, 'default', '{\"uuid\":\"e3ff6e87-c32f-4085-a469-9e8eff097152\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"ebb0e9e0-57af-46d3-be1c-3ce518fd472d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781195079,\"delay\":null}', 0, NULL, 1781195079, 1781195079),
(41, 'default', '{\"uuid\":\"b922f18a-b21f-4cdd-89a8-95895030f83f\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:35;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"d9d62063-89f9-40a8-b43a-70488efefe7a\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T20:11:05+00:00\\\";s:4:\\\"icon\\\";s:4:\\\"file\\\";s:10:\\\"action_url\\\";s:18:\\\"\\/jobs\\/19\\/proposals\\\";s:4:\\\"type\\\";s:8:\\\"proposal\\\";s:5:\\\"title\\\";s:21:\\\"New proposal received\\\";s:4:\\\"body\\\";s:49:\\\"A freelancer submitted a proposal for \\\"3erd job\\\".\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781208665,\"delay\":null}', 0, NULL, 1781208665, 1781208665),
(42, 'default', '{\"uuid\":\"6e79419f-e068-48a2-b128-736e615c5187\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d602580d-8604-40d1-9f3c-5ccd76191eb4\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781208666,\"delay\":null}', 0, NULL, 1781208666, 1781208666),
(43, 'default', '{\"uuid\":\"ac0083ec-d739-43fa-9003-faafdad6f49b\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d602580d-8604-40d1-9f3c-5ccd76191eb4\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781208666,\"delay\":null}', 0, NULL, 1781208666, 1781208666),
(44, 'default', '{\"uuid\":\"607153a5-35be-4b87-aa81-24ccf205defc\",\"displayName\":\"App\\\\Notifications\\\\ProposalReceivedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:35;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:46:\\\"App\\\\Notifications\\\\ProposalReceivedNotification\\\":2:{s:8:\\\"proposal\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Proposal\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"d602580d-8604-40d1-9f3c-5ccd76191eb4\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781208666,\"delay\":null}', 0, NULL, 1781208666, 1781208666),
(45, 'default', '{\"uuid\":\"26de390b-7473-4443-b5b5-a5176b5e9304\",\"displayName\":\"App\\\\Events\\\\NotificationCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\NotificationCreated\\\":3:{s:6:\\\"userId\\\";i:34;s:7:\\\"payload\\\";a:7:{s:2:\\\"id\\\";s:36:\\\"ae7074a1-4537-4eac-b8a1-6513b238a9d5\\\";s:10:\\\"created_at\\\";s:25:\\\"2026-06-11T20:11:45+00:00\\\";s:4:\\\"icon\\\";s:9:\\\"briefcase\\\";s:10:\\\"action_url\\\";s:12:\\\"\\/contracts\\/3\\\";s:4:\\\"type\\\";s:8:\\\"contract\\\";s:5:\\\"title\\\";s:16:\\\"Contract created\\\";s:4:\\\"body\\\";s:70:\\\"Your proposal for \\\"3erd job\\\" was accepted. The contract is now active.\\\";}s:11:\\\"unreadCount\\\";i:1;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781208705,\"delay\":null}', 0, NULL, 1781208705, 1781208705),
(46, 'default', '{\"uuid\":\"d46c9cbb-a6a5-4684-9156-5b62fa24a386\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"4cc179aa-26b8-4398-bf81-af801a4cf49a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\",\"batchId\":null},\"createdAt\":1781208705,\"delay\":null}', 0, NULL, 1781208705, 1781208705),
(47, 'default', '{\"uuid\":\"6dc52611-f407-4003-80ae-8a23df27c14d\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"4cc179aa-26b8-4398-bf81-af801a4cf49a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1781208705,\"delay\":null}', 0, NULL, 1781208705, 1781208705),
(48, 'default', '{\"uuid\":\"1d67a857-d418-4f35-b478-66231e2e6588\",\"displayName\":\"App\\\\Notifications\\\\ContractCreatedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:34;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:45:\\\"App\\\\Notifications\\\\ContractCreatedNotification\\\":2:{s:8:\\\"contract\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Contract\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"4cc179aa-26b8-4398-bf81-af801a4cf49a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:9:\\\"broadcast\\\";}}\",\"batchId\":null},\"createdAt\":1781208705,\"delay\":null}', 0, NULL, 1781208705, 1781208705),
(49, 'default', '{\"uuid\":\"d3ea449e-85d2-4196-a497-ec5a23a5c609\",\"displayName\":\"App\\\\Events\\\\MessageRead\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:22:\\\"App\\\\Events\\\\MessageRead\\\":3:{s:14:\\\"conversationId\\\";i:2;s:8:\\\"readerId\\\";i:34;s:6:\\\"readAt\\\";s:25:\\\"2026-06-11T20:25:32+00:00\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781209532,\"delay\":null}', 0, NULL, 1781209532, 1781209532),
(50, 'default', '{\"uuid\":\"1a3e714f-7cc6-4b85-960e-df79ff7e67de\",\"displayName\":\"App\\\\Events\\\\ConversationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":17:{s:5:\\\"event\\\";O:30:\\\"App\\\\Events\\\\ConversationUpdated\\\":4:{s:6:\\\"userId\\\";i:35;s:14:\\\"conversationId\\\";i:2;s:11:\\\"lastMessage\\\";a:4:{s:7:\\\"content\\\";s:1:\\\"H\\\";s:4:\\\"type\\\";s:4:\\\"text\\\";s:9:\\\"sender_id\\\";i:35;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-06-11 02:35:24.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:11:\\\"unreadCount\\\";i:0;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:23:\\\"deleteWhenMissingModels\\\";b:1;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781209532,\"delay\":null}', 0, NULL, 1781209532, 1781209532);

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_postings`
--

CREATE TABLE `job_postings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `type` enum('hourly','fixed') NOT NULL DEFAULT 'fixed',
  `experience_level` enum('entry','intermediate','expert') NOT NULL DEFAULT 'intermediate',
  `budget_min` decimal(12,2) DEFAULT NULL,
  `budget_max` decimal(12,2) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `status` enum('draft','open','in_progress','completed','cancelled','paused') NOT NULL DEFAULT 'open',
  `visibility` enum('public','invite_only') NOT NULL DEFAULT 'public',
  `location_requirement` varchar(255) DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `proposals_count` int(11) NOT NULL DEFAULT 0,
  `views_count` int(11) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_urgent` tinyint(1) NOT NULL DEFAULT 0,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `job_postings`
--

INSERT INTO `job_postings` (`id`, `client_id`, `title`, `description`, `category_id`, `skills`, `type`, `experience_level`, `budget_min`, `budget_max`, `duration`, `status`, `visibility`, `location_requirement`, `attachments`, `proposals_count`, `views_count`, `is_featured`, `is_urgent`, `expires_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 12, 'Build a SaaS Dashboard with Laravel & React', 'We need a senior full-stack developer to build a modern SaaS analytics dashboard. Features: user auth, role-based access, real-time charts, REST API, and a clean TailwindCSS UI. Laravel 12 + React 18.', 1, '[\"Laravel\",\"React\",\"MySQL\",\"TypeScript\"]', 'fixed', 'expert', 2000.00, 5000.00, NULL, 'open', 'public', NULL, NULL, 26, 177, 0, 0, NULL, '2026-05-22 14:22:02', '2026-06-11 17:57:43', NULL),
(2, 12, 'E-Commerce Platform with Laravel & Vue.js', 'Building a full e-commerce platform: product catalog, cart, Stripe checkout, order management, and admin panel. Must have proven Laravel 10+ and Vue 3 experience.', 1, '[\"PHP\",\"Laravel\",\"Vue.js\",\"MySQL\"]', 'fixed', 'intermediate', 1500.00, 4000.00, NULL, 'open', 'public', NULL, NULL, 30, 168, 0, 0, NULL, '2026-05-22 14:22:02', '2026-06-11 16:16:16', NULL),
(3, 12, 'RESTful API Development for Fintech App', 'Need an experienced backend developer to design and implement a secure RESTful API for a fintech application. JWT auth, rate limiting, webhook handling, and full Swagger documentation required.', 1, '[\"Node.js\",\"PostgreSQL\",\"Docker\",\"TypeScript\"]', 'hourly', 'expert', 60.00, 100.00, NULL, 'in_progress', 'public', NULL, NULL, 15, 118, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(4, 13, 'React Native Shopping App (iOS & Android)', 'Building a polished cross-platform shopping app with product listings, cart, push notifications, Stripe payments, and smooth animations. 100k+ target users on day one.', 6, '[\"React Native\",\"JavaScript\",\"TypeScript\"]', 'fixed', 'expert', 3000.00, 8000.00, NULL, 'open', 'public', NULL, NULL, 21, 149, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(5, 15, 'Flutter Game Companion App', 'We need a Flutter developer to build a companion mobile app for our mobile game. Features: leaderboard, achievements, in-app purchases, real-time chat, and push notifications.', 6, '[\"Flutter\",\"Kotlin\",\"Swift\"]', 'fixed', 'expert', 2500.00, 6000.00, NULL, 'open', 'public', NULL, NULL, 16, 685, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(6, 14, 'Customer Churn Prediction ML Model', 'Build a machine learning model to predict customer churn from historical data. Deliver a production-ready Python API endpoint with model documentation and performance metrics.', 3, '[\"Python\",\"Machine Learning\",\"Data Science\"]', 'hourly', 'expert', 70.00, 110.00, NULL, 'open', 'public', NULL, NULL, 24, 167, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(7, 14, 'NLP Chatbot for Customer Support Automation', 'AI-powered chatbot for customer support. Must handle FAQs, classify intent, escalate to humans, and integrate with our helpdesk. Rasa, LangChain, or OpenAI experience preferred.', 3, '[\"NLP\",\"Python\",\"TensorFlow\"]', 'fixed', 'expert', 2000.00, 5000.00, NULL, 'open', 'public', NULL, NULL, 22, 792, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(8, 16, 'Medical Image Analysis with Computer Vision', 'We need a CV specialist to build a model that detects abnormalities in medical X-ray images. FDA-compliance awareness is a plus. Must deliver validated model with >90% accuracy.', 3, '[\"Python\",\"TensorFlow\",\"Machine Learning\"]', 'fixed', 'expert', 4000.00, 10000.00, NULL, 'open', 'public', NULL, NULL, 28, 572, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(9, 13, 'Brand Identity & Logo Design for Marketing Agency', 'Looking for a talented brand designer to create a complete brand identity: logo, color palette, typography, business cards, and brand guidelines document. Creative portfolio required.', 2, '[\"Branding\",\"Figma\",\"UI Design\"]', 'fixed', 'intermediate', 800.00, 2000.00, NULL, 'open', 'public', NULL, NULL, 13, 203, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(10, 17, 'UX Redesign for Luxury E-Commerce Website', 'Full UX audit and redesign of our luxury e-commerce site. Deliverables: user research report, wireframes, hi-fi Figma prototype, and design system. Experience with high-end brands preferred.', 2, '[\"UX Design\",\"Figma\",\"UI Design\"]', 'fixed', 'expert', 1500.00, 4000.00, NULL, 'open', 'public', NULL, NULL, 11, 611, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(11, 13, 'SaaS Blog Content Ã¢Â€Â” 8 Technical Articles/Month', 'We need a skilled technical writer to produce 8 in-depth blog articles per month covering SaaS, cloud, and developer topics. SEO-optimized, audience: CTOs and developers.', 4, '[\"Content Writing\",\"SEO\",\"Copywriting\"]', 'hourly', 'intermediate', 35.00, 60.00, NULL, 'open', 'public', NULL, NULL, 23, 122, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(12, 16, 'Healthcare App Ã¢Â€Â” User Documentation & Help Center', 'Create complete user documentation, FAQ, and help center content for our healthcare mobile app. Clear, empathetic writing style required. Medical writing experience is a plus.', 4, '[\"Content Writing\",\"Copywriting\"]', 'fixed', 'intermediate', 600.00, 1500.00, NULL, 'open', 'public', NULL, NULL, 12, 386, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(13, 14, 'Google Ads & SEO Campaign for B2B SaaS', 'Performance marketer needed to manage Google Ads campaigns and SEO strategy for our B2B SaaS. Target: $5 CPA on demo requests. Experience with HubSpot and Salesforce preferred.', 5, '[\"Google Ads\",\"SEO\",\"Email Marketing\"]', 'hourly', 'expert', 50.00, 90.00, NULL, 'open', 'public', NULL, NULL, 23, 474, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(14, 17, 'Email Marketing Automation Ã¢Â€Â” Klaviyo Setup', 'Set up full Klaviyo email automation flows for our e-commerce store: welcome series, abandoned cart, post-purchase, winback. Write all email copy and design templates.', 5, '[\"Email Marketing\",\"Copywriting\"]', 'fixed', 'intermediate', 500.00, 1200.00, NULL, 'open', 'public', NULL, NULL, 29, 678, 0, 0, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', NULL),
(15, 12, 'Kubernetes Cluster Setup & CI/CD Pipeline', 'Set up production-grade Kubernetes cluster on AWS EKS with Helm charts, auto-scaling, monitoring (Grafana/Prometheus), and GitHub Actions CI/CD. Must deliver full documentation.', 1, '[\"Kubernetes\",\"Docker\",\"AWS\"]', 'fixed', 'expert', 1000.00, 3000.00, NULL, 'open', 'public', NULL, NULL, 2, 126, 0, 0, NULL, '2026-05-22 14:22:02', '2026-06-11 18:52:38', '2026-06-11 18:52:38'),
(16, 35, 'firest jobe', 'qwtyhbvxsyjnbchghjghjghjvhjvjvgjcgcvhcghcghcghcghfghgh', 5, '[]', 'hourly', 'entry', 12.00, 18.00, '1_3_months', 'in_progress', 'public', 'moroco', NULL, 1, 65, 0, 0, NULL, '2026-06-10 18:15:22', '2026-06-11 18:41:21', NULL),
(17, 37, 'TOW', 'XSNOANOJASNXJO SCSb uicbA UIIBIASC BAXSIBIJBCSJIAB', 2, '[]', 'fixed', 'entry', 13.00, 14.00, 'less_than_week', 'in_progress', 'public', 'MOROCO', NULL, 1, 26, 0, 0, NULL, '2026-06-11 15:21:30', '2026-06-13 12:18:20', NULL),
(18, 12, 'Test Job From Search', 'This is a test job to verify it appears in the search page results after being posted. It should show up immediately.', 1, '[\"React\",\"Laravel\"]', 'fixed', 'intermediate', 500.00, 1500.00, NULL, 'open', 'public', NULL, NULL, 0, 0, 0, 0, NULL, '2026-06-11 18:41:06', '2026-06-11 18:53:14', '2026-06-11 18:53:14'),
(19, 35, '3erd job', 'this is  for testing but stile not ofitinale jobe  fojcijxjn hibkx', 4, '[]', 'fixed', 'entry', 11.00, 12.00, 'less_than_week', 'in_progress', 'public', 'moroco', NULL, 1, 6, 0, 0, NULL, '2026-06-11 19:10:01', '2026-06-11 19:11:45', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `body` text DEFAULT NULL,
  `type` enum('text','file','image','system','offer') NOT NULL DEFAULT 'text',
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `reply_to_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `body`, `type`, `attachments`, `metadata`, `is_read`, `read_at`, `edited_at`, `delivered_at`, `reply_to_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 28, 'hhh', 'text', NULL, NULL, 0, NULL, NULL, NULL, NULL, '2026-06-10 02:07:03', '2026-06-10 02:07:03', NULL),
(2, 2, 34, 'jbcajkx n', 'text', NULL, NULL, 1, '2026-06-10 18:22:18', NULL, NULL, NULL, '2026-06-10 18:21:59', '2026-06-10 18:22:18', NULL),
(3, 2, 35, 'jkghjhb', 'text', NULL, NULL, 1, '2026-06-10 18:23:06', NULL, NULL, NULL, '2026-06-10 18:22:37', '2026-06-10 18:23:06', NULL),
(4, 2, 35, 'hi', 'text', NULL, NULL, 1, '2026-06-11 01:10:22', NULL, NULL, NULL, '2026-06-10 18:30:25', '2026-06-11 01:10:22', NULL),
(5, 2, 35, 'H', 'text', NULL, NULL, 1, '2026-06-11 19:25:32', NULL, NULL, NULL, '2026-06-11 01:35:24', '2026-06-11 19:25:32', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `message_reactions`
--

CREATE TABLE `message_reactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `emoji` varchar(16) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `message_reactions`
--

INSERT INTO `message_reactions` (`id`, `message_id`, `user_id`, `emoji`, `created_at`, `updated_at`) VALUES
(1, 3, 34, 'Ã°ÂŸÂ˜Â‚', '2026-06-10 18:23:23', '2026-06-10 18:23:23'),
(2, 3, 34, 'Ã¢ÂÂ¤Ã¯Â¸Â', '2026-06-10 18:23:27', '2026-06-10 18:23:27');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_01_01_000001_create_freelancers_table', 1),
(5, '2024_01_02_000001_create_jobs_proposals_table', 1),
(6, '2024_01_03_000001_create_chat_payments_table', 1),
(7, '2024_01_04_000001_create_notifications_table', 1),
(8, '2024_01_05_000001_make_reviews_contract_nullable', 1),
(9, '2026_05_19_231439_create_personal_access_tokens_table', 1),
(10, '2026_05_21_000001_add_phone_verified_to_users_table', 1),
(11, '2026_05_26_000001_add_onboarding_fields_to_freelancer_profiles', 2),
(12, '2026_06_02_000001_create_payment_infrastructure', 2),
(13, '2026_06_02_000002_create_stripe_infrastructure', 2),
(14, '2026_06_03_000001_upgrade_chat_for_realtime', 2),
(15, '2026_06_04_000001_add_contract_dispute_fields', 2),
(16, '2026_06_05_000001_contracts_advanced_features', 2),
(17, '2026_06_06_000001_add_created_by_to_milestones', 2),
(18, '2026_06_07_000001_create_audit_logs_table', 2),
(19, '2026_06_07_000002_create_identity_verifications_table', 2),
(20, '2026_06_07_000003_add_two_factor_to_users_table', 2),
(21, '2026_06_08_000001_create_talent_lists_and_saved_freelancers', 2),
(22, '2026_06_08_000002_create_tax_documents_table', 2),
(23, '2026_06_08_000003_add_fulltext_indexes_for_search', 2),
(24, '2026_06_08_000004_create_push_subscriptions_table', 2),
(25, '2026_06_09_000001_migrate_connects_to_users_and_drop_legacy_subscriptions', 2),
(26, '2026_06_09_000002_recreate_subscriptions_with_modern_schema', 2),
(27, '2026_06_10_000001_add_hourly_billing_to_contracts', 2),
(28, '2026_06_10_000002_create_agencies_tables', 2),
(29, '2026_06_10_000003_create_catalog_tables', 2),
(30, '2026_06_10_000004_make_contract_job_proposal_nullable', 2);

-- --------------------------------------------------------

--
-- Structure de la table `milestones`
--

CREATE TABLE `milestones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` enum('pending','in_progress','submitted','approved','rejected','paid') NOT NULL DEFAULT 'pending',
  `due_at` timestamp NULL DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `submission_notes` text DEFAULT NULL,
  `submitted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('04483c5b-a1c4-4d39-bbff-8d606f5c7276', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 18, '{\"type\":\"message\",\"icon\":\"message\",\"title\":\"New message from client\",\"body\":\"You have a new message regarding the React Native app project.\",\"action_url\":\"\\/messages\"}', NULL, '2026-05-22 14:02:30', '2026-05-22 14:02:30'),
('0a6e513b-d0a4-41c0-b72c-836f8a773d6f', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 19, '{\"type\":\"review\",\"icon\":\"star\",\"title\":\"5\\u2605 review received\",\"body\":\"James R. left you a 5-star review: \\\"Exceptional work, highly recommended!\\\"\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-05-22 14:30:25', '2026-05-22 14:30:25'),
('2a53fc80-bb81-4089-88f1-8cf4364616c3', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 38, '{\"type\":\"review\",\"icon\":\"star\",\"title\":\"5\\u2605 review received\",\"body\":\"James R. left you a 5-star review: \\\"Exceptional work, highly recommended!\\\"\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-06-13 12:07:46', '2026-06-13 12:07:46'),
('32c7cb0e-64f1-4782-8427-fcb351b76ca0', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 12, '{\"type\":\"payment\",\"icon\":\"payment\",\"title\":\"Escrow funded successfully\",\"body\":\"$2,400 has been placed in escrow for the milestone \\\"UI Design Phase\\\".\",\"action_url\":\"\\/payments\"}', NULL, '2026-06-11 17:52:15', '2026-06-11 17:52:15'),
('34c22325-fc79-4c63-984b-ad2c67ef2a7f', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 35, '{\"icon\":\"file\",\"action_url\":\"\\/jobs\\/16\\/proposals\",\"type\":\"proposal\",\"title\":\"New proposal received\",\"body\":\"A freelancer submitted a proposal for \\\"firest jobe\\\".\"}', '2026-06-10 18:17:27', '2026-06-10 18:16:42', '2026-06-10 18:16:42'),
('367ef2ad-a6eb-42ba-b533-08a24be2e1ea', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 38, '{\"type\":\"payment\",\"icon\":\"payment\",\"title\":\"$480 released to wallet\",\"body\":\"Milestone payment released. Funds are now available in your wallet.\",\"action_url\":\"\\/payments\"}', NULL, '2026-06-13 12:22:46', '2026-06-13 12:22:46'),
('3693d944-80e9-491f-83f2-6d527458b16a', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 1, '{\"type\":\"system\",\"icon\":\"shield\",\"title\":\"Suspicious login attempt\",\"body\":\"Multiple failed login attempts detected from IP 192.168.1.45.\",\"action_url\":\"\\/admin\\/dashboard\"}', NULL, '2026-06-11 17:28:27', '2026-06-11 17:28:27'),
('40185746-9c55-435f-8be6-925c2979d297', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 12, '{\"type\":\"system\",\"icon\":\"bell\",\"title\":\"AI matched 3 top talents\",\"body\":\"Based on your job posting, AI matched 3 highly-rated freelancers for you.\",\"action_url\":\"\\/my-jobs\"}', NULL, '2026-06-11 17:37:15', '2026-06-11 17:37:15'),
('444ee8ba-d9f2-4c5e-a2c8-8b2fe0059db2', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 19, '{\"type\":\"system\",\"icon\":\"bell\",\"title\":\"Profile viewed 12 times\",\"body\":\"Your profile was viewed 12 times this week. Consider updating your portfolio.\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-05-22 14:15:25', '2026-05-22 14:15:25'),
('48cc59d5-ba2c-404d-80b3-2ab505cdc8c3', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 19, '{\"type\":\"proposal\",\"icon\":\"file\",\"title\":\"Proposal accepted!\",\"body\":\"TechStartup Inc accepted your proposal for the SaaS Dashboard project.\",\"action_url\":\"\\/my-proposals\"}', NULL, '2026-05-22 15:15:25', '2026-05-22 15:15:25'),
('4e32234f-9e91-46b0-ace7-3754f6f4e2fc', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 18, '{\"type\":\"payment\",\"icon\":\"payment\",\"title\":\"$480 released to wallet\",\"body\":\"Milestone payment released. Funds are now available in your wallet.\",\"action_url\":\"\\/payments\"}', '2026-06-12 15:23:52', '2026-05-22 13:47:30', '2026-05-22 13:47:30'),
('51ad5a8c-47c2-433e-9d4c-bbe466e99e35', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 34, '{\"icon\":\"briefcase\",\"action_url\":\"\\/contracts\\/1\",\"type\":\"contract\",\"title\":\"Contract created\",\"body\":\"Your proposal for \\\"firest jobe\\\" was accepted. The contract is now active.\"}', '2026-06-11 01:35:46', '2026-06-11 01:34:50', '2026-06-11 01:34:50'),
('6bfbd01d-d012-4160-8eba-ca7246814d88', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 1, '{\"type\":\"system\",\"icon\":\"bell\",\"title\":\"12 new users this week\",\"body\":\"Platform growth: 12 new registrations in the past 7 days.\",\"action_url\":\"\\/admin\\/dashboard\"}', NULL, '2026-06-11 17:43:27', '2026-06-11 17:43:27'),
('6e0e773f-a2f9-48a1-9488-5149db66384d', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 12, '{\"type\":\"proposal\",\"icon\":\"file\",\"title\":\"5 new proposals received\",\"body\":\"Your \\\"SaaS Dashboard\\\" job has 5 new proposals ready for review.\",\"action_url\":\"\\/my-jobs\"}', NULL, '2026-06-11 18:22:15', '2026-06-11 18:22:15'),
('86d9efcc-dd59-46c9-bb5b-ae0825f64d54', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 18, '{\"type\":\"system\",\"icon\":\"bell\",\"title\":\"Profile viewed 12 times\",\"body\":\"Your profile was viewed 12 times this week. Consider updating your portfolio.\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-05-22 13:17:30', '2026-05-22 13:17:30'),
('8dc91498-f7f6-4a05-8c3a-cbcdb63efc3b', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 19, '{\"type\":\"payment\",\"icon\":\"payment\",\"title\":\"$480 released to wallet\",\"body\":\"Milestone payment released. Funds are now available in your wallet.\",\"action_url\":\"\\/payments\"}', NULL, '2026-05-22 14:45:25', '2026-05-22 14:45:25'),
('99b3c881-2ec1-4c7e-aad4-0016b7a11364', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 38, '{\"type\":\"proposal\",\"icon\":\"file\",\"title\":\"Proposal accepted!\",\"body\":\"TechStartup Inc accepted your proposal for the SaaS Dashboard project.\",\"action_url\":\"\\/my-proposals\"}', NULL, '2026-06-13 12:52:46', '2026-06-13 12:52:46'),
('9a8e6257-28df-42ee-8695-f988c40b22fe', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 37, '{\"icon\":\"file\",\"action_url\":\"\\/jobs\\/17\\/proposals\",\"type\":\"proposal\",\"title\":\"New proposal received\",\"body\":\"A freelancer submitted a proposal for \\\"TOW\\\".\"}', '2026-06-11 15:23:58', '2026-06-11 15:23:33', '2026-06-11 15:23:33'),
('a085cac9-0c5c-48c2-96d8-227539ac7c50', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 1, '{\"type\":\"payment\",\"icon\":\"payment\",\"title\":\"Platform revenue: $8,420\",\"body\":\"Total platform commission collected this month: $8,420.\",\"action_url\":\"\\/admin\\/dashboard\"}', '2026-06-11 18:00:17', '2026-06-11 17:13:27', '2026-06-11 17:13:27'),
('a68d87a2-d719-4d44-a4ea-2719550ce022', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 34, '{\"icon\":\"check-circle\",\"action_url\":\"\\/contracts\\/1\",\"type\":\"contract\",\"title\":\"Contract completed\",\"body\":\"Contract \\\"firest jobe\\\" was marked completed.\"}', '2026-06-11 01:38:08', '2026-06-11 01:37:13', '2026-06-11 01:37:13'),
('aa2afd0c-b1cd-4fc8-903b-b790907dc3f5', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 18, '{\"type\":\"review\",\"icon\":\"star\",\"title\":\"5\\u2605 review received\",\"body\":\"James R. left you a 5-star review: \\\"Exceptional work, highly recommended!\\\"\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-05-22 13:32:30', '2026-05-22 13:32:30'),
('ae7074a1-4537-4eac-b8a1-6513b238a9d5', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 34, '{\"icon\":\"briefcase\",\"action_url\":\"\\/contracts\\/3\",\"type\":\"contract\",\"title\":\"Contract created\",\"body\":\"Your proposal for \\\"3erd job\\\" was accepted. The contract is now active.\"}', NULL, '2026-06-11 19:11:45', '2026-06-11 19:11:45'),
('aec7b08d-85ac-42b6-a875-611ba841af83', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 34, '{\"icon\":\"briefcase\",\"action_url\":\"\\/contracts\\/2\",\"type\":\"contract\",\"title\":\"Contract created\",\"body\":\"Your proposal for \\\"TOW\\\" was accepted. The contract is now active.\"}', '2026-06-11 15:25:37', '2026-06-11 15:24:38', '2026-06-11 15:24:38'),
('b6f323ce-8758-4654-9da5-f93df6cafb0b', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 38, '{\"type\":\"message\",\"icon\":\"message\",\"title\":\"New message from client\",\"body\":\"You have a new message regarding the React Native app project.\",\"action_url\":\"\\/messages\"}', NULL, '2026-06-13 12:37:46', '2026-06-13 12:37:46'),
('b9e22c11-5769-47b0-9f33-a75baf436024', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 18, '{\"type\":\"proposal\",\"icon\":\"file\",\"title\":\"Proposal accepted!\",\"body\":\"TechStartup Inc accepted your proposal for the SaaS Dashboard project.\",\"action_url\":\"\\/my-proposals\"}', '2026-06-11 17:57:38', '2026-05-22 14:17:30', '2026-05-22 14:17:30'),
('d82c99e4-7c3f-4cbb-9678-068d386a7811', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 12, '{\"type\":\"message\",\"icon\":\"message\",\"title\":\"Freelancer sent a message\",\"body\":\"Youness Ben Abbou sent you a message about the project timeline.\",\"action_url\":\"\\/messages\"}', NULL, '2026-06-11 18:07:15', '2026-06-11 18:07:15'),
('d9d62063-89f9-40a8-b43a-70488efefe7a', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 35, '{\"icon\":\"file\",\"action_url\":\"\\/jobs\\/19\\/proposals\",\"type\":\"proposal\",\"title\":\"New proposal received\",\"body\":\"A freelancer submitted a proposal for \\\"3erd job\\\".\"}', '2026-06-11 19:11:37', '2026-06-11 19:11:05', '2026-06-11 19:11:05'),
('db12b59d-48d0-4dab-975f-e35ce05d555e', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 38, '{\"type\":\"system\",\"icon\":\"bell\",\"title\":\"Profile viewed 12 times\",\"body\":\"Your profile was viewed 12 times this week. Consider updating your portfolio.\",\"action_url\":\"\\/freelancer\\/profile\"}', NULL, '2026-06-13 11:52:46', '2026-06-13 11:52:46'),
('f2db89ff-9c40-47dd-9688-0fa062b5f911', 'App\\Notifications\\PlatformNotification', 'App\\Models\\User', 19, '{\"type\":\"message\",\"icon\":\"message\",\"title\":\"New message from client\",\"body\":\"You have a new message regarding the React Native app project.\",\"action_url\":\"\\/messages\"}', NULL, '2026-05-22 15:00:25', '2026-05-22 15:00:25');

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('ayoubelmernissi55@gmail.com', '$2y$12$FDP68EtQUbam6BSSOm2KR.Q8ZXfv4lTDBuazaZ3GQtkZdE.lQwbI6', '2026-06-10 01:29:30');

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 18, 'auth_token', 'e0944c88c378e5daea63ef377c3de9c37ce79c899c91a018e12ebd2edc3447e4', '[\"*\"]', '2026-05-23 01:14:57', NULL, '2026-05-22 14:32:30', '2026-05-23 01:14:57'),
(2, 'App\\Models\\User', 19, 'auth_token', '381f7178fed320ccf52eb7b73bbd7ea299cb12ff5a4dfa987b42842876a70cfb', '[\"*\"]', '2026-05-22 16:03:27', NULL, '2026-05-22 15:30:24', '2026-05-22 16:03:27'),
(3, 'App\\Models\\User', 18, 'auth_token', 'ced16fca0e0d433c082b558441b694bf21f4217930a340cad36d00335416a70d', '[\"*\"]', NULL, NULL, '2026-05-25 12:30:28', '2026-05-25 12:30:28'),
(4, 'App\\Models\\User', 18, 'auth_token', '0bea8ece1b437d33e24decf7205a3829f669fd10d3d67fbc45d6916a69f553c4', '[\"*\"]', NULL, NULL, '2026-05-25 12:43:16', '2026-05-25 12:43:16'),
(5, 'App\\Models\\User', 20, 'auth_token', 'c038c2677b4cc69f3cbaf49fbeef97b6817b566bf8bc98b2c9a7d6da51d90196', '[\"*\"]', NULL, NULL, '2026-06-10 01:42:04', '2026-06-10 01:42:04'),
(6, 'App\\Models\\User', 21, 'auth_token', 'ed298062a2f03f04595d06e49857b8b1db58257afe005043d3f92c029c6f966e', '[\"*\"]', NULL, NULL, '2026-06-10 01:42:28', '2026-06-10 01:42:28'),
(7, 'App\\Models\\User', 23, 'auth_token', 'fa8f0db57c61393cf27949f3f30cb092e660ad703977652b47b41faa2a4e8d6f', '[\"*\"]', NULL, NULL, '2026-06-10 01:47:24', '2026-06-10 01:47:24'),
(8, 'App\\Models\\User', 24, 'auth_token', '5fff64e0eb3f3dc01fb52af2e672c55e0206a197887e485e14fc35391727c31d', '[\"*\"]', NULL, NULL, '2026-06-10 01:52:10', '2026-06-10 01:52:10'),
(9, 'App\\Models\\User', 25, 'auth_token', '4b79516205c96c917c0eec739633d70c98fa1ecf676488b9242fd286aaf63cab', '[\"*\"]', NULL, NULL, '2026-06-10 01:53:40', '2026-06-10 01:53:40'),
(10, 'App\\Models\\User', 26, 'auth_token', 'c2a25aa51ec0d45f94aa2229a49f328393f7c107015eab5beab2aae7a2449c0c', '[\"*\"]', NULL, NULL, '2026-06-10 01:57:06', '2026-06-10 01:57:06'),
(11, 'App\\Models\\User', 27, 'auth_token', '423dc03f76db7dc635e324d97cadd0186adac0d63c1c9c12a9ed0bee7383e4d1', '[\"*\"]', NULL, NULL, '2026-06-10 01:58:56', '2026-06-10 01:58:56'),
(15, 'App\\Models\\User', 31, 'auth_token', '8d43b790daa62b00614c1a320f219cc2599961179c146012a7490c88fc25241a', '[\"*\"]', NULL, NULL, '2026-06-10 02:25:13', '2026-06-10 02:25:13'),
(16, 'App\\Models\\User', 32, 'auth_token', 'c0079179c6cd2a3cb74f48fcf4790b2cb285f50721c7c4dc28bb1d1dc2cde16c', '[\"*\"]', NULL, NULL, '2026-06-10 02:32:20', '2026-06-10 02:32:20'),
(20, 'App\\Models\\User', 35, 'auth_token', '827c1e65b203aef6b1e27f5027c39b263094b88ca8fd263f7b2a8756537ec1c5', '[\"*\"]', '2026-06-13 12:16:30', NULL, '2026-06-10 18:13:39', '2026-06-13 12:16:30'),
(21, 'App\\Models\\User', 36, 'auth_token', '8b483ed005bc96ab0c080e8aa278a430f8263a35928ee721a27eb9ff4ab21f1e', '[\"*\"]', NULL, NULL, '2026-06-11 15:16:54', '2026-06-11 15:16:54'),
(22, 'App\\Models\\User', 37, 'auth_token', 'de9e479f9d80b89358e60711f77053dd065c7cfff0732dd336427e16792b59a4', '[\"*\"]', '2026-06-13 12:18:19', NULL, '2026-06-11 15:17:54', '2026-06-13 12:18:19'),
(23, 'App\\Models\\User', 18, 'auth_token', 'd0372bce78e774e18d284b2327b9cde6f37050db2e0ab01c43c1bf518a58f8f6', '[\"*\"]', '2026-06-11 18:03:26', NULL, '2026-06-11 17:57:26', '2026-06-11 18:03:26'),
(24, 'App\\Models\\User', 1, 'auth_token', '3cd9572ea97160aa51754751db7cfd2412df92ec31b51eee7ced005b0cbed8cc', '[\"*\"]', NULL, NULL, '2026-06-11 17:58:27', '2026-06-11 17:58:27'),
(25, 'App\\Models\\User', 1, 'auth_token', '7c9f5f2ae0ba76af5347bbeb72a64fe5b942a2289b3f0e4f04d19af986837f32', '[\"*\"]', NULL, NULL, '2026-06-11 17:58:44', '2026-06-11 17:58:44'),
(27, 'App\\Models\\User', 1, 'auth_token', '7169c1603ae387a35e6d2e39aeae688e6403aad8365028df981323fd9f3ca95a', '[\"*\"]', NULL, NULL, '2026-06-11 18:02:10', '2026-06-11 18:02:10'),
(28, 'App\\Models\\User', 34, 'auth_token', '2e50d7e7f4a21a1eb36f0f9beb0a63897d3f7e55ff506ccdafdf3c375ce4df5f', '[\"*\"]', '2026-06-12 14:47:37', NULL, '2026-06-11 18:03:35', '2026-06-12 14:47:37'),
(29, 'App\\Models\\User', 12, 'auth_token', '0d37fb27e93b059c8eb7bc5e2a6e385c3d6552af9f2a7fb46198418eabfde8e1', '[\"*\"]', NULL, NULL, '2026-06-11 18:37:15', '2026-06-11 18:37:15'),
(30, 'App\\Models\\User', 12, 'auth_token', '901c3805dc86524548dc939629861b4b1330ec68d1535ef9d0993ada187c0e23', '[\"*\"]', '2026-06-11 18:41:06', NULL, '2026-06-11 18:41:05', '2026-06-11 18:41:06'),
(31, 'App\\Models\\User', 12, 'auth_token', '43764732a8fdb1abf6f2d7121299ff48b572368db181478ead06636a4f2a456a', '[\"*\"]', '2026-06-11 18:52:38', NULL, '2026-06-11 18:52:34', '2026-06-11 18:52:38'),
(32, 'App\\Models\\User', 12, 'auth_token', '48d266f387d82a6e03082bf65a72417466a4899465a091938f91712cba2c1ccb', '[\"*\"]', NULL, NULL, '2026-06-11 18:53:00', '2026-06-11 18:53:00'),
(33, 'App\\Models\\User', 12, 'auth_token', '48858654008af7523f8681d4f3bcd1419b911226433ee3f5b3272c72172dabf8', '[\"*\"]', '2026-06-11 18:53:14', NULL, '2026-06-11 18:53:13', '2026-06-11 18:53:14'),
(34, 'App\\Models\\User', 12, 'auth_token', '3d49b2f70de0917b5410e0f0b126a1bb9f0b89ffb371a131d306097d0831dfc9', '[\"*\"]', '2026-06-11 19:00:43', NULL, '2026-06-11 18:58:34', '2026-06-11 19:00:43'),
(35, 'App\\Models\\User', 18, 'auth_token', 'e5038d83f1c125b5cbbb6d5f332f146f8a5be27ca1c28bc57419baaa7e20972b', '[\"*\"]', '2026-06-12 15:23:42', NULL, '2026-06-12 14:47:31', '2026-06-12 15:23:42'),
(37, 'App\\Models\\User', 1, 'auth_token', '656d4c6bd0aecc345f22628b92d2bc2e0c7386a7921fb97f134b16c4a52c029c', '[\"*\"]', '2026-06-12 15:28:03', NULL, '2026-06-12 15:27:17', '2026-06-12 15:28:03'),
(38, 'App\\Models\\User', 18, 'auth_token', 'f3aa64ed2213730c13a34d2ef337edbe4dd5a501e58ef317c4bdb0b8750c3745', '[\"*\"]', '2026-06-13 12:22:40', NULL, '2026-06-12 15:27:58', '2026-06-13 12:22:40'),
(39, 'App\\Models\\User', 18, 'auth_token', '9ef86b02ed023221731093ebc10fca625187f908f99100afdca7a87755340edb', '[\"*\"]', '2026-06-13 12:26:10', NULL, '2026-06-13 12:22:32', '2026-06-13 12:26:10'),
(40, 'App\\Models\\User', 18, 'auth_token', 'ad6bdb94025ffca7b4aba7eee7c6780a6ceec21784059c9702b29e842550a112', '[\"*\"]', '2026-06-13 12:30:46', NULL, '2026-06-13 12:26:03', '2026-06-13 12:30:46'),
(41, 'App\\Models\\User', 18, 'auth_token', '05383ebc6c62e306b6f2f3334536559e5f20f1bbdfb3e4ef3ef881faa7586cde', '[\"*\"]', '2026-06-13 12:36:37', NULL, '2026-06-13 12:30:38', '2026-06-13 12:36:37'),
(42, 'App\\Models\\User', 18, 'auth_token', '195e168eadcf4cdf66a87bcb5e7ca5674a38d9df777b4a1d6fe0d8f066ef9849', '[\"*\"]', '2026-06-13 12:39:36', NULL, '2026-06-13 12:36:29', '2026-06-13 12:39:36'),
(43, 'App\\Models\\User', 18, 'auth_token', 'd6aceb4e033c32d4b302433846afbf3a4cdd43bac7d6ce0b9c6112477d6da002', '[\"*\"]', '2026-06-13 12:43:20', NULL, '2026-06-13 12:39:29', '2026-06-13 12:43:20'),
(44, 'App\\Models\\User', 18, 'auth_token', '897fce32188d084205fb2b59d797f3aa819d63bc2d743d8af212ddd7170d18ee', '[\"*\"]', '2026-06-13 12:49:38', NULL, '2026-06-13 12:43:12', '2026-06-13 12:49:38'),
(45, 'App\\Models\\User', 18, 'auth_token', '2752082d97a34acfcfb4d9383fcbb7902e82cd63c0eab1f0f4228e8d23f5e1b3', '[\"*\"]', '2026-06-13 13:29:25', NULL, '2026-06-13 12:49:32', '2026-06-13 13:29:25'),
(46, 'App\\Models\\User', 38, 'auth_token', 'fd0e79a2566e34e51ec22daae4e392d9c668be5f0ec463302b7cc30b91f1cd39', '[\"*\"]', '2026-06-13 13:19:30', NULL, '2026-06-13 13:07:46', '2026-06-13 13:19:30'),
(47, 'App\\Models\\User', 18, 'auth_token', '2bd4a13ffa4ff8bdab44d893d8f2c0bfa6061a87653d7df802901fd64363d4f0', '[\"*\"]', NULL, NULL, '2026-06-13 13:19:25', '2026-06-13 13:19:25');

-- --------------------------------------------------------

--
-- Structure de la table `platform_settings`
--

CREATE TABLE `platform_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `group` varchar(255) NOT NULL DEFAULT 'general',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `platform_settings`
--

INSERT INTO `platform_settings` (`id`, `key`, `value`, `description`, `group`, `created_at`, `updated_at`) VALUES
(1, 'fee.freelancer_pct', '0.10', 'Service fee deducted from freelancer payouts (e.g. 0.10 = 10%)', 'fees', NULL, NULL),
(2, 'fee.client_pct', '0.05', 'Service fee charged to client on top of contract amount (e.g. 0.05 = 5%)', 'fees', NULL, NULL),
(3, 'fee.contract_init', '0.99', 'One-time contract initiation fee charged to client (USD flat)', 'fees', NULL, NULL),
(4, 'fee.withdrawal_flat', '2.00', 'Flat withdrawal fee to bank (USD)', 'fees', NULL, NULL),
(5, 'fee.deposit_pct', '0.029', 'Deposit processing fee (Stripe-style)', 'fees', NULL, NULL),
(6, 'fee.deposit_flat', '0.30', 'Deposit processing flat fee (USD)', 'fees', NULL, NULL),
(7, 'withdrawal.min', '20.00', 'Minimum withdrawal amount (USD)', 'withdrawals', NULL, NULL),
(8, 'withdrawal.requires_approval', '1', 'Whether admin approval is required for withdrawals (1=yes, 0=auto)', 'withdrawals', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `portfolios`
--

CREATE TABLE `portfolios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `project_url` varchar(255) DEFAULT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`skills`)),
  `completed_at` date DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `proposals`
--

CREATE TABLE `proposals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED NOT NULL,
  `freelancer_id` bigint(20) UNSIGNED NOT NULL,
  `cover_letter` text NOT NULL,
  `bid_amount` decimal(12,2) NOT NULL,
  `bid_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `estimated_duration` int(11) DEFAULT NULL,
  `duration_unit` varchar(255) NOT NULL DEFAULT 'days',
  `milestones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`milestones`)),
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `status` enum('pending','shortlisted','accepted','rejected','withdrawn') NOT NULL DEFAULT 'pending',
  `is_ai_generated` tinyint(1) NOT NULL DEFAULT 0,
  `connects_used` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `proposals`
--

INSERT INTO `proposals` (`id`, `job_id`, `freelancer_id`, `cover_letter`, `bid_amount`, `bid_type`, `estimated_duration`, `duration_unit`, `milestones`, `attachments`, `status`, `is_ai_generated`, `connects_used`, `created_at`, `updated_at`) VALUES
(1, 1, 18, 'Dear Hiring Manager,\n\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\n\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\n\nI look forward to discussing how I can contribute to your project\'s success.\n\nBest regards', 200.00, 'fixed', 10, 'days', NULL, NULL, 'pending', 0, 2, '2026-05-22 14:34:13', '2026-05-22 14:34:13'),
(2, 16, 34, 'Dear Hiring Manager,\n\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\n\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\n\nI look forward to discussing how I can contribute to your project\'s success.\n\nBest regards', 13.00, 'fixed', 15, 'days', NULL, NULL, 'accepted', 0, 2, '2026-06-10 18:16:39', '2026-06-11 01:34:50'),
(3, 17, 34, 'Dear Hiring Manager,\n\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\n\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\n\nI look forward to discussing how I can contribute to your project\'s success.\n\nBest regards', 14.00, 'fixed', 1, 'days', NULL, NULL, 'accepted', 0, 2, '2026-06-11 15:23:33', '2026-06-11 15:24:38'),
(4, 19, 34, 'Dear Hiring Manager,\n\nI am excited to apply for this position. With my extensive experience in the field, I am confident I can deliver exceptional results that exceed your expectations.\n\nI have carefully reviewed your requirements and I believe my skills align perfectly with what you\'re looking for. I am committed to delivering high-quality work on time and within budget.\n\nI look forward to discussing how I can contribute to your project\'s success.\n\nBest regards', 11.00, 'fixed', 1, 'days', NULL, NULL, 'accepted', 0, 2, '2026-06-11 19:11:05', '2026-06-11 19:11:45');

-- --------------------------------------------------------

--
-- Structure de la table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `endpoint` varchar(1024) NOT NULL,
  `p256dh` varchar(255) NOT NULL,
  `auth` varchar(255) NOT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewer_id` bigint(20) UNSIGNED NOT NULL,
  `reviewee_id` bigint(20) UNSIGNED NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `comment` text DEFAULT NULL,
  `breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`breakdown`)),
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `reviews`
--

INSERT INTO `reviews` (`id`, `contract_id`, `reviewer_id`, `reviewee_id`, `rating`, `comment`, `breakdown`, `is_public`, `created_at`, `updated_at`) VALUES
(1, NULL, 35, 34, 5.00, NULL, NULL, 1, '2026-06-11 01:37:22', '2026-06-11 01:37:22');

-- --------------------------------------------------------

--
-- Structure de la table `saved_catalog_projects`
--

CREATE TABLE `saved_catalog_projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `catalog_project_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `saved_freelancers`
--

CREATE TABLE `saved_freelancers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `freelancer_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `saved_jobs`
--

CREATE TABLE `saved_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `saved_jobs`
--

INSERT INTO `saved_jobs` (`id`, `user_id`, `job_id`, `created_at`, `updated_at`) VALUES
(1, 34, 16, '2026-06-11 01:26:58', '2026-06-11 01:26:58');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('43GIT0FMkeiuvngckBroK3mxkyYMcmV468mzBZRP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWtCZDg4ajRraE42emRLVVZBVHN3NVJSVTBCeU83YWZzTUpCM2xjeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2dvb2dsZSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1781356922),
('5e6VswHnKQcHz1OUm2ijVsAJtTNVzCIsX3FgRgOC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjhUZzNuSXdYSTUzQmRYSFVGUVh3UVpLMlZWZndEYVowbTBYcHlqdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2dvb2dsZSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1781359655),
('827VpEFmYN62CZuMeDGEvLHAaRFPCPBP9TzzSO3P', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjdPd250Q3A0ekVhUEJ6V2FNM2RxVXQzMFRYdHl5aWZxRTcwT3RDbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM4OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXV0aC9nb29nbGUvY2FsbGJhY2s/YXV0aHVzZXI9MSZjb2RlPTQlMkYwQWRrVkxQeVdFYlV2TzI4YUQ1NG1uc2pkUDlWMFdLUE9VSkNYakhNTDh1cW9EVENqdDI4VmYwZl9xSXdMODlyUzRwck90dyZpc3M9aHR0cHMlM0ElMkYlMkZhY2NvdW50cy5nb29nbGUuY29tJnByb21wdD1jb25zZW50JnNjb3BlPWVtYWlsJTIwcHJvZmlsZSUyMGh0dHBzJTNBJTJGJTJGd3d3Lmdvb2dsZWFwaXMuY29tJTJGYXV0aCUyRnVzZXJpbmZvLnByb2ZpbGUlMjBodHRwcyUzQSUyRiUyRnd3dy5nb29nbGVhcGlzLmNvbSUyRmF1dGglMkZ1c2VyaW5mby5lbWFpbCUyMG9wZW5pZCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1781360365),
('uWxU5OYJu4zPmyQKGNVxngTH77OHlpADPQrz1wNG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibHVPemFjNzNpeDY3NWxyRUtqNEp2RGg2QXpEVFNzdk1JRjVUeFRsNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2dvb2dsZSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1781356920);

-- --------------------------------------------------------

--
-- Structure de la table `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `skills`
--

INSERT INTO `skills` (`id`, `name`, `slug`, `category_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PHP', 'php', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(2, 'Laravel', 'laravel', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(3, 'React', 'react', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(4, 'Vue.js', 'vuejs', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(5, 'Node.js', 'nodejs', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(6, 'Python', 'python', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(7, 'JavaScript', 'javascript', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(8, 'TypeScript', 'typescript', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(9, 'MySQL', 'mysql', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(10, 'PostgreSQL', 'postgresql', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(11, 'Docker', 'docker', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(12, 'AWS', 'aws', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(13, 'Figma', 'figma', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(14, 'UI Design', 'ui-design', 1, 1, '2026-05-22 14:21:54', '2026-05-22 14:21:54'),
(15, 'UX Design', 'ux-design', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(16, 'Branding', 'branding', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(17, 'Machine Learning', 'machine-learning', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(18, 'TensorFlow', 'tensorflow', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(19, 'NLP', 'nlp', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(20, 'Data Science', 'data-science', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(21, 'React Native', 'react-native', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(22, 'Flutter', 'flutter', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(23, 'GraphQL', 'graphql', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(24, 'Redis', 'redis', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(25, 'Kubernetes', 'kubernetes', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(26, 'Go', 'go', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(27, 'Rust', 'rust', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(28, 'Swift', 'swift', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(29, 'Kotlin', 'kotlin', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(30, 'Unity', 'unity', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(31, 'SEO', 'seo', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(32, 'Content Writing', 'content-writing', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(33, 'Copywriting', 'copywriting', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(34, 'Email Marketing', 'email-marketing', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(35, 'Google Ads', 'google-ads', 1, 1, '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(36, 'jhb', 'jhb', NULL, 1, '2026-05-22 15:30:51', '2026-05-22 15:30:51'),
(37, 'Microsoft Excel', 'microsoft-excel', NULL, 1, '2026-06-11 18:05:33', '2026-06-11 18:05:33');

-- --------------------------------------------------------

--
-- Structure de la table `stripe_webhook_events`
--

CREATE TABLE `stripe_webhook_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stripe_event_id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`payload`)),
  `status` enum('received','processed','failed','ignored') NOT NULL DEFAULT 'received',
  `processing_error` varchar(255) DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_status` varchar(255) NOT NULL,
  `stripe_price` varchar(255) DEFAULT NULL,
  `plan_slug` varchar(255) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subscription_items`
--

CREATE TABLE `subscription_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_product` varchar(255) NOT NULL,
  `stripe_price` varchar(255) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `talent_lists`
--

CREATE TABLE `talent_lists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `talent_list_freelancers`
--

CREATE TABLE `talent_list_freelancers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `talent_list_id` bigint(20) UNSIGNED NOT NULL,
  `freelancer_id` bigint(20) UNSIGNED NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tax_documents`
--

CREATE TABLE `tax_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `form_type` enum('w9','w8ben','vat') NOT NULL,
  `country` varchar(2) NOT NULL,
  `legal_name` varchar(255) NOT NULL,
  `tax_id_last4` varchar(8) DEFAULT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state_region` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) NOT NULL,
  `form_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`form_payload`)),
  `signed_pdf_path` varchar(255) DEFAULT NULL,
  `status` enum('draft','submitted','approved','rejected') NOT NULL DEFAULT 'submitted',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `time_logs`
--

CREATE TABLE `time_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL,
  `duration_seconds` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `description` varchar(500) DEFAULT NULL,
  `screenshot_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `time_logs`
--

INSERT INTO `time_logs` (`id`, `contract_id`, `user_id`, `started_at`, `ended_at`, `duration_seconds`, `description`, `screenshot_url`, `created_at`, `updated_at`) VALUES
(1, 1, 34, '2026-06-11 02:56:10', '2026-06-11 01:56:10', 1047, NULL, NULL, '2026-06-11 01:38:43', '2026-06-11 01:56:10'),
(2, 2, 34, '2026-06-11 19:56:19', '2026-06-11 18:56:19', 12631, NULL, NULL, '2026-06-11 15:25:48', '2026-06-11 18:56:19');

-- --------------------------------------------------------

--
-- Structure de la table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `counterparty_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contract_id` bigint(20) UNSIGNED DEFAULT NULL,
  `milestone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `withdrawal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `idempotency_key` varchar(255) DEFAULT NULL,
  `type` enum('credit','debit','escrow','release','refund','withdrawal','fee') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `direction` enum('in','out') NOT NULL DEFAULT 'in',
  `fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `balance_after` decimal(12,2) DEFAULT NULL,
  `currency` varchar(255) NOT NULL DEFAULT 'USD',
  `status` enum('pending','completed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `description` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `payment_method` varchar(255) DEFAULT NULL,
  `stripe_payment_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `transactions`
--

INSERT INTO `transactions` (`id`, `wallet_id`, `user_id`, `counterparty_user_id`, `contract_id`, `milestone_id`, `withdrawal_id`, `reference`, `idempotency_key`, `type`, `amount`, `direction`, `fee`, `balance_after`, `currency`, `status`, `description`, `metadata`, `payment_method`, `stripe_payment_id`, `created_at`, `updated_at`) VALUES
(1, 37, 37, NULL, NULL, NULL, NULL, 'DEP-URMSS5IY1PDU', NULL, 'credit', 50.00, 'in', 0.00, 50.00, 'USD', 'completed', 'Wallet deposit', '{\"description\":\"Wallet deposit\"}', NULL, NULL, '2026-06-11 15:18:19', '2026-06-11 15:18:19'),
(2, 37, 37, 34, 2, NULL, NULL, 'ESC-T5KG6BR491PW', NULL, 'escrow', 14.00, 'out', 0.00, 36.00, 'USD', 'completed', 'Escrow funded for contract: TOW', NULL, NULL, NULL, '2026-06-11 15:27:46', '2026-06-11 15:27:46');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('freelancer','client','admin') NOT NULL DEFAULT 'freelancer',
  `name` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `phone_verified` tinyint(1) NOT NULL DEFAULT 0,
  `connects_balance` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_platform` tinyint(1) NOT NULL DEFAULT 0,
  `is_online` tinyint(1) NOT NULL DEFAULT 0,
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `stripe_customer_id` varchar(255) DEFAULT NULL,
  `stripe_account_id` varchar(255) DEFAULT NULL,
  `stripe_account_status` enum('none','pending','restricted','active','disabled') NOT NULL DEFAULT 'none',
  `stripe_charges_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_payouts_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_onboarded_at` timestamp NULL DEFAULT NULL,
  `github_id` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `users`
--

INSERT INTO `users` (`id`, `role`, `name`, `username`, `email`, `avatar`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`, `country`, `timezone`, `phone`, `phone_verified`, `connects_balance`, `is_verified`, `is_active`, `is_platform`, `is_online`, `last_seen_at`, `google_id`, `stripe_customer_id`, `stripe_account_id`, `stripe_account_status`, `stripe_charges_enabled`, `stripe_payouts_enabled`, `stripe_onboarded_at`, `github_id`, `deleted_at`) VALUES
(1, 'admin', 'Admin Panda', 'admin', 'admin@panda.io', 'https://randomuser.me/api/portraits/men/0.jpg', NULL, '$2y$12$vjUFXB/2KsGXA6i7Wb2UX.IphCAXf2fDf8tMvoiNOpYF2SnqDhTKW', NULL, NULL, NULL, NULL, '2026-05-22 14:21:55', '2026-06-12 15:27:17', NULL, NULL, NULL, 0, 9999, 1, 1, 0, 1, '2026-06-12 15:27:17', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(2, 'freelancer', 'Alex Johnson', 'alex_johnson', 'alex@freenest.io', 'https://randomuser.me/api/portraits/men/11.jpg', NULL, '$2y$12$dYbati90Oc7t6nJCV96Xtu41aG6/6WGw8FMsJAXhPmO2Yssz71fxC', NULL, NULL, NULL, NULL, '2026-05-22 14:21:55', '2026-05-22 14:21:55', 'US', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(3, 'freelancer', 'Sofia Martinez', 'sofia_design', 'sofia@freenest.io', 'https://randomuser.me/api/portraits/women/21.jpg', NULL, '$2y$12$MbF4lIoHew8ex22EaIZjpeHz..PWne901B.jkTDaXpLou56/WCygW', NULL, NULL, NULL, NULL, '2026-05-22 14:21:56', '2026-05-22 14:21:56', 'ES', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(4, 'freelancer', 'Karim Tahiri', 'karim_ai', 'karim@freenest.io', 'https://randomuser.me/api/portraits/men/32.jpg', NULL, '$2y$12$ABCdYVtxzgJVj5QqVe3fnONNHwgTEg3jaquuFGlJxWUJRHkmuuSyG', NULL, NULL, NULL, NULL, '2026-05-22 14:21:56', '2026-05-22 14:21:56', 'MA', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(5, 'freelancer', 'Lena Fischer', 'lena_dev', 'lena@freenest.io', 'https://randomuser.me/api/portraits/women/44.jpg', NULL, '$2y$12$WailJW0HbHXI0ZVrTTtVWeSXtp6M9ZNSYCQibzz.pxWDY4K8AZcFu', NULL, NULL, NULL, NULL, '2026-05-22 14:21:57', '2026-05-22 14:21:57', 'DE', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(6, 'freelancer', 'James Okafor', 'james_mobile', 'james@freenest.io', 'https://randomuser.me/api/portraits/men/55.jpg', NULL, '$2y$12$8ZOXZT/Hv8BrpLESoH.cXujp1KahzCwrzn7izRtB7ROgLbMl4gBJe', NULL, NULL, NULL, NULL, '2026-05-22 14:21:57', '2026-05-22 14:21:57', 'NG', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(7, 'freelancer', 'Amira Hassan', 'amira_write', 'amira@freenest.io', 'https://randomuser.me/api/portraits/women/62.jpg', NULL, '$2y$12$m0v24w4I0DDkU3HEQaq03ufnpK6SAvRkO88VEK8uw.LI3s.jzHQnO', NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', 'EG', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(8, 'freelancer', 'Lucas Dupont', 'lucas_vue', 'lucas@freenest.io', 'https://randomuser.me/api/portraits/men/73.jpg', NULL, '$2y$12$u631RUXPC3bjQU.VoDgktui.lBo2hHHL1S38eDwzJwAOZLIRFGyRK', NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', 'FR', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(9, 'freelancer', 'Priya Sharma', 'priya_ds', 'priya@freenest.io', 'https://randomuser.me/api/portraits/women/83.jpg', NULL, '$2y$12$8PsFLSg6p5Kfjlb.jHWQHuNX4acRMXOQPRHuK3AoV.SrlArYzXG9u', NULL, NULL, NULL, NULL, '2026-05-22 14:21:58', '2026-05-22 14:21:58', 'IN', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(10, 'freelancer', 'Omar Benali', 'omar_go', 'omar@freenest.io', 'https://randomuser.me/api/portraits/men/87.jpg', NULL, '$2y$12$kasuBrwHvN8qd.SIqsjTcOf28xZ1OlCjQxOvLuVsRRwjPVRlGW.vO', NULL, NULL, NULL, NULL, '2026-05-22 14:21:59', '2026-05-22 14:21:59', 'DZ', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(11, 'freelancer', 'Emma Wilson', 'emma_marketing', 'emma@freenest.io', 'https://randomuser.me/api/portraits/women/90.jpg', NULL, '$2y$12$edcjIVYHSL95VuBtMmlk8uHZaG2KSuLqCPil1PxEGeDoeV.kI1xcu', NULL, NULL, NULL, NULL, '2026-05-22 14:21:59', '2026-05-22 14:21:59', 'GB', NULL, NULL, 0, 80, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(12, 'client', 'Nathan Rivera', 'nathan_tech', 'client1@freenest.io', 'https://randomuser.me/api/portraits/men/15.jpg', NULL, '$2y$12$sh/c7L0lOAegF0ZYpmmaNumTKh2fkkoCv.0baskwlB6DrKGMieU/u', NULL, NULL, NULL, NULL, '2026-05-22 14:22:00', '2026-06-11 18:58:34', 'US', NULL, NULL, 0, 0, 1, 1, 0, 1, '2026-06-11 18:58:34', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(13, 'client', 'Claire Dubois', 'claire_startup', 'client2@freenest.io', 'https://randomuser.me/api/portraits/women/28.jpg', NULL, '$2y$12$ley2xIAjYQAPpVXI/F0ibOdfpylsnM7pKDLUubx/t58Aal7emnAfu', NULL, NULL, NULL, NULL, '2026-05-22 14:22:00', '2026-05-22 14:22:00', 'FR', NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(14, 'client', 'Mohammed Al-Rashid', 'mohammed_biz', 'client3@freenest.io', 'https://randomuser.me/api/portraits/men/38.jpg', NULL, '$2y$12$Saj4Z9smNlLwla627bLvT.6PP5/ncICGwF29bl/hvCTHjglwR3gDC', NULL, NULL, NULL, NULL, '2026-05-22 14:22:00', '2026-05-22 14:22:00', 'AE', NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(15, 'client', 'Yuki Tanaka', 'yuki_games', 'client4@freenest.io', 'https://randomuser.me/api/portraits/women/47.jpg', NULL, '$2y$12$RSs484UGBhtFS3UZULC8p.J9ty/h7xMtVfPNT00Md28gZcsb2rVtm', NULL, NULL, NULL, NULL, '2026-05-22 14:22:01', '2026-05-22 14:22:01', 'JP', NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(16, 'client', 'David Osei', 'david_health', 'client5@freenest.io', 'https://randomuser.me/api/portraits/men/58.jpg', NULL, '$2y$12$3z4h0rPMTP/HcNPrRuib/.N9wZG2tG/7IOme.CEBzo2kfYdjrwEzW', NULL, NULL, NULL, NULL, '2026-05-22 14:22:01', '2026-05-22 14:22:01', 'GH', NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(17, 'client', 'Isabella Conti', 'isabella_ecom', 'client6@freenest.io', 'https://randomuser.me/api/portraits/women/67.jpg', NULL, '$2y$12$ob4JIYAuIAgHrtB4Oqm2w.GKxYPXErLXZ.t9qg7b9mIrA70wwQb/m', NULL, NULL, NULL, NULL, '2026-05-22 14:22:02', '2026-05-22 14:22:02', 'IT', NULL, NULL, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(18, 'freelancer', 'FASKO', 'fasko', 'fasko975@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIRhR91nK3EX4ln1RkNKefD4p4dZOHpU1Tu5jwuspyP9QKHhg=s200-c', NULL, '$2y$12$3xtKkj2uaXjyTDjD5bhXDe3N034CEIklNCBBzU8oLFJ3wAdGfbRUW', NULL, NULL, NULL, NULL, '2026-05-22 14:32:30', '2026-06-13 13:19:24', NULL, NULL, NULL, 0, 10, 0, 1, 0, 1, '2026-06-13 13:19:24', '110051133158336634156', NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(19, 'freelancer', 'AYOUB yt', 'ayoub_yt', 'ayoubelmernissi55@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLvc7JJgo10elT8_SmkL55NWKS92Rl-zidUR05RyxKpSH4qeg=s200-c', NULL, '$2y$12$MqriLuRYq72DvCwBNtwsVuiy5uIrqXc9H5VNC.rlQU6UJFFJ8izJ2', NULL, NULL, NULL, NULL, '2026-05-22 15:30:24', '2026-05-22 15:30:24', NULL, NULL, NULL, 0, 10, 0, 1, 0, 1, '2026-05-22 15:30:24', '108303915853853308281', NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(20, 'freelancer', 'jllbjk', 'jllbjk', 'alex@gmail.io', 'avatars/b1ba1e35-6484-47a8-9101-5839ddac1321.png', '2026-06-10 01:42:03', '$2y$12$7n4BdDLY7ixHegsmpphpAOnB.SPdnRGFX3eQWDq7kZhoBEcNuMfLm', NULL, NULL, NULL, NULL, '2026-06-10 01:42:03', '2026-06-10 01:42:03', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(21, 'freelancer', 'jllbjk', 'jllbjk_1', 'alex@gmail.com', 'avatars/8049964d-faa2-4fb3-be22-02be4100d929.png', '2026-06-10 01:42:28', '$2y$12$u7yDxLjzphf1nnzqrS.Z3uTrs/13GbDCTDBEDCNzNA.tIcR0GVUxG', NULL, NULL, NULL, NULL, '2026-06-10 01:42:28', '2026-06-10 01:42:28', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(23, 'freelancer', 'HBHJ', 'hbhj', 'AYOUB@GMAIL.COM', 'avatars/d2b386e5-216f-4cf8-b5b4-3fc59d1131ba.png', '2026-06-10 01:47:24', '$2y$12$LIT1wM.JeiQh6BbDp96x/.L9UFvVEJLlgDHStcK3urJG5yGLJxQre', NULL, NULL, NULL, NULL, '2026-06-10 01:47:24', '2026-06-10 01:47:24', 'Albania', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(24, 'client', 'Test New User', 'test_new_user', 'newuser_test_xyz@gmail.com', NULL, '2026-06-10 01:52:10', '$2y$12$66MAQAWAy0uQGYvus.R1EeRN8r4EoNKoeCH8qvhGi/NomL.R5wQ2y', NULL, NULL, NULL, NULL, '2026-06-10 01:52:10', '2026-06-10 01:52:10', 'Morocco', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(25, 'freelancer', 'John Test', 'john_test', 'johntest_fresh@gmail.com', NULL, '2026-06-10 01:53:40', '$2y$12$fRfTQ7wZN/0NGnYf//xyNuSXmsUw803jlIOmIyGNsx7yyBJ0sFE.u', NULL, NULL, NULL, NULL, '2026-06-10 01:53:40', '2026-06-10 01:53:40', 'Morocco', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(26, 'freelancer', 'AYOUB', 'ayoub', 'ayoiub@gmail.com', 'avatars/d0ccdb4f-83a3-44e0-9bc9-6488ece11d21.jpg', '2026-06-10 01:57:06', '$2y$12$YgSc/busk2tk.p7Zr/1pnuDU4t8.oW4DzVF81FkXbJpCQ5/ZLPxyu', NULL, NULL, NULL, NULL, '2026-06-10 01:57:06', '2026-06-10 01:57:06', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(27, 'freelancer', 'Fresh User', 'fresh_user', 'freshuser2026@gmail.com', NULL, '2026-06-10 01:58:56', '$2y$12$AXIGJk2.xm8R07v7YABLBOycwEKaiggdUHZqrJKjV07oCaVl.eIRm', NULL, NULL, NULL, NULL, '2026-06-10 01:58:56', '2026-06-10 01:58:56', 'Morocco', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(28, 'freelancer', 'ALN', 'aln', 'eln@gmail.com', NULL, '2026-06-10 02:02:42', '$2y$12$iAd5.CvweQRoteSIALYsWu3lMxcxGT5NAWEI1DX.PGzVUuufarvQ2', NULL, NULL, NULL, NULL, '2026-06-10 02:02:42', '2026-06-10 02:07:19', 'Afghanistan', NULL, 'iiii', 0, 10, 0, 1, 0, 0, '2026-06-10 02:07:19', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(29, 'freelancer', 'hbxzjh', 'hbxzjh', 'ayoubr@g.ccom', NULL, '2026-06-10 02:11:32', '$2y$12$C6KINO1YV978cXSFwQsvFOPjVfBm9Teivx6DlwSzQ7tr5qhcIyP3O', NULL, NULL, NULL, NULL, '2026-06-10 02:11:32', '2026-06-10 02:23:09', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, '2026-06-10 02:23:09', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(30, 'freelancer', 'martn', 'martn', 'mart@gmail.com', NULL, '2026-06-10 02:23:48', '$2y$12$dAUnNOtEj1xpCz/7IvjQUemSjeqeMUEFfWQaCXswLnpM69rPXwrl6', NULL, NULL, NULL, NULL, '2026-06-10 02:23:48', '2026-06-10 02:24:38', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, '2026-06-10 02:24:38', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(31, 'freelancer', 'erf', 'erf', 'erif@gmail.com', 'avatars/e07602e1-2b31-4eb8-8473-f74fa4fe8479.jpg', '2026-06-10 02:25:13', '$2y$12$cVBYyua.mlmqj6j/68dN/uy7mU0GsGuSuytYh.9Lb1U7oGS1hQRRu', NULL, NULL, NULL, NULL, '2026-06-10 02:25:13', '2026-06-10 02:25:13', 'Albania', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(32, 'freelancer', 'hcsz', 'hcsz', 'xhz@u.com', 'avatars/8b4a7c11-a9ad-4884-8fa9-9bed0e609fca.jpg', '2026-06-10 02:32:20', '$2y$12$ai9vM5BxW/FtuKQYqdNVxOGBcorIfqddKB7BRsSSGcIkF3W3FeOOe', NULL, NULL, NULL, NULL, '2026-06-10 02:32:20', '2026-06-10 02:32:20', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(33, 'freelancer', 'hcsz', 'hcsz_1', 'xhzh@u.com', 'avatars/40bb19f0-289b-4a61-87e8-011ce9a71134.jpg', '2026-06-10 02:33:07', '$2y$12$erDtwyBvby72AjYmj3t/DuV88nGUDlTVeBofMsuSbOz4DEZQ38eyq', NULL, NULL, NULL, NULL, '2026-06-10 02:33:07', '2026-06-10 02:33:44', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, '2026-06-10 02:33:44', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(34, 'freelancer', 'FASKO', 'fasko_1', 'fasko75@gmail.com', 'avatars/8a8226b5-e71d-4d6d-92d1-b03977e1b5b2.jpg', '2026-06-10 18:12:04', '$2y$12$zr2fcjXNFd6OcoAXJu.wIOXJeirFuuVIatSTJV6rSOdq6Bd1BDBrm', NULL, NULL, NULL, NULL, '2026-06-10 18:12:04', '2026-06-11 20:32:39', 'United Kingdom', NULL, '+212 7018927988', 0, 4, 0, 1, 0, 1, '2026-06-11 18:03:35', NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(35, 'client', 'AYOUB yt', 'ayoub_yt_1', 'ayoubelmernissi355@gmail.com', NULL, '2026-06-10 18:13:39', '$2y$12$D5gqzXfvefVJlsHEym44KOFUJeXUkMl0qLLozimSX34qGnanDo1ZK', NULL, NULL, NULL, NULL, '2026-06-10 18:13:39', '2026-06-10 18:13:39', 'Albania', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(36, 'client', 'Ayoub', 'ayoub_1', 'ayoubelvarto1@gmail.com', 'avatars/64fdf9b6-bdca-464c-8aed-5d859ca34085.jpg', '2026-06-11 15:16:54', '$2y$12$2Tk5n/vxgT43ZuYT8c8CW.fRkeiXIQR.YF4cG3l1iAkA.a3qJWjvK', NULL, NULL, NULL, NULL, '2026-06-11 15:16:54', '2026-06-11 15:16:54', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(37, 'client', 'Ayoub', 'ayoub_2', 'ayoubelvarto13@gmail.com', 'avatars/dc0beeba-5616-40b5-a512-d23c3db1107c.jpg', '2026-06-11 15:17:54', '$2y$12$mkbm/PDdQrqVz.HG3p1Lg.T3wG8bhLK8KR6LygSwo7TOAezo2roje', NULL, NULL, NULL, NULL, '2026-06-11 15:17:54', '2026-06-11 15:17:54', 'Afghanistan', NULL, NULL, 0, 10, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 'none', 0, 0, NULL, NULL, NULL),
(38, 'freelancer', 'FASKO NOKRO', 'fasko_nokro', 'faskonokro@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIyrSVL4MqrvmyJfEW8mTAtPiTxoQrH0UN_9VqN1qTmByGLDg=s200-c', '2026-06-13 13:01:07', '$2y$12$Y4ynm4qaVG76ZKVHAT1gp./MxCfMaaQb1YM6r/dOLljoGJ7HWQPRa', NULL, NULL, NULL, NULL, '2026-06-13 13:01:07', '2026-06-13 13:07:46', NULL, NULL, NULL, 0, 10, 0, 1, 0, 1, '2026-06-13 13:07:46', '104154372294943509534', NULL, NULL, 'none', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `pending_balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `escrow_balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(255) NOT NULL DEFAULT 'USD',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- DÃƒÂ©chargement des donnÃƒÂ©es de la table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `balance`, `pending_balance`, `escrow_balance`, `currency`, `created_at`, `updated_at`) VALUES
(1, 1, 0.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:55', '2026-05-22 14:21:55'),
(2, 2, 9860.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(3, 3, 5720.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(4, 4, 4860.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:56', '2026-05-22 14:21:56'),
(5, 5, 5760.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(6, 6, 3480.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:57', '2026-05-22 14:21:57'),
(7, 7, 5490.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(8, 8, 4620.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(9, 9, 4510.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:58', '2026-05-22 14:21:58'),
(10, 10, 3610.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(11, 11, 5200.00, 0.00, 0.00, 'USD', '2026-05-22 14:21:59', '2026-05-22 14:21:59'),
(12, 12, 12000.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:00', '2026-05-22 14:22:00'),
(13, 13, 7500.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:00', '2026-05-22 14:22:00'),
(14, 14, 25000.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(15, 15, 15000.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(16, 16, 5000.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:01', '2026-05-22 14:22:01'),
(17, 17, 9000.00, 0.00, 0.00, 'USD', '2026-05-22 14:22:02', '2026-05-22 14:22:02'),
(18, 18, 0.00, 0.00, 0.00, 'USD', '2026-05-22 14:32:30', '2026-05-22 14:32:30'),
(19, 19, 0.00, 0.00, 0.00, 'USD', '2026-05-22 15:30:24', '2026-05-22 15:30:24'),
(20, 20, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:42:03', '2026-06-10 01:42:03'),
(21, 21, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:42:28', '2026-06-10 01:42:28'),
(23, 23, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:47:24', '2026-06-10 01:47:24'),
(24, 24, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:52:10', '2026-06-10 01:52:10'),
(25, 25, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:53:40', '2026-06-10 01:53:40'),
(26, 26, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:57:06', '2026-06-10 01:57:06'),
(27, 27, 0.00, 0.00, 0.00, 'USD', '2026-06-10 01:58:56', '2026-06-10 01:58:56'),
(28, 28, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:02:42', '2026-06-10 02:02:42'),
(29, 29, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:11:32', '2026-06-10 02:11:32'),
(30, 30, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:23:48', '2026-06-10 02:23:48'),
(31, 31, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:25:13', '2026-06-10 02:25:13'),
(32, 32, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:32:20', '2026-06-10 02:32:20'),
(33, 33, 0.00, 0.00, 0.00, 'USD', '2026-06-10 02:33:07', '2026-06-10 02:33:07'),
(34, 34, 0.00, 0.00, 0.00, 'USD', '2026-06-10 18:12:04', '2026-06-10 18:12:04'),
(35, 35, 0.00, 0.00, 0.00, 'USD', '2026-06-10 18:13:39', '2026-06-10 18:13:39'),
(36, 36, 0.00, 0.00, 0.00, 'USD', '2026-06-11 15:16:54', '2026-06-11 15:16:54'),
(37, 37, 36.00, 0.00, 14.00, 'USD', '2026-06-11 15:17:54', '2026-06-11 15:27:46'),
(38, 38, 0.00, 0.00, 0.00, 'USD', '2026-06-13 13:01:07', '2026-06-13 13:01:07');

-- --------------------------------------------------------

--
-- Structure de la table `weekly_invoices`
--

CREATE TABLE `weekly_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contract_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `freelancer_id` bigint(20) UNSIGNED NOT NULL,
  `week_start` date NOT NULL,
  `week_end` date NOT NULL,
  `seconds_worked` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `hours_worked` decimal(8,2) NOT NULL DEFAULT 0.00,
  `hourly_rate` decimal(10,2) NOT NULL,
  `gross_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `commission` decimal(12,2) NOT NULL DEFAULT 0.00,
  `net_to_freelancer` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','paid','failed','cancelled') NOT NULL DEFAULT 'pending',
  `failure_reason` text DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `idempotency_key` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `fee` decimal(12,2) NOT NULL DEFAULT 0.00,
  `net` decimal(12,2) NOT NULL,
  `currency` varchar(8) NOT NULL DEFAULT 'USD',
  `method` enum('bank','paypal','wise','stripe','crypto') NOT NULL DEFAULT 'bank',
  `payout_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payout_details`)),
  `status` enum('pending','approved','rejected','processing','completed','failed') NOT NULL DEFAULT 'pending',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` varchar(255) DEFAULT NULL,
  `external_ref` varchar(255) DEFAULT NULL,
  `stripe_transfer_id` varchar(255) DEFAULT NULL,
  `stripe_payout_id` varchar(255) DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables dÃƒÂ©chargÃƒÂ©es
--

--
-- Index pour la table `agencies`
--
ALTER TABLE `agencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `agencies_slug_unique` (`slug`),
  ADD KEY `agencies_owner_id_foreign` (`owner_id`);

--
-- Index pour la table `agency_invitations`
--
ALTER TABLE `agency_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `agency_invitations_token_unique` (`token`),
  ADD KEY `agency_invitations_invited_by_foreign` (`invited_by`),
  ADD KEY `agency_invitations_agency_id_status_index` (`agency_id`,`status`),
  ADD KEY `agency_invitations_email_index` (`email`);

--
-- Index pour la table `agency_members`
--
ALTER TABLE `agency_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `agency_members_agency_id_user_id_unique` (`agency_id`,`user_id`),
  ADD KEY `agency_members_user_id_role_index` (`user_id`,`role`);

--
-- Index pour la table `ai_histories`
--
ALTER TABLE `ai_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_histories_user_id_foreign` (`user_id`);

--
-- Index pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_target_type_target_id_index` (`target_type`,`target_id`),
  ADD KEY `audit_logs_actor_id_created_at_index` (`actor_id`,`created_at`),
  ADD KEY `audit_logs_action_index` (`action`);

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Index pour la table `catalog_orders`
--
ALTER TABLE `catalog_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catalog_orders_stripe_session_id_unique` (`stripe_session_id`),
  ADD KEY `catalog_orders_catalog_project_id_foreign` (`catalog_project_id`),
  ADD KEY `catalog_orders_contract_id_foreign` (`contract_id`),
  ADD KEY `catalog_orders_conversation_id_foreign` (`conversation_id`),
  ADD KEY `catalog_orders_buyer_id_status_index` (`buyer_id`,`status`),
  ADD KEY `catalog_orders_seller_id_status_index` (`seller_id`,`status`),
  ADD KEY `catalog_orders_status_index` (`status`);

--
-- Index pour la table `catalog_projects`
--
ALTER TABLE `catalog_projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catalog_projects_slug_unique` (`slug`),
  ADD KEY `catalog_projects_seller_id_foreign` (`seller_id`),
  ADD KEY `catalog_projects_category_id_foreign` (`category_id`),
  ADD KEY `catalog_projects_moderated_by_foreign` (`moderated_by`),
  ADD KEY `catalog_projects_status_created_at_index` (`status`,`created_at`),
  ADD KEY `catalog_projects_status_index` (`status`);

--
-- Index pour la table `catalog_project_images`
--
ALTER TABLE `catalog_project_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `catalog_project_images_catalog_project_id_foreign` (`catalog_project_id`);

--
-- Index pour la table `catalog_reviews`
--
ALTER TABLE `catalog_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `catalog_reviews_catalog_order_id_unique` (`catalog_order_id`),
  ADD KEY `catalog_reviews_catalog_project_id_foreign` (`catalog_project_id`),
  ADD KEY `catalog_reviews_reviewer_id_foreign` (`reviewer_id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Index pour la table `client_profiles`
--
ALTER TABLE `client_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_profiles_user_id_foreign` (`user_id`);

--
-- Index pour la table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contracts_job_id_foreign` (`job_id`),
  ADD KEY `contracts_proposal_id_foreign` (`proposal_id`),
  ADD KEY `contracts_client_id_foreign` (`client_id`),
  ADD KEY `contracts_freelancer_id_foreign` (`freelancer_id`),
  ADD KEY `contracts_dispute_opened_by_foreign` (`dispute_opened_by`),
  ADD KEY `contracts_resolved_by_foreign` (`resolved_by`),
  ADD KEY `contracts_cancelled_by_foreign` (`cancelled_by`),
  ADD KEY `contracts_completed_by_foreign` (`completed_by`),
  ADD KEY `contracts_status_client_idx` (`status`,`client_id`),
  ADD KEY `contracts_status_freelancer_idx` (`status`,`freelancer_id`),
  ADD KEY `contracts_archived_at_index` (`archived_at`),
  ADD KEY `contracts_auto_invoice_at_index` (`auto_invoice_at`);
ALTER TABLE `contracts` ADD FULLTEXT KEY `contracts_search_idx` (`title`,`description`);

--
-- Index pour la table `contract_activities`
--
ALTER TABLE `contract_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contract_activities_actor_id_foreign` (`actor_id`),
  ADD KEY `contract_activities_contract_id_created_at_index` (`contract_id`,`created_at`),
  ADD KEY `contract_activities_type_index` (`type`);

--
-- Index pour la table `contract_extensions`
--
ALTER TABLE `contract_extensions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contract_extensions_requested_by_foreign` (`requested_by`),
  ADD KEY `contract_extensions_responded_by_foreign` (`responded_by`),
  ADD KEY `contract_extensions_contract_id_status_index` (`contract_id`,`status`);

--
-- Index pour la table `contract_files`
--
ALTER TABLE `contract_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contract_files_uploader_id_foreign` (`uploader_id`),
  ADD KEY `contract_files_parent_id_foreign` (`parent_id`),
  ADD KEY `contract_files_contract_id_version_index` (`contract_id`,`version`);

--
-- Index pour la table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversations_contract_id_foreign` (`contract_id`),
  ADD KEY `conversations_job_id_foreign` (`job_id`);

--
-- Index pour la table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conversation_participants_conversation_id_user_id_unique` (`conversation_id`,`user_id`),
  ADD KEY `conversation_participants_user_id_foreign` (`user_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `freelancer_profiles`
--
ALTER TABLE `freelancer_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `freelancer_profiles_user_id_foreign` (`user_id`);
ALTER TABLE `freelancer_profiles` ADD FULLTEXT KEY `freelancer_profiles_search_idx` (`title`,`bio`);

--
-- Index pour la table `freelancer_skills`
--
ALTER TABLE `freelancer_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `freelancer_skills_user_id_foreign` (`user_id`),
  ADD KEY `freelancer_skills_skill_id_foreign` (`skill_id`);

--
-- Index pour la table `identity_verifications`
--
ALTER TABLE `identity_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identity_verifications_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `identity_verifications_user_id_status_index` (`user_id`,`status`),
  ADD KEY `identity_verifications_status_index` (`status`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `job_postings`
--
ALTER TABLE `job_postings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_postings_client_id_foreign` (`client_id`),
  ADD KEY `job_postings_status_created_at_index` (`status`,`created_at`),
  ADD KEY `job_postings_category_id_status_index` (`category_id`,`status`);
ALTER TABLE `job_postings` ADD FULLTEXT KEY `job_postings_search_idx` (`title`,`description`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_conversation_id_foreign` (`conversation_id`),
  ADD KEY `messages_sender_id_foreign` (`sender_id`),
  ADD KEY `messages_reply_to_id_foreign` (`reply_to_id`),
  ADD KEY `messages_conv_created_idx` (`conversation_id`,`created_at`),
  ADD KEY `messages_conv_sender_read_idx` (`conversation_id`,`sender_id`,`is_read`);
ALTER TABLE `messages` ADD FULLTEXT KEY `messages_search_idx` (`body`);

--
-- Index pour la table `message_reactions`
--
ALTER TABLE `message_reactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `message_reactions_message_id_user_id_emoji_unique` (`message_id`,`user_id`,`emoji`),
  ADD KEY `message_reactions_user_id_foreign` (`user_id`),
  ADD KEY `message_reactions_message_id_emoji_index` (`message_id`,`emoji`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `milestones_contract_id_foreign` (`contract_id`),
  ADD KEY `milestones_submitted_by_foreign` (`submitted_by`),
  ADD KEY `milestones_contract_status_idx` (`contract_id`,`status`),
  ADD KEY `milestones_creator_idx` (`created_by`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Index pour la table `platform_settings`
--
ALTER TABLE `platform_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `platform_settings_key_unique` (`key`),
  ADD KEY `platform_settings_group_index` (`group`);

--
-- Index pour la table `portfolios`
--
ALTER TABLE `portfolios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portfolios_user_id_foreign` (`user_id`);

--
-- Index pour la table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `proposals_job_id_freelancer_id_unique` (`job_id`,`freelancer_id`),
  ADD KEY `proposals_freelancer_id_foreign` (`freelancer_id`);

--
-- Index pour la table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`) USING HASH,
  ADD KEY `push_subscriptions_user_id_index` (`user_id`);

--
-- Index pour la table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_contract_id_foreign` (`contract_id`),
  ADD KEY `reviews_reviewer_id_foreign` (`reviewer_id`),
  ADD KEY `reviews_reviewee_id_foreign` (`reviewee_id`);

--
-- Index pour la table `saved_catalog_projects`
--
ALTER TABLE `saved_catalog_projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `saved_catalog_projects_user_id_catalog_project_id_unique` (`user_id`,`catalog_project_id`),
  ADD KEY `saved_catalog_projects_catalog_project_id_foreign` (`catalog_project_id`);

--
-- Index pour la table `saved_freelancers`
--
ALTER TABLE `saved_freelancers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `saved_freelancers_user_id_freelancer_id_unique` (`user_id`,`freelancer_id`),
  ADD KEY `saved_freelancers_freelancer_id_foreign` (`freelancer_id`);

--
-- Index pour la table `saved_jobs`
--
ALTER TABLE `saved_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `saved_jobs_user_id_job_id_unique` (`user_id`,`job_id`),
  ADD KEY `saved_jobs_job_id_foreign` (`job_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `skills_slug_unique` (`slug`),
  ADD KEY `skills_category_id_foreign` (`category_id`);

--
-- Index pour la table `stripe_webhook_events`
--
ALTER TABLE `stripe_webhook_events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stripe_webhook_events_stripe_event_id_unique` (`stripe_event_id`),
  ADD KEY `stripe_webhook_events_type_index` (`type`),
  ADD KEY `stripe_webhook_events_status_index` (`status`);

--
-- Index pour la table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscriptions_stripe_id_unique` (`stripe_id`),
  ADD KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`);

--
-- Index pour la table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`),
  ADD KEY `subscription_items_subscription_id_foreign` (`subscription_id`);

--
-- Index pour la table `talent_lists`
--
ALTER TABLE `talent_lists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `talent_lists_user_id_name_index` (`user_id`,`name`);

--
-- Index pour la table `talent_list_freelancers`
--
ALTER TABLE `talent_list_freelancers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `talent_list_freelancers_talent_list_id_freelancer_id_unique` (`talent_list_id`,`freelancer_id`),
  ADD KEY `talent_list_freelancers_freelancer_id_foreign` (`freelancer_id`);

--
-- Index pour la table `tax_documents`
--
ALTER TABLE `tax_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax_documents_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `tax_documents_user_id_status_index` (`user_id`,`status`),
  ADD KEY `tax_documents_form_type_index` (`form_type`),
  ADD KEY `tax_documents_status_index` (`status`);

--
-- Index pour la table `time_logs`
--
ALTER TABLE `time_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time_logs_user_id_foreign` (`user_id`),
  ADD KEY `time_logs_contract_id_user_id_started_at_index` (`contract_id`,`user_id`,`started_at`);

--
-- Index pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_reference_unique` (`reference`),
  ADD UNIQUE KEY `transactions_idempotency_key_unique` (`idempotency_key`),
  ADD KEY `transactions_wallet_id_foreign` (`wallet_id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_contract_id_foreign` (`contract_id`),
  ADD KEY `transactions_milestone_id_foreign` (`milestone_id`),
  ADD KEY `transactions_withdrawal_id_foreign` (`withdrawal_id`),
  ADD KEY `transactions_counterparty_user_id_foreign` (`counterparty_user_id`),
  ADD KEY `transactions_user_id_created_at_index` (`user_id`,`created_at`),
  ADD KEY `transactions_contract_id_milestone_id_index` (`contract_id`,`milestone_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_is_platform_index` (`is_platform`),
  ADD KEY `users_stripe_customer_id_index` (`stripe_customer_id`),
  ADD KEY `users_stripe_account_id_index` (`stripe_account_id`),
  ADD KEY `users_presence_idx` (`is_online`,`last_seen_at`);
ALTER TABLE `users` ADD FULLTEXT KEY `users_search_idx` (`name`,`username`);

--
-- Index pour la table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`);

--
-- Index pour la table `weekly_invoices`
--
ALTER TABLE `weekly_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `weekly_invoices_contract_id_week_start_unique` (`contract_id`,`week_start`),
  ADD UNIQUE KEY `weekly_invoices_idempotency_key_unique` (`idempotency_key`),
  ADD KEY `weekly_invoices_freelancer_id_status_index` (`freelancer_id`,`status`),
  ADD KEY `weekly_invoices_client_id_status_index` (`client_id`,`status`);

--
-- Index pour la table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdrawals_wallet_id_foreign` (`wallet_id`),
  ADD KEY `withdrawals_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `withdrawals_user_id_status_index` (`user_id`,`status`),
  ADD KEY `withdrawals_status_index` (`status`),
  ADD KEY `withdrawals_stripe_transfer_id_index` (`stripe_transfer_id`),
  ADD KEY `withdrawals_stripe_payout_id_index` (`stripe_payout_id`);

--
-- AUTO_INCREMENT pour les tables dÃƒÂ©chargÃƒÂ©es
--

--
-- AUTO_INCREMENT pour la table `agencies`
--
ALTER TABLE `agencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agency_invitations`
--
ALTER TABLE `agency_invitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agency_members`
--
ALTER TABLE `agency_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ai_histories`
--
ALTER TABLE `ai_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `catalog_orders`
--
ALTER TABLE `catalog_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `catalog_projects`
--
ALTER TABLE `catalog_projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `catalog_project_images`
--
ALTER TABLE `catalog_project_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `catalog_reviews`
--
ALTER TABLE `catalog_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `client_profiles`
--
ALTER TABLE `client_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `contract_activities`
--
ALTER TABLE `contract_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `contract_extensions`
--
ALTER TABLE `contract_extensions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contract_files`
--
ALTER TABLE `contract_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `freelancer_profiles`
--
ALTER TABLE `freelancer_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `freelancer_skills`
--
ALTER TABLE `freelancer_skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT pour la table `identity_verifications`
--
ALTER TABLE `identity_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `job_postings`
--
ALTER TABLE `job_postings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `message_reactions`
--
ALTER TABLE `message_reactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `milestones`
--
ALTER TABLE `milestones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `platform_settings`
--
ALTER TABLE `platform_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `portfolios`
--
ALTER TABLE `portfolios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `saved_catalog_projects`
--
ALTER TABLE `saved_catalog_projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `saved_freelancers`
--
ALTER TABLE `saved_freelancers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `saved_jobs`
--
ALTER TABLE `saved_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `stripe_webhook_events`
--
ALTER TABLE `stripe_webhook_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `subscription_items`
--
ALTER TABLE `subscription_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `talent_lists`
--
ALTER TABLE `talent_lists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `talent_list_freelancers`
--
ALTER TABLE `talent_list_freelancers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tax_documents`
--
ALTER TABLE `tax_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `time_logs`
--
ALTER TABLE `time_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `weekly_invoices`
--
ALTER TABLE `weekly_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables dÃƒÂ©chargÃƒÂ©es
--

--
-- Contraintes pour la table `agencies`
--
ALTER TABLE `agencies`
  ADD CONSTRAINT `agencies_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `agency_invitations`
--
ALTER TABLE `agency_invitations`
  ADD CONSTRAINT `agency_invitations_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agencies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `agency_invitations_invited_by_foreign` FOREIGN KEY (`invited_by`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `agency_members`
--
ALTER TABLE `agency_members`
  ADD CONSTRAINT `agency_members_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agencies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `agency_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ai_histories`
--
ALTER TABLE `ai_histories`
  ADD CONSTRAINT `ai_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `catalog_orders`
--
ALTER TABLE `catalog_orders`
  ADD CONSTRAINT `catalog_orders_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `catalog_orders_catalog_project_id_foreign` FOREIGN KEY (`catalog_project_id`) REFERENCES `catalog_projects` (`id`),
  ADD CONSTRAINT `catalog_orders_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `catalog_orders_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `catalog_orders_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `catalog_projects`
--
ALTER TABLE `catalog_projects`
  ADD CONSTRAINT `catalog_projects_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `catalog_projects_moderated_by_foreign` FOREIGN KEY (`moderated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `catalog_projects_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `catalog_project_images`
--
ALTER TABLE `catalog_project_images`
  ADD CONSTRAINT `catalog_project_images_catalog_project_id_foreign` FOREIGN KEY (`catalog_project_id`) REFERENCES `catalog_projects` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `catalog_reviews`
--
ALTER TABLE `catalog_reviews`
  ADD CONSTRAINT `catalog_reviews_catalog_order_id_foreign` FOREIGN KEY (`catalog_order_id`) REFERENCES `catalog_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `catalog_reviews_catalog_project_id_foreign` FOREIGN KEY (`catalog_project_id`) REFERENCES `catalog_projects` (`id`),
  ADD CONSTRAINT `catalog_reviews_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `client_profiles`
--
ALTER TABLE `client_profiles`
  ADD CONSTRAINT `client_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `contracts_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contracts_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `contracts_completed_by_foreign` FOREIGN KEY (`completed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contracts_dispute_opened_by_foreign` FOREIGN KEY (`dispute_opened_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contracts_freelancer_id_foreign` FOREIGN KEY (`freelancer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `contracts_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`),
  ADD CONSTRAINT `contracts_proposal_id_foreign` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`),
  ADD CONSTRAINT `contracts_resolved_by_foreign` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `contract_activities`
--
ALTER TABLE `contract_activities`
  ADD CONSTRAINT `contract_activities_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contract_activities_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `contract_extensions`
--
ALTER TABLE `contract_extensions`
  ADD CONSTRAINT `contract_extensions_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contract_extensions_requested_by_foreign` FOREIGN KEY (`requested_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `contract_extensions_responded_by_foreign` FOREIGN KEY (`responded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `contract_files`
--
ALTER TABLE `contract_files`
  ADD CONSTRAINT `contract_files_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contract_files_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `contract_files` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `contract_files_uploader_id_foreign` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `conversations_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD CONSTRAINT `conversation_participants_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversation_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `freelancer_profiles`
--
ALTER TABLE `freelancer_profiles`
  ADD CONSTRAINT `freelancer_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `freelancer_skills`
--
ALTER TABLE `freelancer_skills`
  ADD CONSTRAINT `freelancer_skills_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `freelancer_skills_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `identity_verifications`
--
ALTER TABLE `identity_verifications`
  ADD CONSTRAINT `identity_verifications_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `identity_verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `job_postings`
--
ALTER TABLE `job_postings`
  ADD CONSTRAINT `job_postings_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `job_postings_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_reply_to_id_foreign` FOREIGN KEY (`reply_to_id`) REFERENCES `messages` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `message_reactions`
--
ALTER TABLE `message_reactions`
  ADD CONSTRAINT `message_reactions_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `milestones`
--
ALTER TABLE `milestones`
  ADD CONSTRAINT `milestones_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `milestones_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `milestones_submitted_by_foreign` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `portfolios`
--
ALTER TABLE `portfolios`
  ADD CONSTRAINT `portfolios_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `proposals`
--
ALTER TABLE `proposals`
  ADD CONSTRAINT `proposals_freelancer_id_foreign` FOREIGN KEY (`freelancer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proposals_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  ADD CONSTRAINT `push_subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`),
  ADD CONSTRAINT `reviews_reviewee_id_foreign` FOREIGN KEY (`reviewee_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reviews_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `saved_catalog_projects`
--
ALTER TABLE `saved_catalog_projects`
  ADD CONSTRAINT `saved_catalog_projects_catalog_project_id_foreign` FOREIGN KEY (`catalog_project_id`) REFERENCES `catalog_projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_catalog_projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `saved_freelancers`
--
ALTER TABLE `saved_freelancers`
  ADD CONSTRAINT `saved_freelancers_freelancer_id_foreign` FOREIGN KEY (`freelancer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_freelancers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `saved_jobs`
--
ALTER TABLE `saved_jobs`
  ADD CONSTRAINT `saved_jobs_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_jobs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `skills_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD CONSTRAINT `subscription_items_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `talent_lists`
--
ALTER TABLE `talent_lists`
  ADD CONSTRAINT `talent_lists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `talent_list_freelancers`
--
ALTER TABLE `talent_list_freelancers`
  ADD CONSTRAINT `talent_list_freelancers_freelancer_id_foreign` FOREIGN KEY (`freelancer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `talent_list_freelancers_talent_list_id_foreign` FOREIGN KEY (`talent_list_id`) REFERENCES `talent_lists` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tax_documents`
--
ALTER TABLE `tax_documents`
  ADD CONSTRAINT `tax_documents_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tax_documents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `time_logs`
--
ALTER TABLE `time_logs`
  ADD CONSTRAINT `time_logs_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `time_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_counterparty_user_id_foreign` FOREIGN KEY (`counterparty_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_milestone_id_foreign` FOREIGN KEY (`milestone_id`) REFERENCES `milestones` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_withdrawal_id_foreign` FOREIGN KEY (`withdrawal_id`) REFERENCES `withdrawals` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `weekly_invoices`
--
ALTER TABLE `weekly_invoices`
  ADD CONSTRAINT `weekly_invoices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `weekly_invoices_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `weekly_invoices_freelancer_id_foreign` FOREIGN KEY (`freelancer_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD CONSTRAINT `withdrawals_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `withdrawals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `withdrawals_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
