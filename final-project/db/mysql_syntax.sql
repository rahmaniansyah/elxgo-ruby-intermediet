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
CREATE view itemOnCategories as
select item.name, itemCategories.category_id, itemCategories.item_id
from item
right join itemCategories on item.id = itemCategories.item_id;

-- Create view display item and categories belongs to item
CREATE view categoriesOnItem_view as
select itemOnCategories.item_id, itemOnCategories.name, group_concat(categories.name separator ', ') as category
from itemOnCategories
left join categories on itemOnCategories.category_id = categories.id
group by itemOnCategories.item_id;