def load_categories(df, connection):
    """Load unique product categories into the categories table."""
    categories_df = df[["category_id", "category_code"]].copy()
    categories_df = categories_df.dropna(subset=["category_id"])
    categories_df = categories_df.drop_duplicates()

    category_records = list(
        categories_df.itertuples(
            index=False,
            name=None,
        )
    )

    insert_query = """
        INSERT INTO categories (category_id, category_code)
        VALUES (%s, %s)
    """

    cursor = connection.cursor()
    try:
        

        cursor.executemany(insert_query, category_records)
        connection.commit()
        print(f"{len(category_records)} categories inserted.")
    except Exception as error:
        connection.rollback()
        raise RuntimeError(f"Error loading categories: {error}")
    finally:
        cursor.close()