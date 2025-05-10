
# Database Normalization to 3NF

This document provides an explanation of the steps taken to normalize the provided database schema to **Third Normal Form (3NF)**. The schema consists of several tables, each representing entities such as users, properties, bookings, payments, reviews, and messages. The normalization process ensures that the database is efficient, free from redundancy, and preserves data integrity.

---

## 1. **First Normal Form (1NF)**

### Definition:

A table is in **First Normal Form (1NF)** if:

* All columns contain atomic (indivisible) values.
* Each column contains values of a single type.
* Each column contains a unique value for each row.

### Action Taken:

* All attributes in the provided schema are atomic. For example, fields like `email`, `phone_number`, `rating`, and `status` contain single values, and there are no repeating groups or arrays within the tables.
* Each column is designed to store a specific type of data (e.g., `VARCHAR` for textual data, `DECIMAL` for prices, and `DATE` for date values).

Thus, the schema already complies with 1NF without needing any changes.

---

## 2. **Second Normal Form (2NF)**

### Definition:

A table is in **Second Normal Form (2NF)** if:

* The table is in 1NF.
* Every non-key attribute is fully functionally dependent on the primary key (no partial dependencies).

### Action Taken:

* **Partial Dependencies**: Partial dependency occurs when a non-key attribute is dependent on part of a composite primary key. For example, in a table with a composite key `(A, B)`, if attribute `C` depends only on `A` but not `B`, it violates 2NF.
* In the provided schema:

  * The `Booking` table uses `property_id` and `user_id` as a composite primary key, and non-key attributes like `total_price` and `status` depend fully on both keys, not just part of them.
  * Similarly, attributes like `price_per_night` in `Property` depend on `property_id`, and there are no partial dependencies present.

The schema was verified to ensure no partial dependencies, and foreign keys were properly defined to enforce the full dependence of non-key attributes on the primary keys.

---

## 3. **Third Normal Form (3NF)**

### Definition:

A table is in **Third Normal Form (3NF)** if:

* The table is in 2NF.
* Every non-key attribute is non-transitively dependent on the primary key (no transitive dependencies).

### Action Taken:

* **Transitive Dependencies**: A transitive dependency occurs when a non-key attribute depends on another non-key attribute, which in turn depends on the primary key. For example, in a table with primary key `A`, if `B` depends on `A` and `C` depends on `B`, then `C` is transitively dependent on `A`.
* In the provided schema:

  * No non-key attribute depends on another non-key attribute. Attributes like `created_at` and `updated_at` are not dependent on the primary key but on the data's creation and update timestamps.
  * There is no transitive dependency in the `Booking`, `Payment`, `Review`, or `Property` tables.

Thus, the schema was further checked for transitive dependencies, and no such issues were found, confirming compliance with 3NF.

---

## **Relationships and Foreign Keys**

* **Foreign Key Constraints**: Foreign keys were defined in the schema to establish relationships between tables:

  * `host_id` in the `Property` table references `user_id` in the `User` table.
  * `property_id` in the `Booking` and `Review` tables references `property_id` in the `Property` table.
  * `user_id` in the `Booking` and `Review` tables references `user_id` in the `User` table.
  * `booking_id` in the `Payment` table references `booking_id` in the `Booking` table.
  * `sender_id` and `recipient_id` in the `Message` table reference `user_id` in the `User` table.

These relationships ensure data integrity and help maintain referential integrity across the tables.

---

## **Indexes**

To improve query performance, several indexes were added:

* **User Table**: Indexed on `email` for faster lookups based on the user's email address.
* **Property Table**: Indexed on `property_id` to improve retrieval performance for properties.
* **Booking Table**: Indexed on `property_id` and `booking_id` for faster search operations, especially for booking details.
* **Payment Table**: Indexed on `booking_id` to speed up queries related to payment information for specific bookings.

Indexes ensure that common queries (such as fetching bookings for a specific property or user) are processed quickly.

---

## **Conclusion**

After normalizing the schema to 3NF, we have eliminated redundancy, ensured data integrity through foreign keys, and optimized query performance through indexing. The schema is now in an efficient form, reducing the likelihood of anomalies such as update, insert, and delete anomalies. Additionally, relationships between entities are clearly defined and enforced through foreign key constraints, ensuring referential integrity.

