DROP DATABASE csirt;
CREATE DATABASE csirt;
USE csirt;

CREATE TABLE HANDLER (
	handlerName VARCHAR(50) NOT NULL,
    CONSTRAINT Handler_PK PRIMARY KEY (handlerName)
);

CREATE TABLE INCIDENT (
    incidentID INTEGER NOT NULL,
    incidentType VARCHAR(50),
    creationDate DATE,
    incidentState VARCHAR(30),
    incidentName VARCHAR(40),
    handlerName VARCHAR(50) NOT NULL,
    associationID INTEGER,
    CONSTRAINT Incident_PK PRIMARY KEY (incidentID),
    CONSTRAINT Incident_FK1 FOREIGN KEY (handlerName)
		REFERENCES HANDLER (handlerName)
);

CREATE TABLE PERSON (
    associationID INTEGER NOT NULL,
    incidentID INTEGER,
    lastName VARCHAR(25),
    firstName VARCHAR(25),
    jobTitle VARCHAR(50),
    emailAddress VARCHAR(100),
    CONSTRAINT Person_PK PRIMARY KEY (associationID),
    CONSTRAINT Person_FK1 FOREIGN KEY (incidentID)
        REFERENCES INCIDENT (incidentID)
        ON DELETE CASCADE
);

CREATE TABLE COMMENT (
    commentID INTEGER NOT NULL,
    incidentID INTEGER NOT NULL,
    commentDescription VARCHAR(250),
    commentDate DATE,
    handlerName VARCHAR(50) NOT NULL,
    CONSTRAINT Comment_PK PRIMARY KEY (commentID),
    CONSTRAINT Comment_FK1 FOREIGN KEY (incidentID)
        REFERENCES INCIDENT (incidentID)
        ON DELETE CASCADE,
    CONSTRAINT Comment_FK2 FOREIGN KEY (handlerName)
        REFERENCES HANDLER (handlerName)
);

CREATE TABLE IPADDRESS (
    associationID INTEGER NOT NULL,
    IPAddress VARCHAR(32),
    incidentID INTEGER NOT NULL,
    CONSTRAINT IPAddress_PK PRIMARY KEY (associationID),
    CONSTRAINT IPAddress_FK1 FOREIGN KEY (associationID)
        REFERENCES PERSON (associationID),
    CONSTRAINT IPAddress_FK2 FOREIGN KEY (incidentID)
        REFERENCES INCIDENT (incidentID)
        ON DELETE CASCADE
);
ALTER TABLE INCIDENT
ADD CONSTRAINT Incident_FK2 FOREIGN KEY (associationID) 
	REFERENCES PERSON (associationID);

/****** INSERT STATEMENTS ******/
INSERT INTO HANDLER VALUES (
	'Steve Woz');
INSERT INTO HANDLER VALUES (
	'John Madoff');
INSERT INTO HANDLER VALUES (
	'Tim Apple');
    
INSERT INTO PERSON VALUES (
	7654, NULL, NULL, NULL, NULL, NULL);
INSERT INTO PERSON VALUES (
	3456, NULL, NULL, NULL, NULL, NULL);
INSERT INTO PERSON VALUES (
	6789, NULL, NULL, NULL, NULL, NULL);

INSERT INTO INCIDENT VALUES (
	222903, 'Malware', '2020-09-18', 'open', 'Computer Lab 12 Infected', 'Steve Woz', null);
INSERT INTO INCIDENT VALUES (
	222398, 'Corruption', '2019-10-31', 'stalled', 'Tim Laptop\'s Hard Drive', 'John Madoff', 7654); 
INSERT INTO INCIDENT VALUES (
	543267, 'Hardware Malfunction', '2018-11-20', 'closed', 'Angie\'s Dropped Laptop', 'Tim Apple', 3456);
INSERT INTO INCIDENT VALUES (
	726818, 'Theft of Property', '2020-12-20', 'closed', 'Frank\'s Laptop Not Returned in Time', 'John Madoff', 6789); 

UPDATE PERSON
SET incidentID = 222398, lastName = 'Claude', firstName = 'Tim', jobTitle = 'Accountant', emailAddress = 'timclaude45@gmail.com'
WHERE associationID = 7654;

UPDATE PERSON
SET incidentID = 543267, lastName = 'Rivera', firstName = 'Angie', jobTitle = 'Secretary', emailAddress = 'angierivera23@gmail.com'
WHERE associationID = 3456;

UPDATE PERSON
SET incidentID = 726818, lastName = 'Clinton', firstName = 'Frank', jobTitle = 'Developer', emailAddress = 'frankcliton12@gmail.com'
WHERE associationID = 6789;
    
INSERT INTO COMMENT VALUES (
	213433, 222903, 'The entire lab was infected with malware that encrypted the hard drives of each computer', '2020-09-20', 'Steve Woz');
INSERT INTO COMMENT VALUES (
	434411, 222398, 'Tim\'s laptop hard drive has been corrupted. Probably needs a fresh OS install', '2019-11-02', 'John Madoff');
INSERT INTO COMMENT VALUES (
	878987, 543267, 'Angie has dropped her laptop, breaking it. Needs a replacement', '2018-11-20', 'Tim Apple');
INSERT INTO COMMENT VALUES (
	878988, 543267, 'Angie has been given a new laptop. Issue is closed.', '2018-11-27', 'Tim Apple');

INSERT INTO IPADDRESS VALUES (
	7654, '145.10.34.3', 222398);
INSERT INTO IPADDRESS VALUES (
	3456, '127.255.255.255', 543267);
INSERT INTO IPADDRESS VALUES (
	6789, '191.255.130.332', 726818);
    
SELECT 
    *
FROM
    INCIDENT;
SELECT 
    *
FROM
    PERSON;
SELECT 
    *
FROM
    COMMENT;
SELECT 
    *
FROM
    IPADDRESS;