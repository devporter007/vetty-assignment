# SQL Test Submission (MySQL)

This repository contains a **single consolidated SQL script** (`solution.sql`) that includes all eight query solutions requested in the assessment.

## Contents

| File | Description |
|------|-------------|
| `solution.sql` | Contains answers to Q1–Q8 clearly separated and documented |

Each query is labeled and commented so reviewers can execute and evaluate individually.

---

## Assumptions

The following assumptions are documented inside the `.sql` file as required:

1. Refund is only considered valid when `refund_time IS NOT NULL`.
2. First order per store is based on the earliest `purchase_time`.
3. Refund eligibility (Q6) is determined by a 72-hour (3-day) window.
4. First purchase per buyer is based on minimum timestamp.
5. All timestamps are in UTC and clean.

---

## Execution

This script can be executed as a whole, or reviewers may run individual question blocks:

```sql
SOURCE solution.sql;
