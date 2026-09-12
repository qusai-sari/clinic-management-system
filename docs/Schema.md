# Clinic Management System – Schema

## Schema Notation Guide

- **Relation_Name**: Represents a relation (table).
- <u>Underlined_Attribute</u>: Represents the **Primary Key (PK)**.
- *Italicized_Attribute*: Represents a **Foreign Key (FK)**.
- <u>*Underlined_and_Italicized*</u>: Represents an attribute that is both a **Primary Key and Foreign Key (PK, FK)**.
- A composite primary key is represented by underlining each participating attribute.

> **Design Basis:**  
> This schema is derived from the Clinic Management System analysis and ERD. The design follows standard relational database principles, including entity integrity, referential integrity, normalization, supertype/subtype specialization, and associative relations for many-to-many relationships.

---

**Patients** (<u>Patient_ID</u>, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status)

**Roles** (<u>Role_ID</u>, Role_Name, Description)

**Employees** (<u>Employee_ID</u>, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status)

**Doctors** (<u>*Employee_ID*</u>, Specialization, License_Number)

**General_Employees** (<u>*Employee_ID*</u>, *Role_ID*)

**Appointments** (<u>Appointment_ID</u>, *Patient_ID*, *Doctor_ID*, Appointment_Date, Appointment_Type, Status, Reason_for_Visit)

**Medical_Records** (<u>Record_No</u>, *Appointment_ID*, Diagnosis, Clinical_Notes, Record_Date)

**Prescriptions** (<u>Prescription_No</u>, *Appointment_ID*, Prescription_Date, General_Instructions)

**Medicines** (<u>Medicine_ID</u>, Medicine_Name, Dosage_Form, Strength, Status)

**Prescription_Medicines** (<u>*Prescription_No*</u>, <u>*Medicine_ID*</u>, Dosage, Frequency, Duration_Days)

**Services** (<u>Service_ID</u>, Service_Name, Description, Price, Status)

**Invoices** (<u>Invoice_No</u>, *Appointment_ID*, Issue_Date)

**Invoice_Services** (<u>*Invoice_No*</u>, <u>*Service_ID*</u>, Quantity, Unit_Price)

**Payments** (<u>Payment_No</u>, *Invoice_No*, *Created_By_Employee_ID*, Amount_Paid, Payment_Date, Payment_Method)

---

# 1. Patients

**Patients** (<u>Patient_ID</u>, First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status)

### Primary Key

- `Patient_ID`

### Constraints

- `First_Name`, `Middle_Name`, `Last_Name`, `Date_of_Birth`, `Gender`, `Phone`, `City`, and `Status` are `NOT NULL`.
- `Gender` has a controlled domain.
- `Status` has a controlled domain.
- `Date_of_Birth` must contain a valid date.

### Design Note

- `Full_Name` is conceptually composite and is represented by:
  - `First_Name`
  - `Middle_Name`
  - `Last_Name`
- `Address` is conceptually composite and is represented by:
  - `City`
  - `Street`
  - `Neighborhood`

---

# 2. Roles

**Roles** (<u>Role_ID</u>, Role_Name, Description)

### Primary Key

- `Role_ID`

### Constraints

- `Role_Name` is `NOT NULL` and `UNIQUE`.
- `Description` is optional.

---

# 3. Employees

**Employees** (<u>Employee_ID</u>, First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status)

### Primary Key

- `Employee_ID`

### Constraints

- `First_Name`, `Middle_Name`, `Last_Name`, `Phone`, `City`, `Salary`, `Hire_Date`, and `Status` are `NOT NULL`.
- `Phone` is `UNIQUE`.
- `Salary > 0`.
- `Status` has a controlled domain.
- `Hire_Date` must contain a valid date.

### Design Note

`Employees` is the **supertype** relation containing attributes common to all employees.

---

# 4. Doctors

**Doctors** (<u>*Employee_ID*</u>, Specialization, License_Number)

### Primary Key

- `Employee_ID`

### Foreign Key

- `Employee_ID` references **Employees**(`Employee_ID`).

