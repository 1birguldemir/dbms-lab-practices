CREATE DATABASE MoviesDB;
GO
USE MoviesDB;
GO

CREATE TABLE Genres (GenreID INT, GenreName NVARCHAR(50));
CREATE TABLE Directors (DirectorID INT, DirectorName NVARCHAR(50));
CREATE TABLE Actors (ActorID INT, ActorName NVARCHAR(50), Age INT);
CREATE TABLE Movies (MovieID INT, MovieName NVARCHAR(100), GenreID INT, Duration INT, ReleaseYear INT, DirectorID INT);
CREATE TABLE MovieActors (MovieID INT, ActorID INT);
CREATE TABLE Awards (AwardID INT, MovieID INT, AwardName NVARCHAR(100), Year INT);

INSERT INTO Genres VALUES (1, 'Animation'), (2, 'Musical'), (3, 'Horror'), (4, 'Drama'), (5, 'Sci-Fi');
INSERT INTO Directors VALUES (1, 'Adam Elliot'), (2, 'Kelsey Mann'), (3, 'Jon M. Chu'), (4, 'Coralie Fargeat'), (5, 'Christopher Nolan');
INSERT INTO Actors VALUES (1, 'Emma Stone', 35), (2, 'Amy Poehler', 52), (3, 'Cynthia Erivo', 37), (4, 'Demi Moore', 61), (5, 'Cillian Murphy', 47), (6, 'Florence Pugh', 28), (7, 'Timothée Chalamet', 28), (8, 'Zendaya', 27);
INSERT INTO Movies VALUES (1001, 'Memoir of a Snail', 1, 94, 2023, 1), (1002, 'Inside Out 2', 1, 96, 2024, 2), (1003, 'Wicked', 2, 160, 2024, 3), (1004, 'The Substance', 3, 142, 2024, 4), (1005, 'Oppenheimer', 4, 180, 2023, 5), (1006, 'Dune: Part Two', 5, 166, 2024, 5);
INSERT INTO MovieActors VALUES (1001, 1), (1002, 2), (1003, 3), (1004, 4), (1005, 5), (1005, 6), (1006, 7), (1006, 8), (1003, 7), (1004, 6);
INSERT INTO Awards VALUES (5001, 1001, 'Best Animated Feature', 2023), (5002, 1002, 'Best Sequel', 2024), (5003, 1003, 'Best Musical', 2024), (5004, 1005, 'Best Picture', 2023), (5005, 1006, 'Best Visual Effects', 2024), (5006, 1005, 'Best Director', 2023), (5007, 1005, 'Best Actor (Cillian Murphy)', 2023);