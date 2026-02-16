-- SQL dialect: MySQL
-- 1- Create the required tables for the retail store database based on the tables structure and relationships. 
-- i have created the required tables using phpMyAdmin GUI

-- 2- Add a column “Category” to the Products table. 
alter table  products add column Category text;

-- 3- Remove the “Category” column from Products. 
alter table  products drop column Category;

-- 4- Change “ContactNumber” column in Suppliers to VARCHAR (15). 
alter table  suppliers modify column ContactNumber varchar(15);

-- 5- Add a NOT NULL constraint to ProductName. 
alter table  products modify column ProductName text not null;

-- 6- Perform Basic Inserts: 
-- a. Add a supplier with the name 'FreshFoods' and contact number '01001234567'. 
insert into suppliers (SupplierName, ContactNumber) 
values ('FreshFoods', '01001234567');

-- b. Insert the following three products, all provided by 'FreshFoods': 
-- i. 'Milk' with a price of 15.00 and stock quantity of 50. 
-- ii. 'Bread' with a price of 10.00 and stock quantity of 30. 
-- iii. 'Eggs' with a price of 20.00 and stock quantity of 40. 
insert into products (ProductName, Price, StockQuantity)
values ('Milk', 15.00, 50),
       ('Bread', 10.00, 30),
       ('Eggs', 20.00, 40);

-- c. Add a record for the sale of 2 units of 'Milk' made on '2025-05-20'. 
insert into sales (ProductID, QuantitySold, SaleDate)
values((select ProductID from products where ProductName = 'Milk'), 2, '2025-05-20');

-- 7- Update the price of 'Bread' to 25.00. 
update products set price = 25.00 where ProductName = 'Bread';

-- 8- Delete the product 'Eggs'. 
delete from products where ProductName = 'Eggs';

-- 9- Retrieve the total quantity sold for each product. 
select ProductName, sum(QuantitySold) as sold
from products left join sales on products.ProductID = sales.ProductID
group by ProductName;

-- 10- Get the product with the highest stock. 
select ProductName, StockQuantity from products
where StockQuantity = (select max(StockQuantity) from products);

-- 11- Find suppliers with names starting with 'F'. 
select * from suppliers where SupplierName like 'F%';

-- 12- Show all products that have never been sold. 
select ProductID, ProductName, StockQuantity 
from products left join sales on products.ProductID = sales.ProductID
where sales.SaleID is null;

-- 13- Get all sales along with product name and sale date. 
select SaleDate, SaleID, QuantitySold, ProductName
from sales inner join products on products.ProductID = sales.ProductID;

-- 14- Create a user “store_manager” and give them SELECT, INSERT, and UPDATE permissions on all tables. 
drop user if exists 'store_manager'@'localhost';
create user 'store_manager'@'localhost' identified by 'password123';
grant select,insert, update on retail_store.* to 'store_manager'@'localhost';
flush privileges;

-- 15- Revoke UPDATE permission from “store_manager”. 
revoke update on retail_store.* from 'store_manager'@'localhost';
flush privileges;

-- 16- Grant DELETE permission to “store_manager” only on the Sales table.
grant delete on retail_store.sales to 'store_manager'@'localhost';
flush privileges;