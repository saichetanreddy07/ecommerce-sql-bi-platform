# Enterprise SQL Analytics & Business Intelligence Platform

## Overview

The Enterprise SQL Analytics & Business Intelligence Platform is an end-to-end Business Intelligence project that transforms raw e-commerce event data into actionable business insights.

The project demonstrates a complete BI workflow, including:

- Data extraction from a large e-commerce dataset
- Data cleaning and validation using Python
- ETL pipeline for loading data into PostgreSQL
- Relational database design and normalization
- Business analytics using PostgreSQL SQL
- Interactive dashboard development using Power BI
- Documentation and reporting

The primary goal of this project is to simulate a real-world Business Intelligence solution while strengthening practical skills in SQL, PostgreSQL, Python, ETL, and Power BI.

---

# Business Problem

An e-commerce company wants to better understand customer behavior, product performance, and sales trends. The Business Intelligence team has been tasked with building a reporting platform that enables stakeholders to monitor key metrics and make data-driven decisions.

---

# Objectives

- Build a scalable ETL pipeline using Python
- Clean and validate raw e-commerce data
- Design a normalized PostgreSQL database
- Load transformed data into PostgreSQL
- Answer business questions using SQL
- Create interactive Power BI dashboards
- Generate business insights for decision-making

---

# Architecture

```text
                Kaggle Dataset
                      │
                      ▼
          Python ETL Pipeline
   (Extraction → Cleaning → Validation)
                      │
                      ▼
          PostgreSQL Database
        (Normalized Relational Schema)
                      │
                      ▼
            SQL Analytics Layer
      (Business & Analytical Queries)
                      │
                      ▼
          Power BI Dashboards
                      │
                      ▼
            Business Insights
```

---

# Tech Stack

| Category | Technology |
|----------|------------|
| Programming Language | Python |
| Database | PostgreSQL |
| Query Language | SQL |
| Data Processing | Pandas, NumPy |
| Database Connectivity | psycopg2 |
| Environment Variables | python-dotenv |
| Visualization | Power BI |
| Development Environment | Visual Studio Code |
| Database Extension | SQLTools |
| Version Control | Git, GitHub |

---

# Project Structure

```text
ecommerce-sql-bi-platform/

├── data/
│   ├── raw/
│   ├── processed/
│   └── validation/
│
├── docs/
│   └── ai_context.md
│
├── src/
│   ├── extraction/
│   ├── cleaning/
│   ├── validation/
│   ├── loading/
│   └── automation/
│
├── sql/
│   ├── ddl/
│   └── analytics/
│
├── dashboards/
├── reports/
├── notebooks/
├── logs/
│
├── requirements.txt
├── README.md
└── .env.example
```

---

# Dataset

This project uses the **eCommerce Behavior Data from Multi Category Store** dataset available on Kaggle.

Dataset:
https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store

Only the **October 2019** dataset is used for this project.

The raw dataset is not included in this repository because it exceeds GitHub's file size limitations.

Place the dataset here before running the project:

```text
data/raw/2019-Oct.csv
```

---

# Database Schema

The project uses a normalized PostgreSQL database consisting of four tables.

| Table | Description |
|--------|-------------|
| categories | Stores unique product categories |
| products | Stores product information and category mapping |
| users | Stores unique customer information |
| events | Stores customer interactions including views, carts, and purchases |

### Relationships

```text
Categories
      │
      │ 1
      ▼
Products
      │
      │ 1
      ▼
Events
      ▲
      │
Users
```

---

# ETL Pipeline

## 1. Data Extraction

- Reads the large CSV file in chunks
- Creates a representative sample dataset
- Reduces memory usage while preserving data distribution

Output

```text
data/processed/ecommerce_sample.csv
```

Run

```bash
python src/extraction/create_sample_dataset.py
```

---

## 2. Data Cleaning

The transformation stage performs:

- Duplicate removal
- Invalid timestamp removal
- Text standardization
- Lowercase conversion
- Whitespace removal
- Business-rule preservation for missing values

Output

```text
data/processed/ecommerce_cleaned.csv
```

Run

```bash
python src/cleaning/clean_ecommerce_data.py
```

---

## 3. Data Validation

Validation includes:

- Row count verification
- Duplicate detection
- Missing value analysis
- Data type verification
- Event type validation
- Date range validation
- Negative price detection

Output

```text
data/validation/validation_report.txt
```

Run

```bash
python src/validation/validate_ecommerce_data.py
```

---

## 4. Data Loading

The cleaned dataset is loaded into PostgreSQL using a modular ETL pipeline.

Loading order:

```text
Categories
      │
      ▼
Products
      │
      ▼
Users
      │
      ▼
Events
```

This loading order preserves referential integrity and satisfies all foreign key constraints.

---

# SQL Analytics

The project contains approximately **40 business-focused SQL queries** organized into multiple analytical domains.

### Sales Analytics

- Total Revenue
- Revenue by Category
- Revenue Trends
- Top Brands
- Top Products
- Average Purchase Value

### Customer Analytics

- Customer Spending
- Most Active Users
- Repeat Customers
- Customer Purchase Behaviour

### Product Analytics

- Product Performance
- Brand Performance
- Category Analysis

### Conversion Analytics

- View → Cart → Purchase Funnel
- Conversion Rate
- Cart Abandonment

### Time Analytics

- Revenue by Hour
- Revenue by Week
- Peak Shopping Hours
- Peak Shopping Days

### Advanced SQL

Advanced PostgreSQL concepts demonstrated:

- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- Running Totals
- Moving Averages

---

# Power BI Dashboard

The Power BI dashboard provides interactive business insights through:

- Executive Overview
- Sales Dashboard
- Customer Analytics
- Product Analytics
- Conversion Funnel
- Time-based Trends

> Dashboard screenshots will be added after completion.

---

# Key Features

- End-to-end ETL pipeline
- PostgreSQL relational database
- Normalized schema design
- Business-driven SQL analysis
- Advanced PostgreSQL queries
- Interactive Power BI dashboards
- Modular Python codebase
- Production-inspired project structure

---

# Skills Demonstrated

### Python

- ETL Pipelines
- Data Cleaning
- Data Validation
- File Processing
- Pandas

### SQL

- Joins
- Aggregations
- GROUP BY
- HAVING
- CASE
- CTEs
- Window Functions
- Ranking Functions

### PostgreSQL

- Database Design
- Normalization
- Foreign Keys
- Constraints
- Query Optimization

### Business Intelligence

- KPI Design
- Business Analytics
- Dashboard Development
- Reporting
- Data Visualization

---

# Current Progress

- ✅ Project Setup
- ✅ Data Extraction
- ✅ Data Cleaning
- ✅ Data Validation
- ✅ PostgreSQL Database Design
- ✅ ETL Data Loading
- ✅ SQL Analytics
- ⏳ Power BI Dashboard
- ⏳ Business Insights Report
- ⏳ Final Documentation

---

# Future Improvements

- Automate ETL scheduling
- Add incremental data loading
- Create database indexes for performance optimization
- Deploy dashboards online
- Build automated reporting pipeline
- Add data quality monitoring

---

# Repository Status

This project is actively being developed. Additional Power BI dashboards, documentation, and deployment steps will be added in future updates.

---

# License

This project is intended for educational, learning, and portfolio purposes.