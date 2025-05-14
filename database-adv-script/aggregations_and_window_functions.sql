
-- a query to find the total number of bookings made by each user
select
	b.user_id ,
	count(*) as booking_count
from
	booking b
group by
	b.user_id;