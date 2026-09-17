-- ============================================================================
-- Clinic Management System - Complete Implementation
-- Database: Oracle
-- ============================================================================
-- This is a comprehensive SQL file that combines all components of the
-- Clinic Management System implementation:
-- 1. DDL (Data Definition Language) - Tables, Constraints, Triggers
-- 2. DML (Data Manipulation Language) - Sample Data
-- 3. DQL (Data Query Language) - 15 Useful Queries
-- 4. Advanced JOIN Queries - 3 Complex JOIN Queries
-- 5. Aggregate Queries - 2 GROUP BY Queries
-- 6. UPDATE and DELETE Examples
-- ============================================================================

-- ============================================================================
-- PART 1: DDL - DATA DEFINITION LANGUAGE
-- ============================================================================

-- Drop existing tables in correct order (reverse of creation)
DROP TABLE Payments CASCADE CONSTRAINTS;
DROP TABLE Invoice_Services CASCADE CONSTRAINTS;
DROP TABLE Invoices CASCADE CONSTRAINTS;
DROP TABLE Prescription_Medicines CASCADE CONSTRAINTS;
DROP TABLE Prescriptions CASCADE CONSTRAINTS;
DROP TABLE Medicines CASCADE CONSTRAINTS;
DROP TABLE Medical_Records CASCADE CONSTRAINTS;
DROP TABLE Appointments CASCADE CONSTRAINTS;
DROP TABLE Services CASCADE CONSTRAINTS;
DROP TABLE General_Employees CASCADE CONSTRAINTS;
DROP TABLE Doctors CASCADE CONSTRAINTS;
DROP TABLE Employees CASCADE CONSTRAINTS;
DROP TABLE Roles CASCADE CONSTRAINTS;
DROP TABLE Patients CASCADE CONSTRAINTS;

-- SEQUENCES
CREATE SEQUENCE seq_patient_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_role_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_employee_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_appointment_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_record_no START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_prescription_no START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_medicine_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_service_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_invoice_no START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_payment_no START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- TABLES
CREATE TABLE Patients (
    Patient_ID NUMBER(10) PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Middle_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR2(10) NOT NULL,
    Phone VARCHAR2(20) NOT NULL,
    City VARCHAR2(50) NOT NULL,
    Street VARCHAR2(100),
    Neighborhood VARCHAR2(50),
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_patient_gender CHECK (Gender IN ('Male', 'Female')),
    CONSTRAINT chk_patient_status CHECK (Status IN ('Active', 'Inactive')),
    CONSTRAINT chk_patient_dob CHECK (Date_of_Birth <= SYSDATE)
);

CREATE TABLE Roles (
    Role_ID NUMBER(10) PRIMARY KEY,
    Role_Name VARCHAR2(50) NOT NULL UNIQUE,
    Description VARCHAR2(200)
);

CREATE TABLE Employees (
    Employee_ID NUMBER(10) PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Middle_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Phone VARCHAR2(20) NOT NULL UNIQUE,
    City VARCHAR2(50) NOT NULL,
    Street VARCHAR2(100),
    Neighborhood VARCHAR2(50),
    Salary NUMBER(10,2) NOT NULL,
    Hire_Date DATE NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_employee_salary CHECK (Salary > 0),
    CONSTRAINT chk_employee_status CHECK (Status IN ('Active', 'Inactive')),
    CONSTRAINT chk_employee_hire_date CHECK (Hire_Date <= SYSDATE)
);

CREATE TABLE Doctors (
    Employee_ID NUMBER(10) PRIMARY KEY,
    Specialization VARCHAR2(100) NOT NULL,
    License_Number VARCHAR2(50) NOT NULL UNIQUE,
    CONSTRAINT fk_doctors_employee FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);

CREATE TABLE General_Employees (
    Employee_ID NUMBER(10) PRIMARY KEY,
    Role_ID NUMBER(10) NOT NULL,
    CONSTRAINT fk_general_employees_employee FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    CONSTRAINT fk_general_employees_role FOREIGN KEY (Role_ID) REFERENCES Roles(Role_ID)
);

CREATE TABLE Medicines (
    Medicine_ID NUMBER(10) PRIMARY KEY,
    Medicine_Name VARCHAR2(100) NOT NULL,
    Dosage_Form VARCHAR2(50) NOT NULL,
    Strength VARCHAR2(50) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_medicine_status CHECK (Status IN ('Active', 'Inactive'))
);

CREATE TABLE Services (
    Service_ID NUMBER(10) PRIMARY KEY,
    Service_Name VARCHAR2(100) NOT NULL UNIQUE,
    Description VARCHAR2(200),
    Price NUMBER(10,2) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_service_price CHECK (Price >= 0),
    CONSTRAINT chk_service_status CHECK (Status IN ('Active', 'Inactive'))
);

CREATE TABLE Appointments (
    Appointment_ID NUMBER(10) PRIMARY KEY,
    Patient_ID NUMBER(10) NOT NULL,
    Doctor_ID NUMBER(10) NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Type VARCHAR2(20) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    Reason_for_Visit VARCHAR2(500) NOT NULL,
    CONSTRAINT fk_appointments_patient FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    CONSTRAINT fk_appointments_doctor FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Employee_ID),
    CONSTRAINT chk_appointment_type CHECK (Appointment_Type IN ('Scheduled', 'Walk-in')),
    CONSTRAINT chk_appointment_status CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'))
);

