# System Analysis
## Clinic Management System

*Database Systems – Final Project | Phase 1: System Analysis*

---

## 1. System Overview & Objectives

The proposed **Clinic Management System** is a relational database system designed to manage the main clinical, administrative, and financial activities of a clinic.

The system manages structured information about:

- Patients
- Employees (Doctors and General Employees)
- Roles
- Appointments
- Medical Records
- Prescriptions and Medicines
- Services
- Invoices and Payments

This analysis defines the system's scope, entities, attributes, keys, relationships, cardinalities, business rules, and constraints required before proceeding to ERD design, normalization, and Oracle SQL implementation.

### Main Objectives

1. Maintain accurate and organized patient information.
2. Manage clinic employees and their current employee categories.
3. Represent doctors as specialized employees while avoiding duplication of common employee data.
4. Manage appointments between patients and doctors.
5. Maintain medical records associated with appointments.
6. Manage prescriptions and the medicines prescribed within them.
7. Maintain a standardized medicine reference catalog.
8. Manage clinic services and their current/standard prices.
9. Generate invoices associated with appointments while preserving historical prices.
10. Record full, partial, and multiple payments against invoices.
11. Reduce unnecessary data redundancy through appropriate entity separation.
12. Maintain data integrity through clearly defined relationships and business rules.
13. Preserve historical clinical and financial data when patients or employees become inactive.
14. A prescription must contain at least one associated row in `Prescription_Medicines`.

---

## 2. System Scope

### 2.1 In-Scope

| Area | Summary |
|---|---|
| Patient Management | Identity (Full_Name), demographic, contact (Address), and account-status data. A patient may exist without an appointment and may have zero, one, or many appointments over time. |
| Employee Management | Common employee identity (Full_Name), contact (Address, Phone), and HR data stored once via a supertype/subtype structure: `Employees` → `Doctors` / `General_Employees`. |
| Doctors Management | Doctors are specialized employees with specialization and license number. Appointments reference the `Doctors` subtype directly. |
| General Employee Management | Non-doctors employees, each linked to exactly one `Role`. |
| Appointment Management | Appointment events between patients and doctors, including scheduled, completed, cancelled, and no-show appointments; resolves the conceptual M:N relationship between them. |
| Medical Record Management | Clinical data resulting from an appointment (zero or one record per appointment). |
| Prescription Management | Issued during appointments; may include multiple medicines with prescription-specific dosage/frequency/duration. |
| Medicine Catalog | Standardized reference catalog only — **no pharmacy inventory management**. |
| Service Management | Clinic services with a current/standard price, independent of historical invoice pricing. |
| Invoice Management | Financial charges linked to appointments (zero or one invoice per appointment); totals are derived, not stored. |
| Payment Management | Supports unpaid, partial, full, and multiple payments per invoice. |

### 2.2 Out of Scope

- Doctors schedule / availability management
- Pharmacy inventory, drug purchasing, and stock replenishment
- Pharmacy sales
- Structured allergy or chronic-disease management
- Additional employee subtypes (e.g., Receptionist, Accountant)

---

## 3. Entity Identification

The system contains **14 entities**:

| # | Entity | Classification |
|---|---|---|
| 1 | `Employees` | Supertype |
| 2 | `Doctors` | Subtype |
| 3 | `General_Employees` | Subtype |
| 4 | `Roles` | Reference Entity |
| 5 | `Patients` | Main Entity |
| 6 | `Appointments` | Main Business Event / Associative Entity |
| 7 | `Medical_Records` | Dependent Clinical Entity |
| 8 | `8.riptions` | Clinical Entity |
| 9 | `Medicines` | Reference / Catalog Entity |
| 10 | `8.ription_Medicines` | Associative Entity (M:N) |
| 11 | `Services` | Reference / Catalog Entity |
| 12 | `Invoices` | Financial Entity |
| 13 | `Invoice_Services` | Associative Entity (M:N) |
| 14 | `Payments` | Financial Transaction Entity |

---

## 4. Entity & Attribute Specification

### 4.1 Patients

