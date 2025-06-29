# SQL Schema Definition for Airbnb Database

## Key Features of This Schema:

1. **Proper Data Types**:
   - UUIDs for primary keys
   - Appropriate VARCHAR lengths
   - DECIMAL for monetary values
   - TIMESTAMP for dates with time

2. **Constraints**:
   - Primary keys on all tables
   - Foreign key relationships
   - CHECK constraints for data validation
   - UNIQUE constraints where appropriate

3. **Indexes**:
   - Created on all foreign keys
   - Created on frequently queried columns
   - Composite indexes for common query patterns

4. **Normalization**:
   - Lookup tables for enumerations
   - No derived data stored
   - Proper relationship modeling

5. **Additional Features**:
   - Default values for timestamps
   - Automatic updates for modified timestamps
   - Prevention of invalid data through CHECK constraints

This schema provides a solid foundation for an Airbnb-like application with proper data integrity and performance characteristics.