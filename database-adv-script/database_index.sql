


-- Before Indexing
EXPLAIN ANALYZE 
select
	*
from
	booking
where
	user_id = 'u1'
	and start_date >= '2025-08-10';


-- Index for filtering/sorting on booking status
CREATE INDEX idx_booking_status ON booking(status);

-- Index to speed up queries filtering by start_date
CREATE INDEX idx_booking_start_date ON booking(start_date);

-- Index to improve queries using user_id + start_date (composite index)
CREATE INDEX idx_booking_user_start ON booking(user_id, start_date);

-- Index for filtering/sorting payments by method
CREATE INDEX idx_payment_method ON payment(payment_method);

-- Index for filtering/sorting payments by date
CREATE INDEX idx_payment_date ON payment(payment_date)



-- After Indexing
EXPLAIN ANALYZE 
select
	*
from
	booking
where
	user_id = 'u1'
	and start_date >= '2025-08-10';



-- Index for filtering/sorting on booking status
CREATE INDEX idx_booking_status ON booking(status);

-- Index to speed up queries filtering by start_date
CREATE INDEX idx_booking_start_date ON booking(start_date);

-- Index to improve queries using user_id + start_date (composite index)
CREATE INDEX idx_booking_user_start ON booking(user_id, start_date);

-- Index for filtering/sorting payments by method
CREATE INDEX idx_payment_method ON payment(payment_method);

-- Index for filtering/sorting payments by date
CREATE INDEX idx_payment_date ON payment(payment_date)