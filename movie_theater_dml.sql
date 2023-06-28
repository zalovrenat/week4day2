INSERT INTO customer(
    first_name,
    last_name,
    age,
    gender
) VALUES(
    'Renat',
    'Zalov',
    30,
    'M'
), (
    'Murad',
    'Zalov',
    29,
    'M'
), (
    'Roman',
    'Zalov',
    33,
    'M'
), (
    'Rakhman',
    'Kurbanov',
    31,
    'M'
), (
    'Sabina',
    'Zalova',
    27,
    'F'
), (
    'Malika',
    'Alieva',
    31,
    'F'
), (
    'Angela',
    'Zalova',
    29,
    'F'
);



INSERT INTO customer_transaction(
    customer_id
) VALUES(
    1
), (
    2
), (
    3
), (
    4
), (
    5
), (
    6
), (
    7
);



INSERT INTO transaction_item(
    transaction_id,
    ticket_id,
    concession_id
) VALUES(1,1,NULL),
(1,NULL,1),
(2,2,NULL),
(2,NULL,2),
(2,NULL,3),
(3,3,NULL),
(4,4,NULL),
(5,5,NULL),
(5,NULL,4),
(6,6,NULL),
(6,NULL,5),
(7,7,NULL),
(7,NULL,6);



INSERT INTO concession(
    concession_id,
    concession_name,
    quantity
) VALUES(1,'Water bottle',2),
(2,'Water bottle',1),
(3,'Candy bar',1),
(4,'Popcorn',1),
(5,'Popcorn',2),
(6,'Candy bar',3);



INSERT INTO auditorium(
    auditorium_id,
    seating_capacity,
    accessible,
    cleaned_status
) VALUES(1,200,true,true),
(2,175,true,true);



INSERT INTO movie(
    movie_id,
    movie_name,
    movie_release_year,
    movie_run_time_mins
) VALUES(1,'Wedding Crashers',2005,119),
(2,'The Notebook',2004,124);



INSERT INTO showing(
    showing_id,
    movie_id,
    auditorium_id,
    showing_time
) VALUES(1,1,1,DEFAULT),
(2,2,2,DEFAULT);



INSERT INTO ticket(
    ticket_id,
    showing_id,
    quantity
) VALUES(1,1,1),
(2,1,1),
(3,1,1),
(4,1,1),
(5,2,1),
(6,2,1),
(7,2,1);



-- Query for customers and which movies they watched
SELECT
customer.first_name,
movie.movie_name,
showing.showing_time,
auditorium.auditorium_id

FROM customer
LEFT OUTER JOIN customer_transaction ON customer.customer_id = customer_transaction.customer_id
LEFT OUTER JOIN transaction_item ON customer_transaction.transaction_id = transaction_item.transaction_id
LEFT OUTER JOIN concession ON transaction_item.concession_id = concession.concession_id
LEFT OUTER JOIN ticket ON transaction_item.ticket_id = ticket.ticket_id
LEFT OUTER JOIN showing ON ticket.showing_id = showing.showing_id
LEFT OUTER JOIN movie ON showing.movie_id = movie.movie_id
LEFT OUTER JOIN auditorium ON showing.auditorium_id = auditorium.auditorium_id

WHERE transaction_item.ticket_id IS NOT NULL;



-- Query for customers and which concessions they bought
SELECT
customer.first_name,
concession.concession_name,
concession.quantity

FROM customer
LEFT OUTER JOIN customer_transaction ON customer.customer_id = customer_transaction.customer_id
LEFT OUTER JOIN transaction_item ON customer_transaction.transaction_id = transaction_item.transaction_id
LEFT OUTER JOIN concession ON transaction_item.concession_id = concession.concession_id

WHERE transaction_item.concession_id IS NOT NULL;