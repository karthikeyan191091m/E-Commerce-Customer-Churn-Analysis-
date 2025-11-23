# E-Commerce Customer Churn Analysis

This repository contains SQL scripts and exploratory queries used to clean, transform, and analyze an e-commerce customer churn dataset. The main SQL script performs data cleaning, feature engineering, and produces analytical summaries that help identify churn patterns and customer behavior.

---

## Files
- `SQL Capstone Project (E-Commerce Customer Churn Analysis)Final.sql` — Main SQL script containing:
  - Missing value imputation (averages and modes)
  - Data standardization and renaming of columns
  - Creation of derived columns like `ComplaintReceived` and `ChurnStatus`
  - Descriptive and aggregation queries to summarize churn, complaints, payment patterns, and product preferences
  - Creation and joining with a sample `customer_returns` table

---

## How to use
1. Place the provided SQL file in a directory accessible by your SQL client/server.  
   Example path in this session: `/mnt/data/SQL Capstone Project (E-Commerce Customer Churn Analysis)Final.sql`

2. Open your MySQL client (or compatible SQL engine) and run the SQL script:
   ```sql
   -- Example using MySQL CLI
   mysql -u your_username -p your_database_name < "SQL Capstone Project (E-Commerce Customer Churn Analysis)Final.sql"
   ```

3. Alternatively, open the file in a GUI client (MySQL Workbench, DBeaver, HeidiSQL) and execute the statements step-by-step to inspect intermediate results.

---

## Requirements
- MySQL server (or compatible database engine)
- Sufficient privileges to ALTER tables, UPDATE rows, and CREATE tables
- Optional: a backup of your `customer_churn` table before running the script (recommended)

---

## What the script does (high level)
- Imputes missing numeric values (e.g., `WarehouseToHome`, `HourSpendOnApp`, etc.) using rounded averages.
- Imputes categorical missing values (e.g., `tenure`, `CouponUsed`, `ordercount`) using mode values.
- Standardizes and corrects inconsistent categorical labels (e.g., `Phone` → `Mobile Phone`, `COD` → `Cash on Delivery`).
- Renames columns for clarity and consistency (e.g., `HourSpendOnApp` → `HoursSpentOnApp`).
- Adds human-readable columns:
  - `ComplaintReceived` derived from `Complain`
  - `ChurnStatus` derived from `Churn`
- Drops redundant columns after transformation.
- Performs aggregation queries to summarize churn counts, averages, and cross-tab analyses.
- Creates a `customer_returns` sample table and demonstrates JOINs to analyze churned customers with returns.

---

## Important notes & best practices
- **Backup your data** before running the script — some statements perform `UPDATE` and `ALTER TABLE`.
- Review `DELETE` statements (e.g., `delete from customer_churn where WarehouseToHome >100;`) to ensure they match your dataset expectations.
- If your SQL engine differs (PostgreSQL, MSSQL), adapt syntax (e.g., `SET` variable usage) accordingly.

---

## Improvements you can add
- Wrap updates in transactions so you can roll back if needed.
- Add logging or temporary staging tables when doing bulk imputation.
- Convert repeated queries into stored procedures for reusability.
- Build a dashboard (Power BI / Tableau) that reads from the cleaned table.

---

## Author
Karthikeyan M

---

