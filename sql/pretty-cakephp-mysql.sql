# **IMPORTANT: Run the following first to get MySQL to accept '0' as a valid value in an autoincrement column:
# SET GLOBAL sql_mode='NO_AUTO_VALUE_ON_ZERO';
# SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
# (We *really* ought to fix this sometime...)

CREATE SCHEMA `public` DEFAULT CHARACTER SET utf8 ;
USE `public`;

# Tables
CREATE TABLE acos (
    id INT NOT NULL AUTO_INCREMENT,
    parent_id INT,
    model VARCHAR(255) DEFAULT NULL,
    foreign_key INT,
    alias VARCHAR(255) DEFAULT NULL,
    lft INT,
    rght INT,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_groups (
    id INT NOT NULL AUTO_INCREMENT,
    archive_id INT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_name VARCHAR(255),
    archive_description VARCHAR(255),
    archive_created TIMESTAMP,
    archive_modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_medical_informations (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    archive_reason VARCHAR(255),
    archive_pid INT NOT NULL,
    archive_patient_source_id INT,
    archive_funding_id INT,
    archive_hiv_positive_date DATE,
    archive_hiv_positive_test_location_id INT,
    archive_hiv_positive_clinic_start_date DATE,
    archive_hiv_positive_who_stage INT,
    archive_art_naive BOOLEAN,
    archive_art_service_type_id INT,
    archive_art_starting_regimen_id INT,
    archive_art_start_date DATE,
    archive_art_eligibility_date DATE,
    archive_art_indication_id INT,
    archive_transfer_in_date DATE,
    archive_transfer_in_district_id INT,
    archive_transfer_in_facility TEXT,
    archive_transfer_out_date DATE,
    archive_date_pep_start DATE,
    archive_pep_reason_id INT,
    archive_art_eligible_who_stage INT,
    archive_art_eligible_cd4 INT,
    archive_art_start_weight INT,
    archive_art_start_height INT,
    archive_art_start_who_stage INT,
    archive_art_second_start_date DATE,
    archive_art_second_line_reason_id INT,
    archive_drug_allergies VARCHAR(255),
    archive_created TIMESTAMP,
    archive_modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_patients (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    archive_reason VARCHAR(255),
    archive_pid INT NOT NULL,
    archive_upn VARCHAR(255),
    archive_arvid VARCHAR(255),
    archive_vfcc VARCHAR(255),
    archive_surname VARCHAR(255) NOT NULL,
    archive_forenames VARCHAR(255) NOT NULL,
    archive_date_of_birth DATE,
    archive_year_of_birth INT,
    archive_sex VARCHAR(255),
    archive_mother VARCHAR(255),
    archive_occupation_id INT,
    archive_education_id INT,
    archive_marital_status_id INT,
    archive_telephone_number VARCHAR(255),
    archive_treatment_supporter TEXT,
    archive_location_id INT,
    archive_village VARCHAR(255),
    archive_home VARCHAR(255),
    archive_nearest_church VARCHAR(255),
    archive_nearest_school VARCHAR(255),
    archive_nearest_health_centre VARCHAR(255),
    archive_nearest_major_landmark VARCHAR(255),
    archive_vf_testing_site INT,
    archive_status BOOLEAN NOT NULL,
    archive_inactive_reason_id INT,
    archive_status_timestamp DATE,
    archive_treatment_supporter_name VARCHAR(255),
    archive_treatment_supporter_relationship VARCHAR(255),
    archive_treatment_supporter_address VARCHAR(255),
    archive_treatment_supporter_telephone_number VARCHAR(255),
    archive_created TIMESTAMP,
    archive_modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_result_lookups (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_id INT,
    archive_test_id INT NOT NULL,
    archive_value VARCHAR(255) NOT NULL,
    archive_description VARCHAR(255),
    archive_comment VARCHAR(255),
    archive_user_id INT NOT NULL,
    archive_modified TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_result_values (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_id INT NOT NULL,
    archive_result_id INT NOT NULL,
    archive_value_DECIMAL DOUBLE PRECISION,
    archive_value_TEXT VARCHAR(255),
    archive_value_lookup VARCHAR(255),
    archive_user_id INT NOT NULL,
    archive_created TIMESTAMP NOT NULL,
    archive_modified TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_results (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_id INT NOT NULL,
    archive_pid INT NOT NULL,
    archive_test_id INT NOT NULL,
    archive_test_performed TIMESTAMP,
    archive_created TIMESTAMP NOT NULL,
    archive_modified TIMESTAMP NOT NULL,
    archive_requesting_clinician VARCHAR(255),
    archive_user_id INT NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_tests (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_id INT,
    archive_name VARCHAR(255) NOT NULL,
    archive_abbreiviation VARCHAR(255),
    archive_type VARCHAR(255) NOT NULL,
    archive_upper_limit DOUBLE PRECISION,
    archive_lower_limit DOUBLE PRECISION,
    archive_description VARCHAR(255),
    archive_comment VARCHAR(255),
    archive_active BOOLEAN DEFAULT true,
    archive_user_id INT NOT NULL,
    archive_modified TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE archive_users (
    id INT NOT NULL AUTO_INCREMENT,
    archive_id INT,
    user_id INT NOT NULL,
    created TIMESTAMP,
    archive_reason VARCHAR(255),
    archive_username VARCHAR(255) NOT NULL,
    archive_password VARCHAR(255) NOT NULL,
    archive_group_id INT NOT NULL,
    archive_name VARCHAR(255),
    archive_created TIMESTAMP,
    archive_modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE aros (
    id INT NOT NULL AUTO_INCREMENT,
    parent_id INT,
    model VARCHAR(255) DEFAULT NULL,
    foreign_key INT,
    alias VARCHAR(255) DEFAULT NULL,
    lft INT,
    rght INT,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE aros_acos (
    id INT NOT NULL AUTO_INCREMENT,
    aro_id INT NOT NULL,
    aco_id INT NOT NULL,
    _create VARCHAR(2) DEFAULT '0' NOT NULL,
    _read VARCHAR(2) DEFAULT '0' NOT NULL,
    _update VARCHAR(2) DEFAULT '0' NOT NULL,
    _delete VARCHAR(2) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_indications (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_interruption_reasons (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_interruptions (
    id INT NOT NULL AUTO_INCREMENT,
    pid INT NOT NULL,
    interruption_date DATE NOT NULL,
    art_interruption_reason_id INT NOT NULL,
    restart_date DATE,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_regimens (
    id INT NOT NULL AUTO_INCREMENT,
    pid INT NOT NULL,
    regimen_id INT NOT NULL,
    art_line INT NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_second_line_reasons (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_service_types (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_substitution_reasons (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE art_substitutions (
    id INT NOT NULL AUTO_INCREMENT,
    pid INT NOT NULL,
    regimen_id INT NOT NULL,
    art_substitution_reason_id INT NOT NULL,
    art_line INT NOT NULL,
    date DATE,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE educations (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE fundings (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE groups (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    description VARCHAR(255),
    created TIMESTAMP,
    modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE inactive_reasons (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE locations (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id INT,
    tree_left INT,
    tree_right INT,
    vf_code INT,
    longitude DOUBLE PRECISION,
    latitude DOUBLE PRECISION,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE marital_statuses (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE medical_informations (
    pid INT NOT NULL,
    patient_source_id INT,
    funding_id INT,
    hiv_positive_date DATE,
    hiv_positive_test_location_id INT,
    hiv_positive_clinic_start_date DATE,
    hiv_positive_who_stage INT,
    art_naive BOOLEAN,
    art_service_type_id INT,
    art_first_start_date DATE,
    art_eligibility_date DATE,
    art_indication_id INT,
    transfer_in_date DATE,
    transfer_in_district_id INT,
    transfer_in_facility VARCHAR(255),
    transfer_out_date DATE,
    transfer_out_event TEXT,
    DATE_pep_start DATE,
    pep_reason_id INT,
    art_eligible_who_stage INT,
    art_eligible_cd4 INT,
    art_start_weight DECIMAL,
    art_start_height DECIMAL,
    art_start_who_stage INT,
    art_second_start_date DATE,
    art_second_line_reason_id INT,
    drug_allergies VARCHAR(255),
    user_id INT,
    created TIMESTAMP,
    modified TIMESTAMP,
	PRIMARY KEY (pid)
) ENGINE=InnoDB;

CREATE TABLE occupations (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE patient_sources (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE patients (
    pid INT NOT NULL,
    upn VARCHAR(255) NOT NULL UNIQUE,
    old_upn VARCHAR(255),
    arvid VARCHAR(255) UNIQUE,
    vfcc VARCHAR(255) UNIQUE,
    surname VARCHAR(255) NOT NULL,
    forenames VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    year_of_birth INT,
    sex VARCHAR(255),
    mother VARCHAR(255),
    occupation_id INT,
    education_id INT,
    marital_status_id INT,
    telephone_number VARCHAR(255),
    location_id INT,
    village VARCHAR(255),
    home VARCHAR(255),
    nearest_church VARCHAR(255),
    nearest_school VARCHAR(255),
    nearest_health_centre VARCHAR(255),
    nearest_major_landmark VARCHAR(255),
    vf_testing_site INT,
    status BOOLEAN DEFAULT TRUE NOT NULL,
    inactive_reason_id INT,
    status_timestamp DATE,
    treatment_supporter_name VARCHAR(255),
    treatment_supporter_relationship VARCHAR(255),
    treatment_supporter_address VARCHAR(255),
    treatment_supporter_telephone_number VARCHAR(255),
    user_id INT,
    created TIMESTAMP,
    modified TIMESTAMP,
	PRIMARY KEY (pid)
) ENGINE=InnoDB;

CREATE TABLE pep_reasons (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE regimens (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255),
    comment VARCHAR(255),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE result_lookups (
    id INT NOT NULL AUTO_INCREMENT,
    test_id INT NOT NULL,
    value VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    comment VARCHAR(255),
    user_id INT NOT NULL,
    modified TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE result_values (
    id INT NOT NULL AUTO_INCREMENT,
    result_id INT NOT NULL,
    value_DECIMAL DOUBLE PRECISION,
    value_TEXT VARCHAR(255),
    value_lookup INT,
    user_id INT NOT NULL,
    created TIMESTAMP NOT NULL,
    modified TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE results (
    id INT NOT NULL AUTO_INCREMENT,
    pid INT NOT NULL,
    test_id INT NOT NULL,
    test_performed TIMESTAMP,
    created TIMESTAMP NOT NULL,
    modified TIMESTAMP NOT NULL,
    requesting_clinician VARCHAR(255),
    user_id INT NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE second_line_reasons (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    comment VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE tests (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    abbreiviation VARCHAR(255),
    type VARCHAR(255) NOT NULL,
    upper_limit DOUBLE PRECISION,
    lower_limit DOUBLE PRECISION,
    description VARCHAR(255),
    comment VARCHAR(255),
    active BOOLEAN DEFAULT true,
    user_id INT NOT NULL,
    modified TIMESTAMP NOT NULL,
    units VARCHAR(255),
    multival BOOLEAN,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    group_id INT NOT NULL,
    name VARCHAR(255),
    created TIMESTAMP,
    modified TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE vf_testing_sites (
    site_code INT NOT NULL AUTO_INCREMENT,
    site_name VARCHAR(255) NOT NULL UNIQUE,
    type VARCHAR(255) NOT NULL,
    location_id INT NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
	PRIMARY KEY (site_code)
) ENGINE=InnoDB;

# Initial data
INSERT INTO aros VALUES ('3',	'1',	'User',		'1',	\N,	'2',	'3');
INSERT INTO aros VALUES ('10',	'1',	'User',		'7',	\N,	'4',	'5');
INSERT INTO aros VALUES ('5',	\N,		'Group',	'3',	\N,	'13',	'20');
INSERT INTO aros VALUES ('1',	\N,		'Group',	'1',	\N,	'1',	'8');
INSERT INTO aros VALUES ('2',	\N,		'Group',	'2',	\N,	'9',	'12');
INSERT INTO aros VALUES ('4',	'2',	'User',		'2',	\N,	'10',	'11');
INSERT INTO aros VALUES ('6',	'5',	'User',		'3',	\N,	'14',	'15');
INSERT INTO aros VALUES ('7',	'5',	'User',		'4',	\N,	'16',	'17');
INSERT INTO aros VALUES ('8',	'5',	'User',		'5',	\N,	'18',	'19');
INSERT INTO aros VALUES ('9',	'1',	'User',		'6',	\N,	'6',	'7');

# aros_acos is empty

INSERT INTO art_indications VALUES ('1',	'WHO Stage',	\N,	\N);
INSERT INTO art_indications VALUES ('2',	'TLC',			\N,	\N);
INSERT INTO art_indications VALUES ('3',	'CD4 Count',	\N,	\N);

INSERT INTO art_interruption_reasons VALUES ('0',	'Default(1/12)',			\N,	\N);
INSERT INTO art_interruption_reasons VALUES ('1',	'Lost to follow-up (3/12)',	\N,	\N);
INSERT INTO art_interruption_reasons VALUES ('2',	'Stop',						\N,	\N);

# art_interruptions is empty

# art_regimens is empty

INSERT INTO art_second_line_reasons VALUES ('0',	'Clinical treatment failure',	\N,	\N);
INSERT INTO art_second_line_reasons VALUES ('1',	'Immunological failure',		\N,	\N);
INSERT INTO art_second_line_reasons VALUES ('2',	'Virologic failure',			\N,	\N);

INSERT INTO art_service_types VALUES ('0',	'Not on ART',			\N,	\N);
INSERT INTO art_service_types VALUES ('1',	'ART',					\N,	\N);
INSERT INTO art_service_types VALUES ('2',	'PMTCT',				\N,	\N);
INSERT INTO art_service_types VALUES ('3',	'PEP (Assualt)',		\N,	\N);
INSERT INTO art_service_types VALUES ('4',	'PEP (Occupational)',	\N,	\N);
INSERT INTO art_service_types VALUES ('5',	'OI Only',				\N,	\N);

INSERT INTO art_substitution_reasons VALUES ('1',	'Toxicity/Side effects',	\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('2',	'Pregnancy',				\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('3',	'Risk of pregnancy',		\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('4',	'Due to new TB',			\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('5',	'New drug available',		\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('6',	'Drug out of stock',		\N,	\N);
INSERT INTO art_substitution_reasons VALUES ('7',	'Other',					\N,	\N);

# art_substitutions is empty

INSERT INTO educations VALUES ('0',	'None',					\N,	\N);
INSERT INTO educations VALUES ('1',	'Some primary',			\N,	\N);
INSERT INTO educations VALUES ('2',	'Some secondary',		\N,	\N);
INSERT INTO educations VALUES ('3',	'Some Post secondary',	\N,	\N);

INSERT INTO fundings VALUES ('1',	'GOK/NASCOP',	\N,	\N);
INSERT INTO fundings VALUES ('2',	'USA/PEPFAR',	\N,	\N);

INSERT INTO groups VALUES ('1',	'admin',	\N,								'2009-07-10 21:35:23',	'2009-07-10 21:35:23');
INSERT INTO groups VALUES ('2',	'user',		\N,								'2009-07-10 21:35:27',	'2009-07-10 21:35:27');
INSERT INTO groups VALUES ('3',	'data',		'Group for mass data entry',	'2010-04-11 21:37:20',	'2010-04-11 21:37:20');

INSERT INTO inactive_reasons VALUES ('0',	'None',							\N,	\N);
INSERT INTO inactive_reasons VALUES ('1',	'Default (1 month)',			\N,	\N);
INSERT INTO inactive_reasons VALUES ('2',	'Lost to Follow Up (3 months)',	\N,	\N);
INSERT INTO inactive_reasons VALUES ('3',	'Stop',							\N,	\N);
INSERT INTO inactive_reasons VALUES ('4',	'Deceased',						\N,	\N);
INSERT INTO inactive_reasons VALUES ('5',	'PEP End',						\N,	\N);
INSERT INTO inactive_reasons VALUES ('6',	'PMTCT End',					\N,	\N);
INSERT INTO inactive_reasons VALUES ('7',	'Lost to Follow-up',			\N,	\N);
INSERT INTO inactive_reasons VALUES ('8',	'Transfer Out',					\N,	\N);
INSERT INTO inactive_reasons VALUES ('9',	'Stopped by Physician',			\N,	\N);
INSERT INTO inactive_reasons VALUES ('10',	'Stopped as Duplicate Record',	\N,	\N);

INSERT INTO locations VALUES ('2',	'Central',			'1',	'2',	'3',	'1',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('3',	'Coast',			'1',	'4',	'5',	'2',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('4',	'Eastern',			'1',	'6',	'7',	'3',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('33',	'Shibuli',			'27',	'46',	'47',	'4',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('5',	'Nairobi Area',		'1',	'8',	'9',	'5',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('6',	'North-Eastern',	'1',	'10',	'11',	'6',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('7',	'Nyanza',			'1',	'12',	'13',	'7',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('8',	'Rift Valley',		'1',	'14',	'15',	'8',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('28',	'East Butsotso',	'25',	'53',	'60',	'3',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('10',	'Bungoma',			'9',	'17',	'18',	'1',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('13',	'Butere',			'9',	'75',	'76',	'4',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('14',	'Lugari',			'9',	'77',	'78',	'5',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('11',	'Busia',			'9',	'19',	'20',	'2',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('22',	'Shinyalu',			'12',	'30',	'31',	'5',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('15',	'Teso',				'9',	'79',	'80',	'6',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('16',	'Vihiga',			'9',	'81',	'82',	'7',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('38',	'Indangalasia',		'28',	'58',	'59',	'9',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('17',	'Mount Elgon',		'9',	'83',	'84',	'8',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('12',	'Kakamega',			'9',	'21',	'74',	'3',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('1',	'Kenya',			\N,		'1',	'86',	\N,		\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('9',	'Western',			'1',	'16',	'85',	'9',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('25',	'Lurambi',			'12',	'36',	'73',	'8',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('29',	'North Butsotso',	'25',	'61',	'72',	'4',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('34',	'Eshisuru',			'27',	'48',	'49',	'5',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('30',	'Matioli',			'26',	'38',	'39',	'1',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('23',	'Malava',			'12',	'32',	'33',	'6',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('43',	'Mathia',			'29',	'70',	'71',	'14',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('26',	'South Butsotso',	'25',	'37',	'42',	'1',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('24',	'Mumias',			'12',	'34',	'35',	'7',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('18',	'Butere',			'12',	'22',	'23',	'1',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('39',	'Esumeyia',			'29',	'62',	'63',	'10',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('27',	'Central Butsotso',	'25',	'43',	'52',	'2',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('35',	'Shiyunzu',			'27',	'50',	'51',	'6',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('31',	'Emukaya',			'26',	'40',	'41',	'2',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('19',	'Ikolomani',		'12',	'24',	'25',	'2',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('40',	'Shikomari',		'29',	'64',	'65',	'11',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('20',	'Khwisero',			'12',	'26',	'27',	'3',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('36',	'Murumba',			'28',	'54',	'55',	'7',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('21',	'Lugari',			'12',	'28',	'29',	'4',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('32',	'Shiveye',			'27',	'44',	'45',	'3',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('41',	'Shinoyi',			'29',	'66',	'67',	'12',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('37',	'Shirakalu',		'28',	'56',	'57',	'8',	\N,	\N,	\N,	\N);
INSERT INTO locations VALUES ('42',	'Ingotse',			'29',	'68',	'69',	'13',	\N,	\N,	\N,	\N);

INSERT INTO marital_statuses VALUES ('0',	'Single/Never married',	\N,	\N);
INSERT INTO marital_statuses VALUES ('1',	'Married, monogamous',	\N,	\N);
INSERT INTO marital_statuses VALUES ('2',	'Married, polygamous',	\N,	\N);
INSERT INTO marital_statuses VALUES ('3',	'Cohabiting',			\N,	\N);
INSERT INTO marital_statuses VALUES ('4',	'Divorced/Separated',	\N,	\N);
INSERT INTO marital_statuses VALUES ('5',	'Widowed',				\N,	\N);

# medical_informations is empty

INSERT INTO occupations VALUES ('0',	'None',			\N,	\N);
INSERT INTO occupations VALUES ('1',	'Unskilled',	\N,	\N);
INSERT INTO occupations VALUES ('2',	'Skilled',		\N,	\N);
INSERT INTO occupations VALUES ('3',	'Professional',	\N,	\N);
INSERT INTO occupations VALUES ('4',	'Student',		\N,	\N);

INSERT INTO patient_sources VALUES ('1',	'PMTCT',				\N,	\N);
INSERT INTO patient_sources VALUES ('2',	'Inpatient',			\N,	\N);
INSERT INTO patient_sources VALUES ('3',	'VCT',					\N,	\N);
INSERT INTO patient_sources VALUES ('4',	'Child Welfare Clinic',	\N,	\N);
INSERT INTO patient_sources VALUES ('5',	'TB OPD',				\N,	\N);
INSERT INTO patient_sources VALUES ('6',	'VF',					\N,	\N);
INSERT INTO patient_sources VALUES ('7',	'OPD ',					\N,	\N);
INSERT INTO patient_sources VALUES ('8',	'PITC',					\N,	\N);
INSERT INTO patient_sources VALUES ('9',	'Other',				\N,	\N);

# patients is empty

INSERT INTO pep_reasons VALUES ('1',	'Sexual assault',			\N,	\N);
INSERT INTO pep_reasons VALUES ('2',	'Occupational exposure',	\N,	\N);
INSERT INTO pep_reasons VALUES ('3',	'Others',					\N,	\N);

INSERT INTO regimens VALUES ('1',	'1A', 		'(D4T30/3TC/NVP)',	'1st Line');
INSERT INTO regimens VALUES ('2',	'2A', 		'(D4T30/3TC/EFV)',	'1st Line');
INSERT INTO regimens VALUES ('3',	'3A', 		'(AZT/3TC/EFV)',	'1st Line');
INSERT INTO regimens VALUES ('4',	'3B', 		'(AZT/3TC/NVP)',	'1st Line');
INSERT INTO regimens VALUES ('5',	'R66', 		'(TDF/3FC/NVP)',	'2nd Line');
INSERT INTO regimens VALUES ('6',	'R67', 		'(ABC/DDI/LPVR)',	'2nd Line');
INSERT INTO regimens VALUES ('7',	'PEP1', 	'(AZT/3TC)',		'PEP');
INSERT INTO regimens VALUES ('8',	'Other',	'Other',			\N);

INSERT INTO result_lookups VALUES ('1',	'1',	'A',	'Arrived',											\N,	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('2',	'1',	'S',	'Seen',												\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('3',	'1',	'DNA',	'Did Not Attend',									\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('4',	'6',	'1',	'Stage 1',											\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('5',	'6',	'2',	'Stage 2',											\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('6',	'6',	'3',	'Stage 3',											\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('7',	'6',	'4',	'Stage 4',											\N,	'1',	'2009-07-19 22:38:59');
INSERT INTO result_lookups VALUES ('8',	'7',	'N',	'No',												\N,	'1',	'2009-07-19 22:41:43');
INSERT INTO result_lookups VALUES ('9',	'7',	'Y',	'Yes',												\N,	'1',	'2009-07-19 22:42:04');
INSERT INTO result_lookups VALUES ('10',	'9',	'Y',	'Yes',												\N,	'1',	'2009-07-19 22:44:48');
INSERT INTO result_lookups VALUES ('11',	'9',	'N',	'No',												\N,	'1',	'2009-07-19 22:44:58');
INSERT INTO result_lookups VALUES ('12',	'10',	'1',	'No Signs',											\N,	'1',	'2009-07-19 22:46:21');
INSERT INTO result_lookups VALUES ('13',	'10',	'2',	'TB Suspected',										\N,	'1',	'2009-07-19 22:46:31');
INSERT INTO result_lookups VALUES ('14',	'10',	'3',	'Receiving TB Treatment',							\N,	'1',	'2009-07-19 22:46:45');
INSERT INTO result_lookups VALUES ('15',	'11',	'1',	'Herpes Zoster',									\N,	'1',	'2009-07-19 22:48:32');
INSERT INTO result_lookups VALUES ('16',	'11',	'2',	'Pneumonia',										\N,	'1',	'2009-07-19 22:48:41');
INSERT INTO result_lookups VALUES ('17',	'11',	'3',	'Dementia / Encephalitis',							\N,	'1',	'2009-07-19 22:48:55');
INSERT INTO result_lookups VALUES ('18',	'11',	'4',	'Thrush',											\N,	'1',	'2009-07-19 22:49:36');
INSERT INTO result_lookups VALUES ('19',	'11',	'5',	'Ulcers',											\N,	'1',	'2009-07-19 22:51:10');
INSERT INTO result_lookups VALUES ('20',	'11',	'6',	'Fever',											\N,	'1',	'2009-07-19 22:51:20');
INSERT INTO result_lookups VALUES ('21',	'11',	'7',	'Cough',											\N,	'1',	'2009-07-19 22:51:28');
INSERT INTO result_lookups VALUES ('22',	'11',	'8',	'Difficulty Breathing',								\N,	'1',	'2009-07-19 22:51:39');
INSERT INTO result_lookups VALUES ('23',	'11',	'9',	'IRIS',												\N,	'1',	'2009-07-19 22:52:00');
INSERT INTO result_lookups VALUES ('24',	'11',	'10',	'Weight Loss',										\N,	'1',	'2009-07-19 22:52:10');
INSERT INTO result_lookups VALUES ('25',	'11',	'11',	'Urethral Discharge',								\N,	'1',	'2009-07-19 22:52:19');
INSERT INTO result_lookups VALUES ('26',	'11',	'12',	'Pelvic Inflammatory Disease',						\N,	'1',	'2009-07-19 22:52:32');
INSERT INTO result_lookups VALUES ('27',	'11',	'13',	'Genital Ulcerative Disease',						\N,	'1',	'2009-07-19 22:52:48');
INSERT INTO result_lookups VALUES ('28',	'14',	'1',	'Peripheral Neuropathy',							\N,	'1',	'2009-07-19 22:53:46');
INSERT INTO result_lookups VALUES ('29',	'14',	'2',	'Rash',												\N,	'1',	'2009-07-19 22:53:53');
INSERT INTO result_lookups VALUES ('30',	'14',	'3',	'Anaemia',											\N,	'1',	'2009-07-19 22:54:00');
INSERT INTO result_lookups VALUES ('31',	'14',	'4',	'Pancreatitis',										\N,	'1',	'2009-07-19 22:54:09');
INSERT INTO result_lookups VALUES ('32',	'14',	'5',	'Jaundice',											\N,	'1',	'2009-07-19 22:54:19');
INSERT INTO result_lookups VALUES ('33',	'14',	'6',	'Fat Redistribution',								\N,	'1',	'2009-07-19 22:54:31');
INSERT INTO result_lookups VALUES ('34',	'14',	'7',	'Hypersensitivity',									\N,	'1',	'2009-07-19 22:54:41');
INSERT INTO result_lookups VALUES ('35',	'14',	'8',	'Hepatotoxicity',									\N,	'1',	'2009-07-19 22:54:51');
INSERT INTO result_lookups VALUES ('36',	'14',	'9',	'CNS Symptoms',										\N,	'1',	'2009-07-19 22:55:10');
INSERT INTO result_lookups VALUES ('37',	'15',	'Y',	'Yes',												\N,	'1',	'2009-07-19 22:56:30');
INSERT INTO result_lookups VALUES ('38',	'15',	'YS',	'Yes (SA)',											\N,	'1',	'2009-07-19 22:56:30');
INSERT INTO result_lookups VALUES ('39',	'15',	'YU',	'Yes (UA)',											\N,	'1',	'2009-07-19 22:56:46');
INSERT INTO result_lookups VALUES ('40',	'15',	'N',	'No',												\N,	'1',	'2009-07-19 22:56:54');
INSERT INTO result_lookups VALUES ('41',	'16',	'Y',	'Yes',												\N,	'1',	'2009-07-19 22:56:30');
INSERT INTO result_lookups VALUES ('42',	'16',	'YS',	'Yes (SA)',											\N,			'1',	'2009-07-19 22:57:34');
INSERT INTO result_lookups VALUES ('43',	'16',	'YU',	'Yes (UA)',											\N,			'1',	'2009-07-19 22:57:46');
INSERT INTO result_lookups VALUES ('44',	'16',	'N',	'No',												\N,			'1',	'2009-07-19 22:58:04');
INSERT INTO result_lookups VALUES ('45',	'20',	'1A',	'1A (D4T30/3TC/NVP)',								'1st Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('46',	'20',	'2A',	'2A (D4T30/3TC/EFV)',								'1st Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('47',	'20',	'3A',	'3A (AZT/3TC/EFV)',									'1st Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('48',	'20',	'3B',	'3B (AZT/3TC/NVP)',									'1st Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('49',	'20',	'R66',	'R66 (TDF/3FC/NVP)',								'2nd Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('50',	'20',	'R67',	'R67 (ABC/DDI/LPVR)',								'2nd Line',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('51',	'20',	'PEP1',	'PEP1 (AZT/3TC)',									'PEP',		'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('52',	'20',	'O',	'Other',											'Other',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('53',	'20',	'U',	'Unknown',											'Unknown',	'1',	'2009-07-19 22:38:09');
INSERT INTO result_lookups VALUES ('54',	'19',	'Y',	'Yes',												\N,	'1',	'2009-07-19 22:56:30');
INSERT INTO result_lookups VALUES ('55',	'19',	'YS',	'Yes (SA)',											\N,	'1',	'2009-07-19 23:00:35');
INSERT INTO result_lookups VALUES ('56',	'19',	'YU',	'Yes (UA)',											\N,	'1',	'2009-07-19 23:00:44');
INSERT INTO result_lookups VALUES ('57',	'19',	'N',	'No',												\N,	'1',	'2009-07-19 23:00:52');
INSERT INTO result_lookups VALUES ('58',	'25',	'1',	'Basic HIV Education, transmission',				\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('59',	'25',	'2',	'Prevention: abstinenece, safer sex, condoms',		\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('60',	'25',	'3',	'Prevention: household precautions, what is safe',	\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('61',	'25',	'4',	'Post-test counselling: implications of results',	\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('62',	'25',	'5',	'Positive living',									\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('63',	'25',	'6',	'Testing partners-Discordants',						\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('64',	'25',	'7',	'Disclosure',										\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('65',	'25',	'8',	'To whom disclosed',								\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('66',	'25',	'9',	'Family/living situation',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('67',	'25',	'10',	'Shared confidentiality',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('68',	'25',	'11',	'Reproductive choices, prevention MTCT',			\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('69',	'25',	'12',	'Progression of disease',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('70',	'25',	'13',	'Available treatment/prophylaxis',					\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('71',	'25',	'14',	'Follow-up appointments, clinical team',			\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('72',	'25',	'15',	'CTX, prophylaxis',									\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('73',	'25',	'16',	'ART - educate on essentials (locally adapted)',	\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('74',	'25',	'17',	'Why complete adherence needed',					\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('75',	'25',	'18',	'Adherence preparation',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('76',	'25',	'19',	'Indicate when READY for ART',						\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('77',	'25',	'20',	'Explain dose, when to take',						\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('78',	'25',	'21',	'What can occur, how to manage SEs',				\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('79',	'25',	'22',	'What to do if one forgets dose',					\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('80',	'25',	'23',	'What to do when travelling',						\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('81',	'25',	'24',	'Adherence plan (schedule, aids, explain diary)',	\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('82',	'25',	'25',	'Treatment supporter preparation',					\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('83',	'25',	'26',	'Which doses, why missed',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('84',	'25',	'27',	'ARV support group',								\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('85',	'25',	'28',	'How to contact clinic',							\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('86',	'25',	'29',	'Symptom management/palliative care at home',		\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('87',	'25',	'30',	'Caregiver booklet',								\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('88',	'25',	'31',	'Home-based care',									\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('89',	'25',	'32',	'Support groups',									\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('90',	'25',	'33',	'Community support',								\N,	'1',	'2009-07-19 23:04:20');
INSERT INTO result_lookups VALUES ('91',	'17',	'1',	'Amoxicillin',										\N,	'1',	'2010-04-13 20:26:53');
INSERT INTO result_lookups VALUES ('93',	'17',	'2',	'Ciprofloxacin',									\N,	'1',	'2010-04-13 20:28:05');
INSERT INTO result_lookups VALUES ('94',	'17',	'3',	'Cotrimoxazole',									\N,	'1',	'2010-04-13 20:28:23');
INSERT INTO result_lookups VALUES ('100',	'12',	'2',	'Diarrhoea (watery)',								\N,	'1',	'2010-04-13 20:34:39');
INSERT INTO result_lookups VALUES ('92',	'17',	'4',	'Doxycycline',										\N,	'1',	'2010-04-13 20:27:50');
INSERT INTO result_lookups VALUES ('95',	'17',	'5',	'Flagyl',											\N,	'1',	'2010-04-13 20:29:57');
INSERT INTO result_lookups VALUES ('101',	'12',	'3',	'Helminthiasis',									\N,	'1',	'2010-04-13 20:34:51');
INSERT INTO result_lookups VALUES ('96',	'17',	'7',	'Piriton',											\N,	'1',	'2010-04-13 20:30:19');
INSERT INTO result_lookups VALUES ('98',	'17',	'6',	'Multivitamins',									\N,	'1',	'2010-04-13 20:30:58');
INSERT INTO result_lookups VALUES ('99',	'12',	'1',	'Diarrhoea (bloody)',								\N,	'1',	'2010-04-13 20:34:21');
INSERT INTO result_lookups VALUES ('102',	'12',	'4',	'Malaria',											\N,	'1',	'2010-04-13 20:35:00');
INSERT INTO result_lookups VALUES ('104',	'12',	'6',	'RTI (upper)',										\N,	'1',	'2010-04-13 20:35:30');
INSERT INTO result_lookups VALUES ('103',	'12',	'5',	'Pneumonia (lower RTI)',							\N,	'1',	'2010-04-13 20:35:19');
INSERT INTO result_lookups VALUES ('105',	'12',	'7',	'Other (please specify)',							\N,	'1',	'2010-04-13 20:37:10');
INSERT INTO result_lookups VALUES ('106',	'17',	'8',	'Paracetamol',										\N,	'1',	'2010-04-14 07:50:41');
INSERT INTO result_lookups VALUES ('107',	'17',	'9',	'Ibuprofen',										\N,	'1',	'2010-04-14 07:50:56');
INSERT INTO result_lookups VALUES ('108',	'17',	'10',	'Metronidazole',									\N,	'1',	'2010-04-14 07:56:51');
INSERT INTO result_lookups VALUES ('109',	'17',	'11',	'Acyclovir',										\N,	'1',	'2010-04-14 07:59:09');
INSERT INTO result_lookups VALUES ('110',	'17',	'12',	'Fluconazole',										\N,	'1',	'2010-04-14 07:59:21');
INSERT INTO result_lookups VALUES ('111',	'17',	'13',	'Ketonazole',										\N,	'1',	'2010-04-14 07:59:50');
INSERT INTO result_lookups VALUES ('112',	'17',	'14',	'Erythromycin',										\N,	'1',	'2010-04-14 10:24:33');
INSERT INTO result_lookups VALUES ('113',	'17',	'15',	'Cefuroxime',										\N,	'1',	'2010-04-14 10:24:51');
INSERT INTO result_lookups VALUES ('97',	'17',	'17',	'Other (please specify)',							\N,	'1',	'2010-04-13 20:30:39');
INSERT INTO result_lookups VALUES ('114',	'17',	'16',	'Nystatin',											\N,	'1',	'2010-04-14 10:25:12');

# result_values is empty

# results is empty

# second_line_reasons is empty

INSERT INTO tests VALUES ('1',	'Clinic Attendance',			'Attendance',				'lookup',		\N,	\N,	'A record of a patients clinic attendance',					\N,	'1',	'1',	'2009-07-19 22:37:59',	\N,		\N);
INSERT INTO tests VALUES ('2',	'Weight',						'Wt',						'DECIMAL',		\N,	\N,	'The patients current weight in kilograms.',				\N,	'1',	'1',	'2009-07-19 22:39:59',	'kg',	\N);
INSERT INTO tests VALUES ('3',	'Height',						'Ht',						'DECIMAL',		\N,	\N,	'The patients current height in metres.',					\N,	'1',	'1',	'2009-07-19 22:40:22',	'm',	\N);
INSERT INTO tests VALUES ('4',	'Temperature',					'Temp',						'DECIMAL',		\N,	\N,	'The patients temperature in degrees Celsius.',				\N,	'1',	'1',	'2009-07-19 22:41:10',	'ºC',	\N);
INSERT INTO tests VALUES ('5',	'Blood Pressure',				'BP',						'TEXT',			\N,	\N,	'The patients blood pressure (systolic/diastolic)',			\N,	'1',	'1',	'2009-07-19 22:41:10',	\N,		\N);
INSERT INTO tests VALUES ('6',	'WHO Stage',					\N,							'lookup',		\N,	\N,	'The patients current WHO Stage (1-4)',						\N,	'1',	'1',	'2009-07-19 22:41:10',	\N,		\N);
INSERT INTO tests VALUES ('7',	'Pregnant',						\N,							'lookup',		\N,	\N,	'Is the patient currently pregnant?',						\N,	'1',	'1',	'2009-07-19 22:41:32',	\N,		\N);
INSERT INTO tests VALUES ('8',	'Last Menstrual Period',		'LMP',						'TEXT',			\N,	\N,	'Date of the patients LMP in the format DD-MM-YYYY',		\N,	'1',	'1',	'2009-07-19 22:43:46',	\N,		\N);
INSERT INTO tests VALUES ('10',	'TB Status',					\N,							'lookup',		\N,	\N,	'The current TB status of the patient.',					\N,	'1',	'1',	'2009-07-19 22:46:10',	\N,		\N);
INSERT INTO tests VALUES ('15',	'Cotrimoxazole Status',			\N,							'lookup',		\N,	\N,	'Is the patient taking cotrimoxazole?',						\N,	'1',	'1',	'2009-07-19 22:56:15',	\N,		\N);
INSERT INTO tests VALUES ('16',	'Fluconazole Status',			\N,							'lookup',		\N,	\N,	'Is the patient taking fluconazole?',						\N,	'1',	'1',	'2009-07-19 22:57:27',	\N,		\N);
INSERT INTO tests VALUES ('19',	'ARV Drug Adherence',			\N,							'lookup',		\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 23:00:28',	\N,		\N);
INSERT INTO tests VALUES ('20',	'ARV Drug Regimen',				\N,							'lookup',		\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 22:59:43',	\N,		\N);
INSERT INTO tests VALUES ('21',	'CD4 Count',					'CD4',						'DECIMAL',		\N,	\N,	'The patients current CD4 count.', 							\N,	'1',	'1',	'2009-07-19 23:01:45',	'/μl',	\N);
INSERT INTO tests VALUES ('22',	'Haemaglobin',					'Hb',						'DECIMAL',		\N,	\N,	'The patients current haemaglobin level.',					\N,	'1',	'1',	'2009-07-19 23:02:16',	'g/dL',	\N);
INSERT INTO tests VALUES ('23',	'White Cell Count',				'WCC',						'DECIMAL',		\N,	\N,	'The patients current white cell count.',					\N,	'1',	'1',	'2009-07-19 23:03:10',	'x10^9',\N);
INSERT INTO tests VALUES ('24',	'ALT',							'ALT',						'DECIMAL',		\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 23:03:50',	'IU',	\N);
INSERT INTO tests VALUES ('27',	'Counselling',					\N,							'lookup',		\N,	\N,	'Has the patient received any form of counselling?',		\N,	'1',	'1',	'2009-07-19 23:04:24',	\N,		\N);
INSERT INTO tests VALUES ('29',	'Examination Findings',			\N,							'TEXT',			\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 23:05:58',	\N,		\N);
INSERT INTO tests VALUES ('9',	'Family Planning Status',		'FP Status',				'lookup',		\N,	\N,	'Is the patient using any form of contraception?',			\N,	'1',	'1',	'2009-07-19 22:44:36',	\N,		'0');
INSERT INTO tests VALUES ('11',	'Opportunistic Infection',		'Opportunistic Infection',	'lookup',		\N,	\N,	'Does the patient have a new opportunistic infection?',		\N,	'1',	'1',	'2009-07-19 22:48:23',	\N,		'1');
INSERT INTO tests VALUES ('14',	'ART Side Effects',				'ART Side Effects',			'lookup',		\N,	\N,	'Is the patient currently have any side-effects of ARTs?',	\N,	'1',	'1',	'2009-07-19 22:53:32',	\N,		'1');
INSERT INTO tests VALUES ('17',	'Other Medications Dispensed',	'Other Medications',		'lookup',		\N,	\N,	'Have any other drugs been dispensed to the patient?',		\N,	'1',	'1',	'2009-07-19 22:58:40',	\N,		'1');
INSERT INTO tests VALUES ('12',	'Other Medical Conditions',		\N,							'lookup',		\N,	\N,	'Does the patient have any new other medical condition?',	\N,	'1',	'1',	'2009-07-19 22:48:23',	\N,		'1');
INSERT INTO tests VALUES ('13',	'Conditions (others)',			\N,							'TEXT',			\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 22:48:23',	\N,		\N);
INSERT INTO tests VALUES ('18',	'Medications (others)',			\N,							'TEXT',			\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 22:48:23',	\N,		\N);
INSERT INTO tests VALUES ('25',	'Adherence counselling',		\N,							'lookup',		\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 23:04:13',	\N,		'1');
INSERT INTO tests VALUES ('26',	'Refered To',					\N,							'TEXT',			\N,	\N,	\N,															\N,	'1',	'1',	'2009-07-19 23:05:12',	\N,		'0');
INSERT INTO tests VALUES ('28',	'Date Of Next Appointment',		\N,							'TEXT',			\N,	\N,	'The date of next appointment in the format DD-MM-YYYY',	\N,	'1',	'1',	'2009-07-19 23:05:44',	\N,		'0');

INSERT INTO users VALUES ('1',	'admin',	'82bf611c53901f13c54e59f032a4d4714168c505075f7010d05ff2d8062a8c9e',	'1',	\N,	'2009-07-10 21:35:38',	'2009-07-10 21:35:38');
INSERT INTO users VALUES ('2',	'user',		'89ef4f9d082dad635f13d9aab392a2ce41f47dbfd28d783e023ccfd5213a1a67',	'2',	\N,	'2009-07-10 21:35:59',	'2009-07-10 21:35:59');
INSERT INTO users VALUES ('3',	'data',		'78732071c8fa23f1587f71b1bd7169b3e186c978e2cc1cf281580b9a9cad31d7',	'3',	\N,	'2010-04-11 23:29:55',	'2010-04-11 23:29:55');

INSERT INTO vf_testing_sites VALUES ('1',	'Ebukulima',		'Salvation Army',	'30',	'0.19305',	'34.613630000000001');
INSERT INTO vf_testing_sites VALUES ('2',	'Mwiyenga',			'Church',			'30',	'0.20582',	'34.634129999999999');
INSERT INTO vf_testing_sites VALUES ('3',	'Ekapwonje',		'Church',			'31',	'0.21640000000000001',	'34.614130000000003');
INSERT INTO vf_testing_sites VALUES ('4',	'Shianda',			'Church',			'31',	'0.23147000000000001',	'34.620080000000002');
INSERT INTO vf_testing_sites VALUES ('5',	'Sumba',			'Dispensary',		'32',	'0.24218000000000001',	'34.63955');
INSERT INTO vf_testing_sites VALUES ('6',	'Shirembe',			'Dispensary',		'32',	'0.25446999999999997',	'34.621119999999998');
INSERT INTO vf_testing_sites VALUES ('7',	'Ematsayi',			'School',			'32',	'0.27548',	'34.621229999999997');
INSERT INTO vf_testing_sites VALUES ('8',	'Eshikuyu',			'Health Centre',	'33',	'0.26477000000000001',	'34.655900000000003');
INSERT INTO vf_testing_sites VALUES ('9',	'Ibinzo',			'School',			'33',	'0.25659999999999999',	'34.687930000000001');
INSERT INTO vf_testing_sites VALUES ('10',	'Eshisiru',			'District Office',	'34',	'0.28160000000000002',	'34.673400000000001');
INSERT INTO vf_testing_sites VALUES ('11',	'Emusanda',			'Dispensary',		'34',	'0.29325000000000001',	'34.647599999999997');
INSERT INTO vf_testing_sites VALUES ('12',	'Ikonyero',			'Church',			'35',	'0.28343000000000002',	'34.722470000000001');
INSERT INTO vf_testing_sites VALUES ('13',	'Eshiyunzu',		'Church',			'35',	'0.29087000000000002',	'34.70355');
INSERT INTO vf_testing_sites VALUES ('14',	'Murumba',			'Dispensary',		'36',	'0.30314999999999998',	'34.726100000000002');
INSERT INTO vf_testing_sites VALUES ('15',	'Shikoti',			'Church',			'36',	'0.31788',	'34.735930000000003');
INSERT INTO vf_testing_sites VALUES ('16',	'Emukoyani',		'Church',			'37',	'0.32135000000000002',	'34.749470000000002');
INSERT INTO vf_testing_sites VALUES ('17',	'Elukho',			'Church',			'37',	'0.32290000000000002',	'34.75647');
INSERT INTO vf_testing_sites VALUES ('18',	'Emusala',			'Church',			'38',	'0.32965',	'34.780479999999997');
INSERT INTO vf_testing_sites VALUES ('19',	'Emukaba',			'Church',			'38',	'0.34425',	'34.76343');
INSERT INTO vf_testing_sites VALUES ('20',	'Bushibo',			'Church',			'39',	'0.30809999999999998',	'34.686079999999997');
INSERT INTO vf_testing_sites VALUES ('21',	'Emukaya',			'Health Centre',	'39',	'0.31850000000000001',	'34.702669999999998');
INSERT INTO vf_testing_sites VALUES ('22',	'Esumeyia',			'Church',			'39',	'0.31972',	'34.681019999999997');
INSERT INTO vf_testing_sites VALUES ('23',	'Shikomari',		'Church',			'40',	'0.32085000000000002',	'34.644480000000001');
INSERT INTO vf_testing_sites VALUES ('24',	'Gospel Spring',	'Church',			'40',	'0.33844999999999997',	'34.654780000000002');
INSERT INTO vf_testing_sites VALUES ('25',	'Shinoyi',			'Church',			'41',	'0.34401999999999999',	'34.664999999999999');
INSERT INTO vf_testing_sites VALUES ('26',	'Naluchira',		'Church',			'41',	'0.34894999999999998',	'34.694180000000003');
INSERT INTO vf_testing_sites VALUES ('27',	'Ingotse',			'Health Centre',	'42',	'0.35544999999999999',	'34.697879999999998');
INSERT INTO vf_testing_sites VALUES ('28',	'Bushiri',			'Church',			'42',	'0.36499999999999999',	'34.729170000000003');
INSERT INTO vf_testing_sites VALUES ('29',	'Emulama',			'Church',			'43',	'0.37630000000000002',	'34.755450000000003');
INSERT INTO vf_testing_sites VALUES ('30',	'Matiha',			'Church',			'43',	'0.36153000000000002',	'34.76567');
INSERT INTO vf_testing_sites VALUES ('31',	'Shikakala',		'Unknown',			'25',	\N,						\N);

# Foreign keys
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_art_indication_id_fkey FOREIGN KEY (archive_art_indication_id) REFERENCES art_indications(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_art_service_type_id_fkey FOREIGN KEY (archive_art_service_type_id) REFERENCES art_service_types(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_art_starting_regimen__fkey FOREIGN KEY (archive_art_starting_regimen_id) REFERENCES regimens(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_funding_id_fkey FOREIGN KEY (archive_funding_id) REFERENCES fundings(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_hiv_positive_test_loc_fkey FOREIGN KEY (archive_hiv_positive_test_location_id) REFERENCES locations(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_patient_source_id_fkey FOREIGN KEY (archive_patient_source_id) REFERENCES patient_sources(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_pid_fkey FOREIGN KEY (archive_pid) REFERENCES patients(pid);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_archive_transfer_in_district__fkey FOREIGN KEY (archive_transfer_in_district_id) REFERENCES locations(id);
ALTER TABLE archive_medical_informations ADD CONSTRAINT archive_medical_informations_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_education_id_fkey FOREIGN KEY (archive_education_id) REFERENCES educations(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_inactive_reason_id_fkey FOREIGN KEY (archive_inactive_reason_id) REFERENCES inactive_reasons(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_location_id_fkey FOREIGN KEY (archive_location_id) REFERENCES locations(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_marital_status_id_fkey FOREIGN KEY (archive_marital_status_id) REFERENCES marital_statuses(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_occupation_id_fkey FOREIGN KEY (archive_occupation_id) REFERENCES occupations(id);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_archive_vf_testing_site_fkey FOREIGN KEY (archive_vf_testing_site) REFERENCES vf_testing_sites(site_code);
ALTER TABLE archive_patients ADD CONSTRAINT archive_patients_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_art_indication_id_fkey FOREIGN KEY (art_indication_id) REFERENCES art_indications(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_art_service_type_id_fkey FOREIGN KEY (art_service_type_id) REFERENCES art_service_types(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_funding_id_fkey FOREIGN KEY (funding_id) REFERENCES fundings(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_hiv_positive_test_location_id_fkey FOREIGN KEY (hiv_positive_test_location_id) REFERENCES locations(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_patient_source_id_fkey FOREIGN KEY (patient_source_id) REFERENCES patient_sources(id);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_pid_fkey FOREIGN KEY (pid) REFERENCES patients(pid);
ALTER TABLE medical_informations ADD CONSTRAINT medical_informations_transfer_in_district_id_fkey FOREIGN KEY (transfer_in_district_id) REFERENCES locations(id);
ALTER TABLE patients ADD CONSTRAINT patients_education_id_fkey FOREIGN KEY (education_id) REFERENCES educations(id);
ALTER TABLE patients ADD CONSTRAINT patients_inactive_reason_id_fkey FOREIGN KEY (inactive_reason_id) REFERENCES inactive_reasons(id);
ALTER TABLE patients ADD CONSTRAINT patients_location_id_fkey FOREIGN KEY (location_id) REFERENCES locations(id);
ALTER TABLE patients ADD CONSTRAINT patients_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES marital_statuses(id);
ALTER TABLE patients ADD CONSTRAINT patients_occupation_id_fkey FOREIGN KEY (occupation_id) REFERENCES occupations(id);
ALTER TABLE patients ADD CONSTRAINT patients_vf_testing_site_fkey FOREIGN KEY (vf_testing_site) REFERENCES vf_testing_sites(site_code);
ALTER TABLE result_lookups ADD CONSTRAINT result_lookups_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE tests ADD CONSTRAINT tests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE vf_testing_sites ADD CONSTRAINT vf_testing_sites_location_id_fkey FOREIGN KEY (location_id) REFERENCES locations(id);

# Indexes
CREATE UNIQUE INDEX aro_aco_key ON aros_acos(aro_id, aco_id) USING BTREE;