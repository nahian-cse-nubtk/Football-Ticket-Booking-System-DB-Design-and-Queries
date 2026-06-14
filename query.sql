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