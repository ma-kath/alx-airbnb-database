-- Indexes for User table (adding to existing idx_user_email)
CREATE INDEX idx_user_role ON User(role_id);

-- Indexes for Booking table (adding to existing indexes)
CREATE INDEX idx_booking_status ON Booking(status_id);
CREATE INDEX idx_booking_date_range ON Booking(start_date, end_date);
CREATE INDEX idx_booking_composite ON Booking(user_id, property_id);

-- Indexes for Property table (adding to existing idx_property_host)
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_composite ON Property(host_id, price_per_night);

-- Composite index for Review table (frequently joined with Property)
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Composite index for messages (frequently queried by timestamp)
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);

-- Sample query to analyze
EXPLAIN ANALYZE
SELECT p.*, u.first_name, u.last_name, AVG(r.rating) as avg_rating
FROM Property p
JOIN User u ON p.host_id = u.user_id
JOIN Review r ON p.property_id = r.property_id
WHERE p.price_per_night BETWEEN 50 AND 200
  AND p.location LIKE '%New York%'
GROUP BY p.property_id, u.first_name, u.last_name
ORDER BY avg_rating DESC
LIMIT 10;