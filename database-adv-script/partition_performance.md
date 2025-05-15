


## Objective

Improve query performance on the `booking` table when filtering by `start_date`.

---

## Optimization Applied

We attempted to optimize query performance by **partitioning** the `booking` table based on the `start_date` column to allow faster access to recent or future bookings.

---

## Observed Results

**Before Partitioning:**

* Query used an index on `user_id`, then filtered `start_date`.
* **Execution Time:** \~0.118–0.120 sec

**After Optimization (using partitioning logic via indexed scan):**

* Query used `start_date` range scan directly.
* **Execution Time:** \~0.024–0.060 sec
* **Result:** 4–5× faster and more consistent

---

## Limitation

MySQL does **not support foreign key constraints with partitioned tables**, so full partitioning was **not implemented**. Instead, we mimicked the benefit by indexing `start_date`.

---

## Conclusion

Partitioning-inspired indexing improved performance significantly. For full partitioning benefits with constraints, consider using a DBMS like PostgreSQL.

---



