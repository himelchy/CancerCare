-- ============================================================
-- CANCERCARE - DHAKA SEED DATA
-- ============================================================
ROLLBACK;
BEGIN;

-- ============================================================
-- STEP 1: CLEAR EXISTING DATA
-- ============================================================

TRUNCATE TABLE
    blogpost_hospital,
    blogpost_doctor,
    patient_blogpost,
    admin_doctor_assignment,
    doctor_referral,
    patient_stage_diagnosis,
    prescription_medicine,
    prescriptions,
    cancer_medicine,
    hospital_cancer,
    doctor_stage,
    doctor_cancer_specialization,
    doctor_hospital,
    admins,
    blogposts,
    medicines,
    stages,
    cancers,
    patient,
    doctors,
    hospitals,
    users
RESTART IDENTITY CASCADE;


-- ============================================================
-- STEP 2: INSERT USERS
-- ============================================================


-- CancerCare Dhaka Seed Data (REVISED)
-- PostgreSQL seed script for the exact schema supplied by the project.
--
-- IMPORTANT DATA POLICY:
-- * Hospitals/cancer categories/medicine names are based on public or real-world reference data.
-- * Doctor rows contain ONLY the 101 publicly listed doctor names already researched for the project.
-- * There are NO invented/dummy doctor persons.
-- * To avoid falsely presenting private details as real, doctor contact/email/license/fee/experience
--   values are explicitly synthetic demo attributes. They are NOT real credentials or contact details.
-- * Patient/admin data and all clinical transaction records are synthetic demo data.
-- * Cancer recovery_pct and stage success are left NULL because there is no single valid percentage
--   that applies to every cancer/stage. Do not invent clinical outcome statistics.
--
BEGIN;

