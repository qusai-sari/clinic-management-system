-- ============================================================================
-- Clinic Management System - UPDATE and DELETE Examples
-- Database: Oracle
-- ============================================================================
-- This file contains practical examples of UPDATE and DELETE operations
-- for the Clinic Management System. These examples demonstrate how to
-- modify and remove data while maintaining data integrity.
-- ============================================================================

-- ============================================================================
-- IMPORTANT NOTES BEFORE EXECUTING:
-- 1. Always back up your data before performing UPDATE or DELETE operations
-- 2. Use WHERE clauses carefully to avoid affecting unintended rows
-- 3. Test with SELECT first to verify the rows that will be affected
-- 4. Consider using transactions for complex operations
-- 5. Be aware of foreign key constraints and triggers
-- ============================================================================

-- ============================================================================
-- UPDATE EXAMPLES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 1: Update patient contact information
-- Update phone number and address for a specific patient
-- ----------------------------------------------------------------------------
-- First, verify the current data:
SELECT Patient_ID, First_Name, Last_Name, Phone, City, Street, Neighborhood
FROM Patients
WHERE Patient_ID = 1;

-- Then perform the update:
UPDATE Patients
SET Phone = '966509876543',
    City = 'Riyadh',
    Street = 'New Olaya Street',
    Neighborhood = 'Al-Olaya'
WHERE Patient_ID = 1;

-- Verify the update:
SELECT Patient_ID, First_Name, Last_Name, Phone, City, Street, Neighborhood
FROM Patients
WHERE Patient_ID = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 2: Change patient status (e.g., mark as inactive)
-- Change a patient's status from Active to Inactive
-- ----------------------------------------------------------------------------
-- First, verify the current status:
SELECT Patient_ID, First_Name, Last_Name, Status
FROM Patients
WHERE Patient_ID = 2;

-- Perform the update:
UPDATE Patients
SET Status = 'Inactive'
WHERE Patient_ID = 2;

-- Verify the update:
SELECT Patient_ID, First_Name, Last_Name, Status
FROM Patients
WHERE Patient_ID = 2;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 3: Update employee salary
-- Increase salary for a specific employee
-- ----------------------------------------------------------------------------
-- First, verify current salary:
SELECT e.Employee_ID, e.First_Name, e.Last_Name, e.Salary, e.Hire_Date
FROM Employees e
WHERE Employee_ID = 13;

-- Perform the update (10% salary increase):
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Employee_ID = 13;

-- Verify the update:
SELECT e.Employee_ID, e.First_Name, e.Last_Name, e.Salary, e.Hire_Date
FROM Employees e
WHERE Employee_ID = 13;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 4: Update doctor specialization
-- Change a doctor's specialization
-- ----------------------------------------------------------------------------
-- First, verify current specialization:
SELECT d.Employee_ID, e.First_Name, e.Last_Name, d.Specialization, d.License_Number
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE d.Employee_ID = 1;

-- Perform the update:
UPDATE Doctors
SET Specialization = 'Interventional Cardiology'
WHERE Employee_ID = 1;

-- Verify the update:
SELECT d.Employee_ID, e.First_Name, e.Last_Name, d.Specialization, d.License_Number
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE d.Employee_ID = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 5: Update employee status (e.g., mark as inactive)
-- Change an employee's status from Active to Inactive
-- ----------------------------------------------------------------------------
-- First, verify current status:
SELECT Employee_ID, First_Name, Last_Name, Status
FROM Employees
WHERE Employee_ID = 14;

-- Perform the update:
UPDATE Employees
SET Status = 'Inactive'
WHERE Employee_ID = 14;

-- Verify the update:
SELECT Employee_ID, First_Name, Last_Name, Status
FROM Employees
WHERE Employee_ID = 14;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 6: Update medicine status
-- Mark a medicine as inactive (discontinued)
-- ----------------------------------------------------------------------------
-- First, verify current status:
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status
FROM Medicines
WHERE Medicine_ID = 15;

-- Perform the update:
UPDATE Medicines
SET Status = 'Inactive'
WHERE Medicine_ID = 15;

-- Verify the update:
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status
FROM Medicines
WHERE Medicine_ID = 15;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 7: Update service price
-- Change the price of a service
-- ----------------------------------------------------------------------------
-- First, verify current price:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Service_ID = 1;

-- Perform the update (increase price by 10%):
UPDATE Services
SET Price = ROUND(Price * 1.10, 2)
WHERE Service_ID = 1;

-- Verify the update:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Service_ID = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 8: Update service status
-- Mark a service as inactive (discontinued)
-- ----------------------------------------------------------------------------
-- First, verify current status:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Service_ID = 15;

