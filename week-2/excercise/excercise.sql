----------------------
-- Exercise : Query --
----------------------

-- Number 1 --

select items.*, categories.name
from items
inner join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id;

-- +----+-------------------+-------+-----------+
-- | id | name              | price | name      |
-- +----+-------------------+-------+-----------+
-- |  1 | Ice water         |  2000 | main dish |
-- |  2 | Air putih         |     0 | beverage  |
-- |  3 | spaghetti         | 40000 | main dish |
-- |  4 | Green tea latte   | 18000 | beverage  |
-- |  5 | orange juice      | 15000 | beverage  |
-- |  6 | vanilla ice cream | 13000 | dessert   |
-- |  7 | Cordon Bleu       | 36000 | main dish |
-- +----+-------------------+-------+-----------+

-- Number 2 --

select items.id, items.name
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id
where categories.name like '%main dish%';

-- +----+-------------+
-- | id | name        |
-- +----+-------------+
-- |  1 | Ice water   |
-- |  3 | spaghetti   |
-- |  7 | Cordon Bleu |
-- +----+-------------+

-- Number 3 --

select items.*
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id
where items.price >= 30000;

-- +----+-------------+-------+
-- | id | name        | price |
-- +----+-------------+-------+
-- |  3 | spaghetti   | 40000 |
-- |  7 | Cordon Bleu | 36000 |
-- +----+-------------+-------+

-- Number 4 --

select items.*
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id
where categories.name is NULL;

-- +----+--------------+-------+
-- | id | name         | price |
-- +----+--------------+-------+
-- |  8 | French Fries | 20000 |
-- |  9 | Mango Juice  | 15000 |
-- +----+--------------+-------+

-- Number 5 --

select ROW_NUMBER() OVER (
	ORDER BY categories.name
   ) as No, group_concat(items.name separator ', ') as Name, MAX(items.price) as price
from items  
inner join item_categories on items.id = item_categories.item_id 
inner join categories on categories.id = item_categories.category_id 
group by categories.name;

-- +----+------------------------------------------+-------+
-- | No | Name                                     | price |
-- +----+------------------------------------------+-------+
-- |  1 | Air putih, Green tea latte, orange juice | 18000 |
-- |  2 | vanilla ice cream                        | 13000 |
-- |  3 | Ice water, spaghetti, Cordon Bleu        | 40000 |
-- +----+------------------------------------------+-------+