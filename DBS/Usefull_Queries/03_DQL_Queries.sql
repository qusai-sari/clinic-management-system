-- ============================================================================
-- Clinic Management System - DQL Queries (15 Useful Queries)
-- Database: Oracle
-- ============================================================================
-- This file contains 15 useful data query language (DQL) queries for the
-- Clinic Management System. These queries are separate from the JOIN and
-- aggregate queries that follow.
-- ============================================================================

-- ============================================================================
-- QUERY 1: List all active patients with their contact information
-- ============================================================================
SELECT
    Patient_ID,
    First_Name || ' ' || Middle_Name || ' ' || Last_Name AS Full_Name,
    Date_of_Birth,
    Gender,
    Phone,
    City,
    Street,
    Neighborhood,
    Status
FROM Patients
WHERE Status = 'Active'
ORDER BY Last_Name, First_Name;

-- ============================================================================
-- QUERY 2: Find patients by city
-- ============================================================================
SELECT
    Patient_ID,
    First_Name || ' ' || Middle_Name || ' ' || Last_Name AS Full_Name,
    Phone,
    City,
    Street,
    Neighborhood
FROM Patients
WHERE City = 'Riyadh'
ORDER BY Neighborhood, Last_Name;

-- ============================================================================
-- QUERY 3: List all doctors with their specializations and license numbers
-- ============================================================================
SELECT
    d.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
    d.License_Number,
    e.Phone,
    e.City,
    e.Status
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
ORDER BY d.Specialization, e.Last_Name;

-- ============================================================================
-- QUERY 4: Find all active doctors by specialization
-- ============================================================================
SELECT
    d.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
    d.License_Number,
    e.City
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE e.Status = 'Active' AND d.Specialization = 'Cardiology'
ORDER BY e.Last_Name;

-- ============================================================================
-- QUERY 5: List all general employees with their roles
-- ============================================================================
SELECT
    ge.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Employee_Name,
    r.Role_Name,
    r.Description,
    e.Phone,
    e.City,
    e.Status
FROM General_Employees ge
JOIN Employees e ON ge.Employee_ID = e.Employee_ID
JOIN Roles r ON ge.Role_ID = r.Role_ID
ORDER BY r.Role_Name, e.Last_Name;

-- ============================================================================
-- QUERY 6: Find employees by role
-- ============================================================================
SELECT
    ge.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Employee_Name,
    r.Role_Name,
    e.Phone,
    e.City,
    e.Salary,
    e.Hire_Date
FROM General_Employees ge
JOIN Employees e ON ge.Employee_ID = e.Employee_ID
JOIN Roles r ON ge.Role_ID = r.Role_ID
WHERE r.Role_Name = 'Nurse'
ORDER BY e.Hire_Date DESC;

-- ============================================================================
-- QUERY 7: List all active medicines
-- ============================================================================
SELECT
    Medicine_ID,
    Medicine_Name,
    Dosage_Form,
    Strength,
    Status
FROM Medicines
WHERE Status = 'Active'
ORDER BY Medicine_Name;

-- ============================================================================
-- QUERY 8: Find medicines by dosage form
-- ============================================================================
SELECT
    Medicine_ID,
    Medicine_Name,
    Dosage_Form,
    Strength,
    Status
FROM Medicines
WHERE Dosage_Form = 'Tablet' AND Status = 'Active'
ORDER BY Medicine_Name;

-- ============================================================================
-- QUERY 9: List all active services with their prices
-- ============================================================================
SELECT
    Service_ID,
    Service_Name,
    Description,
    Price,
    Status
FROM Services
WHERE Status = 'Active'
ORDER BY Price DESC, Service_Name;

-- ============================================================================
-- QUERY 10: Find services within a price range
-- ============================================================================
SELECT
    Service_ID,
    Service_Name,
    Description,
    Price,
    Status
FROM Services
WHERE Price BETWEEN 100 AND 300 AND Status = 'Active'
ORDER BY Price;

-- ============================================================================
-- QUERY 11: List all appointments for a specific patient
-- ============================================================================
SELECT
    a.Appointment_ID,
    a.Appointment_Date,
    a.Appointment_Type,
    a.Status,
    a.Reason_for_Visit,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization
FROM Appointments a
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE a.Patient_ID = 1
ORDER BY a.Appointment_Date DESC;

-- ============================================================================
-- QUERY 12: Find appointments by date range
-- ============================================================================
SELECT
    a.Appointment_ID,
    p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Type,
    a.Status,
    a.Reason_for_Visit
FROM Appointments a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE a.Appointment_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-01-31', 'YYYY-MM-DD')
ORDER BY a.Appointment_Date;

-- ============================================================================
-- QUERY 13: List appointments by status
-- ============================================================================
SELECT
    a.Appointment_ID,
    p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name,
    p.Phone,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Type,
    a.Status,
    a.Reason_for_Visit
FROM Appointments a
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE a.Status = 'Completed'
ORDER BY a.Appointment_Date DESC;

-- ============================================================================
-- QUERY 14: Find medical records by diagnosis keyword
-- ============================================================================
SELECT
    mr.Record_No,
    a.Appointment_ID,
    a.Appointment_Date,
    p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    mr.Diagnosis,
    mr.Clinical_Notes,
    mr.Record_Date
FROM Medical_Records mr
JOIN Appointments a ON mr.Appointment_ID = a.Appointment_ID
JOIN Patients p ON a.Patient_ID = p.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE UPPER(mr.Diagnosis) LIKE '%FEVER%'
ORDER BY mr.Record_Date DESC;

-- ============================================================================
-- QUERY 15: List all prescriptions for a specific appointment
-- ============================================================================
SELECT
    p.Prescription_No,
    p.Prescription_Date,
    p.General_Instructions,
    pm.Medicine_ID,
    m.Medicine_Name,
    m.Dosage_Form,
    m.Strength,
    pm.Dosage,
    pm.Frequency,
    pm.Duration_Days
FROM Prescriptions p
JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No
JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID
WHERE p.Appointment_ID = 1
ORDER BY p.Prescription_Date, m.Medicine_Name;

-- ============================================================================
-- END OF 15 DQL QUERIES
-- ============================================================================
