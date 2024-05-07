-- Drop table
DROP TABLE IF EXISTS EndScores;
DROP TABLE IF EXISTS Staging;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS DefaultEquipment;
DROP TABLE IF EXISTS Rounds;
DROP TABLE IF EXISTS ClubCompetition;
DROP TABLE IF EXISTS EquipmentDescription;
DROP TABLE IF EXISTS ArcherInfo;

-- TABLES
-- ArcherInfo_Table
CREATE TABLE ArcherInfo (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Gender ENUM('M', 'F'),
    DOB DATE
) AUTO_INCREMENT=10000;

-- Round_Table
CREATE TABLE Rounds(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    RoundName VARCHAR(255) NOT NULL,
    TotalArrows CHAR(10) DEFAULT '0',
    TotalPossibleScores CHAR(10) DEFAULT '0'
) AUTO_INCREMENT=10000;



-- Equipment description
CREATE TABLE EquipmentDescription(
    Equipment VARCHAR(5) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    PRIMARY KEY (Equipment)
);

-- Default Equipment
CREATE TABLE DefaultEquipment(
    RoundID INT NOT NULL,
    Category VARCHAR(255) NOT NULL,
    Equipment VARCHAR(5) NOT NULL,
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (Equipment) REFERENCES EquipmentDescription(Equipment)
);

-- Club Competition
CREATE TABLE ClubCompetition(
    ID INT NOT NULL AUTO_INCREMENT,
    CompetitionName VARCHAR(255),
    Championship VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (ID)
) AUTO_INCREMENT = 10000;

-- Category
CREATE TABLE Category (
    ID INT NOT NULL AUTO_INCREMENT,
    ArcherID INT NOT NULL,
    CompetitionID INT NOT NULL,
    RoundID INT NOT NULL,
    Classification  VARCHAR(255) NOT NULL,
    RegisterYear YEAR,
    PRIMARY KEY (ID),
    FOREIGN KEY (ArcherID) REFERENCES ArcherInfo(ID),
    FOREIGN KEY (CompetitionID) REFERENCES ClubCompetition(ID),
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID)
) AUTO_INCREMENT = 30000;

CREATE TABLE Ranges(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Distance ENUM('10m','20m','30m','40m','50m','60m','70m','90m')
    ) AUTO_INCREMENT = 100000;

-- ArrowScore_Table
CREATE TABLE EndScores(
    ID INT NOT NULL AUTO_INCREMENT,
    ArcherID INT NOT NULL,
    CategoryID INT NOT NULL,
    EndNo INT NOT NULL,
    ScoreDateTime DATETIME NOT NULL,  
    RangeID INT NOT NULL,
    Score INT NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (CategoryID) REFERENCES Category(ID),
    FOREIGN KEY (ArcherID) REFERENCES ArcherInfo(ID),
    FOREIGN KEY (RangeID) REFERENCES Ranges(ID)
    ) AUTO_INCREMENT = 100000;
    

    CREATE TABLE RoundArrows(
    RoundID INT NOT NULL AUTO_INCREMENT,
    RangeID INT NOT NULL,
    ArrowsNo INT NOT NULL,
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (RangeID) REFERENCES Ranges(ID)
    ) AUTO_INCREMENT = 100000;
