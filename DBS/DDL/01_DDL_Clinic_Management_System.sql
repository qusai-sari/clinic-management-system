-- ============================================================================
-- Clinic Management System - DDL Script
-- Database: Oracle
-- ============================================================================
-- This script creates all tables, constraints, and triggers for the Clinic
-- Management System based on the System Analysis, ERD, Schema, and Normalization.
-- ============================================================================

-- Drop existing objects safely so the script can be re-run.
BEGIN
    FOR r IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'PAYMENTS','INVOICE_SERVICES','INVOICES','PRESCRIPTION_MEDICINES',
            'PRESCRIPTIONS','MEDICINES','MEDICAL_RECORDS','APPOINTMENTS',
            'SERVICES','GENERAL_EMPLOYEES','DOCTORS','EMPLOYEES','ROLES','PATIENTS'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || r.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/

BEGIN
    FOR r IN (
        SELECT sequence_name FROM user_sequences
        WHERE sequence_name IN (
            'SEQ_PATIENT_ID','SEQ_ROLE_ID','SEQ_EMPLOYEE_ID','SEQ_APPOINTMENT_ID',
            'SEQ_RECORD_NO','SEQ_PRESCRIPTION_NO','SEQ_MEDICINE_ID','SEQ_SERVICE_ID',
            'SEQ_INVOICE_NO','SEQ_PAYMENT_NO'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || r.sequence_name;
    END LOOP;
END;
/

-- ============================================================================
-- SEQUENCES
-- ============================================================================

-- Sequence for Patient_ID
CREATE SEQUENCE seq_patient_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Role_ID
CREATE SEQUENCE seq_role_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Employee_ID
CREATE SEQUENCE seq_employee_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Appointment_ID
CREATE SEQUENCE seq_appointment_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Record_No (Medical_Records)
CREATE SEQUENCE seq_record_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Prescription_No
CREATE SEQUENCE seq_prescription_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Medicine_ID
CREATE SEQUENCE seq_medicine_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Service_ID
CREATE SEQUENCE seq_service_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Invoice_No
CREATE SEQUENCE seq_invoice_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Sequence for Payment_No
CREATE SEQUENCE seq_payment_no
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- ============================================================================
-- TABLES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Patients Table
-- ----------------------------------------------------------------------------
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

-- ----------------------------------------------------------------------------
-- 2. Roles Table
-- ----------------------------------------------------------------------------
CREATE TABLE Roles (
    Role_ID NUMBER(10) PRIMARY KEY,
    Role_Name VARCHAR2(50) NOT NULL UNIQUE,
    Description VARCHAR2(200)
);

-- ----------------------------------------------------------------------------
-- 3. Employees Table (Supertype)
-- ----------------------------------------------------------------------------
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
    CONSTRAINT chk_employee_status CHECK (Status IN ('Active', 'Inactive'))
);

-- ----------------------------------------------------------------------------
-- 4. Doctors Table (Subtype of Employees)
-- ----------------------------------------------------------------------------
CREATE TABLE Doctors (
    Employee_ID NUMBER(10) PRIMARY KEY,
    Specialization VARCHAR2(100) NOT NULL,
    License_Number VARCHAR2(50) NOT NULL UNIQUE,
    CONSTRAINT fk_doctors_employee FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

-- ----------------------------------------------------------------------------
-- 5. General_Employees Table (Subtype of Employees)
-- ----------------------------------------------------------------------------
CREATE TABLE General_Employees (
    Employee_ID NUMBER(10) PRIMARY KEY,
    Role_ID NUMBER(10) NOT NULL,
    CONSTRAINT fk_general_employees_employee FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID),
    CONSTRAINT fk_general_employees_role FOREIGN KEY (Role_ID)
        REFERENCES Roles(Role_ID)
);

-- ----------------------------------------------------------------------------
-- 6. Medicines Table (Reference Catalog)
-- ----------------------------------------------------------------------------
CREATE TABLE Medicines (
    Medicine_ID NUMBER(10) PRIMARY KEY,
    Medicine_Name VARCHAR2(100) NOT NULL,
    Dosage_Form VARCHAR2(50) NOT NULL,
    Strength VARCHAR2(50) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_medicine_status CHECK (Status IN ('Active', 'Inactive'))
);

-- ----------------------------------------------------------------------------
-- 7. Services Table (Reference Catalog)
-- ----------------------------------------------------------------------------
CREATE TABLE Services (
    Service_ID NUMBER(10) PRIMARY KEY,
    Service_Name VARCHAR2(100) NOT NULL UNIQUE,
    Description VARCHAR2(200),
    Price NUMBER(10,2) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_service_price CHECK (Price >= 0),
    CONSTRAINT chk_service_status CHECK (Status IN ('Active', 'Inactive'))
);

-- ----------------------------------------------------------------------------
-- 8. Appointments Table
-- ----------------------------------------------------------------------------
CREATE TABLE Appointments (
    Appointment_ID NUMBER(10) PRIMARY KEY,
    Patient_ID NUMBER(10) NOT NULL,
    Doctor_ID NUMBER(10) NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Type VARCHAR2(20) NOT NULL,
    Status VARCHAR2(20) NOT NULL,
    Reason_for_Visit VARCHAR2(500) NOT NULL,
    CONSTRAINT fk_appointments_patient FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID),
    CONSTRAINT fk_appointments_doctor FOREIGN KEY (Doctor_ID)
        REFERENCES Doctors(Employee_ID),
    CONSTRAINT chk_appointment_type CHECK (Appointment_Type IN ('Scheduled', 'Walk-in')),
    CONSTRAINT chk_appointment_status CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'))
);

