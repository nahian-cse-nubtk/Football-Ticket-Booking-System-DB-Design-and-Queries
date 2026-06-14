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