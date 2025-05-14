-- a non-correlated query to find all properties where the average rating is greater than 4.0 s
select
    *
from
    (
        select
            p.property_id as property_id,
            p.name as name,
            avg(rating) as Avg_rating
        from
            property p
            left join review r on r.property_id = p.property_id
        group by
            p.property_id,
            p.name
    ) as sub
where
    Avg_rating >= 4.0;

-- A correlated subquery to find all users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    (
        SELECT COUNT(*) 
        FROM booking b 
        WHERE b.user_id = u.user_id
    ) AS booking_count
FROM user u
WHERE 
    (
        SELECT COUNT(*) 
        FROM booking b 
        WHERE b.user_id = u.user_id
    ) > 3;


