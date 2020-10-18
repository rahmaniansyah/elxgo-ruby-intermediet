-- 2. Create tables that represent the entities --

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
    primary key (id)
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