| Attribute | Description | Rule |
|---|---|---|
| `Patient_ID` | Unique patient identifier | **PK** |
| `First_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Middle_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Last_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Date_of_Birth` | Date of birth | NOT NULL, valid date |
| `Gender` | Patient's gender | NOT NULL, controlled domain |
| `Phone` | Contact phone number | NOT NULL |
| `City` | Component of composite attribute `Address` | NOT NULL |
| `Street` | Component of composite attribute `Address` | Optional |
| `Neighborhood` | Component of composite attribute `Address` | Optional |
| `Status` | Account status (e.g., Active/Inactive) | NOT NULL, controlled domain |

**Business Rules**

- A patient may exist without an appointment.
- A patient may have zero, one, or many appointments over time.
- Patient data must be stored independently and must not be duplicated inside `Appointments`.
- Inactive patients must be retained rather than physically deleted in order to preserve historical relationships.

---

### 4.2 Employees (Supertype)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Unique employee identifier | **PK** |
| `First_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Middle_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Last_Name` | Component of composite attribute `Full_Name` | NOT NULL |
| `Phone` | Contact phone number | NOT NULL, **UNIQUE** |
| `City` | Component of composite attribute `Address` | NOT NULL |
| `Street` | Component of composite attribute `Address` | Optional |
| `Neighborhood` | Component of composite attribute `Address` | Optional  |
| `Salary` | Employee salary | NOT NULL, positive value |
| `Hire_Date` | Hiring date | NOT NULL, valid date |
| `Status` | Employment status | NOT NULL, controlled domain |

**Business Rules**

- Common employee data must be stored once in `Employees` and must not be duplicated in the employee subtypes.
- Every employee must belong to exactly one subtype: `Doctors` or `General_Employees`.
- An employee cannot belong to both `Doctors` and `General_Employees`.
- Inactive employees must be retained when they are referenced by historical clinical or financial records.

---

### 4.3 Doctors (Subtype of `Employees`)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Identifies the doctor | **PK, FK** → `Employees.Employee_ID` |
| `Specialization` | Medical specialization | NOT NULL |
| `License_Number` | Professional license number | NOT NULL, **UNIQUE** |

**Business Rules**

- Every doctor must correspond to an existing record in `Employees`.
- Each doctor must have a unique professional `License_Number`.
- `Appointments` must reference `Doctors` rather than `Employees` directly.
- New appointments may be assigned only to doctors whose employee status is `Active`.

---

### 4.4 General_Employees (Subtype of `Employees`)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Identifies the general employee | **PK, FK** → `Employees.Employee_ID` |
| `Role_ID` | Employee's role | NOT NULL, **FK** → `Roles.Role_ID` |

**Business Rules**

- `General_Employees` represents non-doctor employees within the system scope.
- Every general employee must be assigned exactly one role.
- One role may be assigned to many general employees.

---

### 4.5 Roles

| Attribute | Description | Rule |
|---|---|---|
| `Role_ID` | Unique role identifier | **PK**|
| `Role_Name` | Name of the role | NOT NULL, **UNIQUE** |
| `Description` | Role description | Optional |

---

### 4.6 Appointments

| Attribute | Description | Rule |
|---|---|---|
| `Appointment_ID` | Unique appointment identifier | **PK** |
| `Patient_ID` | Associated patient | NOT NULL, **FK** → `Patients.Patient_ID` |
| `Doctor_ID` | Associated doctor | NOT NULL, **FK** → `Doctors.Employee_ID` |
| `Appointment_Date` | Date of appointment | NOT NULL, valid date |
| `Appointment_Type` | Booking source of the appointment | NOT NULL, controlled domain (`Scheduled`, `Walk-in`) |
| `Status` | Appointment status (Scheduled/Completed/Cancelled/No-show) | NOT NULL, controlled domain |
| `Reason_for_Visit` | Reason for the visit | NOT NULL |

**Business Rules**

