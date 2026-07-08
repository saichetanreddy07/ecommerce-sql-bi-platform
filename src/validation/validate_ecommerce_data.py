from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[2]

INPUT_FILE_PATH = BASE_DIR / "data/processed/ecommerce_cleaned.csv"
REPORT_FILE_PATH = BASE_DIR / "data/validation/validation_report.txt"


def load_cleaned_data():
    """Load the cleaned ecommerce dataset."""
    print(f"Loading cleaned data from: {INPUT_FILE_PATH}")
    return pd.read_csv(INPUT_FILE_PATH)


def build_validation_report(data):
    """Create a validation report for the ecommerce dataset."""
    report_lines = []

    report_lines.append("Ecommerce Data Validation Report")
    report_lines.append("=" * 35)
    report_lines.append("")

    report_lines.append("Dataset Shape")
    report_lines.append(f"Total rows: {len(data):,}")
    report_lines.append(f"Total columns: {len(data.columns):,}")
    report_lines.append("")

    report_lines.append("Missing Values by Column")
    missing_values = data.isna().sum()
    for column, missing_count in missing_values.items():
        report_lines.append(f"{column}: {missing_count:,}")
    report_lines.append("")

    report_lines.append("Duplicate Rows")
    duplicate_count = data.duplicated().sum()
    report_lines.append(f"Duplicate rows found: {duplicate_count:,}")
    report_lines.append("")

    report_lines.append("Column Data Types")
    for column, data_type in data.dtypes.items():
        report_lines.append(f"{column}: {data_type}")
    report_lines.append("")

    report_lines.append("Unique Event Types")
    event_types = sorted(data["event_type"].dropna().unique())
    for event_type in event_types:
        report_lines.append(str(event_type))
    report_lines.append("")

    report_lines.append("Records by Event Date")
    records_by_date = data["event_date"].value_counts().sort_index()
    for event_date, record_count in records_by_date.items():
        report_lines.append(f"{event_date}: {record_count:,}")
    report_lines.append("")

    report_lines.append("Negative Price Check")
    negative_price_count = (data["price"] < 0).sum()
    report_lines.append(f"Rows with negative prices: {negative_price_count:,}")

    return "\n".join(report_lines)


def save_validation_report(report):
    """Save the validation report as a text file."""
    REPORT_FILE_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_FILE_PATH.write_text(report, encoding="utf-8")

    print(f"Validation report saved to: {REPORT_FILE_PATH}")


def main():
    """Run validation checks for the cleaned ecommerce dataset."""
    cleaned_data = load_cleaned_data()
    validation_report = build_validation_report(cleaned_data)
    save_validation_report(validation_report)


if __name__ == "__main__":
    main()