CREATE TABLE Medical_Records (
    Record_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL UNIQUE,
    Diagnosis VARCHAR2(500) NOT NULL,
    Clinical_Notes VARCHAR2(1000),
    Record_Date DATE NOT NULL,
    CONSTRAINT fk_medical_records_appointment FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

CREATE TABLE Prescriptions (
    Prescription_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL,
    Prescription_Date DATE NOT NULL,
    General_Instructions VARCHAR2(1000),
    CONSTRAINT fk_prescriptions_appointment FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

CREATE TABLE Prescription_Medicines (
    Prescription_No NUMBER(10) NOT NULL,
    Medicine_ID NUMBER(10) NOT NULL,
    Dosage VARCHAR2(50) NOT NULL,
    Frequency VARCHAR2(50) NOT NULL,
    Duration_Days NUMBER(5) NOT NULL,
    CONSTRAINT pk_prescription_medicines PRIMARY KEY (Prescription_No, Medicine_ID),
    CONSTRAINT fk_prescription_medicines_prescription FOREIGN KEY (Prescription_No) REFERENCES Prescriptions(Prescription_No),
    CONSTRAINT fk_prescription_medicines_medicine FOREIGN KEY (Medicine_ID) REFERENCES Medicines(Medicine_ID),
    CONSTRAINT chk_duration_days CHECK (Duration_Days > 0)
);

CREATE TABLE Invoices (
    Invoice_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL UNIQUE,
    Issue_Date DATE NOT NULL,
    CONSTRAINT fk_invoices_appointment FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

CREATE TABLE Invoice_Services (
    Invoice_No NUMBER(10) NOT NULL,
    Service_ID NUMBER(10) NOT NULL,
    Quantity NUMBER(5) NOT NULL,
    Unit_Price NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_invoice_services PRIMARY KEY (Invoice_No, Service_ID),
    CONSTRAINT fk_invoice_services_invoice FOREIGN KEY (Invoice_No) REFERENCES Invoices(Invoice_No),
    CONSTRAINT fk_invoice_services_service FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID),
    CONSTRAINT chk_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_unit_price CHECK (Unit_Price >= 0)
);

CREATE TABLE Payments (
    Payment_No NUMBER(10) PRIMARY KEY,
    Invoice_No NUMBER(10) NOT NULL,
    Created_By_Employee_ID NUMBER(10) NOT NULL,
    Amount_Paid NUMBER(10,2) NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Method VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_payments_invoice FOREIGN KEY (Invoice_No) REFERENCES Invoices(Invoice_No),
    CONSTRAINT fk_payments_employee FOREIGN KEY (Created_By_Employee_ID) REFERENCES General_Employees(Employee_ID),
    CONSTRAINT chk_amount_paid CHECK (Amount_Paid > 0),
    CONSTRAINT chk_payment_method CHECK (Payment_Method IN ('Cash', 'Card', 'Bank Transfer', 'Insurance'))
);

-- TRIGGERS
CREATE OR REPLACE TRIGGER trg_employee_specialization
BEFORE INSERT OR UPDATE ON Employees
FOR EACH ROW
DECLARE
    v_doctor_count NUMBER;
    v_general_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_doctor_count FROM Doctors WHERE Employee_ID = :NEW.Employee_ID;
    SELECT COUNT(*) INTO v_general_count FROM General_Employees WHERE Employee_ID = :NEW.Employee_ID;
    IF INSERTING THEN
        IF v_doctor_count = 0 AND v_general_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Every employee must belong to exactly one subtype');
        END IF;
    END IF;
    IF v_doctor_count > 0 AND v_general_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'An employee cannot belong to both subtypes');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_medical_record_appointment_status
BEFORE INSERT OR UPDATE ON Medical_Records
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF v_appointment_status IN ('Cancelled', 'No-show') THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cannot create medical record for cancelled or no-show appointments');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_medical_record_date
BEFORE INSERT OR UPDATE ON Medical_Records
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF :NEW.Record_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20004, 'Record_Date must be >= Appointment_Date');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prescription_appointment_status
BEFORE INSERT OR UPDATE ON Prescriptions
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF v_appointment_status IN ('Cancelled', 'No-show') THEN
        RAISE_APPLICATION_ERROR(-20005, 'Cannot create prescription for cancelled or no-show appointments');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prescription_date
BEFORE INSERT OR UPDATE ON Prescriptions
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF :NEW.Prescription_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20006, 'Prescription_Date must be >= Appointment_Date');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_invoice_appointment_status
BEFORE INSERT OR UPDATE ON Invoices
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF v_appointment_status = 'Cancelled' THEN
        RAISE_APPLICATION_ERROR(-20007, 'Cannot create invoice for cancelled appointments');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_invoice_date
BEFORE INSERT OR UPDATE ON Invoices
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date FROM Appointments WHERE Appointment_ID = :NEW.Appointment_ID;
    IF :NEW.Issue_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20008, 'Issue_Date must be >= Appointment_Date');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prescription_medicine_status
BEFORE INSERT OR UPDATE ON Prescription_Medicines
FOR EACH ROW
DECLARE
    v_medicine_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_medicine_status FROM Medicines WHERE Medicine_ID = :NEW.Medicine_ID;
    IF v_medicine_status = 'Inactive' THEN
        RAISE_APPLICATION_ERROR(-20009, 'Cannot add inactive medicines to prescriptions');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_invoice_service_status
BEFORE INSERT OR UPDATE ON Invoice_Services
FOR EACH ROW
DECLARE
    v_service_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_service_status FROM Services WHERE Service_ID = :NEW.Service_ID;
    IF v_service_status = 'Inactive' THEN
        RAISE_APPLICATION_ERROR(-20010, 'Cannot add inactive services to invoices');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_payment_date
BEFORE INSERT OR UPDATE ON Payments
FOR EACH ROW
DECLARE
    v_invoice_date DATE;
BEGIN
    SELECT Issue_Date INTO v_invoice_date FROM Invoices WHERE Invoice_No = :NEW.Invoice_No;
    IF :NEW.Payment_Date < v_invoice_date THEN
        RAISE_APPLICATION_ERROR(-20011, 'Payment_Date must be >= Invoice Issue_Date');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_payment_overpayment
BEFORE INSERT OR UPDATE ON Payments
FOR EACH ROW
DECLARE
    v_invoice_total NUMBER(10,2);
    v_current_payments NUMBER(10,2);
    v_new_total NUMBER(10,2);
BEGIN
    SELECT SUM(Quantity * Unit_Price) INTO v_invoice_total FROM Invoice_Services WHERE Invoice_No = :NEW.Invoice_No;
    IF v_invoice_total IS NULL THEN v_invoice_total := 0; END IF;
    SELECT SUM(Amount_Paid) INTO v_current_payments FROM Payments WHERE Invoice_No = :NEW.Invoice_No AND Payment_No != NVL(:NEW.Payment_No, 0);
    IF v_current_payments IS NULL THEN v_current_payments := 0; END IF;
    v_new_total := v_current_payments + :NEW.Amount_Paid;
    IF v_new_total > v_invoice_total THEN
        RAISE_APPLICATION_ERROR(-20012, 'Total payments cannot exceed invoice total');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_appointment_active_doctor
BEFORE INSERT OR UPDATE ON Appointments
FOR EACH ROW
DECLARE
    v_employee_status VARCHAR2(20);
BEGIN
    SELECT e.Status INTO v_employee_status FROM Employees e JOIN Doctors d ON e.Employee_ID = d.Employee_ID WHERE d.Employee_ID = :NEW.Doctor_ID;
    IF v_employee_status != 'Active' THEN
        RAISE_APPLICATION_ERROR(-20013, 'Cannot assign appointment to inactive doctor');
    END IF;
END;
/

-- VIEWS
CREATE OR REPLACE VIEW vw_Invoice_Total AS
SELECT i.Invoice_No, i.Appointment_ID, i.Issue_Date,
       SUM(is.Quantity * is.Unit_Price) AS Total_Amount,
       (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) AS Total_Paid,
       CASE WHEN SUM(is.Quantity * is.Unit_Price) = 0 THEN 'Paid'
            WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) IS NULL THEN 'Unpaid'
            WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) = 0 THEN 'Unpaid'
            WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) < SUM(is.Quantity * is.Unit_Price) THEN 'Partially Paid'
            WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) >= SUM(is.Quantity * is.Unit_Price) THEN 'Paid'
       END AS Payment_Status
FROM Invoices i LEFT JOIN Invoice_Services is ON i.Invoice_No = is.Invoice_No
GROUP BY i.Invoice_No, i.Appointment_ID, i.Issue_Date;

CREATE OR REPLACE VIEW vw_Prescription_Detail AS
SELECT p.Prescription_No, p.Appointment_ID, p.Prescription_Date, p.General_Instructions,
       pat.Patient_ID, pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name,
       doc.Employee_ID AS Doctor_ID, doc.First_Name || ' ' || doc.Middle_Name || ' ' || doc.Last_Name AS Doctor_Name,
       pm.Medicine_ID, m.Medicine_Name, m.Dosage_Form, m.Strength, pm.Dosage, pm.Frequency, pm.Duration_Days
FROM Prescriptions p JOIN Appointments a ON p.Appointment_ID = a.Appointment_ID
JOIN Patients pat ON a.Patient_ID = pat.Patient_ID
JOIN Doctors doc ON a.Doctor_ID = doc.Employee_ID
JOIN Employees emp_doc ON doc.Employee_ID = emp_doc.Employee_ID
JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No
JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID;

