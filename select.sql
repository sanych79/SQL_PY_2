/*--Задание 2
--Написать SELECT-запросы, которые выведут информацию согласно инструкциям ниже.

--Внимание! Результаты запросов не должны быть пустыми (учтите при заполнении таблиц).*/
--название и год выхода альбомов, вышедших в 2018 году;

select a.albom_name as "Название Альбома", a.albom_year as "Год выхода" --название и год выхода альбомов, вышедших в 2018 году;
	FROM music.albom a 
	where a.albom_year = 2018

select t.track_name as "Название трэка", t.track_time as "Продолжительность трэка" --название и продолжительность самого длительного трека;
	from music.track t 
	order BY t.track_time desc limit 1

	
select t.track_name as "Название трэка", t.track_time as "Продолжительность трэка" --название треков, продолжительность которых не менее 3,5 минуты;
  from music.track t 
 WHERE t.track_time >= '03:30'
  order BY t.track_time 

select c.collection_name as "Название сборника" --названия сборников, вышедших в период с 2018 по 2020 год включительно;
  from music.collection c 
 WHERE 	c.collection_year<=2020 and c.collection_year>=2018

select	a.artist_name as "Имя артиста" --исполнители, чье имя состоит из 1 слова;
  FROM music.artist a
 WHERE position(' ' in a.artist_name) = 0

select	t.track_name  "Название тека" --название треков, которые содержат слово "мой"/"my".
  FROM music.track t
 WHERE position('my' in lower(t.track_name)) <> 0 
 	   or position('мой' in lower(t.track_name)) <> 0
