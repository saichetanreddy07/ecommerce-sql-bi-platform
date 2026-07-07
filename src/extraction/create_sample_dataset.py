from pathlib import Path

import pandas as pd


RAW_FILE_PATH = Path("data/raw/2019-Oct.csv")
OUTPUT_FILE_PATH = Path("data/processed/ecommerce_sample.csv")

CHUNK_SIZE = 100_000
ROWS_PER_DAY = 10_000
RANDOM_STATE = 42


def read_and_prepare_chunk(chunk):
    """Convert timestamps and add an event date column."""
    chunk["event_time"] = pd.to_datetime(chunk["event_time"], errors="coerce")
    chunk = chunk.dropna(subset=["event_time"])

    chunk["event_date"] = chunk["event_time"].dt.date

    return chunk


def update_daily_samples(daily_samples, chunk):
    """Update the stored sample for each event date in a chunk."""
    for event_date, daily_rows in chunk.groupby("event_date"):
        if event_date in daily_samples:
            combined_rows = pd.concat(
                [daily_samples[event_date], daily_rows],
                ignore_index=True,
            )
        else:
            combined_rows = daily_rows

        sample_size = min(ROWS_PER_DAY, len(combined_rows))

        # Keep each date capped so memory usage stays predictable.
        daily_samples[event_date] = combined_rows.sample(
            n=sample_size,
            random_state=RANDOM_STATE,
        )

    return daily_samples


def create_sample_dataset():
    """Create a smaller sampled dataset from the raw ecommerce CSV."""
    daily_samples = {}

    print("Starting sample dataset creation...")
    print(f"Reading raw data from: {RAW_FILE_PATH}")

    # Read the large CSV in chunks instead of loading the full file.
    for chunk_number, chunk in enumerate(
        pd.read_csv(RAW_FILE_PATH, chunksize=CHUNK_SIZE),
        start=1,
    ):
        print(f"Processing chunk {chunk_number}...")

        prepared_chunk = read_and_prepare_chunk(chunk)
        daily_samples = update_daily_samples(daily_samples, prepared_chunk)

    if not daily_samples:
        print("No valid rows found. Sample dataset was not created.")
        return

    print("Combining daily samples...")

    sampled_data = pd.concat(
        [daily_samples[event_date] for event_date in sorted(daily_samples)],
        ignore_index=True,
    )

    OUTPUT_FILE_PATH.parent.mkdir(parents=True, exist_ok=True)
    sampled_data.to_csv(OUTPUT_FILE_PATH, index=False)

    print(f"Sample dataset saved to: {OUTPUT_FILE_PATH}")
    print(f"Total sampled rows: {len(sampled_data):,}")


if __name__ == "__main__":
    create_sample_dataset()
