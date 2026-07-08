# Database Design

## Products

Purpose:
Stores product-related information.

Columns:
- product_id (Primary Key)
- category_id
- category_code
- brand

---

## Users

Purpose:
Stores user information.

Columns:
- user_id (Primary Key)

---

## Events

Purpose:
Stores every customer interaction.

Columns:
- event_time
- event_date
- event_type
- price
- user_session
- product_id (Foreign Key)
- user_id (Foreign Key)