-- ----------------------------------------------------------------------------
-- 9. Medical_Records Table
-- ----------------------------------------------------------------------------
CREATE TABLE Medical_Records (
    Record_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL UNIQUE,
    Diagnosis VARCHAR2(500) NOT NULL,
    Clinical_Notes VARCHAR2(1000),
    Record_Date DATE NOT NULL,
    CONSTRAINT fk_medical_records_appointment FOREIGN KEY (Appointment_ID)
        REFERENCES Appointments(Appointment_ID)
);

-- ----------------------------------------------------------------------------
-- 10. Prescriptions Table
-- ----------------------------------------------------------------------------
CREATE TABLE Prescriptions (
    Prescription_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL,
    Prescription_Date DATE NOT NULL,
    General_Instructions VARCHAR2(1000),
    CONSTRAINT fk_prescriptions_appointment FOREIGN KEY (Appointment_ID)
        REFERENCES Appointments(Appointment_ID)
);

-- ----------------------------------------------------------------------------
-- 11. Prescription_Medicines Table (Associative - M:N)
-- ----------------------------------------------------------------------------
CREATE TABLE Prescription_Medicines (
    Prescription_No NUMBER(10) NOT NULL,
    Medicine_ID NUMBER(10) NOT NULL,
    Dosage VARCHAR2(50) NOT NULL,
    Frequency VARCHAR2(50) NOT NULL,
    Duration_Days NUMBER(5) NOT NULL,
    CONSTRAINT pk_prescription_medicines PRIMARY KEY (Prescription_No, Medicine_ID),
    CONSTRAINT fk_prescription_medicines_prescription FOREIGN KEY (Prescription_No)
        REFERENCES Prescriptions(Prescription_No),
    CONSTRAINT fk_prescription_medicines_medicine FOREIGN KEY (Medicine_ID)
        REFERENCES Medicines(Medicine_ID),
    CONSTRAINT chk_duration_days CHECK (Duration_Days > 0)
);