- Every appointment must belong to exactly one patient and exactly one doctor.
- A patient may have zero, one, or many appointments.
- A doctor may have zero, one, or many appointments.
- `Appointments` is a business event and resolves the conceptual many-to-many relationship between patients and doctors.
- Appointment-specific information, including date, type, status, and reason, must be stored in `Appointments`.
- Cancelled appointments cannot have associated `Medical_Records`, `8.riptions`, or `Invoices`.
- No-show appointments cannot have associated `Medical_Records` or `8.riptions`.
- A no-show appointment may have an invoice only when the clinic charges a no-show or cancellation fee.

> **Note:**
**`Appointment_Type` = (Booking Source):**
   - `Scheduled`: Patient booked in advance.
   - `Walk-in`: Patient arrived without booking in advance.

**`Status` = (Operational State):**
   - `Scheduled`: Appointment is booked for a future time; patient has not arrived yet.
   - `Completed`: The appointment took place and was completed.
   - `Cancelled`: The appointment was cancelled and did not take place.
   - `No-show`: The patient did not attend the appointment.

---

### 4.7 Medical_Records

| Attribute | Description | Rule |
|---|---|---|
| `Record_No` | Unique identifier for the medical record | **PK**, Auto-increment |
| `Appointment_ID` | Associated appointment | **FK** → `Appointments.Appointment_ID`, **UNIQUE**, NOT NULL |
| `Diagnosis` | Diagnosis recorded | NOT NULL |
| `Clinical_Notes` | Additional notes | Optional |
| `Record_Date` | Date the record was created | NOT NULL, valid date |

**Business Rules**

- An appointment may have zero or one medical record.
- Each medical record belongs to exactly one appointment.
- `Appointment_ID` must be unique in `Medical_Records` to prevent more than one medical record for the same appointment.
- A medical record must not store a direct `Patient_ID`; the patient is reached through `Appointments`.
- `Record_Date` must be greater than or equal to the related `Appointment_Date`.

---

### 4.8 Prescriptions

| Attribute | Description | Rule |
|---|---|---|
| `Prescription_No` | Unique prescription identifier | **PK**, Auto-increment |
| `Appointment_ID` | Associated appointment | NOT NULL, **FK** → `Appointments.Appointment_ID` |
| `Prescription_Date` | Date issued | NOT NULL, valid date |
| `General_Instructions` | General instructions | Optional |

**Business Rules**

- An appointment may produce zero, one, or many prescriptions.
- Each prescription belongs to exactly one appointment.
- A prescription may contain one or many medicines through `Prescription_Medicines`.
- Medicine-specific dosage, frequency, and duration must be stored in `Prescription_Medicines`, not in `Prescriptions` or `Medicines`.
- `Prescription_Date` must be greater than or equal to the related `Appointment_Date`.
- A prescription cannot be finalized unless it contains at least one row in `Prescription_Medicines`.

---

### 4.9 Medicines (Reference Catalog)

| Attribute | Description | Rule |
|---|---|---|
| `Medicine_ID` | Unique medicine identifier | **PK** |
| `Medicine_Name` | Name of the medicine | NOT NULL |
| `Dosage_Form` | Form (tablet, syrup, etc.) | NOT NULL |
| `Strength` | Standard strength | NOT NULL |
| `Status` | Availability status (Active/Inactive) | NOT NULL, controlled domain |

**Business Rules**

- `Medicines` stores standardized medicine reference data only.
- Pharmacy inventory, stock quantity, purchasing, and pharmacy sales are outside the system scope.
- Inactive medicines must be retained to preserve historical prescriptions.
- Inactive medicines cannot be selected for new prescriptions.

---

### 4.10 Prescription_Medicines (Associative — M:N)

| Attribute | Description | Rule |
|---|---|---|
| `Prescription_No` | Identifies the prescription | **PK, FK** → `Prescriptions.Prescription_No` |
| `Medicine_ID` | Identifies the medicine | **PK, FK** → `Medicines.Medicine_ID` |
| `Dosage` | Dose prescribed | NOT NULL |
| `Frequency` | How often taken | NOT NULL |
| `Duration_Days` | Treatment duration | NOT NULL |