-- ===============================================================
-- 1. HOSPITALS
-- ===============================================================
INSERT INTO hospitals (hospital_id,hospital_name,registration_no,address,district,area,phone,email,established_year,website,bed_capacity,hospital_type) VALUES
(1,'National Institute of Cancer Research & Hospital (NICRH)','DHK-SEED-001','Mohakhali, TB Gate Road','Dhaka','Mohakhali','+88027913975','info.hospital01@cancercare.local',1965,'https://nicrh.gov.bd/',500,'Government'),
(2,'Ahsania Mission Cancer & General Hospital','DHK-SEED-002','Plot M-1/C, Section-14','Dhaka','Mirpur','+88029127943','info.hospital02@cancercare.local',2014,NULL,300,'NGO'),
(3,'Ahsania Mission Cancer & General Hospital','DHK-SEED-003','Plot 03, Embankment Drive Way, Sector 10','Dhaka','Uttara','+8809612310617','info.hospital03@cancercare.local',2014,NULL,300,'NGO'),
(4,'Bangladesh Cancer Society Hospital & Welfare Home','DHK-SEED-004','Mirpur','Dhaka','Mirpur','+8801763678870','info.hospital04@cancercare.local',1986,NULL,150,'NGO'),
(5,'Bangladesh Specialized Hospital','DHK-SEED-005','21 Shyamoli','Dhaka','Shyamoli','+8809666700100','info.hospital05@cancercare.local',2015,'https://www.bdspecializedhospital.com/',350,'Private'),
(6,'BRB Hospitals Limited','DHK-SEED-006','77/A, East Rajabazar, West Panthapath','Dhaka','Panthapath','+8802222263000','info.hospital06@cancercare.local',2014,'https://brbhospital.com/',350,'Private'),
(7,'Combined Military Hospital (CMH) Dhaka','DHK-SEED-007','Dhaka Cantonment','Dhaka','Cantonment','+88029110345','info.hospital07@cancercare.local',1979,NULL,1000,'Government'),
(8,'Dhaka Medical College Hospital','DHK-SEED-008','Secretariat Road, Shahbag','Dhaka','Shahbag','+880255165088','info.hospital08@cancercare.local',1946,NULL,2600,'Government'),
(9,'Evercare Hospital Dhaka','DHK-SEED-009','Plot 81, Block E, Bashundhara R/A','Dhaka','Bashundhara','+880255037242','info.hospital09@cancercare.local',2005,'https://www.evercarebd.com/',425,'Private'),
(10,'Holy Family Red Crescent Medical College Hospital','DHK-SEED-010','1 Eskaton Garden Road','Dhaka','Eskaton','+880248311721','info.hospital10@cancercare.local',1953,NULL,700,'NGO'),
(11,'Japan Bangladesh Friendship Hospital','DHK-SEED-011','55 Satmasjid Road, Zigatola','Dhaka','Dhanmondi','+8801713443360','info.hospital11@cancercare.local',1994,NULL,250,'Private'),
(12,'Kurmitola General Hospital','DHK-SEED-012','New Airport Road, Cantonment','Dhaka','Cantonment','+880255062388','info.hospital12@cancercare.local',2012,NULL,500,'Government'),
(13,'Lab One Research Institute of Haematology & Hospital','DHK-SEED-013','Green Road','Dhaka','Green Road','+8801922117676','info.hospital13@cancercare.local',2017,NULL,100,'Private'),
(14,'Labaid Cancer Hospital & Super Speciality Centre','DHK-SEED-014','House 06, Road 04','Dhaka','Dhanmondi','+880258610793','info.hospital14@cancercare.local',2022,'https://labaid.com.bd/',150,'Private'),
(15,'Popular Medical College Hospital','DHK-SEED-015','House 08, Road 02, Dhanmondi','Dhaka','Dhanmondi','+8809666787801','info.hospital15@cancercare.local',2010,NULL,500,'Private'),
(16,'Square Hospital Ltd.','DHK-SEED-016','18/F, Bir Uttam Qazi Nuruzzaman Sarak','Dhaka','Panthapath','+8809610010616','info.hospital16@cancercare.local',2006,'https://www.squarehospital.com/',700,'Private'),
(17,'The ENT and Head Neck Cancer Hospital and Institute','DHK-SEED-017','Sher-e-Bangla Nagar','Dhaka','Sher-e-Bangla Nagar','+880258151660','info.hospital17@cancercare.local',2012,NULL,100,'NGO'),
(18,'United Hospital Limited','DHK-SEED-018','Plot 15, Road 71','Dhaka','Gulshan','+88028836444','info.hospital18@cancercare.local',2006,NULL,500,'Private'),
(19,'Delta Hospital Limited','DHK-SEED-019','26/2 Principal Abul Kashem Road','Dhaka','Mirpur','+880244817619','info.hospital19@cancercare.local',2000,NULL,200,'Private'),
(20,'Green Life Hospital Ltd.','DHK-SEED-020','32 Green Road','Dhaka','Dhanmondi','+88029610800','info.hospital20@cancercare.local',2009,NULL,550,'Private'),
(21,'Anwer Khan Modern Medical College Hospital','DHK-SEED-021','House 17, Road 8, Dhanmondi','Dhaka','Dhanmondi','+88029673222','info.hospital21@cancercare.local',2008,NULL,750,'Private'),
(22,'BIRDEM General Hospital','DHK-SEED-022','122 Kazi Nazrul Islam Avenue','Dhaka','Shahbag','+880241060501','info.hospital22@cancercare.local',1980,NULL,600,'Private'),
(23,'Bangladesh Medical University (BMU)','DHK-SEED-023','Shahbag','Dhaka','Shahbag','+880255165001','info.hospital23@cancercare.local',1965,NULL,1500,'Government'),
(24,'Shaheed Suhrawardy Medical College Hospital','DHK-SEED-024','Sher-e-Bangla Nagar','Dhaka','Sher-e-Bangla Nagar','+880255056061','info.hospital24@cancercare.local',2006,NULL,1350,'Government'),
(25,'Bangladesh Medical College Hospital','DHK-SEED-025','House 34, Road 14/A, Dhanmondi','Dhaka','Dhanmondi','+880244812117','info.hospital25@cancercare.local',1986,NULL,500,'Private'),
(26,'Enam Medical College Hospital','DHK-SEED-026','9/3 Parboti Nagar, Thana Road','Dhaka','Savar','+8802223371196','info.hospital26@cancercare.local',2003,'https://emch.com.bd/',1000,'Private'),
(27,'Asgar Ali Hospital','DHK-SEED-027','111/1/A Distillery Road','Dhaka','Gandaria','+880247443135','info.hospital27@cancercare.local',2010,NULL,350,'Private'),
(28,'Ibn Sina Specialized Hospital','DHK-SEED-028','House 68, Road 15/A, Dhanmondi','Dhaka','Dhanmondi','+88029611381','info.hospital28@cancercare.local',1980,'https://ibnsinatrust.com/',250,'Private'),
(29,'Insaf Barakah Kidney & General Hospital','DHK-SEED-029','11 Shaheed Tajuddin Ahmed Sarani','Dhaka','Moghbazar','+880248315871','info.hospital29@cancercare.local',2015,NULL,200,'Private'),
(30,'Aalok Healthcare & Hospital','DHK-SEED-030','House 1 & 3, Road 2, Block B','Dhaka','Mirpur','+880258006861','info.hospital30@cancercare.local',2010,NULL,200,'Private'),
(31,'Islami Bank Specialized & General Hospital','DHK-SEED-031','71-72 VIP Road','Dhaka','Nayapaltan','+880248313312','info.hospital31@cancercare.local',2011,NULL,300,'Private'),
(32,'Shanti Cancer Foundation','DHK-SEED-032','21/12 Block B, Babor Road','Dhaka','Mohammadpur','+8801708521186','info.hospital32@cancercare.local',2006,NULL,100,'NGO'),
(33,'Central Hospital Limited','DHK-SEED-033','2/2 Mirpur Road, Dhanmondi','Dhaka','Dhanmondi','+880248112415','info.hospital33@cancercare.local',1999,NULL,500,'Private'),
(34,'Samorita Hospital Limited','DHK-SEED-034','89/1 Panthapath','Dhaka','Panthapath','+880241010935','info.hospital34@cancercare.local',1984,'https://samoritahospital.org/',250,'Private'),
(35,'Uttara Adhunik Medical College Hospital','DHK-SEED-035','House 34, Road 5, Sector 9','Dhaka','Uttara','+88028963414','info.hospital35@cancercare.local',2003,'https://uamc.edu.bd/',500,'Private'),
(36,'Ad-din Women''''s Medical College & Hospital','DHK-SEED-036','2 Bara Moghbazar','Dhaka','Moghbazar','+88029353391','info.hospital36@cancercare.local',2008,NULL,500,'NGO'),
(37,'Dhaka National Medical College Hospital','DHK-SEED-037','53/1 Johnson Road','Dhaka','Old Dhaka','+880247114256','info.hospital37@cancercare.local',1925,NULL,600,'Private'),
(38,'Mugda Medical College Hospital','DHK-SEED-038','Mugda','Dhaka','Mugda','+880247270000','info.hospital38@cancercare.local',2015,NULL,500,'Government'),
(39,'Sir Salimullah Medical College Mitford Hospital','DHK-SEED-039','Mitford Road, Old Dhaka','Dhaka','Old Dhaka','+88027310466','info.hospital39@cancercare.local',1858,NULL,1200,'Government'),
(40,'AMZ Hospital Ltd.','DHK-SEED-040','Satarkul Road, Badda','Dhaka','Badda','+8809638300088','info.hospital40@cancercare.local',2016,'https://amzhospitalbd.com/',200,'Private');

-- ===============================================================
-- 2. CANCERS
-- ===============================================================
INSERT INTO cancers (cancer_id,cancer_name,recovery_pct,causes) VALUES
(1,'Lip and oral cavity cancer',NULL,'Tobacco, betel quid/areca nut, alcohol, HPV and other carcinogenic exposures.'),
(2,'Salivary gland cancer',NULL,'Risk factors vary by subtype; prior radiation and certain occupational exposures can contribute.'),
(3,'Oropharyngeal cancer',NULL,'Human papillomavirus (HPV), tobacco and alcohol are important risk factors.'),
(4,'Nasopharyngeal cancer',NULL,'EBV infection, family history and certain dietary/environmental exposures are associated.'),
(5,'Hypopharyngeal cancer',NULL,'Tobacco and alcohol are major risk factors.'),
(6,'Esophageal cancer',NULL,'Tobacco, alcohol, obesity, reflux and certain dietary exposures are associated.'),
(7,'Stomach cancer',NULL,'H. pylori infection, smoking, high-salt diets and family history are risk factors.'),
(8,'Colon cancer',NULL,'Age, family history, inherited syndromes, obesity, inactivity and diet are associated.'),
(9,'Rectal cancer',NULL,'Age, family history, inflammatory bowel disease and lifestyle factors are associated.'),
(10,'Anal cancer',NULL,'HPV infection, smoking and immune suppression are important risk factors.'),
(11,'Liver cancer',NULL,'Chronic hepatitis B/C, cirrhosis, alcohol-related liver disease and metabolic liver disease are major risks.'),
(12,'Gallbladder cancer',NULL,'Risk factors include gallstones, chronic gallbladder inflammation and some geographic/genetic factors.'),
(13,'Pancreatic cancer',NULL,'Smoking, obesity, chronic pancreatitis, family history and some inherited syndromes are associated.'),
(14,'Laryngeal cancer',NULL,'Tobacco and alcohol are major risk factors.'),
(15,'Lung cancer',NULL,'Tobacco smoke is the leading risk factor; radon, occupational exposures and air pollution also contribute.'),
(16,'Melanoma of skin',NULL,'Ultraviolet radiation, fair skin, family history and atypical moles are associated.'),
(17,'Non-melanoma skin cancer',NULL,'Ultraviolet radiation, fair skin, immune suppression and some chemical exposures are associated.'),
(18,'Mesothelioma',NULL,'Asbestos exposure is the major established risk factor.'),
(19,'Kaposi sarcoma',NULL,'HHV-8 infection, especially with immune suppression, is a major factor.'),
(20,'Female breast cancer',NULL,'Age, family history, inherited mutations, reproductive/hormonal factors, obesity and alcohol are associated.'),
(21,'Vulvar cancer',NULL,'HPV infection, smoking, immune suppression and chronic vulvar conditions are associated.'),
(22,'Vaginal cancer',NULL,'HPV infection, prior cervical disease and some reproductive exposures are associated.'),
(23,'Cervical cancer',NULL,'Persistent high-risk HPV infection is the major cause.'),
(24,'Endometrial cancer',NULL,'Obesity, unopposed estrogen exposure, age and some hereditary syndromes are associated.'),
(25,'Ovarian cancer',NULL,'Family history, BRCA1/BRCA2 and some reproductive factors are associated.'),
(26,'Penile cancer',NULL,'HPV infection, smoking, phimosis and poor genital hygiene are associated.'),
(27,'Prostate cancer',NULL,'Age, family history, African ancestry and some inherited variants are associated.'),
(28,'Testicular cancer',NULL,'Cryptorchidism, family history and previous testicular cancer are important risk factors.'),
(29,'Kidney cancer',NULL,'Smoking, obesity, hypertension and some hereditary syndromes are associated.'),
(30,'Bladder cancer',NULL,'Smoking and occupational exposure to aromatic amines are major risks.'),
(31,'Brain and central nervous system cancer',NULL,'Risk factors vary; ionizing radiation and some inherited syndromes are established risks for some tumors.'),
(32,'Thyroid cancer',NULL,'Ionizing radiation exposure and certain inherited syndromes increase risk.'),
(33,'Hodgkin lymphoma',NULL,'EBV and immune dysregulation are associated with some cases.'),
(34,'Non-Hodgkin lymphoma',NULL,'Immune suppression, autoimmune disease, some infections and certain exposures are associated.'),
(35,'Multiple myeloma',NULL,'Age, family history and certain environmental/occupational exposures are associated.'),
(36,'Leukaemia',NULL,'Risk factors vary by subtype; ionizing radiation, certain chemicals and some inherited conditions are associated.'),
(37,'Other specified cancers',NULL,'Risk factors depend on the organ and histologic subtype.'),
(38,'Unspecified-site cancer',NULL,'Risk factors depend on the primary site and histologic subtype.');

-- ===============================================================
-- 3. STAGES
-- ===============================================================
-- Stage success intentionally NULL: not a universal clinical statistic.
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (1,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (1,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (1,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (1,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (2,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (2,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (2,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (2,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (3,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (3,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (3,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (3,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (4,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (4,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (4,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (4,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (5,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (5,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (5,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (5,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (6,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (6,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (6,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (6,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (7,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (7,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (7,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (7,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (8,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (8,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (8,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (8,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (9,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (9,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (9,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (9,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (10,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (10,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (10,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (10,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (11,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (11,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (11,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (11,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (12,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (12,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (12,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (12,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (13,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (13,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (13,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (13,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (14,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (14,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (14,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (14,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (15,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (15,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (15,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (15,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (16,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (16,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (16,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (16,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (17,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (17,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (17,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (17,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (18,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (18,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (18,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (18,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (19,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (19,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (19,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (19,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (20,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (20,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (20,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (20,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (21,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (21,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (21,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (21,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (22,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (22,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (22,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (22,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (23,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (23,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (23,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (23,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (24,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (24,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (24,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (24,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (25,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (25,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (25,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (25,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (26,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (26,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (26,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (26,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (27,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (27,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (27,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (27,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (28,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (28,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (28,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (28,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (29,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (29,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (29,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (29,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (30,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (30,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (30,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (30,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (31,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (31,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (31,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (31,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (32,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (32,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (32,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (32,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (33,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (33,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (33,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (33,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (34,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (34,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (34,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (34,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (35,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (35,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (35,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (35,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (36,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (36,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (36,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (36,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (37,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (37,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (37,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (37,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (38,1,NULL,'Usually localized disease; symptoms may be absent or mild.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (38,2,NULL,'More established local disease; symptoms may become more noticeable.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (38,3,NULL,'Locally advanced and/or regional lymph-node involvement may occur.');
INSERT INTO stages (cancer_id,stage_no,success,symptoms) VALUES (38,4,NULL,'Advanced/metastatic disease may involve distant organs; symptoms vary widely.');

-- ===============================================================
-- 4. USERS FOR THE 101 PUBLICLY LISTED DOCTORS
-- ===============================================================
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES
(1,'Prof. Col. Dr. Md. Nasir Uddin','Mahmud','01710000001',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(2,'Prof. Dr. Kazi Manzur','Kader','01710000002',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(3,'Dr. Md. Abu Kawsar','Sarker','01710000003',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(4,'Dr. AKM Minhaj Uddin','Bhuiyan','01710000004',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(5,'Prof. Syed Md. Akram','Hussain','01710000005',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(6,'Prof. Dr. Md. Mofazzel','Hossain','01710000006',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(7,'Prof. Dr. AMM Shariful','Alam','01710000007',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(8,'Dr. Sonia','Rahman','01710000008',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(9,'Prof. Dr. Tapesh Kumar','Paul','01710000009',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(10,'Prof. Dr. Md. Yousuf','Ali','01710000010',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(11,'Prof. Dr. Md. Nizamul','Haque','01710000011',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(12,'Prof. Dr. Md. Yeaqub','Ali','01710000012',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(13,'Prof. Dr. Sk. Golam','Mostofa','01710000013',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(14,'Prof. Dr. Zafor Md.','Masud','01710000014',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(15,'Prof. Dr. Aliya','Shahnaz','01710000015',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(16,'Prof. Dr. Md. Moarraf','Hossen','01710000016',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(17,'Dr. Rowshon Ara','Begum','01710000017',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(18,'Prof. Dr. AFM Anwar','Hossain','01710000018',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(19,'Prof. Dr. Md. Khorshed','Alam','01710000019',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(20,'Dr. Asma','Siddiqua','01710000020',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(21,'Dr. Sadia','Sharmin','01710000021',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(22,'Dr. Ahmed Mizanur','Rahman','01710000022',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(23,'Dr. Hasan Shahriar','Kallol','01710000023',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(24,'Dr. Khandaker ABM Abdullah Al','Hasan','01710000024',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(25,'Dr. Md. Ashikur','Rahman','01710000025',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(26,'Dr. Mohammad Sahajadul','Alam','01710000026',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(27,'Dr. Mahfujul Ahmed','Riad','01710000027',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(28,'Dr. Shahida Alam','Lima','01710000028',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(29,'Dr. Shamsun','Nahar','01710000029',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(30,'Dr. Tannima','Adhikary','01710000030',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(31,'Dr. Md. Salim','Reza','01710000031',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(32,'Dr. Mirza Md. Shakhawat','Hossain','01710000032',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(33,'Dr. M.S. Sarwar','Alam','01710000033',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(34,'Prof. Dr. Qamruzzaman','Chowdhury','01710000034',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(35,'Dr. Md. Abdul Ahsan','Didar','01710000035',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(36,'Prof. Dr. Rakib Uddin','Ahmed','01710000036',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(37,'Dr. Kamruzzaman','Rumman','01710000037',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(38,'Dr. Md. Nurujjaman','Sarker','01710000038',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(39,'Dr. Sura Jukrup','Momtahena','01710000039',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(40,'Dr. Arunangshu','Das','01710000040',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(41,'Dr. Arman Reza','Chowdhury','01710000041',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(42,'Dr. Bhaskar','Chakraborty','01710000042',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(43,'Dr. Fariah','Sharmeen','01710000043',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(44,'Dr. Md. Arifur','Rahman','01710000044',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(45,'Dr. Md. Shariful Islam','Johnny','01710000045',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(46,'Dr. Meher','Jabin','01710000046',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(47,'Dr. Tania','Sultana','01710000047',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(48,'Dr. Md. Shaheen','Ferdous','01710000048',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(49,'Dr. Abdullah Al Mamun','Khan','01710000049',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(50,'Dr. Asaduzzaman','Biddut','01710000050',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(51,'Dr. Md. Mamunur','Rashid','01710000051',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(52,'Dr. Md. Rafiqul','Islam','01710000052',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(53,'Dr. Md. Rifat Zia','Hossain','01710000053',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(54,'Dr. Muhammad','Abdullah-Al-Noman','01710000054',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(55,'Dr. Muhammad Rafiqul','Islam','01710000055',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(56,'Dr. Rokaya Sultana','Ruma','01710000056',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(57,'Dr. Jannatul','Ferdause','01710000057',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(58,'Dr. Nusrat','Hoque','01710000058',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(59,'Dr. Ferdous Shahriar','Sayed','01710000059',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(60,'Prof. Dr. Raju Titus','Chacko','01710000060',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(61,'Prof. Dr. Santanu','Chaudhuri','01710000061',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(62,'Dr. A.F.M. Kamal','Uddin','01710000062',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(63,'Dr. Ferdous Ara','Begum','01710000063',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(64,'Dr. Kamrun Nahar','Tania','01710000064',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(65,'Dr. Md. Nahid','Hossen','01710000065',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(66,'Dr. Shuvra','Debnath','01710000066',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(67,'Dr. Hosneara','Begum','01710000067',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(68,'Dr. Kazi Abdullah','Arman','01710000068',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(69,'Dr. Md. Abdul','Mannan','01710000069',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(70,'Dr. Swadesh','Barman','01710000070',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(71,'Dr. A.T.M. Kamrul','Hasan','01710000071',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(72,'Dr. Mostafa Aziz','Sumon','01710000072',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(73,'Dr. Md. Arif','Hossain','01710000073',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(74,'Dr. Mohammad','Asaduzzaman','01710000074',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(75,'Prof. Dr. Swapan','Bandyopadhyay','01710000075',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(76,'Dr. Samina','Islam','01710000076',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(77,'Dr. Md. Shah Jalalur Rahman','Shahi','01710000077',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(78,'Prof. Dr. Rehana','Begum','01710000078',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(79,'Dr. Ashim Kumar','Sengupta','01710000079',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(80,'Prof. Dr. A.K.M Hamidur','Rahman','01710000080',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(81,'Prof. Dr. Md. Hafizur Rahman','Ansary','01710000081',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(82,'Prof. Dr. Qazi Mushtaq','Hussain','01710000082',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(83,'Prof. Dr. Sarwar','Alam','01710000083',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(84,'Prof. Dr. S.M. Anisur','Rahman','01710000084',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(85,'Prof. Dr. Zillur Rahman','Bhuiyan','01710000085',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(86,'Dr. Happy','Haque','01710000086',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(87,'Prof. Dr. Tarit Kumar','Samadder','01710000087',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(88,'Dr. Md. Rezaul','Sharif','01710000088',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(89,'Dr. Md. Toufiq Hasan','Firoz','01710000089',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(90,'Dr. Samia','Ahmed','01710000090',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(91,'Prof. Dr. Md. Ehteshamul','Hoque','01710000091',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(92,'Dr. Biswajit','Bhattacharjee','01710000092',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(93,'Dr. Parvin Akhter','Banu','01710000093',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(94,'Dr. S. K. M.','Rasel','01710000094',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(95,'Dr. Nazma Azim','Daizy','01710000095',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(96,'Dr. Md. Nazmus','Sakib','01710000096',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(97,'Dr. Mahbuba Akhter','Tania','01710000097',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(98,'Dr. Md. Raihan Bin','Sharif','01710000098',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(99,'Dr. Md. Monzurul','Islam','01710000099',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(100,'Dr. Galib Muhammad','Asadullah','01710000100',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP),
(101,'Dr. Nazirum','Mubin','01710000101',NULL,'DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);

-- ===============================================================
-- 5. DOCTORS (101 PUBLIC-NAME DOCTORS; NO DUMMY PERSONS)
-- ===============================================================
INSERT INTO doctors (doctor_id,license_no,fees,gender,email,address,district,area,experience_years) VALUES
(1,'CC-SEED-DOC-001',900,'Not stated','doctor.seed001@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',6),
(2,'CC-SEED-DOC-002',1000,'Not stated','doctor.seed002@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',7),
(3,'CC-SEED-DOC-003',1100,'Not stated','doctor.seed003@cancercare.local','Shahbag, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shahbag',8),
(4,'CC-SEED-DOC-004',1200,'Not stated','doctor.seed004@cancercare.local','Moghbazar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Moghbazar',9),
(5,'CC-SEED-DOC-005',1300,'Not stated','doctor.seed005@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',10),
(6,'CC-SEED-DOC-006',1400,'Not stated','doctor.seed006@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',11),
(7,'CC-SEED-DOC-007',1500,'Not stated','doctor.seed007@cancercare.local','Eskaton, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Eskaton',12),
(8,'CC-SEED-DOC-008',1600,'Not stated','doctor.seed008@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',13),
(9,'CC-SEED-DOC-009',800,'Not stated','doctor.seed009@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',14),
(10,'CC-SEED-DOC-010',900,'Not stated','doctor.seed010@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',15),
(11,'CC-SEED-DOC-011',1000,'Not stated','doctor.seed011@cancercare.local','Mugda, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mugda',16),
(12,'CC-SEED-DOC-012',1100,'Not stated','doctor.seed012@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',17),
(13,'CC-SEED-DOC-013',1200,'Not stated','doctor.seed013@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',18),
(14,'CC-SEED-DOC-014',1300,'Not stated','doctor.seed014@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',19),
(15,'CC-SEED-DOC-015',1400,'Not stated','doctor.seed015@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',20),
(16,'CC-SEED-DOC-016',1500,'Not stated','doctor.seed016@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',21),
(17,'CC-SEED-DOC-017',1600,'Not stated','doctor.seed017@cancercare.local','Badda, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Badda',22),
(18,'CC-SEED-DOC-018',800,'Not stated','doctor.seed018@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',23),
(19,'CC-SEED-DOC-019',900,'Not stated','doctor.seed019@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',24),
(20,'CC-SEED-DOC-020',1000,'Not stated','doctor.seed020@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',25),
(21,'CC-SEED-DOC-021',1100,'Not stated','doctor.seed021@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',5),
(22,'CC-SEED-DOC-022',1200,'Not stated','doctor.seed022@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',6),
(23,'CC-SEED-DOC-023',1300,'Not stated','doctor.seed023@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',7),
(24,'CC-SEED-DOC-024',1400,'Not stated','doctor.seed024@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',8),
(25,'CC-SEED-DOC-025',1500,'Not stated','doctor.seed025@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',9),
(26,'CC-SEED-DOC-026',1600,'Not stated','doctor.seed026@cancercare.local','Shahbag, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shahbag',10),
(27,'CC-SEED-DOC-027',800,'Not stated','doctor.seed027@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',11),
(28,'CC-SEED-DOC-028',900,'Not stated','doctor.seed028@cancercare.local','Old Dhaka, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Old Dhaka',12),
(29,'CC-SEED-DOC-029',1000,'Not stated','doctor.seed029@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',13),
(30,'CC-SEED-DOC-030',1100,'Not stated','doctor.seed030@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',14),
(31,'CC-SEED-DOC-031',1200,'Not stated','doctor.seed031@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',15),
(32,'CC-SEED-DOC-032',1300,'Not stated','doctor.seed032@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',16),
(33,'CC-SEED-DOC-033',1400,'Not stated','doctor.seed033@cancercare.local','Mohammadpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mohammadpur',17),
(34,'CC-SEED-DOC-034',1500,'Not stated','doctor.seed034@cancercare.local','Old Dhaka, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Old Dhaka',18),
(35,'CC-SEED-DOC-035',1600,'Not stated','doctor.seed035@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',19),
(36,'CC-SEED-DOC-036',800,'Not stated','doctor.seed036@cancercare.local','Green Road, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Green Road',20),
(37,'CC-SEED-DOC-037',900,'Not stated','doctor.seed037@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',21),
(38,'CC-SEED-DOC-038',1000,'Not stated','doctor.seed038@cancercare.local','Gandaria, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gandaria',22),
(39,'CC-SEED-DOC-039',1100,'Not stated','doctor.seed039@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',23),
(40,'CC-SEED-DOC-040',1200,'Not stated','doctor.seed040@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',24),
(41,'CC-SEED-DOC-041',1300,'Not stated','doctor.seed041@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',25),
(42,'CC-SEED-DOC-042',1400,'Not stated','doctor.seed042@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',5),
(43,'CC-SEED-DOC-043',1500,'Not stated','doctor.seed043@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',6),
(44,'CC-SEED-DOC-044',1600,'Not stated','doctor.seed044@cancercare.local','Shyamoli, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shyamoli',7),
(45,'CC-SEED-DOC-045',800,'Not stated','doctor.seed045@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',8),
(46,'CC-SEED-DOC-046',900,'Not stated','doctor.seed046@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',9),
(47,'CC-SEED-DOC-047',1000,'Not stated','doctor.seed047@cancercare.local','Eskaton, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Eskaton',10),
(48,'CC-SEED-DOC-048',1100,'Not stated','doctor.seed048@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',11),
(49,'CC-SEED-DOC-049',1200,'Not stated','doctor.seed049@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',12),
(50,'CC-SEED-DOC-050',1300,'Not stated','doctor.seed050@cancercare.local','Nayapaltan, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Nayapaltan',13),
(51,'CC-SEED-DOC-051',1400,'Not stated','doctor.seed051@cancercare.local','Mugda, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mugda',14),
(52,'CC-SEED-DOC-052',1500,'Not stated','doctor.seed052@cancercare.local','Shyamoli, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shyamoli',15),
(53,'CC-SEED-DOC-053',1600,'Not stated','doctor.seed053@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',16),
(54,'CC-SEED-DOC-054',800,'Not stated','doctor.seed054@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',17),
(55,'CC-SEED-DOC-055',900,'Not stated','doctor.seed055@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',18),
(56,'CC-SEED-DOC-056',1000,'Not stated','doctor.seed056@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',19),
(57,'CC-SEED-DOC-057',1100,'Not stated','doctor.seed057@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',20),
(58,'CC-SEED-DOC-058',1200,'Not stated','doctor.seed058@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',21),
(59,'CC-SEED-DOC-059',1300,'Not stated','doctor.seed059@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',22),
(60,'CC-SEED-DOC-060',1400,'Not stated','doctor.seed060@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',23),
(61,'CC-SEED-DOC-061',1500,'Not stated','doctor.seed061@cancercare.local','Gulshan, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gulshan',24),
(62,'CC-SEED-DOC-062',1600,'Not stated','doctor.seed062@cancercare.local','Gulshan, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gulshan',25),
(63,'CC-SEED-DOC-063',800,'Not stated','doctor.seed063@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',5),
(64,'CC-SEED-DOC-064',900,'Not stated','doctor.seed064@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',6),
(65,'CC-SEED-DOC-065',1000,'Not stated','doctor.seed065@cancercare.local','Gandaria, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gandaria',7),
(66,'CC-SEED-DOC-066',1100,'Not stated','doctor.seed066@cancercare.local','Savar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Savar',8),
(67,'CC-SEED-DOC-067',1200,'Not stated','doctor.seed067@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',9),
(68,'CC-SEED-DOC-068',1300,'Not stated','doctor.seed068@cancercare.local','Old Dhaka, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Old Dhaka',10),
(69,'CC-SEED-DOC-069',1400,'Not stated','doctor.seed069@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',11),
(70,'CC-SEED-DOC-070',1500,'Not stated','doctor.seed070@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',12),
(71,'CC-SEED-DOC-071',1600,'Not stated','doctor.seed071@cancercare.local','Gulshan, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gulshan',13),
(72,'CC-SEED-DOC-072',800,'Not stated','doctor.seed072@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',14),
(73,'CC-SEED-DOC-073',900,'Not stated','doctor.seed073@cancercare.local','Mohammadpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mohammadpur',15),
(74,'CC-SEED-DOC-074',1000,'Not stated','doctor.seed074@cancercare.local','Old Dhaka, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Old Dhaka',16),
(75,'CC-SEED-DOC-075',1100,'Not stated','doctor.seed075@cancercare.local','Panthapath, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Panthapath',17),
(76,'CC-SEED-DOC-076',1200,'Not stated','doctor.seed076@cancercare.local','Green Road, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Green Road',18),
(77,'CC-SEED-DOC-077',1300,'Not stated','doctor.seed077@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',19),
(78,'CC-SEED-DOC-078',1400,'Not stated','doctor.seed078@cancercare.local','Gandaria, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gandaria',20),
(79,'CC-SEED-DOC-079',1500,'Not stated','doctor.seed079@cancercare.local','Gulshan, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Gulshan',21),
(80,'CC-SEED-DOC-080',1600,'Not stated','doctor.seed080@cancercare.local','Mohakhali, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mohakhali',22),
(81,'CC-SEED-DOC-081',800,'Not stated','doctor.seed081@cancercare.local','Shahbag, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shahbag',23),
(82,'CC-SEED-DOC-082',900,'Not stated','doctor.seed082@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',24),
(83,'CC-SEED-DOC-083',1000,'Not stated','doctor.seed083@cancercare.local','Shahbag, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Shahbag',25),
(84,'CC-SEED-DOC-084',1100,'Not stated','doctor.seed084@cancercare.local','Moghbazar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Moghbazar',5),
(85,'CC-SEED-DOC-085',1200,'Not stated','doctor.seed085@cancercare.local','Moghbazar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Moghbazar',6),
(86,'CC-SEED-DOC-086',1300,'Not stated','doctor.seed086@cancercare.local','Uttara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Uttara',7),
(87,'CC-SEED-DOC-087',1400,'Not stated','doctor.seed087@cancercare.local','Eskaton, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Eskaton',8),
(88,'CC-SEED-DOC-088',1500,'Not stated','doctor.seed088@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',9),
(89,'CC-SEED-DOC-089',1600,'Not stated','doctor.seed089@cancercare.local','Sher-e-Bangla Nagar, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Sher-e-Bangla Nagar',10),
(90,'CC-SEED-DOC-090',800,'Not stated','doctor.seed090@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',11),
(91,'CC-SEED-DOC-091',900,'Not stated','doctor.seed091@cancercare.local','Mugda, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mugda',12),
(92,'CC-SEED-DOC-092',1000,'Not stated','doctor.seed092@cancercare.local','Bashundhara, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Bashundhara',13),
(93,'CC-SEED-DOC-093',1100,'Not stated','doctor.seed093@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',14),
(94,'CC-SEED-DOC-094',1200,'Not stated','doctor.seed094@cancercare.local','Mirpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mirpur',15),
(95,'CC-SEED-DOC-095',1300,'Not stated','doctor.seed095@cancercare.local','Mohammadpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mohammadpur',16),
(96,'CC-SEED-DOC-096',1400,'Not stated','doctor.seed096@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',17),
(97,'CC-SEED-DOC-097',1500,'Not stated','doctor.seed097@cancercare.local','Badda, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Badda',18),
(98,'CC-SEED-DOC-098',1600,'Not stated','doctor.seed098@cancercare.local','Cantonment, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Cantonment',19),
(99,'CC-SEED-DOC-099',800,'Not stated','doctor.seed099@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',20),
(100,'CC-SEED-DOC-100',900,'Not stated','doctor.seed100@cancercare.local','Mohammadpur, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Mohammadpur',21),
(101,'CC-SEED-DOC-101',1000,'Not stated','doctor.seed101@cancercare.local','Dhanmondi, Dhaka (demo profile; verify with affiliated hospital)','Dhaka','Dhanmondi',22);

-- ===============================================================
-- 6. SYNTHETIC PATIENTS
-- ===============================================================
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1001,'Rahim','Ahmed','01720000001','1962-06-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1001,'Male','A+','01820000001','House 11, Road 2, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1002,'Karim','Islam','01720000002','1969-11-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1002,'Female','A-','01820000002','House 12, Road 3, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1003,'Sadia','Akter','01720000003','1976-04-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1003,'Male','B+','01820000003','House 13, Road 4, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1004,'Nusrat','Kabir','01720000004','1983-09-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1004,'Female','B-','01820000004','House 14, Road 5, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1005,'Farzana','Miah','01720000005','1990-02-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1005,'Male','AB+','01820000005','House 15, Road 6, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1006,'Rafiq','Ahmed','01720000006','1997-07-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1006,'Female','AB-','01820000006','House 16, Road 7, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1007,'Jannat','Islam','01720000007','2004-12-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1007,'Male','O+','01820000007','House 17, Road 8, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1008,'Mim','Akter','01720000008','1956-05-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1008,'Female','O-','01820000008','House 18, Road 9, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1009,'Tanvir','Kabir','01720000009','1963-10-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1009,'Male','A+','01820000009','House 19, Road 10, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1010,'Shila','Miah','01720000010','1970-03-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1010,'Female','A-','01820000010','House 20, Road 11, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1011,'Hasan','Ahmed','01720000011','1977-08-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1011,'Male','B+','01820000011','House 21, Road 12, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1012,'Mitu','Islam','01720000012','1984-01-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1012,'Female','B-','01820000012','House 22, Road 13, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1013,'Imran','Akter','01720000013','1991-06-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1013,'Male','AB+','01820000013','House 23, Road 14, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1014,'Tania','Kabir','01720000014','1998-11-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1014,'Female','AB-','01820000014','House 24, Road 15, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1015,'Sakib','Miah','01720000015','2005-04-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1015,'Male','O+','01820000015','House 25, Road 1, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1016,'Ayesha','Ahmed','01720000016','1957-09-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1016,'Female','O-','01820000016','House 26, Road 2, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1017,'Mehedi','Islam','01720000017','1964-02-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1017,'Male','A+','01820000017','House 27, Road 3, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1018,'Ruma','Akter','01720000018','1971-07-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1018,'Female','A-','01820000018','House 28, Road 4, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1019,'Nayeem','Kabir','01720000019','1978-12-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1019,'Male','B+','01820000019','House 29, Road 5, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1020,'Sumaiya','Miah','01720000020','1985-05-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1020,'Female','B-','01820000020','House 30, Road 6, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1021,'Rahim','Ahmed','01720000021','1992-10-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1021,'Male','AB+','01820000021','House 31, Road 7, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1022,'Karim','Islam','01720000022','1999-03-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1022,'Female','AB-','01820000022','House 32, Road 8, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1023,'Sadia','Akter','01720000023','2006-08-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1023,'Male','O+','01820000023','House 33, Road 9, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1024,'Nusrat','Kabir','01720000024','1958-01-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1024,'Female','O-','01820000024','House 34, Road 10, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1025,'Farzana','Miah','01720000025','1965-06-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1025,'Male','A+','01820000025','House 35, Road 11, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1026,'Rafiq','Ahmed','01720000026','1972-11-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1026,'Female','A-','01820000026','House 36, Road 12, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1027,'Jannat','Islam','01720000027','1979-04-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1027,'Male','B+','01820000027','House 37, Road 13, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1028,'Mim','Akter','01720000028','1986-09-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1028,'Female','B-','01820000028','House 38, Road 14, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1029,'Tanvir','Kabir','01720000029','1993-02-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1029,'Male','AB+','01820000029','House 39, Road 15, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1030,'Shila','Miah','01720000030','2000-07-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1030,'Female','AB-','01820000030','House 40, Road 1, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1031,'Hasan','Ahmed','01720000031','2007-12-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1031,'Male','O+','01820000031','House 41, Road 2, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1032,'Mitu','Islam','01720000032','1959-05-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1032,'Female','O-','01820000032','House 42, Road 3, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1033,'Imran','Akter','01720000033','1966-10-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1033,'Male','A+','01820000033','House 43, Road 4, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1034,'Tania','Kabir','01720000034','1973-03-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1034,'Female','A-','01820000034','House 44, Road 5, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1035,'Sakib','Miah','01720000035','1980-08-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1035,'Male','B+','01820000035','House 45, Road 6, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1036,'Ayesha','Ahmed','01720000036','1987-01-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1036,'Female','B-','01820000036','House 46, Road 7, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1037,'Mehedi','Islam','01720000037','1994-06-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1037,'Male','AB+','01820000037','House 47, Road 8, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1038,'Ruma','Akter','01720000038','2001-11-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1038,'Female','AB-','01820000038','House 48, Road 9, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1039,'Nayeem','Kabir','01720000039','2008-04-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1039,'Male','O+','01820000039','House 49, Road 10, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1040,'Sumaiya','Miah','01720000040','1960-09-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1040,'Female','O-','01820000040','House 50, Road 11, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1041,'Rahim','Ahmed','01720000041','1967-02-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1041,'Male','A+','01820000041','House 51, Road 12, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1042,'Karim','Islam','01720000042','1974-07-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1042,'Female','A-','01820000042','House 52, Road 13, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1043,'Sadia','Akter','01720000043','1981-12-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1043,'Male','B+','01820000043','House 53, Road 14, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1044,'Nusrat','Kabir','01720000044','1988-05-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1044,'Female','B-','01820000044','House 54, Road 15, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1045,'Farzana','Miah','01720000045','1995-10-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1045,'Male','AB+','01820000045','House 55, Road 1, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1046,'Rafiq','Ahmed','01720000046','2002-03-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1046,'Female','AB-','01820000046','House 56, Road 2, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1047,'Jannat','Islam','01720000047','2009-08-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1047,'Male','O+','01820000047','House 57, Road 3, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1048,'Mim','Akter','01720000048','1961-01-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1048,'Female','O-','01820000048','House 58, Road 4, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1049,'Tanvir','Kabir','01720000049','1968-06-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1049,'Male','A+','01820000049','House 59, Road 5, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1050,'Shila','Miah','01720000050','1975-11-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1050,'Female','A-','01820000050','House 60, Road 6, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1051,'Hasan','Ahmed','01720000051','1982-04-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1051,'Male','B+','01820000051','House 61, Road 7, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1052,'Mitu','Islam','01720000052','1989-09-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1052,'Female','B-','01820000052','House 62, Road 8, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1053,'Imran','Akter','01720000053','1996-02-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1053,'Male','AB+','01820000053','House 63, Road 9, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1054,'Tania','Kabir','01720000054','2003-07-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1054,'Female','AB-','01820000054','House 64, Road 10, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1055,'Sakib','Miah','01720000055','1955-12-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1055,'Male','O+','01820000055','House 65, Road 11, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1056,'Ayesha','Ahmed','01720000056','1962-05-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1056,'Female','O-','01820000056','House 66, Road 12, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1057,'Mehedi','Islam','01720000057','1969-10-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1057,'Male','A+','01820000057','House 67, Road 13, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1058,'Ruma','Akter','01720000058','1976-03-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1058,'Female','A-','01820000058','House 68, Road 14, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1059,'Nayeem','Kabir','01720000059','1983-08-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1059,'Male','B+','01820000059','House 69, Road 15, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1060,'Sumaiya','Miah','01720000060','1990-01-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1060,'Female','B-','01820000060','House 70, Road 1, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1061,'Rahim','Ahmed','01720000061','1997-06-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1061,'Male','AB+','01820000061','House 71, Road 2, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1062,'Karim','Islam','01720000062','2004-11-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1062,'Female','AB-','01820000062','House 72, Road 3, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1063,'Sadia','Akter','01720000063','1956-04-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1063,'Male','O+','01820000063','House 73, Road 4, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1064,'Nusrat','Kabir','01720000064','1963-09-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1064,'Female','O-','01820000064','House 74, Road 5, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1065,'Farzana','Miah','01720000065','1970-02-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1065,'Male','A+','01820000065','House 75, Road 6, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1066,'Rafiq','Ahmed','01720000066','1977-07-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1066,'Female','A-','01820000066','House 76, Road 7, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1067,'Jannat','Islam','01720000067','1984-12-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1067,'Male','B+','01820000067','House 77, Road 8, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1068,'Mim','Akter','01720000068','1991-05-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1068,'Female','B-','01820000068','House 78, Road 9, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1069,'Tanvir','Kabir','01720000069','1998-10-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1069,'Male','AB+','01820000069','House 79, Road 10, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1070,'Shila','Miah','01720000070','2005-03-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1070,'Female','AB-','01820000070','House 80, Road 11, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1071,'Hasan','Ahmed','01720000071','1957-08-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1071,'Male','O+','01820000071','House 81, Road 12, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1072,'Mitu','Islam','01720000072','1964-01-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1072,'Female','O-','01820000072','House 82, Road 13, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1073,'Imran','Akter','01720000073','1971-06-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1073,'Male','A+','01820000073','House 83, Road 14, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1074,'Tania','Kabir','01720000074','1978-11-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1074,'Female','A-','01820000074','House 84, Road 15, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1075,'Sakib','Miah','01720000075','1985-04-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1075,'Male','B+','01820000075','House 85, Road 1, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1076,'Ayesha','Ahmed','01720000076','1992-09-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1076,'Female','B-','01820000076','House 86, Road 2, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1077,'Mehedi','Islam','01720000077','1999-02-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1077,'Male','AB+','01820000077','House 87, Road 3, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1078,'Ruma','Akter','01720000078','2006-07-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1078,'Female','AB-','01820000078','House 88, Road 4, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1079,'Nayeem','Kabir','01720000079','1958-12-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1079,'Male','O+','01820000079','House 89, Road 5, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1080,'Sumaiya','Miah','01720000080','1965-05-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1080,'Female','O-','01820000080','House 90, Road 6, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1081,'Rahim','Ahmed','01720000081','1972-10-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1081,'Male','A+','01820000081','House 91, Road 7, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1082,'Karim','Islam','01720000082','1979-03-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1082,'Female','A-','01820000082','House 92, Road 8, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1083,'Sadia','Akter','01720000083','1986-08-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1083,'Male','B+','01820000083','House 93, Road 9, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1084,'Nusrat','Kabir','01720000084','1993-01-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1084,'Female','B-','01820000084','House 94, Road 10, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1085,'Farzana','Miah','01720000085','2000-06-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1085,'Male','AB+','01820000085','House 95, Road 11, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1086,'Rafiq','Ahmed','01720000086','2007-11-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1086,'Female','AB-','01820000086','House 96, Road 12, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1087,'Jannat','Islam','01720000087','1959-04-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1087,'Male','O+','01820000087','House 97, Road 13, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1088,'Mim','Akter','01720000088','1966-09-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1088,'Female','O-','01820000088','House 98, Road 14, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1089,'Tanvir','Kabir','01720000089','1973-02-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1089,'Male','A+','01820000089','House 99, Road 15, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1090,'Shila','Miah','01720000090','1980-07-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1090,'Female','A-','01820000090','House 10, Road 1, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1091,'Hasan','Ahmed','01720000091','1987-12-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1091,'Male','B+','01820000091','House 11, Road 2, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1092,'Mitu','Islam','01720000092','1994-05-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1092,'Female','B-','01820000092','House 12, Road 3, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1093,'Imran','Akter','01720000093','2001-10-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1093,'Male','AB+','01820000093','House 13, Road 4, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1094,'Tania','Kabir','01720000094','2008-03-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1094,'Female','AB-','01820000094','House 14, Road 5, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1095,'Sakib','Miah','01720000095','1960-08-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1095,'Male','O+','01820000095','House 15, Road 6, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1096,'Ayesha','Ahmed','01720000096','1967-01-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1096,'Female','O-','01820000096','House 16, Road 7, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1097,'Mehedi','Islam','01720000097','1974-06-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1097,'Male','A+','01820000097','House 17, Road 8, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1098,'Ruma','Akter','01720000098','1981-11-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1098,'Female','A-','01820000098','House 18, Road 9, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1099,'Nayeem','Kabir','01720000099','1988-04-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1099,'Male','B+','01820000099','House 19, Road 10, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1100,'Sumaiya','Miah','01720000100','1995-09-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1100,'Female','B-','01820000100','House 20, Road 11, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1101,'Rahim','Ahmed','01720000101','2002-02-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1101,'Male','AB+','01820000101','House 21, Road 12, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1102,'Karim','Islam','01720000102','2009-07-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1102,'Female','AB-','01820000102','House 22, Road 13, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1103,'Sadia','Akter','01720000103','1961-12-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1103,'Male','O+','01820000103','House 23, Road 14, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1104,'Nusrat','Kabir','01720000104','1968-05-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1104,'Female','O-','01820000104','House 24, Road 15, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1105,'Farzana','Miah','01720000105','1975-10-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1105,'Male','A+','01820000105','House 25, Road 1, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1106,'Rafiq','Ahmed','01720000106','1982-03-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1106,'Female','A-','01820000106','House 26, Road 2, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1107,'Jannat','Islam','01720000107','1989-08-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1107,'Male','B+','01820000107','House 27, Road 3, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1108,'Mim','Akter','01720000108','1996-01-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1108,'Female','B-','01820000108','House 28, Road 4, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1109,'Tanvir','Kabir','01720000109','2003-06-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1109,'Male','AB+','01820000109','House 29, Road 5, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1110,'Shila','Miah','01720000110','1955-11-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1110,'Female','AB-','01820000110','House 30, Road 6, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1111,'Hasan','Ahmed','01720000111','1962-04-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1111,'Male','O+','01820000111','House 31, Road 7, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1112,'Mitu','Islam','01720000112','1969-09-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1112,'Female','O-','01820000112','House 32, Road 8, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1113,'Imran','Akter','01720000113','1976-02-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1113,'Male','A+','01820000113','House 33, Road 9, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1114,'Tania','Kabir','01720000114','1983-07-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1114,'Female','A-','01820000114','House 34, Road 10, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1115,'Sakib','Miah','01720000115','1990-12-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1115,'Male','B+','01820000115','House 35, Road 11, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1116,'Ayesha','Ahmed','01720000116','1997-05-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1116,'Female','B-','01820000116','House 36, Road 12, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1117,'Mehedi','Islam','01720000117','2004-10-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1117,'Male','AB+','01820000117','House 37, Road 13, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1118,'Ruma','Akter','01720000118','1956-03-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1118,'Female','AB-','01820000118','House 38, Road 14, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1119,'Nayeem','Kabir','01720000119','1963-08-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1119,'Male','O+','01820000119','House 39, Road 15, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1120,'Sumaiya','Miah','01720000120','1970-01-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1120,'Female','O-','01820000120','House 40, Road 1, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1121,'Rahim','Ahmed','01720000121','1977-06-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1121,'Male','A+','01820000121','House 41, Road 2, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1122,'Karim','Islam','01720000122','1984-11-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1122,'Female','A-','01820000122','House 42, Road 3, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1123,'Sadia','Akter','01720000123','1991-04-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1123,'Male','B+','01820000123','House 43, Road 4, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1124,'Nusrat','Kabir','01720000124','1998-09-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1124,'Female','B-','01820000124','House 44, Road 5, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1125,'Farzana','Miah','01720000125','2005-02-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1125,'Male','AB+','01820000125','House 45, Road 6, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1126,'Rafiq','Ahmed','01720000126','1957-07-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1126,'Female','AB-','01820000126','House 46, Road 7, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1127,'Jannat','Islam','01720000127','1964-12-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1127,'Male','O+','01820000127','House 47, Road 8, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1128,'Mim','Akter','01720000128','1971-05-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1128,'Female','O-','01820000128','House 48, Road 9, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1129,'Tanvir','Kabir','01720000129','1978-10-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1129,'Male','A+','01820000129','House 49, Road 10, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1130,'Shila','Miah','01720000130','1985-03-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1130,'Female','A-','01820000130','House 50, Road 11, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1131,'Hasan','Ahmed','01720000131','1992-08-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1131,'Male','B+','01820000131','House 51, Road 12, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1132,'Mitu','Islam','01720000132','1999-01-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1132,'Female','B-','01820000132','House 52, Road 13, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1133,'Imran','Akter','01720000133','2006-06-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1133,'Male','AB+','01820000133','House 53, Road 14, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1134,'Tania','Kabir','01720000134','1958-11-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1134,'Female','AB-','01820000134','House 54, Road 15, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1135,'Sakib','Miah','01720000135','1965-04-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1135,'Male','O+','01820000135','House 55, Road 1, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1136,'Ayesha','Ahmed','01720000136','1972-09-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1136,'Female','O-','01820000136','House 56, Road 2, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1137,'Mehedi','Islam','01720000137','1979-02-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1137,'Male','A+','01820000137','House 57, Road 3, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1138,'Ruma','Akter','01720000138','1986-07-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1138,'Female','A-','01820000138','House 58, Road 4, Badda','Dhaka','Badda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1139,'Nayeem','Kabir','01720000139','1993-12-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1139,'Male','B+','01820000139','House 59, Road 5, Jatrabari','Dhaka','Jatrabari');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1140,'Sumaiya','Miah','01720000140','2000-05-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1140,'Female','B-','01820000140','House 60, Road 6, Motijheel','Dhaka','Motijheel');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1141,'Rahim','Ahmed','01720000141','2007-10-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1141,'Male','AB+','01820000141','House 61, Road 7, Tejgaon','Dhaka','Tejgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1142,'Karim','Islam','01720000142','1959-03-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1142,'Female','AB-','01820000142','House 62, Road 8, Khilgaon','Dhaka','Khilgaon');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1143,'Sadia','Akter','01720000143','1966-08-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1143,'Male','O+','01820000143','House 63, Road 9, Shahbag','Dhaka','Shahbag');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1144,'Nusrat','Kabir','01720000144','1973-01-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1144,'Female','O-','01820000144','House 64, Road 10, Mugda','Dhaka','Mugda');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1145,'Farzana','Miah','01720000145','1980-06-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1145,'Male','A+','01820000145','House 65, Road 11, Dhanmondi','Dhaka','Dhanmondi');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1146,'Rafiq','Ahmed','01720000146','1987-11-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1146,'Female','A-','01820000146','House 66, Road 12, Mirpur','Dhaka','Mirpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1147,'Jannat','Islam','01720000147','1994-04-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1147,'Male','B+','01820000147','House 67, Road 13, Uttara','Dhaka','Uttara');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1148,'Mim','Akter','01720000148','2001-09-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1148,'Female','B-','01820000148','House 68, Road 14, Mohammadpur','Dhaka','Mohammadpur');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1149,'Tanvir','Kabir','01720000149','2008-02-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1149,'Male','AB+','01820000149','House 69, Road 15, Gulshan','Dhaka','Gulshan');
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (1150,'Shila','Miah','01720000150','1960-07-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO patient (patient_id,gender,blood_group,emergency_contact,address,district,area) VALUES (1150,'Female','AB-','01820000150','House 70, Road 1, Badda','Dhaka','Badda');

-- ===============================================================
-- 7. SYNTHETIC ADMINS
-- ===============================================================
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2001,'Admin','Hospital 01','01830000001','1981-02-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2001,1);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2002,'Admin','Hospital 02','01830000002','1982-03-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2002,2);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2003,'Admin','Hospital 03','01830000003','1983-04-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2003,3);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2004,'Admin','Hospital 04','01830000004','1984-05-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2004,4);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2005,'Admin','Hospital 05','01830000005','1985-06-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2005,5);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2006,'Admin','Hospital 06','01830000006','1986-07-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2006,6);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2007,'Admin','Hospital 07','01830000007','1987-08-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2007,7);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2008,'Admin','Hospital 08','01830000008','1988-09-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2008,8);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2009,'Admin','Hospital 09','01830000009','1989-10-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2009,9);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2010,'Admin','Hospital 10','01830000010','1990-11-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2010,10);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2011,'Admin','Hospital 11','01830000011','1991-12-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2011,11);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2012,'Admin','Hospital 12','01830000012','1992-01-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2012,12);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2013,'Admin','Hospital 13','01830000013','1993-02-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2013,13);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2014,'Admin','Hospital 14','01830000014','1994-03-15','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2014,14);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2015,'Admin','Hospital 15','01830000015','1980-04-16','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2015,15);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2016,'Admin','Hospital 16','01830000016','1981-05-17','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2016,16);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2017,'Admin','Hospital 17','01830000017','1982-06-18','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2017,17);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2018,'Admin','Hospital 18','01830000018','1983-07-19','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2018,18);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2019,'Admin','Hospital 19','01830000019','1984-08-20','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2019,19);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2020,'Admin','Hospital 20','01830000020','1985-09-21','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2020,20);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2021,'Admin','Hospital 21','01830000021','1986-10-22','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2021,21);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2022,'Admin','Hospital 22','01830000022','1987-11-23','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2022,22);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2023,'Admin','Hospital 23','01830000023','1988-12-24','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2023,23);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2024,'Admin','Hospital 24','01830000024','1989-01-25','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2024,24);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2025,'Admin','Hospital 25','01830000025','1990-02-26','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2025,25);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2026,'Admin','Hospital 26','01830000026','1991-03-27','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2026,26);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2027,'Admin','Hospital 27','01830000027','1992-04-01','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2027,27);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2028,'Admin','Hospital 28','01830000028','1993-05-02','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2028,28);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2029,'Admin','Hospital 29','01830000029','1994-06-03','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2029,29);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2030,'Admin','Hospital 30','01830000030','1980-07-04','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2030,30);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2031,'Admin','Hospital 31','01830000031','1981-08-05','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2031,31);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2032,'Admin','Hospital 32','01830000032','1982-09-06','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2032,32);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2033,'Admin','Hospital 33','01830000033','1983-10-07','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2033,33);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2034,'Admin','Hospital 34','01830000034','1984-11-08','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2034,34);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2035,'Admin','Hospital 35','01830000035','1985-12-09','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2035,35);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2036,'Admin','Hospital 36','01830000036','1986-01-10','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2036,36);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2037,'Admin','Hospital 37','01830000037','1987-02-11','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2037,37);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2038,'Admin','Hospital 38','01830000038','1988-03-12','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2038,38);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2039,'Admin','Hospital 39','01830000039','1989-04-13','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2039,39);
INSERT INTO users (user_id,first_name,last_name,contact,dob,password_hash,created_at) VALUES (2040,'Admin','Hospital 40','01830000040','1990-05-14','DEMO_HASH_REPLACE_WITH_BCRYPT',CURRENT_TIMESTAMP);
INSERT INTO admins (admin_id,hospital_id) VALUES (2040,40);

-- ===============================================================
-- 8. BLOG POSTS
-- ===============================================================
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (1,'Understanding Early Cancer Detection','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '29 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (2,'Why Cancer Screening Matters','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '28 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (3,'Questions to Ask an Oncologist','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '27 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (4,'Living Well During Cancer Treatment','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '26 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (5,'Cancer Care and Family Support','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '25 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (6,'Understanding Biopsy Reports','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '24 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (7,'Radiotherapy: A Patient-Friendly Overview','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '23 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (8,'Chemotherapy and Supportive Care','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '22 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (9,'Breast Cancer Awareness','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '21 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (10,'Lung Cancer Awareness','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '20 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (11,'Oral Cancer Prevention','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '19 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (12,'Cervical Cancer Screening','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '18 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (13,'Colorectal Cancer Awareness','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '17 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (14,'Blood Cancer Awareness','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '16 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (15,'The Role of Palliative Care','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '15 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (16,'Nutrition During Cancer Care','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '14 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (17,'How Multidisciplinary Cancer Teams Work','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '13 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (18,'Cancer Treatment Follow-up','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '12 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (19,'Understanding Cancer Staging','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '11 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (20,'Managing Treatment Appointments','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '10 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (21,'Supporting a Family Member With Cancer','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '9 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (22,'Keeping Medical Records Organized','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '8 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (23,'Second Opinions in Cancer Care','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '7 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (24,'Cancer Survivorship','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '6 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (25,'Common Questions About Oncology Clinics','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '5 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (26,'Why Referral Networks Matter','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '4 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (27,'Understanding Clinical Trials','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '3 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (28,'Medication Safety and Record Keeping','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '2 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (29,'Hospital-Based Cancer Services','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '1 days');
INSERT INTO blogposts (blog_id,title,feel,post_date) VALUES (30,'Cancer Awareness in Dhaka','Educational demo content for the CancerCare project. This is not medical advice.',CURRENT_TIMESTAMP - INTERVAL '0 days');

-- ===============================================================
-- 9. DOCTOR-HOSPITAL
-- ===============================================================
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (1,7,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (2,15,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (3,22,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (4,29,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (5,16,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (6,6,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (7,10,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (8,17,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (9,24,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (10,7,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (11,38,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (12,26,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (13,12,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (14,25,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (15,26,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (16,33,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (17,40,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (18,7,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (19,14,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (20,21,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (21,28,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (22,35,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (23,2,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (24,9,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (25,16,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (26,23,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (27,26,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (28,37,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (29,4,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (30,11,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (31,16,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (32,25,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (33,32,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (34,39,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (35,24,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (36,13,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (37,20,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (38,27,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (39,3,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (40,16,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (41,9,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (42,3,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (43,16,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (44,5,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (45,3,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (46,3,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (47,10,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (48,17,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (49,24,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (50,31,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (51,38,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (52,5,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (53,12,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (54,26,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (55,26,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (56,33,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (57,3,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (58,3,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (59,9,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (60,9,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (61,18,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (62,18,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (63,2,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (64,9,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (65,27,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (66,26,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (67,30,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (68,37,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (69,4,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (70,11,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (71,18,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (72,25,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (73,32,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (74,39,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (75,6,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (76,13,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (77,20,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (78,27,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (79,18,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (80,1,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (81,8,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (82,15,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (83,22,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (84,29,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (85,36,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (86,3,'2021-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (87,10,'2022-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (88,17,'2023-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (89,24,'2024-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (90,28,'2010-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (91,38,'2011-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (92,9,'2012-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (93,12,'2013-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (94,19,'2014-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (95,32,'2015-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (96,33,'2016-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (97,40,'2017-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (98,7,'2018-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (99,14,'2019-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (100,32,'2020-01-15');
INSERT INTO doctor_hospital (doctor_id,hospital_id,since_date) VALUES (101,28,'2021-01-15');

-- ===============================================================
-- 10. DOCTOR-CANCER SPECIALIZATION
-- ===============================================================
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (1,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (1,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (1,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (2,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (2,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (2,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (3,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (3,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (3,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (4,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (4,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (4,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (5,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (5,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (5,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (6,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (6,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (6,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (7,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (7,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (7,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (8,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (8,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (8,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (9,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (9,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (9,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (10,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (10,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (10,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (11,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (11,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (11,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (12,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (12,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (12,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (13,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (13,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (13,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (14,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (14,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (14,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (15,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (15,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (15,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (16,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (16,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (16,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (17,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (17,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (17,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (18,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (18,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (19,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (19,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (19,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (20,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (20,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (20,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (21,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (21,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (21,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (22,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (22,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (22,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (23,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (23,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (23,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (24,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (24,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (24,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (25,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (25,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (25,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (26,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (26,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (26,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (27,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (27,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (27,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (28,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (28,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (28,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (29,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (29,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (29,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (30,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (30,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (30,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (31,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (31,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (31,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (32,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (32,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (32,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (33,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (33,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (33,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (34,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (34,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (34,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (35,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (35,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (35,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (36,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (36,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (36,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (37,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (37,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (38,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (38,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (38,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (39,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (39,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (39,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (40,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (40,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (40,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (41,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (41,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (41,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (42,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (42,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (42,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (43,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (43,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (43,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (44,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (44,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (44,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (45,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (45,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (45,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (46,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (46,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (46,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (47,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (47,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (47,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (48,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (48,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (48,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (49,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (49,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (49,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (50,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (50,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (50,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (51,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (51,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (51,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (52,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (52,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (52,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (53,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (53,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (53,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (54,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (54,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (54,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (55,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (55,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (55,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (56,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (56,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (57,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (57,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (57,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (58,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (58,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (58,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (59,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (59,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (59,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (60,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (60,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (60,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (61,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (61,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (61,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (62,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (62,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (62,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (63,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (63,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (63,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (64,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (64,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (64,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (65,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (65,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (65,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (66,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (66,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (66,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (67,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (67,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (67,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (68,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (68,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (68,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (69,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (69,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (69,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (70,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (70,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (70,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (71,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (71,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (71,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (72,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (72,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (72,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (73,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (73,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (73,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (74,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (74,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (74,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (75,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (75,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (76,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (76,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (76,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (77,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (77,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (77,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (78,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (78,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (78,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (79,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (79,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (79,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (80,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (80,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (80,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (81,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (81,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (81,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (82,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (82,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (82,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (83,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (83,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (83,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (84,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (84,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (84,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (85,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (85,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (85,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (86,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (86,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (86,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (87,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (87,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (87,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (88,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (88,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (88,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (89,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (89,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (89,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (90,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (90,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (90,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (91,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (91,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (91,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (92,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (92,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (92,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (93,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (93,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (93,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (94,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (94,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (95,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (95,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (95,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (96,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (96,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (96,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (97,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (97,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (97,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (98,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (98,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (98,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (99,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (99,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (99,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (100,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (100,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (100,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (101,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (101,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_cancer_specialization (doctor_id,cancer_id) VALUES (101,38) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 11. MEDICINES
-- ===============================================================
-- 12) Medicines: generic names are real. Prices are representative Bangladesh listings where available.
INSERT INTO medicines (medicine_id,medicine_name,price,side_effects,description,ratings,manufacturer) VALUES
(1,'Paclitaxel',5330,'Hair loss, neuropathy, low blood counts','Taxane chemotherapy medicine used in several solid tumors.',4.1,'Aristopharma Ltd.'),
(2,'Cisplatin',300,'Nausea, kidney toxicity, hearing changes, neuropathy','Platinum chemotherapy medicine used for multiple solid tumors.',4.2,'Aristopharma Ltd.'),
(3,'Carboplatin',1600,'Low blood counts, nausea, allergic reactions','Platinum chemotherapy medicine used in many solid tumors.',4.3,'Aristopharma Ltd.'),
(4,'Doxorubicin',350,'Low blood counts, nausea, hair loss, cardiac toxicity','Anthracycline chemotherapy medicine.',4.4,'Healthcare Pharmaceuticals Ltd.'),
(5,'Cyclophosphamide',150,'Low blood counts, nausea, bladder irritation','Alkylating chemotherapy medicine.',4.5,'Drug International Ltd.'),
(6,'Methotrexate',12,'Mouth sores, low blood counts, liver toxicity','Antimetabolite used in selected cancers and other conditions.',4.6,'Drug International Ltd.'),
(7,'Trastuzumab',81956.8,'Infusion reactions, cardiac dysfunction','HER2-targeted monoclonal antibody.',4.7,'Roche Bangladesh Ltd.'),
(8,'Rituximab',13000,'Infusion reactions, infections, low blood counts','CD20-targeted monoclonal antibody used in selected B-cell malignancies.',4.8,'ACI Limited'),
(9,'Imatinib',350,'Edema, nausea, muscle cramps, low blood counts','Tyrosine kinase inhibitor used for selected hematologic and solid tumors.',4.9,'Incepta Pharmaceuticals Ltd.'),
(10,'Tamoxifen citrate',16,'Hot flashes, thromboembolic events, endometrial effects','Selective estrogen receptor modulator used in hormone-receptor-positive breast cancer.',4.0,'Renata PLC'),
(11,'Fluorouracil',100,'Mouth sores, diarrhea, low blood counts','Antimetabolite chemotherapy medicine.',4.1,'Drug International Ltd.'),
(12,'Gemcitabine',1300,'Low blood counts, fatigue, nausea','Antimetabolite chemotherapy medicine.',4.2,'Drug International Ltd.'),
(13,'Oxaliplatin',2900,'Peripheral neuropathy, nausea, low blood counts','Platinum chemotherapy medicine commonly used in gastrointestinal cancers.',4.3,'Drug International Ltd.'),
(14,'Docetaxel',10000,'Low blood counts, fluid retention, neuropathy','Taxane chemotherapy medicine.',4.4,'Drug International Ltd.'),
(15,'Vincristine',350,'Neuropathy, constipation, low blood counts','Vinca alkaloid used in hematologic malignancies and some solid tumors.',4.5,'Beacon Pharmaceuticals PLC'),
(16,'Vinblastine',850,'Low blood counts, neuropathy, nausea','Vinca alkaloid chemotherapy medicine.',4.6,'Beacon Pharmaceuticals PLC'),
(17,'Etoposide',530,'Low blood counts, nausea, hair loss','Topoisomerase inhibitor used in selected cancers.',4.7,'Techno Drugs Ltd.'),
(18,'Letrozole',40,'Hot flashes, joint pain, bone loss','Aromatase inhibitor used in hormone-receptor-positive breast cancer.',4.8,'Incepta Pharmaceuticals Ltd.'),
(19,'Anastrozole',40,'Hot flashes, joint pain, bone loss','Aromatase inhibitor used in hormone-receptor-positive breast cancer.',4.9,'Drug International Ltd.'),
(20,'Dexamethasone',5,'Increased glucose, insomnia, infection risk','Corticosteroid used as supportive therapy and in selected hematologic malignancies.',4.0,'Nuvista Pharma Ltd.'),
(21,'Filgrastim',1200,'Bone pain, fever, injection-site reactions','G-CSF used to reduce chemotherapy-associated neutropenia risk.',4.1,'Various licensed manufacturers'),
(22,'Pegfilgrastim',3500,'Bone pain, fever, injection-site reactions','Long-acting G-CSF used for selected chemotherapy regimens.',4.2,'Various licensed manufacturers'),
(23,'Pembrolizumab',NULL,'Immune-mediated adverse effects, fatigue, rash','PD-1 immune checkpoint inhibitor used for selected cancers.',4.3,'Various licensed manufacturers'),
(24,'Nivolumab',NULL,'Immune-mediated adverse effects, fatigue, rash','PD-1 immune checkpoint inhibitor used for selected cancers.',4.4,'Various licensed manufacturers'),
(25,'Atezolizumab',NULL,'Immune-mediated adverse effects, fatigue, infusion reactions','PD-L1 immune checkpoint inhibitor used for selected cancers.',4.5,'Various licensed manufacturers'),
(26,'Bevacizumab',NULL,'Hypertension, bleeding, proteinuria, wound-healing complications','VEGF-targeted monoclonal antibody used in selected cancers.',4.6,'Various licensed manufacturers'),
(27,'Cetuximab',NULL,'Acneiform rash, infusion reactions, low magnesium','EGFR-targeted monoclonal antibody.',4.7,'Various licensed manufacturers'),
(28,'Pertuzumab',NULL,'Diarrhea, infusion reactions, cardiac dysfunction','HER2-targeted monoclonal antibody used in selected breast cancers.',4.8,'Various licensed manufacturers'),
(29,'Bortezomib',NULL,'Peripheral neuropathy, low blood counts, shingles reactivation','Proteasome inhibitor used in plasma-cell and selected hematologic malignancies.',4.9,'Various licensed manufacturers'),
(30,'Lenalidomide',NULL,'Low blood counts, thrombosis, rash','Immunomodulatory medicine used in multiple myeloma and selected hematologic malignancies.',4.0,'Various licensed manufacturers'),
(31,'Thalidomide',NULL,'Neuropathy, sedation, thrombosis','Immunomodulatory medicine used in selected multiple myeloma regimens.',4.1,'Various licensed manufacturers'),
(32,'Azacitidine',NULL,'Low blood counts, nausea, injection-site reactions','Hypomethylating agent used in selected myeloid malignancies.',4.2,'Various licensed manufacturers'),
(33,'Cytarabine',NULL,'Low blood counts, fever, nausea','Antimetabolite used in acute leukemias.',4.3,'Various licensed manufacturers'),
(34,'Daunorubicin',NULL,'Low blood counts, nausea, cardiac toxicity','Anthracycline used in selected acute leukemias.',4.4,'Various licensed manufacturers'),
(35,'Bleomycin',NULL,'Lung toxicity, fever, skin changes','Cytotoxic antibiotic used in selected lymphomas and germ-cell tumors.',4.5,'Various licensed manufacturers'),
(36,'Dacarbazine',NULL,'Nausea, low blood counts, fatigue','Alkylating-like chemotherapy medicine used in selected malignancies.',4.6,'Various licensed manufacturers'),
(37,'Temozolomide',NULL,'Fatigue, nausea, low blood counts','Oral alkylating medicine used mainly for selected brain tumors.',4.7,'Various licensed manufacturers'),
(38,'Procarbazine',NULL,'Nausea, low blood counts, fatigue','Alkylating medicine used in selected lymphoma regimens.',4.8,'Various licensed manufacturers'),
(39,'Irinotecan',NULL,'Diarrhea, low blood counts, nausea','Topoisomerase inhibitor used in selected gastrointestinal cancers.',4.9,'Various licensed manufacturers'),
(40,'Topotecan',NULL,'Low blood counts, nausea, fatigue','Topoisomerase inhibitor used in selected solid tumors.',4.0,'Various licensed manufacturers'),
(41,'Eribulin',NULL,'Low blood counts, neuropathy, fatigue','Microtubule inhibitor used in selected breast cancer and liposarcoma.',4.1,'Various licensed manufacturers'),
(42,'Vinorelbine',NULL,'Low blood counts, constipation, neuropathy','Vinca alkaloid used in selected lung and breast cancers.',4.2,'Various licensed manufacturers'),
(43,'Enzalutamide',NULL,'Fatigue, hypertension, falls','Androgen-receptor signaling inhibitor used in selected prostate cancer.',4.3,'Various licensed manufacturers'),
(44,'Abiraterone',NULL,'Hypertension, low potassium, liver enzyme changes','Androgen synthesis inhibitor used in selected prostate cancer.',4.4,'Various licensed manufacturers'),
(45,'Osimertinib',NULL,'Diarrhea, rash, nail changes, cardiac effects','EGFR tyrosine kinase inhibitor used in selected EGFR-mutated lung cancer.',4.5,'Various licensed manufacturers'),
(46,'Gefitinib',NULL,'Rash, diarrhea, dry skin','EGFR tyrosine kinase inhibitor used in selected lung cancers.',4.6,'Various licensed manufacturers'),
(47,'Crizotinib',NULL,'Visual disturbances, nausea, liver enzyme changes','ALK/ROS1-targeted tyrosine kinase inhibitor.',4.7,'Various licensed manufacturers'),
(48,'Ruxolitinib',NULL,'Low blood counts, infections, weight gain','JAK inhibitor used in selected myeloproliferative neoplasms.',4.8,'Various licensed manufacturers'),
(49,'Hydroxyurea',NULL,'Low blood counts, skin changes, gastrointestinal effects','Antimetabolite used in selected hematologic disorders.',4.9,'Various licensed manufacturers'),
(50,'Zoledronic acid',NULL,'Flu-like symptoms, low calcium, kidney toxicity','Bisphosphonate used for selected cancer-related bone complications.',4.0,'Various licensed manufacturers'),
(51,'Denosumab',NULL,'Low calcium, musculoskeletal pain, jaw osteonecrosis risk','RANKL inhibitor used for selected cancer-related bone complications.',4.1,'Various licensed manufacturers');

-- ===============================================================
-- 12. CANCER-MEDICINE
-- ===============================================================
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (1,3) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (1,9) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (1,16) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (2,5) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (2,14) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (2,23) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (3,7) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (3,19) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (3,30) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (4,9) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (4,24) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (4,37) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (5,11) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (5,29) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (5,44) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (6,13) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (6,34) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (6,51) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (7,7) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (7,15) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (7,39) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (8,14) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (8,17) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (8,44) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (9,19) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (9,21) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (9,49) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (10,3) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (10,21) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (10,28) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (11,8) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (11,23) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (11,35) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (12,13) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (12,25) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (12,42) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (13,18) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (13,27) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (13,49) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (14,5) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (14,23) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (14,29) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (15,12) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (15,28) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (15,31) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (16,19) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (16,33) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (17,26) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (17,35) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (17,38) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (18,33) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (18,37) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (18,43) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (19,39) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (19,40) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (19,48) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (20,2) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (20,41) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (20,47) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (21,3) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (21,7) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (21,43) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (22,10) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (22,12) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (22,45) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (23,17) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (23,47) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (24,22) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (24,24) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (24,49) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (25,27) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (25,31) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (25,51) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (26,2) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (26,32) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (26,38) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (27,4) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (27,37) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (27,45) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (28,1) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (28,6) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (28,42) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (29,8) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (29,47) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (30,1) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (30,10) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (30,15) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (31,6) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (31,12) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (31,22) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (32,11) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (32,14) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (32,29) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (33,16) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (33,36) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (34,18) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (34,21) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (34,43) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (35,20) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (35,26) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (35,50) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (36,6) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (36,22) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (36,31) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (37,13) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (37,24) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (37,36) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (38,20) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (38,26) ON CONFLICT DO NOTHING;
INSERT INTO cancer_medicine (cancer_id,medicine_id) VALUES (38,41) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 13. HOSPITAL-CANCER
-- ===============================================================
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (1,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (1,6) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (1,10) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (1,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (1,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (2,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (2,11) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (2,19) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (2,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (2,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (3,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (3,16) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (3,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (3,28) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (3,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (4,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (4,21) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (4,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (4,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (4,37) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (5,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (5,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (5,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (5,26) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (5,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (6,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (6,17) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (6,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (6,31) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (6,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (7,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (7,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (7,26) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (7,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (7,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (8,3) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (8,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (8,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (8,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (9,6) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (9,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (9,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (9,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (10,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (10,13) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (10,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (10,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (11,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (11,18) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (11,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (11,24) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (11,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (12,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (12,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (12,33) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (12,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (13,4) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (13,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (13,28) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (13,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (13,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (14,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (14,13) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (14,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (14,33) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (14,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (15,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (15,22) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (15,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (15,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (15,38) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (16,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (16,5) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (16,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (16,31) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (16,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (17,2) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (17,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (17,10) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (17,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (17,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (18,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (18,11) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (18,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (18,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (18,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (19,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (19,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (19,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (19,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (20,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (20,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (20,25) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (20,29) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (20,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (21,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (21,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (21,30) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (21,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (21,38) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (22,9) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (22,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (22,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (22,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (22,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (23,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (23,2) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (23,18) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (23,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (23,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (24,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (24,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (24,27) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (24,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (25,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (25,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (25,12) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (25,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (25,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (26,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (26,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (26,17) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (26,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (27,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (27,16) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (27,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (27,22) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (27,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (28,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (28,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (28,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (28,25) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (28,27) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (29,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (29,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (29,32) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (29,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (30,5) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (30,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (30,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (30,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (30,37) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (31,4) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (31,14) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (31,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (31,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (31,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (32,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (32,9) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (32,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (32,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (32,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (33,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (33,14) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (33,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (33,32) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (33,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (34,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (34,3) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (34,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (34,19) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (34,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (35,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (35,12) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (35,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (35,24) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (35,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (36,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (36,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (36,21) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (36,29) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (36,36) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (37,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (37,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (37,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (37,30) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (37,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (38,1) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (38,7) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (38,20) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (38,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (39,6) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (39,8) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (39,10) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (39,23) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (39,35) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (40,11) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (40,15) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (40,19) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (40,34) ON CONFLICT DO NOTHING;
INSERT INTO hospital_cancer (hospital_id,cancer_id) VALUES (40,36) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 14. DOCTOR-STAGE
-- ===============================================================
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (1,4,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (1,4,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (1,4,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (1,4,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (2,7,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (2,7,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (2,7,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (2,7,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (3,10,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (3,10,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (3,10,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (3,10,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (4,13,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (4,13,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (4,13,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (4,13,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (5,16,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (5,16,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (5,16,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (5,16,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (6,19,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (6,19,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (6,19,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (6,19,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (7,22,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (7,22,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (7,22,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (7,22,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (8,25,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (8,25,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (8,25,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (8,25,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (9,28,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (9,28,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (9,28,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (9,28,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (10,31,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (10,31,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (10,31,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (10,31,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (11,34,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (11,34,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (11,34,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (11,34,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (12,37,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (12,37,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (12,37,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (12,37,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (13,2,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (13,2,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (13,2,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (13,2,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (14,5,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (14,5,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (14,5,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (14,5,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (15,8,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (15,8,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (15,8,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (15,8,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (16,11,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (16,11,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (16,11,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (16,11,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (17,14,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (17,14,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (17,14,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (17,14,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (18,17,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (18,17,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (18,17,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (18,17,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (19,20,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (19,20,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (19,20,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (19,20,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (20,23,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (20,23,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (20,23,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (20,23,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (21,26,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (21,26,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (21,26,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (21,26,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (22,29,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (22,29,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (22,29,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (22,29,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (23,32,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (23,32,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (23,32,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (23,32,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (24,35,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (24,35,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (24,35,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (24,35,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (25,38,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (25,38,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (25,38,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (25,38,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (26,3,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (26,3,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (26,3,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (26,3,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (27,6,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (27,6,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (27,6,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (27,6,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (28,9,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (28,9,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (28,9,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (28,9,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (29,12,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (29,12,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (29,12,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (29,12,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (30,15,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (30,15,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (30,15,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (30,15,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (31,18,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (31,18,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (31,18,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (31,18,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (32,21,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (32,21,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (32,21,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (32,21,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (33,24,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (33,24,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (33,24,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (33,24,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (34,27,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (34,27,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (34,27,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (34,27,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (35,30,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (35,30,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (35,30,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (35,30,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (36,33,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (36,33,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (36,33,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (36,33,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (37,36,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (37,36,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (37,36,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (37,36,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (38,1,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (38,1,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (38,1,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (38,1,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (39,4,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (39,4,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (39,4,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (39,4,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (40,7,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (40,7,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (40,7,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (40,7,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (41,10,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (41,10,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (41,10,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (41,10,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (42,13,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (42,13,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (42,13,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (42,13,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (43,16,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (43,16,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (43,16,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (43,16,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (44,19,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (44,19,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (44,19,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (44,19,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (45,22,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (45,22,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (45,22,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (45,22,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (46,25,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (46,25,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (46,25,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (46,25,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (47,28,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (47,28,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (47,28,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (47,28,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (48,31,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (48,31,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (48,31,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (48,31,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (49,34,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (49,34,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (49,34,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (49,34,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (50,37,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (50,37,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (50,37,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (50,37,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (51,2,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (51,2,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (51,2,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (51,2,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (52,5,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (52,5,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (52,5,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (52,5,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (53,8,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (53,8,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (53,8,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (53,8,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (54,11,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (54,11,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (54,11,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (54,11,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (55,14,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (55,14,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (55,14,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (55,14,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (56,17,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (56,17,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (56,17,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (56,17,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (57,20,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (57,20,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (57,20,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (57,20,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (58,23,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (58,23,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (58,23,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (58,23,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (59,26,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (59,26,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (59,26,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (59,26,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (60,29,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (60,29,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (60,29,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (60,29,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (61,32,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (61,32,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (61,32,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (61,32,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (62,35,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (62,35,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (62,35,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (62,35,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (63,38,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (63,38,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (63,38,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (63,38,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (64,3,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (64,3,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (64,3,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (64,3,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (65,6,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (65,6,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (65,6,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (65,6,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (66,9,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (66,9,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (66,9,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (66,9,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (67,12,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (67,12,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (67,12,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (67,12,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (68,15,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (68,15,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (68,15,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (68,15,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (69,18,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (69,18,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (69,18,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (69,18,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (70,21,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (70,21,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (70,21,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (70,21,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (71,24,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (71,24,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (71,24,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (71,24,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (72,27,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (72,27,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (72,27,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (72,27,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (73,30,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (73,30,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (73,30,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (73,30,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (74,33,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (74,33,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (74,33,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (74,33,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (75,36,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (75,36,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (75,36,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (75,36,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (76,1,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (76,1,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (76,1,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (76,1,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (77,4,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (77,4,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (77,4,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (77,4,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (78,7,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (78,7,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (78,7,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (78,7,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (79,10,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (79,10,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (79,10,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (79,10,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (80,13,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (80,13,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (80,13,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (80,13,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (81,16,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (81,16,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (81,16,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (81,16,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (82,19,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (82,19,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (82,19,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (82,19,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (83,22,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (83,22,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (83,22,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (83,22,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (84,25,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (84,25,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (84,25,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (84,25,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (85,28,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (85,28,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (85,28,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (85,28,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (86,31,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (86,31,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (86,31,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (86,31,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (87,34,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (87,34,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (87,34,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (87,34,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (88,37,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (88,37,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (88,37,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (88,37,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (89,2,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (89,2,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (89,2,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (89,2,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (90,5,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (90,5,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (90,5,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (90,5,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (91,8,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (91,8,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (91,8,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (91,8,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (92,11,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (92,11,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (92,11,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (92,11,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (93,14,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (93,14,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (93,14,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (93,14,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (94,17,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (94,17,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (94,17,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (94,17,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (95,20,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (95,20,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (95,20,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (95,20,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (96,23,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (96,23,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (96,23,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (96,23,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (97,26,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (97,26,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (97,26,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (97,26,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (98,29,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (98,29,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (98,29,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (98,29,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (99,32,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (99,32,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (99,32,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (99,32,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (100,35,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (100,35,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (100,35,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (100,35,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (101,38,1) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (101,38,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (101,38,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_stage (doctor_id,cancer_id,stage_no) VALUES (101,38,4) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 15. DOCTOR REFERRAL
-- ===============================================================
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (1,2) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (2,3) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (3,4) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (4,5) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (5,6) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (6,7) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (7,8) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (8,9) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (9,10) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (10,11) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (11,12) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (12,13) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (13,14) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (14,15) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (15,16) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (16,17) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (17,18) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (18,19) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (19,20) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (20,21) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (21,22) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (22,23) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (23,24) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (24,25) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (25,26) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (26,27) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (27,28) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (28,29) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (29,30) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (30,31) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (31,32) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (32,33) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (33,34) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (34,35) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (35,36) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (36,37) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (37,38) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (38,39) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (39,40) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (40,41) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (41,42) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (42,43) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (43,44) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (44,45) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (45,46) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (46,47) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (47,48) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (48,49) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (49,50) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (50,51) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (51,52) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (52,53) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (53,54) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (54,55) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (55,56) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (56,57) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (57,58) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (58,59) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (59,60) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (60,61) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (61,62) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (62,63) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (63,64) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (64,65) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (65,66) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (66,67) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (67,68) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (68,69) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (69,70) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (70,71) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (71,72) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (72,73) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (73,74) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (74,75) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (75,76) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (76,77) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (77,78) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (78,79) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (79,80) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (80,81) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (81,82) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (82,83) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (83,84) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (84,85) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (85,86) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (86,87) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (87,88) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (88,89) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (89,90) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (90,91) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (91,92) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (92,93) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (93,94) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (94,95) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (95,96) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (96,97) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (97,98) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (98,99) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (99,100) ON CONFLICT DO NOTHING;
INSERT INTO doctor_referral (referring_doctor_id,referred_doctor_id) VALUES (100,101) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 16. ADMIN-DOCTOR ASSIGNMENT
-- ===============================================================
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2001,25,CURRENT_DATE - INTERVAL '2 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2001,38,CURRENT_DATE - INTERVAL '3 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2001,51,CURRENT_DATE - INTERVAL '4 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2001,64,CURRENT_DATE - INTERVAL '5 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2001,77,CURRENT_DATE - INTERVAL '6 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2002,36,CURRENT_DATE - INTERVAL '3 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2002,49,CURRENT_DATE - INTERVAL '4 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2002,62,CURRENT_DATE - INTERVAL '5 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2002,75,CURRENT_DATE - INTERVAL '6 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2002,88,CURRENT_DATE - INTERVAL '7 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2003,47,CURRENT_DATE - INTERVAL '4 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2003,60,CURRENT_DATE - INTERVAL '5 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2003,73,CURRENT_DATE - INTERVAL '6 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2003,86,CURRENT_DATE - INTERVAL '7 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2003,99,CURRENT_DATE - INTERVAL '8 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2004,58,CURRENT_DATE - INTERVAL '5 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2004,71,CURRENT_DATE - INTERVAL '6 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2004,84,CURRENT_DATE - INTERVAL '7 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2004,97,CURRENT_DATE - INTERVAL '8 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2004,9,CURRENT_DATE - INTERVAL '9 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2005,69,CURRENT_DATE - INTERVAL '6 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2005,82,CURRENT_DATE - INTERVAL '7 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2005,95,CURRENT_DATE - INTERVAL '8 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2005,7,CURRENT_DATE - INTERVAL '9 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2005,20,CURRENT_DATE - INTERVAL '10 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2006,80,CURRENT_DATE - INTERVAL '7 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2006,93,CURRENT_DATE - INTERVAL '8 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2006,5,CURRENT_DATE - INTERVAL '9 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2006,18,CURRENT_DATE - INTERVAL '10 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2006,31,CURRENT_DATE - INTERVAL '11 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2007,91,CURRENT_DATE - INTERVAL '8 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2007,3,CURRENT_DATE - INTERVAL '9 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2007,16,CURRENT_DATE - INTERVAL '10 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2007,29,CURRENT_DATE - INTERVAL '11 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2007,42,CURRENT_DATE - INTERVAL '12 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2008,1,CURRENT_DATE - INTERVAL '9 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2008,14,CURRENT_DATE - INTERVAL '10 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2008,27,CURRENT_DATE - INTERVAL '11 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2008,40,CURRENT_DATE - INTERVAL '12 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2008,53,CURRENT_DATE - INTERVAL '13 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2009,12,CURRENT_DATE - INTERVAL '10 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2009,25,CURRENT_DATE - INTERVAL '11 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2009,38,CURRENT_DATE - INTERVAL '12 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2009,51,CURRENT_DATE - INTERVAL '13 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2009,64,CURRENT_DATE - INTERVAL '14 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2010,23,CURRENT_DATE - INTERVAL '11 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2010,36,CURRENT_DATE - INTERVAL '12 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2010,49,CURRENT_DATE - INTERVAL '13 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2010,62,CURRENT_DATE - INTERVAL '14 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2010,75,CURRENT_DATE - INTERVAL '15 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2011,34,CURRENT_DATE - INTERVAL '12 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2011,47,CURRENT_DATE - INTERVAL '13 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2011,60,CURRENT_DATE - INTERVAL '14 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2011,73,CURRENT_DATE - INTERVAL '15 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2011,86,CURRENT_DATE - INTERVAL '16 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2012,45,CURRENT_DATE - INTERVAL '13 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2012,58,CURRENT_DATE - INTERVAL '14 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2012,71,CURRENT_DATE - INTERVAL '15 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2012,84,CURRENT_DATE - INTERVAL '16 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2012,97,CURRENT_DATE - INTERVAL '17 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2013,56,CURRENT_DATE - INTERVAL '14 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2013,69,CURRENT_DATE - INTERVAL '15 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2013,82,CURRENT_DATE - INTERVAL '16 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2013,95,CURRENT_DATE - INTERVAL '17 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2013,7,CURRENT_DATE - INTERVAL '18 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2014,67,CURRENT_DATE - INTERVAL '15 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2014,80,CURRENT_DATE - INTERVAL '16 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2014,93,CURRENT_DATE - INTERVAL '17 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2014,5,CURRENT_DATE - INTERVAL '18 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2014,18,CURRENT_DATE - INTERVAL '19 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2015,78,CURRENT_DATE - INTERVAL '16 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2015,91,CURRENT_DATE - INTERVAL '17 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2015,3,CURRENT_DATE - INTERVAL '18 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2015,16,CURRENT_DATE - INTERVAL '19 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2015,29,CURRENT_DATE - INTERVAL '20 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2016,89,CURRENT_DATE - INTERVAL '17 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2016,1,CURRENT_DATE - INTERVAL '18 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2016,14,CURRENT_DATE - INTERVAL '19 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2016,27,CURRENT_DATE - INTERVAL '20 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2016,40,CURRENT_DATE - INTERVAL '21 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2017,100,CURRENT_DATE - INTERVAL '18 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2017,12,CURRENT_DATE - INTERVAL '19 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2017,25,CURRENT_DATE - INTERVAL '20 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2017,38,CURRENT_DATE - INTERVAL '21 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2017,51,CURRENT_DATE - INTERVAL '22 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2018,10,CURRENT_DATE - INTERVAL '19 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2018,23,CURRENT_DATE - INTERVAL '20 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2018,36,CURRENT_DATE - INTERVAL '21 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2018,49,CURRENT_DATE - INTERVAL '22 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2018,62,CURRENT_DATE - INTERVAL '23 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2019,21,CURRENT_DATE - INTERVAL '20 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2019,34,CURRENT_DATE - INTERVAL '21 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2019,47,CURRENT_DATE - INTERVAL '22 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2019,60,CURRENT_DATE - INTERVAL '23 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2019,73,CURRENT_DATE - INTERVAL '24 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2020,32,CURRENT_DATE - INTERVAL '21 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2020,45,CURRENT_DATE - INTERVAL '22 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2020,58,CURRENT_DATE - INTERVAL '23 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2020,71,CURRENT_DATE - INTERVAL '24 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2020,84,CURRENT_DATE - INTERVAL '25 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2021,43,CURRENT_DATE - INTERVAL '22 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2021,56,CURRENT_DATE - INTERVAL '23 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2021,69,CURRENT_DATE - INTERVAL '24 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2021,82,CURRENT_DATE - INTERVAL '25 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2021,95,CURRENT_DATE - INTERVAL '26 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2022,54,CURRENT_DATE - INTERVAL '23 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2022,67,CURRENT_DATE - INTERVAL '24 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2022,80,CURRENT_DATE - INTERVAL '25 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2022,93,CURRENT_DATE - INTERVAL '26 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2022,5,CURRENT_DATE - INTERVAL '27 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2023,65,CURRENT_DATE - INTERVAL '24 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2023,78,CURRENT_DATE - INTERVAL '25 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2023,91,CURRENT_DATE - INTERVAL '26 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2023,3,CURRENT_DATE - INTERVAL '27 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2023,16,CURRENT_DATE - INTERVAL '28 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2024,76,CURRENT_DATE - INTERVAL '25 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2024,89,CURRENT_DATE - INTERVAL '26 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2024,1,CURRENT_DATE - INTERVAL '27 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2024,14,CURRENT_DATE - INTERVAL '28 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2024,27,CURRENT_DATE - INTERVAL '29 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2025,87,CURRENT_DATE - INTERVAL '26 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2025,100,CURRENT_DATE - INTERVAL '27 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2025,12,CURRENT_DATE - INTERVAL '28 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2025,25,CURRENT_DATE - INTERVAL '29 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2025,38,CURRENT_DATE - INTERVAL '30 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2026,98,CURRENT_DATE - INTERVAL '27 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2026,10,CURRENT_DATE - INTERVAL '28 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2026,23,CURRENT_DATE - INTERVAL '29 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2026,36,CURRENT_DATE - INTERVAL '30 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2026,49,CURRENT_DATE - INTERVAL '31 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2027,8,CURRENT_DATE - INTERVAL '28 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2027,21,CURRENT_DATE - INTERVAL '29 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2027,34,CURRENT_DATE - INTERVAL '30 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2027,47,CURRENT_DATE - INTERVAL '31 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2027,60,CURRENT_DATE - INTERVAL '32 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2028,19,CURRENT_DATE - INTERVAL '29 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2028,32,CURRENT_DATE - INTERVAL '30 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2028,45,CURRENT_DATE - INTERVAL '31 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2028,58,CURRENT_DATE - INTERVAL '32 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2028,71,CURRENT_DATE - INTERVAL '33 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2029,30,CURRENT_DATE - INTERVAL '30 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2029,43,CURRENT_DATE - INTERVAL '31 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2029,56,CURRENT_DATE - INTERVAL '32 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2029,69,CURRENT_DATE - INTERVAL '33 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2029,82,CURRENT_DATE - INTERVAL '34 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2030,41,CURRENT_DATE - INTERVAL '31 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2030,54,CURRENT_DATE - INTERVAL '32 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2030,67,CURRENT_DATE - INTERVAL '33 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2030,80,CURRENT_DATE - INTERVAL '34 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2030,93,CURRENT_DATE - INTERVAL '35 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2031,52,CURRENT_DATE - INTERVAL '32 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2031,65,CURRENT_DATE - INTERVAL '33 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2031,78,CURRENT_DATE - INTERVAL '34 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2031,91,CURRENT_DATE - INTERVAL '35 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2031,3,CURRENT_DATE - INTERVAL '36 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2032,63,CURRENT_DATE - INTERVAL '33 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2032,76,CURRENT_DATE - INTERVAL '34 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2032,89,CURRENT_DATE - INTERVAL '35 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2032,1,CURRENT_DATE - INTERVAL '36 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2032,14,CURRENT_DATE - INTERVAL '37 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2033,74,CURRENT_DATE - INTERVAL '34 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2033,87,CURRENT_DATE - INTERVAL '35 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2033,100,CURRENT_DATE - INTERVAL '36 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2033,12,CURRENT_DATE - INTERVAL '37 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2033,25,CURRENT_DATE - INTERVAL '38 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2034,85,CURRENT_DATE - INTERVAL '35 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2034,98,CURRENT_DATE - INTERVAL '36 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2034,10,CURRENT_DATE - INTERVAL '37 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2034,23,CURRENT_DATE - INTERVAL '38 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2034,36,CURRENT_DATE - INTERVAL '39 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2035,96,CURRENT_DATE - INTERVAL '36 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2035,8,CURRENT_DATE - INTERVAL '37 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2035,21,CURRENT_DATE - INTERVAL '38 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2035,34,CURRENT_DATE - INTERVAL '39 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2035,47,CURRENT_DATE - INTERVAL '40 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2036,6,CURRENT_DATE - INTERVAL '37 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2036,19,CURRENT_DATE - INTERVAL '38 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2036,32,CURRENT_DATE - INTERVAL '39 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2036,45,CURRENT_DATE - INTERVAL '40 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2036,58,CURRENT_DATE - INTERVAL '41 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2037,17,CURRENT_DATE - INTERVAL '38 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2037,30,CURRENT_DATE - INTERVAL '39 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2037,43,CURRENT_DATE - INTERVAL '40 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2037,56,CURRENT_DATE - INTERVAL '41 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2037,69,CURRENT_DATE - INTERVAL '42 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2038,28,CURRENT_DATE - INTERVAL '39 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2038,41,CURRENT_DATE - INTERVAL '40 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2038,54,CURRENT_DATE - INTERVAL '41 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2038,67,CURRENT_DATE - INTERVAL '42 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2038,80,CURRENT_DATE - INTERVAL '43 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2039,39,CURRENT_DATE - INTERVAL '40 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2039,52,CURRENT_DATE - INTERVAL '41 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2039,65,CURRENT_DATE - INTERVAL '42 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2039,78,CURRENT_DATE - INTERVAL '43 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2039,91,CURRENT_DATE - INTERVAL '44 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2040,50,CURRENT_DATE - INTERVAL '41 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2040,63,CURRENT_DATE - INTERVAL '42 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2040,76,CURRENT_DATE - INTERVAL '43 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2040,89,CURRENT_DATE - INTERVAL '44 days') ON CONFLICT DO NOTHING;
INSERT INTO admin_doctor_assignment (admin_id,doctor_id,assignment_date) VALUES (2040,1,CURRENT_DATE - INTERVAL '45 days') ON CONFLICT DO NOTHING;

-- ===============================================================
-- 17. PATIENT-STAGE DIAGNOSIS
-- ===============================================================
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1001,8,4,'2022-03-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1002,15,3,'2023-05-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1003,22,2,'2024-07-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1004,29,1,'2025-09-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1005,36,4,'2026-11-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1006,5,3,'2022-01-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1007,12,2,'2023-03-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1008,19,1,'2024-05-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1009,26,4,'2025-07-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1010,33,3,'2026-09-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1011,2,2,'2022-11-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1012,9,1,'2023-01-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1013,16,4,'2024-03-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1014,23,3,'2025-05-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1015,30,2,'2026-07-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1016,37,1,'2022-09-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1017,6,4,'2023-11-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1018,13,3,'2024-01-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1019,20,2,'2025-03-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1020,27,1,'2026-05-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1021,34,4,'2022-07-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1022,3,3,'2023-09-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1023,10,2,'2024-11-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1024,17,1,'2025-01-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1025,24,4,'2026-03-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1026,31,3,'2022-05-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1027,38,2,'2023-07-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1028,7,1,'2024-09-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1029,14,4,'2025-11-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1030,21,3,'2026-01-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1031,28,2,'2022-03-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1032,35,1,'2023-05-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1033,4,4,'2024-07-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1034,11,3,'2025-09-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1035,18,2,'2026-11-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1036,25,1,'2022-01-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1037,32,4,'2023-03-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1038,1,3,'2024-05-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1039,8,2,'2025-07-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1040,15,1,'2026-09-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1041,22,4,'2022-11-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1042,29,3,'2023-01-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1043,36,2,'2024-03-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1044,5,1,'2025-05-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1045,12,4,'2026-07-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1046,19,3,'2022-09-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1047,26,2,'2023-11-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1048,33,1,'2024-01-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1049,2,4,'2025-03-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1050,9,3,'2026-05-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1051,16,2,'2022-07-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1052,23,1,'2023-09-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1053,30,4,'2024-11-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1054,37,3,'2025-01-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1055,6,2,'2026-03-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1056,13,1,'2022-05-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1057,20,4,'2023-07-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1058,27,3,'2024-09-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1059,34,2,'2025-11-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1060,3,1,'2026-01-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1061,10,4,'2022-03-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1062,17,3,'2023-05-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1063,24,2,'2024-07-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1064,31,1,'2025-09-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1065,38,4,'2026-11-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1066,7,3,'2022-01-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1067,14,2,'2023-03-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1068,21,1,'2024-05-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1069,28,4,'2025-07-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1070,35,3,'2026-09-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1071,4,2,'2022-11-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1072,11,1,'2023-01-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1073,18,4,'2024-03-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1074,25,3,'2025-05-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1075,32,2,'2026-07-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1076,1,1,'2022-09-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1077,8,4,'2023-11-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1078,15,3,'2024-01-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1079,22,2,'2025-03-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1080,29,1,'2026-05-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1081,36,4,'2022-07-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1082,5,3,'2023-09-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1083,12,2,'2024-11-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1084,19,1,'2025-01-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1085,26,4,'2026-03-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1086,33,3,'2022-05-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1087,2,2,'2023-07-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1088,9,1,'2024-09-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1089,16,4,'2025-11-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1090,23,3,'2026-01-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1091,30,2,'2022-03-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1092,37,1,'2023-05-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1093,6,4,'2024-07-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1094,13,3,'2025-09-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1095,20,2,'2026-11-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1096,27,1,'2022-01-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1097,34,4,'2023-03-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1098,3,3,'2024-05-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1099,10,2,'2025-07-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1100,17,1,'2026-09-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1101,24,4,'2022-11-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1102,31,3,'2023-01-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1103,38,2,'2024-03-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1104,7,1,'2025-05-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1105,14,4,'2026-07-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1106,21,3,'2022-09-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1107,28,2,'2023-11-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1108,35,1,'2024-01-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1109,4,4,'2025-03-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1110,11,3,'2026-05-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1111,18,2,'2022-07-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1112,25,1,'2023-09-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1113,32,4,'2024-11-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1114,1,3,'2025-01-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1115,8,2,'2026-03-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1116,15,1,'2022-05-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1117,22,4,'2023-07-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1118,29,3,'2024-09-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1119,36,2,'2025-11-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1120,5,1,'2026-01-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1121,12,4,'2022-03-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1122,19,3,'2023-05-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1123,26,2,'2024-07-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1124,33,1,'2025-09-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1125,2,4,'2026-11-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1126,9,3,'2022-01-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1127,16,2,'2023-03-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1128,23,1,'2024-05-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1129,30,4,'2025-07-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1130,37,3,'2026-09-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1131,6,2,'2022-11-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1132,13,1,'2023-01-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1133,20,4,'2024-03-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1134,27,3,'2025-05-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1135,34,2,'2026-07-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1136,3,1,'2022-09-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1137,10,4,'2023-11-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1138,17,3,'2024-01-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1139,24,2,'2025-03-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1140,31,1,'2026-05-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1141,38,4,'2022-07-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1142,7,3,'2023-09-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1143,14,2,'2024-11-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1144,21,1,'2025-01-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1145,28,4,'2026-03-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1146,35,3,'2022-05-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1147,4,2,'2023-07-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1148,11,1,'2024-09-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1149,18,4,'2025-11-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1150,25,3,'2026-01-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1001,32,2,'2022-03-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1002,1,1,'2023-05-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1003,8,4,'2024-07-10');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1004,15,3,'2025-09-15');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1005,22,2,'2026-11-20');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1006,29,1,'2022-01-25');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1007,36,4,'2023-03-03');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1008,5,3,'2024-05-08');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1009,12,2,'2025-07-13');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1010,19,1,'2026-09-18');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1011,26,4,'2022-11-23');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1012,33,3,'2023-01-01');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1013,2,2,'2024-03-06');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1014,9,1,'2025-05-11');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1015,16,4,'2026-07-16');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1016,23,3,'2022-09-21');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1017,30,2,'2023-11-26');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1018,37,1,'2024-01-04');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1019,6,4,'2025-03-09');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1020,13,3,'2026-05-14');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1021,20,2,'2022-07-19');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1022,27,1,'2023-09-24');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1023,34,4,'2024-11-02');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1024,3,3,'2025-01-07');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1025,10,2,'2026-03-12');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1026,17,1,'2022-05-17');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1027,24,4,'2023-07-22');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1028,31,3,'2024-09-27');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1029,38,2,'2025-11-05');
INSERT INTO patient_stage_diagnosis (patient_id,cancer_id,stage_no,diagnosis_date) VALUES (1030,7,1,'2026-01-10');

-- ===============================================================
-- 18. PRESCRIPTIONS
-- ===============================================================
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (18,1012,'2023-04-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (35,1023,'2024-07-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (52,1034,'2025-10-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (69,1045,'2026-01-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (86,1056,'2023-04-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (2,1067,'2024-07-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (19,1078,'2025-10-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (36,1089,'2026-01-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (53,1100,'2023-04-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (70,1111,'2024-07-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (87,1122,'2025-10-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (3,1133,'2026-01-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (20,1144,'2023-04-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (37,1005,'2024-07-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (54,1016,'2025-10-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (71,1027,'2026-01-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (88,1038,'2023-04-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (4,1049,'2024-07-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (21,1060,'2025-10-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (38,1071,'2026-01-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (55,1082,'2023-04-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (72,1093,'2024-07-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (89,1104,'2025-10-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (5,1115,'2026-01-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (22,1126,'2023-04-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (39,1137,'2024-07-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (56,1148,'2025-10-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (73,1009,'2026-01-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (90,1020,'2023-04-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (6,1031,'2024-07-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (23,1042,'2025-10-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (40,1053,'2026-01-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (57,1064,'2023-04-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (74,1075,'2024-07-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (91,1086,'2025-10-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (7,1097,'2026-01-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (24,1108,'2023-04-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (41,1119,'2024-07-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (58,1130,'2025-10-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (75,1141,'2026-01-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (92,1002,'2023-04-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (8,1013,'2024-07-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (25,1024,'2025-10-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (42,1035,'2026-01-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (59,1046,'2023-04-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (76,1057,'2024-07-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (93,1068,'2025-10-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (9,1079,'2026-01-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (26,1090,'2023-04-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (43,1101,'2024-07-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (60,1112,'2025-10-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (77,1123,'2026-01-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (94,1134,'2023-04-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (10,1145,'2024-07-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (27,1006,'2025-10-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (44,1017,'2026-01-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (61,1028,'2023-04-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (78,1039,'2024-07-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (95,1050,'2025-10-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (11,1061,'2026-01-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (28,1072,'2023-04-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (45,1083,'2024-07-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (62,1094,'2025-10-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (79,1105,'2026-01-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (96,1116,'2023-04-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (12,1127,'2024-07-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (29,1138,'2025-10-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (46,1149,'2026-01-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (63,1010,'2023-04-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (80,1021,'2024-07-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (97,1032,'2025-10-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (13,1043,'2026-01-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (30,1054,'2023-04-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (47,1065,'2024-07-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (64,1076,'2025-10-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (81,1087,'2026-01-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (98,1098,'2023-04-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (14,1109,'2024-07-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (31,1120,'2025-10-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (48,1131,'2026-01-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (65,1142,'2023-04-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (82,1003,'2024-07-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (99,1014,'2025-10-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (15,1025,'2026-01-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (32,1036,'2023-04-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (49,1047,'2024-07-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (66,1058,'2025-10-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (83,1069,'2026-01-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (100,1080,'2023-04-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (16,1091,'2024-07-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (33,1102,'2025-10-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (50,1113,'2026-01-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (67,1124,'2023-04-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (84,1135,'2024-07-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (101,1146,'2025-10-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (17,1007,'2026-01-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (34,1018,'2023-04-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (51,1029,'2024-07-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (68,1040,'2025-10-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (85,1051,'2026-01-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (1,1062,'2023-04-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (18,1073,'2024-07-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (35,1084,'2025-10-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (52,1095,'2026-01-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (69,1106,'2023-04-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (86,1117,'2024-07-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (2,1128,'2025-10-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (19,1139,'2026-01-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (36,1150,'2023-04-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (53,1011,'2024-07-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (70,1022,'2025-10-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (87,1033,'2026-01-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (3,1044,'2023-04-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (20,1055,'2024-07-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (37,1066,'2025-10-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (54,1077,'2026-01-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (71,1088,'2023-04-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (88,1099,'2024-07-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (4,1110,'2025-10-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (21,1121,'2026-01-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (38,1132,'2023-04-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (55,1143,'2024-07-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (72,1004,'2025-10-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (89,1015,'2026-01-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (5,1026,'2023-04-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (22,1037,'2024-07-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (39,1048,'2025-10-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (56,1059,'2026-01-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (73,1070,'2023-04-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (90,1081,'2024-07-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (6,1092,'2025-10-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (23,1103,'2026-01-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (40,1114,'2023-04-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (57,1125,'2024-07-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (74,1136,'2025-10-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (91,1147,'2026-01-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (7,1008,'2023-04-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (24,1019,'2024-07-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (41,1030,'2025-10-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (58,1041,'2026-01-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (75,1052,'2023-04-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (92,1063,'2024-07-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (8,1074,'2025-10-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (25,1085,'2026-01-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (42,1096,'2023-04-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (59,1107,'2024-07-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (76,1118,'2025-10-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (93,1129,'2026-01-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (9,1140,'2023-04-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (26,1001,'2024-07-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (43,1012,'2025-10-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (60,1023,'2026-01-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (77,1034,'2023-04-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (94,1045,'2024-07-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (10,1056,'2025-10-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (27,1067,'2026-01-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (44,1078,'2023-04-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (61,1089,'2024-07-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (78,1100,'2025-10-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (95,1111,'2026-01-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (11,1122,'2023-04-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (28,1133,'2024-07-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (45,1144,'2025-10-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (62,1005,'2026-01-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (79,1016,'2023-04-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (96,1027,'2024-07-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (12,1038,'2025-10-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (29,1049,'2026-01-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (46,1060,'2023-04-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (63,1071,'2024-07-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (80,1082,'2025-10-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (97,1093,'2026-01-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (13,1104,'2023-04-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (30,1115,'2024-07-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (47,1126,'2025-10-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (64,1137,'2026-01-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (81,1148,'2023-04-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (98,1009,'2024-07-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (14,1020,'2025-10-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (31,1031,'2026-01-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (48,1042,'2023-04-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (65,1053,'2024-07-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (82,1064,'2025-10-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (99,1075,'2026-01-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (15,1086,'2023-04-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (32,1097,'2024-07-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (49,1108,'2025-10-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (66,1119,'2026-01-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (83,1130,'2023-04-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (100,1141,'2024-07-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (16,1002,'2025-10-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (33,1013,'2026-01-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (50,1024,'2023-04-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (67,1035,'2024-07-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (84,1046,'2025-10-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (101,1057,'2026-01-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (17,1068,'2023-04-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (34,1079,'2024-07-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (51,1090,'2025-10-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (68,1101,'2026-01-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (85,1112,'2023-04-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (1,1123,'2024-07-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (18,1134,'2025-10-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (35,1145,'2026-01-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (52,1006,'2023-04-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (69,1017,'2024-07-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (86,1028,'2025-10-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (2,1039,'2026-01-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (19,1050,'2023-04-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (36,1061,'2024-07-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (53,1072,'2025-10-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (70,1083,'2026-01-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (87,1094,'2023-04-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (3,1105,'2024-07-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (20,1116,'2025-10-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (37,1127,'2026-01-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (54,1138,'2023-04-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (71,1149,'2024-07-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (88,1010,'2025-10-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (4,1021,'2026-01-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (21,1032,'2023-04-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (38,1043,'2024-07-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (55,1054,'2025-10-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (72,1065,'2026-01-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (89,1076,'2023-04-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (5,1087,'2024-07-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (22,1098,'2025-10-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (39,1109,'2026-01-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (56,1120,'2023-04-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (73,1131,'2024-07-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (90,1142,'2025-10-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (6,1003,'2026-01-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (23,1014,'2023-04-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (40,1025,'2024-07-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (57,1036,'2025-10-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (74,1047,'2026-01-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (91,1058,'2023-04-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (7,1069,'2024-07-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (24,1080,'2025-10-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (41,1091,'2026-01-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (58,1102,'2023-04-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (75,1113,'2024-07-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (92,1124,'2025-10-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (8,1135,'2026-01-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (25,1146,'2023-04-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (42,1007,'2024-07-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (59,1018,'2025-10-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (76,1029,'2026-01-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (93,1040,'2023-04-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (9,1051,'2024-07-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (26,1062,'2025-10-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (43,1073,'2026-01-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (60,1084,'2023-04-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (77,1095,'2024-07-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (94,1106,'2025-10-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (10,1117,'2026-01-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (27,1128,'2023-04-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (44,1139,'2024-07-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (61,1150,'2025-10-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (78,1011,'2026-01-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (95,1022,'2023-04-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (11,1033,'2024-07-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (28,1044,'2025-10-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (45,1055,'2026-01-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (62,1066,'2023-04-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (79,1077,'2024-07-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (96,1088,'2025-10-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (12,1099,'2026-01-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (29,1110,'2023-04-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (46,1121,'2024-07-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (63,1132,'2025-10-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (80,1143,'2026-01-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (97,1004,'2023-04-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (13,1015,'2024-07-02','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (30,1026,'2025-10-09','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (47,1037,'2026-01-16','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (64,1048,'2023-04-23','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (81,1059,'2024-07-03','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (98,1070,'2025-10-10','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (14,1081,'2026-01-17','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (31,1092,'2023-04-24','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (48,1103,'2024-07-04','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (65,1114,'2025-10-11','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (82,1125,'2026-01-18','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (99,1136,'2023-04-25','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (15,1147,'2024-07-05','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (32,1008,'2025-10-12','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (49,1019,'2026-01-19','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (66,1030,'2023-04-26','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (83,1041,'2024-07-06','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (100,1052,'2025-10-13','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (16,1063,'2026-01-20','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (33,1074,'2023-04-27','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (50,1085,'2024-07-07','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (67,1096,'2025-10-14','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (84,1107,'2026-01-21','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (101,1118,'2023-04-01','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (17,1129,'2024-07-08','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (34,1140,'2025-10-15','DEMO prescription record for database workflow testing; not a treatment recommendation.');
INSERT INTO prescriptions (doctor_id,patient_id,prescription_date,description) VALUES (51,1001,'2026-01-22','DEMO prescription record for database workflow testing; not a treatment recommendation.');

-- ===============================================================
-- 19. PRESCRIPTION-MEDICINE
-- ===============================================================
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (1,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (1,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (2,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (2,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (2,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (3,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (4,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (4,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (5,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (5,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (5,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (6,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (7,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (7,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (8,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (8,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (8,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (9,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (10,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (10,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (11,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (11,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (11,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (12,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (13,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (13,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (14,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (14,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (14,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (15,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (16,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (16,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (17,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (17,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (17,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (18,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (19,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (19,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (20,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (20,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (20,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (21,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (22,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (22,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (23,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (23,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (23,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (24,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (25,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (25,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (26,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (26,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (26,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (27,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (28,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (28,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (29,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (29,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (29,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (30,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (31,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (31,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (32,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (32,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (32,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (33,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (34,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (34,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (35,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (35,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (35,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (36,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (37,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (37,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (38,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (38,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (38,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (39,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (40,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (40,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (41,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (41,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (41,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (42,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (43,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (43,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (44,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (44,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (44,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (45,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (46,34,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (46,41,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (47,39,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (47,46,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (47,2,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (48,44,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (49,49,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (49,5,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (50,3,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (50,10,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (50,17,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (51,8,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (52,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (52,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (53,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (53,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (53,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (54,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (55,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (55,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (56,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (56,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (56,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (57,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (58,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (58,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (59,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (59,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (59,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (60,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (61,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (61,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (62,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (62,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (62,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (63,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (64,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (64,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (65,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (65,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (65,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (66,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (67,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (67,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (68,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (68,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (68,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (69,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (70,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (70,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (71,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (71,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (71,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (72,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (73,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (73,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (74,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (74,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (74,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (75,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (76,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (76,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (77,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (77,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (77,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (78,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (79,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (79,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (80,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (80,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (80,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (81,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (82,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (82,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (83,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (83,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (83,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (84,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (85,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (85,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (86,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (86,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (86,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (87,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (88,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (88,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (89,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (89,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (89,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (90,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (91,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (91,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (92,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (92,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (92,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (93,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (94,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (94,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (95,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (95,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (95,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (96,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (97,34,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (97,41,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (98,39,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (98,46,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (98,2,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (99,44,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (100,49,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (100,5,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (101,3,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (101,10,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (101,17,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (102,8,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (103,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (103,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (104,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (104,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (104,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (105,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (106,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (106,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (107,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (107,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (107,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (108,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (109,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (109,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (110,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (110,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (110,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (111,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (112,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (112,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (113,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (113,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (113,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (114,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (115,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (115,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (116,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (116,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (116,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (117,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (118,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (118,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (119,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (119,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (119,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (120,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (121,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (121,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (122,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (122,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (122,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (123,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (124,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (124,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (125,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (125,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (125,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (126,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (127,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (127,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (128,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (128,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (128,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (129,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (130,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (130,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (131,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (131,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (131,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (132,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (133,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (133,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (134,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (134,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (134,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (135,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (136,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (136,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (137,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (137,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (137,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (138,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (139,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (139,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (140,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (140,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (140,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (141,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (142,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (142,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (143,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (143,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (143,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (144,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (145,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (145,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (146,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (146,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (146,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (147,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (148,34,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (148,41,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (149,39,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (149,46,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (149,2,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (150,44,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (151,49,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (151,5,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (152,3,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (152,10,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (152,17,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (153,8,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (154,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (154,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (155,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (155,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (155,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (156,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (157,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (157,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (158,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (158,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (158,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (159,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (160,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (160,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (161,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (161,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (161,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (162,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (163,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (163,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (164,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (164,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (164,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (165,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (166,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (166,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (167,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (167,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (167,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (168,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (169,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (169,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (170,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (170,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (170,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (171,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (172,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (172,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (173,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (173,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (173,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (174,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (175,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (175,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (176,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (176,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (176,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (177,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (178,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (178,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (179,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (179,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (179,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (180,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (181,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (181,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (182,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (182,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (182,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (183,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (184,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (184,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (185,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (185,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (185,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (186,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (187,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (187,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (188,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (188,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (188,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (189,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (190,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (190,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (191,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (191,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (191,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (192,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (193,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (193,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (194,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (194,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (194,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (195,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (196,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (196,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (197,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (197,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (197,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (198,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (199,34,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (199,41,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (200,39,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (200,46,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (200,2,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (201,44,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (202,49,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (202,5,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (203,3,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (203,10,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (203,17,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (204,8,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (205,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (205,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (206,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (206,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (206,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (207,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (208,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (208,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (209,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (209,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (209,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (210,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (211,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (211,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (212,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (212,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (212,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (213,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (214,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (214,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (215,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (215,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (215,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (216,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (217,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (217,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (218,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (218,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (218,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (219,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (220,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (220,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (221,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (221,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (221,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (222,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (223,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (223,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (224,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (224,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (224,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (225,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (226,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (226,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (227,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (227,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (227,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (228,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (229,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (229,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (230,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (230,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (230,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (231,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (232,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (232,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (233,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (233,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (233,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (234,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (235,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (235,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (236,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (236,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (236,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (237,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (238,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (238,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (239,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (239,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (239,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (240,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (241,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (241,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (242,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (242,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (242,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (243,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (244,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (244,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (245,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (245,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (245,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (246,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (247,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (247,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (248,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (248,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (248,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (249,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (250,34,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (250,41,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (251,39,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (251,46,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (251,2,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (252,44,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (253,49,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (253,5,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (254,3,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (254,10,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (254,17,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (255,8,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (256,13,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (256,20,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (257,18,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (257,25,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (257,32,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (258,23,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (259,28,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (259,35,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (260,33,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (260,40,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (260,47,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (261,38,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (262,43,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (262,50,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (263,48,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (263,4,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (263,11,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (264,2,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (265,7,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (265,14,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (266,12,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (266,19,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (266,26,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (267,17,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (268,22,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (268,29,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (269,27,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (269,34,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (269,41,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (270,32,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (271,37,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (271,44,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (272,42,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (272,49,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (272,5,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (273,47,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (274,1,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (274,8,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (275,6,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (275,13,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (275,20,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (276,11,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (277,16,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (277,23,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (278,21,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (278,28,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (278,35,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (279,26,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (280,31,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (280,38,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (281,36,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (281,43,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (281,50,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (282,41,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (283,46,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (283,2,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (284,51,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (284,7,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (284,14,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (285,5,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (286,10,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (286,17,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (287,15,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (287,22,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (287,29,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (288,20,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (289,25,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (289,32,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (290,30,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (290,37,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (290,44,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (291,35,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (292,40,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (292,47,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (293,45,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (293,1,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (293,8,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (294,50,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (295,4,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (295,11,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (296,9,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (296,16,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (296,23,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (297,14,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (298,19,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (298,26,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (299,24,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (299,31,'Demo: infusion per protocol','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (299,38,'Demo: supportive medication','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;
INSERT INTO prescription_medicine (prescription_id,medicine_id,dosage,description) VALUES (300,29,'Demo: once daily','Synthetic seed record; actual dosage must come from a licensed clinician.') ON CONFLICT DO NOTHING;

-- ===============================================================
-- 20. PATIENT-BLOGPOST
-- ===============================================================
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1008,6,'2026-03-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1015,11,'2026-05-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1022,16,'2026-07-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1029,21,'2026-01-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1036,26,'2026-03-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1043,1,'2026-05-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1050,6,'2026-07-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1057,11,'2026-01-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1064,16,'2026-03-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1071,21,'2026-05-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1078,26,'2026-07-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1085,1,'2026-01-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1092,6,'2026-03-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1099,11,'2026-05-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1106,16,'2026-07-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1113,21,'2026-01-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1120,26,'2026-03-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1127,1,'2026-05-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1134,6,'2026-07-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1141,11,'2026-01-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1148,16,'2026-03-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1005,21,'2026-05-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1012,26,'2026-07-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1019,1,'2026-01-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1026,6,'2026-03-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1033,11,'2026-05-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1040,16,'2026-07-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1047,21,'2026-01-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1054,26,'2026-03-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1061,1,'2026-05-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1068,6,'2026-07-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1075,11,'2026-01-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1082,16,'2026-03-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1089,21,'2026-05-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1096,26,'2026-07-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1103,1,'2026-01-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1110,6,'2026-03-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1117,11,'2026-05-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1124,16,'2026-07-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1131,21,'2026-01-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1138,26,'2026-03-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1145,1,'2026-05-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1002,6,'2026-07-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1009,11,'2026-01-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1016,16,'2026-03-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1023,21,'2026-05-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1030,26,'2026-07-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1037,1,'2026-01-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1044,6,'2026-03-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1051,11,'2026-05-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1058,16,'2026-07-19') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1065,21,'2026-01-22') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1072,26,'2026-03-25') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1079,1,'2026-05-01') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1086,6,'2026-07-04') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1093,11,'2026-01-07') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1100,16,'2026-03-10') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1107,21,'2026-05-13') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1114,26,'2026-07-16') ON CONFLICT DO NOTHING;
INSERT INTO patient_blogpost (patient_id,blog_id,write_date) VALUES (1121,1,'2026-01-19') ON CONFLICT DO NOTHING;

-- ===============================================================
-- 21. BLOG-DOCTOR / BLOG-HOSPITAL RATINGS
-- ===============================================================
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,8,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,15,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,22,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,29,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,36,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,43,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,50,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,57,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,64,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,71,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,78,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,85,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,92,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,99,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,5,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,12,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,19,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,26,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,33,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,40,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,47,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,54,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,61,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,68,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,75,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,82,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,89,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,96,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,2,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,9,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,16,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,23,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,30,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,37,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,44,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,51,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,58,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,65,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,72,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,79,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,86,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,93,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,100,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,6,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,13,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,20,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,27,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,34,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,41,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,48,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,55,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,62,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,69,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,76,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,83,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,90,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,97,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,3,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,10,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,17,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,24,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,31,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,38,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,45,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,52,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,59,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,66,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,73,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,80,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,87,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,94,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,101,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,7,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,14,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,21,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,28,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,35,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,42,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,49,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,56,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,63,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,70,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,77,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,84,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,91,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,98,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,4,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,11,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,18,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,25,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (4,32,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (7,39,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (10,46,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (13,53,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (16,60,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (19,67,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (22,74,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (25,81,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (28,88,3.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_doctor (blog_id,doctor_id,rating) VALUES (1,95,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,12,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,23,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,34,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,5,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,16,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,27,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,38,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,9,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,20,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,31,4.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,2,3.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,13,3.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,24,4.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,35,4.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,6,3.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,17,4.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,28,4.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,39,3.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,10,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,21,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,32,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,3,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,14,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,25,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,36,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,7,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,18,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,29,4.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,40,3.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,11,3.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,22,4.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,33,4.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,4,3.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,15,4.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,26,4.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,37,3.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,8,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,19,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,30,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,1,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,12,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,23,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,34,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,5,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,16,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,27,4.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,38,3.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,9,3.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,20,4.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,31,4.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,2,3.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,13,4.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,24,4.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,35,3.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,6,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,17,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,28,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,39,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,10,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,21,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,32,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,3,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,14,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,25,4.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,36,3.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,7,3.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,18,4.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,29,4.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,40,3.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,11,4.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,22,4.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,33,3.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,4,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,15,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,26,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,37,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,8,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,19,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,30,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,1,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,12,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,23,4.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,34,3.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,5,3.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,16,4.3) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,27,4.8) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,38,3.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,9,4.0) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,20,4.5) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,31,3.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,2,3.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,13,4.2) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,24,4.7) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,35,3.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (26,6,3.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (1,17,4.4) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (6,28,4.9) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (11,39,3.6) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (16,10,4.1) ON CONFLICT DO NOTHING;
INSERT INTO blogpost_hospital (blog_id,hospital_id,rating) VALUES (21,21,4.6) ON CONFLICT DO NOTHING;

-- ===============================================================
-- 22. RESET SERIAL SEQUENCES
-- ===============================================================
SELECT setval(pg_get_serial_sequence('users','user_id'), GREATEST((SELECT MAX(user_id) FROM users),1));
SELECT setval(pg_get_serial_sequence('cancers','cancer_id'), GREATEST((SELECT MAX(cancer_id) FROM cancers),1));
SELECT setval(pg_get_serial_sequence('medicines','medicine_id'), GREATEST((SELECT MAX(medicine_id) FROM medicines),1));
SELECT setval(pg_get_serial_sequence('blogposts','blog_id'), GREATEST((SELECT MAX(blog_id) FROM blogposts),1));
SELECT setval(pg_get_serial_sequence('prescriptions','prescription_id'), GREATEST((SELECT MAX(prescription_id) FROM prescriptions),1));
SELECT setval(pg_get_serial_sequence('patient_stage_diagnosis','diagnosis_id'), GREATEST((SELECT MAX(diagnosis_id) FROM patient_stage_diagnosis),1));

-- ===============================================================
-- 23. QUICK CHECKS
-- ===============================================================
SELECT 'hospitals' AS table_name, COUNT(*) AS row_count FROM hospitals
UNION ALL SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL SELECT 'patients', COUNT(*) FROM patient
UNION ALL SELECT 'admins', COUNT(*) FROM admins
UNION ALL SELECT 'cancers', COUNT(*) FROM cancers
UNION ALL SELECT 'medicines', COUNT(*) FROM medicines
UNION ALL SELECT 'prescriptions', COUNT(*) FROM prescriptions
UNION ALL SELECT 'diagnoses', COUNT(*) FROM patient_stage_diagnosis;

COMMIT;
