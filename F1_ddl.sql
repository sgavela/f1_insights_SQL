CREATE DATABASE F1;

USE F1;

CREATE TABLE Constructor (
   Id INT IDENTITY,
   [Name] NVARCHAR(40) NOT NULL,
   Nationality NVARCHAR(40) NOT NULL,

   CONSTRAINT pk_constructor PRIMARY KEY (Id)
);

CREATE TABLE "Driver" (
   Id INT IDENTITY,
   Ref NVARCHAR(40) UNIQUE NOT NULL,
   Number INT,
   [Name] NVARCHAR(40) NOT NULL,
   Surname NVARCHAR(40) NOT NULL,
   Nationality NVARCHAR(40) NOT NULL,

   CONSTRAINT pk_Driver PRIMARY KEY (Id)
);

CREATE TABLE "Driver_Constructor" (
	Id_Driver INT,
	Id_Constructor INT,
	Season INT,

	CONSTRAINT pk_Driver_Constructor PRIMARY KEY(Id_Driver, Id_Constructor, Season),
	CONSTRAINT fk_Driver_Constructor_Id_Driver FOREIGN KEY (Id_Driver) REFERENCES Driver(Id),
	CONSTRAINT fk_Driver_Constructor_Id_Constructor FOREIGN KEY (Id_Constructor) REFERENCES Constructor(Id)
);

CREATE TABLE "Circuit" (
	Id INT IDENTITY,
	Ref NVARCHAR(40) UNIQUE NOT NULL,
	[Location] NVARCHAR(40) NOT NULL,
	Country NVARCHAR(40) NOT NULL,

	CONSTRAINT pk_Circuit PRIMARY KEY(Id)
);

CREATE TABLE "Race" (
	Id INT IDENTITY,
	[Round] INT NOT NULL,
	[Name] NVARCHAR(40) NOT NULL,
	[Date] DATE NOT NULL,
	Season INT NOT NULL,
	Id_Circuit INT,

	CONSTRAINT pk_Race PRIMARY KEY(Id),
	CONSTRAINT fk_Race_Id_Circuit FOREIGN KEY (Id_Circuit) REFERENCES Circuit(Id)
);

CREATE TABLE "Status" (
	Id INT IDENTITY,
	Status_ref NVARCHAR(40) NOT NULL,

	CONSTRAINT pk_Status PRIMARY KEY (Id)
);

CREATE TABLE "Result" (
	Id INT IDENTITY,
	Grid_quali INT NOT NULL,
	PositionText NVARCHAR(40) NOT NULL,
	PositionOrder INT NOT NULL,
	Points INT NOT NULL,
	Laps INT NOT NULL,
	Miliseconds FLOAT,
	FastestLap INT,
	FastestLapTime FLOAT,
	FastestLapSpeed FLOAT,
	Id_Status INT NOT NULL,
	Id_Race INT NOT NULL,
	Id_Driver INT NOT NULL,

	CONSTRAINT pk_Result PRIMARY KEY (Id),
	CONSTRAINT fk_Result_Id_Status FOREIGN KEY(Id_Status) REFERENCES [Status](Id),
	CONSTRAINT fk_Result_Id_Race FOREIGN KEY(Id_Race) REFERENCES Race(Id),
	CONSTRAINT fk_Result_Id_Driver FOREIGN KEY(Id_Driver) REFERENCES Driver(Id)
);
