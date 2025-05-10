This repository contains the SQL schema for a booking and payment system. The schema includes tables for **users**, **properties**, **bookings**, **payments**, **reviews**, and **messages**, each designed with proper relationships, constraints, and indexing for optimal performance.

## Tables and Their Relationships

1. **User Table**

   * Stores user information (e.g., name, email, role).
   * Columns: `user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`.
   * Primary Key: `user_id`
   * Index: `email` for quick lookups.

2. **Property Table**

   * Stores property details (e.g., name, description, price).
   * Columns: `property_id`, `host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`.
   * Primary Key: `property_id`
   * Foreign Key: `host_id` references `User(user_id)`.

3. **Booking Table**

   * Stores booking information (e.g., user, property, dates).
   * Columns: `booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`.
   * Primary Key: `booking_id`
   * Foreign Keys:

     * `property_id` references `Property(property_id)`.
     * `user_id` references `User(user_id)`.

4. **Payment Table**

   * Stores payment information for bookings (e.g., amount, method).
   * Columns: `payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`.
   * Primary Key: `payment_id`
   * Foreign Key: `booking_id` references `Booking(booking_id)`.

5. **Review Table**

   * Stores user reviews for properties.
   * Columns: `review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`.
   * Primary Key: `review_id`
   * Foreign Keys:

     * `property_id` references `Property(property_id)`.
     * `user_id` references `User(user_id)`.

6. **Message Table**

   * Stores messages exchanged between users.
   * Columns: `message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`.
   * Primary Key: `message_id`
   * Foreign Keys:

     * `sender_id` references `User(user_id)`.
     * `recipient_id` references `User(user_id)`.

## Indexes

To optimize query performance, indexes have been created on the following columns:

* `User(email)`
* `Property(property_id)`
* `Booking(property_id)`
* `Booking(booking_id)`
* `Payment(booking_id)`

## SQL Constraints

* **Primary Keys**: Uniquely identify each record in the table.
* **Foreign Keys**: Enforce relationships between tables to ensure referential integrity.
* **Unique Constraints**: Ensure uniqueness of `email` in the `User` table.
* **Check Constraints**: Ensure that `rating` in the `Review` table is between 1 and 5.
* **Default Values**: Automatically set `created_at` and `updated_at` to the current timestamp.
