# Key Highlights
1. Defining Relationships with ER Diagrams
Learners start by creating an Entity-Relationship (ER) diagram, modeling relationships and dependencies between users, bookings, properties, and reviews in the Airbnb schema.

2. Complex Queries with Joins
Gain expertise in SQL joins with tasks that require combining multiple tables to extract meaningful insights. Learners explore INNER JOIN, LEFT JOIN, and FULL OUTER JOIN for various scenarios.

3. Power of Subqueries
Develop proficiency with both correlated and non-correlated subqueries. Learn how to nest queries for advanced data analysis, such as calculating average ratings or filtering users based on activity thresholds.

4. Aggregations and Window Functions
Unlock analytical capabilities using SQL aggregation functions like COUNT and SUM. Dive into advanced window functions like ROW_NUMBER and RANK to rank and analyze data sets.

5. Indexing for Optimization
Learners identify performance bottlenecks and write SQL commands to create indexes for frequently queried columns. They analyze the impact of these changes on query execution times.

6. Query Optimization Techniques
Write and analyze complex queries for retrieving detailed information about bookings, properties, users, and payments. Refactor queries to improve execution times by reducing redundancies and leveraging indexing.

7. Partitioning Large Tables
Address performance challenges with large datasets by implementing table partitioning. Focus on partitioning the Booking table to improve queries on date ranges and compare performance before and after partitioning.

8. Performance Monitoring and Schema Refinement
Learners monitor query performance using SHOW PROFILE and EXPLAIN ANALYZE, identify bottlenecks, and propose schema changes. Practical tasks include implementing these adjustments and documenting results.

This comprehensive task flow ensures you learn not only to write efficient SQL queries but also to think strategically about database design and optimization. The goal is to prepare you for real-world database challenges in high-performance applications.

### Task 1
First Query:
The outer query selects properties from the Property table.
The subquery calculates the average rating for each property by filtering reviews based on the property_id. It checks if the average rating is greater than 4.0.
Second Query:
The outer query selects users from the User  table.
The correlated subquery counts the number of bookings for each user by filtering bookings based on the user_id. It checks if the count is greater than 3.

### Task 2
First Query:
The LEFT JOIN is used to include all users, even those who have not made any bookings.
The COUNT(b.booking_id) function counts the number of bookings for each user.
The GROUP BY clause groups the results by user ID, first name, and last name to aggregate the booking counts.
The results are optionally ordered by the total number of bookings in descending order.
Second Query:
The LEFT JOIN is used to include all properties, even those that have not received any bookings.
The COUNT(b.booking_id) function counts the number of bookings for each property.
The RANK() window function assigns a rank to each property based on the total number of bookings, with the highest number of bookings receiving the highest rank.
The GROUP BY clause groups the results by property ID, name, and description to aggregate the booking counts.
The results are optionally ordered by the booking rank.