-- ----------------------------------------------------------------------------
-- 12. Invoices Table
-- ----------------------------------------------------------------------------
CREATE TABLE Invoices (
    Invoice_No NUMBER(10) PRIMARY KEY,
    Appointment_ID NUMBER(10) NOT NULL UNIQUE,
    Issue_Date DATE NOT NULL,
    CONSTRAINT fk_invoices_appointment FOREIGN KEY (Appointment_ID)
        REFERENCES Appointments(Appointment_ID)
);

-- ----------------------------------------------------------------------------
-- 13. Invoice_Services Table (Associative - M:N)
-- ----------------------------------------------------------------------------
CREATE TABLE Invoice_Services (
    Invoice_No NUMBER(10) NOT NULL,
    Service_ID NUMBER(10) NOT NULL,
    Quantity NUMBER(5) NOT NULL,
    Unit_Price NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_invoice_services PRIMARY KEY (Invoice_No, Service_ID),
    CONSTRAINT fk_invoice_services_invoice FOREIGN KEY (Invoice_No)
        REFERENCES Invoices(Invoice_No),
    CONSTRAINT fk_invoice_services_service FOREIGN KEY (Service_ID)
        REFERENCES Services(Service_ID),
    CONSTRAINT chk_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_unit_price CHECK (Unit_Price >= 0)
);

-- ----------------------------------------------------------------------------
-- 14. Payments Table
-- ----------------------------------------------------------------------------
CREATE TABLE Payments (
    Payment_No NUMBER(10) PRIMARY KEY,
    Invoice_No NUMBER(10) NOT NULL,
    Created_By_Employee_ID NUMBER(10) NOT NULL,
    Amount_Paid NUMBER(10,2) NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Method VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_payments_invoice FOREIGN KEY (Invoice_No)
        REFERENCES Invoices(Invoice_No),
    CONSTRAINT fk_payments_employee FOREIGN KEY (Created_By_Employee_ID)
        REFERENCES General_Employees(Employee_ID),
    CONSTRAINT chk_amount_paid CHECK (Amount_Paid > 0),
    CONSTRAINT chk_payment_method CHECK (Payment_Method IN ('Cash', 'Card', 'Bank Transfer', 'Insurance'))
);

-- ============================================================================
-- TRIGGERS FOR BUSINESS RULES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Employee specialization rule
-- ----------------------------------------------------------------------------
-- The Employees table is a supertype and Doctors/General_Employees are its
-- subtypes. Enforcing total + disjoint specialization with a row-level trigger
-- on Employees is not valid because the child rows do not exist yet and querying
-- child tables from such a trigger can cause inconsistent enforcement.
-- Use sp_Add_Employee (below) for employee creation so the subtype is assigned
-- in the same transaction.

-- ----------------------------------------------------------------------------
-- Triggers: Enforce disjoint employee subtypes
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_doctor_disjoint_subtype
BEFORE INSERT OR UPDATE ON Doctors
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM General_Employees
    WHERE Employee_ID = :NEW.Employee_ID;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20015,
            'An employee cannot belong to both Doctors and General_Employees');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_general_employee_disjoint_subtype
