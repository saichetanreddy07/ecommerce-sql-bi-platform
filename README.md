# E-commerce Data Engineering and BI Platform

An end-to-end data engineering and analytics project that samples e-commerce events, cleans and validates them with Python, loads them into MySQL, analyzes them with SQL, and presents findings in Power BI.

The included dataset is a capped sample of October 2019 activity. Its statistics describe the sample and should not be generalized to the full month.

## Project Overview

The pipeline covers:

1. Sampling the source CSV in chunks, with a cap of 10,000 records per event date.
2. Cleaning timestamps and text values, removing duplicates, and validating data quality.
3. Loading normalized categories, products, users, and events into MySQL 8.0+.
4. Answering sales, customer, product, conversion, and time analysis questions with MySQL SQL.
5. Reporting sample-level findings in a four-page Power BI dashboard.

See [architecture](docs/architecture.md), [database design](docs/database_design.md), [data dictionary](docs/data_dictionary.md), and [business insights](reports/business_insights.md).

## Technology

| Area | Tools |
|---|---|
| Data processing | Python 3.12, pandas, NumPy |
| Database | MySQL 8.0+, PyMySQL, InnoDB |
| Analytics | MySQL SQL, CTEs, window functions |
| Reporting | Power BI |
| Configuration | python-dotenv |
| Checks | unittest, GitHub Actions |

## Dataset

The source is the [eCommerce Behavior Data from Multi Category Store](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store), October 2019 file.

| Artifact | Details |
|---|---|
| Raw source | `data/raw/2019-Oct.csv` (5.67 GB locally; excluded from Git) |
| Sampling | Chunked extraction, capped at 10,000 rows per event date |
| Sample and cleaned data | 309,967 records over 31 dates; 10 columns |
| Cleaned CSV | `data/processed/ecommerce_cleaned.csv` (approximately 45.6 MB) |

To reproduce the sample, download the source file from Kaggle and place it at `data/raw/2019-Oct.csv`. The repository's cleaned sample is already available at the path above.

## Repository Layout

```text
.
├── dashboards/       Power BI report
├── data/             Raw, sampled, processed, and validation data
├── docs/             Architecture, database design, and data dictionary
├── images/           Dashboard previews and project diagrams
├── notebooks/        Data understanding notebook
├── reports/          Business insights
├── sql/
│   ├── ddl/           Database and table definitions
│   └── analytics/     Business analysis queries
├── src/
│   ├── extraction/    Chunked source sampling
│   ├── cleaning/      Event data cleaning
│   ├── validation/   Data quality profiling
│   └── loading/       MySQL connection and table loaders
└── tests/             Python unit tests
```

## ETL Pipeline

![ETL pipeline](<images/ETL Pipeline.png>)

Run the stages from the repository root:

```powershell
python -m src.extraction.create_sample_dataset
python -m src.cleaning.clean_ecommerce_data
python -m src.validation.validate_ecommerce_data
python -m src.loading.load_all
```

The full loader inserts in foreign-key order: **categories → products → users → events**. Loaders use batched `executemany` inserts in batches of 5,000 rows. `event_time` values are converted to naive UTC for storage in MySQL `DATETIME`; the database connection sets its session timezone to UTC.

## MySQL Schema

![MySQL database schema](<images/Normalized MySQL Schema.png>)

The InnoDB schema contains four tables:

- `categories`: source category identifiers and optional category codes.
- `products`: source product identifiers, category foreign key, and optional brand.
- `users`: source customer identifiers.
- `events`: auto-increment event identifier, UTC event timestamp, event date and type, price, session identifier, product foreign key, and user foreign key.

The database and tables use `utf8mb4`. Prices use `DECIMAL(10,2)`, text fields use bounded `VARCHAR` columns, and the event table has indexes on `event_time`, `event_type`, and its foreign keys. The product table indexes its category foreign key.

## Installation and Database Setup

Requirements: Python 3.12, MySQL 8.0+, and Power BI Desktop to open the `.pbix` report. Ensure the MySQL server is running and the `mysql` command-line client is available.

Create a Python environment and install dependencies:

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
Copy-Item .env.example .env
```

Set `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, and `DB_PASSWORD` in `.env`. The sample configuration uses port `3306` and database `ecommerce_bi`. `.env` is ignored by Git.

Create the database and tables from the repository root. Enter your MySQL password when prompted:

```powershell
Get-Content sql/ddl/create_database.sql | mysql -u root -p
Get-Content sql/ddl/create_categories.sql | mysql -u root -p ecommerce_bi
Get-Content sql/ddl/create_products.sql | mysql -u root -p ecommerce_bi
Get-Content sql/ddl/create_users.sql | mysql -u root -p ecommerce_bi
Get-Content sql/ddl/create_events.sql | mysql -u root -p ecommerce_bi
```

Then load the cleaned sample:

```powershell
python -m src.loading.load_all
```

The loader expects `data/processed/ecommerce_cleaned.csv` and a reachable MySQL server with credentials matching `.env`.

## SQL Analytics

The `sql/analytics/` directory contains seven analysis scripts and an exploratory session query. The queries cover purchase revenue, customer activity, product and category performance, event-count funnel ratios, time trends, rankings, running totals, moving averages, and `LAG`. Funnel rates are event-count ratios unless a query explicitly defines a session or customer grain. Ratio calculations use decimal operands to avoid integer division.

## Power BI

Open [the dashboard](dashboards/ecommerce_sales_analytics_dashboard.pbix) in Power BI Desktop. It contains four pages, 48 visual containers (16 charts, 16 KPI cards, 12 slicers, and 4 page-title text boxes), with event-date, category, and brand filters.

After migrating the database, reconnect the report's data source to MySQL and validate its measures. The funnel page's purchase card requires reconciliation with the source counts; see the [business insights report](reports/business_insights.md).

## Sample Checks

After loading, compare database results with these sample-level values:

| Measure | Expected value |
|---|---:|
| Events | 309,967 |
| Users | 139,048 |
| Products | 52,823 |
| Purchase revenue | $1,486,209.46 |
| Purchasing customers | 3,558 |

Other sample facts include 4,051 purchase events, 602 distinct category IDs, 126 non-null category codes, and 2,393 non-null brands. Category-code values are missing for 32.8% of event rows. These metrics describe only the capped sample.

## Verification

Run the Python unit tests and compile the source modules:

```powershell
python -m unittest discover -s tests -v
python -m compileall src
```

SQL execution also requires a running MySQL 8.0+ server with the schema loaded.

## Manual Migration Follow-up

- Current diagram exports are `images/architecture.png`, `images/ETL Pipeline.png`, and `images/Normalized MySQL Schema.png`. Review and regenerate them when the architecture, pipeline, or schema changes.
- Reconnect and validate the Power BI report against MySQL.
- Update any resume or portfolio material that still identifies PostgreSQL as the database.

## Future Improvements

- Define session-based funnel and cart-abandonment measures consistently across Power BI and SQL.
- Improve category-code and brand coverage with documented unknown-value handling.
- Add schema and business-rule assertions to validation.
- Make database loading idempotent and add MySQL integration tests.
- Add incremental ingestion, orchestration, and monitoring for production-scale data.
