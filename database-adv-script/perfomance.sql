EXPLAIN
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
