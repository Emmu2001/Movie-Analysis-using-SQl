CREATE TABLE movies
(
 movieid NUMERIC(100),
 title VARCHAR(200),
PRIMARY KEY(movieid)
);
SELECT *FROM movies

CREATE TABLE genres
(
	genresid NUMERIC(100),
	genrestype VARCHAR(100),
	PRIMARY KEY(genresid)
);
SELECT *FROM genres


CREATE TABLE genresids
(
	genresids NUMERIC(100),
	movieid NUMERIC(100),
	genresid NUMERIC(100),
	PRIMARY KEY(genresids),
	FOREIGN KEY (genresid) references genres
		ON DELETE SET NULL,
	FOREIGN KEY (movieid) references movies
		ON DELETE SET NULL
	
);
SELECT *FROM genresids


CREATE TABLE rating
(
	ratingid NUMERIC(100),
	movieid NUMERIC(100),
	userid NUMERIC(100),
	rating NUMERIC(10,2),
	timestamp NUMERIC(100),
	PRIMARY KEY(ratingid),
	FOREIGN KEY (movieid) references movies
		ON DELETE SET NULL
	
);
SELECT *FROM rating


CREATE TABLE tags
(
	tagsid NUMERIC(100),
	userid NUMERIC(100),
	movieid NUMERIC(100),
	tag VARCHAR(100),
	timestamp NUMERIC(100),
	PRIMARY KEY(tagsid),
	FOREIGN KEY (movieid) references movies
		ON DELETE SET NULL,
	FOREIGN KEY (userid) references rating
		ON DELETE SET NULL
	
);
SELECT *FROM tags


CREATE TABLE link
(
	linkid NUMERIC(100),
	movieid NUMERIC(100),
	imdbld NUMERIC(100),
	tmdbld NUMERIC(100),
	PRIMARY KEY(linkid),
	FOREIGN KEY (movieid) references movies
		ON DELETE SET NULL
	
);
SELECT *FROM link


CREATE TABLE scores
(
	scoreid NUMERIC(100),
	movieid NUMERIC(100),
	tagsid NUMERIC(100),
	relevance NUMERIC(10,5),
	PRIMARY KEY(scoreid),
	FOREIGN KEY (movieid) references movies
		ON DELETE SET NULL,
	FOREIGN KEY (tagsid) references tags
		ON DELETE SET NULL
);
SELECT *FROM scores

/**/Q.Display the title of the movie whose ratings are equal to 5. 
SELECT DISTINCT m.title
FROM rating r, movies m
WHERE r.rating=5.00
AND r.movieid=m.movieid

/**/Q.Display the title of the movie whose genres are Adventure
SELECT DISTINCT m.title 
FROM genres g,movies m, genresids gs
WHERE g.genrestype='Adventure'
AND gs.movieid=m.movieid

/*Q.Display the tag of the movie'Georgia (1995)’*/
SELECT DISTINCT t.tag,m.title
FROM movies m,tags t
WHERE m.movieid=t.movieid
AND m.title='Georgia (1995)'

/*Q.Display the title and rating of the movie*/
SELECT DISTINCT title,rating
FROM movies NATURAL JOIN rating

/*Q.Display title and tmdbld of the imdbld=‘113987’.*/
SELECT DISTINCT m.title,l.imdbld,l.tmdbld
FROM movies m,link l
WHERE l.imdbld='113987'
AND m.movieid=l.movieid


/*Q.Display the title and tag of the movie whose ratings are equal to 2.*/ 
SELECT COUNT(m.title)
FROM movies m,rating r,tags t 
WHERE r.rating=2.00
AND r.movieid=m.movieid
AND t.movieid=m.movieid
GROUP BY t.tag