CREATE OR REPLACE VIEW vw_Doctor_Appointment_Summary AS
SELECT d.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization,
       COUNT(a.Appointment_ID) AS Total_Appointments,
       SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Appointments,
       SUM(CASE WHEN a.Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Appointments,
       SUM(CASE WHEN a.Status = 'No-show' THEN 1 ELSE 0 END) AS No_Show_Appointments,
       SUM(CASE WHEN a.Status = 'Scheduled' THEN 1 ELSE 0 END) AS Scheduled_Appointments
FROM Doctors d JOIN Employees e ON d.Employee_ID = e.Employee_ID
LEFT JOIN Appointments a ON d.Employee_ID = a.Doctor_ID
GROUP BY d.Employee_ID, e.First_Name, e.Middle_Name, e.Last_Name, d.Specialization;

-- STORED PROCEDURE
CREATE OR REPLACE PROCEDURE sp_Add_Employee(
    p_First_Name IN VARCHAR2, p_Middle_Name IN VARCHAR2, p_Last_Name IN VARCHAR2,
    p_Phone IN VARCHAR2, p_City IN VARCHAR2, p_Street IN VARCHAR2, p_Neighborhood IN VARCHAR2,
    p_Salary IN NUMBER, p_Hire_Date IN DATE, p_Status IN VARCHAR2,
    p_Is_Doctor IN NUMBER, p_Specialization IN VARCHAR2, p_License_Number IN VARCHAR2,
    p_Role_ID IN NUMBER, p_Employee_ID OUT NUMBER
) AS
BEGIN
    INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status)
    VALUES (seq_employee_id.NEXTVAL, p_First_Name, p_Middle_Name, p_Last_Name, p_Phone, p_City, p_Street, p_Neighborhood, p_Salary, p_Hire_Date, p_Status)
    RETURNING Employee_ID INTO p_Employee_ID;
    IF p_Is_Doctor = 1 THEN
        INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES (p_Employee_ID, p_Specialization, p_License_Number);
    ELSE
        INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES (p_Employee_ID, p_Role_ID);
    END IF;
    COMMIT;
EXCEPTION WHEN OTHERS THEN ROLLBACK; RAISE;
END;
/

-- INDEXES
CREATE INDEX idx_patients_status ON Patients(Status);
CREATE INDEX idx_employees_status ON Employees(Status);
CREATE INDEX idx_appointments_date ON Appointments(Appointment_Date);
CREATE INDEX idx_appointments_status ON Appointments(Status);
CREATE INDEX idx_appointments_patient ON Appointments(Patient_ID);
CREATE INDEX idx_appointments_doctor ON Appointments(Doctor_ID);
CREATE INDEX idx_medical_records_appointment ON Medical_Records(Appointment_ID);
CREATE INDEX idx_prescriptions_appointment ON Prescriptions(Appointment_ID);
CREATE INDEX idx_invoices_appointment ON Invoices(Appointment_ID);
CREATE INDEX idx_payments_invoice ON Payments(Invoice_No);
CREATE INDEX idx_medicines_status ON Medicines(Status);
CREATE INDEX idx_services_status ON Services(Status);

-- ============================================================================
-- PART 2: DML - SAMPLE DATA
-- ============================================================================

-- ROLES
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

-- PATIENTS
INSERT INTO Patients (Patient_ID, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status) VALUES
(seq_patient_id.NEXTVAL, 'Ahmed', 'Mohammed', 'Al-Rashid', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 'Male', '966501234567', 'Riyadh', 'Olaya Street', 'Al-Olaya', 'Active'),
(seq_patient_id.NEXTVAL, 'Fatima', 'Ali', 'Al-Hassan', TO_DATE('1990-07-22', 'YYYY-MM-DD'), 'Female', '966502345678', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 'Active'),
(seq_patient_id.NEXTVAL, 'Omar', 'Khalid', 'Al-Otaibi', TO_DATE('1978-11-08', 'YYYY-MM-DD'), 'Male', '966503456789', 'Dammam', 'King Fahd Road', 'Al-Shati', 'Active'),
(seq_patient_id.NEXTVAL, 'Aisha', 'Saud', 'Al-Qahtani', TO_DATE('1995-02-14', 'YYYY-MM-DD'), 'Female', '966504567890', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 'Active'),
(seq_patient_id.NEXTVAL, 'Mohammed', 'Abdullah', 'Al-Zahrani', TO_DATE('1982-09-30', 'YYYY-MM-DD'), 'Male', '966505678901', 'Makkah', 'Ibrahim Al-Khalil Street', 'Al-Aziziyah', 'Active'),
(seq_patient_id.NEXTVAL, 'Sarah', 'Ahmed', 'Al-Ghamdi', TO_DATE('1988-05-17', 'YYYY-MM-DD'), 'Female', '966506789012', 'Jeddah', 'Palestine Street', 'Al-Rawdah', 'Active'),
(seq_patient_id.NEXTVAL, 'Abdulrahman', 'Fahad', 'Al-Harbi', TO_DATE('1992-12-25', 'YYYY-MM-DD'), 'Male', '966507890123', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 'Active'),
(seq_patient_id.NEXTVAL, 'Layla', 'Youssef', 'Al-Mutairi', TO_DATE('1998-08-03', 'YYYY-MM-DD'), 'Female', '966508901234', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 'Active'),
(seq_patient_id.NEXTVAL, 'Khalid', 'Salem', 'Al-Ansari', TO_DATE('1975-04-19', 'YYYY-MM-DD'), 'Male', '966509012345', 'Riyadh', 'Makkah Road', 'Al-Safa', 'Active'),
(seq_patient_id.NEXTVAL, 'Reem', 'Hassan', 'Al-Shammari', TO_DATE('1993-10-28', 'YYYY-MM-DD'), 'Female', '966510123456', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 'Active'),
(seq_patient_id.NEXTVAL, 'Turki', 'Nasser', 'Al-Dosari', TO_DATE('1980-06-12', 'YYYY-MM-DD'), 'Male', '966511234567', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 'Active'),
(seq_patient_id.NEXTVAL, 'Noura', 'Ibrahim', 'Al-Badr', TO_DATE('1996-01-09', 'YYYY-MM-DD'), 'Female', '966512345678', 'Riyadh', 'Othman Bin Affan Road', 'Al-Wafa', 'Active'),
(seq_patient_id.NEXTVAL, 'Faisal', 'Rashid', 'Al-Mutlaq', TO_DATE('1987-03-21', 'YYYY-MM-DD'), 'Male', '966513456789', 'Dammam', 'King Faisal Road', 'Al-Khalidiyyah', 'Active'),
(seq_patient_id.NEXTVAL, 'Hind', 'Mahmoud', 'Al-Farsi', TO_DATE('1994-07-15', 'YYYY-MM-DD'), 'Female', '966514567890', 'Jeddah', 'Al-Madinah Road', 'Al-Salam', 'Active'),
(seq_patient_id.NEXTVAL, 'Sultan', 'Abdulaziz', 'Al-Yami', TO_DATE('1979-11-02', 'YYYY-MM-DD'), 'Male', '966515678901', 'Riyadh', 'Prince Turki Road', 'Al-Quds', 'Active');

