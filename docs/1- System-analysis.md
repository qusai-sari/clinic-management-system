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

---

## 2. System Scope

### 2.1 In-Scope

| Area | Summary |
|---|---|
| Patient Management | Identity, demographic, contact, and account-status data. A patient may exist without an appointment and may have zero, one, or many appointments over time. |
| Employee Management | Common employee data stored once via a supertype/subtype structure: `Employees` → `Doctors` / `General_Employees`. |
| Doctors Management | Doctors are specialized employees with specialization and license number. Appointments reference the `Doctors` subtype directly. |
| General Employee Management | Non-doctors employees, each linked to exactly one `Role`. |
| Appointment Management | Actual interactions between patients and doctors; resolves the conceptual M:N relationship between them. |
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
| 8 | `Prescriptions` | Clinical Entity |
| 9 | `Medicines` | Reference / Catalog Entity |
| 10 | `Prescription_Medicines` | Associative Entity (M:N) |
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
| `First_Name` | Patient's first name | NOT NULL |
| `Last_Name` | Patient's last name | NOT NULL |
| `Date_of_Birth` | Date of birth | NOT NULL, valid date |
| `Gender` | Patient's gender | NOT NULL, controlled domain |
| `Phone` | Contact phone number | NOT NULL |
| `Address` | Patient's address | NOT NULL |
| `Status` | Account status (e.g., Active/Inactive) | NOT NULL, controlled domain |

**Business Rules**
- A patient may exist without an appointment, and may have zero, one, or many appointments.
- Patient data is stored independently and is never duplicated inside `Appointments`.
- Inactive patients are retained (soft-deleted) to preserve historical relationships.

---

### 4.2 Employees (Supertype)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Unique employee identifier | **PK** |
| `First_Name` | Employee's first name | NOT NULL |
| `Last_Name` | Employee's last name | NOT NULL |
| `Phone` | Contact phone number | NOT NULL, **UNIQUE** |
| `Salary` | Employee salary | NOT NULL, positive value |
| `Hire_Date` | Hiring date | NOT NULL, valid date |
| `Status` | Employment status | NOT NULL, controlled domain |

**Business Rules**
- Common employee data is stored once here to avoid duplication across subtypes.
- Every employee belongs to **exactly one** current subtype (Total specialization).
- An employee cannot be both a `Doctors` and a `General_Employees` (Disjoint specialization).
- Inactive employees are retained when historical relationships must be preserved.

---

### 4.3 Doctors (Subtype of `Employees`)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Identifies the doctor | **PK, FK** → `Employees.Employee_ID` |
| `Specialization` | Medical specialization | NOT NULL |
| `License_Number` | Professional license number | NOT NULL, **UNIQUE** |

**Business Rules**
- Every doctor must correspond to an existing employee record.
- License number must be unique per doctor.
- Appointments must reference the `Doctors` subtype — not `Employees` directly.
- New appointments must only be assigned to active doctors.

---

### 4.4 General_Employees (Subtype of `Employees`)

| Attribute | Description | Rule |
|---|---|---|
| `Employee_ID` | Identifies the general employee | **PK, FK** → `Employees.Employee_ID` |
| `Role_ID` | Employee's role | NOT NULL, **FK** → `Roles.Role_ID` |

**Business Rules**
- Represents current non-doctors employees; no further subtypes are defined in this scope.
- Each general employee has exactly one role; one role may be assigned to many employees.

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
| `Appointment_Type` | Type of appointment | NOT NULL, controlled domain (e.g., Scheduled, Walk-in, Follow-up) |
| `Status` | Appointment status (e.g., Scheduled/Completed/Cancelled/No-show) | NOT NULL, controlled domain |
| `Reason_for_Visit` | Reason for the visit | NOT NULL |

**Business Rules**
- Every appointment belongs to exactly one patient and references exactly one doctor.
- A patient/doctor may have zero, one, or many appointments.
- `Appointments` is a **business event**, not a plain linking table — it carries its own attributes and therefore resolves the conceptual `Patients M:N Doctors` relationship.
- Cancelled appointments (`Status = 'Cancelled'`) must not have associated `Medical_Records`, `Prescriptions`, or `Invoices`.
- No-show appointments (`Status = 'No-show'`) may only generate invoices if the clinic charges a penalty/cancellation fee, but cannot generate `Medical_Records` or `Prescriptions`.

> **Note:**
**`Appointment_Type` = (Booking Source):**
   - `Scheduled`: Patient booked in advance.
**`Status` = (Operational State):**
   - `Scheduled`: Appointment is booked for a future time; patient has not arrived yet.

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
- An appointment may have zero or one medical record (`0..1`).
- Each medical record belongs to exactly one appointment (`1..1`).
- The `Appointment_ID` is defined as **UNIQUE** to strictly enforce that no appointment can have more than one medical record.
- No direct `Patient_ID` is stored — the patient is reached via `Medical_Records → Appointments → Patients`, avoiding redundant relationships and maintaining 3NF database normalization.

