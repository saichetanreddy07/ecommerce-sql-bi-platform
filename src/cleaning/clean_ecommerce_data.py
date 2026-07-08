from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[2]

INPUT_FILE_PATH = BASE_DIR / "data/processed/ecommerce_sample.csv"
OUTPUT_FILE_PATH = BASE_DIR / "data/processed/ecommerce_cleaned.csv"

TEXT_COLUMNS = ["brand", "category_code", "event_type"]


def load_sample_data():
    """Load the sampled ecommerce dataset."""
    print(f"Loading data from: {INPUT_FILE_PATH}")
    return pd.read_csv(INPUT_FILE_PATH)


def clean_text_columns(data):
    """Clean spacing and casing for selected text columns."""
    for column in TEXT_COLUMNS:
        if column not in data.columns:
            print(f"Skipping missing text column: {column}")
            continue

        data[column] = data[column].astype("string")
        data[column] = data[column].str.strip().str.lower()

    return data


def clean_ecommerce_data(data):
    """Apply the main cleaning rules to the ecommerce dataset."""
    print(f"Original rows: {len(data):,}")

    print("Removing duplicate rows...")
    data = data.drop_duplicates().copy()
    print(f"Rows after removing duplicates: {len(data):,}")

    print("Cleaning event timestamps...")
    data["event_time"] = pd.to_datetime(data["event_time"], errors="coerce")
    data = data.dropna(subset=["event_time"]).copy()

    # Missing brand and category_code values are kept for later analysis.
    print("Cleaning text columns...")
    data = clean_text_columns(data)

    return data


def save_cleaned_data(data):
    """Save the cleaned ecommerce dataset."""
    OUTPUT_FILE_PATH.parent.mkdir(parents=True, exist_ok=True)
    data.to_csv(OUTPUT_FILE_PATH, index=False)

    print(f"Cleaned data saved to: {OUTPUT_FILE_PATH}")
    print(f"Final cleaned rows: {len(data):,}")


def main():
    """Run the ecommerce data cleaning process."""
    sample_data = load_sample_data()
    cleaned_data = clean_ecommerce_data(sample_data)
    save_cleaned_data(cleaned_data)


if __name__ == "__main__":
    main()
