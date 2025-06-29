# Database Normalization Analysis for Airbnb Schema

## Current Schema Evaluation (Before Normalization)

The initial schema contains six tables:
- User
- Property
- Booking
- Payment
- Review
- Message

Let's evaluate each table for normalization compliance.

## First Normal Form (1NF) Compliance

All tables satisfy 1NF requirements:
- Each table has a primary key
- Each attribute contains atomic values
- No repeating groups exist 

✔ All tables already comply with 1NF

## Second Normal Form (2NF) Compliance

2NF requires:
- 1NF compliance
- No partial dependencies on composite primary keys

Analysis:
- No tables have composite primary keys
- All non-key attributes fully depend on the primary key

✔ All tables already comply with 2NF

## Third Normal Form (3NF) Compliance

3NF requires:
- 2NF compliance
- No transitive dependencies (non-key attributes shouldn't depend on other non-key attributes)

Potential issues identified:

### 1. Property Table (Potential Optimization)
- `total_price` in Booking appears to be derivable from:
  - `pricepernight` in Property
  - `start_date` and `end_date` in Booking

### 2. User Roles ENUM
- Role is implemented as an ENUM which limits flexibility
- Better to normalize into separate table

## Normalization Improvements

These are the recommended changes to achieve better 3NF compliance:

### 1. Derived Data Optimization (Booking Table)

Rather than storing `total_price` which depends on:
- Property's `pricepernight`
- Booking's date range (`end_date` - `start_date` + 1)

**Solution**: 
- Remove `total_price` from Booking table
- Calculate it at query time or application level
- Alternatively create view for bookings with calculated totals

### 2. User Roles Normalization

Current:
- Role stored as ENUM in User table
- Limits flexible role management

**Solution**:
1. Create new `Role` lookup table:
   ```sql
   CREATE TABLE Role (
     role_id INT PRIMARY KEY,
     role_name VARCHAR(50) NOT NULL UNIQUE
   );
   
   INSERT INTO Role VALUES 
   (1, 'guest'), (2, 'host'), (3, 'admin');
   ```

2. Modify User table:
   - Replace `role` ENUM with `role_id` INT foreign key
   - Add foreign key constraint to Role table

### 3. Payment Method Normalization

Current:
- `payment_method` stored as ENUM

**Solution**:
1. Create new `PaymentMethod` table:
   ```sql
   CREATE TABLE PaymentMethod (
     method_id INT PRIMARY KEY,
     method_name VARCHAR(50) NOT NULL UNIQUE
   );
   
   INSERT INTO PaymentMethod VALUES
   (1, 'credit_card'), (2, 'paypal'), (3, 'stripe');
   ```

2. Modify Payment table:
   - Replace `payment_method` ENUM with `method_id` INT foreign key

## Final Normalized Schema

```
User
- user_id (PK)
- first_name
- last_name
- email
- password_hash
- phone_number
- role_id (FK to Role)
- created_at

Role
- role_id (PK)
- role_name

Property
- property_id (PK)
- host_id (FK to User)
- name
- description
- location
- pricepernight
- created_at
- updated_at

Booking
- booking_id (PK)
- property_id (FK to Property)
- user_id (FK to User)
- start_date
- end_date
- status
- created_at

Payment
- payment_id (PK)
- booking_id (FK to Booking)
- amount
- payment_date
- method_id (FK to PaymentMethod)

PaymentMethod
- method_id (PK)
- method_name

Review
- review_id (PK)
- property_id (FK to Property)
- user_id (FK to User)
- rating
- comment
- created_at

Message
- message_id (PK)
- sender_id (FK to User)
- recipient_id (FK to User)
- message_body
- sent_at
```

## Benefits of Normalization

1. **Reduced redundancy**:
   - No derived data is stored
   - Lookup values are properly normalized

2. **Improved flexibility**:
   - Easier to add new roles/payment methods
   - No schema changes required for new types

3. **Data integrity**:
   - Explicit relationships via foreign keys
   - Valid values enforced by lookup tables

4. **Scalability**:
   - Better prepared for future business logic changes
   - More efficient storage of repeated values 

## Trade-offs

1. **Performance considerations**:
   - More joins required for some queries
   - Application must calculate derived values

2. **Complexity**:
   - Additional tables to manage
   - Additional foreign key relationships  

However, these are generally worth the benefits for an OLTP database system.