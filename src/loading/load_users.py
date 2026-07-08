def load_users(df, connection):
    """Load unique user records into the users table."""
    users_df = df[["user_id"]].copy()
    users_df = users_df.dropna(subset=["user_id"])
    users_df = users_df.drop_duplicates()

    user_records = list(
        users_df[["user_id"]].itertuples(
            index=False,
            name=None,
        )
    )

    insert_query = """
        INSERT INTO users (user_id)
        VALUES (%s)
    """

    cursor = connection.cursor()

    try:
        cursor.executemany(insert_query, user_records)
        connection.commit()
        print(f"{len(user_records)} users inserted.")
    except Exception as error:
        connection.rollback()
        raise RuntimeError(f"Error loading users: {error}")
    finally:
        cursor.close()
