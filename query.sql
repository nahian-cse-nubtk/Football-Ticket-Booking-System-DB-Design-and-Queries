--Create the  users table

CREATE TABLE Users (
    user_id serial,
    full_name varchar(100),
    email varchar(100),
    role varchar(20),
    phone_number varchar(20),

    constraint pk_users primary key (user_id),
    constraint uk_user_email unique(email),
    constraint check_user_role check(role in ('Ticket Manager','Football Fan'))
);

--create matches table
CREATE TABLE Matches (
    match_id SERIAL,
    fixture VARCHAR(100),
    tournament_category VARCHAR(100),
    base_ticket_price NUMERIC(10,2),
    match_status VARCHAR(30),

    CONSTRAINT pk_matches PRIMARY KEY (match_id),
    CONSTRAINT chk_base_ticket_price
        CHECK (base_ticket_price >= 0),
    CONSTRAINT chk_match_status
        CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- create bookings table
CREATE TABLE Bookings (
    booking_id SERIAL,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(20),
    payment_status VARCHAR(20),
    total_cost NUMERIC(10,2),
    CONSTRAINT pk_bookings PRIMARY KEY (booking_id),
    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_bookings_match
        FOREIGN KEY (match_id) REFERENCES Matches(match_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_total_cost
        CHECK (total_cost >= 0),
    CONSTRAINT chk_payment_status
        CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);