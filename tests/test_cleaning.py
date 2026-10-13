import unittest

import pandas as pd

from src.cleaning.clean_ecommerce_data import clean_ecommerce_data


class CleanEcommerceDataTests(unittest.TestCase):
    def test_deduplicates_drops_invalid_timestamps_and_normalizes_text(self):
        source = pd.DataFrame(
            {
                "event_time": [
                    "2019-10-01 10:00:00 UTC",
                    "2019-10-01 10:00:00 UTC",
                    "invalid",
                ],
                "brand": ["  Acme ", "  Acme ", "Unused"],
                "category_code": [" Electronics.Audio ", " Electronics.Audio ", "other"],
                "event_type": [" PURCHASE ", " PURCHASE ", "view"],
            }
        )

        cleaned = clean_ecommerce_data(source)

        self.assertEqual(len(cleaned), 1)
        self.assertEqual(cleaned.iloc[0]["brand"], "acme")
        self.assertEqual(cleaned.iloc[0]["category_code"], "electronics.audio")
        self.assertEqual(cleaned.iloc[0]["event_type"], "purchase")
        self.assertTrue(pd.api.types.is_datetime64_any_dtype(cleaned["event_time"]))


if __name__ == "__main__":
    unittest.main()
