-- Initial complex query joining multiple tables
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;

-- Analyse the performance of the above query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;


-- Refactored optimized query
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    Booking b
INNER JOIN                   -- Changed to INNER JOIN since all bookings need users/properties
    Property p ON b.property_id = p.property_id
INNER JOIN 
    User u ON b.user_id = u.user_id
LEFT JOIN                    -- Keep as LEFT JOIN since payments might not exist yet
    (SELECT 
        payment_id, 
        booking_id, 
        amount, 
        payment_date 
     FROM Payment 
     ORDER BY payment_date DESC 
     LIMIT 1
    ) pay ON b.booking_id = pay.booking_id
WHERE                        -- Added useful filters
    b.start_date > CURRENT_DATE - INTERVAL '6 months'
ORDER BY 
    b.start_date DESC
LIMIT 100;                   -- Added reasonable limit for UI display