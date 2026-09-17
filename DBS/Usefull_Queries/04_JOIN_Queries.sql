-- ============================================================================
-- Clinic Management System - JOIN Queries (3 Advanced JOIN Queries)
-- Database: Oracle
-- ============================================================================
-- This file contains 3 advanced JOIN queries that are separate from the
-- 15 basic DQL queries. These queries demonstrate complex joins across
-- multiple tables.
-- ============================================================================

-- ============================================================================
-- JOIN QUERY 1: Complete Patient Appointment History with Doctor and Invoice Details
-- This query joins Patients, Appointments, Doctors, Employees, Invoices, and
-- Invoice_Services to show a complete view of a patient's appointment history
-- including doctor information and invoice details.
-- ============================================================================
SELECT
    p.Patient_ID,
    p.First_Name || ' ' || p.Middle_Name || ' ' || p.Last_Name AS Patient_Name,
    p.Phone,
    p.City,
    a.Appointment_ID,
    a.Appointment_Date,
    a.Appointment_Type,
    a.Status AS Appointment_Status,
    a.Reason_for_Visit,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
    i.Invoice_No,
    i.Issue_Date,
    s.Service_Name,
    is_inv.Quantity,
    is_inv.Unit_Price,
    (is_inv.Quantity * is_inv.Unit_Price) AS Line_Total
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Employees e ON d.Employee_ID = e.Employee_ID
LEFT JOIN Invoices i ON a.Appointment_ID = i.Appointment_ID
LEFT JOIN Invoice_Services is_inv ON i.Invoice_No = is_inv.Invoice_No
LEFT JOIN Services s ON is_inv.Service_ID = s.Service_ID
WHERE p.Patient_ID = 1
ORDER BY a.Appointment_Date DESC, i.Invoice_No, s.Service_Name;

-- ============================================================================
-- JOIN QUERY 2: Prescription Details with Patient, Doctor, and Medicine Information
-- This query joins Prescriptions, Prescription_Medicines, Medicines, Appointments,
-- Patients, Doctors, and Employees to show complete prescription information
-- including patient details, doctor information, and medicine details.
-- ============================================================================
SELECT
    p.Prescription_No,
    p.Prescription_Date,
    p.General_Instructions,
    pat.Patient_ID,
    pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name,
    pat.Phone,
    pat.City,
    a.Appointment_ID,
    a.Appointment_Date,
    a.Reason_for_Visit,
    doc.Employee_ID AS Doctor_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
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
JOIN Employees e ON doc.Employee_ID = e.Employee_ID
JOIN Doctors d ON a.Doctor_ID = d.Employee_ID
JOIN Prescription_Medicines pm ON p.Prescription_No = pm.Prescription_No
JOIN Medicines m ON pm.Medicine_ID = m.Medicine_ID
WHERE p.Prescription_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
ORDER BY p.Prescription_Date DESC, p.Prescription_No, m.Medicine_Name;

-- ============================================================================
-- JOIN QUERY 3: Payment History with Invoice, Patient, and Employee Details
-- This query joins Payments, Invoices, Appointments, Patients, General_Employees,
-- Employees, and Roles to show complete payment history including patient information,
-- invoice details, and the employee who processed the payment.
-- ============================================================================
SELECT
    pay.Payment_No,
    pay.Amount_Paid,
    pay.Payment_Date,
    pay.Payment_Method,
    inv.Invoice_No,
    inv.Issue_Date,
    app.Appointment_ID,
    app.Appointment_Date,
    pat.Patient_ID,
    pat.First_Name || ' ' || pat.Middle_Name || ' ' || pat.Last_Name AS Patient_Name,
    pat.Phone,
    pat.City,
    ge.Employee_ID AS Processing_Employee_ID,
    emp.First_Name || ' ' || emp.Middle_Name || ' ' || emp.Last_Name AS Processing_Employee_Name,
    r.Role_Name AS Employee_Role,
    (SELECT SUM(Quantity * Unit_Price) FROM Invoice_Services WHERE Invoice_No = inv.Invoice_No) AS Invoice_Total,
    (SELECT SUM(Amount_Paid) FROM Payments WHERE Invoice_No = inv.Invoice_No) AS Total_Paid
FROM Payments pay
JOIN Invoices inv ON pay.Invoice_No = inv.Invoice_No
JOIN Appointments app ON inv.Appointment_ID = app.Appointment_ID
JOIN Patients pat ON app.Patient_ID = pat.Patient_ID
JOIN General_Employees ge ON pay.Created_By_Employee_ID = ge.Employee_ID
JOIN Employees emp ON ge.Employee_ID = emp.Employee_ID
JOIN Roles r ON ge.Role_ID = r.Role_ID
WHERE pay.Payment_Date BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-03-31', 'YYYY-MM-DD')
ORDER BY pay.Payment_Date DESC, pay.Payment_No;

-- ============================================================================
-- END OF 3 JOIN QUERIES
-- ============================================================================
