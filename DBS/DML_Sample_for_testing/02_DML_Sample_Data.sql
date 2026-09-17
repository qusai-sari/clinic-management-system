-- ============================================================================
-- Clinic Management System - DML Script (Sample Data)
-- Database: Oracle
-- ============================================================================
-- This script inserts sample data into all tables (10+ records per table)
-- to demonstrate the system functionality.
-- ============================================================================

-- ============================================================================
-- 1. ROLES TABLE (Reference Data)
-- ============================================================================
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Receptionist', 'Handles patient check-in and appointment scheduling');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Nurse', 'Assists doctors with patient care and procedures');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Accountant', 'Manages financial transactions and billing');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Lab Technician', 'Performs laboratory tests and analyses');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Pharmacist', 'Dispenses medications and provides drug information');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Medical Assistant', 'Supports clinical and administrative tasks');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Administrator', 'Oversees clinic operations and management');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Janitor', 'Maintains cleanliness and hygiene of the clinic');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Security Guard', 'Ensures safety and security of the clinic');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'IT Support', 'Manages clinic IT systems and technical support');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Dietitian', 'Provides nutritional guidance and meal planning');
INSERT INTO Roles (Role_ID, Role_Name, Description) VALUES (seq_role_id.NEXTVAL, 'Physiotherapist', 'Provides physical therapy and rehabilitation');

-- ============================================================================
-- 2. PATIENTS TABLE (10+ records)
-- ============================================================================
INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Ahmed', 'Mohammed', 'Al-Rashid', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 'Male', '966501234567', 'Riyadh', 'Olaya Street', 'Al-Olaya', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Fatima', 'Ali', 'Al-Hassan', TO_DATE('1990-07-22', 'YYYY-MM-DD'), 'Female', '966502345678', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Omar', 'Khalid', 'Al-Otaibi', TO_DATE('1978-11-08', 'YYYY-MM-DD'), 'Male', '966503456789', 'Dammam', 'King Fahd Road', 'Al-Shati', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Aisha', 'Saud', 'Al-Qahtani', TO_DATE('1995-02-14', 'YYYY-MM-DD'), 'Female', '966504567890', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Mohammed', 'Abdullah', 'Al-Zahrani', TO_DATE('1982-09-30', 'YYYY-MM-DD'), 'Male', '966505678901', 'Makkah', ' Ibrahim Al-Khalil Street', 'Al-Aziziyah', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Sarah', 'Ahmed', 'Al-Ghamdi', TO_DATE('1988-05-17', 'YYYY-MM-DD'), 'Female', '966506789012', 'Jeddah', ' Palestine Street', 'Al-Rawdah', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Abdulrahman', 'Fahad', 'Al-Harbi', TO_DATE('1992-12-25', 'YYYY-MM-DD'), 'Male', '966507890123', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Layla', 'Youssef', 'Al-Mutairi', TO_DATE('1998-08-03', 'YYYY-MM-DD'), 'Female', '966508901234', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Khalid', 'Salem', 'Al-Ansari', TO_DATE('1975-04-19', 'YYYY-MM-DD'), 'Male', '966509012345', 'Riyadh', 'Makkah Road', 'Al-Safa', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Reem', 'Hassan', 'Al-Shammari', TO_DATE('1993-10-28', 'YYYY-MM-DD'), 'Female', '966510123456', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Turki', 'Nasser', 'Al-Dosari', TO_DATE('1980-06-12', 'YYYY-MM-DD'), 'Male', '966511234567', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Noura', 'Ibrahim', 'Al-Badr', TO_DATE('1996-01-09', 'YYYY-MM-DD'), 'Female', '966512345678', 'Riyadh', 'Othman Bin Affan Road', 'Al-Wafa', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Faisal', 'Rashid', 'Al-Mutlaq', TO_DATE('1987-03-21', 'YYYY-MM-DD'), 'Male', '966513456789', 'Dammam', 'King Faisal Road', 'Al-Khalidiyyah', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Hind', 'Mahmoud', 'Al-Farsi', TO_DATE('1994-07-15', 'YYYY-MM-DD'), 'Female', '966514567890', 'Jeddah', 'Al-Madinah Road', 'Al-Salam', 'Active');

INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Sultan', 'Abdulaziz', 'Al-Yami', TO_DATE('1979-11-02', 'YYYY-MM-DD'), 'Male', '966515678901', 'Riyadh', 'Prince Turki Road', 'Al-Quds', 'Active');

-- ============================================================================
-- 3. EMPLOYEES TABLE (Doctors and General Employees)
-- ============================================================================

-- Doctors (10+ records)
INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Muhammad', 'Ahmed', 'Al-Saeed', '966520123456', 'Riyadh', 'King Fahd Road', 'Al-Malaz', 25000, TO_DATE('2015-01-15', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Sarah', 'Abdullah', 'Al-Khalifa', '966521234567', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 28000, TO_DATE('2014-03-20', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Ahmed', 'Youssef', 'Al-Obeikan', '966522345678', 'Riyadh', 'Olaya Street', 'Al-Olaya', 30000, TO_DATE('2013-06-10', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Layla', 'Mohammed', 'Al-Hammad', '966523456789', 'Dammam', 'King Faisal Road', 'Al-Khalidiyyah', 26000, TO_DATE('2016-02-28', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Omar', 'Khalid', 'Al-Drees', '966524567890', 'Makkah', 'Ibrahim Al-Khalil Street', 'Al-Aziziyah', 27000, TO_DATE('2015-09-12', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Fatima', 'Ali', 'Al-Mutairi', '966525678901', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 29000, TO_DATE('2014-11-05', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Abdulrahman', 'Saud', 'Al-Qahtani', '966526789012', 'Jeddah', 'Palestine Street', 'Al-Rawdah', 31000, TO_DATE('2012-04-18', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Aisha', 'Hassan', 'Al-Ghamdi', '966527890123', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 27500, TO_DATE('2015-07-22', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Mohammed', 'Fahad', 'Al-Harbi', '966528901234', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 28500, TO_DATE('2016-01-08', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Noura', 'Youssef', 'Al-Zahrani', '966529012345', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 29500, TO_DATE('2014-08-30', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Khalid', 'Salem', 'Al-Ansari', '966530123456', 'Riyadh', 'Makkah Road', 'Al-Safa', 32000, TO_DATE('2011-12-15', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Reem', 'Abdulaziz', 'Al-Shammari', '966531234567', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 30500, TO_DATE('2013-05-25', 'YYYY-MM-DD'), 'Active');

-- General Employees (10+ records)
INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Ahmed', 'Mohammed', 'Al-Rashid', '966532345678', 'Riyadh', 'Olaya Street', 'Al-Olaya', 8000, TO_DATE('2018-03-01', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Fatima', 'Ali', 'Al-Hassan', '966533456789', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 7500, TO_DATE('2019-06-15', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Omar', 'Khalid', 'Al-Otaibi', '966534567890', 'Dammam', 'King Fahd Road', 'Al-Shati', 8200, TO_DATE('2017-09-20', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Aisha', 'Saud', 'Al-Qahtani', '966535678901', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 7800, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Mohammed', 'Abdullah', 'Al-Zahrani', '966536789012', 'Makkah', 'Ibrahim Al-Khalil Street', 'Al-Aziziyah', 8500, TO_DATE('2017-04-05', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Sarah', 'Ahmed', 'Al-Ghamdi', '966537890123', 'Jeddah', 'Palestine Street', 'Al-Rawdah', 7900, TO_DATE('2019-01-25', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Abdulrahman', 'Fahad', 'Al-Harbi', '966538901234', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 8300, TO_DATE('2018-07-18', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Layla', 'Youssef', 'Al-Mutairi', '966539012345', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 8100, TO_DATE('2019-03-12', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Khalid', 'Salem', 'Al-Ansari', '966540123456', 'Riyadh', 'Makkah Road', 'Al-Safa', 8700, TO_DATE('2016-11-30', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Reem', 'Hassan', 'Al-Shammari', '966541234567', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 8400, TO_DATE('2017-08-22', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Turki', 'Nasser', 'Al-Dosari', '966542345678', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 8600, TO_DATE('2016-05-14', 'YYYY-MM-DD'), 'Active');

INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Noura', 'Ibrahim', 'Al-Badr', '966543456789', 'Riyadh', 'Othman Bin Affan Road', 'Al-Wafa', 8800, TO_DATE('2015-10-08', 'YYYY-MM-DD'), 'Active');

-- ============================================================================
-- 4. DOCTORS TABLE (Specialization for first 12 employees)
-- ============================================================================
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(1, 'Cardiology', 'SA-CARD-001');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(2, 'Dermatology', 'SA-DERM-002');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(3, 'General Medicine', 'SA-GEN-003');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(4, 'Pediatrics', 'SA-PED-004');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(5, 'Orthopedics', 'SA-ORTHO-005');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(6, 'Gynecology', 'SA-GYN-006');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(7, 'Neurology', 'SA-NEURO-007');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(8, 'Ophthalmology', 'SA-OPHTH-008');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(9, 'Internal Medicine', 'SA-INT-009');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(10, 'ENT', 'SA-ENT-010');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(11, 'Radiology', 'SA-RAD-011');
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(12, 'Psychiatry', 'SA-PSYCH-012');

-- ============================================================================
-- 5. GENERAL_EMPLOYEES TABLE (Assign roles to last 12 employees)
-- ============================================================================
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (13, 1); -- Receptionist
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (14, 2); -- Nurse
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (15, 3); -- Accountant
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (16, 4); -- Lab Technician
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (17, 5); -- Pharmacist
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (18, 6); -- Medical Assistant
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (19, 7); -- Administrator
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (20, 8); -- Janitor
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (21, 9); -- Security Guard
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (22, 10); -- IT Support
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (23, 11); -- Dietitian
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (24, 12); -- Physiotherapist

-- ============================================================================
-- 6. MEDICINES TABLE (Reference Catalog - 10+ records)
-- ============================================================================
INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Paracetamol', 'Tablet', '500mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Ibuprofen', 'Tablet', '400mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Amoxicillin', 'Capsule', '500mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Omeprazole', 'Capsule', '20mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Metformin', 'Tablet', '850mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Lisinopril', 'Tablet', '10mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Cetirizine', 'Tablet', '10mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Vitamin D3', 'Capsule', '1000 IU', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Cough Syrup', 'Syrup', '100ml', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Salbutamol', 'Inhaler', '100mcg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Aspirin', 'Tablet', '100mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Antacid', 'Tablet', '400mg', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Insulin', 'Injection', '100 IU/ml', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Antibiotic Ointment', 'Ointment', '10g', 'Active');

INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Old Painkiller', 'Tablet', '200mg', 'Inactive');

-- ============================================================================
-- 7. SERVICES TABLE (Reference Catalog - 10+ records)
-- ============================================================================
INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'General Consultation', 'Standard doctor consultation', 200, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Specialist Consultation', 'Consultation with specialist doctor', 350, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Laboratory Tests', 'Basic blood work and lab tests', 150, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'X-Ray', 'Digital X-Ray imaging', 120, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Ultrasound', 'Ultrasound imaging', 200, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'ECG', 'Electrocardiogram test', 80, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Vaccination', 'Standard vaccination', 50, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Wound Dressing', 'Minor wound treatment and dressing', 75, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'IV Therapy', 'Intravenous fluid administration', 100, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Physical Therapy Session', 'Physical therapy consultation', 250, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Dietary Consultation', 'Nutritionist consultation', 180, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Follow-up Visit', 'Follow-up appointment with doctor', 100, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Emergency Visit', 'Urgent medical consultation', 400, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Health Checkup', 'Comprehensive health examination', 500, 'Active');

INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'Old Service', 'Discontinued service', 0, 'Inactive');

-- ============================================================================
-- 8. APPOINTMENTS TABLE (20+ records with various statuses)
-- ============================================================================
INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 1, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Chest pain and shortness of breath');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 2, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Skin rash and itching');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 3, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Fever and body aches');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 4, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child vaccination');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 5, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Joint pain in knees');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 6, 6, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Routine checkup');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 7, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Severe headache');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 8, 8, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Eye examination');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 9, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Stomach pain');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 10, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Ear infection');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 11, 11, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Chest X-Ray follow-up');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 12, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Anxiety and stress');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 1, 3, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Follow-up for heart condition');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 2, 2, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'Scheduled', 'Cancelled', 'Patient unable to attend');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 3, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Scheduled', 'No-show', 'Patient did not attend');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 4, 4, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child fever');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 5, 5, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Back pain');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 6, 6, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Annual gynecological exam');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 7, 7, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Migraine follow-up');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 8, 8, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Vision test');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 9, 9, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Digestive issues');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 10, 10, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Throat infection');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 11, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Cardiac stress test');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 12, 12, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Depression consultation');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 13, 3, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Diabetes management');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 14, 2, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Allergic reaction');

INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 15, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child developmental check');

-- ============================================================================
-- 9. MEDICAL_RECORDS TABLE (For completed appointments)
-- ============================================================================
INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 1, 'Angina pectoris', 'Patient presents with chest pain and shortness of breath. ECG shows mild abnormalities. Recommended stress test.', TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 2, 'Contact dermatitis', 'Skin rash on arms and legs. Patient reports using new laundry detergent. Prescribed topical corticosteroid.', TO_DATE('2024-01-16', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 3, 'Viral fever', 'Patient has fever of 38.5°C with body aches. No specific infection source identified. Recommended rest and fluids.', TO_DATE('2024-01-17', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 4, 'Routine vaccination', 'Child received scheduled vaccinations: DTP, Polio, and MMR. No adverse reactions observed.', TO_DATE('2024-01-18', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 5, 'Osteoarthritis', 'Patient reports knee pain worsened by activity. X-ray shows mild degenerative changes. Recommended physical therapy.', TO_DATE('2024-01-19', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 6, 'Normal pregnancy', 'Routine prenatal checkup. Fetal heart rate normal. Blood pressure within normal range.', TO_DATE('2024-01-20', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 7, 'Migraine', 'Patient reports severe headache with aura. CT scan normal. Prescribed preventive medication.', TO_DATE('2024-01-21', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 8, 'Myopia', 'Patient has difficulty seeing distant objects. Vision test confirms nearsightedness. Prescribed glasses.', TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 9, 'Gastritis', 'Patient reports stomach pain after meals. Endoscopy shows mild inflammation. Recommended dietary changes.', TO_DATE('2024-01-23', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 10, 'Otitis media', 'Patient has ear pain and reduced hearing. Examination shows ear infection. Prescribed antibiotics.', TO_DATE('2024-01-24', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 11, 'Normal chest X-ray', 'Follow-up X-ray shows no abnormalities. Previous condition resolved.', TO_DATE('2024-01-25', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 12, 'Generalized anxiety disorder', 'Patient reports anxiety and stress. Recommended therapy and lifestyle changes.', TO_DATE('2024-01-26', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 13, 'Stable angina', 'Follow-up for heart condition. ECG stable. Medication effective. Continue current treatment.', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 14, 'Pediatric fever', 'Child has fever of 39°C. Throat culture negative. Viral infection suspected. Symptomatic treatment.', TO_DATE('2024-02-15', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 15, 'Lower back pain', 'Patient reports chronic back pain. MRI shows disc herniation. Recommended conservative treatment.', TO_DATE('2024-02-20', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 16, 'Healthy pregnancy', 'Routine prenatal checkup. All tests normal. Fetal growth appropriate for gestational age.', TO_DATE('2024-02-25', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 17, 'Chronic migraine', 'Follow-up for migraine. Frequency reduced with medication. Continue current regimen.', TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 18, 'Stable myopia', 'Follow-up vision test. Prescription unchanged. Annual exam recommended.', TO_DATE('2024-03-05', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 19, 'Irritable bowel syndrome', 'Patient reports digestive issues. Colonoscopy normal. Recommended fiber and probiotics.', TO_DATE('2024-03-10', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 20, 'Pharyngitis', 'Patient has sore throat and fever. Rapid strep test positive. Prescribed antibiotics.', TO_DATE('2024-03-15', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 21, 'Normal cardiac stress test', 'Stress test results normal. No evidence of coronary artery disease.', TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 22, 'Major depressive disorder', 'Patient reports persistent low mood. Recommended antidepressant medication and therapy.', TO_DATE('2024-03-25', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 23, 'Type 2 diabetes', 'Patient has elevated blood sugar. HbA1c 7.5%. Recommended metformin and dietary changes.', TO_DATE('2024-04-01', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 24, 'Allergic contact dermatitis', 'Patient has allergic reaction to unknown substance. Prescribed antihistamines and topical steroid.', TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 25, 'Normal development', 'Child developmental assessment normal. All milestones achieved appropriately.', TO_DATE('2024-04-10', 'YYYY-MM-DD'));

-- ============================================================================
-- 10. PRESCRIPTIONS TABLE (For some completed appointments)
-- ============================================================================
INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Take with food. Avoid alcohol. Monitor blood pressure.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Apply to affected area twice daily. Avoid sun exposure.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Complete full course. Rest and fluids. Consult if fever persists.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Take with meals. May cause stomach upset. Report any side effects.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Take at onset of symptoms. Avoid driving if drowsy. Limit caffeine.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Take before meals. Avoid spicy foods. Follow up in 2 weeks.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Complete full course. Take with water. Keep hydrated.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Take daily at same time. May take 2-4 weeks for full effect. Regular follow-up essential.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 13, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Continue as prescribed. Monitor blood pressure weekly. Report chest pain immediately.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 14, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Dose based on weight. Complete full course. Keep hydrated.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 15, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Take with food. May cause dizziness. Avoid alcohol. Physical therapy recommended.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 17, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Take at onset. Keep headache diary. Identify triggers. Stress management.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 19, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Take before meals. Increase fiber intake. Probiotics recommended. Follow up in 4 weeks.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 20, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Complete full course. Gargle with warm salt water. Rest voice.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 22, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Take daily at same time. Regular therapy sessions essential. Report any mood changes.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 23, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Take with meals. Monitor blood sugar regularly. Exercise and diet important.');

INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 24, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Take as needed. Identify and avoid allergen. Cool compress for itching.');

-- ============================================================================
-- 11. PRESCRIPTION_MEDICINES TABLE (M:N relationship)
-- ============================================================================
-- Prescription 1 (Angina)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(1, 1, '1 tablet', '3 times daily', 30);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(1, 5, '1 tablet', 'Twice daily', 30);

-- Prescription 2 (Dermatitis)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(2, 7, '1 tablet', 'Once daily', 14);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(2, 14, 'Apply thin layer', 'Twice daily', 7);

-- Prescription 3 (Viral fever)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(3, 1, '1 tablet', 'Every 6 hours', 5);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(3, 9, '10ml', '3 times daily', 5);

-- Prescription 5 (Osteoarthritis)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(5, 2, '1 tablet', 'Twice daily', 21);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(5, 4, '1 capsule', 'Once daily', 21);

-- Prescription 7 (Migraine)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(7, 1, '1 tablet', 'As needed', 30);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(7, 7, '1 tablet', 'Once daily', 30);

-- Prescription 9 (Gastritis)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(9, 4, '1 capsule', 'Once daily', 14);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(9, 12, '1 tablet', '3 times daily', 14);

-- Prescription 10 (Ear infection)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(10, 3, '1 capsule', '3 times daily', 7);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(10, 1, '1 tablet', 'Every 6 hours', 7);

-- Prescription 12 (Anxiety)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(12, 7, '1 tablet', 'Once daily', 90);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(12, 8, '1 capsule', 'Once daily', 90);

-- Prescription 13 (Angina follow-up)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(13, 6, '1 tablet', 'Once daily', 30);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(13, 11, '1 tablet', 'Once daily', 30);

-- Prescription 14 (Pediatric fever)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(14, 1, '0.5 tablet', 'Every 6 hours', 5);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(14, 9, '5ml', '3 times daily', 5);

-- Prescription 15 (Back pain)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(15, 2, '1 tablet', 'Twice daily', 14);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(15, 1, '1 tablet', 'As needed', 14);

-- Prescription 17 (Migraine follow-up)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(17, 7, '1 tablet', 'As needed', 60);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(17, 8, '1 capsule', 'Once daily', 60);

-- Prescription 19 (IBS)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(19, 4, '1 capsule', 'Once daily', 28);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(19, 12, '1 tablet', '3 times daily', 28);

-- Prescription 20 (Throat infection)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(20, 3, '1 capsule', '3 times daily', 10);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(20, 9, '10ml', '3 times daily', 10);

-- Prescription 22 (Depression)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(22, 7, '1 tablet', 'Once daily', 180);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(22, 8, '1 capsule', 'Once daily', 180);

-- Prescription 23 (Diabetes)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(23, 5, '1 tablet', 'Twice daily', 90);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(23, 8, '1 capsule', 'Once daily', 90);

-- Prescription 24 (Allergic reaction)
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(24, 7, '1 tablet', 'Twice daily', 7);
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(24, 14, 'Apply thin layer', '3 times daily', 5);

-- ============================================================================
-- 12. INVOICES TABLE (For some completed appointments)
-- ============================================================================
INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 6, TO_DATE('2024-01-20', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 8, TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 11, TO_DATE('2024-01-25', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 13, TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 14, TO_DATE('2024-02-15', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 15, TO_DATE('2024-02-20', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 16, TO_DATE('2024-02-25', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 17, TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 18, TO_DATE('2024-03-05', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 19, TO_DATE('2024-03-10', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 20, TO_DATE('2024-03-15', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 21, TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 22, TO_DATE('2024-03-25', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 23, TO_DATE('2024-04-01', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 24, TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 25, TO_DATE('2024-04-10', 'YYYY-MM-DD'));

-- ============================================================================
-- 13. INVOICE_SERVICES TABLE (M:N relationship with historical pricing)
-- ============================================================================
-- Invoice 1 (Angina - Cardiology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(1, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(1, 6, 1, 80); -- ECG

-- Invoice 2 (Dermatitis - Dermatology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(2, 2, 1, 350); -- Specialist Consultation

-- Invoice 3 (Viral fever - General Medicine)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(3, 1, 1, 200); -- General Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(3, 3, 1, 150); -- Laboratory Tests

-- Invoice 4 (Vaccination - Pediatrics)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(4, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(4, 7, 3, 50); -- Vaccination (3 vaccines)

-- Invoice 5 (Osteoarthritis - Orthopedics)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(5, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(5, 4, 1, 120); -- X-Ray

-- Invoice 6 (Pregnancy - Gynecology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(6, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(6, 3, 1, 150); -- Laboratory Tests

-- Invoice 7 (Migraine - Neurology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(7, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(7, 5, 1, 200); -- Ultrasound

-- Invoice 8 (Myopia - Ophthalmology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(8, 2, 1, 350); -- Specialist Consultation

-- Invoice 9 (Gastritis - Internal Medicine)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(9, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(9, 3, 1, 150); -- Laboratory Tests

-- Invoice 10 (Ear infection - ENT)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(10, 2, 1, 350); -- Specialist Consultation

-- Invoice 11 (X-Ray follow-up - Radiology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(11, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(11, 4, 1, 120); -- X-Ray

-- Invoice 12 (Anxiety - Psychiatry)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(12, 2, 1, 350); -- Specialist Consultation

-- Invoice 13 (Angina follow-up - Cardiology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(13, 12, 1, 100); -- Follow-up Visit
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(13, 6, 1, 80); -- ECG

-- Invoice 14 (Pediatric fever - Pediatrics)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(14, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(14, 3, 1, 150); -- Laboratory Tests

-- Invoice 15 (Back pain - Orthopedics)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(15, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(15, 10, 1, 250); -- Physical Therapy Session

-- Invoice 16 (Pregnancy follow-up - Gynecology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(16, 12, 1, 100); -- Follow-up Visit
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(16, 3, 1, 150); -- Laboratory Tests

-- Invoice 17 (Migraine follow-up - Neurology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(17, 12, 1, 100); -- Follow-up Visit

-- Invoice 18 (Vision test - Ophthalmology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(18, 12, 1, 100); -- Follow-up Visit

-- Invoice 19 (IBS - Internal Medicine)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(19, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(19, 3, 1, 150); -- Laboratory Tests

-- Invoice 20 (Throat infection - ENT)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(20, 2, 1, 350); -- Specialist Consultation

-- Invoice 21 (Cardiac stress test - Cardiology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(21, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(21, 6, 1, 80); -- ECG

-- Invoice 22 (Depression - Psychiatry)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(22, 2, 1, 350); -- Specialist Consultation

-- Invoice 23 (Diabetes - Internal Medicine)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(23, 2, 1, 350); -- Specialist Consultation
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(23, 3, 1, 150); -- Laboratory Tests

-- Invoice 24 (Allergic reaction - Dermatology)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(24, 2, 1, 350); -- Specialist Consultation

-- Invoice 25 (Developmental check - Pediatrics)
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(25, 2, 1, 350); -- Specialist Consultation

-- ============================================================================
-- 14. PAYMENTS TABLE (Various payment methods and statuses)
-- ============================================================================
-- Invoice 1 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 1, 13, 430, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Cash');

-- Invoice 2 - Full payment with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 2, 13, 350, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Card');

-- Invoice 3 - Full payment with Bank Transfer
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 3, 15, 350, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Bank Transfer');

-- Invoice 4 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 4, 13, 500, TO_DATE('2024-01-18', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 5 - Partial payment with Cash, then remaining with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 5, 13, 200, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Cash');
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 5, 13, 270, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Card');

-- Invoice 6 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 6, 13, 500, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 7 - Full payment with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 7, 13, 550, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Card');

-- Invoice 8 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 8, 13, 350, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 'Cash');

-- Invoice 9 - Full payment with Bank Transfer
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 9, 15, 500, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Bank Transfer');

-- Invoice 10 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 10, 13, 350, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 11 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 11, 13, 470, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Cash');

-- Invoice 12 - Full payment with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 12, 13, 350, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Card');

-- Invoice 13 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 13, 13, 180, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 14 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 14, 13, 500, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Cash');

-- Invoice 15 - Partial payment with Card, then remaining with Bank Transfer
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 15, 13, 300, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Card');
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 15, 15, 300, TO_DATE('2024-02-27', 'YYYY-MM-DD'), 'Bank Transfer');

-- Invoice 16 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 16, 13, 250, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 17 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 17, 13, 100, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Cash');

-- Invoice 18 - Full payment with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 18, 13, 100, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Card');

-- Invoice 19 - Full payment with Bank Transfer
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 19, 15, 500, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Bank Transfer');

-- Invoice 20 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 20, 13, 350, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 21 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 21, 13, 430, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Cash');

-- Invoice 22 - Full payment with Card
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 22, 13, 350, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Card');

-- Invoice 23 - Full payment with Insurance
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 23, 13, 500, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Insurance');

-- Invoice 24 - Full payment with Cash
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 24, 13, 350, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Cash');

-- Invoice 25 - Unpaid (no payment record)
-- This invoice will show as Unpaid in the view

-- ============================================================================
-- COMMIT
-- ============================================================================
COMMIT;

-- ============================================================================
-- END OF DML SCRIPT
-- ============================================================================
