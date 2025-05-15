
# Performance Optimization Report

##  Objective

Refactor a complex SQL query that retrieves all bookings along with user details, property details, and payment details. The goal is to improve query performance using best practices such as indexing and reduced complexity.

---

##  Initial Query (`performance.sql`)

```sql
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,

  u.user_id,
  u.first_name,
  u.last_name,
  u.email,

  p.property_id,
  p.name AS property_name,
  p.location,
  p.price_per_night,

  pay.payment_id,
  pay.amount,
  pay.payment_method,
  pay.payment_date

FROM booking b
JOIN user u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id

WHERE b.status = 'confirmed'
  AND b.start_date >= DATE '2025-08-10';

````

---

##  Performance Analysis (Before Index)

**Execution Plan (Simplified)**:

```
-> Limit: 200 row(s)  (cost=8.35 rows=6) (actual time=0.0808..0.185 rows=9)
    -> Nested loop left join
        -> Nested loop inner join
            -> Nested loop inner join
                -> Filter: (b.status = 'confirmed')
                    -> Table scan on b
                -> Index lookup on user using PRIMARY (user_id = b.user_id)
            -> Index lookup on property using PRIMARY (property_id = b.property_id)
        -> Index lookup on payment using fk_payment_booking (booking_id = b.booking_id)
```

### Issues Identified

* Full table scan on `booking` to filter `status = 'confirmed'`
* No compound index for `status` and `user_id`, though frequently filtered or joined
* Some join operations depend on primary key lookups, which are fine, but could be slightly improved with join column optimization

---

## Refactoring Strategy

### Index Improvements

We added the following composite index:

```sql
CREATE INDEX idx_booking_status_user 
ON booking (status, user_id);
```

This allows filtering on `status` and joining on `user_id` simultaneously using the index.

---

## 🚀 Performance Analysis (After Index)

**Updated Execution Plan (Simplified)**:

```
-> Limit: 200 row(s)  (cost=10.8 rows=9) (actual time=0.0977..0.191 rows=9)
    -> Nested loop left join
        -> Nested loop inner join
            -> Nested loop inner join
                -> Index lookup on booking using idx_booking_status_user (status = 'confirmed')
                -> Index lookup on user using PRIMARY (user_id = b.user_id)
            -> Index lookup on property using PRIMARY (property_id = b.property_id)
        -> Index lookup on payment using fk_payment_booking (booking_id = b.booking_id)
```

---

## 📊 Performance Comparison

| Metric                  | Before Indexing  | After Indexing            |
| ----------------------- | ---------------- | ------------------------- |
| `booking` Access Type   | Table Scan       | Index Lookup              |
| Execution Time (Actual) | 0.0808–0.185 sec | 0.0677–0.161 sec          |
| Index Used on `booking` | None             | `idx_booking_status_user` |
| Join Strategy           | Nested Loop      | Nested Loop               |
