-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(50) UNIQUE,
    role VARCHAR(20) CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(15)
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    fixture VARCHAR(100) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL,
    base_ticket_price INT CHECK (base_ticket_price > 0),
    match_status VARCHAR(50) CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    match_id INT NOT NULL REFERENCES matches(match_id),
    seat_number VARCHAR(20),
    payment_status VARCHAR(20) CHECK (
        payment_status IN (
            'Pending',
            'Confirmed',
            'Cancelled',
            'Refunded'
        )
    ),
    total_cost DECIMAL(10,2) NOT NULL CHECK (total_cost >= 0)
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);