**Composite PK:** `(Prescription_No, Medicine_ID)`

**Business Rules**

- `Prescription_Medicines` resolves the many-to-many relationship between `Prescriptions` and `Medicines`.
- `Dosage`, `Frequency`, and `Duration_Days` describe how a medicine is used within a specific prescription.
- The composite key `(Prescription_No, Medicine_ID)` prevents the same medicine from being repeated within one prescription.

---

### 4.11 Services

| Attribute | Description | Rule |
|---|---|---|
| `Service_ID` | Unique service identifier | **PK** |
| `Service_Name` | Name of the service | NOT NULL, **UNIQUE** |
| `Description` | Service description | Optional |
| `Price` | Current/standard price | NOT NULL, non-negative value (`>= 0`) |
| `Status` | Availability status (Active/Inactive) | NOT NULL, controlled domain |

**Business Rules**

- `Services.Price` is the *current* price — it never overwrites historical prices already invoiced. Supports free services and follow-ups (`Price = 0`).
- Inactive services (Status = 'Inactive') are retained to preserve historical invoice records, but cannot be added to new invoices.
  
---

### 4.12 Invoices

| Attribute | Description | Rule |
|---|---|---|
| `Invoice_No` | Unique identifier for the invoice | **PK**, Auto-increment |
| `Appointment_ID` | Associated appointment | **FK** → `Appointments.Appointment_ID`, **UNIQUE**, NOT NULL |
| `Issue_Date` | Date issued | NOT NULL, valid date |
| `Payment_Status` | Payment state derived from invoice total and payments | Derived, not stored |
| `Total_Amount` | Total services cost | Derived, not stored |

**Business Rules**

- An appointment may have zero or one invoice.
- Each invoice belongs to exactly one appointment.
- `Appointment_ID` must be unique in `Invoices` to prevent more than one invoice for the same appointment.
- An invoice must not store a direct `Patient_ID`; the patient is reached through `Appointments`.
- `Issue_Date` must be greater than or equal to the related `Appointment_Date`.
- `Total_Amount` is derived from `Invoice_Services` and is calculated as the sum of `Quantity × Unit_Price`; it must not be stored as a base attribute.
- If an invoice has no service lines, its derived `Total_Amount` is treated as zero.
- `Payment_Status` is derived from the invoice total and the cumulative payment amount:
  - `Unpaid` when `Total_Amount > 0` and no payment has been recorded.
  - `Partially Paid` when payments are greater than zero but less than `Total_Amount`.
  - `Paid` when `Total_Amount = 0` or payments equal `Total_Amount`.
- An invoice with a total amount of zero is considered `Paid` without requiring a payment record.

---

### 4.13 Invoice_Services (Associative — M:N)

| Attribute | Description | Rule |
|---|---|---|
| `Invoice_No` | Identifies the invoice | **PK, FK** → `Invoices.Invoice_No` |
| `Service_ID` | Identifies the service | **PK, FK** → `Services.Service_ID` |
| `Quantity` | Units of service | NOT NULL, positive value |
| `Unit_Price` | Actual price charged at invoice time | NOT NULL, non-negative value (`>= 0`) |
| `Line_Total` | Total cost of the service | Derived and can't be manipulated manually | 

**Composite PK:** `(Invoice_No, Service_ID)`

**Business Rules**

- Resolves `Invoices M:N Services`.
- `Unit_Price` preserves the historical charged price, independent of later changes to `Services.Price`.
- `Line_Total = Quantity × Unit_Price` is derived, not stored.

---

### 4.14 Payments

| Attribute | Description | Rule |
|---|---|---|
| `Payment_No` | Unique identifier for the payment | **PK**, Auto-increment |
| `Invoice_No` | Invoice receiving the payment | **FK** → `Invoices.Invoice_No`, NOT NULL |
| `Created_By_Employee_ID` | Employee who recorded and processed the payment | **FK** → `General_Employees.Employee_ID`, NOT NULL |
| `Amount_Paid` | Amount paid in this transaction | NOT NULL, positive value |
| `Payment_Date` | Date of payment | NOT NULL, valid date |
| `Payment_Method` | Method used (e.g., Cash, Credit Card) | NOT NULL, controlled domain |


