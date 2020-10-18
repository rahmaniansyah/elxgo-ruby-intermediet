-- 4. Display data which contains all orders information, 
-- with ther respective customer name and phone information.

select orderDetails.order_id as "Order ID", date(orderT.order_date) as "Order Date",
    customer.name as "Customer name", customer.phone "Customer phone",
    orderT.total_price as "Total",
    group_concat(item.name separator ', ') as "Items bought"
from orderDetails
join item on orderDetails.item_id = item.id
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