---

### 4.8 Prescriptions

| Attribute | Description | Rule |
|---|---|---|
| `Prescription_No` | Unique prescription identifier | **PK**, Auto-increment |
| `Appointment_ID` | Associated appointment | NOT NULL, **FK** → `Appointments.Appointment_ID` |
| `Prescription_Date` | Date issued | NOT NULL, valid date |
| `General_Instructions` | General instructions | Optional |

**Business Rules**
- An appointment may have zero, one, or many prescriptions.
- Each prescription belongs to exactly one appoinment.
- A prescription may contain multiple medicines; medicine-specific instructions live in `Prescription_Medicines`.

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
- Stores standardized reference data only — **not** pharmacy inventory (no stock/quantity attributes).
- Inactive medicines (Status = 'Inactive') are retained to preserve historical prescriptions, but cannot be selected for new prescriptions.

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
- Resolves `Prescriptions M:N Medicines`.
- Dosage/Frequency/Duration describe how a medicine is used *within a specific prescription* — not permanent properties of `Medicines`.

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
- `Services.Price` is the *current* price — it never overwrites historical prices already invoiced. Supports free services/follow-ups (`Price = 0`).
- Inactive services (Status = 'Inactive') are retained to preserve historical invoice records, but cannot be added to new invoices.
  
---

### 4.12 Invoices

| Attribute | Description | Rule |
|---|---|---|
| `Invoice_No` | Unique identifier for the invoice | **PK**, Auto-increment |
| `Appointment_ID` | Associated appointment | **FK** → `Appointments.Appointment_ID`, **UNIQUE**, NOT NULL |
| `Issue_Date` | Date issued | NOT NULL, valid date |
| `Payment_Status` | Administrative status (Unpaid/Paid/Cancelled) | NOT NULL, controlled domain |
| `Total_Amount` | Total services cost | Derived and can't be manipulated manually |

**Business Rules**
- An appointment may have zero or one invoice (`0..1`).
- Each invoice belongs to exactly one appointment (`1..1`).
- The `Appointment_ID` is defined as **UNIQUE** to strictly enforce that no appointment can have more than one invoice.
- `Total_Amount` is **derived**, not stored: `SUM(Line_Total)` from `Invoice_Services` (exposed via a database View in the implementation phase).
- No direct `Patient_ID` is stored — the patient is reached via `Invoices → Appointments → Patients`, avoiding redundant relationships and maintaining database normalization.

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
| `Created_By_Employee_ID` |Employee who recorded and processed the payment | **FK** → `General_Employees.Employee_ID`, NOT NULL |
| `Amount_Paid` | Amount paid in this transaction | NOT NULL, positive value |
| `Payment_Date` | Date of payment | NOT NULL, valid date |
| `Payment_Method` | Method used (e.g., Cash, Credit Card) | NOT NULL, controlled domain |


**Business Rules**
- An invoice may have zero, one, or many payments (`0..*`), supporting partial, full, or installment payments.
- Each payment record belongs to strictly one invoice (`1..1`).
- Every payment must reference the appropriate non-doctor employee (`Created_By_Employee_ID`) who processed the financial transaction for accountability and audit trail purposes.
- The cumulative sum of `Amount_Paid` for a single `Invoice_No` must not exceed the invoice's derived `Total_Amount`.
- `Payment_Date` must be on or after the associated invoice's `Issue_Date` (`Payment_Date >= Invoices.Issue_Date`).

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

- **Total**: every employee must belong to a current subtype (`Doctors` or `General_Employees`).
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
| 13 | `Employees – Payments` | 1 : 0..M | An employee processes zero or more financial payments (Audit trail) |

### Transaction-Specific Attribute Principle

Attributes describing a *relationship instance* (not the parent entities) are stored on the associative/event entity itself:

- `Appointments` → `Appointment_Date`, `Type`, `Status`, `Reason`
- `Prescription_Medicines` → `Dosage`, `Frequency`, `Duration_Days`
- `Invoice_Services` → `Quantity`, `Unit_Price`

This prevents relationship-specific values from being mistakenly stored as permanent attributes of `Patients`, `Doctors`, `Medicines`, or `Services`.

---

## 7. Business Rules (Consolidated)

**Patients**

1. `Patient_ID` is unique per patient.
2. A patient may exist without an appointment.
3. Patient data is never duplicated in `Appointments`.
4. Inactive patients are retained, not physically deleted.

**Employees / Doctors / General_Employees**

1. `Employee_ID` is unique per employee.
2. Every employee belongs to exactly one current subtype (Total + Disjoint).
3. A Doctor's `License_Number` is unique; new appointments only reference active doctors.
4. Every general employee has exactly one role.

**Appointments**