### Constraints

- `Employee_ID` is both the Primary Key and Foreign Key.
- `Specialization` is `NOT NULL`.
- `License_Number` is `NOT NULL` and `UNIQUE`.

### Design Principle

`Doctors` is a subtype of `Employees` using the **shared primary key approach**.

---

# 5. General_Employees

**General_Employees** (<u>*Employee_ID*</u>, *Role_ID*)

### Primary Key

- `Employee_ID`

### Foreign Keys

- `Employee_ID` references **Employees**(`Employee_ID`).
- `Role_ID` references **Roles**(`Role_ID`).

### Constraints

- `Employee_ID` is both the Primary Key and Foreign Key.
- `Role_ID` is `NOT NULL`.

---

# 6. Employee Specialization Constraint

The specialization of **Employees** into **Doctors** and **General_Employees** is:

- **Total Specialization**: Every employee must belong to exactly one current subtype.
- **Disjoint Specialization**: An employee cannot belong to both `Doctors` and `General_Employees`.

### Conceptual Representation

```text
                    Employees
                        |
              Total + Disjoint
                 /          \
                /            \
           Doctors      General_Employees
                              |
                            Roles
```

### Implementation Note

The following rules require implementation-level enforcement:

1. Every employee must belong to one subtype.
2. An employee cannot belong to both subtypes simultaneously.

These rules may require transaction validation, triggers, or other appropriate database mechanisms depending on the Oracle implementation strategy.

---

# 7. Appointments

**Appointments** (<u>Appointment_ID</u>, *Patient_ID*, *Doctor_ID*, Appointment_Date, Appointment_Type, Status, Reason_for_Visit)

### Primary Key

- `Appointment_ID`

### Foreign Keys

- `Patient_ID` references **Patients**(`Patient_ID`).
- `Doctor_ID` references **Doctors**(`Employee_ID`).

### Constraints

- `Patient_ID`, `Doctor_ID`, `Appointment_Date`, `Appointment_Type`, `Status`, and `Reason_for_Visit` are `NOT NULL`.
- `Appointment_Type` has a controlled domain.
- `Status` has a controlled domain.

### Design Note

`Appointments` is a **business event relation**, not merely a junction table.

It resolves the conceptual many-to-many relationship between:

```text
Patients M:N Doctors
```

while storing relationship-specific attributes:

- `Appointment_Date`
- `Appointment_Type`
- `Status`
- `Reason_for_Visit`

---

# 8. Medical_Records

**Medical_Records** (<u>Record_No</u>, *Appointment_ID*, Diagnosis, Clinical_Notes, Record_Date)

### Primary Key

- `Record_No` is generated automatically by Oracle using an identity column or sequence.

### Foreign Key

- `Appointment_ID` references **Appointments**(`Appointment_ID`).

### Constraints

- `Appointment_ID` is `NOT NULL` and `UNIQUE`.
- `Diagnosis` is `NOT NULL`.
- `Clinical_Notes` is optional.
- `Record_Date` is `NOT NULL`.

### Cardinality Enforcement

The `UNIQUE` constraint on `Appointment_ID` enforces:

```text
Appointments 1 : 0..1 Medical_Records
```

---

# 9. Prescriptions

**Prescriptions** (<u>Prescription_No</u>, *Appointment_ID*, Prescription_Date, General_Instructions)

### Primary Key

- `Prescription_No` is generated automatically by Oracle using an identity column or sequence.

### Foreign Key

- `Appointment_ID` references **Appointments**(`Appointment_ID`).

### Constraints

- `Appointment_ID` is `NOT NULL`.
- `Prescription_Date` is `NOT NULL`.
- `General_Instructions` is optional.

### Relationship

```text
Appointments 1 : 0..M Prescriptions
```

---

# 10. Medicines

**Medicines** (<u>Medicine_ID</u>, Medicine_Name, Dosage_Form, Strength, Status)

### Primary Key

- `Medicine_ID`

### Constraints

- `Medicine_Name`, `Dosage_Form`, `Strength`, and `Status` are `NOT NULL`.
- `Status` has a controlled domain.

