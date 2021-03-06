DROP DATABASE IF EXISTS crypto_piggy;
CREATE DATABASE crypto_piggy;

\c crypto_piggy;

CREATE TABLE users (
  ID SERIAL PRIMARY KEY,
  username VARCHAR NOT NULL,
  hash_pass VARCHAR NOT NULL,
  created_at timestamp default current_timestamp
);

CREATE TABLE addresses (
  ID SERIAL PRIMARY KEY,
  user_id integer REFERENCES users (ID) NOT NULL,
  address VARCHAR NOT NULL,
  created_at timestamp default current_timestamp
);

CREATE TABLE performance_history_hourly (
  ID SERIAL PRIMARY KEY,
  user_id integer REFERENCES users (ID) NOT NULL,
  created_at timestamp default current_timestamp,
  portfolio_value VARCHAR NOT NULL,
  amount_eth VARCHAR NOT NULL
);

CREATE TABLE performance_history_daily (
  ID SERIAL PRIMARY KEY,
  user_id integer REFERENCES users (ID) NOT NULL,
  created_at timestamp default current_timestamp,
  portfolio_value VARCHAR NOT NULL,
  amount_eth VARCHAR NOT NULL
);

INSERT INTO users (username, hash_pass, created_at)
  VALUES ('ianh', '$2a$10$VBX3tQbf/dj6Y73TMrOakeNUQe.6u.wtbnpl/w8wFiWtWrzDp.oY6', '2017-2-22 16:01:00');

-- INSERT INTO users (username, hash_pass, created_at)
--     VALUES ('sam', '$2a$10$VBX3tQbf/dj6Y73TMrOakeNUQe.6u.wtbnpl/w8wFiWtWrzDp.oY6', '2016-12-11 11:00:00');

INSERT INTO addresses (user_id, address)
  VALUES (1, '0x64042ba68b12d4c151651ca2813b7352bd56f08e');

INSERT INTO addresses (user_id, address)
    VALUES (1, '0x9644d964867ace0534559a5435a1d780a25cf03a');

-- INSERT INTO addresses (user_id, address)
--   VALUES (2, '0xac223b118852b90d63052b3f3e203c3dAe4644C0');
--
-- INSERT INTO addresses (user_id, address)
--   VALUES (2, '0x38F913e25db0c796C47b0c0A3d25Cf654e982d51');

-- INSERT INTO performance_history_hourly (user_id, created_at, portfolio_value, amount_eth)
--
-- SELECT 2, generate_series('2016-12-11 12:00:00'::timestamp,'2017-12-11 11:00:00'::timestamp,'1 hour'::interval),to_char((random()*20000),'FM99999'),to_char((random()*300), 'FM999');

-- INSERT INTO performance_history_hourly (user_id, created_at, portfolio_value, amount_eth)
--
-- SELECT 1, generate_series('2018-2-22 17:00:00'::timestamp,'2018-2-23 2:00:00'::timestamp,'1 hour'::interval),to_char((random()*20000),'FM99999'),to_char((random()*300), 'FM999');

-- INSERT INTO performance_history_daily (user_id, created_at, portfolio_value, amount_eth)
--
-- SELECT 2, generate_series('2016-12-11 00:00:00'::timestamp,'2017-12-11 00:00:00'::timestamp,'1 day'::interval),to_char((random()*20000),'FM99999'),to_char((random()*300), 'FM999');
--
-- INSERT INTO performance_history_daily (user_id, created_at, portfolio_value, amount_eth)
--
-- SELECT 1, generate_series('2017-2-17 00:00:00'::timestamp,'2018-2-16 00:00:00'::timestamp,'1 day'::interval),to_char((random()*20000),'FM99999'),to_char((random()*300), 'FM999');