-- Perform the update:
UPDATE Services
SET Status = 'Inactive'
WHERE Service_ID = 15;

-- Verify the update:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Service_ID = 15;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 9: Update appointment status
-- Change an appointment's status (e.g., from Scheduled to Completed)
-- ----------------------------------------------------------------------------
-- First, verify current status:
SELECT Appointment_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit
FROM Appointments
WHERE Appointment_ID = 15;

-- Perform the update:
UPDATE Appointments
SET Status = 'Completed'
WHERE Appointment_ID = 15;

-- Verify the update:
SELECT Appointment_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit
FROM Appointments
WHERE Appointment_ID = 15;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 10: Update medical record notes
-- Add or update clinical notes in a medical record
-- ----------------------------------------------------------------------------
-- First, verify current notes:
SELECT Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date
FROM Medical_Records
WHERE Record_No = 1;

-- Perform the update:
UPDATE Medical_Records
SET Clinical_Notes = 'Patient presents with chest pain and shortness of breath. ECG shows mild abnormalities. Recommended stress test. Patient responds well to initial treatment.'
WHERE Record_No = 1;

-- Verify the update:
SELECT Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date
FROM Medical_Records
WHERE Record_No = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 11: Update prescription instructions
-- Add or update general instructions for a prescription
-- ----------------------------------------------------------------------------
-- First, verify current instructions:
SELECT Prescription_No, Appointment_ID, Prescription_Date, General_Instructions
FROM Prescriptions
WHERE Prescription_No = 1;

-- Perform the update:
UPDATE Prescriptions
SET General_Instructions = 'Take with food. Avoid alcohol. Monitor blood pressure. Report any chest pain immediately. Keep medication in a cool, dry place.'
WHERE Prescription_No = 1;

-- Verify the update:
SELECT Prescription_No, Appointment_ID, Prescription_Date, General_Instructions
FROM Prescriptions
WHERE Prescription_No = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 12: Update role description
-- Update the description of a role
-- ----------------------------------------------------------------------------
-- First, verify current description:
SELECT Role_ID, Role_Name, Description
FROM Roles
WHERE Role_ID = 1;

-- Perform the update:
UPDATE Roles
SET Description = 'Handles patient check-in, appointment scheduling, and front desk operations'
WHERE Role_ID = 1;

-- Verify the update:
SELECT Role_ID, Role_Name, Description
FROM Roles
WHERE Role_ID = 1;

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 13: Batch update - Update multiple patient statuses
-- Mark all patients in a specific city as inactive
-- ----------------------------------------------------------------------------
-- First, verify which patients will be affected:
SELECT Patient_ID, First_Name, Last_Name, City, Status
FROM Patients
WHERE City = 'Jeddah' AND Status = 'Active';

-- Perform the batch update:
UPDATE Patients
SET Status = 'Inactive'
WHERE City = 'Jeddah' AND Status = 'Active';

-- Verify the update:
SELECT Patient_ID, First_Name, Last_Name, City, Status
FROM Patients
WHERE City = 'Jeddah';

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 14: Conditional update based on date
-- Update service prices for services that haven't been updated in a while
-- (This is a conceptual example - assumes you have a last_updated_date column)
-- ----------------------------------------------------------------------------
-- For this example, we'll increase prices for all services by 5%
-- First, verify current prices:
SELECT Service_ID, Service_Name, Price
FROM Services
WHERE Status = 'Active';

-- Perform the conditional update:
UPDATE Services
SET Price = ROUND(Price * 1.05, 2)
WHERE Status = 'Active' AND Price > 0;

-- Verify the update:
SELECT Service_ID, Service_Name, Price
FROM Services
WHERE Status = 'Active';

-- ----------------------------------------------------------------------------
-- UPDATE EXAMPLE 15: Update with subquery
-- Update employee salary based on their role
-- Give a 15% raise to all accountants
-- ----------------------------------------------------------------------------
-- First, verify current salaries:
SELECT e.Employee_ID, e.First_Name, e.Last_Name, r.Role_Name, e.Salary
FROM Employees e
JOIN General_Employees ge ON e.Employee_ID = ge.Employee_ID
JOIN Roles r ON ge.Role_ID = r.Role_ID
WHERE r.Role_Name = 'Accountant';

-- Perform the update with subquery:
UPDATE Employees
SET Salary = ROUND(Salary * 1.15, 2)
WHERE Employee_ID IN (
    SELECT ge.Employee_ID
    FROM General_Employees ge
    JOIN Roles r ON ge.Role_ID = r.Role_ID
    WHERE r.Role_Name = 'Accountant'
);

