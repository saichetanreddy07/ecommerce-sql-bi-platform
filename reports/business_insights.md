# Business Insights Report

## Executive Summary

The October 2019 sample contains 309,967 cleaned interaction events and 4,051 purchase events, generating $1,486,209.46 in sampled purchase-event revenue. The strongest visible commercial signal is concentration: electronics.smartphone accounts for 73.38% of sampled revenue and Apple for 60.33%. The dataset also has important analytical limitations: extraction caps each date at 10,000 events, category codes are missing on 32.76% of rows, and the dashboard's funnel page labels a 3.56K value as purchase events even though the included data has 4,051 purchase events and 3,558 unique purchasing customers.

These results are descriptive of the included sample, not estimates of total October sales or true customer/session conversion. Recommendations prioritize data completeness, consistent metric definitions, and validation against the full source.

## Analysis Basis and Limitations

- The calculations below were reproduced from `data/processed/ecommerce_cleaned.csv` (309,967 rows, 10 columns). Purchase revenue includes rows where `event_type = 'purchase'`.
- The sample is capped at 10,000 records per event date. Daily counts are all approximately 10,000, so sample revenue by day cannot be used to rank actual store demand.
- The CSV contains event and session identifiers, but the current SQL funnel queries calculate event-count ratios rather than a session-cohort journey. Such ratios are not customer conversion or cart-abandonment rates.
- The SQL files define analytical questions; query-result exports are not included. Where a dashboard label conflicts with the CSV, the discrepancy is called out rather than blended into the calculations.

## Revenue Analysis

### Insight 1: The sample records $1.486M from 4,051 purchase events

**Observation:** Purchase rows total $1,486,209.46, with a mean event price of $366.87.

**Business impact:** This is a useful baseline for checking dashboard calculations and validating the ETL, but it is not full-month revenue because the source was sampled.

**Recommendation:** Label revenue as sample-level in portfolio materials and reconcile it against a full-data run before using it for operating or financial decisions.

### Insight 2: The purchase-price distribution is right-skewed

**Observation:** Median purchase-event price is $198.18, materially below the $366.87 mean.

**Business impact:** A relatively small number of high-value transactions lift the average; average purchase value alone does not describe a typical event.

**Recommendation:** Show median and percentile bands alongside the mean, and segment ticket size by category and product before setting price or promotion targets.

### Insight 3: Electronics smartphones dominate category revenue

**Observation:** `electronics.smartphone` generated $1,090,531.63, or 73.38% of purchase-event revenue in the sample.

**Business impact:** Results and dashboard totals are highly sensitive to smartphone demand, assortment, and the availability of a small number of high-value devices.

**Recommendation:** Protect availability for leading smartphone products while testing cross-sell and acquisition opportunities in categories outside smartphones; compare contribution margin as well as revenue.

### Insight 4: Sampled daily revenue varies, but daily ranking is not decision-grade

**Observation:** Sample purchase revenue is highest on October 13 ($69,233.58) and lowest on October 7 ($34,893.50).

**Business impact:** These amounts come from daily samples capped near 10,000 records, not each day's complete event population. The apparent difference cannot establish a real demand spike or decline.

**Recommendation:** Re-run the daily trend over the complete source data or use a representative weighted sample before scheduling campaigns or staffing from daily patterns.

## Customer Analysis

### Insight 5: 3,558 of 139,048 observed customers made a purchase

**Observation:** There are 139,048 distinct customer IDs across the sample and 3,558 distinct IDs on purchase events (2.56% of observed IDs).

**Business impact:** The comparison describes this event sample only; it is not a site-visitor conversion rate because the extract is capped and does not define eligible visits or customer cohorts.

**Recommendation:** Build a session- or customer-cohort metric with explicit eligibility, time window, and numerator/denominator definitions before presenting customer conversion.

### Insight 6: Most purchasing customers have one purchase event in the sample

**Observation:** The median is one purchase event per purchasing customer. 361 customers have more than one purchase event, equal to 10.15% of the 3,558 purchasing customers.

**Business impact:** Repeat purchasing exists but is not the typical observed behavior in this sample; retention programs may have room to grow, subject to full-data confirmation.

**Recommendation:** Measure repeat purchase by customer over defined 30-, 60-, and 90-day cohorts, then test replenishment, loyalty, or cross-category follow-up against a holdout group.

### Insight 7: The leading spenders have multiple purchase events

**Observation:** The highest-spend customer in the sample contributes $9,765.25 across six purchase events; the customer with the most purchase events has eight and spends $7,562.15.

**Business impact:** Purchase frequency and monetary value identify different high-value behaviors; a single ranking can miss frequent moderate spenders or infrequent high-ticket buyers.

**Recommendation:** Segment customers using both frequency and monetary value, and evaluate whether service or retention treatment improves incremental value.

## Product Performance

### Insight 8: Revenue is concentrated among a small set of leading products

**Observation:** Product `1005115` generated $116,910.23 in sampled purchase revenue, followed by product `1005105` at $79,896.78.

**Business impact:** Stockouts or pricing changes for leading products can materially affect the observed product revenue ranking, while a revenue-only view does not reveal margin or inventory risk.

**Recommendation:** Pair product revenue with margin, stock availability, returns, and view-to-purchase performance before making assortment decisions.

### Insight 9: Product coverage is broad, but product count is not demand

**Observation:** The cleaned sample contains 52,823 distinct product IDs, while a handful of products lead purchase revenue.

**Business impact:** Catalog breadth creates a long tail that can dilute merchandising attention; catalog presence alone does not demonstrate customer demand.

**Recommendation:** Use a product scorecard that separates active catalog coverage, traffic, purchases, revenue, and profitability, and review low-traffic products for discoverability issues.

## Category Performance

### Insight 10: Category identifiers and category labels have different coverage