BEFORE INSERT OR UPDATE ON General_Employees
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Doctors
    WHERE Employee_ID = :NEW.Employee_ID;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20016,
            'An employee cannot belong to both Doctors and General_Employees');
    END IF;
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 1: Validate patient date of birth
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_patient_dob
BEFORE INSERT OR UPDATE OF Date_of_Birth ON Patients
FOR EACH ROW
BEGIN
    IF :NEW.Date_of_Birth > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20000,
            'Date_of_Birth cannot be in the future');
    END IF;
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 2: Validate employee hire date
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_employee_hire_date
BEFORE INSERT OR UPDATE OF Hire_Date ON Employees
FOR EACH ROW
BEGIN
    IF :NEW.Hire_Date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20014,
            'Hire_Date cannot be in the future');
    END IF;
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 3: Prevent Medical Record for Cancelled/No-show Appointments
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_medical_record_appointment_status
BEFORE INSERT OR UPDATE ON Medical_Records
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF v_appointment_status IN ('Cancelled', 'No-show') THEN
        RAISE_APPLICATION_ERROR(-20003,
            'Cannot create medical record for cancelled or no-show appointments');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 4: Ensure Record_Date >= Appointment_Date
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_medical_record_date
BEFORE INSERT OR UPDATE ON Medical_Records
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF :NEW.Record_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20004,
            'Record_Date must be greater than or equal to Appointment_Date');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 5: Prevent Prescription for Cancelled/No-show Appointments
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_prescription_appointment_status
BEFORE INSERT OR UPDATE ON Prescriptions
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF v_appointment_status IN ('Cancelled', 'No-show') THEN
        RAISE_APPLICATION_ERROR(-20005,
            'Cannot create prescription for cancelled or no-show appointments');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 6: Ensure Prescription_Date >= Appointment_Date
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_prescription_date
BEFORE INSERT OR UPDATE ON Prescriptions
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF :NEW.Prescription_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20006,
            'Prescription_Date must be greater than or equal to Appointment_Date');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 7: Ensure Prescription has at least one medicine
-- (This is checked before allowing prescription to be finalized)
-- Note: This is a validation trigger that should be checked at application level
-- or through a stored procedure. For now, we'll create a check constraint
-- that ensures a prescription has at least one medicine before it's considered valid.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Trigger 8: Ensure Prescription has at least one medicine
-- This trigger prevents a prescription from being created or updated without
-- at least one associated medicine in Prescription_Medicines
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_prescription_medicine_count
BEFORE INSERT OR UPDATE ON Prescriptions
FOR EACH ROW
DECLARE
    v_medicine_count NUMBER;
BEGIN
    -- For UPDATE, check if medicines exist (can't check for INSERT as medicines not added yet)
    IF UPDATING THEN
        SELECT COUNT(*)
        INTO v_medicine_count
        FROM Prescription_Medicines
        WHERE Prescription_No = :NEW.Prescription_No;

        IF v_medicine_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20017,
                'A prescription must have at least one associated medicine');
        END IF;
    END IF;
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 9: Prevent Invoice for Cancelled Appointments
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_invoice_appointment_status
BEFORE INSERT OR UPDATE ON Invoices
FOR EACH ROW
DECLARE
    v_appointment_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_appointment_status
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF v_appointment_status = 'Cancelled' THEN
        RAISE_APPLICATION_ERROR(-20007,
            'Cannot create invoice for cancelled appointments');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 10: Ensure Issue_Date >= Appointment_Date
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_invoice_date
BEFORE INSERT OR UPDATE ON Invoices
FOR EACH ROW
DECLARE
    v_appointment_date DATE;
BEGIN
    SELECT Appointment_Date INTO v_appointment_date
    FROM Appointments
    WHERE Appointment_ID = :NEW.Appointment_ID;

    IF :NEW.Issue_Date < v_appointment_date THEN
        RAISE_APPLICATION_ERROR(-20008,
            'Issue_Date must be greater than or equal to Appointment_Date');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20018,
            'Referenced appointment does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 11: Prevent adding inactive medicines to prescriptions
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_prescription_medicine_status
BEFORE INSERT OR UPDATE ON Prescription_Medicines
FOR EACH ROW
DECLARE
    v_medicine_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_medicine_status
    FROM Medicines
    WHERE Medicine_ID = :NEW.Medicine_ID;

    IF v_medicine_status = 'Inactive' THEN
        RAISE_APPLICATION_ERROR(-20009,
            'Cannot add inactive medicines to prescriptions');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20019,
            'Referenced medicine does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 12: Prevent adding inactive services to invoices
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_invoice_service_status
BEFORE INSERT OR UPDATE ON Invoice_Services
FOR EACH ROW
DECLARE
    v_service_status VARCHAR2(20);
