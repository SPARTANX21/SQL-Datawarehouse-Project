# SQL Data Warehouse from Scratch | Full Hands-On Data Engineering Project

## 📌 Project Overview

This project aims to build a **SQL Data Warehouse** from scratch using **SQL Server**. 
It covers the end-to-end process of data engineering, including data ingestion, transformation, modeling, and analytics, following industry best practices. 
The project follows a **Medallion Architecture** (Bronze, Silver, Gold) for structured data processing.

## 🎯 Key Objectives

- Implement a robust **SQL-based Data Warehouse**.
- Design and manage **ETL pipelines** for structured data processing.
- Develop **data models** using Fact and Dimension tables.
- Perform **data transformation and cleansing**.
- Enable **business intelligence and reporting** through SQL queries.

---

## 🏠 Architecture

The data warehouse is structured into three layers:

### 1️⃣ Bronze Layer (Raw Data)

- **Purpose:** Stores raw, unprocessed data from various sources (CSV, logs, APIs, databases).
- **Storage:** Staging tables in SQL Server.
- **Data Characteristics:** Duplicate records, missing values, inconsistent formats.

### 2️⃣ Silver Layer (Processed Data)

- **Purpose:** Cleansed and transformed data, ready for analysis.
- **Operations:** Deduplication, standardization, type conversions.
- **Storage:** Normalized tables.

### 3️⃣ Gold Layer (Business-Ready Data)

- **Purpose:** Final structured data for analytics and reporting.
- **Schema:** Fact and Dimension tables (Star Schema).
- **Usage:** Business intelligence, dashboards, and reporting tools.

---

## 🛠️ Technology Stack

- **Database:** SQL Server
- **ETL Process:** SQL-based transformations & stored procedures
- **Data Modeling:** Star Schema (Fact & Dimension Tables)
- **Scripting:** Python (optional for automation)
- **Visualization:** Power BI / Tableau (optional)

---

## 🔧 Setup Instructions

### 1️⃣ Prerequisites

- Install **SQL Server** & **SSMS (SQL Server Management Studio)**.
- Clone the repository and navigate to the project directory.

### 2️⃣ Database Setup

- Create a new database in SQL Server:
  ```sql
  CREATE DATABASE DataWarehouse;
  ```
- Run the SQL scripts inside the `/sql_scripts` folder to create tables.

### 3️⃣ Data Ingestion

- Import raw CSV files into the **Bronze Layer** using `BULK INSERT` or `OPENROWSET`.
  ```sql
  BULK INSERT BronzeTable FROM 'your_path_to_file' WITH (FORMAT='CSV');
  ```

### 4️⃣ Data Transformation (ETL Process)

- Clean and process data using **stored procedures** and **SQL queries**.
  ```sql
  EXEC TransformBronzeToSilver;
  EXEC TransformSilverToGold;
  ```

### 5️⃣ Data Analysis & Reporting

- Query the **Gold Layer** for insights:
  ```sql
  SELECT * FROM FactSales;
  ```
- Connect to **Power BI / Tableau** for visualization.

---

## 📊 Data Modeling

The data warehouse follows a **Star Schema**:

### 📌 Fact Table

- `fact_sales`: Stores sales transactions with foreign keys to dimensions.

### 📌 Dimension Tables

- `dim_customer`: Customer details.
- `dim_product`: Product details.

---

## 🔥 Features

✔️ Full SQL-based ETL process 🚀\
✔️ Data Cleansing & Standardization 📊\
✔️ Star Schema for efficient querying 🔍\
✔️ Real-world hands-on SQL experience 🏆\
✔️ Ready for Business Intelligence (BI) tools 📈

---

## 🏆 Benefits of this Project

- **Industry-Standard Practices**: Learn real-world data warehouse design.
- **SQL Mastery**: Gain hands-on SQL experience in ETL & data modeling.
- **BI Readiness**: Prepare for Power BI / Tableau visualizations.
- **Performance Optimization**: Learn efficient indexing and querying techniques.

---

## 📌 Future Enhancements

- **Automation using Python & Airflow** 🛠️
- **Cloud Migration (Azure/AWS Redshift/BigQuery)** ☁️
- **Data Streaming (Kafka / Spark Streaming)** 🔥
- **Advanced Analytics & Machine Learning** 🤖

---

## 🤝 Contributing

Contributions are welcome! If you'd like to enhance the project:

1. **Fork** the repository.
2. Create a **new branch**.
3. Make your changes and **commit** them.
4. Open a **Pull Request**.

---


---

## 🙏 Acknowledgment & Gratitude

This project was made possible thanks to the guidance and expertise of **Baraa Khatib Salkini**. 
His detailed teaching and hands-on approach to data engineering have been invaluable in executing this project successfully.
For more incredible data engineering content, check out his GitHub: [DataWithBaraa](https://github.com/DataWithBaraa) 🚀

