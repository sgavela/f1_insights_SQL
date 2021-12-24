USE F1;

SET IDENTITY_INSERT Constructor  ON;

INSERT INTO Constructor (Id, [Name], Nationality) 
SELECT constructorId, constructorName, constructorNationality
FROM f1_results
GROUP BY constructorId, constructorName, constructorNationality;

SET IDENTITY_INSERT Constructor OFF;
SET IDENTITY_INSERT Driver ON;

INSERT INTO Driver (Id, Ref, Number, [Name], Surname, Nationality) 
SELECT driverId, driverRef, driverNumber, driverName, driverSurname, driverNationality
FROM f1_results
GROUP BY driverId, driverRef, driverNumber, driverName, driverSurname, driverNationality;

SET IDENTITY_INSERT Driver OFF;

INSERT INTO Driver_Constructor (Id_Driver, Id_Constructor, Season)
SELECT driverId, constructorId, season
FROM f1_results
GROUP BY driverId, constructorId, season;

SET IDENTITY_INSERT Circuit ON;

INSERT INTO Circuit (Id, Ref, [Location], Country)
SELECT circuitId, circuitRef, circuitLocation, circuitCountry
FROM f1_results
GROUP BY circuitId, circuitRef, circuitLocation, circuitCountry;

SET IDENTITY_INSERT Circuit OFF;
SET IDENTITY_INSERT Race ON;

INSERT INTO Race (Id, [Round], [Name], [Date], Season, Id_Circuit)
SELECT raceId, raceRound, raceName, raceDate, season, circuitId
FROM f1_results
GROUP BY raceId, raceRound, raceName, raceDate, season, circuitId;

SET IDENTITY_INSERT Race OFF;
SET IDENTITY_INSERT [Status] ON;

INSERT INTO [Status] (Id, Status_ref)
SELECT statusId, [status]
FROM f1_results
GROUP BY statusId, [status]

SET IDENTITY_INSERT [Status] OFF;
SET IDENTITY_INSERT Result ON;

INSERT INTO Result (Id, Grid_quali, PositionText, PositionOrder, Points, Laps, Miliseconds, FastestLap, FastestLapTime, FastestLapSpeed, Id_Status, Id_Race, Id_Driver)
SELECT resultId, gridQuali, positionText, positionOrder, points, laps, milliseconds, fastestLap, fastestLapTime, fastestLapSpeed, statusId, raceId, driverId
FROM f1_results
GROUP BY resultId, gridQuali, positionText, positionOrder, points, laps, milliseconds, fastestLap, fastestLapTime, fastestLapSpeed, statusId, raceId, driverId;

SET IDENTITY_INSERT Result OFF