-- Verify the update:
SELECT e.Employee_ID, e.First_Name, e.Last_Name, r.Role_Name, e.Salary
FROM Employees e
JOIN General_Employees ge ON e.Employee_ID = ge.Employee_ID
JOIN Roles r ON ge.Role_ID = r.Role_ID
WHERE r.Role_Name = 'Accountant';

-- ============================================================================
-- DELETE EXAMPLES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 1: Delete a specific payment
-- Remove a payment record (use with caution - may affect invoice payment status)
-- ----------------------------------------------------------------------------
-- First, verify the payment to be deleted:
SELECT Payment_No, Invoice_No, Amount_Paid, Payment_Date, Payment_Method
FROM Payments
WHERE Payment_No = 1;

-- Check if this is the only payment for the invoice:
SELECT Invoice_No, COUNT(*) AS Payment_Count, SUM(Amount_Paid) AS Total_Paid
FROM Payments
WHERE Invoice_No = 1
GROUP BY Invoice_No;

-- Perform the delete:
DELETE FROM Payments
WHERE Payment_No = 1;

-- Verify the delete:
SELECT Payment_No, Invoice_No, Amount_Paid, Payment_Date, Payment_Method
FROM Payments
WHERE Payment_No = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 2: Delete invoice services line item
-- Remove a specific service from an invoice
-- ----------------------------------------------------------------------------
-- First, verify the line item to be deleted:
SELECT Invoice_No, Service_ID, Quantity, Unit_Price
FROM Invoice_Services
WHERE Invoice_No = 1 AND Service_ID = 1;

-- Perform the delete:
DELETE FROM Invoice_Services
WHERE Invoice_No = 1 AND Service_ID = 1;

-- Verify the delete:
SELECT Invoice_No, Service_ID, Quantity, Unit_Price
FROM Invoice_Services
WHERE Invoice_No = 1 AND Service_ID = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 3: Delete prescription medicine
-- Remove a specific medicine from a prescription
-- ----------------------------------------------------------------------------
-- First, verify the medicine to be removed:
SELECT Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days
FROM Prescription_Medicines
WHERE Prescription_No = 1 AND Medicine_ID = 1;

-- Perform the delete:
DELETE FROM Prescription_Medicines
WHERE Prescription_No = 1 AND Medicine_ID = 1;

-- Verify the delete:
SELECT Prescription_No, Medicine_ID, Dosage, Frequency, Duration_Days
FROM Prescription_Medicines
WHERE Prescription_No = 1 AND Medicine_ID = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 4: Delete a prescription (and its medicines via cascade)
-- Note: This requires CASCADE DELETE to be enabled on the foreign key
-- or manual deletion of related records first
-- ----------------------------------------------------------------------------
-- First, check if the prescription has medicines:
SELECT COUNT(*) AS Medicine_Count
FROM Prescription_Medicines
WHERE Prescription_No = 1;

-- Delete associated medicines first (if cascade is not enabled):
DELETE FROM Prescription_Medicines
WHERE Prescription_No = 1;

-- Then delete the prescription:
DELETE FROM Prescriptions
WHERE Prescription_No = 1;

-- Verify the delete:
SELECT Prescription_No, Appointment_ID, Prescription_Date
FROM Prescriptions
WHERE Prescription_No = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 5: Delete a medical record
-- Remove a medical record (use with caution - important clinical data)
-- ----------------------------------------------------------------------------
-- First, verify the medical record to be deleted:
SELECT Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date
FROM Medical_Records
WHERE Record_No = 1;

-- Perform the delete:
DELETE FROM Medical_Records
WHERE Record_No = 1;

-- Verify the delete:
SELECT Record_No, Appointment_ID, Diagnosis, Clinical_Notes, Record_Date
FROM Medical_Records
WHERE Record_No = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 6: Delete an invoice (and its services/payments)
-- Note: This requires careful handling of foreign key constraints
-- ----------------------------------------------------------------------------
-- First, check what will be affected:
SELECT i.Invoice_No, i.Appointment_ID,
       (SELECT COUNT(*) FROM Invoice_Services WHERE Invoice_No = i.Invoice_No) AS Service_Count,
       (SELECT COUNT(*) FROM Payments WHERE Invoice_No = i.Invoice_No) AS Payment_Count
FROM Invoices i
WHERE Invoice_No = 1;

-- Delete payments first:
DELETE FROM Payments
WHERE Invoice_No = 1;

-- Delete invoice services:
DELETE FROM Invoice_Services
WHERE Invoice_No = 1;

