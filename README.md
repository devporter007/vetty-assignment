# SQL Test Submission (MySQL)

This repository contains a **single consolidated SQL script** (`solution.sql`) that includes all eight SQL query solutions requested in the assessment.  
Each screenshot (`qX.png`) demonstrates the **executed query output** on a sample dataset.

---

## Repository Contents

| File | Description |
|------|-------------|
| `solution.sql` | Full executable SQL script with dataset + Q1–Q8 answers |
| `q1.png` | Output of Query 1 |
| `q2.png` | Output of Query 2 |
| `q3.png` | Output of Query 3 |
| `q4.png` | Output of Query 4 |
| `q5.png` | Output of Query 5 |
| `q6.png` | Output of Query 6 |
| `q7.png` | Output of Query 7 |
| `q8.png` | Output of Query 8 |
| `README.md` | This documentation |

Each query in `solution.sql` is labeled and commented so reviewers can execute or inspect them independently.

---

## Assumptions

The following assumptions (as requested in the assignment brief) are included inside the SQL file:

1. A purchase is considered refunded only if `refund_time IS NOT NULL`.
2. First order per store is determined using earliest `purchase_time`.
3. Refund eligibility (Q6) is valid when refund occurs within **72 hours** of purchase.
4. First purchase per buyer determined by earliest timestamp.
5. All timestamps are assumed to be in UTC and consistent.

---

## How to Execute

You can run the full solution at once:

```sql
SOURCE solution.sql;
