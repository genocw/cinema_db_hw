DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers(
  id        SERIAL8 PRIMARY KEY,
  name      VARCHAR(255),
  dob       DATE,
  funds     DECIMAL(8,2),
  Student   BOOLEAN
);

CREATE TABLE films (
  id                SERIAL8 PRIMARY KEY,
  title             VARCHAR(255),
  age_restriction   INT8
);

CREATE TABLE screenings (
  id            SERIAL8 PRIMARY KEY,
  showtime          VARCHAR(255),
  film_id       INT8 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets (
  id            SERIAL8 PRIMARY KEY,
  customer_id   INT8 REFERENCES customers(id) ON DELETE CASCADE,
  screening_id  INT8 REFERENCES screenings(id) ON DELETE CASCADE,
  price         DECIMAL(8,2)
);
