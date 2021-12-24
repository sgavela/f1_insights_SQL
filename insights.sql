USE F1;

--1
SELECT *
FROM Circuit
WHERE Country = 'Spain'

--2
SELECT Driver.Id, Driver.[Name], Driver.Surname
FROM Driver
LEFT JOIN Driver_Constructor
ON Driver.Id = Driver_Constructor.Id_Driver
LEFT JOIN Constructor 
ON Driver_Constructor.Id_Constructor = Constructor.Id
WHERE Constructor.[Name] = 'Ferrari' AND Season = 2009 
ORDER BY Driver.[Name] DESC

--3
SELECT TOP 1 [Name], [Date]
FROM Race
ORDER BY [Date] DESC

--4
SELECT ROUND(AVG(CAST(positionOrder AS FLOAT)),2) AS Posicion_media_hamilton
FROM Driver
LEFT JOIN Result
ON Driver.Id = Result.Id_Driver
WHERE Driver.Ref = 'hamilton'

--5
SELECT TOP 1 Driver.Ref AS Driver, COUNT(*) AS num_carreras
FROM Driver
LEFT JOIN Result
ON Driver.Id = Result.Id_Driver
GROUP BY Driver.Ref
ORDER BY num_carreras DESC

--6
--Ningún piloto ha participado en 20 temporadas o más
SELECT Driver_Season.Driver, COUNT(*) AS num_seasons
FROM (
	SELECT DISTINCT Driver.Ref AS Driver, Driver_Constructor.Season 
	FROM Driver
	LEFT JOIN Driver_Constructor
	ON Driver.Id = Driver_Constructor.Id_Driver
) AS Driver_Season
GROUP BY Driver_Season.Driver
HAVING COUNT(*) >= 20

--7
SELECT [Name], Surname
FROM Driver
WHERE Driver.[Name] LIKE 'Joe%'
ORDER BY Surname DESC

--8
SELECT Driver.Ref, Race.Season, SUM(Result.Points) AS Puntos_Alonso
FROM Driver
LEFT JOIN Result
ON Driver.Id = Result.Id_Driver
LEFT JOIN Race
ON Result.Id_Race = Race.Id
WHERE Driver.Ref = 'alonso' AND Season = 2005
GROUP BY Driver.Ref, Race.Season

--9
SELECT DISTINCT Driver.[Name], Driver.Surname, Season
FROM Driver
LEFT JOIN Driver_Constructor
On Driver.Id = Driver_Constructor.Id_Driver
LEFT JOIN Constructor
ON Driver_Constructor.Id_Constructor = Constructor.Id
WHERE Constructor.[Name] = 'Renault'

--10
--Alonso superó en 12 puntos a Hamilton
SELECT 
	(SELECT SUM(Result.Points)  
	FROM Driver
	LEFT JOIN Result
	ON Driver.Id = Result.Id_Driver
	LEFT JOIN Race
	ON Result.Id_Race = Race.Id
	WHERE Driver.Ref = 'alonso' AND Season = 2010
	GROUP BY Driver.Ref, Race.Season)
-
	(SELECT SUM(Result.Points) 
	FROM Driver
	LEFT JOIN Result
	ON Driver.Id = Result.Id_Driver
	LEFT JOIN Race
	ON Result.Id_Race = Race.Id
	WHERE Driver.Ref = 'hamilton' AND Season = 2010
	GROUP BY Driver.Ref, Race.Season) AS Diferencia_Alonso_Hamilton