**Business Rules**

- An invoice may have zero, one, or many payments.
- Each payment record belongs to exactly one invoice.
- Every payment must reference the general employee who recorded the transaction through `Created_By_Employee_ID`.
- The cumulative sum of `Amount_Paid` for a single invoice must not exceed the invoice's derived `Total_Amount`.
- `Payment_Date` must be greater than or equal to the associated invoice's `Issue_Date`.

---

## 5. Employee Specialization

```text
                     Employees
                         |
               Total + Disjoint Specialization
                    /              \
                   v                v
               Doctors        General_Employees
                                    |
                                    v
                                  Roles
```

- **Total**: every employee must belong to a subtype (`Doctors` or `General_Employees`).
- **Disjoint**: no employee can belong to both subtypes simultaneously.
- **Shared Primary Key**: both subtypes use `Employee_ID` as PK and FK back to `Employees`.

---

## 6. Relationships & Cardinalities

| # | Relationship | Cardinality | Notes |
|---|---|---|---|
| 1 | `Employees – Doctors` | 1 : 0..1 | Total + Disjoint specialization |
| 2 | `Employees – General_Employees` | 1 : 0..1 | Total + Disjoint specialization |
| 3 | `Roles – General_Employees` | 1 : M | One role → many general employees |
| 4 | `Patients – Appointments` | 1 : 0..M | A patient may have many appointments |
| 5 | `Doctors – Appointments` | 1 : 0..M | A doctor may have many appointments |
| 6 | `Patients – Doctors` | **M : N** | Resolved via `Appointments` (associative + business event) |
| 7 | `Appointments – Medical_Records` | 1 : 0..1 | Optional, one record max per appointment |
| 8 | `Appointments – Prescriptions` | 1 : 0..M | An appointment may yield many prescriptions |
| 9 | `Prescriptions – Medicines` | **M : N** | Resolved via `Prescription_Medicines` |
| 10 | `Appointments – Invoices` | 1 : 0..1 | Supports appointments not yet billed |
| 11 | `Invoices – Services` | **M : N** | Resolved via `Invoice_Services` |
| 12 | `Invoices – Payments` | 1 : 0..M | Supports full, partial, and multiple payments |
| 13 | `General_Employees – Payments` | 1 : 0..M | A general employee processes zero or more financial payments (Audit trail) |

### Transaction-Specific Attribute Principle

Attributes describing a *relationship instance* (not the parent entities) are stored on the associative/event entity itself:

- `Appointments` → `Appointment_Date`, `Type`, `Status`, `Reason`
- `Prescription_Medicines` → `Dosage`, `Frequency`, `Duration_Days`
- `Invoice_Services` → `Quantity`, `Unit_Price`

This prevents relationship-specific values from being mistakenly stored as permanent attributes of `Patients`, `Doctors`, `Medicines`, or `Services`.

---

## 7. Data Integrity Constraints

### 7.1 Primary & Foreign Keys

| Entity | Primary Key | Foreign Key(s) |
|---|---|---|
| `Employees` | `Employee_ID` | — |
| `Doctors` | `Employee_ID` | → `Employees.Employee_ID` |
| `General_Employees` | `Employee_ID` | → `Employees.Employee_ID`; `Role_ID` → `Roles.Role_ID` |
| `Roles` | `Role_ID` | — |
| `Patients` | `Patient_ID` | — |
| `Appointments` | `Appointment_ID` | `Patient_ID` → `Patients`; `Doctor_ID` → `Doctors.Employee_ID` |
| `Medical_Records` | `Record_No` | `Appointment_ID` → `Appointments` |
| `Prescriptions` | `Prescription_No` | `Appointment_ID` → `Appointments` |
| `Medicines` | `Medicine_ID` | — |
| `Prescription_Medicines` | `(Prescription_No, Medicine_ID)` | both → `Prescriptions`, `Medicines` |
| `Services` | `Service_ID` | — |
| `Invoices` | `Invoice_No` | `Appointment_ID` → `Appointments` |
| `Invoice_Services` | `(Invoice_No, Service_ID)` | both → `Invoices`, `Services` |
| `Payments` | `Payment_No` | `Invoice_No` → `Invoices`, `Created_By_Employee_ID` → `General_Employees.Employee_ID` |

