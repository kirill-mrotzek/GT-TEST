-- 1. Создать и активировать базу данных tasks.
create database tasks;
use tasks;

-- 2. Создать таблицу store с полями:
--    •	id — целое число, первичный ключ, автоинкремент.
--    •	title — строка (128 символов), не NULL.
--    •	price — целое число.
--    •	quantity — целое число.
create table store(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL,
    price INTEGER,
    quantity INTEGER
  );

-- 3. Добавить в таблицу store записи:
--    •	title — 'Skirt', price — 120, quantity — 10.
--    •	title — 'Shirt', price — 55, quantity — 4.
--    •	title — 'Jeanse', price — 135, quantity — 15.
insert into store(title, price, quantity) values("Skirt", 120, 10);
insert into store(title, price, quantity) values("Shirt", 55, 4);
insert into store(title, price, quantity) values("Jeanse", 135, 15);

-- 4. Из таблицы store вывести те товары, цена которых больше 100.
select * from store
where store.price > 100;

-- 5. Из таблицы store вывести те товары, название которых начинается на букву 'S'.
select * from store
where store.title like 'S%';

-- 6. Увеличить количество товара с названием 'Jeanse' на 5.
SET SQL_SAFE_UPDATES = 0;
update store
set quantity = quantity+5
where title='Jeanse';
SET SQL_SAFE_UPDATES = 1;

-- 7. Добавить новое поле quality — целое число.
alter table store
add quality INT;

-- 8. Заполнить поле quality:
--    •	Если цена товара больше 100, установить значение 5.
--    •	Если цена товара меньше или равна 100, установить значение 4.
SET SQL_SAFE_UPDATES = 0;
update store
set quality = CASE
when price > 100 then 5
when price <= 100 then 4
end;
SET SQL_SAFE_UPDATES = 1;

-- 9. Удалить из таблицы store товары, где количество меньше 10.
SET SQL_SAFE_UPDATES = 0;
delete from store
where quantity < 10;
SET SQL_SAFE_UPDATES = 1;

-- 10. Удалить таблицу store.
drop table store;

-- 11. Удалить базу данных tasks.
drop database tasks;

-- 12. Создать базу данных shop и заполнить её, используя скрипт:
-- https://github.com/annykh/GT-290424/blob/main/%D0%91%D0%94%20-%20shop.sql
-- Техническое описание этой базы данных доступно по следующей ссылке - https://github.com/annykh/GT-290424/blob/main/%D0%A2%D0%B5%D1%85.%20%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5%20-%20shop.txt
create database shop;
use shop;
CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
		BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);

INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);

INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

-- 13. Вывести всех продавцов, чьи имена начинаются на букву 'Л'.
select * from SELLERS
where SELLERS.SNAME like 'Л%';

-- 14. Вывести всех клиентов из города Тула с рейтингом больше 100.
select * from CUSTOMERS
where CUSTOMERS.RATING > 100;

-- 15. Вывести всех продавцов, чьи комиссии между 0.10 и 0.15 (включительно).
select * from SELLERS
where SELLERS.COMM between 0.10 and 0.15;

-- 16. Вывести заказы, сумма которых меньше 1000 и дата которых после 1 апреля 2022 года.
select * from ORDERS
where ORDERS.AMT < 100 and ORDERS.ODATE > '2022-04-01';

-- 17. Вывести список всех продавцов из Москвы, отсортированный по убыванию их идентификаторов.
select * from SELLERS
where SELLERS.CITY = 'Москва'
order by SELL_ID desc;

-- 18. Вывести все заказы, сделанные клиентом с ID 304, и отсортировать по сумме заказа (AMT) в порядке убывания.
select * from ORDERS
where ORDERS.CUST_ID = 304
order by AMT desc;

-- 19. Вывести пары покупателей и обслуживших их продавцов из одного города.
select *
from SELLERS
join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
where SELLERS.CITY = CUSTOMERS.CITY;

-- 20. Вывести все заказы, сделанные в марте.
select * from ORDERS
where ORDERS.ODATE between '2022-03-01' and '2022-03-31';

-- 21. Вывести имена клиентов, которые сделали заказ в апреле 2022 года, и соответствующие суммы их заказов.
select * from CUSTOMERS
join ORDERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
where ORDERS.ODATE between '2022-04-01' and '2022-04-30';

-- 22. Вывести имена всех продавцов и соответствующих клиентов, которые сделали заказ у этих продавцов.
select SELLERS.SNAME, CUSTOMERS.CNAME
from SELLERS
join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID;
 
-- 23. Вывести имена продавцов и города их клиентов, сделавших заказ.
select SELLERS.SNAME, CUSTOMERS.CITY
from SELLERS
join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID;

-- 24. Вывести имена клиентов и их соответствующих продавцов, если клиент сделал заказ.
select CUSTOMERS.CNAME, SELLERS.SNAME
from SELLERS
join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID;

-- 25. Вывести имена продавцов, у которых нет заказов.
select SELLERS.SNAME
from SELLERS
left join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
where ORDERS.ORDER_ID is null;

-- 26. Вывести всех клиентов, у которых есть заказы, и суммы этих заказов.
select CUSTOMERS.CNAME, ORDERS.AMT
from CUSTOMERS
join ORDERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
where ORDERS.AMT is not null;

-- 27. Вывести всех клиентов и их продавцов, включая тех, у кого нет заказов.
select CUSTOMERS.CNAME, SELLERS.SNAME
from CUSTOMERS 
left join ORDERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
left join SELLERS on SELLERS.SELL_ID = ORDERS.SELL_ID;

-- 28. Вывести имена всех продавцов, которые продают товары клиентам из Тулы.
select SELLERS.SNAME
from SELLERS
join ORDERS on SELLERS.SELL_ID = ORDERS.SELL_ID
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
where CUSTOMERS.CITY = 'Тула';

-- 29. Вывести все заказы и соответствующих клиентов, для которых сумма заказа превышает 5000
select ORDERS.*, CUSTOMERS.CNAME
from ORDERS
join CUSTOMERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
where ORDERS.AMT > 5000;

-- 30. Вывести имена всех клиентов и продавцов, которые сделали заказ в июне 2022 года.
select CUSTOMERS.CNAME, SELLERS.SNAME
from CUSTOMERS
join ORDERS on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
join SELLERS on SELLERS.SELL_ID = ORDERS.SELL_ID
where ORDERS.ODATE between '2022-06-01' and '2022-06-30';