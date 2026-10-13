# Data Dictionary

The source dataset contains e-commerce interaction events. The normalized PostgreSQL schema is defined in `sql/ddl/`.

## Cleaned Event Dataset

`data/processed/ecommerce_cleaned.csv` contains nine source fields plus the derived `event_date` field.

| Column | Description | Nullable in sample |
|---|---|---|
| `event_time` | Timestamp of the interaction, parsed during cleaning. | No |
| `event_type` | Interaction type (`view`, `cart`, or `purchase` in this sample). | No |
| `product_id` | Source product identifier. | No |
| `category_id` | Source category identifier. | No |
| `category_code` | Hierarchical category label; missing values are retained. | Yes |
| `brand` | Product brand; missing values are retained. | Yes |
| `price` | Price recorded on the event. | No |
| `user_id` | Source customer identifier. | No |
| `user_session` | Source session identifier. | No |
| `event_date` | Date derived from `event_time` for date-level analysis. | No |

## categories

| Column | PostgreSQL type | Constraints | Description |
|---|---|---|---|
| `category_id` | BIGINT | Primary key | Source category identifier. |
| `category_code` | TEXT | Nullable | Hierarchical product category code. |

## products

| Column | PostgreSQL type | Constraints | Description |
|---|---|---|---|
| `product_id` | INT | Primary key | Source product identifier. |
| `category_id` | BIGINT | Not null, foreign key | Category associated with the product. |
| `brand` | TEXT | Nullable | Product brand. |

## users

| Column | PostgreSQL type | Constraints | Description |
|---|---|---|---|
| `user_id` | BIGINT | Primary key | Source customer identifier. |

## events

| Column | PostgreSQL type | Constraints | Description |
|---|---|---|---|
| `event_id` | BIGSERIAL | Primary key | Database-generated event identifier. |
| `event_time` | TIMESTAMP | Not null | Timestamp of the customer interaction. |
| `event_date` | DATE | Not null | Calendar date derived from the interaction timestamp. |
| `event_type` | TEXT | Not null | Interaction type, such as view, cart, or purchase. |
| `price` | NUMERIC(10, 2) | Not null | Recorded product price for the event. |
| `user_session` | UUID | Not null | Session identifier from the source data. |
| `product_id` | INT | Not null, foreign key | Product associated with the event. |
| `user_id` | BIGINT | Not null, foreign key | Customer associated with the event. |
