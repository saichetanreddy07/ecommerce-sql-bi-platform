# Enterprise SQL Analytics & Business Intelligence Platform

## Overview

This project demonstrates an end-to-end Business Intelligence workflow using Python, PostgreSQL, SQL, and Power BI. The objective is to transform raw e-commerce event data into meaningful business insights through data extraction, cleaning, validation, database design, SQL analysis, KPI reporting, and interactive dashboards.

The project is being developed as a portfolio project to strengthen practical skills in SQL, Business Intelligence, and Data Analytics.

---

## Business Problem

An e-commerce company wants to better understand customer behavior, product performance, and sales trends. The Business Intelligence team has been tasked with building a reporting platform that helps stakeholders monitor key metrics and make data-driven decisions.

---

## Objectives

- Build a data extraction, cleaning, and validation pipeline using Python
- Design a relational database in PostgreSQL
- Analyze business data using SQL
- Create interactive dashboards in Power BI
- Generate business insights and recommendations

---

## Tech Stack

| Category | Technology |
|----------|------------|
| Programming Language | Python |
| Database | PostgreSQL |
| Query Language | SQL |
| Data Analysis | Pandas, NumPy |
| Visualization | Power BI |
| Development Environment | Visual Studio Code |
| Version Control | Git, GitHub |
| Notebook | Jupyter Notebook |

---

## Project Structure

```text
ecommerce-sql-bi-platform/
|
|-- data/
|   |-- raw/
|   |-- processed/
|   `-- validation/
|
|-- src/
|   |-- extraction/
|   |-- cleaning/
|   |-- validation/
|   `-- automation/
|
|-- sql/
|-- notebooks/
|-- dashboards/
|-- reports/
|-- logs/
|
|-- requirements.txt
|-- README.md
`-- main.py
```

---

## Dataset

This project uses the **eCommerce Behavior Data from Multi Category Store** dataset available on Kaggle:

```text
https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store
```

For this project, the **October 2019** dataset file is used.

The raw dataset is not included in this repository because it exceeds GitHub's file size limits.

Place the dataset in the following directory before running the project:

```text
data/raw/2019-Oct.csv
```

---

## Pipeline Steps

### 1. Create Sample Dataset

The raw CSV file is large, so the extraction script reads it in chunks and creates a smaller daily sample.

```bash
python src/extraction/create_sample_dataset.py
```

Output:

```text
data/processed/ecommerce_sample.csv
```

### 2. Clean Sample Dataset

The cleaning script removes duplicate rows, handles invalid timestamps, standardizes text columns, and preserves useful missing values for analysis.

```bash
python src/cleaning/clean_ecommerce_data.py
```

Output:

```text
data/processed/ecommerce_cleaned.csv
```

### 3. Validate Cleaned Dataset

The validation script checks row counts, missing values, duplicate rows, data types, event types, records by date, and negative prices.

```bash
python src/validation/validate_ecommerce_data.py
```

Output:

```text
data/validation/validation_report.txt
```

---

## Output Files

| File | Description |
|------|-------------|
| `data/processed/ecommerce_sample.csv` | Sample dataset created from the large raw CSV |
| `data/processed/ecommerce_cleaned.csv` | Cleaned ecommerce dataset ready for analysis |
| `data/validation/validation_report.txt` | Text report containing validation checks |

---

## Current Progress

- [x] Project setup
- [x] Development environment
- [x] Repository initialization
- [x] Sample dataset extraction
- [x] Data cleaning
- [x] Data validation
- [ ] PostgreSQL database design
- [ ] SQL analytics
- [ ] Power BI dashboards
- [ ] Business insights
- [ ] Documentation

---

## Repository Status

This project is currently under development and will be updated as each milestone is completed.

---

## License

This project is intended for educational and portfolio purposes.
