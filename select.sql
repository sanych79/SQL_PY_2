
/*--Домашка  2
--Написать SELECT-запросы, которые выведут информацию согласно инструкциям ниже.
--Внимание! Результаты запросов не должны быть пустыми (учтите при заполнении таблиц).
--название и год выхода альбомов, вышедших в 2018 году;*/

select a.albom_name as "Название Альбома", a.albom_year as "Год выхода" --название и год выхода альбомов, вышедших в 2018 году;
	FROM music.albom a 
	where a.albom_year = 2018

select t.track_name as "Название трэка", t.track_time as "Продолжительность трэка" --название и продолжительность самого длительного трека;
	from music.track t 
	where t.track_time  = (select MAX(tt.track_time) from music.track tt )	

	
select t.track_name as "Название трэка", t.track_time as "Продолжительность трэка" --название треков, продолжительность которых не менее 3,5 минуты;
  from music.track t 
 WHERE t.track_time >= '03:30'
  order BY t.track_time 

select c.collection_name as "Название сборника" --названия сборников, вышедших в период с 2018 по 2020 год включительно;
  from music.collection c 
 WHERE 	c.collection_year between 2018 and 2020

select	a.artist_name as "Имя артиста" --исполнители, чье имя состоит из 1 слова - ВАРИАНТ 1
  FROM music.artist a
 WHERE position(' ' in a.artist_name) = 0
 
 select	a.artist_name as "Имя артиста" --исполнители, чье имя состоит из 1 слова - ВАРИАНТ 2
  FROM music.artist a
 WHERE a.artist_name not like '% %'

select	t.track_name  "Название тека" --название треков, которые содержат слово "мой"/"my".
  FROM music.track t
 WHERE position('my' in lower(t.track_name)) <> 0 
 	   or position('мой' in lower(t.track_name)) <> 0
 	   
/* Домашка 3
 * Написать SELECT-запросы, которые выведут информацию согласно инструкциям ниже.
Внимание! Результаты запросов не должны быть пустыми (при необходимости добавьте данные в таблицы).*/


select g.ganre_name as "Жанр", count(ga.artist_id) as "количество исполнителей"--количество исполнителей в каждом жанре;
  from ganre g 
   join ganre_artist ga on g.ganre_id = ga.ganre_id 
  group by g.ganre_name 


select count(*) as "Количество треков" --количество треков, вошедших в альбомы 2019-2020 годов;
  from track t 
 where t.albom_id in (
	select albom_id from albom a 
 	 where a.albom_year <= 2020 and a.albom_year >=2019)
	

select a.albom_name as "Название альбома", avg(t.track_time) as "Средняя продолжительность трека" --средняя продолжительность треков по каждому альбому;
  from albom a 
  join track t on a.albom_id = t.albom_id
 group by a.albom_name 


select ar.artist_name as "Исполнитель" --все исполнители, которые не выпустили альбомы в 2020 году;
  from artist ar
 where ar.artist_id not in (
 	select aa.artist_id 
	  from albom a 
	 join artist_albom aa on a.albom_id = aa.albom_id 
	 where a.albom_year = 2020)
 
 
select distinct (c.collection_name) as "Название сборника" --названия сборников, в которых присутствует конкретный исполнитель Ария;
  from collection c 
    join track_collection tc on tc.collection_id  = c.collection_id 
	join track t on tc.track_id = t.track_id 
	join albom a on t.albom_id = a.albom_id 
	join artist_albom aa on aa.albom_id = a.albom_id 
	join artist a2 on a2.artist_id = aa.artist_id 
  where a2.artist_name = 'Ария'

select a.albom_name as "Название альбама" --название альбомов, в которых присутствуют исполнители более 1 жанра;
  from albom a  
	join artist_albom aa on aa.albom_id = a.albom_id 
  where aa.artist_id in ( 
 	select a.artist_id 
 	  from artist a 
 		join ganre_artist ga ON a.artist_id = ga.artist_id 
 	 group by a.artist_id 
 	 having count(a.artist_id) > 1) 
  
select t.track_name as "Наименование тека" --наименование треков, которые не входят в сборники;
  from track t
 left join track_collection tc  on t.track_id = tc.track_id 
  where tc.track_id is NULL


select a.albom_name as "Исполнитель" --исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
  from artist a2 
	join artist_albom aa on a2.artist_id = aa.artist_id 
	join albom a on a.albom_id = aa.albom_id 
	join track t on t.albom_id  = a.albom_id  
   where t.track_time = (select min(t2.track_time) from track t2)

select a.albom_name as "Название альбома" --название альбомов, содержащих наименьшее количество треков.
  from albom a 
  	join track t on a.albom_id = t.albom_id 
   group by a.albom_name
  having count(t.track_id) =(
	select count(tt.track_id) as track_count
	  from track tt 
	 group by tt.albom_id 
	order by count(tt.track_id) limit 1 )
