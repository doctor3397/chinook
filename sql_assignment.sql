-- SQL Assignment
-- Check out [W3Schools' SQL Reference](http://www.w3schools.com/sql/sql_syntax.asp) as a reference.

-- Provide one or more SQL queries that retrieve the requested data
-- below each of the following questions:

-- 1) Find the albums recorded by the artist Queen.
-- SELECT * FROM artists WHERE name = 'Queen';
--  id | name  |         created_at         |         updated_at
-- ----+-------+----------------------------+----------------------------
--  51 | Queen | 2006-01-08 22:57:01.166112 | 2014-01-29 22:10:22.166366
--
-- SELECT * FROM albums where artist_id = 51;
--  id  | artist_id |       title       |         created_at         |         updated_at
-- -----+-----------+-------------------+----------------------------+----------------------------
--   36 |        51 | Greatest Hits II  | 2008-01-30 14:00:12.455894 | 2014-01-29 22:14:02.456155
--  185 |        51 | Greatest Hits I   | 2007-12-29 12:02:13.672295 | 2014-01-29 22:14:02.672569
--  186 |        51 | News Of The World | 2010-06-23 20:50:06.971442 | 2014-01-29 22:14:02.971684

SELECT id, title FROM albums WHERE artist_id = (SELECT id FROM artists WHERE name = 'Queen');


-- 2) [Count](http://www.w3schools.com/sql/sql_func_count.asp) how many tracks belong to the media type "Protected MPEG-4 video file".
-- SELECT * FROM media_types WHERE name = 'Protected MPEG-4 video file';
--  id |            name             |         created_at         |         updated_at
-- ----+-----------------------------+----------------------------+----------------------------
--   3 | Protected MPEG-4 video file | 2007-12-07 13:17:17.805185 | 2014-01-29 22:14:22.805487
--
-- SELECT COUNT(*) FROM tracks WHERE media_type_id = 3; #=>214

SELECT COUNT(*) FROM tracks WHERE media_type_id = (SELECT id FROM media_types WHERE name = 'Protected MPEG-4 video file'); -- => 214


-- 3) Find the least expensive track that has the genre "Electronica/Dance".
-- SELECT * FROM genres WHERE name ='Electronica/Dance';
--  id |       name        |        created_at         |         updated_at
-- ----+-------------------+---------------------------+----------------------------
--  15 | Electronica/Dance | 2008-05-25 12:13:42.91584 | 2014-01-29 22:14:08.916059

-- SELECT * FROM tracks WHERE genre_id IN (SELECT id FROM genres WHERE name ='Electronica/Dance');

-- SELECT MIN(unit_price) FROM tracks;
-- min
-- ------
-- 0.99

-- SELECT * FROM tracks WHERE genre_id = 15 AND unit_price = 0.99;
SELECT * FROM tracks WHERE genre_id = (SELECT id FROM genres WHERE name ='Electronica/Dance') AND unit_price = (SELECT MIN(unit_price) FROM tracks);


-- 4) Find the all the artists whose names start with A.
SELECT * FROM artists WHERE name LIKE 'A%';

-- 5) Find all the tracks that belong to playlist 1.
SELECT * FROM tracks t JOIN playlists_tracks p ON (t.id = p.track_id) WHERE playlist_id = 1;


List of relations
Schema |         Name         | Type  |  Owner
--------+----------------------+-------+---------
public | albums               | table | theresa
public | ar_internal_metadata | table | theresa
public | artists              | table | theresa
public | genres               | table | theresa
public | media_types          | table | theresa
public | playlists            | table | theresa
public | playlists_tracks     | table | theresa
public | schema_migrations    | table | theresa
public | tracks               | table | theresa


Table "public.albums"
Column   |            Type             |                      Modifiers
------------+-----------------------------+-----------------------------------------------------
id         | integer                     | not null default nextval('albums_id_seq'::regclass)
artist_id  | integer                     |
title      | character varying           |
created_at | timestamp without time zone |
updated_at | timestamp without time zone |
Indexes:
"albums_pkey" PRIMARY KEY, btree (id)


Table "public.artists"
  Column   |            Type             |                      Modifiers
------------+-----------------------------+------------------------------------------------------
id         | integer                     | not null default nextval('artists_id_seq'::regclass)
name       | character varying           |
created_at | timestamp without time zone |
updated_at | timestamp without time zone |
Indexes:
   "artists_pkey" PRIMARY KEY, btree (id)


Table "public.media_types"
    Column   |            Type             |                        Modifiers
 ------------+-----------------------------+----------------------------------------------------------
  id         | integer                     | not null default nextval('media_types_id_seq'::regclass)
  name       | character varying           |
  created_at | timestamp without time zone |
  updated_at | timestamp without time zone |
 Indexes:
     "media_types_pkey" PRIMARY KEY, btree (id)


 Table "public.tracks"
     Column     |            Type             |                      Modifiers
 ---------------+-----------------------------+-----------------------------------------------------
  id            | integer                     | not null default nextval('tracks_id_seq'::regclass)
  album_id      | integer                     |
  genre_id      | integer                     |
  media_type_id | integer                     |
  name          | character varying           | not null
  composer      | character varying           |
  milliseconds  | integer                     | not null
  bytes         | integer                     |
  unit_price    | numeric(10,2)               |
  created_at    | timestamp without time zone |
  updated_at    | timestamp without time zone |
 Indexes:


 "tracks_pkey" PRIMARY KEY, btree (id)

 Table "public.genres"
    Column   |            Type             |                      Modifiers
 ------------+-----------------------------+-----------------------------------------------------
  id         | integer                     | not null default nextval('genres_id_seq'::regclass)
  name       | character varying           |
  created_at | timestamp without time zone |
  updated_at | timestamp without time zone |
 Indexes:
     "genres_pkey" PRIMARY KEY, btree (id)


 Table "public.playlists"
   Column   |            Type             |                       Modifiers
------------+-----------------------------+--------------------------------------------------------
 id         | integer                     | not null default nextval('playlists_id_seq'::regclass)
 name       | character varying           |
 created_at | timestamp without time zone |
 updated_at | timestamp without time zone |
Indexes:
    "playlists_pkey" PRIMARY KEY, btree (id)