-- Delete the invoice:
DELETE FROM Invoices
WHERE Invoice_No = 1;

-- Verify the delete:
SELECT Invoice_No, Appointment_ID, Issue_Date
FROM Invoices
WHERE Invoice_No = 1;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 7: Delete an appointment (and related records)
-- Note: This is a complex operation due to multiple foreign key relationships
-- ----------------------------------------------------------------------------
-- First, check all related records:
SELECT a.Appointment_ID, a.Status,
       (SELECT COUNT(*) FROM Medical_Records WHERE Appointment_ID = a.Appointment_ID) AS Medical_Records_Count,
       (SELECT COUNT(*) FROM Prescriptions WHERE Appointment_ID = a.Appointment_ID) AS Prescriptions_Count,
       (SELECT COUNT(*) FROM Invoices WHERE Appointment_ID = a.Appointment_ID) AS Invoices_Count
FROM Appointments a
WHERE Appointment_ID = 15;

-- This is a complex delete that should be done in a transaction
-- For safety, we'll use a transaction block:

BEGIN
    -- Delete related records in correct order
    DELETE FROM Medical_Records WHERE Appointment_ID = 15;
    DELETE FROM Prescription_Medicines pm
    WHERE Prescription_No IN (SELECT Prescription_No FROM Prescriptions WHERE Appointment_ID = 15);
    DELETE FROM Prescriptions WHERE Appointment_ID = 15;
    DELETE FROM Payments WHERE Invoice_No IN (SELECT Invoice_No FROM Invoices WHERE Appointment_ID = 15);
    DELETE FROM Invoice_Services WHERE Invoice_No IN (SELECT Invoice_No FROM Invoices WHERE Appointment_ID = 15);
    DELETE FROM Invoices WHERE Appointment_ID = 15;
    DELETE FROM Appointments WHERE Appointment_ID = 15;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

-- Verify the delete:
SELECT Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Status
FROM Appointments
WHERE Appointment_ID = 15;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 8: Delete a general employee (and reassign or handle their records)
-- Note: This requires handling of payments they processed
-- ----------------------------------------------------------------------------
-- First, check if the employee has processed payments:
SELECT ge.Employee_ID, e.First_Name, e.Last_Name,
       (SELECT COUNT(*) FROM Payments WHERE Created_By_Employee_ID = ge.Employee_ID) AS Payments_Processed
FROM General_Employees ge
JOIN Employees e ON ge.Employee_ID = e.Employee_ID
WHERE ge.Employee_ID = 13;

-- For safety, we should first reassign or handle their payments
-- This example assumes we're deleting an employee with no processed payments
-- or we have a process to reassign payments

-- If no payments processed, delete the general employee record:
DELETE FROM General_Employees
WHERE Employee_ID = 24; -- Using employee with no payments as example

-- Then delete the employee record:
DELETE FROM Employees
WHERE Employee_ID = 24;

-- Verify the delete:
SELECT Employee_ID, First_Name, Last_Name, Status
FROM Employees
WHERE Employee_ID = 24;

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 9: Delete a doctor (requires handling of their appointments)
-- Note: This is complex due to appointment relationships
-- ----------------------------------------------------------------------------
-- First, check if the doctor has appointments:
SELECT d.Employee_ID, e.First_Name, e.Last_Name, d.Specialization,
       (SELECT COUNT(*) FROM Appointments WHERE Doctor_ID = d.Employee_ID) AS Appointments_Count
FROM Doctors d
JOIN Employees e ON d.Employee_ID = e.Employee_ID
WHERE d.Employee_ID = 1;

-- This should only be done for doctors with no appointments
-- or after careful data migration

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 10: Delete a patient (requires handling of their appointments)
-- Note: This is complex due to appointment relationships
-- ----------------------------------------------------------------------------
-- First, check if the patient has appointments:
SELECT p.Patient_ID, p.First_Name, p.Last_Name, p.Status,
       (SELECT COUNT(*) FROM Appointments WHERE Patient_ID = p.Patient_ID) AS Appointments_Count
FROM Patients p
WHERE p.Patient_ID = 15;

-- This should only be done for patients with no appointments
-- or after careful data migration

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 11: Batch delete - Delete inactive medicines
-- Remove all medicines marked as inactive
-- ----------------------------------------------------------------------------
-- First, verify which medicines will be deleted:
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status
FROM Medicines
WHERE Status = 'Inactive';

-- Perform the batch delete:
DELETE FROM Medicines
WHERE Status = 'Inactive';

