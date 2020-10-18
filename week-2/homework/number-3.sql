-- 3. Insert minimal 5 dummy records for each entity --

-- insert into customer --
insert into customer (name, phone) values
('Dummy1','+62838322323900'),
('Dummy2','+62838322323901'),
('Dummy3','+62838322323902'),
('Dummy4','+62838322323903'),
('Dummy5','+62838322323904'),
('Dummy6','+62838322323905');

-- select * from customer;
-- +----+--------+-----------------+
-- | id | name   | phone           |
-- +----+--------+-----------------+
-- |  3 | Dummy1 | +62838322323900 |
-- |  4 | Dummy2 | +62838322323901 |
-- |  5 | Dummy3 | +62838322323902 |
-- |  6 | Dummy4 | +62838322323903 |
-- |  7 | Dummy5 | +62838322323904 |
-- |  8 | Dummy6 | +62838322323905 |
-- +----+--------+-----------------+

-- insert into item --
insert into item (name, price) values
('Nasi goreng spesial','24000'),
('Ayam geprek sambal','13000'),
('Ayam kung pao','25000'),
('Bakso semar tulang iga','28000'),
('Air putih','2000'),
('Jus jeruk','10000');

-- select * from item;
-- +----+------------------------+-------+
-- | id | name                   | price |
-- +----+------------------------+-------+
-- |  1 | Nasi goreng spesial    | 24000 |
-- |  2 | Ayam geprek sambal     | 13000 |
-- |  3 | Ayam kung pao          | 25000 |
-- |  4 | Bakso semar tulang iga | 28000 |
-- |  5 | Air putih              |  2000 |
-- |  6 | Jus jeruk              | 10000 |
-- +----+------------------------+-------+

-- insert into orderT --
SET time_zone = '+07:00';       -- set time zone

insert into orderT (order_date, total_price, customer_id) values
(now(), 38000, 3),  -- 4 6
(date_sub(now(), interval 2 Hour), 26000, 6), -- 1 5
(date_sub(now(), interval 5 Hour), 37000, 4), -- 1 2
(date_sub(now(), interval 1 Day), 27000, 3), -- 3 5
(date_sub(now(), interval 2 Day), 23000, 5), -- 2 6
(date_sub(now(), interval 3 Day), 53000, 6); -- 3 4

-- select * from orderT;
-- +----+---------------------+-------------+-------------+
-- | id | order_date          | total_price | customer_id |
-- +----+---------------------+-------------+-------------+
-- |  1 | 2020-10-18 21:42:36 |       38000 |           3 |
-- |  2 | 2020-10-18 19:42:36 |       26000 |           6 |
-- |  3 | 2020-10-18 16:42:36 |       37000 |           4 |
-- |  4 | 2020-10-17 21:42:36 |       27000 |           3 |
-- |  5 | 2020-10-16 21:42:36 |       23000 |           5 |
-- |  6 | 2020-10-15 21:42:36 |       53000 |           6 |
-- +----+---------------------+-------------+-------------+

-- insert into orderDetails --
insert into orderDetails (order_id, item_id, quantity) values
(1, 4, 1),
(1, 6, 1),
(2, 1, 1),
(2, 5, 1),
(3, 1, 1),
(3, 2, 1),
(4, 3, 1),
(4, 5, 1),
(5, 2, 1),
(5, 6, 1),
(6, 3, 1),
(6, 4, 1);

-- select * from orderDetails;
-- +----+----------+---------+----------+
-- | id | order_id | item_id | quantity |
-- +----+----------+---------+----------+
-- |  1 |        1 |       4 |        1 |
-- |  2 |        1 |       6 |        1 |
-- |  3 |        2 |       1 |        1 |
-- |  4 |        2 |       5 |        1 |
-- |  5 |        3 |       1 |        1 |
-- |  6 |        3 |       2 |        1 |
-- |  7 |        4 |       3 |        1 |
-- |  8 |        4 |       5 |        1 |
-- |  9 |        5 |       2 |        1 |
-- | 10 |        5 |       6 |        1 |
-- | 11 |        6 |       3 |        1 |
-- | 12 |        6 |       4 |        1 |
-- +----+----------+---------+----------+