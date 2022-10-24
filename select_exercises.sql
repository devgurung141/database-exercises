USE albums_db;

/* 
a. How many rows are in the albums table?
31

b. How many unique artist names are in the albums table?
23

c. What is the primary key for the albums table?
id

d. What is the oldest release date for any album in the albums table? What is the most recent release date?
Most recent release date: 2011
Oldest release date: 1967

*/

SELECT COUNT(*)
FROM albums;

SELECT COUNT(DISTINCT artist)
FROM albums;

SELECT *
FROM albums
ORDER BY release_date DESC;

SELECT *
FROM albums
ORDER BY release_date ASC;

/*
a.The name of all albums by Pink Floyd

The Dark Side of the Moon
The Wall

b. The year Sgt. Pepper's Lonely Hearts Club Band was released
1967

c. The genre for the album Nevermind
Grunge, Alternative rock

d. Which albums were released in the 1990s
The Immaculate Collection

e. Which albums had less than 20 million certified sales

"Grease: The Original Soundtrack from the Motion Picture"
"Bad"
"Sgt. Pepper's Lonely Hearts Club Band"
"Dirty Dancing"
"Let's Talk About Love"
"Dangerous"
"The Immaculate Collection"
"Abbey Road"
"Born in the U.S.A."
"Brothers in Arms"
"Titanic: Music from the Motion Picture"
"Nevermind"
"The Wall"

f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

Sgt. Pepper's Lonely Hearts Club Band"
"1"
"Abbey Road"
"Born in the U.S.A."
"Supernatural"

because Rock is categorized as a separate genre.

*/


SELECT 
	name
FROM albums
WHERE artist = 'Pink Floyd';

SELECT 
	release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT 
	genre
FROM albums
WHERE name = 'Nevermind';

SELECT
	name 
FROM albums
WHERE release_date = '1990';

SELECT 
	name 
FROM albums
WHERE sales < '20';

SELECT 
	name,
	genre 
FROM albums
WHERE genre = 'Rock';