-- Verify the delete:
SELECT Medicine_ID, Medicine_Name, Dosage_Form, Strength, Status
FROM Medicines
WHERE Status = 'Inactive';

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 12: Delete inactive services
-- Remove all services marked as inactive
-- ----------------------------------------------------------------------------
-- First, verify which services will be deleted:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Status = 'Inactive';

-- Perform the batch delete:
DELETE FROM Services
WHERE Status = 'Inactive';

-- Verify the delete:
SELECT Service_ID, Service_Name, Description, Price, Status
FROM Services
WHERE Status = 'Inactive';

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 13: Delete old cancelled appointments
-- Remove cancelled appointments older than a certain date
-- ----------------------------------------------------------------------------
-- First, verify which appointments will be deleted:
SELECT Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Status
FROM Appointments
WHERE Status = 'Cancelled'
AND Appointment_Date < ADD_MONTHS(SYSDATE, -6);

-- Perform the delete:
DELETE FROM Appointments
WHERE Status = 'Cancelled'
AND Appointment_Date < ADD_MONTHS(SYSDATE, -6);

-- Verify the delete:
SELECT COUNT(*) AS Remaining_Cancelled_Appointments
FROM Appointments
WHERE Status = 'Cancelled';

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 14: Delete with subquery
-- Delete payments for invoices that are fully paid and older than 1 year
-- This is an example of using a subquery in DELETE
-- ----------------------------------------------------------------------------
-- First, verify which payments will be deleted:
SELECT p.Payment_No, p.Invoice_No, p.Amount_Paid, p.Payment_Date
FROM Payments p
JOIN Invoices i ON p.Invoice_No = i.Invoice_No
WHERE i.Issue_Date < ADD_MONTHS(SYSDATE, -12)
AND p.Invoice_No IN (
    SELECT Invoice_No
    FROM vw_Invoice_Total
    WHERE Payment_Status = 'Paid'
);

-- Perform the delete with subquery:
DELETE FROM Payments
WHERE Invoice_No IN (
    SELECT Invoice_No
    FROM Invoices
    WHERE Issue_Date < ADD_MONTHS(SYSDATE, -12)
    AND Invoice_No IN (
        SELECT Invoice_No
        FROM vw_Invoice_Total
        WHERE Payment_Status = 'Paid'
    )
);

-- Verify the delete:
SELECT COUNT(*) AS Remaining_Old_Payments
FROM Payments p
JOIN Invoices i ON p.Invoice_No = i.Invoice_No
WHERE i.Issue_Date < ADD_MONTHS(SYSDATE, -12);

-- ----------------------------------------------------------------------------
-- DELETE EXAMPLE 15: Conditional delete based on multiple conditions
-- Delete no-show appointments that have no associated records
-- (no medical records, prescriptions, or invoices)
-- ----------------------------------------------------------------------------
-- First, verify which appointments will be deleted:
SELECT a.Appointment_ID, a.Patient_ID, a.Doctor_ID, a.Appointment_Date, a.Status
FROM Appointments a
WHERE a.Status = 'No-show'
AND NOT EXISTS (SELECT 1 FROM Medical_Records mr WHERE mr.Appointment_ID = a.Appointment_ID)
AND NOT EXISTS (SELECT 1 FROM Prescriptions p WHERE p.Appointment_ID = a.Appointment_ID)
AND NOT EXISTS (SELECT 1 FROM Invoices i WHERE i.Appointment_ID = a.Appointment_ID);

-- Perform the conditional delete:
DELETE FROM Appointments
WHERE Status = 'No-show'
AND NOT EXISTS (SELECT 1 FROM Medical_Records mr WHERE mr.Appointment_ID = Appointments.Appointment_ID)
AND NOT EXISTS (SELECT 1 FROM Prescriptions p WHERE p.Appointment_ID = Appointments.Appointment_ID)
AND NOT EXISTS (SELECT 1 FROM Invoices i WHERE i.Appointment_ID = Appointments.Appointment_ID);

-- Verify the delete:
SELECT COUNT(*) AS Remaining_No_Show_Appointments
FROM Appointments
WHERE Status = 'No-show';

-- ============================================================================
-- IMPORTANT: ROLLBACK OR COMMIT AS NEEDED
-- ============================================================================
-- After testing these examples, you can either:
-- ROLLBACK; -- to undo all changes
-- COMMIT;   -- to permanently apply all changes

-- For production use, always:
-- 1. Test in a development environment first
-- 2. Use proper transactions
-- 3. Have proper backups
-- 4. Get approval for destructive operations
-- 5. Document the changes

-- ============================================================================
-- END OF UPDATE AND DELETE EXAMPLES
-- ============================================================================
