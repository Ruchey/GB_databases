use shop;

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select distinct name, orders.user_id from users right join orders on users.id = orders.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select p.name, c.name from products as p left join catalogs as c on p.catalog_id = c.id; 

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.
