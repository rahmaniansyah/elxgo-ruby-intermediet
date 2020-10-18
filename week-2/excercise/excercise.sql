select items.*, categories.name
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id;

select items.id, items.name
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id
where categories.name is NULL;

select items.name
from items
left join item_categories on items.id = item_categories.item_id
left join categories on item_categories.category_id = categories.id
group by categories.name;

select items.id, items.name, group_concat(items separator ', '), max(items.price)
from items 
inner join item_categories on items.id = item_categories.item_id
inner join categories on categories.id = item_categories.category_id

select group_concat(items.name separator ', '), max (items.price)
from items 
inner join item_categories on items.id = item_categories.item_id
inner join categories on categories.id = item_categories.category_id
grup by categories.name;

select group_concat(items.name separator ', ') as Name, MAX(items.price) as price
from items  
inner join item_categories on items.id = item_categories.item_id 
inner join categories on categories.id = item_categories.category_id 
group by categories.name;