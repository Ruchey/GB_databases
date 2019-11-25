-- ������������ ������� �� ���� ����������, ����������, ���������� � �����������

-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10".
--    ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
--    ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.
-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� ('may', 'august')
-- 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.



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


-- ������������ ������� ���� ���������� �������
-- 1. ����������� ������� ������� ������������� � ������� users
-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
-- 3. (�� �������) ����������� ������������ ����� � ������� �������


-- 1
select avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age from users;

-- 2

-- 3
select sum(a * b) from sumtbl;

