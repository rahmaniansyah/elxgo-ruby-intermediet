--------------------------------------------------
-- Tables that represent the entities --
--------------------------------------------------

-- customer TABLE --
CREATE TABLE customers(
    id INT NOT NULL auto_increment,
    name VARCHAR(60),
    email VARCHAR(60),
    phone VARCHAR(15) UNIQUE,
    PRIMARY KEY (id)
);

-- admin information -- *still not used
CREATE TABLE admins(
    id INT NOT NULL auto_increment,
    password CHAR(128),
    email VARCHAR(60),
    PRIMARY KEY (id)
);

-- order TABLE --
CREATE TABLE orders(
    id INT NOT NULL auto_increment,
    order_date DATETIME,
    total_price INT,
    customer_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

-- orderDetails TABLE --
CREATE TABLE order_details(
    id INT NOT NULL auto_increment,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT,
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE
);

-- item TABLE --
CREATE TABLE items(
    id INT NOT NULL auto_increment,
    name VARCHAR(60),
    price INT,
    description VARCHAR(100),
    PRIMARY KEY (id)
);

-- add categories TABLE
CREATE TABLE categories(
    id INT NOT NULL auto_increment,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

-- add relation TABLE from item and categories
CREATE TABLE item_categories(
    id INT NOT NULL auto_increment,
    item_id INT,
    category_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

------------------------------------------------------------
-- Views tables --
------------------------------------------------------------

-- Display items belongs to categories
CREATE VIEW item_categories_views AS
SELECT item_categories.id, items.name, item_categories.category_id, item_categories.item_id, categories.name AS category
FROM items
INNER JOIN item_categories ON items.id = item_categories.item_id
INNER JOIN categories ON item_categories.category_id = categories.id;

select name, group_concat(category separator ', ') as category from item_categories_views group by name where item_id = 1;

SELECT * FROM items WHERE name LIKE '%Nasi%';

-- Display order details for customer
CREATE VIEW order_details_views AS
SELECT items.name, (items.price * order_details.quantity) as price, order_details.quantity, orders.id as order_id
FROM orders
INNER JOIN order_details ON order_details.order_id = orders.id
INNER JOIN items ON order_details.item_id = items.id;


WHERE orders.id = 1;