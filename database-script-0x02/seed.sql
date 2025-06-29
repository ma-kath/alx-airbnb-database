-- Insert sample users with 3-digit IDs
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role_id) VALUES
-- Admins
('100', 'Admin', 'System', 'admin@airbnb.com', '$2a$10$randomhash', '+1234567890', 3),

-- Hosts
('200', 'Sarah', 'Johnson', 'sarah@example.com', '$2a$10$randomhash', '+1555123456', 2),
('201', 'Michael', 'Chen', 'michael@example.com', '$2a$10$randomhash', '+1555234567', 2),
('202', 'Emma', 'Williams', 'emma@example.com', '$2a$10$randomhash', '+1555345678', 2),

-- Guests
('300', 'David', 'Brown', 'david@example.com', '$2a$10$randomhash', '+1555456789', 1),
('301', 'Lisa', 'Garcia', 'lisa@example.com', '$2a$10$randomhash', '+1555567890', 1),
('302', 'James', 'Wilson', 'james@example.com', '$2a$10$randomhash', '+1555678901', 1),
('303', 'Sophia', 'Martinez', 'sophia@example.com', '$2a$10$randomhash', '+1555789012', 1);

-- Insert sample properties with 5-character IDs
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night) VALUES
-- Sarah's properties
('A1000', '200', 
 'Cozy Downtown Apartment', 
 'Modern 1-bedroom apartment in the heart of the city with great views', 
 'New York, NY', 120.00),
('A1001', '200', 
 'Lakeside Cabin', 
 'Rustic cabin with private lake access and mountain views', 
 'Lake Tahoe, CA', 195.00),

-- Michael's properties
('B2000', '201', 
 'Beachfront Villa', 
 'Luxury 3-bedroom villa with private beach access', 
 'Miami, FL', 350.00),
('B2001', '201', 
 'City Loft', 
 'Industrial-style loft in arts district with rooftop terrace', 
 'Chicago, IL', 175.00),

-- Emma's properties
('C3000', '202', 
 'Mountain Retreat', 
 'Secluded cabin with hot tub and hiking trails', 
 'Aspen, CO', 225.00),
('C3001', '202', 
 'Historic Townhouse', 
 'Beautifully restored 19th century townhouse', 
 'Boston, MA', 210.00);

-- Insert sample bookings with 5-character IDs
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status_id) VALUES
-- David's bookings
('BK100', 'A1000', '300', '2023-06-15', '2023-06-20', 2), -- Confirmed
('BK101', 'C3000', '300', '2023-07-10', '2023-07-17', 2), -- Confirmed

-- Lisa's bookings
('BK200', 'B2000', '301', '2023-08-05', '2023-08-12', 1), -- Pending
('BK201', 'A1001', '301', '2023-09-01', '2023-09-07', 2), -- Confirmed

-- James' booking
('BK300', 'B2001', '302', '2023-10-15', '2023-10-20', 3), -- Canceled

-- Sophia's booking
('BK400', 'C3001', '303', '2023-11-20', '2023-11-27', 2); -- Confirmed

-- Insert sample payments with 5-character IDs
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, method_id, transaction_reference) VALUES
('PA100', 'BK100', 600.00, '2023-06-01 10:30:00', 1, 'CC123456789'),
('PA101', 'BK101', 1575.00, '2023-06-25 14:15:00', 2, 'PP987654321'),
('PA201', 'BK201', 1170.00, '2023-08-15 09:45:00', 1, 'CC987654321'),
('PA400', 'BK400', 1470.00, '2023-10-30 16:20:00', 3, 'ST123456789');

-- Insert sample reviews with 5-character IDs
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('RV100', 'A1000', '300', 5, 'Perfect location and amazing views!'),
('RV101', 'C3000', '300', 4, 'Beautiful cabin, but the wifi was spotty'),
('RV201', 'A1001', '301', 5, 'Absolutely loved the lake access!'),
('RV400', 'C3001', '303', 5, 'Gorgeous historic home with modern amenities');

-- Insert sample messages with 5-character IDs
INSERT INTO Message (sender_id, recipient_id, message_body, sent_at, is_read) VALUES
('300', '200', 'Hi Sarah, is the apartment available for early check-in?', '2023-06-10 08:30:00', TRUE),
('200', '300', 'Yes David, we can arrange for 1pm check-in', '2023-06-10 09:15:00', TRUE),
('301', '201', 'What beach amenities are included with the villa?', '2023-07-20 11:45:00', FALSE),
('303', '202', 'Do you provide parking with the townhouse?', '2023-10-15 16:20:00', TRUE),
('202', '303', 'Yes Sophia, we have a dedicated parking spot', '2023-10-15 17:05:00', FALSE);