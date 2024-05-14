USE master;
GO
DROP DATABASE IF EXISTS JVGraph;
GO
CREATE DATABASE JVGraph;
GO

USE JVGraph;
GO

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    ID INT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Registration DATE
    ) AS NODE;

INSERT INTO Users (id, name, Email, Registration)
VALUES 
(1, 'John', 'john@example.com', '2024-04-25'),
(2, 'Alice', 'alice@example.com', '2024-04-25'),
(3, 'Bob', 'bob@example.com', '2024-04-25'),
(4, 'Emily', 'emily@example.com', '2024-04-25'),
(5, 'Michael', 'michael@example.com', '2024-04-25'),
(6, 'Sophia', 'sophia@example.com', '2024-04-25'),
(7, 'William', 'william@example.com', '2024-04-25'),
(8, 'Olivia', 'olivia@example.com', '2024-04-25'),
(9, 'James', 'james@example.com', '2024-04-25'),
(10, 'Emma', 'emma@example.com', '2024-04-25');

SELECT *
FROM Users

DROP TABLE IF EXISTS Travel;
CREATE TABLE Travel (
    ID INT PRIMARY KEY NOT NULL,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
    ) AS NODE;

INSERT INTO Travel (ID, City, Country)
VALUES 
(1, 'Paris', 'France'),
(2, 'Rome', 'Italy'),
(3, 'Tokyo', 'Japan'),
(4, 'New York', 'USA'),
(5, 'London', 'UK'),
(6, 'Barcelona', 'Spain'),
(7, 'Sydney', 'Australia'),
(8, 'Berlin', 'Germany'),
(9, 'Dubai', 'UAE'),
(10, 'Moscow', 'Russia');

SELECT *
FROM Travel

DROP TABLE IF EXISTS Place;
CREATE TABLE Place (
    ID INT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    Rating INT,
    Comment TEXT
    ) AS NODE;

INSERT INTO Place (ID, name, Rating, Comment)
VALUES 
(1, 'Eiffel Tower', 5, 'Amazing view of Paris.'),
(2, 'Colosseum', 4, 'Historical landmark in Rome.'),
(3, 'Mount Fuji', 5, 'Breathtaking scenery in Japan.'),
(4, 'Statue of Liberty', 4, 'Iconic symbol of freedom in the USA.'),
(5, 'Big Ben', 4, 'Famous clock tower in London.'),
(6, 'Sagrada Família', 4, 'Gaudí masterpiece in Barcelona.'),
(7, 'Sydney Opera House', 5, 'Iconic performing arts center in Australia.'),
(8, 'Brandenburg Gate', 4, 'Historic landmark in Berlin.'),
(9, 'Burj Khalifa', 5, 'Tallest building in the world located in Dubai.'),
(10, 'Red Square', 4, 'Historic square in Moscow.');

SELECT *
FROM Place

CREATE TABLE Publishing ([date] date) AS EDGE;
SELECT *
FROM Publishing

CREATE TABLE Subscribing AS EDGE;;
SELECT *
FROM Subscribing

CREATE TABLE Reading ([date] date) AS EDGE;
SELECT *
FROM Reading

INSERT INTO Publishing ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Place WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Place WHERE ID = 1), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Place WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Place WHERE ID = 2), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Place WHERE ID = 3), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Place WHERE ID = 3), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Place WHERE ID = 4), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Place WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Place WHERE ID = 9), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Place WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Place WHERE ID = 9), '2022-07-05 14:30:00');
 GO
SELECT *
FROM Publishing;

INSERT INTO Subscribing ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Users WHERE id = 1),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 10),
 (SELECT $node_id FROM Users WHERE id = 5)),
 ((SELECT $node_id FROM Users WHERE id = 2),
 (SELECT $node_id FROM Users WHERE id = 9)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 1)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 6)),
 ((SELECT $node_id FROM Users WHERE id = 4),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 5),
 (SELECT $node_id FROM Users WHERE id = 4)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 7)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 8)),
 ((SELECT $node_id FROM Users WHERE id = 8),
 (SELECT $node_id FROM Users WHERE id = 3));
GO
SELECT *
FROM Subscribing;

INSERT INTO Reading ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Travel WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Travel WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Travel WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Travel WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Travel WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Travel WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Travel WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Travel WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Travel WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Travel WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Travel WHERE ID = 9), '2021-11-10 09:45:00');
 GO
SELECT *
FROM Reading;

SELECT [User].name, T.city
FROM Users AS [User]
	, Reading
	, Travel AS T
WHERE MATCH([User]-(Reading)->T)
	AND [User].name = 'John';

SELECT u.name, pl.rating, p.date
FROM Users u
	, Publishing p
	, Place pl
WHERE MATCH(u-(p)->pl)
AND p.date > '2022-05-10';

SELECT u.name, T.city, r.date
FROM Users AS u
	, Reading AS r
	, Travel AS T
WHERE MATCH(u-(r)->T)
AND r.date > '2021-09-10';

SELECT u1.name, u2.name
FROM Users AS u1
	, Subscribing AS s
	, Users AS u2
WHERE MATCH(u1-(s)->u2)
	AND u1.name = 'Sophia';

SELECT u.name, pl.rating, p.date
FROM Users u
	, Publishing p
	, Place pl
WHERE MATCH(u-(p)->pl)
AND pl.rating > 3

SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Subscriptions
FROM Users AS User1
 , Subscribing FOR PATH AS s
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(s)->User2)+))
 AND User1.name = 'Sophia';

SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Subscriptions
FROM Users AS User1
 , Subscribing FOR PATH AS s
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(s)->User2){1,3}))
 AND User1.name = 'Sophia';

SELECT User1.id AS IdFirst
	, User1.name AS First
	, CONCAT(N'user', User1.id) AS [First image name]
	, User2.id AS IdSecond
	, User2.name AS Second
	, CONCAT(N'user', User2.id) AS [Second image name]
FROM Users AS User1
 , Subscribing AS s
 , Users AS User2
WHERE MATCH(User1-(s)->User2);

SELECT [User].id AS IdFirst
	, [User].name AS First
	, CONCAT(N'user', [User].id) AS [First image name]
	, pl.id AS IdSecond
	, pl.rating AS Second
	, CONCAT(N'place', pl.id) AS [Second image name]
FROM Users AS [User]
	, Publishing AS p
	, Place AS pl
WHERE MATCH([User]-(p)->pl);

SELECT [User].id AS IdFirst
	, [User].name AS First
	, CONCAT(N'user', [User].id) AS [First image name]
	, T.id AS IdSecond
	, T.city AS Second
	, CONCAT(N'travel', T.id) AS [Second image name]
FROM Users AS [User]
	, Reading AS rr
	, Travel AS T
WHERE MATCH([User]-(rr)->T);