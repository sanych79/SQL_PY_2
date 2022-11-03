
/*--�������  2
--�������� SELECT-�������, ������� ������� ���������� �������� ����������� ����.
--��������! ���������� �������� �� ������ ���� ������� (������ ��� ���������� ������).
--�������� � ��� ������ ��������, �������� � 2018 ����;*/

select a.albom_name as "�������� �������", a.albom_year as "��� ������" --�������� � ��� ������ ��������, �������� � 2018 ����;
	FROM music.albom a 
	where a.albom_year = 2018

select t.track_name as "�������� �����", t.track_time as "����������������� �����" --�������� � ����������������� ������ ����������� �����;
	from music.track t 
	where t.track_time  = (select MAX(tt.track_time) from music.track tt )	

	
select t.track_name as "�������� �����", t.track_time as "����������������� �����" --�������� ������, ����������������� ������� �� ����� 3,5 ������;
  from music.track t 
 WHERE t.track_time >= '03:30'
  order BY t.track_time 

select c.collection_name as "�������� ��������" --�������� ���������, �������� � ������ � 2018 �� 2020 ��� ������������;
  from music.collection c 
 WHERE 	c.collection_year between 2018 and 2020

select	a.artist_name as "��� �������" --�����������, ��� ��� ������� �� 1 ����� - ������� 1
  FROM music.artist a
 WHERE position(' ' in a.artist_name) = 0
 
 select	a.artist_name as "��� �������" --�����������, ��� ��� ������� �� 1 ����� - ������� 2
  FROM music.artist a
 WHERE a.artist_name not like '% %'

select	t.track_name  "�������� ����" --�������� ������, ������� �������� ����� "���"/"my".
  FROM music.track t
 WHERE position('my' in lower(t.track_name)) <> 0 
 	   or position('���' in lower(t.track_name)) <> 0
 	   
/* ������� 3
 * �������� SELECT-�������, ������� ������� ���������� �������� ����������� ����.
��������! ���������� �������� �� ������ ���� ������� (��� ������������� �������� ������ � �������).*/


select g.ganre_name as "����", count(ga.artist_id) as "���������� ������������"--���������� ������������ � ������ �����;
  from ganre g 
   join ganre_artist ga on g.ganre_id = ga.ganre_id 
  group by g.ganre_name 


select count(*) as "���������� ������" --���������� ������, �������� � ������� 2019-2020 �����;
  from track t 
 where t.albom_id in (
	select albom_id from albom a 
 	 where a.albom_year <= 2020 and a.albom_year >=2019)
	

select a.albom_name as "�������� �������", avg(t.track_time) as "������� ����������������� �����" --������� ����������������� ������ �� ������� �������;
  from albom a 
  join track t on a.albom_id = t.albom_id
 group by a.albom_name 


select ar.artist_name as "�����������" --��� �����������, ������� �� ��������� ������� � 2020 ����;
  from artist ar
 where ar.artist_id not in (
 	select aa.artist_id 
	  from albom a 
	 join artist_albom aa on a.albom_id = aa.albom_id 
	 where a.albom_year = 2020)
 
 
select distinct (c.collection_name) as "�������� ��������" --�������� ���������, � ������� ������������ ���������� ����������� ����;
  from collection c 
    join track_collection tc on tc.collection_id  = c.collection_id 
	join track t on tc.track_id = t.track_id 
	join albom a on t.albom_id = a.albom_id 
	join artist_albom aa on aa.albom_id = a.albom_id 
	join artist a2 on a2.artist_id = aa.artist_id 
  where a2.artist_name = '����'

select a.albom_name as "�������� �������" --�������� ��������, � ������� ������������ ����������� ����� 1 �����;
  from albom a  
	join artist_albom aa on aa.albom_id = a.albom_id 
  where aa.artist_id in ( 
 	select a.artist_id 
 	  from artist a 
 		join ganre_artist ga ON a.artist_id = ga.artist_id 
 	 group by a.artist_id 
 	 having count(a.artist_id) > 1) 
  
select t.track_name as "������������ ����" --������������ ������, ������� �� ������ � ��������;
  from track t
 left join track_collection tc  on t.track_id = tc.track_id 
  where tc.track_id is NULL


select a.albom_name as "�����������" --�����������(-��), ����������� ����� �������� �� ����������������� ���� (������������ ����� ������ ����� ���� ���������);
  from artist a2 
	join artist_albom aa on a2.artist_id = aa.artist_id 
	join albom a on a.albom_id = aa.albom_id 
	join track t on t.albom_id  = a.albom_id  
   where t.track_time = (select min(t2.track_time) from track t2)

select a.albom_name as "�������� �������" --�������� ��������, ���������� ���������� ���������� ������.
  from albom a 
  	join track t on a.albom_id = t.albom_id 
   group by a.albom_name
  having count(t.track_id) =(
	select count(tt.track_id) as track_count
	  from track tt 
	 group by tt.albom_id 
	order by count(tt.track_id) limit 1 )