### Design Scope

`Medicines` is a standardized reference catalog.

It does **not** include:

- Inventory quantity
- Stock management
- Purchasing
- Pharmacy sales

---

# 11. Prescription_Medicines

**Prescription_Medicines** (<u>*Prescription_No*</u>, <u>*Medicine_ID*</u>, Dosage, Frequency, Duration_Days)

### Composite Primary Key

```text
(Prescription_No, Medicine_ID)
```

### Foreign Keys

- `Prescription_No` references **Prescriptions**(`Prescription_No`).
- `Medicine_ID` references **Medicines**(`Medicine_ID`).

### Constraints

- `Dosage` is `NOT NULL`.
- `Frequency` is `NOT NULL`.
- `Duration_Days` is `NOT NULL`.
- `Duration_Days > 0`.

### Design Principle

This relation resolves:

```text
Prescriptions M:N Medicines
```

The following attributes belong to the relationship instance and therefore correctly reside here:

- `Dosage`
- `Frequency`
- `Duration_Days`

They are not permanent attributes of `Medicines`.

---

# 12. Services

**Services** (<u>Service_ID</u>, Service_Name, Description, Price, Status)

### Primary Key

- `Service_ID`

### Constraints

- `Service_Name` is `NOT NULL` and `UNIQUE`.
- `Description` is optional.
- `Price` is `NOT NULL`.
- `Price >= 0`.
- `Status` is `NOT NULL` and has a controlled domain.

### Design Principle

`Price` represents the **current or standard service price**.

Historical invoice prices are preserved separately in:

```text
Invoice_Services.Unit_Price
```

---

# 13. Invoices

**Invoices** (<u>Invoice_No</u>, *Appointment_ID*, Issue_Date)

### Primary Key

- `Invoice_No` is generated automatically by Oracle using an identity column or sequence.

### Foreign Key

- `Appointment_ID` references **Appointments**(`Appointment_ID`).

### Constraints

- `Appointment_ID` is `NOT NULL` and `UNIQUE`.
- `Issue_Date` is `NOT NULL`.

### Cardinality Enforcement

The `UNIQUE` constraint on `Appointment_ID` enforces:

```text
Appointments 1 : 0..1 Invoices
```

### Derived Values

`Total_Amount` and `Payment_Status` are derived values and are not stored as base relation attributes.

```text
Total_Amount = SUM(Quantity × Unit_Price)
```

Unpaid         when Total_Amount > 0 and SUM(Amount_Paid) = 0
Partially Paid when Total_Amount > 0 and 0 < SUM(Amount_Paid) < Total_Amount
Paid           when Total_Amount = 0 or SUM(Amount_Paid) = Total_Amount

These values should be exposed through a database view or query rather than stored redundantly.

### Design Principle

The derived total should be exposed through a query or database view rather than stored as redundant data.

---

# 14. Invoice_Services

**Invoice_Services** (<u>*Invoice_No*</u>, <u>*Service_ID*</u>, Quantity, Unit_Price)

### Composite Primary Key

```text
(Invoice_No, Service_ID)
```

### Foreign Keys

- `Invoice_No` references **Invoices**(`Invoice_No`).
- `Service_ID` references **Services**(`Service_ID`).

### Constraints

- `Quantity` is `NOT NULL`.
- `Quantity > 0`.
- `Unit_Price` is `NOT NULL`.
- `Unit_Price >= 0`.

### Derived Attribute

`Line_Total` is derived and is **not stored redundantly**.

```text
Line_Total = Quantity × Unit_Price
```

### Design Principle

`Unit_Price` stores the actual price charged when the invoice was created.

Therefore:

```text
Services.Price
```

represents the current standard price, while:

```text
Invoice_Services.Unit_Price
```

preserves the historical transaction price.

This prevents historical financial records from being affected by future price changes.

---

# 15. Payments

**Payments** (<u>Payment_No</u>, *Invoice_No*, *Created_By_Employee_ID*, Amount_Paid, Payment_Date, Payment_Method)

