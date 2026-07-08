def load_products(df, connection):
    """Load unique product records into the products table."""
    products_df = df[["product_id", "category_id", "brand"]].copy()
    products_df = products_df.dropna(subset=["product_id", "category_id"])
    products_df = products_df.sort_values(by="brand", na_position="first")
    products_df = products_df.drop_duplicates(subset=["product_id"], keep="last")

    product_records = list(
        products_df[["product_id", "category_id", "brand"]].itertuples(
            index=False,
            name=None,
        )
    )

    insert_query = """
        INSERT INTO products (product_id, category_id, brand)
        VALUES (%s, %s, %s)
    """

    cursor = connection.cursor()

    try:
        cursor.executemany(insert_query, product_records)
        connection.commit()
        print(f"{len(product_records)} products inserted.")
    except Exception as error:
        connection.rollback()
        raise RuntimeError(f"Error loading products: {error}")
    finally:
        cursor.close()
