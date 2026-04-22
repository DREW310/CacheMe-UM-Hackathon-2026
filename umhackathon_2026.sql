-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 22, 2026 at 06:42 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `umhackathon 2026`
--

-- --------------------------------------------------------

--
-- Table structure for table `processed_invoices`
--

CREATE TABLE `processed_invoices` (
  `invoice_id` int(11) NOT NULL,
  `invoice_number` varchar(100) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `processed_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `processed_invoices`
--

INSERT INTO `processed_invoices` (`invoice_id`, `invoice_number`, `vendor_id`, `total_amount`, `processed_date`) VALUES
(1, 'INV-2026-04-001', 1, 13500.00, '2026-04-02 09:15:00'),
(2, 'TM-B-449211', 2, 349.00, '2026-04-05 14:30:00'),
(3, 'SNS-INV-8832', 3, 17000.00, '2026-04-10 11:45:00'),
(4, 'TNB-202604-099', 5, 4500.50, '2026-04-12 10:00:00'),
(5, 'MAX-B-883920', 6, 474.00, '2026-04-15 08:30:00'),
(6, 'GRAB-26-881', 7, 500.00, '2026-04-18 16:45:00'),
(7, 'MAB-T-11029', 8, 1100.00, '2026-04-01 09:20:00'),
(8, 'POS-2026-332', 9, 85.00, '2026-04-20 11:15:00'),
(9, 'PETRONAS-FC-04', 4, 1075.00, '2026-04-21 15:00:00'),
(10, 'MBB-CORP-0426-88', 11, 150.00, '2026-04-03 09:00:00'),
(11, 'IHH-GL-2026-104', 14, 4250.00, '2026-04-08 14:15:00'),
(12, 'SUN-EVT-9921', 20, 15000.00, '2026-04-12 11:30:00'),
(13, 'CD-B2B-44911', 23, 980.00, '2026-04-16 10:45:00'),
(14, 'GAM-INV-26-003', 27, 9000.00, '2026-04-20 16:00:00'),
(15, 'INV-AMB-2026-041', 28, 850.00, '2026-04-04 10:00:00'),
(16, 'AXI-IOT-9922', 29, 1500.00, '2026-04-09 09:30:00'),
(17, 'SIM-LSE-811', 30, 9000.00, '2026-04-14 14:00:00'),
(18, 'NES-B2B-1044', 31, 1200.00, '2026-04-18 11:15:00'),
(19, 'MRD-CORP-4001', 33, 500.00, '2026-04-20 15:45:00'),
(20, 'MAHB-PRK-55', 34, 1750.00, '2026-04-22 08:30:00'),
(21, 'INV-INARI-9092', 38, 6000.00, '2026-04-02 10:15:00'),
(22, 'QL-CF-2026-04', 39, 8500.00, '2026-04-05 14:00:00'),
(23, 'BIMB-PAY-0426', 40, 350.00, '2026-04-07 09:30:00'),
(24, 'FNN-EVT-7721', 41, 1700.00, '2026-04-10 11:20:00'),
(25, 'TIME-ENT-991', 42, 4500.00, '2026-04-12 15:45:00'),
(26, 'WPORT-2026-33', 43, 4800.00, '2026-04-15 08:30:00'),
(27, 'YTL-CMT-8822', 44, 3800.00, '2026-04-18 13:10:00'),
(28, 'BURSA-AF-001', 45, 25000.00, '2026-04-20 10:00:00'),
(29, 'KPJ-HR-4041', 46, 2400.00, '2026-04-21 16:00:00'),
(30, 'ABMB-LN-092', 47, 1500.00, '2026-04-22 09:15:00'),
(31, 'INV-CARLS-26-88', 48, 4250.00, '2026-04-03 14:20:00'),
(32, 'BKB-CHM-4491', 49, 4200.00, '2026-04-06 09:15:00'),
(33, 'GENM-RT-004', 50, 24000.00, '2026-04-09 11:30:00'),
(34, 'UPB-CPO-9002', 51, 39000.00, '2026-04-11 10:45:00'),
(35, 'HARTA-GL-110', 52, 3700.00, '2026-04-14 15:00:00'),
(36, 'TOPG-MED-332', 53, 4200.00, '2026-04-16 08:30:00'),
(37, 'AA-CORP-0426-1', 54, 3000.00, '2026-04-19 13:20:00'),
(38, 'SPS-LSE-B1-04', 55, 15000.00, '2026-04-20 09:00:00'),
(39, 'BAB-OSV-26-02', 56, 90000.00, '2026-04-21 16:45:00'),
(40, 'FCB-CLN-8812', 57, 17000.00, '2026-04-22 10:10:00'),
(41, 'DRB-FL-26-004', 58, 12000.00, '2026-04-03 10:00:00'),
(42, 'MBSB-TF-0426', 59, 2500.00, '2026-04-06 14:15:00'),
(43, 'AFFIN-BG-112', 60, 1050.00, '2026-04-08 09:30:00'),
(44, 'MYEG-FW-992', 61, 1850.00, '2026-04-12 11:20:00'),
(45, 'GASM-IG-33', 62, 4500.00, '2026-04-15 15:45:00'),
(46, 'MAHS-RNT-A1', 63, 8500.00, '2026-04-18 08:30:00'),
(47, 'WCT-PM-04', 64, 25000.00, '2026-04-20 13:10:00'),
(48, 'ECOW-LSE-88', 65, 18000.00, '2026-04-21 10:00:00'),
(49, 'PAD-UNI-10', 66, 8500.00, '2026-04-22 16:00:00'),
(50, 'BJY-CAT-55', 67, 7500.00, '2026-04-23 09:15:00'),
(51, 'MAT-INV-2026-04', 68, 12000.00, '2026-04-02 09:00:00'),
(52, 'UOA-LSE-882', 69, 25000.00, '2026-04-05 10:30:00'),
(53, 'SCI-FLM-911', 70, 4250.00, '2026-04-08 14:15:00'),
(54, 'VIT-AOI-04', 71, 7000.00, '2026-04-11 11:45:00'),
(55, 'CMS-CMT-332', 72, 3600.00, '2026-04-14 08:20:00'),
(56, 'BPT-CRG-500', 73, 5500.00, '2026-04-17 16:30:00'),
(57, 'GPL-RPO-21', 74, 41000.00, '2026-04-20 09:10:00'),
(58, 'LCT-RES-81', 75, 10400.00, '2026-04-22 13:40:00'),
(59, 'VEL-RIG-001', 76, 240000.00, '2026-04-24 15:00:00'),
(60, 'DAY-MNT-99', 77, 90000.00, '2026-04-26 10:00:00'),
(61, 'AEON-GV-0426', 78, 9500.00, '2026-04-02 11:00:00'),
(62, 'BAUTO-FLT-88', 79, 4500.00, '2026-04-06 09:30:00'),
(63, 'LHI-PLT-332', 80, 8500.00, '2026-04-09 08:15:00'),
(64, 'KOS-CLN-01', 81, 6000.00, '2026-04-10 14:45:00'),
(65, 'HIB-CR-440', 82, 70000.00, '2026-04-13 16:00:00'),
(66, 'OSK-LSE-04', 83, 14000.00, '2026-04-15 10:30:00'),
(67, 'PAN-HVAC-33', 84, 22500.00, '2026-04-18 11:20:00'),
(68, 'MHB-FAB-11', 85, 36000.00, '2026-04-21 09:00:00'),
(69, 'STAR-AD-992', 86, 24000.00, '2026-04-22 15:10:00'),
(70, 'PAV-EVT-04', 87, 50000.00, '2026-04-24 13:00:00'),
(71, 'IGB-MV-0426', 88, 18000.00, '2026-04-03 10:00:00'),
(72, 'MAG-SPN-221', 89, 50000.00, '2026-04-05 14:30:00'),
(73, 'TOTO-AD-04', 90, 7000.00, '2026-04-08 09:15:00'),
(74, 'HEI-EVT-55', 91, 4500.00, '2026-04-10 11:20:00'),
(75, 'DL-PANTRY-01', 92, 900.00, '2026-04-12 15:45:00'),
(76, 'GCB-CB-334', 93, 75000.00, '2026-04-14 08:30:00'),
(77, 'SMAX-MED-99', 94, 3000.00, '2026-04-16 13:10:00'),
(78, 'MYN-BEN-04', 95, 4800.00, '2026-04-19 10:00:00'),
(79, 'KGB-MNT-112', 96, 120000.00, '2026-04-20 16:00:00'),
(80, 'KPG-PC-STG4', 97, 250000.00, '2026-04-22 09:45:00'),
(81, 'YIN-OM-0426', 98, 450000.00, '2026-04-03 08:00:00'),
(82, 'FF-HSP-2026', 99, 1400.00, '2026-04-05 09:30:00'),
(83, 'HSB-MB-404', 100, 5400.00, '2026-04-08 11:15:00'),
(84, 'MFCB-SOL-99', 101, 2200.00, '2026-04-10 14:00:00'),
(85, 'WCE-CORP-04', 102, 5000.00, '2026-04-12 10:45:00'),
(86, 'PHAR-MED-81', 103, 6000.00, '2026-04-14 13:20:00'),
(87, 'DNEX-API-26', 104, 2500.00, '2026-04-16 16:00:00'),
(88, 'TROP-W-211', 105, 17000.00, '2026-04-19 09:10:00'),
(89, 'GRE-CAL-01', 106, 12000.00, '2026-04-21 15:30:00'),
(90, 'CTOS-API-04', 107, 4500.00, '2026-04-23 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `sku` varchar(50) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`sku`, `product_name`, `category`) VALUES
('SKU-ABMB-SME', 'SME Business Loan Processing Fee', 'Financial Services'),
('SKU-AEON-VOUCH', 'AEON Corporate Gift Vouchers (RM100 Denomination)', 'Retail'),
('SKU-AFFIN-BG', 'Bank Guarantee Issuance Fee', 'Financial Services'),
('SKU-AMB-MERCH', 'AmBank Merchant Terminal Rental (Monthly)', 'Financial Services'),
('SKU-AXI-M2M', 'Axiata IoT M2M SIM Subscription', 'Telecommunications'),
('SKU-BAUTO-SVC', 'Mazda Corporate Fleet Maintenance Service', 'Automotive'),
('SKU-BIMB-WAGE', 'Islamic Corporate Payroll Processing Fee', 'Financial Services'),
('SKU-BJY-CAT', 'Berjaya Hotel Corporate Event Catering (Per Pax)', 'Food & Beverage'),
('SKU-BKB-CHEM', 'Industrial Caustic Soda (Per Drum)', 'Chemicals'),
('SKU-BPT-CRG', 'Port Cargo Handling Service (Per TEU)', 'Logistics'),
('SKU-BUMI-OSV', 'Offshore Support Vessel Charter (Daily Rate)', 'Oil & Gas'),
('SKU-BURSA-ANN', 'Annual Listing Maintenance Fee', 'Financial Services'),
('SKU-CAPA-CORP', 'AirAsia Corporate Flexi Flight (ASEAN Return)', 'Travel'),
('SKU-CARLS-EVT', 'Corporate Event Beverage Supply - Premium (Per Keg)', 'Food & Beverage'),
('SKU-CD-ENTROAM', 'CelcomDigi Enterprise Global Roaming Pass', 'Telecommunications'),
('SKU-CISCO-9200', 'Cisco Catalyst 9200L-48P-4G Switch', 'Networking'),
('SKU-CMS-CMT', 'Portland Cement Supply (Per Metric Ton)', 'Construction'),
('SKU-CTOS-API', 'CTOS Corporate Credit API Access (Per 1000 Calls)', 'Financial Services'),
('SKU-DAY-MNT', 'Offshore Topside Maintenance (Daily Rate)', 'Oil & Gas'),
('SKU-DELL-L5450', 'Dell Latitude 5450 Business Laptop', 'IT Hardware'),
('SKU-DELL-S150', 'Dell PowerEdge T150 Server', 'IT Hardware'),
('SKU-DL-MILK', 'Office Pantry Milk Supply (Bulk - 100 Cartons)', 'Food & Beverage'),
('SKU-DNEX-NSW', 'National Single Window Trade Declaration API (Monthly)', 'IT Services'),
('SKU-DRB-FLEET', 'Proton Corporate Fleet Leasing (Monthly)', 'Transportation'),
('SKU-ECOW-LSE', 'Eco Business Park Factory Lease (Monthly)', 'Real Estate'),
('SKU-FF-HOSP', 'Farm Fresh Hospitality Dairy Supply (Per 50 Cartons)', 'Food & Beverage'),
('SKU-FNN-EVENT', 'F&N Event Beverage Supply (Per Pallet)', 'Food & Beverage'),
('SKU-FRONT-CLEAN', 'Advanced Semiconductor Precision Cleaning', 'Manufacturing'),
('SKU-GAM-CIVENG', 'Civil Engineering Consultation (Hourly Rate)', 'Consulting'),
('SKU-GASM-IND', 'Industrial Natural Gas Supply (Per MMBtu)', 'Energy'),
('SKU-GCB-COCOA', 'Industrial Cocoa Butter (Per Metric Ton)', 'Agriculture & Food'),
('SKU-GENM-RETREAT', 'Corporate Retreat Package - RWG (Per Pax)', 'Travel & Hospitality'),
('SKU-GPL-RPO', 'Refined Palm Oil Supply (Per Metric Ton)', 'Agriculture'),
('SKU-GRAB-CORP', 'Grab Corporate Travel Voucher', 'Transportation'),
('SKU-GRE-CAL', 'Factory Automation Equipment Calibration Service', 'Manufacturing'),
('SKU-HARTA-NIT', 'Nitrile Examination Gloves (Bulk - 100 Cartons)', 'Medical Supplies'),
('SKU-HEI-EVT', 'Corporate Dinner Beverage Supply (Per Keg)', 'Food & Beverage'),
('SKU-HIB-CRUDE', 'Crude Oil Supply (Per 100 Barrels)', 'Oil & Gas'),
('SKU-HP-TONER', 'HP 85A Black Original LaserJet Toner', 'Office Supplies'),
('SKU-HS-MB', 'Mercedes-Benz Corporate Fleet Servicing (Hap Seng Star)', 'Automotive'),
('SKU-IGB-RNT', 'Mid Valley Megamall Retail Kiosk Space (Monthly)', 'Real Estate'),
('SKU-IHH-EXCHCK', 'Executive Comprehensive Health Screening (Per Pax)', 'Healthcare'),
('SKU-INARI-TEST', 'Semiconductor RF Testing (Per Batch)', 'Manufacturing'),
('SKU-KGB-GAS', 'Ultra-High Purity Gas Delivery System Maintenance', 'Engineering'),
('SKU-KOS-GLV', 'Cleanroom Nitrile Gloves (Per 10 Cartons)', 'Medical Supplies'),
('SKU-KPG-CNST', 'Subcontractor Progress Claim (Monthly Stage)', 'Construction'),
('SKU-KPJ-PREEMP', 'Pre-Employment Medical Checkup (Standard)', 'Healthcare'),
('SKU-LCT-RES', 'Polyethylene Resin Supply (Per Metric Ton)', 'Chemicals'),
('SKU-LHI-POULTRY', 'Wholesale Poultry Supply (Per 100kg)', 'Food & Beverage'),
('SKU-MAB-KULSIN', 'Economy Flight KUL-SIN (Return)', 'Travel'),
('SKU-MAG-CORP', 'Corporate Event Sponsorship Package', 'Marketing'),
('SKU-MAHB-PARK', 'KLIA Corporate Season Parking Pass', 'Transportation'),
('SKU-MAHS-RNT', 'Commercial Shop Lot Rental (Monthly)', 'Real Estate'),
('SKU-MAT-RNT', 'Matrix Commercial Space Lease (Monthly)', 'Real Estate'),
('SKU-MAXIS-5G', 'Maxis Business Postpaid 5G', 'Telecommunications'),
('SKU-MAY-CORPFEE', 'Corporate Account Maintenance Fee (Monthly)', 'Financial Services'),
('SKU-MBSB-FIN', 'Islamic Trade Financing Processing Fee', 'Financial Services'),
('SKU-MFCB-SOL', 'Commercial Solar PPA Generation (Per MWh)', 'Energy'),
('SKU-MHB-FAB', 'Offshore Structure Fabrication (Per Metric Tonne)', 'Engineering'),
('SKU-MRDIY-BULK', 'MR DIY Corporate Office Maintenance Kit', 'Office Supplies'),
('SKU-MYEG-FW', 'Foreign Worker Permit Renewal Service (Per Pax)', 'Government Services'),
('SKU-MYN-VCH', 'Corporate Employee Benefit Vouchers (RM50 Denomination)', 'Retail'),
('SKU-NES-PANTRY', 'Nestle Professional Office Pantry Supply', 'Office Supplies'),
('SKU-OSK-LSE', 'OSK Plaza Commercial Office Lease (Monthly)', 'Real Estate'),
('SKU-PAD-UNI', 'Custom Corporate Uniforms (Bulk - 100 Sets)', 'Apparel'),
('SKU-PAN-AC', 'Panasonic Commercial HVAC System Unit', 'Electronics'),
('SKU-PAV-EVT', 'Pavilion Mall Concourse Event Space (Daily Rate)', 'Real Estate'),
('SKU-PET-DSL', 'Diesel - Fleet Card (Per Liter)', 'Fuel'),
('SKU-PHAR-MED', 'Generic Paracetamol Supply (Bulk - 1000 Boxes)', 'Medical Supplies'),
('SKU-POS-LAJU', 'PosLaju Next Day Delivery (<1kg)', 'Logistics'),
('SKU-QL-CATER', 'Corporate Cafeteria Raw Food Supply (Monthly)', 'Food & Beverage'),
('SKU-SCI-FILM', 'Industrial Stretch Film Supply (Per Pallet)', 'Packaging'),
('SKU-SIM-FLEET', 'Sime Darby Heavy Equipment Leasing', 'Machinery'),
('SKU-SMAX-GLV', 'Standard Medical Gloves (Per 50 Cartons)', 'Medical Supplies'),
('SKU-SPS-LEASE', 'Commercial Office Space Lease (Monthly Base)', 'Real Estate'),
('SKU-STAR-AD', 'The Star Full-Page Print Advertisement', 'Media & Advertising'),
('SKU-SUN-CONV', 'Sunway Convention Centre Full-Day Rental', 'Event Management'),
('SKU-TIME-10G', 'Time Enterprise Leased Line 10Gbps', 'Telecommunications'),
('SKU-TM-ENT800', 'Enterprise Fibre 800Mbps (Monthly)', 'Networking'),
('SKU-TNB-COM', 'Commercial Electricity Tariff B (per kWh)', 'Utilities'),
('SKU-TOPG-SURG', 'Sterile Surgical Gloves (Bulk - 50 Cartons)', 'Medical Supplies'),
('SKU-TOTO-AD', 'In-Store Digital Display Advertising (Monthly)', 'Media & Advertising'),
('SKU-TROP-HOTEL', 'W Hotel Kuala Lumpur Corporate Block (10 Rooms/Night)', 'Travel & Hospitality'),
('SKU-UOA-OFF', 'UOA Corporate Office Rental (Monthly)', 'Real Estate'),
('SKU-UPB-CPO', 'Crude Palm Oil Supply (Per Metric Ton)', 'Agriculture'),
('SKU-VEL-RIG', 'Jack-up Drilling Rig Charter (Daily Rate)', 'Oil & Gas'),
('SKU-VIT-AOI', 'Automated Optical Inspection Services (Per Batch)', 'Technology'),
('SKU-WCE-RFID', 'Corporate Toll Fleet Pass - WCE Route (Monthly Sub)', 'Transportation'),
('SKU-WCT-ENG', 'Construction Project Management Fee (Monthly Phase)', 'Consulting'),
('SKU-WPRT-TEU', 'Standard 20ft TEU Container Handling Fee', 'Logistics'),
('SKU-YIN-FPSO', 'FPSO Vessel Operations & Maintenance (Daily)', 'Oil & Gas'),
('SKU-YTL-CMNT', 'Bulk Cement Supply (Per Metric Ton)', 'Construction');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendor_id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `ssm_number` varchar(50) NOT NULL,
  `tax_id` varchar(50) NOT NULL,
  `status` enum('ACTIVE','BLACKLISTED') DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`vendor_id`, `company_name`, `ssm_number`, `tax_id`, `status`) VALUES
(1, 'Dell Global Business Center Sdn Bhd', '199501037533', 'C1234567890', 'ACTIVE'),
(2, 'Telekom Malaysia Berhad', '198401016183', 'C9876543210', 'ACTIVE'),
(3, 'SNS Network (M) Sdn Bhd', '199801015502', 'C5554443330', 'ACTIVE'),
(4, 'Petronas Dagangan Berhad', '198201004151', 'C1112223330', 'ACTIVE'),
(5, 'Tenaga Nasional Berhad', '199001009294', 'C4445556660', 'ACTIVE'),
(6, 'Maxis Broadband Sdn Bhd', '199201002549', 'C7778889990', 'ACTIVE'),
(7, 'GrabCar Sdn Bhd', '201401026116', 'C1231231230', 'ACTIVE'),
(8, 'Malaysia Airlines Berhad', '201401040794', 'C9879879870', 'ACTIVE'),
(9, 'Pos Malaysia Berhad', '199101019653', 'C4564564560', 'ACTIVE'),
(10, 'Shady Tech Solutions Enterprise', '202503099999', 'C0000000001', 'BLACKLISTED'),
(11, 'Malayan Banking Berhad (Maybank)', '196001000142', 'C1000000001', 'ACTIVE'),
(12, 'Public Bank Berhad', '196501000672', 'C1000000002', 'ACTIVE'),
(13, 'CIMB Group Holdings Berhad', '195601000197', 'C1000000003', 'ACTIVE'),
(14, 'IHH Healthcare Berhad', '201001016626', 'C1000000004', 'ACTIVE'),
(15, 'Press Metal Aluminium Holdings Berhad', '198601004812', 'C1000000005', 'ACTIVE'),
(16, 'Hong Leong Bank Berhad', '193401000023', 'C1000000006', 'ACTIVE'),
(17, 'PETRONAS Chemicals Group Berhad', '199801003706', 'C1000000007', 'ACTIVE'),
(18, 'SD Guthrie Berhad', '200401009263', 'C1000000008', 'ACTIVE'),
(19, 'MISC Berhad', '196801000580', 'C1000000009', 'ACTIVE'),
(20, 'Sunway Berhad', '201001037627', 'C1000000010', 'ACTIVE'),
(21, 'PETRONAS Gas Berhad', '198301006447', 'C1000000011', 'ACTIVE'),
(22, 'RHB Bank Berhad', '196501000373', 'C1000000012', 'ACTIVE'),
(23, 'CelcomDigi Berhad', '199701009694', 'C1000000013', 'ACTIVE'),
(24, 'YTL Power International Berhad', '199601031393', 'C1000000014', 'ACTIVE'),
(25, '99 Speed Mart Retail Holdings Berhad', '202301010001', 'C1000000015', 'ACTIVE'),
(26, 'IOI Corporation Berhad', '196901000607', 'C1000000016', 'ACTIVE'),
(27, 'Gamuda Berhad', '197601003632', 'C1000000017', 'ACTIVE'),
(28, 'AMMB Holdings Berhad (AmBank)', '199101012723', 'C1000000018', 'ACTIVE'),
(29, 'Axiata Group Berhad', '199201010685', 'C1000000019', 'ACTIVE'),
(30, 'Sime Darby Berhad', '200601032645', 'C1000000020', 'ACTIVE'),
(31, 'Nestle (Malaysia) Berhad', '198401004653', 'C1000000021', 'ACTIVE'),
(32, 'Kuala Lumpur Kepong Berhad (KLK)', '197301000219', 'C1000000022', 'ACTIVE'),
(33, 'MR D.I.Y. Group (M) Berhad', '201001034084', 'C1000000023', 'ACTIVE'),
(34, 'Malaysia Airports Holdings Berhad', '199901012192', 'C1000000024', 'ACTIVE'),
(35, 'Genting Berhad', '196801000315', 'C1000000025', 'ACTIVE'),
(36, 'PPB Group Berhad', '196801000571', 'C1000000026', 'ACTIVE'),
(37, 'Dialog Group Berhad', '198901001388', 'C1000000027', 'ACTIVE'),
(38, 'Inari Amertron Berhad', '201001015698', 'C1000000028', 'ACTIVE'),
(39, 'QL Resources Berhad', '199701008590', 'C1000000029', 'ACTIVE'),
(40, 'Bank Islam Malaysia Berhad', '198201014361', 'C1000000030', 'ACTIVE'),
(41, 'Fraser & Neave Holdings Bhd (F&N)', '196101000088', 'C1000000031', 'ACTIVE'),
(42, 'Time dotCom Berhad', '199601040939', 'C1000000032', 'ACTIVE'),
(43, 'Westports Holdings Berhad', '199301008024', 'C1000000033', 'ACTIVE'),
(44, 'YTL Corporation Berhad', '198201012898', 'C1000000034', 'ACTIVE'),
(45, 'Bursa Malaysia Berhad', '197601004668', 'C1000000035', 'ACTIVE'),
(46, 'KPJ Healthcare Berhad', '199201015575', 'C1000000036', 'ACTIVE'),
(47, 'Alliance Bank Malaysia Berhad', '198201008390', 'C1000000037', 'ACTIVE'),
(48, 'Carlsberg Brewery Malaysia Berhad', '196901000792', 'C1000000038', 'ACTIVE'),
(49, 'Batu Kawan Berhad', '196501000477', 'C1000000039', 'ACTIVE'),
(50, 'Genting Malaysia Berhad', '198001004236', 'C1000000040', 'ACTIVE'),
(51, 'United Plantations Berhad', '190801000001', 'C1000000041', 'ACTIVE'),
(52, 'Hartalega Holdings Berhad', '200601022130', 'C1000000042', 'ACTIVE'),
(53, 'Top Glove Corporation Bhd', '199801018294', 'C1000000043', 'ACTIVE'),
(54, 'Capital A Berhad (AirAsia)', '201701030323', 'C1000000044', 'ACTIVE'),
(55, 'SP Setia Berhad', '197401002663', 'C1000000045', 'ACTIVE'),
(56, 'Bumi Armada Berhad', '199501041194', 'C1000000046', 'ACTIVE'),
(57, 'Frontken Corporation Berhad', '200401012517', 'C1000000047', 'ACTIVE'),
(58, 'DRB-HICOM Berhad', '199001011859', 'C1000000048', 'ACTIVE'),
(59, 'Malaysia Building Society Berhad (MBSB)', '197001000172', 'C1000000049', 'ACTIVE'),
(60, 'Affin Bank Berhad', '197501003274', 'C1000000050', 'ACTIVE'),
(61, 'MyEG Services Berhad', '200001003034', 'C1000000051', 'ACTIVE'),
(62, 'Gas Malaysia Berhad', '199201008606', 'C1000000052', 'ACTIVE'),
(63, 'Mah Sing Group Berhad', '199101019838', 'C1000000053', 'ACTIVE'),
(64, 'WCT Holdings Berhad', '201101002327', 'C1000000054', 'ACTIVE'),
(65, 'Eco World Development Group Berhad', '197401000725', 'C1000000055', 'ACTIVE'),
(66, 'Padini Holdings Berhad', '197901005918', 'C1000000056', 'ACTIVE'),
(67, 'Berjaya Corporation Berhad', '200101019033', 'C1000000057', 'ACTIVE'),
(68, 'Matrix Concepts Holdings Berhad', '199601042262', 'C1000000058', 'ACTIVE'),
(69, 'UOA Development Bhd', '200401015520', 'C1000000059', 'ACTIVE'),
(70, 'Scientex Berhad', '196801000259', 'C1000000060', 'ACTIVE'),
(71, 'ViTrox Corporation Berhad', '200401011463', 'C1000000061', 'ACTIVE'),
(72, 'Cahya Mata Sarawak Berhad (CMSB)', '197401003655', 'C1000000062', 'ACTIVE'),
(73, 'Bintulu Port Holdings Berhad', '199601008064', 'C1000000063', 'ACTIVE'),
(74, 'Genting Plantations Berhad', '197701003946', 'C1000000064', 'ACTIVE'),
(75, 'Lotte Chemical Titan Holding Berhad', '199101005696', 'C1000000065', 'ACTIVE'),
(76, 'Velesto Energy Berhad', '200901035667', 'C1000000066', 'ACTIVE'),
(77, 'Dayang Enterprise Holdings Bhd', '200501030106', 'C1000000067', 'ACTIVE'),
(78, 'AEON Co. (M) Bhd', '198401014370', 'C1000000068', 'ACTIVE'),
(79, 'Bermaz Auto Berhad', '201001016854', 'C1000000069', 'ACTIVE'),
(80, 'Leong Hup International Berhad', '201401022577', 'C1000000070', 'ACTIVE'),
(81, 'Kossan Rubber Industries Bhd', '197901003918', 'C1000000071', 'ACTIVE'),
(82, 'Hibiscus Petroleum Berhad', '200701040290', 'C1000000072', 'ACTIVE'),
(83, 'OSK Holdings Berhad', '199001015262', 'C1000000073', 'ACTIVE'),
(84, 'Panasonic Manufacturing Malaysia Berhad', '196501000304', 'C1000000074', 'ACTIVE'),
(85, 'Malaysia Marine and Heavy Engineering Holdings Berhad', '198901002387', 'C1000000075', 'ACTIVE'),
(86, 'Star Media Group Berhad', '197101000523', 'C1000000076', 'ACTIVE'),
(87, 'Pavilion Real Estate Investment Trust', '201101011359', 'C1000000077', 'ACTIVE'),
(88, 'IGB Real Estate Investment Trust', '201201026305', 'C1000000078', 'ACTIVE'),
(89, 'Magnum Berhad', '197501002449', 'C1000000079', 'ACTIVE'),
(90, 'Sports Toto Berhad', '196901000688', 'C1000000080', 'ACTIVE'),
(91, 'Heineken Malaysia Berhad', '196401000020', 'C1000000081', 'ACTIVE'),
(92, 'Dutch Lady Milk Industries Berhad', '196301000165', 'C1000000082', 'ACTIVE'),
(93, 'Guan Chong Berhad', '200401007722', 'C1000000083', 'ACTIVE'),
(94, 'Supermax Corporation Berhad', '199701020367', 'C1000000084', 'ACTIVE'),
(95, 'MyNews Holdings Berhad', '201301010004', 'C1000000085', 'ACTIVE'),
(96, 'Kelington Group Berhad', '199901026486', 'C1000000086', 'ACTIVE'),
(97, 'Kerjaya Prospek Group Berhad', '198401010054', 'C1000000087', 'ACTIVE'),
(98, 'Yinson Holdings Berhad', '199301004410', 'C1000000088', 'ACTIVE'),
(99, 'Farm Fresh Berhad', '202101010385', 'C1000000089', 'ACTIVE'),
(100, 'Hap Seng Consolidated Berhad', '197601000914', 'C1000000090', 'ACTIVE'),
(101, 'Mega First Corporation Berhad', '196601000104', 'C1000000091', 'ACTIVE'),
(102, 'WCE Holdings Berhad', '200001031730', 'C1000000092', 'ACTIVE'),
(103, 'Pharmaniaga Berhad', '199801011581', 'C1000000093', 'ACTIVE'),
(104, 'Dagang NeXchange Berhad (DNeX)', '197001000696', 'C1000000094', 'ACTIVE'),
(105, 'Tropicana Corporation Berhad', '197901003695', 'C1000000095', 'ACTIVE'),
(106, 'Greatech Technology Berhad', '201801008033', 'C1000000096', 'ACTIVE'),
(107, 'CTOS Digital Berhad', '201401025733', 'C1000000097', 'ACTIVE');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_contracts`
--

CREATE TABLE `vendor_contracts` (
  `contract_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `agreed_unit_price` decimal(10,2) NOT NULL,
  `valid_until` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor_contracts`
--

INSERT INTO `vendor_contracts` (`contract_id`, `vendor_id`, `sku`, `agreed_unit_price`, `valid_until`) VALUES
(1, 1, 'SKU-DELL-L5450', 4500.00, '2026-12-31'),
(2, 1, 'SKU-DELL-S150', 6200.00, '2026-12-31'),
(3, 2, 'SKU-TM-ENT800', 349.00, '2026-12-31'),
(4, 3, 'SKU-CISCO-9200', 8500.00, '2026-12-31'),
(5, 4, 'SKU-PET-DSL', 2.15, '2026-12-31'),
(6, 5, 'SKU-TNB-COM', 0.44, '2026-12-31'),
(7, 6, 'SKU-MAXIS-5G', 158.00, '2026-12-31'),
(8, 7, 'SKU-GRAB-CORP', 50.00, '2026-12-31'),
(9, 8, 'SKU-MAB-KULSIN', 550.00, '2026-12-31'),
(10, 9, 'SKU-POS-LAJU', 8.50, '2026-12-31'),
(11, 3, 'SKU-HP-TONER', 285.00, '2026-12-31'),
(12, 11, 'SKU-MAY-CORPFEE', 150.00, '2026-12-31'),
(13, 14, 'SKU-IHH-EXCHCK', 850.00, '2026-12-31'),
(14, 20, 'SKU-SUN-CONV', 15000.00, '2026-12-31'),
(15, 23, 'SKU-CD-ENTROAM', 98.00, '2026-12-31'),
(16, 27, 'SKU-GAM-CIVENG', 450.00, '2026-12-31'),
(17, 28, 'SKU-AMB-MERCH', 85.00, '2026-12-31'),
(18, 29, 'SKU-AXI-M2M', 15.00, '2026-12-31'),
(19, 30, 'SKU-SIM-FLEET', 4500.00, '2026-12-31'),
(20, 31, 'SKU-NES-PANTRY', 1200.00, '2026-12-31'),
(21, 33, 'SKU-MRDIY-BULK', 250.00, '2026-12-31'),
(22, 34, 'SKU-MAHB-PARK', 350.00, '2026-12-31'),
(23, 38, 'SKU-INARI-TEST', 1200.00, '2026-12-31'),
(24, 39, 'SKU-QL-CATER', 8500.00, '2026-12-31'),
(25, 40, 'SKU-BIMB-WAGE', 350.00, '2026-12-31'),
(26, 41, 'SKU-FNN-EVENT', 850.00, '2026-12-31'),
(27, 42, 'SKU-TIME-10G', 4500.00, '2026-12-31'),
(28, 43, 'SKU-WPRT-TEU', 480.00, '2026-12-31'),
(29, 44, 'SKU-YTL-CMNT', 380.00, '2026-12-31'),
(30, 45, 'SKU-BURSA-ANN', 25000.00, '2026-12-31'),
(31, 46, 'SKU-KPJ-PREEMP', 120.00, '2026-12-31'),
(32, 47, 'SKU-ABMB-SME', 1500.00, '2026-12-31'),
(33, 48, 'SKU-CARLS-EVT', 850.00, '2026-12-31'),
(34, 49, 'SKU-BKB-CHEM', 420.00, '2026-12-31'),
(35, 50, 'SKU-GENM-RETREAT', 1200.00, '2026-12-31'),
(36, 51, 'SKU-UPB-CPO', 3900.00, '2026-12-31'),
(37, 52, 'SKU-HARTA-NIT', 1850.00, '2026-12-31'),
(38, 53, 'SKU-TOPG-SURG', 2100.00, '2026-12-31'),
(39, 54, 'SKU-CAPA-CORP', 750.00, '2026-12-31'),
(40, 55, 'SKU-SPS-LEASE', 15000.00, '2026-12-31'),
(41, 56, 'SKU-BUMI-OSV', 45000.00, '2026-12-31'),
(42, 57, 'SKU-FRONT-CLEAN', 8500.00, '2026-12-31'),
(43, 58, 'SKU-DRB-FLEET', 1200.00, '2026-12-31'),
(44, 59, 'SKU-MBSB-FIN', 500.00, '2026-12-31'),
(45, 60, 'SKU-AFFIN-BG', 350.00, '2026-12-31'),
(46, 61, 'SKU-MYEG-FW', 185.00, '2026-12-31'),
(47, 62, 'SKU-GASM-IND', 45.00, '2026-12-31'),
(48, 63, 'SKU-MAHS-RNT', 8500.00, '2026-12-31'),
(49, 64, 'SKU-WCT-ENG', 25000.00, '2026-12-31'),
(50, 65, 'SKU-ECOW-LSE', 18000.00, '2026-12-31'),
(51, 66, 'SKU-PAD-UNI', 8500.00, '2026-12-31'),
(52, 67, 'SKU-BJY-CAT', 150.00, '2026-12-31'),
(53, 68, 'SKU-MAT-RNT', 12000.00, '2026-12-31'),
(54, 69, 'SKU-UOA-OFF', 25000.00, '2026-12-31'),
(55, 70, 'SKU-SCI-FILM', 850.00, '2026-12-31'),
(56, 71, 'SKU-VIT-AOI', 3500.00, '2026-12-31'),
(57, 72, 'SKU-CMS-CMT', 360.00, '2026-12-31'),
(58, 73, 'SKU-BPT-CRG', 550.00, '2026-12-31'),
(59, 74, 'SKU-GPL-RPO', 4100.00, '2026-12-31'),
(60, 75, 'SKU-LCT-RES', 5200.00, '2026-12-31'),
(61, 76, 'SKU-VEL-RIG', 120000.00, '2026-12-31'),
(62, 77, 'SKU-DAY-MNT', 45000.00, '2026-12-31'),
(63, 78, 'SKU-AEON-VOUCH', 95.00, '2026-12-31'),
(64, 79, 'SKU-BAUTO-SVC', 450.00, '2026-12-31'),
(65, 80, 'SKU-LHI-POULTRY', 850.00, '2026-12-31'),
(66, 81, 'SKU-KOS-GLV', 1200.00, '2026-12-31'),
(67, 82, 'SKU-HIB-CRUDE', 35000.00, '2026-12-31'),
(68, 83, 'SKU-OSK-LSE', 14000.00, '2026-12-31'),
(69, 84, 'SKU-PAN-AC', 4500.00, '2026-12-31'),
(70, 85, 'SKU-MHB-FAB', 18000.00, '2026-12-31'),
(71, 86, 'SKU-STAR-AD', 12000.00, '2026-12-31'),
(72, 87, 'SKU-PAV-EVT', 25000.00, '2026-12-31'),
(73, 88, 'SKU-IGB-RNT', 18000.00, '2026-12-31'),
(74, 89, 'SKU-MAG-CORP', 50000.00, '2026-12-31'),
(75, 90, 'SKU-TOTO-AD', 3500.00, '2026-12-31'),
(76, 91, 'SKU-HEI-EVT', 900.00, '2026-12-31'),
(77, 92, 'SKU-DL-MILK', 450.00, '2026-12-31'),
(78, 93, 'SKU-GCB-COCOA', 25000.00, '2026-12-31'),
(79, 94, 'SKU-SMAX-GLV', 1500.00, '2026-12-31'),
(80, 95, 'SKU-MYN-VCH', 48.00, '2026-12-31'),
(81, 96, 'SKU-KGB-GAS', 120000.00, '2026-12-31'),
(82, 97, 'SKU-KPG-CNST', 250000.00, '2026-12-31'),
(83, 98, 'SKU-YIN-FPSO', 150000.00, '2026-12-31'),
(84, 99, 'SKU-FF-HOSP', 350.00, '2026-12-31'),
(85, 100, 'SKU-HS-MB', 1800.00, '2026-12-31'),
(86, 101, 'SKU-MFCB-SOL', 220.00, '2026-12-31'),
(87, 102, 'SKU-WCE-RFID', 500.00, '2026-12-31'),
(88, 103, 'SKU-PHAR-MED', 1200.00, '2026-12-31'),
(89, 104, 'SKU-DNEX-NSW', 2500.00, '2026-12-31'),
(90, 105, 'SKU-TROP-HOTEL', 8500.00, '2026-12-31'),
(91, 106, 'SKU-GRE-CAL', 6000.00, '2026-12-31'),
(92, 107, 'SKU-CTOS-API', 1500.00, '2026-12-31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `processed_invoices`
--
ALTER TABLE `processed_invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `unique_invoice_vendor` (`invoice_number`,`vendor_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`sku`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`vendor_id`),
  ADD UNIQUE KEY `ssm_number` (`ssm_number`);

--
-- Indexes for table `vendor_contracts`
--
ALTER TABLE `vendor_contracts`
  ADD PRIMARY KEY (`contract_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `sku` (`sku`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `processed_invoices`
--
ALTER TABLE `processed_invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `vendor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `vendor_contracts`
--
ALTER TABLE `vendor_contracts`
  MODIFY `contract_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `processed_invoices`
--
ALTER TABLE `processed_invoices`
  ADD CONSTRAINT `fk_invoice_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`);

--
-- Constraints for table `vendor_contracts`
--
ALTER TABLE `vendor_contracts`
  ADD CONSTRAINT `fk_contract_sku` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`),
  ADD CONSTRAINT `fk_contract_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
