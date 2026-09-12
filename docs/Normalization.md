# Relational Schema Normalization of the Clinic Management System

## 1. Purpose and Scope

This section evaluates the relational schema of the Clinic Management System against the requirements of First, Second, and Third Normal Forms. The analysis is based on the declared primary keys, candidate keys, unique constraints, and functional dependencies in the schema. Business rules, authorization, transaction processing, and implementation mechanisms are outside the scope of this analysis.

---

# 2. First Normal Form (1NF)

## 2.1 Atomic Attributes

Conceptual composite attributes are decomposed into atomic attributes. For example, `Full_Name` is represented by `First_Name`, `Middle_Name`, and `Last_Name`, while `Address` is represented by `City`, `Street`, and `Neighborhood`.

## 2.2 Removal of Repeating Groups

Repeating and multivalued data are represented through separate relations. Medicines, invoice services, and payments are stored in `Prescription_Medicines`, `Invoice_Services`, and `Payments`, respectively. Therefore, each row represents one logical fact.

## 2.3 Primary Key Identification

Each relation has a declared primary key. Subtype relations use shared primary keys, while associative relations use composite keys.

## 2.4 1NF Result

The schema satisfies 1NF because its attributes are atomic, repeating groups are removed, multivalued relationships are represented by separate relations, and every relation has a primary key.

---

# 3. Functional Dependencies

The following functional dependencies are derived from the declared primary keys and `UNIQUE NOT NULL` constraints. A unique attribute is considered an alternate candidate key only when it is non-null and uniquely identifies a tuple.

## 3.1 Entity and Reference Relations

In `Patients`:

```text
Patient_ID → First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status
```

In `Roles`:

```text
Role_ID → Role_Name, Description
```

Because `Role_Name` is unique and not null:

```text
Role_Name → Role_ID, Description
```

In `Employees`:

```text
Employee_ID → First_Name, Middle_Name, Last_Name, Phone, City, Street, Neighborhood, Salary, Hire_Date, Status
```

Because `Phone` is unique and not null:

```text
Phone → Employee_ID
```

In `Doctors`:

```text
Employee_ID → Specialization, License_Number
```

This dependency holds because `Employee_ID` is the primary key of the subtype relation.

Because `License_Number` is unique and not null:

```text
License_Number → Employee_ID
```

In `General_Employees`:

```text
Employee_ID → Role_ID
```

In `Medicines`:

```text
Medicine_ID → Medicine_Name, Dosage_Form, Strength, Status
```

In `Services`:

```text
Service_ID → Service_Name, Description, Price, Status
```

Because `Service_Name` is unique and not null:

```text
Service_Name → Service_ID, Description, Price, Status
```

---

## 3.2 Transaction and Event Relations

```text
Appointment_ID → Patient_ID, Doctor_ID, Appointment_Date, Appointment_Type, Status, Reason_for_Visit
```

```text
Record_No → Appointment_ID, Diagnosis, Clinical_Notes, Record_Date
```

Because `Appointment_ID` is both `UNIQUE` and `NOT NULL` in `Medical_Records`:

```text
Appointment_ID → Record_No, Diagnosis, Clinical_Notes, Record_Date
```

```text
Prescription_No → Appointment_ID, Prescription_Date, General_Instructions
```

```text
Invoice_No → Appointment_ID, Issue_Date
```

Because `Appointment_ID` is both `UNIQUE` and `NOT NULL` in `Invoices`:

```text
Appointment_ID → Invoice_No, Issue_Date
```

```text
Payment_No → Invoice_No, Created_By_Employee_ID, Amount_Paid, Payment_Date, Payment_Method
```

---

## 3.3 Associative Relations

For `Prescription_Medicines`:

```text
(Prescription_No, Medicine_ID) → Dosage, Frequency, Duration_Days
```

For `Invoice_Services`:

```text
(Invoice_No, Service_ID) → Quantity, Unit_Price
```

---

## 4. Second Normal Form (2NF)

Relations with single-attribute primary keys satisfy 2NF automatically because partial dependencies cannot occur.

In `Prescription_Medicines`:

```text
(Prescription_No, Medicine_ID) → Dosage, Frequency, Duration_Days
```

These attributes depend on the complete composite key.

In `Invoice_Services`:

```text
(Invoice_No, Service_ID) → Quantity, Unit_Price
```

These attributes also depend on the complete composite key.

Therefore, no partial dependency exists, and the schema satisfies 2NF.

---

## 5. Third Normal Form (3NF)

Each relation was examined using its primary key and alternate candidate keys. Non-key attributes depend on the whole candidate key, and no non-key attribute determines another non-key attribute.

For example, in `Patients`:

```text
Patient_ID → First_Name, Middle_Name, Last_Name, Date_of_Birth, Gender, Phone, City, Street, Neighborhood, Status
```

Unique attributes such as `Role_Name`, `Phone`, `License_Number`, and `Service_Name` function as alternate candidate keys only when declared `UNIQUE NOT NULL`. Therefore, these dependencies do not constitute transitive dependencies.

Derived values such as `Line_Total`, `Total_Amount`, and `Payment_Status` are not stored as base relation attributes. Therefore, they do not introduce redundancy or update anomalies.

The schema satisfies 3NF, and no further decomposition is required based on the stated dependencies.

---

## 6. Final Conclusion

Based on the stated keys, constraints, and functional dependencies, the Clinic Management System schema satisfies 3NF. The schema uses atomic attributes, separate relations for multivalued data, composite keys for associative relations, and appropriate separation of entity and relationship attributes. No further decomposition is required for normalization purposes.
