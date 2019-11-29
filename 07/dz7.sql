use shop;

-- ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.

select distinct name, orders.user_id from users right join orders on users.id = orders.user_id;

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

select p.name, c.name from products as p left join catalogs as c on p.catalog_id = c.id; 

-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name).
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������.
-- �������� ������ ������ flights � �������� ���������� �������.
