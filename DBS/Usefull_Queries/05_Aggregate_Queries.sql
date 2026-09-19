-- ============================================================================
-- Clinic Management System - Aggregate Queries (2 GROUP BY Queries)
-- Database: Oracle
-- ============================================================================
-- This file contains 2 aggregate queries using GROUP BY that are separate
-- from the 15 basic DQL queries. These queries demonstrate aggregation
-- and grouping functionality.
-- ============================================================================

-- ============================================================================
-- AGGREGATE QUERY 1: Doctor Performance Summary
-- This query groups by doctor to show their appointment statistics including
-- total appointments, completed appointments, cancelled appointments, no-shows,
-- and average appointment completion rate.
-- ============================================================================
SELECT
    d.Employee_ID,
    e.First_Name || ' ' || e.Middle_Name || ' ' || e.Last_Name AS Doctor_Name,
    d.Specialization,
    COUNT(a.Appointment_ID) AS Total_Appointments,
    SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Appointments,
    SUM(CASE WHEN a.Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Appointments,
    SUM(CASE WHEN a.Status = 'No-show' THEN 1 ELSE 0 END) AS No_Show_Appointments,
    SUM(CASE WHEN a.Status = 'Scheduled' THEN 1 ELSE 0 END) AS Scheduled_Appointments,
    ROUND(
        (SUM(CASE WHEN a.Status = 'Completed' THEN 1 ELSE 0 END) * 100.0) /
        NULLIF(COUNT(a.Appointment_ID), 0), 2
    ) AS Completion_Rate_Percentage,
    ROUND(
        (SUM(CASE WHEN a.Status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) * 100.0) /
        NULLIF(COUNT(a.Appointment_ID), 0), 2
    ) AS Cancellation_NoShow_Rate_Percentage
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
LEFT JOIN Appointments a ON d.Employee_ID = a.Doctor_ID
GROUP BY d.Employee_ID, e.First_Name, e.Middle_Name, e.Last_Name, d.Specialization
ORDER BY Total_Appointments DESC, Doctor_Name;

-- ============================================================================
-- AGGREGATE QUERY 2: Revenue Analysis by Specialization and Payment Method
-- This query groups by doctor specialization and payment method to show
-- revenue analysis including total invoices, total revenue, average invoice
-- amount, and payment method distribution.
-- ============================================================================
SELECT
    d.Specialization,
    pay.Payment_Method,
    COUNT(DISTINCT i.Invoice_No) AS Total_Invoices,
    COUNT(pay.Payment_No) AS Total_Payments,
    SUM(pay.Amount_Paid) AS Total_Revenue,
    ROUND(AVG(pay.Amount_Paid), 2) AS Average_Payment_Amount,
    ROUND(
        (SUM(pay.Amount_Paid) * 100.0) /
        NULLIF((SELECT SUM(Amount_Paid) FROM Payments WHERE Payment_Date BETWEEN 
            (SELECT MIN(Payment_Date) FROM Payments) AND 
            (SELECT MAX(Payment_Date) FROM Payments)), 0), 2
    ) AS Revenue_Percentage,
    ROUND(
        (COUNT(pay.Payment_No) * 100.0) /
        NULLIF(COUNT(DISTINCT i.Invoice_No), 0), 2
    ) AS Payments_Per_Invoice
FROM Doctors d
JOIN Appointments a ON d.Employee_ID = a.Doctor_ID
JOIN Invoices i ON a.Appointment_ID = i.Appointment_ID
JOIN Payments pay ON i.Invoice_No = pay.Invoice_No
GROUP BY d.Specialization, pay.Payment_Method
ORDER BY d.Specialization, Total_Revenue DESC;

-- ============================================================================
-- BONUS AGGREGATE QUERY: Monthly Revenue Analysis
-- This additional query shows monthly revenue analysis by year and month.
-- ============================================================================
SELECT
    EXTRACT(YEAR FROM pay.Payment_Date) AS Year,
    EXTRACT(MONTH FROM pay.Payment_Date) AS Month,
    COUNT(DISTINCT i.Invoice_No) AS Total_Invoices,
    COUNT(pay.Payment_No) AS Total_Payments,
    SUM(pay.Amount_Paid) AS Total_Revenue,
    ROUND(AVG(pay.Amount_Paid), 2) AS Average_Payment_Amount,
    pay.Payment_Method
FROM Payments pay
JOIN Invoices i ON pay.Invoice_No = i.Invoice_No
GROUP BY
    EXTRACT(YEAR FROM pay.Payment_Date),
    EXTRACT(MONTH FROM pay.Payment_Date),
    pay.Payment_Method
ORDER BY Year DESC, Month DESC, Total_Revenue DESC;

-- ============================================================================
-- END OF AGGREGATE QUERIES
-- ============================================================================