> **Doctors reference integrity**: `Appointments.Doctor_ID` must target `Doctors.Employee_ID`, never `Employees.Employee_ID` directly — this guarantees an appointment always references an employee who is actually a doctor.

### 7.2 UNIQUE Constraints

- `Employees.Phone`
- `Doctors.License_Number`
- `Roles.Role_Name`
- `Services.Service_Name`
- `Medical_Records.Appointment_ID`
- `Invoices.Appointment_ID`
- All primary keys are inherently unique.

### 7.3 CHECK Constraints and Cross-Relation Conditions

- `CHECK (Salary > 0)`
- `CHECK (Prescription_Medicines.Duration_Days > 0)`
- `CHECK (Services.Price >= 0)` (allows free services)
- `CHECK (Invoice_Services.Quantity > 0)` and `CHECK (Invoice_Services.Unit_Price >= 0)`
- `CHECK (Payments.Amount_Paid > 0)`

- `Record_Date >= Appointment_Date` must be enforced through a trigger, transaction validation, or another implementation-level mechanism because the two attributes belong to different relations.
- `Prescription_Date >= Appointment_Date` must be enforced through a trigger, transaction validation, or another implementation-level mechanism.
- `Issue_Date >= Appointment_Date` must be enforced through a trigger, transaction validation, or another implementation-level mechanism.
- `Payment_Date >= Issue_Date` must be enforced through a trigger, transaction validation, or another implementation-level mechanism because the two attributes belong to different relations.
 
---

### 7.4 Controlled Domains

The following attributes must use controlled domains implemented through appropriate `CHECK` constraints or equivalent validation:

| Attribute | Example Domain |
|---|---|
| `Patients.Gender` | Controlled values defined by system requirements |
| `Patients.Status`, `Employees.Status`, `Medicines.Status`, `Services.Status` | `Active`, `Inactive` |
| `Appointments.Appointment_Type` | `Scheduled`, `Walk-in` |
| `Appointments.Status` | `Scheduled`, `Completed`, `Cancelled`, `No-show` |
| `Payments.Payment_Method` | Controlled payment methods supported by the clinic |

## 8. Key Design Decisions

| Decision | Rationale |
|---|---|
| `Employees` as supertype | Avoids duplicating common attributes across `Doctors` and `General_Employees`. |
| Total + Disjoint specialization | Every employee is either a Doctors or a General Employee — never both, never neither. |
| `Appointments` as a business event (not a plain junction table) | It carries its own attributes (date, type, status, reason), so it meaningfully resolves `Patients M:N Doctors`. |
| No direct `Patient_ID` in `Medical_Records` / `Invoices` | Both are reachable through `Appointments`, avoiding a redundant duplicate relationship. |
| `Medicines` as reference-only | Pharmacy inventory is out of scope; keeps the catalog clean and focused. |
| Two separate price concepts | `Services.Price` (current) vs. `Invoice_Services.Unit_Price` (historical, actually charged) — preserves financial history. |
| Derived financial values | `Line_Total`, `Total_Amount`, and `Payment_Status` are calculated rather than stored, preventing redundancy and update anomalies. |
| Soft deletion via `Status` | `Employees.Status` / `Patients.Status` / `Services.Status` / `Medicines.Status` preserve historical relationships instead of physical deletion. |
| Auditing payment creation via `Created_By_Employee_ID` | Ensures financial accountability by tracking which employee recorded each payment transaction. |
| Composite attributes decomposition | Attributes like `Full_Name` (First, Middle, Last) and `Address` (City, Street, Neighborhood) are defined conceptually as composite attributes to support First Normal Form (1NF) atomic field representation. |
