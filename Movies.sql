CREATE TABLE Movies (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50),
	ReleaseDate DATE,
	IMDB INT
)

INSERT INTO Movies 
VALUES 
	('Inception', '2010-07-16', 8.8),
	('The Dark Knight', '2008-07-18', 9.0),
	('Interstellar', '2014-11-07', 8.6),
	('Dune', '2021-10-22', 8.1),
	('Upcoming Movie', '2024-12-25', NULL);


CREATE TABLE Actors (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50),
	Surname NVARCHAR(50)
)

INSERT INTO Actors
VALUES 
	('Leonardo', 'DiCaprio'),
	('Christian', 'Bale'),
	('Matthew', 'McConaughey'),
	('Timothée', 'Chalamet'),
	('Zendaya', NULL);


CREATE TABLE Genres (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50)
)

INSERT INTO Genres
VALUES 
	('Action'),
	('Adventure'),
	('Sci-Fi'),
	('Drama');

CREATE TABLE MoviesActors (
	MovieId INT,
	ActorId INT,
	FOREIGN KEY (MovieId) REFERENCES Movies(Id),
	FOREIGN KEY (ActorId) REFERENCES Actors(Id)
)

INSERT INTO MoviesActors 
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(4, 5),
(1, 3)


CREATE TABLE MoviesGenres (
	MovieId INT,
	GenreId INT,
	FOREIGN KEY (MovieId) REFERENCES Movies(Id),
	FOREIGN KEY (GenreId) REFERENCES Genres(Id)
)

INSERT INTO MoviesGenres 
VALUES 
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(4, 3),
(1, 1)

SELECT * FROM  Movies
SELECT * FROM  Actors
SELECT * FROM  Genres
SELECT * FROM  MoviesActors
SELECT * FROM  MoviesGenres

SELECT  a.Name, a.Surname, COUNT(ma.MovieId) AS RoleCount
FROM Actors a
JOIN MoviesActors ma ON a.Id = ma.ActorId
GROUP BY a.Name, a.Surname
ORDER BY RoleCount DESC

SELECT g.Name AS GenreName, COUNT(mg.MovieId) AS MovieCount
FROM Genres g
JOIN MoviesGenres mg ON g.Id = mg.GenreId
GROUP BY g.Name

SELECT m.Name AS MovieName, ReleaseDate
FROM Movies m
WHERE ReleaseDate > GETDATE()

SELECT IMDB
FROM  Movies
WHERE DATEDIFF(year, ReleaseDate, GETDATE()) <= 5

SELECT a.Name, a.Surname, COUNT(ma.MovieId) AS MovieCount
FROM Actors a
JOIN MoviesActors ma ON a.Id = ma.ActorId
GROUP BY a.Name, a.Surname
HAVING COUNT(ma.MovieId) > 1;
