--------------------------------------------------
-- 2. Create tables that represent the entities --
--------------------------------------------------

-- customer table --
create table customer(
    id int not null auto_increment,
    name varchar(60),
    phone varchar(15) UNIQUE,
    primary key (id)
);

-- describe customer;
-- +-------+-------------+------+-----+---------+----------------+
-- | Field | Type        | Null | Key | Default | Extra          |
-- +-------+-------------+------+-----+---------+----------------+
-- | id    | int         | NO   | PRI | NULL    | auto_increment |
-- | name  | varchar(60) | YES  |     | NULL    |                |
-- | phone | varchar(15) | YES  | UNI | NULL    |                |
-- +-------+-------------+------+-----+---------+----------------+

-- item table --
create table item(
    id int not null auto_increment,
    name varchar(60),
    price int,
    category_id int,
    description varchar(100),
    primary key (id),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- describe item;
-- +-------+-------------+------+-----+---------+----------------+
-- | Field | Type        | Null | Key | Default | Extra          |
-- +-------+-------------+------+-----+---------+----------------+
-- | id    | int         | NO   | PRI | NULL    | auto_increment |
-- | name  | varchar(60) | YES  |     | NULL    |                |
-- | price | int         | YES  |     | NULL    |                |
-- +-------+-------------+------+-----+---------+----------------+

-- order table --
create table orderT(
    id int not null auto_increment,
    order_date datetime,
    total_price int,
    customer_id int not null,
    primary key (id),
    foreign key (customer_id) references customer (id)
);

-- describe orderT;
-- +-------------+----------+------+-----+---------+----------------+
-- | Field       | Type     | Null | Key | Default | Extra          |
-- +-------------+----------+------+-----+---------+----------------+
-- | id          | int      | NO   | PRI | NULL    | auto_increment |
-- | order_date  | datetime | YES  |     | NULL    |                |
-- | total_price | int      | YES  |     | NULL    |                |
-- | customer_id | int      | NO   | MUL | NULL    |                |
-- +-------------+----------+------+-----+---------+----------------+

-- orderDetails table --
create table orderDetails(
    id int not null auto_increment,
    order_id int not null,
    item_id int not null,
    quantity int,
    primary key (id),
    foreign key (order_id) references orderT (id),
    foreign key (item_id) references item (id)
);

-- describe orderDetails;
-- +----------+------+------+-----+---------+----------------+
-- | Field    | Type | Null | Key | Default | Extra          |
-- +----------+------+------+-----+---------+----------------+
-- | id       | int  | NO   | PRI | NULL    | auto_increment |
-- | order_id | int  | NO   | MUL | NULL    |                |
-- | item_id  | int  | NO   | MUL | NULL    |                |
-- | quantity | int  | YES  |     | NULL    |                |
-- +----------+------+------+-----+---------+----------------+

-- User tabel for admin information --
create table users(
    id int not null auto_increment,
    password CHAR(128),
    email varchar(60),
    primary key (id)
);

-- add categories table
create table categories(
    id int not null auto_increment,
    name varchar(50),
    primary key (id)
);

-- add relation table from item and categories
create table itemCategories(
    id INT NOT NULL auto_increment,
    item_id INT,
    category_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

-- insert into itemCategories (category_id,  item_id) values
-- (1,1),
-- (1,3),
-- (1,4),
-- (2,5),
-- (2,7),
-- (1,20),
-- (3,22),
-- (2,23);


-------------------------------------------------------
-- 3. Insert minimal 5 dummy records for each entity --
-------------------------------------------------------

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
insert into item (name, price, category_id) values
('Nasi goreng spesial','24000',1),
('Ayam geprek sambal','13000',1),
('Ayam kung pao','25000',1),
('Bakso semar tulang iga','28000',1),
('Air putih','2000',2),
('Jus jeruk','10000',2);

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





------------------------------------------------------------
-- 4. Display data which contains all orders information, 
-- with ther respective customer name and phone information.
------------------------------------------------------------

select orderDetails.order_id as "Order ID", date(orderT.order_date) as "Order Date",
    customer.name as "Customer name", customer.phone "Customer phone",
    orderT.total_price as "Total",
    group_concat(item.name separator ', ') as "Items bought"
from orderDetails
inner join item on orderDetails.item_id = item.id
left join orderT on orderDetails.order_id = orderT.id
left join customer on orderT.customer_id = customer.id
group by orderDetails.order_id;

-- +----------+------------+---------------+-----------------+-------+-----------------------------------------+
-- | Order ID | Order Date | Customer name | Customer phone  | Total | Items bought                            |
-- +----------+------------+---------------+-----------------+-------+-----------------------------------------+
-- |        1 | 2020-10-18 | Dummy1        | +62838322323900 | 38000 | Bakso semar tulang iga, Jus jeruk       |
-- |        2 | 2020-10-18 | Dummy4        | +62838322323903 | 26000 | Nasi goreng spesial, Air putih          |
-- |        3 | 2020-10-18 | Dummy2        | +62838322323901 | 37000 | Nasi goreng spesial, Ayam geprek sambal |
-- |        4 | 2020-10-17 | Dummy1        | +62838322323900 | 27000 | Ayam kung pao, Air putih                |
-- |        5 | 2020-10-16 | Dummy3        | +62838322323902 | 23000 | Ayam geprek sambal, Jus jeruk           |
-- |        6 | 2020-10-15 | Dummy4        | +62838322323903 | 53000 | Ayam kung pao, Bakso semar tulang iga   |
-- +----------+------------+---------------+-----------------+-------+-----------------------------------------+

-- Display items belongs to categories
select item.name
from itemCategories
inner join item on itemCategories.item_id = item.id
where itemCategories.category_id = 1;