/*--������� 2
--�������� SELECT-�������, ������� ������� ���������� �������� ����������� ����.

--��������! ���������� �������� �� ������ ���� ������� (������ ��� ���������� ������).*/
--�������� � ��� ������ ��������, �������� � 2018 ����;

select a.albom_name as "�������� �������", a.albom_year as "��� ������" --�������� � ��� ������ ��������, �������� � 2018 ����;
	FROM music.albom a 
	where a.albom_year = 2018

select t.track_name as "�������� �����", t.track_time as "����������������� �����" --�������� � ����������������� ������ ����������� �����;
	from music.track t 
	order BY t.track_time desc limit 1

	
select t.track_name as "�������� �����", t.track_time as "����������������� �����" --�������� ������, ����������������� ������� �� ����� 3,5 ������;
  from music.track t 
 WHERE t.track_time >= '03:30'
  order BY t.track_time 

select c.collection_name as "�������� ��������" --�������� ���������, �������� � ������ � 2018 �� 2020 ��� ������������;
  from music.collection c 
 WHERE 	c.collection_year<=2020 and c.collection_year>=2018

select	a.artist_name as "��� �������" --�����������, ��� ��� ������� �� 1 �����;
  FROM music.artist a
 WHERE position(' ' in a.artist_name) = 0

select	t.track_name  "�������� ����" --�������� ������, ������� �������� ����� "���"/"my".
  FROM music.track t
 WHERE position('my' in lower(t.track_name)) <> 0 
 	   or position('���' in lower(t.track_name)) <> 0