BEGIN
    SELECT Status INTO v_service_status
    FROM Services
    WHERE Service_ID = :NEW.Service_ID;

    IF v_service_status = 'Inactive' THEN
        RAISE_APPLICATION_ERROR(-20010,
            'Cannot add inactive services to invoices');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20020,
            'Referenced service does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 13: Ensure Payment_Date >= Invoice Issue_Date
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_payment_date
BEFORE INSERT OR UPDATE ON Payments
FOR EACH ROW
DECLARE
    v_invoice_date DATE;
BEGIN
    SELECT Issue_Date INTO v_invoice_date
    FROM Invoices
    WHERE Invoice_No = :NEW.Invoice_No;

    IF :NEW.Payment_Date < v_invoice_date THEN
        RAISE_APPLICATION_ERROR(-20011,
            'Payment_Date must be greater than or equal to Invoice Issue_Date');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20021,
            'Referenced invoice does not exist');
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 14: Prevent overpayment (cumulative payments cannot exceed invoice total)
-- A compound trigger is used because querying Payments from a row-level trigger
-- on Payments causes ORA-04091 (mutating table).
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_payment_overpayment
FOR INSERT OR UPDATE ON Payments
COMPOUND TRIGGER
    TYPE t_payment_record IS RECORD (
        Invoice_No Payments.Invoice_No%TYPE,
        Amount_Paid Payments.Amount_Paid%TYPE
    );
    TYPE t_payment_array IS TABLE OF t_payment_record INDEX BY PLS_INTEGER;
    g_payments t_payment_array;
    g_count PLS_INTEGER := 0;

    BEFORE STATEMENT IS
    BEGIN
        g_count := 0;
    END BEFORE STATEMENT;

    AFTER EACH ROW IS
    BEGIN
        g_count := g_count + 1;
        g_payments(g_count).Invoice_No := :NEW.Invoice_No;
        g_payments(g_count).Amount_Paid := :NEW.Amount_Paid;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
        v_invoice_total NUMBER(10,2);
        v_current_payments NUMBER(10,2);
        v_invoice_no Payments.Invoice_No%TYPE;
    BEGIN
        FOR i IN 1 .. g_count LOOP
            v_invoice_no := g_payments(i).Invoice_No;

            -- Calculate invoice total from Invoice_Services
            SELECT NVL(SUM(Quantity * Unit_Price), 0)
            INTO v_invoice_total
            FROM Invoice_Services
            WHERE Invoice_No = v_invoice_no;

            -- Calculate total payments including the new one
            SELECT NVL(SUM(Amount_Paid), 0)
            INTO v_current_payments
            FROM Payments
            WHERE Invoice_No = v_invoice_no;

            -- Check if total payments exceed invoice total
            IF v_current_payments > v_invoice_total AND v_invoice_total > 0 THEN
                RAISE_APPLICATION_ERROR(-20012,
                    'Total payments cannot exceed invoice total. Invoice total: ' ||
                    v_invoice_total || ', Total payments: ' || v_current_payments);
            END IF;
        END LOOP;
    END AFTER STATEMENT;
END;
/

-- ----------------------------------------------------------------------------
-- Trigger 15: Ensure appointments are only assigned to active doctors
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_appointment_active_doctor
BEFORE INSERT OR UPDATE ON Appointments
FOR EACH ROW
DECLARE
    v_employee_status VARCHAR2(20);
BEGIN
    SELECT e.Status INTO v_employee_status
    FROM Employees e
    JOIN Doctors d ON e.Employee_ID = d.Employee_ID
    WHERE d.Employee_ID = :NEW.Doctor_ID;

    IF v_employee_status != 'Active' THEN
        RAISE_APPLICATION_ERROR(-20013,
            'Cannot assign appointment to inactive doctor');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20022,
            'Referenced doctor does not exist or is not a valid doctor');
END;
/

