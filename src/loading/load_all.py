import traceback
from pathlib import Path

import pandas as pd

if __package__:
    from .database import get_connection
    from .load_categories import load_categories
    from .load_events import load_events
    from .load_products import load_products
    from .load_users import load_users
else:
    from database import get_connection
    from load_categories import load_categories
    from load_events import load_events
    from load_products import load_products
    from load_users import load_users


BASE_DIR = Path(__file__).resolve().parents[2]


def main():
    """Run the full data loading pipeline."""
    connection = None

    try:
        df = pd.read_csv(BASE_DIR / "data/processed/ecommerce_cleaned.csv")
        connection = get_connection()

        load_categories(df, connection)
        load_products(df, connection)
        load_users(df, connection)
        load_events(df, connection)

        print("ETL pipeline completed successfully.")

    except Exception:
        traceback.print_exc()

    finally:
        if connection is not None:
            connection.close()


if __name__ == "__main__":
    main()