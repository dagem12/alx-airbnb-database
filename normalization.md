# Database Normalization Process

## Objective
The goal is to apply normalization principles to ensure the database is in Third Normal Form (3NF).

## Step 1: First Normal Form (1NF)
The database schema already adheres to 1NF as:
- Each column contains atomic values.
- Each record is unique.

## Step 2: Second Normal Form (2NF)
The schema adheres to 2NF as well because:
- All non-key attributes are fully dependent on the primary key.
- There are no partial dependencies.

## Step 3: Third Normal Form (3NF)
To achieve 3NF, the following adjustments were made:
1. **Role Table:** The `role` field in the `User` table was moved to a separate `Role` table to avoid redundancy.
2. **Booking Status:** The `status` field in the `Booking` table was moved to a separate `BookingStatus` table to eliminate transitive dependencies.
3. **Payment Method:** The `payment_method` field in the `Payment` table was moved to a separate `PaymentMethod` table.

## Conclusion
With these changes, the database is now in 3NF, ensuring data integrity, eliminating redundancy, and improving scalability.