-- ============================================================================
-- VIEWS FOR DERIVED VALUES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- View: Invoice_Total - Calculate total amount for each invoice
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_Invoice_Total AS
SELECT
    i.Invoice_No,
    i.Appointment_ID,
    i.Issue_Date,
    SUM(inv_svc.Quantity * inv_svc.Unit_Price) AS Total_Amount,
    (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) AS Total_Paid,
    CASE
        WHEN SUM(inv_svc.Quantity * inv_svc.Unit_Price) = 0 THEN 'Paid'
        WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) IS NULL THEN 'Unpaid'
        WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) = 0 THEN 'Unpaid'
        WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) < SUM(inv_svc.Quantity * inv_svc.Unit_Price) THEN 'Partially Paid'
        WHEN (SELECT SUM(Amount_Paid) FROM Payments p WHERE p.Invoice_No = i.Invoice_No) >= SUM(inv_svc.Quantity * inv_svc.Unit_Price) THEN 'Paid'
    END AS Payment_Status
FROM Invoices i
LEFT JOIN Invoice_Services inv_svc ON i.Invoice_No = inv_svc.Invoice_No
GROUP BY i.Invoice_No, i.Appointment_ID, i.Issue_Date;

-- ----------------------------------------------------------------------------
-- View: Prescription_Detail - Complete prescription information with medicines
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_Prescription_Detail AS
SELECT
    p.Prescription_No,
    p.Appointment_ID,
    p.Prescription_Date,
    p.General_Instructions,
    pat.Patient_ID,
    pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name,
    doc.Employee_ID AS Doctor_ID,
    emp_doc.First_Name || ' ' || emp_doc.Middle_Name || ' ' || emp_doc.Last_Name AS Doctor_Name,
    pm.Medicine_ID,
    m.Medicine_Name,
    m.Dosage_Form,
    m.Strength,
    pm.Dosage,
    pm.Frequency,
    pm.Duration_Days
FROM Prescriptions p
JOIN Appointments a ON p.Appointment_ID = a.Appointment_ID
JOIN Patients pat ON a.Patient_ID = pat.Patient_ID
JOIN Doctors doc ON a.Doctor_ID = doc.Employee_ID
JOIN Employees emp_doc ON doc.Employee_ID = emp_doc.Employee_ID
JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No
JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID;

