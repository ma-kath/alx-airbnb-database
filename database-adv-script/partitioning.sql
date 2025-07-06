-- 1. Create the partitioned table structure
CREATE TABLE Booking_Partitioned (
    booking_id UUID DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_booking_partitioned PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create partitions for different time periods
-- Historical data
CREATE TABLE booking_history PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2000-01-01') TO ('2020-01-01');

-- Recent years
CREATE TABLE booking_2020 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');
    
CREATE TABLE booking_2021 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');
    
CREATE TABLE booking_2022 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

-- Current year + future
CREATE TABLE booking_current PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2025-01-01');

-- Default partition for unknown dates
CREATE TABLE booking_future PARTITION OF Booking_Partitioned
    DEFAULT;

-- 3. Migrate data from original table
INSERT INTO Booking_Partitioned 
SELECT * FROM Booking;

-- 4. Create the same indexes on partitioned table
CREATE INDEX idx_booking_partitioned_user ON Booking_Partitioned(user_id);
CREATE INDEX idx_booking_partitioned_property ON Booking_Partitioned(property_id);
CREATE INDEX idx_booking_partitioned_dates ON Booking_Partitioned(start_date, end_date);
CREATE INDEX idx_booking_partitioned_status ON Booking_Partitioned(status_id);

-- 5. Replace original table (optional - in production you would schedule this during low traffic)
-- ALTER TABLE Booking RENAME TO Booking_Old;
-- ALTER TABLE Booking_Partitioned RENAME TO Booking;

-- Query Before Partitioning (Original Table)
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2022-06-01' AND '2022-08-31'
AND status_id = 2;

-- Query After Partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking_Partitioned
WHERE start_date BETWEEN '2022-06-01' AND '2022-08-31'
AND status_id = 2;