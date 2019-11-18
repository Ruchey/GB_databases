/*
* 2. �������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������
* 3. �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = true).
*    ��� ������������� �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = false (��� 0)
* 4. �������� ������, ��������� ��������� ��� �������� (���� ����� �����������)
*
*/

use vk;

-- 2
select distinct firstname from users order by firstname asc;

-- 3
update profiles set is_active=true where ((YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))) >= 18;
update profiles set is_active=false where ((YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))) < 18;

select birthday,
	((YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))) as age,
	is_active
	from profiles
	order by  age;

-- 4
update messages set body = '' where created_at > curdate();