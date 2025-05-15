# Index Performance

## Query

```sql
-- Before Indexing
explain analyze 
select
	*
from
	booking
where
	user_id = 'u1'
	and start_date >= '2025-08-10';

-- Create Index
CREATE INDEX idx_booking_user_start ON booking(user_id, start_date);

-- After Indexing
explain analyze 
select
	*
from
	booking
where
	user_id = 'u1'
	and start_date >= '2025-08-10';
```

## Performance Analysis

**Without Index**
![without index](https://github.com/dagem12/alx-airbnb-database/blob/main/database-adv-script/before.png?raw=true)

**With Index**

![with index](https://github.com/dagem12/alx-airbnb-database/blob/main/database-adv-script/after.png?raw=true)