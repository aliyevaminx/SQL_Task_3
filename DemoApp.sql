CREATE DATABASE DemoApp

USE DemoApp

CREATE TABLE Countries (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	Area DECIMAL(18, 2)
)

INSERT INTO Countries
VALUES
('China', 38295523),
('USA', 9841955),
('Russia', 17125192),
('Brazil', 124124),
('UK', 244376),
('Italy', 301230),
('Spain',  505990),
('Japan', 377973)

CREATE TABLE Cities (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	Area DECIMAL(18, 2),
	CountryId INT,
	FOREIGN KEY(CountryId) REFERENCES Countries(Id)
)

INSERT INTO Cities
VALUES
('New York', 5136, 1),
('Moscow', 12263, 2),
('London', 57281, 3),
('Athens', 1232, NULL),
('Rome', 42125, 4),
('Ankara', 32432, NULL),
('Madrid',  5325, 5),
('Tokio', 28383, 6)

CREATE TABLE People (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	PhoneNumber NVARCHAR(50),
	Email NVARCHAR(50),
	BirthDate DATE,
	Gender NVARCHAR(5),
	HasCitizenship BIT,
	CityId INT,
	FOREIGN KEY (CityId) REFERENCES Cities(Id),
)

INSERT INTO People
VALUES
('Name1', 'Surname1', '+99455555555', 'name1@gmail.com', '2000-02-02', 'M', 0, 4),
('Name2', 'Surname2', '+99466666666', 'name2@gmail.com', '2000-03-03', 'F', 1, 7),
('Name3', 'Surname3', '+99477777777', 'name3@gmail.com', '2000-04-04', 'F', 0, 3),
('Name4', 'Surname4', '+99488888888', 'name4@gmail.com', '2000-05-05', 'M', 1, 2),
('Name5', 'Surname5', '+99488888888', 'name4@gmail.com', '2000-05-05', 'M', 1, 2),
('Name6', 'Surname6', '+99488888888', 'name4@gmail.com', '2000-05-05', 'M', 1, 2),
('Name7', 'Surname7', '+99488888888', 'name4@gmail.com', '2000-05-05', 'M', 1, 2)

SELECT * FROM Countries
SELECT * FROM Cities
SELECT * FROM People

SELECT 
    p.Id AS PersonId,
    p.Name AS PersonName,
    p.Surname AS PersonSurname,
    c.Name AS CountryName,
    ct.Name AS CityName
FROM 
    People p
JOIN 
    Cities ct ON p.CityId = ct.Id
JOIN 
    Countries c ON ct.CountryId = c.Id;


SELECT * FROM Countries
ORDER BY Area 

SELECT * FROM Cities
ORDER BY [Name] DESC

SELECT COUNT(*) AS CountryCount FROM Countries
WHERE Area > 20000

SELECT Max(Area) AS MaxArea FROM Countries
WHERE [Name] LIKE 'I%'

SELECT [Name] FROM Countries
UNION
SELECT [Name] FROM Cities

SELECT ct.Name AS CityName, COUNT(p.Id) AS PersonCount FROM People p
JOIN Cities ct ON p.CityId = ct.Id
GROUP BY ct.Name;

SELECT ct.Name AS CityName, COUNT(p.Id) AS PersonCount FROM People p
JOIN Cities ct ON p.CityId = ct.Id
GROUP BY ct.Name
HAVING COUNT(p.Id) > 2
--50000