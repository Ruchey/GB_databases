use vk;

-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

select count(*) as cnt, to_user_id from messages group by to_user_id order by cnt desc;

select from_user_id from
	(select from_user_id, to_user_id, count(from_user_id) as cntmsg from messages where to_user_id = 72 group by from_user_id) as tbl
	order by cntmsg desc limit 1;
	
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет
-- update likes set user_id = ceil(rand()*100), media_id = ceil(rand()*100); 
-- update media set user_id = ceil(rand()*100);

select media.user_id from media;

select media.user_id from media, likes, profiles
	where media.id = likes.media_id and (TIMESTAMPDIFF(YEAR, profiles.birthday, NOW())) < 10;

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?



