-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
--    Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
--    Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.



use vk;

ALTER TABLE vk.users ADD created_at varchar(100) NULL;
ALTER TABLE vk.users ADD updated_at varchar(100) NULL;
-- 1
update users set created_at = now();
update users set updated_at = now();

-- 2
ALTER TABLE vk.users MODIFY COLUMN created_at DATETIME NULL;
ALTER TABLE vk.users MODIFY COLUMN updated_at DATETIME NULL;

-- 3
use shop;

select * from storehouses_products 
	order by if(value = 0, 1, 0), value;
	
-- 4
select * from users where monthname(birthday_at) in ('may', 'august');

-- 5
SELECT * FROM catalogs WHERE id IN (3, 1, 2) order by FIELD(id, 3, 1, 2);


-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users
-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы


-- 1
select avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age from users;

-- 2

-- 3
select sum(a * b) from sumtbl;

