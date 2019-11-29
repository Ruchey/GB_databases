use vk;

-- ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.

select count(*) as cnt, to_user_id from messages group by to_user_id order by cnt desc;

select from_user_id from
	(select from_user_id, to_user_id, count(from_user_id) as cntmsg from messages where to_user_id = 72 group by from_user_id) as tbl
	order by cntmsg desc limit 1;
	
-- ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���
-- update likes set user_id = ceil(rand()*100), media_id = ceil(rand()*100); 
-- update media set user_id = ceil(rand()*100);

select l.media_id, m.user_id, (TIMESTAMPDIFF(YEAR, p.birthday, NOW())) as ag, p.gender from (likes as l left join media as m on l.media_id = m.id)
	left join profiles as p on m.user_id = p.user_id where (TIMESTAMPDIFF(YEAR, p.birthday, NOW())) < 10;

-- ��� ������� ���-�� ������
select count(m.user_id) from (likes as l left join media as m on l.media_id = m.id)
	left join profiles as p on m.user_id = p.user_id where (TIMESTAMPDIFF(YEAR, p.birthday, NOW())) < 10;


-- ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

select (count(m.user_id)) as cnt, p.gender as gen from (likes as l left join media as m on l.media_id = m.id)
		left join profiles as p on m.user_id = p.user_id where (TIMESTAMPDIFF(YEAR, p.birthday, NOW())) < 10
		group by gender;


