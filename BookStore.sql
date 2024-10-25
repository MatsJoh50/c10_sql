-- BOOKSTORE

DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;
CREATE TABLE IF NOT EXISTS bookstore.author
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    birth_date DATE
);
INSERT INTO bookstore.author (first_name, last_name, birth_date) VALUES ('John Ronald Reuel', 'Tolkien', '1892-09-01');
INSERT INTO bookstore.author (first_name, last_name, birth_date) VALUES ('Brandon', 'Sanderson', '1975-12-19');
INSERT INTO bookstore.author (first_name, last_name, birth_date) VALUES ('Brent', 'Weeks', '1977-03-07');
INSERT INTO bookstore.author (first_name, last_name, birth_date) VALUES ('Robert Anson', 'Heinlein', '1907-07-07');

CREATE TABLE IF NOT EXISTS bookstore.book
(
    isbn             BIGINT PRIMARY KEY,
    title            VARCHAR(255),
    price            INT,
    publication_date DATE,
    author           INT,
    FOREIGN KEY (author) REFERENCES author (id)
);
-- J.R.R. Tolkien
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780547928227, 'The Hobbit', 15, '1937-09-21', 1);
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780618640157, 'The Lord of the Rings: The Fellowship of the Ring', 20, '1954-07-29', 1);

-- Brandon Sanderson
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780765311784, 'Mistborn: The Final Empire', 25, '2006-07-17', 2);
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780765326351, 'The Way of Kings', 30, '2010-08-31', 2);

-- Brent Weeks
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780316053293, 'The Way of Shadows', 22, '2008-04-01', 3);
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780316053309, 'Shadows Edge', 24, '2009-04-01', 3);

-- Robert A. Heinlein
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780442281492, 'Starship Troopers', 18, '1959-12-01', 4);
INSERT INTO bookstore.book (isbn, title, price, publication_date, author) VALUES (9780441013593, 'Stranger in a Strange Land', 20, '1961-02-01', 4);


CREATE TABLE IF NOT EXISTS bookstore.language
(
    isbn     BIGINT,
    FOREIGN KEY (isbn) REFERENCES bookstore.book (isbn),
    language VARCHAR(255)
);
-- J.R.R. Tolkien
INSERT INTO bookstore.language (isbn, language) VALUES (9780547928227, 'English');
INSERT INTO bookstore.language (isbn, language) VALUES (9780618640157, 'English');

-- Brandon Sanderson
INSERT INTO bookstore.language (isbn, language) VALUES (9780765311784, 'English');
INSERT INTO bookstore.language (isbn, language) VALUES (9780765326351, 'English');

-- Brent Weeks
INSERT INTO bookstore.language (isbn, language) VALUES (9780316053293, 'English');
INSERT INTO bookstore.language (isbn, language) VALUES (9780316053309, 'English');

-- Robert A. Heinlein
INSERT INTO bookstore.language (isbn, language) VALUES (9780442281492, 'English');
INSERT INTO bookstore.language (isbn, language) VALUES (9780441013593, 'English');

CREATE TABLE IF NOT EXISTS bookstore.store
(
    store_id   INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(255)
);

INSERT INTO bookstore.store (store_name) VALUES ('The Book Nook');
INSERT INTO bookstore.store (store_name) VALUES ('Readers Paradise');
INSERT INTO bookstore.store (store_name) VALUES ('Page Turners');
INSERT INTO bookstore.store (store_name) VALUES ('Literary Haven');

CREATE TABLE IF NOT EXISTS bookstore.store_location
(
    store_id INT,
    location VARCHAR(255),
    PRIMARY KEY (store_id, location),
    FOREIGN KEY (store_id) REFERENCES bookstore.store (store_id)
);
INSERT INTO bookstore.store_location (store_id, location) VALUES (1, 'Stockholm');
INSERT INTO bookstore.store_location (store_id, location) VALUES (2, 'Malmö');
INSERT INTO bookstore.store_location (store_id, location) VALUES (3, 'London');
INSERT INTO bookstore.store_location (store_id, location) VALUES (4, 'Madrid');

CREATE TABLE IF NOT EXISTS bookstore.inventory(
    store_id INT,
    isbn BIGINT,
    amount INT,
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore.store(store_id),
    FOREIGN KEY (isbn) REFERENCES bookstore.book(isbn)
);

INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (1, 9780547928227, 50);  -- The Hobbit
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (1, 9780618640157, 30);  -- The Fellowship of the Ring
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (2, 9780765311784, 40);  -- Mistborn: The Final Empire
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (2, 9780765326351, 20);  -- The Way of Kings
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (3, 9780316053293, 25);  -- The Way of Shadows
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (3, 9780316053309, 15);  -- Shadow's Edge
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (4, 9780442281492, 10);  -- Starship Troopers
INSERT INTO bookstore.inventory (store_id, isbn, amount) VALUES (4, 9780441013593, 5);   -- Stranger in a Strange Land


CREATE VIEW total_author_book_value AS
SELECT
    CONCAT(author.first_name, ' ', author.last_name) AS name,
    FLOOR(YEAR(CURDATE()) - YEAR(author.birth_date)) AS age,
    COUNT(b.isbn) AS book_title_count,
    SUM(i.amount * b.price) AS inventory_value
FROM
    bookstore.author
        LEFT JOIN bookstore.book b ON author.id = b.author
        LEFT JOIN bookstore.inventory i ON b.isbn = i.isbn
GROUP BY author.id;

select name as n, age as a, book_title_count as btc, inventory_value as iv
from total_author_book_value