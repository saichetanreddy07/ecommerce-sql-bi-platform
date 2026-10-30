# AI Project Context

## Project

Enterprise SQL Analytics & Business Intelligence Platform

This project demonstrates an end-to-end Business Intelligence workflow using Python, MySQL and Power BI.

The goal is to build a production-inspired analytics pipeline rather than a machine learning project.

---

# Tech Stack

- Python
- MySQL
- Pandas
- PyMySQL
- python-dotenv
- VS Code
- SQLTools
- Power BI
- Git & GitHub

---

# Project Structure

```
ecommerce-sql-bi-platform/

├── data/
│   ├── raw/
│   ├── processed/
│   ├── sample/
│   └── validation/
│
├── docs/
│   ├── architecture.md
│   ├── database_design.md
│   ├── data_dictionary.md
│   └── ai_context.md
│
├── sql/
│   ├── ddl/
│   ├── analytics/
│   ├── dml/
│   └── views/
│
├── src/
│   ├── config/
│   ├── extraction/
│   ├── loading/
│   ├── cleaning/
│   ├── validation/
│   └── utils/
│
├── dashboards/
├── images/
├── notebooks/
├── reports/
├── tests/
├── .github/workflows/
├── .env.example
├── .gitignore
├── README.md
└── requirements.txt
```

---

# Database Schema

## categories

- category_id (Primary Key)
- category_code

## products

- product_id (Primary Key)
- category_id (Foreign Key)
- brand

## users

- user_id (Primary Key)

## events

- event_id (Primary Key)
- event_time
- event_date
- event_type
- price
- user_session
- product_id (Foreign Key)
- user_id (Foreign Key)

---

# ETL Pipeline

Raw Dataset

↓

Sampling

↓

Cleaning

↓

Validation

↓

Load into MySQL

---

# SQL Analytics Folder

- `00_session_query.sql`
- `01_sales_analysis.sql`
- `02_customer_analysis.sql`
- `03_product_analysis.sql`
- `04_conversion_analysis.sql`
- `05_time_analysis.sql`
- `06_advanced_analytics.sql`

Table definitions are in `sql/ddl/`. The DML and views folders are reserved for future scripts.

---

# SQL Coding Standards

- Use MySQL syntax.
- Use meaningful aliases.
- Use INNER JOIN only when required.
- Revenue only includes rows where event_type = 'purchase'.
- Add one short comment before every query.
- Format SQL cleanly.
- Order queries from simple to advanced.
- Do not create views unless explicitly requested.
- Do not create stored procedures or functions unless explicitly requested.
- Use GROUP BY only when necessary.
- Use ORDER BY only when it improves readability.
- Use LIMIT where appropriate.

---

# Python Coding Standards

- Follow PEP 8.
- Keep functions small and focused.
- Use pathlib instead of os when possible.
- Use print() instead of logging.
- Use meaningful variable names.
- Add comments only where they improve understanding.
- Avoid unnecessary abstractions.
- Keep the code beginner-friendly and interview-ready.

---

# AI Coding Guidelines

When generating code:

- Do not over-engineer.
- Do not use unnecessary classes.
- Prefer functions over classes unless classes provide clear value.
- Keep code modular.
- Modify only the requested files.
- Do not change unrelated files.
- Return only the requested code.
- Assume this is a portfolio project for a final-year Computer Science student.
- Write code that is easy to explain during technical interviews.

---

# Analytics Philosophy

Every SQL query should answer a business question.

Do not generate random SQL queries.

Always think in this order:

1. Business Question
2. Required Tables
3. Required Joins
4. Required Filters
5. Aggregation
6. Grouping
7. Ordering
8. SQL

---

# Business Domains

Sales Analytics

Customer Analytics

Product Analytics

Conversion Analytics

Time Analytics

Business Insights

Interview SQL

---

# Git Rules

- Keep commits focused.
- One feature per commit.
- Do not commit raw datasets.
- Do not commit .env.
- Keep folder structure consistent.

---

# General Rules

Prefer readability over clever code.

Prefer maintainability over short code.

If there are multiple correct solutions, choose the one that is easiest for a beginner to understand while still following industry best practices.