1. Every appointment has exactly one patient and one doctor.
2. Appointment date, type, status, and reason are mandatory.
3. Status supports Scheduled, Completed, Cancelled, and No-show. Cancelled appointments cannot receive medical records, prescriptions, or invoices.

**Medical Records & Prescriptions**

1. An appointment has at most one medical record.
2. An appointment may have multiple prescriptions; each prescription may cover multiple medicines.
3. Dosage/Frequency/Duration are recorded per prescription-medicine pair, not on `Medicines` itself.

**Medicines / Services**

1. `Medicines` is a reference catalog only — no inventory tracking.
2. `Services.Price` is the current price; it never overwrites historical invoice prices.
3. Inactive services or medicines (Status = 'Inactive') are soft-deleted and cannot be selected for new transactions, preserving historical clinical and billing records.

**Invoices & Payments**

1. An appointment has at most one invoice.
2. `Total_Amount` and `Line_Total` are derived values, never stored redundantly.
3. `Unit_Price` on `Invoice_Services` preserves the price actually charged.
4. Cumulative payments on an invoice must not exceed its derived total.
5. `Payment_Status` is a stored administrative state, distinct from the calculated `SUM(Amount_Paid)`.
6. Payment date must be greater than or equal to the invoice issue date (`Payment_Date >= Issue_Date`).
7. Every payment transaction must be audited by linking to the employee who recorded it (Created_By_Employee_ID).

---

## 8. Data Integrity Constraints

### 8.1 Primary & Foreign Keys

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
| `Payments` | `Payment_No` | `Invoice_No` → `Invoices`, `Created_By_Employee_ID` → `General_Employees.Employee_ID`|

> **Doctors reference integrity**: `Appointments.Doctor_ID` must target `Doctors.Employee_ID`, never `Employees.Employee_ID` directly — this guarantees an appointment always references an employee who is actually a doctor.

### 8.2 UNIQUE Constraints

- `Doctors.License_Number`
- All primary keys are inherently unique.
- `Role_Name`, `Service_Name`.

### 8.3 CHECK / Domain Constraints (examples to implement in SQL phase)

- `CHECK (Salary > 0)`
- `CHECK (Services.Price >= 0)` (allows free services/follow-up visits)
- `CHECK (Invoice_Services.Quantity > 0)` and `CHECK (Invoice_Services.Unit_Price >= 0)`
- `CHECK (Payments.Amount_Paid > 0)`
- `CHECK` on controlled-domain columns such as `Appointments.Status`, `Appointments.Appointment_Type`, `Invoices.Payment_Status`, `Employees.Status`, `Patients.Status` (e.g., restricted to an allowed list of values).
- `CHECK (Payment_Date >= Issue_Date)` (ensures payment transactions occur on or after the invoice issuance date)

---

## 9. Key Design Decisions

| Decision | Rationale |
|---|---|
| `Employees` as supertype | Avoids duplicating common attributes across `Doctors` and `General_Employees`. |
| Total + Disjoint specialization | Every employee is either a Doctors or a General Employee — never both, never neither. |
| `Appointments` as a business event (not a plain junction table) | It carries its own attributes (date, type, status, reason), so it meaningfully resolves `Patients M:N Doctors`. |
| No direct `Patient_ID` in `Medical_Records` / `Invoices` | Both are reachable through `Appointments`, avoiding a redundant duplicate relationship. |
| `Medicines` as reference-only | Pharmacy inventory is out of scope; keeps the catalog clean and focused. |
| Two separate price concepts | `Services.Price` (current) vs. `Invoice_Services.Unit_Price` (historical, actually charged) — preserves financial history. |
| Derived financial totals | `Line_Total` and `Total_Amount` are calculated, not stored, to avoid redundancy and update anomalies. |
| Soft deletion via `Status` | `Employees.Status` / `Patients.Status` / `Services.Status` / `Medicines.Status` preserve historical relationships instead of physical deletion. |
| Auditing payment creation via `Created_By_Employee_ID` | Ensures financial accountability by tracking which employee recorded each payment transaction. |

---

## 10. Conclusion

The Clinic Management System is modeled around `Appointments` as the central business event linking `Patients` and `Doctors`, with two downstream branches:

- **Clinical branch**: `Appointments → Medical_Records` and `Appointments → Prescriptions → Prescription_Medicines → Medicines`
- **Financial branch**: `Appointments → Invoices → Invoice_Services → Services`, with `Invoices → Payments`

The employee side uses a Total + Disjoint `Employees` supertype with `Doctors` and `General_Employees` subtypes. All redundant relationships are avoided by routing through `Appointments`, all M:N relationships are resolved with associative entities carrying their own meaningful attributes, and historical financial data is preserved by separating current prices from actually-charged prices.

This analysis (entities, attributes, keys, relationships, cardinalities, and business rules) is the finalized foundation for the next project phases: **ERD Design → Normalization (1NF/2NF/3NF) → Oracle SQL Implementation**.