**Observation:** The sample has 602 distinct `category_id` values but 126 distinct non-null `category_code` values.

**Business impact:** A dashboard grouped by category code will not represent the same dimension cardinality as the category table's IDs; comparing these counts without explaining their meaning can misstate catalog coverage.

**Recommendation:** Maintain a documented category dimension mapping IDs to labels, and report both labeled and unlabeled categories explicitly.

### Insight 11: Missing category labels conceal meaningful revenue

**Observation:** `category_code` is missing on 101,542 event rows (32.76%). Purchase rows with a missing category code contribute $128,478.61, or 8.64% of sample revenue.

**Business impact:** Category reports under-attribute over one-tenth of purchase revenue if nulls are dropped, weakening category comparisons and merchandising decisions.

**Recommendation:** Trace missing codes to source quality or mapping gaps, preserve an explicit `Unknown` bucket, and monitor category-code coverage as a pipeline quality metric.

## Brand Performance

### Insight 12: Apple leads sampled brand revenue

**Observation:** Apple accounts for $896,572.41, or 60.33% of sample purchase revenue. Samsung contributes $220,407.79, or 14.83%.

**Business impact:** The dashboard's brand ranking is dominated by Apple, making total performance sensitive to one brand's product mix and price points.

**Recommendation:** Review revenue, margin, inventory, and promotion dependency by brand; treat expansion beyond the leader as a portfolio-risk question rather than a revenue-only target.

### Insight 13: The top two named brands account for three-quarters of revenue

**Observation:** Apple and Samsung together represent 75.16% of sample purchase-event revenue.

**Business impact:** High brand concentration can create supplier, assortment, and promotional exposure, although the sample cannot establish the full-month share.

**Recommendation:** Track concentration over complete periods and evaluate complementary brands using margin and conversion evidence before changing assortment allocation.

### Insight 14: Missing brand values weaken brand attribution

**Observation:** Brand is missing on 45,841 event rows (14.79%). Purchase events in the missing-brand group contribute $42,841.32.

**Business impact:** Brand totals omit or understate an identifiable part of activity, and product/brand comparisons may be biased if missingness is not random.

**Recommendation:** Keep missing brand as an explicit category, investigate source coverage by product/category, and avoid silently excluding it from dashboard totals.

## Customer Purchase Behaviour

### Insight 15: Views dominate the sampled event mix

**Observation:** The dataset has 301,166 views, 4,750 cart events, and 4,051 purchase events; views make up 97.16% of all 309,967 events.

**Business impact:** The interaction table is primarily a browsing signal. Event volume should not be interpreted as distinct customers or qualified shopping sessions.

**Recommendation:** Report unique users and sessions beside raw event counts, and define funnel stages at a consistent grain.

## Sales Funnel Analysis

The sampled funnel contains 301,166 view events, 4,750 cart events, and 4,051 purchase events. These are event counts and need session-level linkage before they can describe customer journeys.

## Conversion Analysis

### Insight 16: The purchase-to-view event ratio is 1.345%

**Observation:** Purchase events divided by view events gives 4,051 / 301,166 = 1.345%, which rounds to the 1.35% shown on dashboard pages.

**Business impact:** This is an event-count ratio, not a conventional conversion rate: one customer or session can contribute multiple views and purchases, and the two event populations are not cohort-matched.

**Recommendation:** Rename the current KPI to `purchase events per view event` or replace it with a session-based funnel using a defined attribution window and deduplicated stage transitions.

### Insight 17: Cart and purchase event totals do not calculate cart abandonment

**Observation:** The sample has 4,750 cart events and 4,051 purchase events. Their simple event-count ratio is 85.28%, but these counts are not joined by session, product, or time window.

**Business impact:** Subtracting purchase events from cart events cannot identify abandoned carts; purchases may occur without a sampled cart event, and one session can emit repeated events.

**Recommendation:** Link cart and purchase events by `user_session` and product within a documented time window, deduplicate stage transitions, and only then publish an abandonment rate.

### Insight 18: The funnel page's purchase label conflicts with the source counts

**Observation:** The executive page shows about 4.05K total purchases and 3.56K purchasing customers, consistent with 4,051 purchase events and 3,558 purchasing customer IDs in the CSV. The funnel page labels a 3.56K card as `Total Purchase Events`.

**Business impact:** Stakeholders can confuse unique purchasers with purchase events, changing the apparent funnel size and undermining confidence in the report.

**Recommendation:** Bind the funnel card to the purchase-event measure or relabel it as purchasing customers, then reconcile card, funnel, and SQL definitions before publishing.

## Key Business Findings

- Sample revenue and leading category/brand rankings are strongly concentrated; use them as hypotheses to test against the full source, not as enterprise-wide benchmarks.
- Event-based conversion and cart ratios are not journey conversion or cart abandonment without session-level linkage.
- Missing category and brand values are material and should remain visible in all reporting.
- The dashboard needs consistent KPI names and definitions across pages.

## Actionable Recommendations

1. Reconcile Power BI purchase-event and purchasing-customer measures against the CSV and SQL definitions.
2. Build session-based funnel tables or queries using `user_session`, product, and a documented attribution window.
3. Preserve unknown category and brand values and add coverage thresholds to data validation.
4. Re-run revenue and daily-trend analysis on the complete source or a statistically weighted sample.
5. Extend product and customer scorecards with margin, inventory, repeat cohorts, and unique session measures.

## Future Improvements

- Replace diagnostic-only data profiling with explicit assertions for required columns, allowed event types, timestamp validity, and referential integrity.
- Make database loads idempotent and transactional, and add MySQL integration tests.
- Publish reproducible query outputs alongside the dashboard definitions.
- Add incremental ingestion, orchestration, and data-quality monitoring for production-scale data.
