
-- a query to find the total number of bookings made by each user
select
	b.user_id ,
	count(*) as booking_count
from
	booking b
group by
	b.user_id;


--Rank properties based on the total number of bookings they have received.
WITH property_bookings AS (
    SELECT 
        p.property_id, 
        p.name, 
        COUNT(b.booking_id) AS booking_count
    FROM 
        property p
    LEFT JOIN 
        booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name
)
SELECT 
    property_id, 
    name, 
    booking_count,
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS row_num,
    RANK() OVER (ORDER BY booking_count DESC) AS `rank`
FROM 
    property_bookings
ORDER BY 
    booking_count DESC;
