CREATE TABLE booking_new (
  booking_id CHAR(36) NOT NULL,
  property_id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status ENUM('pending','confirmed','canceled') NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id, start_date),
  KEY fk_booking_property (property_id),
  KEY fk_booking_user (user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
  PARTITION p2022 VALUES LESS THAN (2023),
  PARTITION p2023 VALUES LESS THAN (2024),
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION pMax VALUES LESS THAN MAXVALUE
);

INSERT INTO booking_new
SELECT * FROM booking;

RENAME TABLE booking TO booking_old, booking_new TO booking;