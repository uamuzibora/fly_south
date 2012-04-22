# **IMPORTANT: Run the following first to get MySQL to accept '0' as a valid value in an autoincrement column:
# SET GLOBAL sql_mode='NO_AUTO_VALUE_ON_ZERO';
# SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
# (We *really* ought to fix this sometime...)

CREATE DATABASE IF NOT EXISTS `public` DEFAULT CHARACTER SET utf8 ;
USE `public`;

DROP TABLE IF EXISTS `archive_result_values`;
CREATE TABLE `archive_result_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_id` int(11) NOT NULL,
  `archive_result_id` int(11) NOT NULL,
  `archive_value_DECIMAL` double DEFAULT NULL,
  `archive_value_TEXT` varchar(255) DEFAULT NULL,
  `archive_value_lookup` varchar(255) DEFAULT NULL,
  `archive_user_id` int(11) NOT NULL,
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `occupations`;
CREATE TABLE `occupations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `occupations` WRITE;
INSERT INTO `occupations` VALUES (0,'None',NULL,NULL);
INSERT INTO `occupations` VALUES (1,'Unskilled',NULL,NULL);
INSERT INTO `occupations` VALUES (2,'Skilled',NULL,NULL);
INSERT INTO `occupations` VALUES (3,'Professional',NULL,NULL);
INSERT INTO `occupations` VALUES (4,'Student',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `tree_left` int(11) DEFAULT NULL,
  `tree_right` int(11) DEFAULT NULL,
  `vf_code` int(11) DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

LOCK TABLES `locations` WRITE;
INSERT INTO `locations` VALUES (1,'Kenya',NULL,1,86,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (2,'Central',1,2,3,1,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (3,'Coast',1,4,5,2,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (4,'Eastern',1,6,7,3,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (5,'Nairobi Area',1,8,9,5,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (6,'North-Eastern',1,10,11,6,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (7,'Nyanza',1,12,13,7,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (8,'Rift Valley',1,14,15,8,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (9,'Western',1,16,85,9,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (10,'Bungoma',9,17,18,1,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (11,'Busia',9,19,20,2,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (12,'Kakamega',9,21,74,3,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (13,'Butere',9,75,76,4,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (14,'Lugari',9,77,78,5,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (15,'Teso',9,79,80,6,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (16,'Vihiga',9,81,82,7,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (17,'Mount Elgon',9,83,84,8,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (18,'Butere',12,22,23,1,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (19,'Ikolomani',12,24,25,2,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (20,'Khwisero',12,26,27,3,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (21,'Lugari',12,28,29,4,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (22,'Shinyalu',12,30,31,5,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (23,'Malava',12,32,33,6,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (24,'Mumias',12,34,35,7,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (25,'Lurambi',12,36,73,8,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (26,'South Butsotso',25,37,42,1,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (27,'Central Butsotso',25,43,52,2,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (28,'East Butsotso',25,53,60,3,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (29,'North Butsotso',25,61,72,4,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (30,'Matioli',26,38,39,1,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (31,'Emukaya',26,40,41,2,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (32,'Shiveye',27,44,45,3,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (33,'Shibuli',27,46,47,4,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (34,'Eshisuru',27,48,49,5,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (35,'Shiyunzu',27,50,51,6,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (36,'Murumba',28,54,55,7,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (37,'Shirakalu',28,56,57,8,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (38,'Indangalasia',28,58,59,9,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (39,'Esumeyia',29,62,63,10,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (40,'Shikomari',29,64,65,11,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (41,'Shinoyi',29,66,67,12,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (42,'Ingotse',29,68,69,13,NULL,NULL,NULL,NULL);
INSERT INTO `locations` VALUES (43,'Mathia',29,70,71,14,NULL,NULL,NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `art_substitutions`;
CREATE TABLE `art_substitutions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `regimen_id` int(11) NOT NULL,
  `art_substitution_reason_id` int(11) NOT NULL,
  `art_line` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `regimens`;