-- ----------------------------------------------------------------------------
-- View: Doctor_Appointment_Summary - Summary of doctor appointments
-- ----------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_Doctor_Appointment_Summary AS
SELECT
    d.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
    COUNT(a.Appointment_ID) AS Total_Appointments,
    SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Appointments,
    SUM(CASE WHEN a.Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Appointments,
    SUM(CASE WHEN a.Status = 'No-show' THEN 1 ELSE 0 END) AS No_Show_Appointments,
    SUM(CASE WHEN a.Status = 'Scheduled' THEN 1 ELSE 0 END) AS Scheduled_Appointments
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
LEFT JOIN Appointments a ON d.Employee_ID = a.Doctor_ID
GROUP BY d.Employee_ID, e.First_Name, e.Middle_Name, e.Last_Name, d.Specialization;

-- ============================================================================
-- STORED PROCEDURES FOR COMPLEX OPERATIONS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Procedure: Add Employee with Subtype
-- Adds an employee and assigns them to the appropriate subtype
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Add_Employee(
    p_First_Name IN VARCHAR2,
    p_Middle_Name IN VARCHAR2,
    p_Last_Name IN VARCHAR2,
    p_Phone IN VARCHAR2,
    p_City IN VARCHAR2,
    p_Street IN VARCHAR2,
    p_Neighborhood IN VARCHAR2,
    p_Salary IN NUMBER,
    p_Hire_Date IN DATE,
    p_Status IN VARCHAR2,
    p_Is_Doctor IN NUMBER,
    p_Specialization IN VARCHAR2,
    p_License_Number IN VARCHAR2,
    p_Role_ID IN NUMBER,
    p_Employee_ID OUT NUMBER
) AS
BEGIN
    -- Insert into Employees table
    INSERT INTO Employees (
        Employee_ID, First_Name, Middle_Name, Last_Name, Phone, City,
        Street, Neighborhood, Salary, Hire_Date, Status
    ) VALUES (
        seq_employee_id.NEXTVAL, p_First_Name, p_Middle_Name, p_Last_Name,
        p_Phone, p_City, p_Street, p_Neighborhood, p_Salary, p_Hire_Date, p_Status
    ) RETURNING Employee_ID INTO p_Employee_ID;

    -- Assign to appropriate subtype
    IF p_Is_Doctor = 1 THEN
        INSERT INTO Doctors (Employee_ID, Specialization, License_Number)
        VALUES (p_Employee_ID, p_Specialization, p_License_Number);
    ELSE
        INSERT INTO General_Employees (Employee_ID, Role_ID)
        VALUES (p_Employee_ID, p_Role_ID);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Index on Patients.Status for filtering active patients
CREATE INDEX idx_patients_status ON Patients(Status);

-- Index on Employees.Status for filtering active employees
CREATE INDEX idx_employees_status ON Employees(Status);

-- Index on Appointments.Date for date-based queries
CREATE INDEX idx_appointments_date ON Appointments(Appointment_Date);

-- Index on Appointments.Status for status-based queries
CREATE INDEX idx_appointments_status ON Appointments(Status);

-- Index on Appointments.Patient_ID for patient appointment queries
CREATE INDEX idx_appointments_patient ON Appointments(Patient_ID);

-- Index on Appointments.Doctor_ID for doctor appointment queries
CREATE INDEX idx_appointments_doctor ON Appointments(Doctor_ID);

-- Index on Medical_Records.Appointment_ID for quick lookups
CREATE INDEX idx_medical_records_appointment ON Medical_Records(Appointment_ID);

-- Index on Prescriptions.Appointment_ID for appointment prescriptions
CREATE INDEX idx_prescriptions_appointment ON Prescriptions(Appointment_ID);

-- Index on Invoices.Appointment_ID for appointment invoices
CREATE INDEX idx_invoices_appointment ON Invoices(Appointment_ID);

-- Index on Payments.Invoice_No for invoice payment queries
CREATE INDEX idx_payments_invoice ON Payments(Invoice_No);

-- Index on Medicines.Status for filtering active medicines
CREATE INDEX idx_medicines_status ON Medicines(Status);

-- Index on Services.Status for filtering active services
CREATE INDEX idx_services_status ON Services(Status);

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE Patients IS 'Stores patient demographic and contact information';
COMMENT ON TABLE Roles IS 'Reference table for employee roles';
COMMENT ON TABLE Employees IS 'Supertype table containing common employee data';
COMMENT ON TABLE Doctors IS 'Subtype table for doctor-specific information';
COMMENT ON TABLE General_Employees IS 'Subtype table for non-doctor employees';
COMMENT ON TABLE Appointments IS 'Business event table for patient-doctor appointments';
COMMENT ON TABLE Medical_Records IS 'Clinical records resulting from appointments';
COMMENT ON TABLE Prescriptions IS 'Prescriptions issued during appointments';
COMMENT ON TABLE Medicines IS 'Reference catalog for medicines (no inventory)';
COMMENT ON TABLE Prescription_Medicines IS 'Associative table for prescription-medicine M:N relationship';
COMMENT ON TABLE Services IS 'Reference catalog for clinic services';
COMMENT ON TABLE Invoices IS 'Financial invoices linked to appointments';
COMMENT ON TABLE Invoice_Services IS 'Associative table for invoice-service M:N relationship';
COMMENT ON TABLE Payments IS 'Payment transactions against invoices';

-- ============================================================================
-- END OF DDL SCRIPT
-- ============================================================================
