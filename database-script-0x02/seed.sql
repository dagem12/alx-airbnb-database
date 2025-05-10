-- Insert sample data into the User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  (UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashedpassword1', '555-1234', 'guest'),
  (UUID(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashedpassword2', '555-5678', 'host'),
  (UUID(), 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashedpassword3', '555-8765', 'admin'),
  (UUID(), 'Mary', 'Williams', 'mary.williams@example.com', 'hashedpassword4', '555-4321', 'host'),
  (UUID(), 'Eve', 'Davis', 'eve.davis@example.com', 'hashedpassword5', '555-6789', 'guest');

-- Insert sample data into the Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
  (UUID(), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), 'Luxury Villa', 'A luxurious villa with a private pool and beach access.', 'Malibu, CA', 500.00),
  (UUID(), (SELECT user_id FROM User WHERE email = 'mary.williams@example.com'), 'Cozy Cottage', 'A cozy cottage in the woods, perfect for a relaxing getaway.', 'Aspen, CO', 200.00),
  (UUID(), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), 'Modern Apartment', 'A modern city apartment with great views and amenities.', 'New York, NY', 250.00);

-- Insert sample data into the Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), (SELECT user_id FROM User WHERE email = 'eve.davis@example.com'), '2025-06-01', '2025-06-07', 3000.00, 'confirmed'),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2025-07-15', '2025-07-20', 1000.00, 'pending'),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Modern Apartment'), (SELECT user_id FROM User WHERE email = 'mary.williams@example.com'), '2025-08-01', '2025-08-05', 1000.00, 'confirmed');

-- Insert sample data into the Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed' AND user_id = (SELECT user_id FROM User WHERE email = 'eve.davis@example.com')), 3000.00, '2025-05-25', 'credit_card'),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'pending' AND user_id = (SELECT user_id FROM User WHERE email = 'john.doe@example.com')), 1000.00, '2025-07-10', 'paypal'),
  (UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed' AND user_id = (SELECT user_id FROM User WHERE email = 'mary.williams@example.com')), 1000.00, '2025-07-20', 'stripe');

-- Insert sample data into the Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), (SELECT user_id FROM User WHERE email = 'eve.davis@example.com'), 5, 'Absolutely amazing experience! The villa was beautiful and the beach access was perfect.'),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 4, 'Great place for a weekend getaway. Cozy and quiet, but could use a few updates.'),
  (UUID(), (SELECT property_id FROM Property WHERE name = 'Modern Apartment'), (SELECT user_id FROM User WHERE email = 'mary.williams@example.com'), 4, 'Nice apartment, clean and well-located, but a bit noisy at night.');

-- Insert sample data into the Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  (UUID(), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), (SELECT user_id FROM User WHERE email = 'eve.davis@example.com'), 'Welcome to my property! I hope you enjoy your stay at the Luxury Villa.'),
  (UUID(), (SELECT user_id FROM User WHERE email = 'bob.johnson@example.com'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 'Hello, how can I help you with your booking?'),
  (UUID(), (SELECT user_id FROM User WHERE email = 'eve.davis@example.com'), (SELECT user_id FROM User WHERE email = 'alice.smith@example.com'), 'Thank you for the warm welcome! We had a fantastic time at the villa!');