CREATE TABLE `regimens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

LOCK TABLES `regimens` WRITE;
INSERT INTO `regimens` VALUES (1,'1A','(D4T30/3TC/NVP)','1st Line');
INSERT INTO `regimens` VALUES (2,'2A','(D4T30/3TC/EFV)','1st Line');
INSERT INTO `regimens` VALUES (3,'3A','(AZT/3TC/EFV)','1st Line');
INSERT INTO `regimens` VALUES (4,'3B','(AZT/3TC/NVP)','1st Line');
INSERT INTO `regimens` VALUES (5,'R66','(TDF/3FC/NVP)','2nd Line');
INSERT INTO `regimens` VALUES (6,'R67','(ABC/DDI/LPVR)','2nd Line');
INSERT INTO `regimens` VALUES (7,'PEP1','(AZT/3TC)','PEP');
INSERT INTO `regimens` VALUES (8,'Other','Other',NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `art_interruption_reasons`;
CREATE TABLE `art_interruption_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `art_interruption_reasons` WRITE;
INSERT INTO `art_interruption_reasons` VALUES (0,'Default(1/12)',NULL,NULL);
INSERT INTO `art_interruption_reasons` VALUES (1,'Lost to follow-up (3/12)',NULL,NULL);
INSERT INTO `art_interruption_reasons` VALUES (2,'Stop',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `second_line_reasons`;
CREATE TABLE `second_line_reasons` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `aros_acos`;
CREATE TABLE `aros_acos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aro_id` int(11) NOT NULL,
  `aco_id` int(11) NOT NULL,
  `_create` varchar(2) NOT NULL DEFAULT '0',
  `_read` varchar(2) NOT NULL DEFAULT '0',
  `_update` varchar(2) NOT NULL DEFAULT '0',
  `_delete` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `aro_aco_key` (`aro_id`,`aco_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `medical_informations`;
CREATE TABLE `medical_informations` (
  `pid` int(11) NOT NULL,
  `patient_source_id` int(11) DEFAULT NULL,
  `funding_id` int(11) DEFAULT NULL,
  `hiv_positive_date` date DEFAULT NULL,
  `hiv_positive_test_location_id` int(11) DEFAULT NULL,
  `hiv_positive_clinic_start_date` date DEFAULT NULL,
  `hiv_positive_who_stage` int(11) DEFAULT NULL,
  `art_naive` tinyint(1) DEFAULT NULL,
  `art_service_type_id` int(11) DEFAULT NULL,
  `art_first_start_date` date DEFAULT NULL,
  `art_eligibility_date` date DEFAULT NULL,
  `art_indication_id` int(11) DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `transfer_in_district_id` int(11) DEFAULT NULL,
  `transfer_in_facility` varchar(255) DEFAULT NULL,
  `transfer_out_date` date DEFAULT NULL,
  `transfer_out_event` text,
  `DATE_pep_start` date DEFAULT NULL,
  `pep_reason_id` int(11) DEFAULT NULL,
  `art_eligible_who_stage` int(11) DEFAULT NULL,
  `art_eligible_cd4` int(11) DEFAULT NULL,
  `art_start_weight` decimal(10,0) DEFAULT NULL,
  `art_start_height` decimal(10,0) DEFAULT NULL,
  `art_start_who_stage` int(11) DEFAULT NULL,
  `art_second_start_date` date DEFAULT NULL,
  `art_second_line_reason_id` int(11) DEFAULT NULL,
  `drug_allergies` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pid`),
  KEY `medical_informations_art_indication_id_fkey` (`art_indication_id`),
  KEY `medical_informations_art_service_type_id_fkey` (`art_service_type_id`),
  KEY `medical_informations_funding_id_fkey` (`funding_id`),
  KEY `medical_informations_hiv_positive_test_location_id_fkey` (`hiv_positive_test_location_id`),
  KEY `medical_informations_patient_source_id_fkey` (`patient_source_id`),
  KEY `medical_informations_transfer_in_district_id_fkey` (`transfer_in_district_id`),
  CONSTRAINT `medical_informations_transfer_in_district_id_fkey` FOREIGN KEY (`transfer_in_district_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `medical_informations_art_indication_id_fkey` FOREIGN KEY (`art_indication_id`) REFERENCES `art_indications` (`id`),
  CONSTRAINT `medical_informations_art_service_type_id_fkey` FOREIGN KEY (`art_service_type_id`) REFERENCES `art_service_types` (`id`),
  CONSTRAINT `medical_informations_funding_id_fkey` FOREIGN KEY (`funding_id`) REFERENCES `fundings` (`id`),
  CONSTRAINT `medical_informations_hiv_positive_test_location_id_fkey` FOREIGN KEY (`hiv_positive_test_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `medical_informations_patient_source_id_fkey` FOREIGN KEY (`patient_source_id`) REFERENCES `patient_sources` (`id`),
  CONSTRAINT `medical_informations_pid_fkey` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `aros`;
CREATE TABLE `aros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rght` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `aros` WRITE;
INSERT INTO `aros` VALUES (1,NULL,'Group',1,NULL,1,8);
INSERT INTO `aros` VALUES (2,NULL,'Group',2,NULL,9,12);
INSERT INTO `aros` VALUES (3,1,'User',1,NULL,2,3);
INSERT INTO `aros` VALUES (4,2,'User',2,NULL,10,11);
INSERT INTO `aros` VALUES (5,NULL,'Group',3,NULL,13,20);
INSERT INTO `aros` VALUES (6,5,'User',3,NULL,14,15);
INSERT INTO `aros` VALUES (7,5,'User',4,NULL,16,17);
INSERT INTO `aros` VALUES (8,5,'User',5,NULL,18,19);
INSERT INTO `aros` VALUES (9,1,'User',6,NULL,6,7);
INSERT INTO `aros` VALUES (10,1,'User',7,NULL,4,5);
UNLOCK TABLES;

DROP TABLE IF EXISTS `art_indications`;
CREATE TABLE `art_indications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `art_indications` WRITE;
INSERT INTO `art_indications` VALUES (1,'WHO Stage',NULL,NULL);
INSERT INTO `art_indications` VALUES (2,'TLC',NULL,NULL);
INSERT INTO `art_indications` VALUES (3,'CD4 Count',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_results`;
CREATE TABLE `archive_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_id` int(11) NOT NULL,
  `archive_pid` int(11) NOT NULL,
  `archive_test_id` int(11) NOT NULL,
  `archive_test_performed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_requesting_clinician` varchar(255) DEFAULT NULL,
  `archive_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `art_substitution_reasons`;
CREATE TABLE `art_substitution_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

LOCK TABLES `art_substitution_reasons` WRITE;
INSERT INTO `art_substitution_reasons` VALUES (1,'Toxicity/Side effects',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (2,'Pregnancy',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (3,'Risk of pregnancy',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (4,'Due to new TB',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (5,'New drug available',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (6,'Drug out of stock',NULL,NULL);
INSERT INTO `art_substitution_reasons` VALUES (7,'Other',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `abbreiviation` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `upper_limit` double DEFAULT NULL,
  `lower_limit` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `user_id` int(11) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `units` varchar(255) DEFAULT NULL,
  `multival` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tests_user_id_fkey` (`user_id`),
  CONSTRAINT `tests_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

LOCK TABLES `tests` WRITE;
INSERT INTO `tests` VALUES (1,'Clinic Attendance','Attendance','lookup',NULL,NULL,'A record of a patients clinic attendance',NULL,1,1,'2009-07-19 19:37:59',NULL,NULL);
INSERT INTO `tests` VALUES (2,'Weight','Wt','DECIMAL',NULL,NULL,'The patients current weight in kilograms.',NULL,1,1,'2009-07-19 19:39:59','kg',NULL);
INSERT INTO `tests` VALUES (3,'Height','Ht','DECIMAL',NULL,NULL,'The patients current height in metres.',NULL,1,1,'2009-07-19 19:40:22','m',NULL);
INSERT INTO `tests` VALUES (4,'Temperature','Temp','DECIMAL',NULL,NULL,'The patients temperature in degrees Celsius.',NULL,1,1,'2009-07-19 19:41:10','ºC',NULL);
INSERT INTO `tests` VALUES (5,'Blood Pressure','BP','TEXT',NULL,NULL,'The patients blood pressure (systolic/diastolic)',NULL,1,1,'2009-07-19 19:41:10',NULL,NULL);
INSERT INTO `tests` VALUES (6,'WHO Stage',NULL,'lookup',NULL,NULL,'The patients current WHO Stage (1-4)',NULL,1,1,'2009-07-19 19:41:10',NULL,NULL);
INSERT INTO `tests` VALUES (7,'Pregnant',NULL,'lookup',NULL,NULL,'Is the patient currently pregnant?',NULL,1,1,'2009-07-19 19:41:32',NULL,NULL);
INSERT INTO `tests` VALUES (8,'Last Menstrual Period','LMP','TEXT',NULL,NULL,'Date of the patients LMP in the format DD-MM-YYYY',NULL,1,1,'2009-07-19 19:43:46',NULL,NULL);
INSERT INTO `tests` VALUES (9,'Family Planning Status','FP Status','lookup',NULL,NULL,'Is the patient using any form of contraception?',NULL,1,1,'2009-07-19 19:44:36',NULL,0);
INSERT INTO `tests` VALUES (10,'TB Status',NULL,'lookup',NULL,NULL,'The current TB status of the patient.',NULL,1,1,'2009-07-19 19:46:10',NULL,NULL);
INSERT INTO `tests` VALUES (11,'Opportunistic Infection','Opportunistic Infection','lookup',NULL,NULL,'Does the patient have a new opportunistic infection?',NULL,1,1,'2009-07-19 19:48:23',NULL,1);
INSERT INTO `tests` VALUES (12,'Other Medical Conditions',NULL,'lookup',NULL,NULL,'Does the patient have any new other medical condition?',NULL,1,1,'2009-07-19 19:48:23',NULL,1);
INSERT INTO `tests` VALUES (13,'Conditions (others)',NULL,'TEXT',NULL,NULL,NULL,NULL,1,1,'2009-07-19 19:48:23',NULL,NULL);
INSERT INTO `tests` VALUES (14,'ART Side Effects','ART Side Effects','lookup',NULL,NULL,'Is the patient currently have any side-effects of ARTs?',NULL,1,1,'2009-07-19 19:53:32',NULL,1);
INSERT INTO `tests` VALUES (15,'Cotrimoxazole Status',NULL,'lookup',NULL,NULL,'Is the patient taking cotrimoxazole?',NULL,1,1,'2009-07-19 19:56:15',NULL,NULL);
INSERT INTO `tests` VALUES (16,'Fluconazole Status',NULL,'lookup',NULL,NULL,'Is the patient taking fluconazole?',NULL,1,1,'2009-07-19 19:57:27',NULL,NULL);
INSERT INTO `tests` VALUES (17,'Other Medications Dispensed','Other Medications','lookup',NULL,NULL,'Have any other drugs been dispensed to the patient?',NULL,1,1,'2009-07-19 19:58:40',NULL,1);
INSERT INTO `tests` VALUES (18,'Medications (others)',NULL,'TEXT',NULL,NULL,NULL,NULL,1,1,'2009-07-19 19:48:23',NULL,NULL);
INSERT INTO `tests` VALUES (19,'ARV Drug Adherence',NULL,'lookup',NULL,NULL,NULL,NULL,1,1,'2009-07-19 20:00:28',NULL,NULL);
INSERT INTO `tests` VALUES (20,'ARV Drug Regimen',NULL,'lookup',NULL,NULL,NULL,NULL,1,1,'2009-07-19 19:59:43',NULL,NULL);
INSERT INTO `tests` VALUES (21,'CD4 Count','CD4','DECIMAL',NULL,NULL,'The patients current CD4 count.',NULL,1,1,'2009-07-19 20:01:45','/μl',NULL);
INSERT INTO `tests` VALUES (22,'Haemaglobin','Hb','DECIMAL',NULL,NULL,'The patients current haemaglobin level.',NULL,1,1,'2009-07-19 20:02:16','g/dL',NULL);
INSERT INTO `tests` VALUES (23,'White Cell Count','WCC','DECIMAL',NULL,NULL,'The patients current white cell count.',NULL,1,1,'2009-07-19 20:03:10','x10^9',NULL);
INSERT INTO `tests` VALUES (24,'ALT','ALT','DECIMAL',NULL,NULL,NULL,NULL,1,1,'2009-07-19 20:03:50','IU',NULL);
INSERT INTO `tests` VALUES (25,'Adherence counselling',NULL,'lookup',NULL,NULL,NULL,NULL,1,1,'2009-07-19 20:04:13',NULL,1);
INSERT INTO `tests` VALUES (26,'Refered To',NULL,'TEXT',NULL,NULL,NULL,NULL,1,1,'2009-07-19 20:05:12',NULL,0);
INSERT INTO `tests` VALUES (27,'Counselling',NULL,'lookup',NULL,NULL,'Has the patient received any form of counselling?',NULL,1,1,'2009-07-19 20:04:24',NULL,NULL);
INSERT INTO `tests` VALUES (28,'Date Of Next Appointment',NULL,'TEXT',NULL,NULL,'The date of next appointment in the format DD-MM-YYYY',NULL,1,1,'2009-07-19 20:05:44',NULL,0);
INSERT INTO `tests` VALUES (29,'Examination Findings',NULL,'TEXT',NULL,NULL,NULL,NULL,1,1,'2009-07-19 20:05:58',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'admin','82bf611c53901f13c54e59f032a4d4714168c505075f7010d05ff2d8062a8c9e',1,NULL,'2009-07-10 18:35:38','2009-07-10 18:35:38');
INSERT INTO `users` VALUES (2,'user','89ef4f9d082dad635f13d9aab392a2ce41f47dbfd28d783e023ccfd5213a1a67',2,NULL,'2009-07-10 18:35:59','2009-07-10 18:35:59');
INSERT INTO `users` VALUES (3,'data','78732071c8fa23f1587f71b1bd7169b3e186c978e2cc1cf281580b9a9cad31d7',3,NULL,'2010-04-11 20:29:55','2010-04-11 20:29:55');
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_patients`;
CREATE TABLE `archive_patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_pid` int(11) NOT NULL,
  `archive_upn` varchar(255) DEFAULT NULL,
  `archive_arvid` varchar(255) DEFAULT NULL,
  `archive_vfcc` varchar(255) DEFAULT NULL,
  `archive_surname` varchar(255) NOT NULL,
  `archive_forenames` varchar(255) NOT NULL,
  `archive_date_of_birth` date DEFAULT NULL,
  `archive_year_of_birth` int(11) DEFAULT NULL,
  `archive_sex` varchar(255) DEFAULT NULL,
  `archive_mother` varchar(255) DEFAULT NULL,
  `archive_occupation_id` int(11) DEFAULT NULL,
  `archive_education_id` int(11) DEFAULT NULL,
  `archive_marital_status_id` int(11) DEFAULT NULL,
  `archive_telephone_number` varchar(255) DEFAULT NULL,
  `archive_treatment_supporter` text,
  `archive_location_id` int(11) DEFAULT NULL,
  `archive_village` varchar(255) DEFAULT NULL,
  `archive_home` varchar(255) DEFAULT NULL,
  `archive_nearest_church` varchar(255) DEFAULT NULL,
  `archive_nearest_school` varchar(255) DEFAULT NULL,
  `archive_nearest_health_centre` varchar(255) DEFAULT NULL,
  `archive_nearest_major_landmark` varchar(255) DEFAULT NULL,
  `archive_vf_testing_site` int(11) DEFAULT NULL,
  `archive_status` tinyint(1) NOT NULL,
  `archive_inactive_reason_id` int(11) DEFAULT NULL,
  `archive_status_timestamp` date DEFAULT NULL,
  `archive_treatment_supporter_name` varchar(255) DEFAULT NULL,
  `archive_treatment_supporter_relationship` varchar(255) DEFAULT NULL,
  `archive_treatment_supporter_address` varchar(255) DEFAULT NULL,
  `archive_treatment_supporter_telephone_number` varchar(255) DEFAULT NULL,
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `archive_patients_archive_education_id_fkey` (`archive_education_id`),
  KEY `archive_patients_archive_inactive_reason_id_fkey` (`archive_inactive_reason_id`),
  KEY `archive_patients_archive_location_id_fkey` (`archive_location_id`),
  KEY `archive_patients_archive_marital_status_id_fkey` (`archive_marital_status_id`),
  KEY `archive_patients_archive_occupation_id_fkey` (`archive_occupation_id`),
  KEY `archive_patients_archive_vf_testing_site_fkey` (`archive_vf_testing_site`),
  KEY `archive_patients_user_id_fkey` (`user_id`),
  CONSTRAINT `archive_patients_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `archive_patients_archive_education_id_fkey` FOREIGN KEY (`archive_education_id`) REFERENCES `educations` (`id`),
  CONSTRAINT `archive_patients_archive_inactive_reason_id_fkey` FOREIGN KEY (`archive_inactive_reason_id`) REFERENCES `inactive_reasons` (`id`),
  CONSTRAINT `archive_patients_archive_location_id_fkey` FOREIGN KEY (`archive_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `archive_patients_archive_marital_status_id_fkey` FOREIGN KEY (`archive_marital_status_id`) REFERENCES `marital_statuses` (`id`),
  CONSTRAINT `archive_patients_archive_occupation_id_fkey` FOREIGN KEY (`archive_occupation_id`) REFERENCES `occupations` (`id`),
  CONSTRAINT `archive_patients_archive_vf_testing_site_fkey` FOREIGN KEY (`archive_vf_testing_site`) REFERENCES `vf_testing_sites` (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `vf_testing_sites`;
CREATE TABLE `vf_testing_sites` (
  `site_code` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `location_id` int(11) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`site_code`),
  UNIQUE KEY `site_name` (`site_name`),
  KEY `vf_testing_sites_location_id_fkey` (`location_id`),
  CONSTRAINT `vf_testing_sites_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

LOCK TABLES `vf_testing_sites` WRITE;
INSERT INTO `vf_testing_sites` VALUES (1,'Ebukulima','Salvation Army',30,0.19305,34.61363);
INSERT INTO `vf_testing_sites` VALUES (2,'Mwiyenga','Church',30,0.20582,34.63413);
INSERT INTO `vf_testing_sites` VALUES (3,'Ekapwonje','Church',31,0.2164,34.61413);
INSERT INTO `vf_testing_sites` VALUES (4,'Shianda','Church',31,0.23147,34.62008);
INSERT INTO `vf_testing_sites` VALUES (5,'Sumba','Dispensary',32,0.24218,34.63955);
INSERT INTO `vf_testing_sites` VALUES (6,'Shirembe','Dispensary',32,0.25447,34.62112);
INSERT INTO `vf_testing_sites` VALUES (7,'Ematsayi','School',32,0.27548,34.62123);
INSERT INTO `vf_testing_sites` VALUES (8,'Eshikuyu','Health Centre',33,0.26477,34.6559);
INSERT INTO `vf_testing_sites` VALUES (9,'Ibinzo','School',33,0.2566,34.68793);
INSERT INTO `vf_testing_sites` VALUES (10,'Eshisiru','District Office',34,0.2816,34.6734);
INSERT INTO `vf_testing_sites` VALUES (11,'Emusanda','Dispensary',34,0.29325,34.6476);
INSERT INTO `vf_testing_sites` VALUES (12,'Ikonyero','Church',35,0.28343,34.72247);
INSERT INTO `vf_testing_sites` VALUES (13,'Eshiyunzu','Church',35,0.29087,34.70355);
INSERT INTO `vf_testing_sites` VALUES (14,'Murumba','Dispensary',36,0.30315,34.7261);
INSERT INTO `vf_testing_sites` VALUES (15,'Shikoti','Church',36,0.31788,34.73593);
INSERT INTO `vf_testing_sites` VALUES (16,'Emukoyani','Church',37,0.32135,34.74947);
INSERT INTO `vf_testing_sites` VALUES (17,'Elukho','Church',37,0.3229,34.75647);
INSERT INTO `vf_testing_sites` VALUES (18,'Emusala','Church',38,0.32965,34.78048);
INSERT INTO `vf_testing_sites` VALUES (19,'Emukaba','Church',38,0.34425,34.76343);
INSERT INTO `vf_testing_sites` VALUES (20,'Bushibo','Church',39,0.3081,34.68608);
INSERT INTO `vf_testing_sites` VALUES (21,'Emukaya','Health Centre',39,0.3185,34.70267);
INSERT INTO `vf_testing_sites` VALUES (22,'Esumeyia','Church',39,0.31972,34.68102);
INSERT INTO `vf_testing_sites` VALUES (23,'Shikomari','Church',40,0.32085,34.64448);
INSERT INTO `vf_testing_sites` VALUES (24,'Gospel Spring','Church',40,0.33845,34.65478);
INSERT INTO `vf_testing_sites` VALUES (25,'Shinoyi','Church',41,0.34402,34.665);
INSERT INTO `vf_testing_sites` VALUES (26,'Naluchira','Church',41,0.34895,34.69418);
INSERT INTO `vf_testing_sites` VALUES (27,'Ingotse','Health Centre',42,0.35545,34.69788);
INSERT INTO `vf_testing_sites` VALUES (28,'Bushiri','Church',42,0.365,34.72917);
INSERT INTO `vf_testing_sites` VALUES (29,'Emulama','Church',43,0.3763,34.75545);
INSERT INTO `vf_testing_sites` VALUES (30,'Matiha','Church',43,0.36153,34.76567);
INSERT INTO `vf_testing_sites` VALUES (31,'Shikakala','Unknown',25,NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `result_lookups`;
CREATE TABLE `result_lookups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `result_lookups_user_id_fkey` (`user_id`),
  CONSTRAINT `result_lookups_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

LOCK TABLES `result_lookups` WRITE;
INSERT INTO `result_lookups` VALUES (1,1,'A','Arrived',NULL,1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (2,1,'S','Seen',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (3,1,'DNA','Did Not Attend',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (4,6,'1','Stage 1',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (5,6,'2','Stage 2',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (6,6,'3','Stage 3',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (7,6,'4','Stage 4',NULL,1,'2009-07-19 19:38:59');
INSERT INTO `result_lookups` VALUES (8,7,'N','No',NULL,1,'2009-07-19 19:41:43');
INSERT INTO `result_lookups` VALUES (9,7,'Y','Yes',NULL,1,'2009-07-19 19:42:04');
INSERT INTO `result_lookups` VALUES (10,9,'Y','Yes',NULL,1,'2009-07-19 19:44:48');
INSERT INTO `result_lookups` VALUES (11,9,'N','No',NULL,1,'2009-07-19 19:44:58');
INSERT INTO `result_lookups` VALUES (12,10,'1','No Signs',NULL,1,'2009-07-19 19:46:21');
INSERT INTO `result_lookups` VALUES (13,10,'2','TB Suspected',NULL,1,'2009-07-19 19:46:31');
INSERT INTO `result_lookups` VALUES (14,10,'3','Receiving TB Treatment',NULL,1,'2009-07-19 19:46:45');
INSERT INTO `result_lookups` VALUES (15,11,'1','Herpes Zoster',NULL,1,'2009-07-19 19:48:32');
INSERT INTO `result_lookups` VALUES (16,11,'2','Pneumonia',NULL,1,'2009-07-19 19:48:41');
INSERT INTO `result_lookups` VALUES (17,11,'3','Dementia / Encephalitis',NULL,1,'2009-07-19 19:48:55');
INSERT INTO `result_lookups` VALUES (18,11,'4','Thrush',NULL,1,'2009-07-19 19:49:36');
INSERT INTO `result_lookups` VALUES (19,11,'5','Ulcers',NULL,1,'2009-07-19 19:51:10');
INSERT INTO `result_lookups` VALUES (20,11,'6','Fever',NULL,1,'2009-07-19 19:51:20');
INSERT INTO `result_lookups` VALUES (21,11,'7','Cough',NULL,1,'2009-07-19 19:51:28');
INSERT INTO `result_lookups` VALUES (22,11,'8','Difficulty Breathing',NULL,1,'2009-07-19 19:51:39');
INSERT INTO `result_lookups` VALUES (23,11,'9','IRIS',NULL,1,'2009-07-19 19:52:00');
INSERT INTO `result_lookups` VALUES (24,11,'10','Weight Loss',NULL,1,'2009-07-19 19:52:10');
INSERT INTO `result_lookups` VALUES (25,11,'11','Urethral Discharge',NULL,1,'2009-07-19 19:52:19');
INSERT INTO `result_lookups` VALUES (26,11,'12','Pelvic Inflammatory Disease',NULL,1,'2009-07-19 19:52:32');
INSERT INTO `result_lookups` VALUES (27,11,'13','Genital Ulcerative Disease',NULL,1,'2009-07-19 19:52:48');
INSERT INTO `result_lookups` VALUES (28,14,'1','Peripheral Neuropathy',NULL,1,'2009-07-19 19:53:46');
INSERT INTO `result_lookups` VALUES (29,14,'2','Rash',NULL,1,'2009-07-19 19:53:53');
INSERT INTO `result_lookups` VALUES (30,14,'3','Anaemia',NULL,1,'2009-07-19 19:54:00');
INSERT INTO `result_lookups` VALUES (31,14,'4','Pancreatitis',NULL,1,'2009-07-19 19:54:09');
INSERT INTO `result_lookups` VALUES (32,14,'5','Jaundice',NULL,1,'2009-07-19 19:54:19');
INSERT INTO `result_lookups` VALUES (33,14,'6','Fat Redistribution',NULL,1,'2009-07-19 19:54:31');
INSERT INTO `result_lookups` VALUES (34,14,'7','Hypersensitivity',NULL,1,'2009-07-19 19:54:41');
INSERT INTO `result_lookups` VALUES (35,14,'8','Hepatotoxicity',NULL,1,'2009-07-19 19:54:51');
INSERT INTO `result_lookups` VALUES (36,14,'9','CNS Symptoms',NULL,1,'2009-07-19 19:55:10');
INSERT INTO `result_lookups` VALUES (37,15,'Y','Yes',NULL,1,'2009-07-19 19:56:30');
INSERT INTO `result_lookups` VALUES (38,15,'YS','Yes (SA)',NULL,1,'2009-07-19 19:56:30');
INSERT INTO `result_lookups` VALUES (39,15,'YU','Yes (UA)',NULL,1,'2009-07-19 19:56:46');
INSERT INTO `result_lookups` VALUES (40,15,'N','No',NULL,1,'2009-07-19 19:56:54');
INSERT INTO `result_lookups` VALUES (41,16,'Y','Yes',NULL,1,'2009-07-19 19:56:30');
INSERT INTO `result_lookups` VALUES (42,16,'YS','Yes (SA)',NULL,1,'2009-07-19 19:57:34');
INSERT INTO `result_lookups` VALUES (43,16,'YU','Yes (UA)',NULL,1,'2009-07-19 19:57:46');
INSERT INTO `result_lookups` VALUES (44,16,'N','No',NULL,1,'2009-07-19 19:58:04');
INSERT INTO `result_lookups` VALUES (45,20,'1A','1A (D4T30/3TC/NVP)','1st Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (46,20,'2A','2A (D4T30/3TC/EFV)','1st Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (47,20,'3A','3A (AZT/3TC/EFV)','1st Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (48,20,'3B','3B (AZT/3TC/NVP)','1st Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (49,20,'R66','R66 (TDF/3FC/NVP)','2nd Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (50,20,'R67','R67 (ABC/DDI/LPVR)','2nd Line',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (51,20,'PEP1','PEP1 (AZT/3TC)','PEP',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (52,20,'O','Other','Other',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (53,20,'U','Unknown','Unknown',1,'2009-07-19 19:38:09');
INSERT INTO `result_lookups` VALUES (54,19,'Y','Yes',NULL,1,'2009-07-19 19:56:30');
INSERT INTO `result_lookups` VALUES (55,19,'YS','Yes (SA)',NULL,1,'2009-07-19 20:00:35');
INSERT INTO `result_lookups` VALUES (56,19,'YU','Yes (UA)',NULL,1,'2009-07-19 20:00:44');
INSERT INTO `result_lookups` VALUES (57,19,'N','No',NULL,1,'2009-07-19 20:00:52');
INSERT INTO `result_lookups` VALUES (58,25,'1','Basic HIV Education, transmission',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (59,25,'2','Prevention: abstinenece, safer sex, condoms',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (60,25,'3','Prevention: household precautions, what is safe',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (61,25,'4','Post-test counselling: implications of results',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (62,25,'5','Positive living',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (63,25,'6','Testing partners-Discordants',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (64,25,'7','Disclosure',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (65,25,'8','To whom disclosed',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (66,25,'9','Family/living situation',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (67,25,'10','Shared confidentiality',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (68,25,'11','Reproductive choices, prevention MTCT',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (69,25,'12','Progression of disease',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (70,25,'13','Available treatment/prophylaxis',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (71,25,'14','Follow-up appointments, clinical team',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (72,25,'15','CTX, prophylaxis',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (73,25,'16','ART - educate on essentials (locally adapted)',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (74,25,'17','Why complete adherence needed',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (75,25,'18','Adherence preparation',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (76,25,'19','Indicate when READY for ART',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (77,25,'20','Explain dose, when to take',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (78,25,'21','What can occur, how to manage SEs',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (79,25,'22','What to do if one forgets dose',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (80,25,'23','What to do when travelling',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (81,25,'24','Adherence plan (schedule, aids, explain diary)',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (82,25,'25','Treatment supporter preparation',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (83,25,'26','Which doses, why missed',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (84,25,'27','ARV support group',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (85,25,'28','How to contact clinic',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (86,25,'29','Symptom management/palliative care at home',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (87,25,'30','Caregiver booklet',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (88,25,'31','Home-based care',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (89,25,'32','Support groups',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (90,25,'33','Community support',NULL,1,'2009-07-19 20:04:20');
INSERT INTO `result_lookups` VALUES (91,17,'1','Amoxicillin',NULL,1,'2010-04-13 17:26:53');
INSERT INTO `result_lookups` VALUES (92,17,'4','Doxycycline',NULL,1,'2010-04-13 17:27:50');
INSERT INTO `result_lookups` VALUES (93,17,'2','Ciprofloxacin',NULL,1,'2010-04-13 17:28:05');
INSERT INTO `result_lookups` VALUES (94,17,'3','Cotrimoxazole',NULL,1,'2010-04-13 17:28:23');
INSERT INTO `result_lookups` VALUES (95,17,'5','Flagyl',NULL,1,'2010-04-13 17:29:57');
INSERT INTO `result_lookups` VALUES (96,17,'7','Piriton',NULL,1,'2010-04-13 17:30:19');
INSERT INTO `result_lookups` VALUES (97,17,'17','Other (please specify)',NULL,1,'2010-04-13 17:30:39');
INSERT INTO `result_lookups` VALUES (98,17,'6','Multivitamins',NULL,1,'2010-04-13 17:30:58');
INSERT INTO `result_lookups` VALUES (99,12,'1','Diarrhoea (bloody)',NULL,1,'2010-04-13 17:34:21');
INSERT INTO `result_lookups` VALUES (100,12,'2','Diarrhoea (watery)',NULL,1,'2010-04-13 17:34:39');
INSERT INTO `result_lookups` VALUES (101,12,'3','Helminthiasis',NULL,1,'2010-04-13 17:34:51');
INSERT INTO `result_lookups` VALUES (102,12,'4','Malaria',NULL,1,'2010-04-13 17:35:00');
INSERT INTO `result_lookups` VALUES (103,12,'5','Pneumonia (lower RTI)',NULL,1,'2010-04-13 17:35:19');
INSERT INTO `result_lookups` VALUES (104,12,'6','RTI (upper)',NULL,1,'2010-04-13 17:35:30');
INSERT INTO `result_lookups` VALUES (105,12,'7','Other (please specify)',NULL,1,'2010-04-13 17:37:10');
INSERT INTO `result_lookups` VALUES (106,17,'8','Paracetamol',NULL,1,'2010-04-14 04:50:41');
INSERT INTO `result_lookups` VALUES (107,17,'9','Ibuprofen',NULL,1,'2010-04-14 04:50:56');
INSERT INTO `result_lookups` VALUES (108,17,'10','Metronidazole',NULL,1,'2010-04-14 04:56:51');
INSERT INTO `result_lookups` VALUES (109,17,'11','Acyclovir',NULL,1,'2010-04-14 04:59:09');
INSERT INTO `result_lookups` VALUES (110,17,'12','Fluconazole',NULL,1,'2010-04-14 04:59:21');
INSERT INTO `result_lookups` VALUES (111,17,'13','Ketonazole',NULL,1,'2010-04-14 04:59:50');
INSERT INTO `result_lookups` VALUES (112,17,'14','Erythromycin',NULL,1,'2010-04-14 07:24:33');
INSERT INTO `result_lookups` VALUES (113,17,'15','Cefuroxime',NULL,1,'2010-04-14 07:24:51');
INSERT INTO `result_lookups` VALUES (114,17,'16','Nystatin',NULL,1,'2010-04-14 07:25:12');
UNLOCK TABLES;

DROP TABLE IF EXISTS `pep_reasons`;
CREATE TABLE `pep_reasons` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pep_reasons` WRITE;
INSERT INTO `pep_reasons` VALUES (1,'Sexual assault',NULL,NULL);
INSERT INTO `pep_reasons` VALUES (2,'Occupational exposure',NULL,NULL);
INSERT INTO `pep_reasons` VALUES (3,'Others',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `results`;
CREATE TABLE `results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `test_performed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `requesting_clinician` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fundings`;
CREATE TABLE `fundings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `fundings` WRITE;
INSERT INTO `fundings` VALUES (1,'GOK/NASCOP',NULL,NULL);
INSERT INTO `fundings` VALUES (2,'USA/PEPFAR',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_medical_informations`;
CREATE TABLE `archive_medical_informations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_pid` int(11) NOT NULL,
  `archive_patient_source_id` int(11) DEFAULT NULL,
  `archive_funding_id` int(11) DEFAULT NULL,
  `archive_hiv_positive_date` date DEFAULT NULL,
  `archive_hiv_positive_test_location_id` int(11) DEFAULT NULL,
  `archive_hiv_positive_clinic_start_date` date DEFAULT NULL,
  `archive_hiv_positive_who_stage` int(11) DEFAULT NULL,
  `archive_art_naive` tinyint(1) DEFAULT NULL,
  `archive_art_service_type_id` int(11) DEFAULT NULL,
  `archive_art_starting_regimen_id` int(11) DEFAULT NULL,
  `archive_art_start_date` date DEFAULT NULL,
  `archive_art_eligibility_date` date DEFAULT NULL,
  `archive_art_indication_id` int(11) DEFAULT NULL,
  `archive_transfer_in_date` date DEFAULT NULL,
  `archive_transfer_in_district_id` int(11) DEFAULT NULL,
  `archive_transfer_in_facility` text,
  `archive_transfer_out_date` date DEFAULT NULL,
  `archive_date_pep_start` date DEFAULT NULL,
  `archive_pep_reason_id` int(11) DEFAULT NULL,
  `archive_art_eligible_who_stage` int(11) DEFAULT NULL,
  `archive_art_eligible_cd4` int(11) DEFAULT NULL,
  `archive_art_start_weight` int(11) DEFAULT NULL,
  `archive_art_start_height` int(11) DEFAULT NULL,
  `archive_art_start_who_stage` int(11) DEFAULT NULL,
  `archive_art_second_start_date` date DEFAULT NULL,
  `archive_art_second_line_reason_id` int(11) DEFAULT NULL,
  `archive_drug_allergies` varchar(255) DEFAULT NULL,
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `archive_medical_informations_archive_art_indication_id_fkey` (`archive_art_indication_id`),
  KEY `archive_medical_informations_archive_art_service_type_id_fkey` (`archive_art_service_type_id`),
  KEY `archive_medical_informations_archive_art_starting_regimen__fkey` (`archive_art_starting_regimen_id`),
  KEY `archive_medical_informations_archive_funding_id_fkey` (`archive_funding_id`),
  KEY `archive_medical_informations_archive_hiv_positive_test_loc_fkey` (`archive_hiv_positive_test_location_id`),
  KEY `archive_medical_informations_archive_patient_source_id_fkey` (`archive_patient_source_id`),
  KEY `archive_medical_informations_archive_pid_fkey` (`archive_pid`),
  KEY `archive_medical_informations_archive_transfer_in_district__fkey` (`archive_transfer_in_district_id`),
  KEY `archive_medical_informations_user_id_fkey` (`user_id`),
  CONSTRAINT `archive_medical_informations_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `archive_medical_informations_archive_art_indication_id_fkey` FOREIGN KEY (`archive_art_indication_id`) REFERENCES `art_indications` (`id`),
  CONSTRAINT `archive_medical_informations_archive_art_service_type_id_fkey` FOREIGN KEY (`archive_art_service_type_id`) REFERENCES `art_service_types` (`id`),
  CONSTRAINT `archive_medical_informations_archive_art_starting_regimen__fkey` FOREIGN KEY (`archive_art_starting_regimen_id`) REFERENCES `regimens` (`id`),
  CONSTRAINT `archive_medical_informations_archive_funding_id_fkey` FOREIGN KEY (`archive_funding_id`) REFERENCES `fundings` (`id`),
  CONSTRAINT `archive_medical_informations_archive_hiv_positive_test_loc_fkey` FOREIGN KEY (`archive_hiv_positive_test_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `archive_medical_informations_archive_patient_source_id_fkey` FOREIGN KEY (`archive_patient_source_id`) REFERENCES `patient_sources` (`id`),
  CONSTRAINT `archive_medical_informations_archive_pid_fkey` FOREIGN KEY (`archive_pid`) REFERENCES `patients` (`pid`),
  CONSTRAINT `archive_medical_informations_archive_transfer_in_district__fkey` FOREIGN KEY (`archive_transfer_in_district_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
LOCK TABLES `groups` WRITE;
INSERT INTO `groups` VALUES (1,'admin',NULL,'2009-07-10 18:35:23','2009-07-10 18:35:23');
INSERT INTO `groups` VALUES (2,'user',NULL,'2009-07-10 18:35:27','2009-07-10 18:35:27');
INSERT INTO `groups` VALUES (3,'data','Group for mass data entry','2010-04-11 18:37:20','2010-04-11 18:37:20');
UNLOCK TABLES;

DROP TABLE IF EXISTS `educations`;
CREATE TABLE `educations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `educations` WRITE;
INSERT INTO `educations` VALUES (0,'None',NULL,NULL);
INSERT INTO `educations` VALUES (1,'Some primary',NULL,NULL);
INSERT INTO `educations` VALUES (2,'Some secondary',NULL,NULL);
INSERT INTO `educations` VALUES (3,'Some Post secondary',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_result_lookups`;
CREATE TABLE `archive_result_lookups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_id` int(11) DEFAULT NULL,
  `archive_test_id` int(11) NOT NULL,
  `archive_value` varchar(255) NOT NULL,
  `archive_description` varchar(255) DEFAULT NULL,
  `archive_comment` varchar(255) DEFAULT NULL,
  `archive_user_id` int(11) NOT NULL,
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `inactive_reasons`;
CREATE TABLE `inactive_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `inactive_reasons` WRITE;
INSERT INTO `inactive_reasons` VALUES (0,'None',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (1,'Default (1 month)',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (2,'Lost to Follow Up (3 months)',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (3,'Stop',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (4,'Deceased',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (5,'PEP End',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (6,'PMTCT End',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (7,'Lost to Follow-up',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (8,'Transfer Out',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (9,'Stopped by Physician',NULL,NULL);
INSERT INTO `inactive_reasons` VALUES (10,'Stopped as Duplicate Record',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_users`;
CREATE TABLE `archive_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `archive_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_username` varchar(255) NOT NULL,
  `archive_password` varchar(255) NOT NULL,
  `archive_group_id` int(11) NOT NULL,
  `archive_name` varchar(255) DEFAULT NULL,
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `patient_sources`;
CREATE TABLE `patient_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

LOCK TABLES `patient_sources` WRITE;
INSERT INTO `patient_sources` VALUES (1,'PMTCT',NULL,NULL);
INSERT INTO `patient_sources` VALUES (2,'Inpatient',NULL,NULL);
INSERT INTO `patient_sources` VALUES (3,'VCT',NULL,NULL);
INSERT INTO `patient_sources` VALUES (4,'Child Welfare Clinic',NULL,NULL);
INSERT INTO `patient_sources` VALUES (5,'TB OPD',NULL,NULL);
INSERT INTO `patient_sources` VALUES (6,'VF',NULL,NULL);
INSERT INTO `patient_sources` VALUES (7,'OPD ',NULL,NULL);
INSERT INTO `patient_sources` VALUES (8,'PITC',NULL,NULL);
INSERT INTO `patient_sources` VALUES (9,'Other',NULL,NULL);
UNLOCK TABLES;


DROP TABLE IF EXISTS `art_second_line_reasons`;
CREATE TABLE `art_second_line_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `art_second_line_reasons` WRITE;
INSERT INTO `art_second_line_reasons` VALUES (0,'Clinical treatment failure',NULL,NULL);
INSERT INTO `art_second_line_reasons` VALUES (1,'Immunological failure',NULL,NULL);
INSERT INTO `art_second_line_reasons` VALUES (2,'Virologic failure',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `archive_groups`;
CREATE TABLE `archive_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `archive_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_name` varchar(255) DEFAULT NULL,
  `archive_description` varchar(255) DEFAULT NULL,
  `archive_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `archive_tests`;
CREATE TABLE `archive_tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_id` int(11) DEFAULT NULL,
  `archive_name` varchar(255) NOT NULL,
  `archive_abbreiviation` varchar(255) DEFAULT NULL,
  `archive_type` varchar(255) NOT NULL,
  `archive_upper_limit` double DEFAULT NULL,
  `archive_lower_limit` double DEFAULT NULL,
  `archive_description` varchar(255) DEFAULT NULL,
  `archive_comment` varchar(255) DEFAULT NULL,
  `archive_active` tinyint(1) DEFAULT '1',
  `archive_user_id` int(11) NOT NULL,
  `archive_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `art_regimens`;
CREATE TABLE `art_regimens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `regimen_id` int(11) NOT NULL,
  `art_line` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `art_service_types`;
CREATE TABLE `art_service_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

LOCK TABLES `art_service_types` WRITE;
INSERT INTO `art_service_types` VALUES (0,'Not on ART',NULL,NULL);
INSERT INTO `art_service_types` VALUES (1,'ART',NULL,NULL);
INSERT INTO `art_service_types` VALUES (2,'PMTCT',NULL,NULL);
INSERT INTO `art_service_types` VALUES (3,'PEP (Assualt)',NULL,NULL);
INSERT INTO `art_service_types` VALUES (4,'PEP (Occupational)',NULL,NULL);
INSERT INTO `art_service_types` VALUES (5,'OI Only',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `art_interruptions`;
CREATE TABLE `art_interruptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `interruption_date` date NOT NULL,
  `art_interruption_reason_id` int(11) NOT NULL,
  `restart_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `upn` varchar(255) NOT NULL,
  `old_upn` varchar(255) DEFAULT NULL,
  `arvid` varchar(255) DEFAULT NULL,
  `vfcc` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  `forenames` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `year_of_birth` int(11) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `mother` varchar(255) DEFAULT NULL,
  `occupation_id` int(11) DEFAULT NULL,
  `education_id` int(11) DEFAULT NULL,
  `marital_status_id` int(11) DEFAULT NULL,
  `telephone_number` varchar(255) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `village` varchar(255) DEFAULT NULL,
  `home` varchar(255) DEFAULT NULL,
  `nearest_church` varchar(255) DEFAULT NULL,
  `nearest_school` varchar(255) DEFAULT NULL,
  `nearest_health_centre` varchar(255) DEFAULT NULL,
  `nearest_major_landmark` varchar(255) DEFAULT NULL,
  `vf_testing_site` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `inactive_reason_id` int(11) DEFAULT NULL,
  `status_timestamp` date DEFAULT NULL,
  `treatment_supporter_name` varchar(255) DEFAULT NULL,
  `treatment_supporter_relationship` varchar(255) DEFAULT NULL,
  `treatment_supporter_address` varchar(255) DEFAULT NULL,
  `treatment_supporter_telephone_number` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `upn` (`upn`),
  UNIQUE KEY `arvid` (`arvid`),
  UNIQUE KEY `vfcc` (`vfcc`),
  KEY `patients_education_id_fkey` (`education_id`),
  KEY `patients_inactive_reason_id_fkey` (`inactive_reason_id`),
  KEY `patients_location_id_fkey` (`location_id`),
  KEY `patients_marital_status_id_fkey` (`marital_status_id`),
  KEY `patients_occupation_id_fkey` (`occupation_id`),
  KEY `patients_vf_testing_site_fkey` (`vf_testing_site`),
  CONSTRAINT `patients_vf_testing_site_fkey` FOREIGN KEY (`vf_testing_site`) REFERENCES `vf_testing_sites` (`site_code`),
  CONSTRAINT `patients_education_id_fkey` FOREIGN KEY (`education_id`) REFERENCES `educations` (`id`),
  CONSTRAINT `patients_inactive_reason_id_fkey` FOREIGN KEY (`inactive_reason_id`) REFERENCES `inactive_reasons` (`id`),
  CONSTRAINT `patients_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `patients_marital_status_id_fkey` FOREIGN KEY (`marital_status_id`) REFERENCES `marital_statuses` (`id`),
  CONSTRAINT `patients_occupation_id_fkey` FOREIGN KEY (`occupation_id`) REFERENCES `occupations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `acos`;
CREATE TABLE `acos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rght` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `marital_statuses`;
CREATE TABLE `marital_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

LOCK TABLES `marital_statuses` WRITE;
INSERT INTO `marital_statuses` VALUES (0,'Single/Never married',NULL,NULL);
INSERT INTO `marital_statuses` VALUES (1,'Married, monogamous',NULL,NULL);
INSERT INTO `marital_statuses` VALUES (2,'Married, polygamous',NULL,NULL);
INSERT INTO `marital_statuses` VALUES (3,'Cohabiting',NULL,NULL);
INSERT INTO `marital_statuses` VALUES (4,'Divorced/Separated',NULL,NULL);
INSERT INTO `marital_statuses` VALUES (5,'Widowed',NULL,NULL);
UNLOCK TABLES;

DROP TABLE IF EXISTS `result_values`;
CREATE TABLE `result_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `result_id` int(11) NOT NULL,
  `value_DECIMAL` double DEFAULT NULL,
  `value_TEXT` varchar(255) DEFAULT NULL,
  `value_lookup` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;