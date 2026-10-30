import pandas as pd


def load_events(df, connection):
    """Load valid event records into the events table."""
    event_columns = [
        "event_time",
        "event_date",
        "event_type",
        "price",
        "user_session",
        "product_id",
        "user_id",
    ]

    events_df = df[event_columns].copy()
    events_df = events_df.dropna(subset=event_columns)
    events_df["event_time"] = pd.to_datetime(
        events_df["event_time"], utc=True
    ).dt.tz_localize(None)

    event_records = list(
        events_df[event_columns].itertuples(
            index=False,
            name=None,
        )
    )

    insert_query = """
        INSERT INTO events (
            event_time,
            event_date,
            event_type,
            price,
            user_session,
            product_id,
            user_id
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """

    cursor = connection.cursor()

    try:
        for start in range(0, len(event_records), 5000):
            cursor.executemany(insert_query, event_records[start:start + 5000])
        connection.commit()
        print(f"{len(event_records)} events inserted.")
    except Exception as error:
        connection.rollback()
        raise RuntimeError(f"Error loading events: {error}")
    finally:
        cursor.close()
