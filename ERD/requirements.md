# Database Specification - AirBnB
## Entities and Attributes
1. User
user_id: Primary Key, UUID, Indexed
first_name: VARCHAR, NOT NULL
last_name: VARCHAR, NOT NULL
email: VARCHAR, UNIQUE, NOT NULL
password_hash: VARCHAR, NOT NULL
phone_number: VARCHAR, NULL
role: ENUM (guest, host, admin), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
2. Property
property_id: Primary Key, UUID, Indexed
host_id: Foreign Key, references User(user_id)
name: VARCHAR, NOT NULL
description: TEXT, NOT NULL
location: VARCHAR, NOT NULL
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
3. Booking
booking_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
start_date: DATE, NOT NULL
end_date: DATE, NOT NULL
total_price: DECIMAL, NOT NULL
status: ENUM (pending, confirmed, canceled), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
4. Payment
payment_id: Primary Key, UUID, Indexed
booking_id: Foreign Key, references Booking(booking_id)
amount: DECIMAL, NOT NULL
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL
5. Review
review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
6. Message
message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Constraints
1. User Table
Unique constraint on email.
Non-null constraints on required fields.
2. Property Table
Foreign key constraint on host_id.
Non-null constraints on essential attributes.
3. Booking Table
Foreign key constraints on property_id and user_id.
status must be one of pending, confirmed, or canceled.
4. Payment Table
Foreign key constraint on booking_id, ensuring payment is linked to valid bookings.
5. Review Table
Constraints on rating values (1-5).
Foreign key constraints on property_id and user_id.
6. Message Table
Foreign key constraints on sender_id and recipient_id.

## Relationships
* User to Property: One-to-Many (A user can host multiple properties)
* User to Booking: One-to-Many (A user can make multiple bookings)
* Property to Booking: One-to-Many (A property can have multiple bookings)
* Booking to Payment: One-to-One (A booking can have one payment)
* Property to Review: One-to-Many (A property can have multiple reviews)
* User to Review: One-to-Many (A user can write multiple reviews)
* User to Message: One-to-Many (A user can send and receive multiple messages)

## Indexing
1. **Primary Keys:** Indexed automatically.
2. **Additional Indexes:**
* email in the User table.
* property_id in the Property and Booking tables.
* booking_id in the Booking and Payment tables.