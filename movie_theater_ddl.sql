CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    gender VARCHAR(1) NOT NULL
);

CREATE TABLE customer_transaction(
    transaction_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    transaction_dttm DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE transaction_item(
    transaction_item_id SERIAL PRIMARY KEY,
    transaction_id INTEGER NOT NULL,
    ticket_id INTEGER DEFAULT NULL,
    concession_id INTEGER DEFAULT NULL,
    FOREIGN KEY (transaction_id) REFERENCES customer_transaction(transaction_id) ON DELETE CASCADE
);

CREATE TABLE movie(
    movie_id SERIAL PRIMARY KEY,
    movie_name VARCHAR(50) NOT NULL,
    movie_release_year INTEGER DEFAULT 2023,
    movie_run_time_mins INTEGER DEFAULT 150
);

CREATE TABLE auditorium(
    auditorium_id SERIAL PRIMARY KEY,
    seating_capacity INTEGER NOT NULL,
    accessible BOOLEAN DEFAULT true,
    cleaned_status BOOLEAN DEFAULT true
);

CREATE TABLE showing(
    showing_id SERIAL PRIMARY KEY,
    movie_id INTEGER NOT NULL,
    auditorium_id INTEGER NOT NULL,
    showing_time DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (auditorium_id) REFERENCES auditorium(auditorium_id) ON DELETE CASCADE
);

CREATE TABLE ticket(
    ticket_id SERIAL PRIMARY KEY,
    showing_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (showing_id) REFERENCES showing(showing_id) ON DELETE CASCADE
);

CREATE TABLE concession(
    concession_id SERIAL PRIMARY KEY,
    concession_name VARCHAR NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1
);

ALTER TABLE transaction_item
ADD FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id) ON DELETE CASCADE,
ADD FOREIGN KEY (concession_id) REFERENCES concession(concession_id) ON DELETE CASCADE;