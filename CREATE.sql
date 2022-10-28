CREATE TABLE ganre
(
 ganre_id   serial PRIMARY KEY,
 ganre_name varchar(100) NOT null UNIQUE
);


CREATE TABLE artist
(
 artist_id   serial PRIMARY KEY,
 artist_name varchar(100) NOT null UNIQUE
);


CREATE TABLE ganre_artist
(
 ganre_id   INTEGER REFERENCES ganre(ganre_id),
 artist_id  INTEGER REFERENCES artist(artist_id),
 CONSTRAINT pk PRIMARY KEY (ganre_id, artist_id)
);

CREATE TABLE albom
(
 albom_id   serial PRIMARY KEY,
 albom_name varchar(100) NOT null,
 albom_year int,
 check (albom_year >=1950 and albom_year <= 2022)
);

CREATE TABLE artist_albom
(
 albom_id   INTEGER REFERENCES albom(albom_id),
 artist_id  INTEGER REFERENCES artist(artist_id),
 CONSTRAINT pk1 PRIMARY KEY (albom_id, artist_id)
);

CREATE TABLE track
(
 track_id   serial PRIMARY KEY,
 track_name varchar(100) NOT null unique,
 track_time time,
 albom_id int REFERENCES albom(albom_id),
 check(track_time > '0:30')
);

CREATE TABLE collection
(
 collection_id   serial PRIMARY KEY,
 collection_name varchar(100) NOT null,
 collection_year int,
 check(collection_year >= 1950 and collection_year<= 2022)
);

CREATE TABLE track_collection
(
 track_id   INTEGER REFERENCES track(track_id),
 collection_id  INTEGER REFERENCES collection(collection_id),
 CONSTRAINT pk2 PRIMARY KEY (track_id, collection_id)
);