-- EMPLOYEES (Doctors)
INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Dr. Muhammad', 'Ahmed', 'Al-Saeed', '966520123456', 'Riyadh', 'King Fahd Road', 'Al-Malaz', 25000, TO_DATE('2015-01-15', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Sarah', 'Abdullah', 'Al-Khalifa', '966521234567', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 28000, TO_DATE('2014-03-20', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Ahmed', 'Youssef', 'Al-Obeikan', '966522345678', 'Riyadh', 'Olaya Street', 'Al-Olaya', 30000, TO_DATE('2013-06-10', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Layla', 'Mohammed', 'Al-Hammad', '966523456789', 'Dammam', 'King Faisal Road', 'Al-Khalidiyyah', 26000, TO_DATE('2016-02-28', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Omar', 'Khalid', 'Al-Drees', '966524567890', 'Makkah', 'Ibrahim Al-Khalil Street', 'Al-Aziziyah', 27000, TO_DATE('2015-09-12', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Fatima', 'Ali', 'Al-Mutairi', '966525678901', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 29000, TO_DATE('2014-11-05', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Abdulrahman', 'Saud', 'Al-Qahtani', '966526789012', 'Jeddah', 'Palestine Street', 'Al-Rawdah', 31000, TO_DATE('2012-04-18', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Aisha', 'Hassan', 'Al-Ghamdi', '966527890123', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 27500, TO_DATE('2015-07-22', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Mohammed', 'Fahad', 'Al-Harbi', '966528901234', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 28500, TO_DATE('2016-01-08', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Noura', 'Youssef', 'Al-Zahrani', '966529012345', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 29500, TO_DATE('2014-08-30', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Khalid', 'Salem', 'Al-Ansari', '966530123456', 'Riyadh', 'Makkah Road', 'Al-Safa', 32000, TO_DATE('2011-12-15', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Dr. Reem', 'Abdulaziz', 'Al-Shammari', '966531234567', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 30500, TO_DATE('2013-05-25', 'YYYY-MM-DD'), 'Active');

-- EMPLOYEES (General)
INSERT INTO Employees (Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status) VALUES
(seq_employee_id.NEXTVAL, 'Ahmed', 'Mohammed', 'Al-Rashid', '966532345678', 'Riyadh', 'Olaya Street', 'Al-Olaya', 8000, TO_DATE('2018-03-01', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Fatima', 'Ali', 'Al-Hassan', '966533456789', 'Jeddah', 'Prince Sultan Road', 'Al-Hamra', 7500, TO_DATE('2019-06-15', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Omar', 'Khalid', 'Al-Otaibi', '966534567890', 'Dammam', 'King Fahd Road', 'Al-Shati', 8200, TO_DATE('2017-09-20', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Aisha', 'Saud', 'Al-Qahtani', '966535678901', 'Riyadh', 'Takhassusi Street', 'Al-Rabwah', 7800, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Mohammed', 'Abdullah', 'Al-Zahrani', '966536789012', 'Makkah', 'Ibrahim Al-Khalil Street', 'Al-Aziziyah', 8500, TO_DATE('2017-04-05', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Sarah', 'Ahmed', 'Al-Ghamdi', '966537890123', 'Jeddah', 'Palestine Street', 'Al-Rawdah', 7900, TO_DATE('2019-01-25', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Abdulrahman', 'Fahad', 'Al-Harbi', '966538901234', 'Riyadh', 'King Abdullah Road', 'Al-Malaz', 8300, TO_DATE('2018-07-18', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Layla', 'Youssef', 'Al-Mutairi', '966539012345', 'Dammam', 'Prince Mohammed Road', 'Al-Manar', 8100, TO_DATE('2019-03-12', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Khalid', 'Salem', 'Al-Ansari', '966540123456', 'Riyadh', 'Makkah Road', 'Al-Safa', 8700, TO_DATE('2016-11-30', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Reem', 'Hassan', 'Al-Shammari', '966541234567', 'Jeddah', 'Airport Road', 'Al-Nuzlah', 8400, TO_DATE('2017-08-22', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Turki', 'Nasser', 'Al-Dosari', '966542345678', 'Makkah', 'Al-Haram Road', 'Al-Hijra', 8600, TO_DATE('2016-05-14', 'YYYY-MM-DD'), 'Active'),
(seq_employee_id.NEXTVAL, 'Noura', 'Ibrahim', 'Al-Badr', '966543456789', 'Riyadh', 'Othman Bin Affan Road', 'Al-Wafa', 8800, TO_DATE('2015-10-08', 'YYYY-MM-DD'), 'Active');

-- DOCTORS
INSERT INTO Doctors (Employee_ID, Specialization, License_Number) VALUES
(1, 'Cardiology', 'SA-CARD-001'), (2, 'Dermatology', 'SA-DERM-002'), (3, 'General Medicine', 'SA-GEN-003'),
(4, 'Pediatrics', 'SA-PED-004'), (5, 'Orthopedics', 'SA-ORTHO-005'), (6, 'Gynecology', 'SA-GYN-006'),
(7, 'Neurology', 'SA-NEURO-007'), (8, 'Ophthalmology', 'SA-OPHTH-008'), (9, 'Internal Medicine', 'SA-INT-009'),
(10, 'ENT', 'SA-ENT-010'), (11, 'Radiology', 'SA-RAD-011'), (12, 'Psychiatry', 'SA-PSYCH-012');

-- GENERAL EMPLOYEES
INSERT INTO General_Employees (Employee_ID, Role_ID) VALUES
(13, 1), (14, 2), (15, 3), (16, 4), (17, 5), (18, 6), (19, 7), (20, 8), (21, 9), (22, 10), (23, 11), (24, 12);

-- MEDICINES
INSERT INTO Medicines (Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status) VALUES
(seq_medicine_id.NEXTVAL, 'Paracetamol', 'Tablet', '500mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Ibuprofen', 'Tablet', '400mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Amoxicillin', 'Capsule', '500mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Omeprazole', 'Capsule', '20mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Metformin', 'Tablet', '850mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Lisinopril', 'Tablet', '10mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Cetirizine', 'Tablet', '10mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Vitamin D3', 'Capsule', '1000 IU', 'Active'),
(seq_medicine_id.NEXTVAL, 'Cough Syrup', 'Syrup', '100ml', 'Active'),
(seq_medicine_id.NEXTVAL, 'Salbutamol', 'Inhaler', '100mcg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Aspirin', 'Tablet', '100mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Antacid', 'Tablet', '400mg', 'Active'),
(seq_medicine_id.NEXTVAL, 'Insulin', 'Injection', '100 IU/ml', 'Active'),
(seq_medicine_id.NEXTVAL, 'Antibiotic Ointment', 'Ointment', '10g', 'Active'),
(seq_medicine_id.NEXTVAL, 'Old Painkiller', 'Tablet', '200mg', 'Inactive');

-- SERVICES
INSERT INTO Services (Service_ID, Service_Name, Description, Price, Status) VALUES
(seq_service_id.NEXTVAL, 'General Consultation', 'Standard doctor consultation', 200, 'Active'),
(seq_service_id.NEXTVAL, 'Specialist Consultation', 'Consultation with specialist doctor', 350, 'Active'),
(seq_service_id.NEXTVAL, 'Laboratory Tests', 'Basic blood work and lab tests', 150, 'Active'),
(seq_service_id.NEXTVAL, 'X-Ray', 'Digital X-Ray imaging', 120, 'Active'),
(seq_service_id.NEXTVAL, 'Ultrasound', 'Ultrasound imaging', 200, 'Active'),
(seq_service_id.NEXTVAL, 'ECG', 'Electrocardiogram test', 80, 'Active'),
(seq_service_id.NEXTVAL, 'Vaccination', 'Standard vaccination', 50, 'Active'),
(seq_service_id.NEXTVAL, 'Wound Dressing', 'Minor wound treatment and dressing', 75, 'Active'),
(seq_service_id.NEXTVAL, 'IV Therapy', 'Intravenous fluid administration', 100, 'Active'),
(seq_service_id.NEXTVAL, 'Physical Therapy Session', 'Physical therapy consultation', 250, 'Active'),
(seq_service_id.NEXTVAL, 'Dietary Consultation', 'Nutritionist consultation', 180, 'Active'),
(seq_service_id.NEXTVAL, 'Follow-up Visit', 'Follow-up appointment with doctor', 100, 'Active'),
(seq_service_id.NEXTVAL, 'Emergency Visit', 'Urgent medical consultation', 400, 'Active'),
(seq_service_id.NEXTVAL, 'Health Checkup', 'Comprehensive health examination', 500, 'Active'),
(seq_service_id.NEXTVAL, 'Old Service', 'Discontinued service', 0, 'Inactive');

-- APPPOINTMENTS
INSERT INTO Appointments (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit) VALUES
(seq_appointment_id.NEXTVAL, 1, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Chest pain and shortness of breath'),
(seq_appointment_id.NEXTVAL, 2, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Skin rash and itching'),
(seq_appointment_id.NEXTVAL, 3, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Fever and body aches'),
(seq_appointment_id.NEXTVAL, 4, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child vaccination'),
(seq_appointment_id.NEXTVAL, 5, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Joint pain in knees'),
(seq_appointment_id.NEXTVAL, 6, 6, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Routine checkup'),
(seq_appointment_id.NEXTVAL, 7, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Severe headache'),
(seq_appointment_id.NEXTVAL, 8, 8, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Eye examination'),
(seq_appointment_id.NEXTVAL, 9, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Stomach pain'),
(seq_appointment_id.NEXTVAL, 10, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Ear infection'),
(seq_appointment_id.NEXTVAL, 11, 11, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Chest X-Ray follow-up'),
(seq_appointment_id.NEXTVAL, 12, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Anxiety and stress'),
(seq_appointment_id.NEXTVAL, 1, 3, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Follow-up for heart condition'),
(seq_appointment_id.NEXTVAL, 2, 2, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'Scheduled', 'Cancelled', 'Patient unable to attend'),
(seq_appointment_id.NEXTVAL, 3, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Scheduled', 'No-show', 'Patient did not attend'),
(seq_appointment_id.NEXTVAL, 4, 4, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child fever'),
(seq_appointment_id.NEXTVAL, 5, 5, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Back pain'),
(seq_appointment_id.NEXTVAL, 6, 6, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Annual gynecological exam'),
(seq_appointment_id.NEXTVAL, 7, 7, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Migraine follow-up'),
(seq_appointment_id.NEXTVAL, 8, 8, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Vision test'),
(seq_appointment_id.NEXTVAL, 9, 9, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Digestive issues'),
(seq_appointment_id.NEXTVAL, 10, 10, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Throat infection'),
(seq_appointment_id.NEXTVAL, 11, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Cardiac stress test'),
(seq_appointment_id.NEXTVAL, 12, 12, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Depression consultation'),
(seq_appointment_id.NEXTVAL, 13, 3, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Diabetes management'),
(seq_appointment_id.NEXTVAL, 14, 2, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Walk-in', 'Completed', 'Allergic reaction'),
(seq_appointment_id.NEXTVAL, 15, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Scheduled', 'Completed', 'Child developmental check');

-- MEDICAL RECORDS
INSERT INTO Medical_Records (Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date) VALUES
(seq_record_no.NEXTVAL, 1, 'Angina pectoris', 'Patient presents with chest pain and shortness of breath. ECG shows mild abnormalities.', TO_DATE('2024-01-15', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 2, 'Contact dermatitis', 'Skin rash on arms and legs. Patient reports using new laundry detergent.', TO_DATE('2024-01-16', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 3, 'Viral fever', 'Patient has fever of 38.5°C with body aches. No specific infection source identified.', TO_DATE('2024-01-17', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 4, 'Routine vaccination', 'Child received scheduled vaccinations: DTP, Polio, and MMR.', TO_DATE('2024-01-18', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 5, 'Osteoarthritis', 'Patient reports knee pain worsened by activity. X-ray shows mild degenerative changes.', TO_DATE('2024-01-19', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 6, 'Normal pregnancy', 'Routine prenatal checkup. Fetal heart rate normal. Blood pressure within normal range.', TO_DATE('2024-01-20', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 7, 'Migraine', 'Patient reports severe headache with aura. CT scan normal.', TO_DATE('2024-01-21', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 8, 'Myopia', 'Patient has difficulty seeing distant objects. Vision test confirms nearsightedness.', TO_DATE('2024-01-22', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 9, 'Gastritis', 'Patient reports stomach pain after meals. Endoscopy shows mild inflammation.', TO_DATE('2024-01-23', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 10, 'Otitis media', 'Patient has ear pain and reduced hearing. Examination shows ear infection.', TO_DATE('2024-01-24', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 11, 'Normal chest X-ray', 'Follow-up X-ray shows no abnormalities. Previous condition resolved.', TO_DATE('2024-01-25', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 12, 'Generalized anxiety disorder', 'Patient reports anxiety and stress. Recommended therapy and lifestyle changes.', TO_DATE('2024-01-26', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 13, 'Stable angina', 'Follow-up for heart condition. ECG stable. Medication effective.', TO_DATE('2024-02-01', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 14, 'Pediatric fever', 'Child has fever of 39°C. Throat culture negative. Viral infection suspected.', TO_DATE('2024-02-15', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 15, 'Lower back pain', 'Patient reports chronic back pain. MRI shows disc herniation.', TO_DATE('2024-02-20', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 16, 'Healthy pregnancy', 'Routine prenatal checkup. All tests normal. Fetal growth appropriate.', TO_DATE('2024-02-25', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 17, 'Chronic migraine', 'Follow-up for migraine. Frequency reduced with medication.', TO_DATE('2024-03-01', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 18, 'Stable myopia', 'Follow-up vision test. Prescription unchanged. Annual exam recommended.', TO_DATE('2024-03-05', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 19, 'Irritable bowel syndrome', 'Patient reports digestive issues. Colonoscopy normal.', TO_DATE('2024-03-10', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 20, 'Pharyngitis', 'Patient has sore throat and fever. Rapid strep test positive.', TO_DATE('2024-03-15', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 21, 'Normal cardiac stress test', 'Stress test results normal. No evidence of coronary artery disease.', TO_DATE('2024-03-20', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 22, 'Major depressive disorder', 'Patient reports persistent low mood. Recommended antidepressant medication.', TO_DATE('2024-03-25', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 23, 'Type 2 diabetes', 'Patient has elevated blood sugar. HbA1c 7.5%. Recommended metformin.', TO_DATE('2024-04-01', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 24, 'Allergic contact dermatitis', 'Patient has allergic reaction to unknown substance.', TO_DATE('2024-04-05', 'YYYY-MM-DD')),
(seq_record_no.NEXTVAL, 25, 'Normal development', 'Child developmental assessment normal. All milestones achieved.', TO_DATE('2024-04-10', 'YYYY-MM-DD'));

-- PRESCRIPTIONS
INSERT INTO Prescriptions (Prescription_No, Appointment_ID, Prescription_Date, General_Instructions) VALUES
(seq_prescription_no.NEXTVAL, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Take with food. Avoid alcohol. Monitor blood pressure.'),
(seq_prescription_no.NEXTVAL, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Apply to affected area twice daily. Avoid sun exposure.'),
(seq_prescription_no.NEXTVAL, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Complete full course. Rest and fluids. Consult if fever persists.'),
(seq_prescription_no.NEXTVAL, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Take with meals. May cause stomach upset. Report any side effects.'),
(seq_prescription_no.NEXTVAL, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Take at onset of symptoms. Avoid driving if drowsy. Limit caffeine.'),
(seq_prescription_no.NEXTVAL, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Take before meals. Avoid spicy foods. Follow up in 2 weeks.'),
(seq_prescription_no.NEXTVAL, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Complete full course. Take with water. Keep hydrated.'),
(seq_prescription_no.NEXTVAL, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Take daily at same time. May take 2-4 weeks for full effect.'),
(seq_prescription_no.NEXTVAL, 13, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Continue as prescribed. Monitor blood pressure weekly.'),
(seq_prescription_no.NEXTVAL, 14, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Dose based on weight. Complete full course. Keep hydrated.'),
(seq_prescription_no.NEXTVAL, 15, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Take with food. May cause dizziness. Avoid alcohol.'),
(seq_prescription_no.NEXTVAL, 17, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Take at onset. Keep headache diary. Identify triggers.'),
(seq_prescription_no.NEXTVAL, 19, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Take before meals. Increase fiber intake. Probiotics recommended.'),
(seq_prescription_no.NEXTVAL, 20, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Complete full course. Gargle with warm salt water. Rest voice.'),
(seq_prescription_no.NEXTVAL, 22, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Take daily at same time. Regular therapy sessions essential.'),
(seq_prescription_no.NEXTVAL, 23, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Take with meals. Monitor blood sugar regularly. Exercise and diet important.'),
(seq_prescription_no.NEXTVAL, 24, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Take as needed. Identify and avoid allergen. Cool compress for itching.');

-- PRESCRIPTION MEDICINES
INSERT INTO Prescription_Medicines (Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days) VALUES
(1, 1, '1 tablet', '3 times daily', 30), (1, 5, '1 tablet', 'Twice daily', 30),
(2, 7, '1 tablet', 'Once daily', 14), (2, 14, 'Apply thin layer', 'Twice daily', 7),
(3, 1, '1 tablet', 'Every 6 hours', 5), (3, 9, '10ml', '3 times daily', 5),
(5, 2, '1 tablet', 'Twice daily', 21), (5, 4, '1 capsule', 'Once daily', 21),
(7, 1, '1 tablet', 'As needed', 30), (7, 7, '1 tablet', 'Once daily', 30),
(9, 4, '1 capsule', 'Once daily', 14), (9, 12, '1 tablet', '3 times daily', 14),
(10, 3, '1 capsule', '3 times daily', 7), (10, 1, '1 tablet', 'Every 6 hours', 7),
(12, 7, '1 tablet', 'Once daily', 90), (12, 8, '1 capsule', 'Once daily', 90),
(13, 6, '1 tablet', 'Once daily', 30), (13, 11, '1 tablet', 'Once daily', 30),
(14, 1, '0.5 tablet', 'Every 6 hours', 5), (14, 9, '5ml', '3 times daily', 5),
(15, 2, '1 tablet', 'Twice daily', 14), (15, 1, '1 tablet', 'As needed', 14),
(17, 7, '1 tablet', 'As needed', 60), (17, 8, '1 capsule', 'Once daily', 60),
(19, 4, '1 capsule', 'Once daily', 28), (19, 12, '1 tablet', '3 times daily', 28),
(20, 3, '1 capsule', '3 times daily', 10), (20, 9, '10ml', '3 times daily', 10),
(22, 7, '1 tablet', 'Once daily', 180), (22, 8, '1 capsule', 'Once daily', 180),
(23, 5, '1 tablet', 'Twice daily', 90), (23, 8, '1 capsule', 'Once daily', 90),
(24, 7, '1 tablet', 'Twice daily', 7), (24, 14, 'Apply thin layer', '3 times daily', 5);

-- INVOICES
INSERT INTO Invoices (Invoice_No, Appointment_ID, Issue_Date) VALUES
(seq_invoice_no.NEXTVAL, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 2, TO_DATE('2024-01-16', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 3, TO_DATE('2024-01-17', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 5, TO_DATE('2024-01-19', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 6, TO_DATE('2024-01-20', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 7, TO_DATE('2024-01-21', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 8, TO_DATE('2024-01-22', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 9, TO_DATE('2024-01-23', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 10, TO_DATE('2024-01-24', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 11, TO_DATE('2024-01-25', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 12, TO_DATE('2024-01-26', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 13, TO_DATE('2024-02-01', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 14, TO_DATE('2024-02-15', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 15, TO_DATE('2024-02-20', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 16, TO_DATE('2024-02-25', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 17, TO_DATE('2024-03-01', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 18, TO_DATE('2024-03-05', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 19, TO_DATE('2024-03-10', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 20, TO_DATE('2024-03-15', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 21, TO_DATE('2024-03-20', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 22, TO_DATE('2024-03-25', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 23, TO_DATE('2024-04-01', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 24, TO_DATE('2024-04-05', 'YYYY-MM-DD')),
(seq_invoice_no.NEXTVAL, 25, TO_DATE('2024-04-10', 'YYYY-MM-DD'));

-- INVOICE SERVICES
INSERT INTO Invoice_Services (Invoice_No, Service_ID, Quantity, Unit_Price) VALUES
(1, 2, 1, 350), (1, 6, 1, 80), (2, 2, 1, 350), (3, 1, 1, 200), (3, 3, 1, 150),
(4, 2, 1, 350), (4, 7, 3, 50), (5, 2, 1, 350), (5, 4, 1, 120), (6, 2, 1, 350), (6, 3, 1, 150),
(7, 2, 1, 350), (7, 5, 1, 200), (8, 2, 1, 350), (9, 2, 1, 350), (9, 3, 1, 150),
(10, 2, 1, 350), (11, 2, 1, 350), (11, 4, 1, 120), (12, 2, 1, 350), (13, 12, 1, 100), (13, 6, 1, 80),
(14, 2, 1, 350), (14, 3, 1, 150), (15, 2, 1, 350), (15, 10, 1, 250), (16, 12, 1, 100), (16, 3, 1, 150),
(17, 12, 1, 100), (18, 12, 1, 100), (19, 2, 1, 350), (19, 3, 1, 150), (20, 2, 1, 350),
(21, 2, 1, 350), (21, 6, 1, 80), (22, 2, 1, 350), (23, 2, 1, 350), (23, 3, 1, 150),
(24, 2, 1, 350), (25, 2, 1, 350);

-- PAYMENTS
INSERT INTO Payments (Payment_No, Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method) VALUES
(seq_payment_no.NEXTVAL, 1, 13, 430, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 2, 13, 350, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 3, 15, 350, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 'Bank Transfer'),
(seq_payment_no.NEXTVAL, 4, 13, 500, TO_DATE('2024-01-18', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 5, 13, 200, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 5, 13, 270, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 6, 13, 500, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 7, 13, 550, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 8, 13, 350, TO_DATE('2024-01-22', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 9, 15, 500, TO_DATE('2024-01-23', 'YYYY-MM-DD'), 'Bank Transfer'),
(seq_payment_no.NEXTVAL, 10, 13, 350, TO_DATE('2024-01-24', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 11, 13, 470, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 12, 13, 350, TO_DATE('2024-01-26', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 13, 13, 180, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 14, 13, 500, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 15, 13, 300, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 15, 15, 300, TO_DATE('2024-02-27', 'YYYY-MM-DD'), 'Bank Transfer'),
(seq_payment_no.NEXTVAL, 16, 13, 250, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 17, 13, 100, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 18, 13, 100, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 19, 15, 500, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Bank Transfer'),
(seq_payment_no.NEXTVAL, 20, 13, 350, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 21, 13, 430, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Cash'),
(seq_payment_no.NEXTVAL, 22, 13, 350, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Card'),
(seq_payment_no.NEXTVAL, 23, 13, 500, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Insurance'),
(seq_payment_no.NEXTVAL, 24, 13, 350, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Cash');

COMMIT;

-- ============================================================================
-- PART 3: DQL - 15 USEFUL QUERIES
-- ============================================================================

-- Query 1: List all active patients with their contact information
SELECT Patient_ID, First_Name || ' ' || Middle_Name || ' ' || Last_Name AS Full_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status
FROM Patients WHERE Status = 'Active' ORDER BY Last_Name, First_Name;

-- Query 2: Find patients by city
SELECT Patient_ID, First_Name || ' ' || Middle_Name || ' ' || Last_Name AS Full_Name, Phone, City, Street, Neighborhood
FROM Patients WHERE City = 'Riyadh' ORDER BY Neighborhood, Last_Name;

-- Query 3: List all doctors with their specializations and license numbers
SELECT d.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization, d.License_Number, e.Phone, e.City, e.Status
FROM Doctors d JOIN Employees e ON d.Employee_ID = e.Employee_ID ORDER BY d.Specialization, e.Last_Name;

-- Query 4: Find all active doctors by specialization
SELECT d.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization, d.License_Number, e.City
FROM Doctors d JOIN Employees e ON d.Employee_ID = e.Employee_ID WHERE e.Status = 'Active' AND d.Specialization = 'Cardiology' ORDER BY e.Last_Name;

-- Query 5: List all general employees with their roles
SELECT ge.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Employee_Name, r.Role_Name, r.Description, e.Phone, e.City, e.Status
FROM General_Employees ge JOIN Employees e ON ge.Employee_ID = e.Employee_ID JOIN Roles r ON ge.Role_ID = r.Role_ID ORDER BY r.Role_Name, e.Last_Name;

-- Query 6: Find employees by role
SELECT ge.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Employee_Name, r.Role_Name, e.Phone, e.City, e.Salary, e.Hire_Date
FROM General_Employees ge JOIN Employees e ON ge.Employee_ID = e.Employee_ID JOIN Roles r ON ge.Role_ID = r.Role_ID WHERE r.Role_Name = 'Nurse' ORDER BY e.Hire_Date DESC;

-- Query 7: List all active medicines
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status FROM Medicines WHERE Status = 'Active' ORDER BY Medicine_Name;

-- Query 8: Find medicines by dosage form
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status FROM Medicines WHERE Dosage_Form = 'Tablet' AND Status = 'Active' ORDER BY Medicine_Name;

-- Query 9: List all active services with their prices
SELECT Service_ID, Service_Name, Description, Price, Status FROM Services WHERE Status = 'Active' ORDER BY Price DESC, Service_Name;

-- Query 10: Find services within a price range
SELECT Service_ID, Service_Name, Description, Price, Status FROM Services WHERE Price BETWEEN 100 AND 300 AND Status = 'Active' ORDER BY Price;

-- Query 11: List all appointments for a specific patient
SELECT a.Appointment_ID, a.Appointment_Date, a.Appointment_Type, a.Status, a.Reason_for_Visit, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization
FROM Appointments a JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Employees e ON d.Employee_ID = e.Employee_ID WHERE a.Patient_ID = 1 ORDER BY a.Appointment_Date DESC;

-- Query 12: Find appointments by date range
SELECT a.Appointment_ID, p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, a.Appointment_Date, a.Appointment_Type, a.Status, a.Reason_for_Visit
FROM Appointments a JOIN Patients p ON a.Patient_ID = p.Patient_ID JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE a.Appointment_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-01-31', 'YYYY-MM-DD') ORDER BY a.Appointment_Date;

-- Query 13: List appointments by status
SELECT a.Appointment_ID, p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name, p.Phone, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, a.Appointment_Date, a.Appointment_Type, a.Status, a.Reason_for_Visit
FROM Appointments a JOIN Patients p ON a.Patient_ID = p.Patient_ID JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Employees e ON d.Employee_ID = e.Employee_ID WHERE a.Status = 'Completed' ORDER BY a.Appointment_Date DESC;

-- Query 14: Find medical records by diagnosis keyword
SELECT mr.Record_No, a.Appointment_ID, a.Appointment_Date, p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, mr.Diagnosis, mr.Clinical_Notes, mr.Record_Date
FROM Medical_Records mr JOIN Appointments a ON mr.Appointment_ID = a.Appointment_ID JOIN Patients p ON a.Patient_ID = p.Patient_ID JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE UPPER(mr.Diagnosis) LIKE '%FEVER%' ORDER BY mr.Record_Date DESC;

-- Query 15: List all prescriptions for a specific appointment
SELECT p.Prescription_No, p.Prescription_Date, p.General_Instructions, pm.Medicine_ID, m.Medicine_Name, m.Dosage_Form, m.Strength, pm.Dosage, pm.Frequency, pm.Duration_Days
FROM Prescriptions p JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID WHERE p.Appointment_ID = 1 ORDER BY p.Prescription_Date, m.Medicine_Name;

-- ============================================================================
-- PART 4: ADVANCED JOIN QUERIES (3 QUERIES)
-- ============================================================================

-- JOIN Query 1: Complete Patient Appointment History with Doctor and Invoice Details
SELECT p.Patient_ID, p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name, p.Phone, p.City, a.Appointment_ID, a.Appointment_Date, a.Appointment_Type, a.Status AS Appointment_Status, a.Reason_for_Visit, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization, i.Invoice_No, i.Issue_Date, s.Service_Name, is_inv.Quantity, is_inv.Unit_Price, (is_inv.Quantity * is_inv.Unit_Price) AS Line_Total
FROM Patients p JOIN Appointments a ON p.Patient_ID = a.Patient_ID JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Employees e ON d.Employee_ID = e.Employee_ID LEFT JOIN Invoices i ON a.Appointment_ID = i.Appointment_ID LEFT JOIN Invoice_Services is_inv ON i.Invoice_No = is_inv.Invoice_No LEFT JOIN Services s ON is_inv.Service_ID = s.Service_ID WHERE p.Patient_ID = 1 ORDER BY a.Appointment_Date DESC, i.Invoice_No, s.Service_Name;

-- JOIN Query 2: Prescription Details with Patient, Doctor, and Medicine Information
SELECT p.Prescription_No, p.Prescription_Date, p.General_Instructions, pat.Patient_ID, pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name, pat.Phone, pat.City, a.Appointment_ID, a.Appointment_Date, a.Reason_for_Visit, doc.Employee_ID AS Doctor_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization, pm.Medicine_ID, m.Medicine_Name, m.Dosage_Form, m.Strength, pm.Dosage, pm.Frequency, pm.Duration_Days
FROM Prescriptions p JOIN Appointments a ON p.Appointment_ID = a.Appointment_ID JOIN Patients pat ON a.Patient_ID = pat.Patient_ID JOIN Doctors doc ON a.Doctor_ID = doc.Employee_ID JOIN Employees e ON doc.Employee_ID = e.Employee_ID JOIN Doctors d ON a.Doctor_ID = d.Employee_ID JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID WHERE p.Prescription_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-03-31', 'YYYY-MM-DD') ORDER BY p.Prescription_Date DESC, p.Prescription_No, m.Medicine_Name;

-- JOIN Query 3: Payment History with Invoice, Patient, and Employee Details
SELECT pay.Payment_No, pay.Amount_Paid, pay.Payment_Date, pay.Payment_Method, inv.Invoice_No, inv.Issue_Date, app.Appointment_ID, app.Appointment_Date, pat.Patient_ID, pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name, pat.Phone, pat.City, ge.Employee_ID AS Processing_Employee_ID, emp.First_Name || ' ' || emp.Middle_Name || ' ' || emp.Last_Name AS Processing_Employee_Name, r.Role_Name AS Employee_Role, (SELECT SUM(Quantity * Unit_Price) FROM Invoice_Services WHERE Invoice_No = inv.Invoice_No) AS Invoice_Total, (SELECT SUM(Amount_Paid) FROM Payments WHERE Invoice_No = inv.Invoice_No) AS Total_Paid
FROM Payments pay JOIN Invoices inv ON pay.Invoice_No = inv.Invoice_No JOIN Appointments app ON inv.Appointment_ID = app.Appointment_ID JOIN Patients pat ON app.Patient_ID = pat.Patient_ID JOIN General_Employees ge ON pay.Created_By_Employee_ID = ge.Employee_ID JOIN Employees emp ON ge.Employee_ID = emp.Employee_ID JOIN Roles r ON ge.Role_ID = r.Role_ID WHERE pay.Payment_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-03-31', 'YYYY-MM-DD') ORDER BY pay.Payment_Date DESC, pay.Payment_No;

-- ============================================================================
-- PART 5: AGGREGATE QUERIES (2 GROUP BY QUERIES)
-- ============================================================================

-- Aggregate Query 1: Doctor Performance Summary
SELECT d.Employee_ID, e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name, d.Specialization, COUNT(a.Appointment_ID) AS Total_Appointments, SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Appointments, SUM(CASE WHEN a.Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Appointments, SUM(CASE WHEN a.Status = 'No-show' THEN 1 ELSE 0 END) AS No_Show_Appointments, SUM(CASE WHEN a.Status = 'Scheduled' THEN 1 ELSE 0 END) AS Scheduled_Appointments, ROUND((SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(a.Appointment_ID), 0), 2) AS Completion_Rate_Percentage, ROUND((SUM(CASE WHEN a.Status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(a.Appointment_ID), 0), 2) AS Cancellation_NoShow_Rate_Percentage
FROM Doctors d JOIN Employees e ON d.Employee_ID = e.Employee_ID LEFT JOIN Appointments a ON d.Employee_ID = a.Doctor_ID GROUP BY d.Employee_ID, e.First_Name, e.Middle_Name, e.Last_Name, d.Specialization ORDER BY Total_Appointments DESC, Doctor_Name;

-- Aggregate Query 2: Revenue Analysis by Specialization and Payment Method
SELECT d.Specialization, pay.Payment_Method, COUNT(DISTINCT i.Invoice_No) AS Total_Invoices, COUNT(pay.Payment_No) AS Total_Payments, SUM(pay.Amount_Paid) AS Total_Revenue, ROUND(AVG(pay.Amount_Paid), 2) AS Average_Payment_Amount, ROUND((SUM(pay.Amount_Paid) * 100.0) / NULLIF((SELECT SUM(Amount_Paid) FROM Payments), 0), 2) AS Revenue_Percentage, ROUND((COUNT(pay.Payment_No) * 100.0) / NULLIF(COUNT(DISTINCT i.Invoice_No), 0), 2) AS Payments_Per_Invoice
FROM Doctors d JOIN Appointments a ON d.Employee_ID = a.Doctor_ID JOIN Invoices i ON a.Appointment_ID = i.Appointment_ID JOIN Payments pay ON i.Invoice_No = pay.Invoice_No GROUP BY d.Specialization, pay.Payment_Method ORDER BY d.Specialization, Total_Revenue DESC;

-- ============================================================================
-- PART 6: UPDATE AND DELETE EXAMPLES
-- ============================================================================

-- UPDATE Example 1: Update patient contact information
UPDATE Patients SET Phone = '966509876543', City = 'Riyadh', Street = 'New Olaya Street', Neighborhood = 'Al-Olaya' WHERE Patient_ID = 1;

-- UPDATE Example 2: Change patient status
UPDATE Patients SET Status = 'Inactive' WHERE Patient_ID = 2;

-- UPDATE Example 3: Update employee salary (10% increase)
UPDATE Employees SET Salary = ROUND(Salary * 1.10, 2) WHERE Employee_ID = 13;

-- UPDATE Example 4: Update doctor specialization
UPDATE Doctors SET Specialization = 'Interventional Cardiology' WHERE Employee_ID = 1;

-- UPDATE Example 5: Update employee status
UPDATE Employees SET Status = 'Inactive' WHERE Employee_ID = 14;

-- UPDATE Example 6: Update medicine status
UPDATE Medicines SET Status = 'Inactive' WHERE Medicine_ID = 15;

-- UPDATE Example 7: Update service price (10% increase)
UPDATE Services SET Price = ROUND(Price * 1.10, 2) WHERE Service_ID = 1;

-- UPDATE Example 8: Update service status
UPDATE Services SET Status = 'Inactive' WHERE Service_ID = 15;

-- UPDATE Example 9: Update appointment status
UPDATE Appointments SET Status = 'Completed' WHERE Appointment_ID = 15;

-- UPDATE Example 10: Update medical record notes
UPDATE Medical_Records SET Clinical_Notes = 'Patient presents with chest pain and shortness of breath. ECG shows mild abnormalities. Recommended stress test. Patient responds well to initial treatment.' WHERE Record_No = 1;

-- DELETE Example 1: Delete a specific payment
DELETE FROM Payments WHERE Payment_No = 1;

-- DELETE Example 2: Delete invoice services line item
DELETE FROM Invoice_Services WHERE Invoice_No = 1 AND Service_ID = 1;

-- DELETE Example 3: Delete prescription medicine
DELETE FROM Prescription_Medicines WHERE Prescription_No = 1 AND Medicine_ID = 1;

-- DELETE Example 4: Delete a prescription (requires deleting medicines first)
DELETE FROM Prescription_Medicines WHERE Prescription_No = 1;
DELETE FROM Prescriptions WHERE Prescription_No = 1;

-- DELETE Example 5: Delete a medical record
DELETE FROM Medical_Records WHERE Record_No = 1;

-- DELETE Example 6: Delete an invoice (requires deleting payments and services first)
DELETE FROM Payments WHERE Invoice_No = 1;
DELETE FROM Invoice_Services WHERE Invoice_No = 1;
DELETE FROM Invoices WHERE Invoice_No = 1;

-- DELETE Example 7: Batch delete inactive medicines
DELETE FROM Medicines WHERE Status = 'Inactive';

-- DELETE Example 8: Delete inactive services
DELETE FROM Services WHERE Status = 'Inactive';

-- ============================================================================
-- END OF COMPLETE CLINIC MANAGEMENT SYSTEM IMPLEMENTATION
-- ============================================================================
