DROP DATABASE IF EXISTS `471`;
CREATE DATABASE `471` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `471`;


DROP TABLE IF EXISTS USER;
CREATE TABLE USER
	(Username		VARCHAR(255)		NOT NULL,
	 SSN			INT					NOT NULL,
	 Password		VARCHAR(255)		NOT NULL,
	 Fname			VARCHAR(255)		NOT NULL,
	 Lname			VARCHAR(255)		NOT NULL,
	 Bdate			DATE				NOT NULL,
	 Sex			CHAR,
	PRIMARY KEY (Username, SSN)
);

DROP TABLE IF EXISTS STAFF;
CREATE TABLE STAFF
	(Username		VARCHAR(255)		NOT NULL,
	 SSN			INT					NOT NULL,
	 Job			VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Username, SSN),
	FOREIGN KEY (Username, SSN) REFERENCES USER(Username, SSN)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

CREATE TABLE PASSENGER
	(P_ID			INT			NOT NULL,
	 Passport_Num	VARCHAR(255)		NOT NULL,
	PRIMARY KEY (P_ID, Passport_Num)
);


CREATE TABLE PURCHASER
	(Username		VARCHAR(255)		NOT NULL,
	 SSN			INT			NOT NULL,
	 P_ID			INT,
	PRIMARY KEY (Username, SSN),
	FOREIGN KEY (Username) REFERENCES USER(Username)
	ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (Username, SSN) REFERENCES USER(Username, SSN)
		ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (P_ID) REFERENCES PASSENGER(P_ID)
		ON DELETE SET NULL		ON UPDATE CASCADE
);

CREATE TABLE OTHER_TICKET_RECIPIENT
	(PUsername		VARCHAR(255)		NOT NULL,
	 SSN			INT			NOT NULL,
	 Fname		VARCHAR(255)		NOT NULL,
	 Lname		VARCHAR(255)		NOT NULL,
	 Bdate			DATE			NOT NULL,
	 Sex			CHAR,
 	 P_ID			INT,
	PRIMARY KEY (PUsername, SSN),
	FOREIGN KEY (PUsername) REFERENCES PURCHASER(Username)
		ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (P_ID) REFERENCES PASSENGER(P_ID)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

CREATE TABLE RUNWAY
	(Runway_Number	VARCHAR(255)		NOT NULL,
	 Runway_Length	INT			NOT NULL,
	PRIMARY KEY (Runway_Number)
);

CREATE TABLE GATE
	(Gate_Number	VARCHAR(255)		NOT NULL,
	 Location		VARCHAR(255)		NOT NULL,
	 Size			VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Gate_Number)
);

CREATE TABLE AIRLINE
	(Name		VARCHAR(255)		NOT NULL,
	 Country		VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Name)
);

CREATE TABLE PLANE
	(Plane_Serial	VARCHAR(255)		NOT NULL,
	 Tank_Size		INT			NOT NULL,
	 Passenger_Capacity	INT		NOT NULL,
	 Type			VARCHAR(255)		NOT NULL,
	 Airline_Name	VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Plane_Serial),
	FOREIGN KEY (Airline_Name) REFERENCES AIRLINE(Name)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

CREATE TABLE FLIGHT
	(Flight_Number	INT			NOT NULL	AUTO_INCREMENT,
	 Departure_Time	DATETIME		NOT NULL,
	 Arrival_Time 	DATETIME		NOT NULL,
 Airline_Name	VARCHAR(255)		NOT NULL,
 Plane_Serial 	VARCHAR(255)		NOT NULL,
 Arrival_Runway	VARCHAR(255),
 Depart_Runway	VARCHAR(255),
 Gate_Number	VARCHAR(255)		NOT NULL,
PRIMARY KEY (Flight_Number),
FOREIGN KEY (Airline_Name) REFERENCES AIRLINE(Name)
ON DELETE CASCADE		ON UPDATE CASCADE,
FOREIGN KEY (Plane_Serial) REFERENCES PLANE(Plane_Serial)
	ON DELETE CASCADE		ON UPDATE CASCADE,
FOREIGN KEY (Arrival_Runway) REFERENCES RUNWAY(Runway_Number)
	ON DELETE CASCADE		ON UPDATE CASCADE,
FOREIGN KEY (Depart_Runway) REFERENCES RUNWAY(Runway_Number)
	ON DELETE CASCADE		ON UPDATE CASCADE,
FOREIGN KEY (Gate_Number) REFERENCES GATE(Gate_Number)
	ON DELETE CASCADE		ON UPDATE CASCADE);
    
