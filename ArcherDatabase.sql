-- Drop table
DROP TABLE IF EXISTS EndScores;
DROP TABLE IF EXISTS Staging;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS DefaultEquipment;
DROP TABLE IF EXISTS Rounds;
DROP TABLE IF EXISTS ClubCompetition;
DROP TABLE IF EXISTS EquipmentDescription;
DROP TABLE IF EXISTS ArcherInfo;
DROP TABLE IF EXISTS Classification;
DROP TABLE IF EXISTS Face;
DROP TABLE IF EXISTS Division;
DROP TABLE IF EXISTS Ranges;


CREATE TABLE Classification(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    MinimumAge INT NOT NULL,
    MaaximumAge INT NOT NULL,
    Gender ENUM('M', 'F'),
    Description VARCHAR(255) NOT NULL
    
    );

CREATE UNIQUE INDEX IDX_Description ON Classification(Description);

CREATE TABLE Face(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FaceSymbol ENUM('+','*'),
    FaceSize ENUM('120cm','80cm')
    );

CREATE UNIQUE INDEX IDX_FaceSymbol ON Face(FaceSymbol);

-- TABLES
-- ArcherInfo_Table
CREATE TABLE ArcherInfo (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Gender ENUM('M', 'F'),
    DOB DATE
);

-- Round_Table
CREATE TABLE Rounds(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    RoundName VARCHAR(255) NOT NULL,
    TotalArrows CHAR(10) DEFAULT '0',
    TotalPossibleScores CHAR(10) DEFAULT '0'
);



-- Equipment description
CREATE TABLE Division(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Equipment VARCHAR(5) NOT NULL,
    Description VARCHAR(255) NOT NULL
);

-- Club Competition
CREATE TABLE ClubCompetition(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CompetitionName VARCHAR(255),
    Championship VARCHAR(255) DEFAULT NULL
 
);

CREATE TABLE Ranges(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Distance ENUM('10m','20m','30m','40m','50m','60m','70m','90m')
    );

-- Default Equipment
CREATE TABLE DefaultEquipment(
    RoundID INT NOT NULL,
    ClassificationID INT NOT NULL,
    DivisionID INT NOT NULL,
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (DivisionID) REFERENCES Division(ID),
    FOREIGN KEY (ClassificationID) REFERENCES Classification(ID)
);



-- Category
CREATE TABLE Category (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ArcherID INT NOT NULL,
    CompetitionID INT NOT NULL,
    RoundID INT NOT NULL,
    ClassificationID  INT NOT NULL,
    RegisterYear YEAR,
    DivisionID INT NOT NULL,
    
    FOREIGN KEY (ArcherID) REFERENCES ArcherInfo(ID),
    FOREIGN KEY (CompetitionID) REFERENCES ClubCompetition(ID),
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (DivisionID) REFERENCES Division(ID),
    FOREIGN KEY (ClassificationID) REFERENCES Classification(ID)
);



-- ArrowScore_Table
CREATE TABLE EndScores(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ArcherID INT NOT NULL,
    CategoryID INT NOT NULL,
    EndNo INT NOT NULL,
    ScoreDateTime DATETIME NOT NULL,  
    RangeID INT NOT NULL,
    Score INT NOT NULL,

    FOREIGN KEY (CategoryID) REFERENCES Category(ID),
    FOREIGN KEY (ArcherID) REFERENCES ArcherInfo(ID),
    FOREIGN KEY (RangeID) REFERENCES Ranges(ID)
    );
    

    CREATE TABLE RoundArrows(
    RoundID INT NOT NULL AUTO_INCREMENT,
    RangeID INT NOT NULL,
    ArrowsNo INT NOT NULL,
    FaceID INT NOT NULL,

    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (RangeID) REFERENCES Ranges(ID),
    FOREIGN KEY (FaceID) REFERENCES Face(ID)
    );

    

    CREATE TABLE StagingScore(
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ArcherID INT NOT NULL,
    CategoryID INT NOT NULL,
    EndNo INT NOT NULL,
    ScoreDateTime DATETIME NOT NULL,  
    DivisionID INT NOT NULL,
    RoundID INT NOT NULL,
    CompetitionID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(ID),
    FOREIGN KEY (ArcherID) REFERENCES ArcherInfo(ID),
    FOREIGN KEY (DivisionID) REFERENCES Division(ID),
    FOREIGN KEY (RoundID) REFERENCES Rounds(ID),
    FOREIGN KEY (CompetitionID) REFERENCES ClubCompetition(ID)
    );

    
