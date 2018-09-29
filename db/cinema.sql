DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers(
  id        SERIAL8 PRIMARY KEY,
  name      VARCHAR(255),
  funds     DECIMAL(8,2)
);

CREATE TABLE films (
  id        SERIAL8 PRIMARY KEY,
  title     VARCHAR(255),
  price     DECIMAL(8,2)
);

CREATE TABLE tickets (
  id            SERIAL8 PRIMARY KEY,
  customer_id   INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id       INT8 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id            SERIAL8 PRIMARY KEY,
  showtime          VARCHAR(255),
  film_id       INT8 REFERENCES films(id) ON DELETE CASCADE
);