CREATE TABLE FUEL
	(Type			VARCHAR(255)		NOT NULL,
	 Price			INT			NOT NULL,
	PRIMARY KEY (Type)
);

CREATE TABLE TICKET
(Ticket_Number	INT		NOT NULL AUTO_INCREMENT,
	P_ID 			INT 	NOT NULL,
	 Price			INT		NOT NULL,
	 Recipient_Pass	VARCHAR(255)	NOT NULL,
	 Flight_Number	INT		NOT NULL,
	PRIMARY KEY (Ticket_Number),
FOREIGN KEY (P_ID, Recipient_Pass) REFERENCES PASSENGER(P_ID, Passport_Num)
	ON DELETE CASCADE		ON UPDATE CASCADE,
FOREIGN KEY (Flight_Number) REFERENCES FLIGHT(Flight_Number)
	ON DELETE CASCADE		ON UPDATE CASCADE
);


CREATE TABLE PREPARE
	(Username		VARCHAR(255)		NOT NULL,
	 Gate_Number	VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Username, Gate_Number),
	FOREIGN KEY (Username) REFERENCES STAFF(Username)
		ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (Gate_Number) REFERENCES GATE(Gate_Number)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

CREATE TABLE OPERATES
	(Username		VARCHAR(255)		NOT NULL,
	 Plane_Serial 	VARCHAR(255) 		NOT NULL,
	PRIMARY KEY (Username, Plane_Serial),
	FOREIGN KEY (Username) REFERENCES STAFF(Username)
		ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (Plane_Serial) REFERENCES PLANE(Plane_Serial)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

CREATE TABLE REQUIRES
	(Plane_Serial	VARCHAR(255)		NOT NULL,
	 Fuel_Type		VARCHAR(255)		NOT NULL,
	PRIMARY KEY (Plane_Serial, Fuel_Type),
	FOREIGN KEY (Plane_Serial) REFERENCES PLANE(Plane_Serial)
		ON DELETE CASCADE		ON UPDATE CASCADE,
	FOREIGN KEY (Fuel_Type) REFERENCES FUEL(Type)
		ON DELETE CASCADE		ON UPDATE CASCADE
);

-- Inserting Fake Data
INSERT INTO USER (Username, SSN, Password, Fname, Lname, Bdate, Sex) VALUE 
('user123', 123456789, 'password123', 'Fanny', 'Longbottom', '2002-02-02','F'),
('funny', 666666666, 'pass', 'Mahmood', 'Moussavi', '1900-09-09', 'M');

INSERT INTO STAFF (Username, SSN, Job) VALUE
('funny', 666666666, 'PlaceholderJob');

INSERT INTO PASSENGER (P_ID, Passport_Num) VALUE
(111111111, 'AAAAAA');

INSERT INTO PURCHASER (Username, SSN, P_ID) VALUE
('user123', 123456789, 111111111);

INSERT INTO AIRLINE (Name, Country) VALUE 
('Data Airlines', 'Canada'),
('Korean Airlines', 'North Korea');

INSERT INTO FUEL (Type, Price) VALUE
('Jet Fuel', 1000),
('AVGAS', 2000);

INSERT INTO PLANE (Plane_Serial, Tank_Size, Passenger_Capacity, Type, Airline_Name) VALUE 
('PS2222', 5000, 100, 'AVGAS', 'Korean Airlines'),
('PS4444', 10000, 350, 'Jet Fuel', 'Data Airlines');

INSERT INTO GATE (Gate_Number, Location, Size) VALUE 
('B7','South B Exit','Medium'),
('C4', 'North C Entrance', 'Large');

INSERT INTO RUNWAY (Runway_Number, Runway_Length) VALUE 
('06L', 1000),
('22R', 1500);

INSERT INTO FLIGHT (Departure_Time, Arrival_Time, Airline_Name, Plane_Serial, Arrival_Runway, Depart_Runway, Gate_Number) VALUE 
('2022-12-10 01:00:00', '2022-12-10 01:00:00', 'Korean Airlines', 'PS4444', '06L', '06L', 'C4');