### Primary Key

- `Payment_No` is generated automatically by Oracle using an identity column or sequence.

### Foreign Keys

- `Invoice_No` references **Invoices**(`Invoice_No`).
- `Created_By_Employee_ID` references **General_Employees**(`Employee_ID`).

### Constraints

- `Invoice_No` is `NOT NULL`.
- `Created_By_Employee_ID` is `NOT NULL`.
- `Amount_Paid` is `NOT NULL`.
- `Amount_Paid > 0`.
- `Payment_Date` is `NOT NULL`.
- `Payment_Method` is `NOT NULL` and has a controlled domain.

### Relationship

```text
Invoices 1 : 0..M Payments
```

This supports:

- Unpaid invoices
- Partial payments
- Full payments
- Multiple installment payments

---

# 16. Relationship Summary

| Relationship | Cardinality | Implementation |
|---|---:|---|
| Employees → Doctors | 1 : 0..1 | Shared PK |
| Employees → General_Employees | 1 : 0..1 | Shared PK |
| Roles → General_Employees | 1 : M | FK `Role_ID` |
| Patients → Appointments | 1 : 0..M | FK `Patient_ID` |
| Doctors → Appointments | 1 : 0..M | FK `Doctor_ID` |
| Appointments → Medical_Records | 1 : 0..1 | FK + UNIQUE |
| Appointments → Prescriptions | 1 : 0..M | FK |
| Prescriptions → Medicines | M : N | `Prescription_Medicines` |
| Appointments → Invoices | 1 : 0..1 | FK + UNIQUE |
| Invoices → Services | M : N | `Invoice_Services` |
| Invoices → Payments | 1 : 0..M | FK |
| General_Employees → Payments | 1 : 0..M | FK |

---

# 17. Business Rules Requiring Implementation-Level Enforcement

The following rules are part of the database design but require enforcement through appropriate implementation mechanisms such as transaction validation, triggers, or other Oracle database logic:

1. Every employee must belong to exactly one subtype:
   - `Doctors`
   - `General_Employees`

2. An employee cannot belong to both subtypes simultaneously.

3. New appointments must reference active doctors.

4. Inactive medicines cannot be selected for new prescriptions.

5. Inactive services cannot be added to new invoices.

6. Cancelled appointments cannot have associated:
   - `Medical_Records`
   - `Prescriptions`
   - `Invoices`

7. No-show appointments cannot have:
   - `Medical_Records`
   - `Prescriptions`

8. The cumulative sum of `Amount_Paid` for an invoice must not exceed the derived invoice total.

9. `Payment_Status` must be derived from the invoice total and the cumulative payment amount rather than stored redundantly.

10. `Record_Date` must not precede the associated `Appointment_Date`.

11. `Prescription_Date` must not precede the associated `Appointment_Date`.

12. `Issue_Date` must not precede the associated `Appointment_Date`.

13. `Payment_Date` must be greater than or equal to the associated invoice's `Issue_Date`.

---

# 18. Controlled Domains

The following attributes should use controlled domains implemented through appropriate `CHECK` constraints or equivalent mechanisms:

| Attribute | Example Domain |
|---|---|
| `Patients.Gender` | Controlled values defined by system requirements |
| `Patients.Status` | Active, Inactive |
| `Employees.Status` | Active, Inactive |
| `Appointments.Appointment_Type` | Scheduled, Walk-in |
| `Appointments.Status` | Scheduled, Completed, Cancelled, No-show |
| `Medicines.Status` | Active, Inactive |
| `Services.Status` | Active, Inactive |
| `Payments.Payment_Method` | Controlled payment methods supported by the clinic |

---

# 19. Derived Values

| Derived Attribute | Calculation | Storage |
|---|---|---|
| `Invoice_Services.Line_Total` | `Quantity × Unit_Price` | Not stored |
| `Invoices.Total_Amount` | `SUM(Quantity × Unit_Price)` | Not stored |
| `Invoices.Payment_Status` | Derived from `Total_Amount` and `SUM(Amount_Paid)` | Not stored |
