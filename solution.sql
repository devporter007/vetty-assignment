/* ========================================================================
   SQL Test Submission - MySQL
   Dataset Tables: transactions, items
   ========================================================================
   Assumptions:
   1) Refund exists only when refund_time IS NOT NULL.
   2) First order per store = earliest purchase_time for that store.
   3) Buyer first purchase = min(purchase_time) per buyer_id.
   4) Interval from purchase → refund measured in minutes.
   5) Timezone from dataset is UTC and consistent.
   ======================================================================== */


/* ===========================
   Q1. Purchases per Month 
   (Excluding refunded)
   =========================== */
SELECT 
    DATE_FORMAT(purchase_time, '%Y-%m') AS purchase_month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_time IS NULL
GROUP BY DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY purchase_month;


/* ===========================
   Q2. Stores with ≥ 5 Orders 
   in October 2020
   =========================== */
SELECT 
    store_id,
    COUNT(*) AS total_orders
FROM transactions
WHERE refund_time IS NULL
  AND YEAR(purchase_time) = 2020
  AND MONTH(purchase_time) = 10
GROUP BY store_id
HAVING COUNT(*) >= 5;


/* ===========================
   Q3. Shortest Interval (Minutes)
   Purchase → Refund per Store
   =========================== */
SELECT 
    store_id,
    MIN(TIMESTAMPDIFF(MINUTE, purchase_time, refund_time)) AS min_refund_time_minutes
FROM transactions
WHERE refund_time IS NOT NULL
GROUP BY store_id;


/* ===========================
   Q4. First Order Gross Value 
   per Store
   =========================== */
SELECT t.store_id, t.gross_transaction_value
FROM transactions t
JOIN (
    SELECT store_id, MIN(purchase_time) AS first_order_time
    FROM transactions
    GROUP BY store_id
) x ON t.store_id = x.store_id 
AND t.purchase_time = x.first_order_time;


/* ===========================
   Q5. Most Popular Item Ordered
   in Buyers' First Purchase
   =========================== */
SELECT i.item_name
FROM transactions t
JOIN (
    SELECT buyer_id, MIN(purchase_time) AS first_purchase_time
    FROM transactions
    GROUP BY buyer_id
) f ON t.buyer_id = f.buyer_id AND t.purchase_time = f.first_purchase_time
JOIN items i ON t.item_id = i.item_id
GROUP BY i.item_name
ORDER BY COUNT(*) DESC
LIMIT 1;


/* ===========================
   Q6. Refund Eligibility Flag 
   (Within 72 Hours of Purchase)
   =========================== */
SELECT 
    t.*,
    CASE 
        WHEN refund_time IS NOT NULL 
             AND TIMESTAMPDIFF(HOUR, purchase_time, refund_time) <= 72 
        THEN 1 ELSE 0 
    END AS refund_can_be_processed
FROM transactions t;


/* ===========================
   Q7. Second Purchase Per Buyer
   Ignoring Refunded Transactions
   =========================== */
WITH ranked AS (
    SELECT 
        t.*,
        ROW_NUMBER() OVER (
            PARTITION BY buyer_id 
            ORDER BY purchase_time
        ) AS rn
    FROM transactions t
    WHERE refund_time IS NULL
)
SELECT *
FROM ranked
WHERE rn = 2;


/* ===========================
   Q8. Second Transaction Time 
   per Buyer (without MIN/MAX)
   =========================== */
WITH ranked AS (
    SELECT 
        buyer_id,
        purchase_time,
        ROW_NUMBER() OVER (
            PARTITION BY buyer_id ORDER BY purchase_time
        ) AS rn
    FROM transactions
)
SELECT buyer_id, purchase_time AS second_transaction_time
FROM ranked
WHERE rn = 2;

