-- Find all properties where the average rating is greater than 4.0 using a subquery.
SELECT 
    p.property_id,
    p.name,
    p.description,
    p.location,
    p.price_per_night
FROM 
    Property p
WHERE 
    (SELECT AVG(r.rating)
     FROM Review r
     WHERE r.property_id = p.property_id) > 4.0;

-- A correlated subquery to find users who have made more than 3 bookings.
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    User u
WHERE 
    (SELECT COUNT(b.booking_id)
     FROM Booking b
     WHERE b.user_id = u.user_id) > 3;