/* INSERT INTO Category (ArcherID, CompetitionID, RoundID, ClassificationID, RegisterYear, DivisionID) VALUES (1 ,1, 1, 29,'2013', 1); */

-- Insert data into Category table with Classification determined by DOB and random CompetitionID, RoundID, and DivisionID
INSERT INTO Category (ArcherID, CompetitionID, RoundID, ClassificationID, RegisterYear, DivisionID)
SELECT 
    ArcherInfo.ID AS ArcherID,
    FLOOR(RAND() * (SELECT MAX(ID) FROM ClubCompetition)) + 1 AS CompetitionID, -- Random CompetitionID
    FLOOR(RAND() * (SELECT MAX(ID) FROM Rounds)) + 1 AS RoundID, -- Random RoundID
    (
        SELECT ID
        FROM Classification
        WHERE
            (YEAR(NOW()) - YEAR(ArcherInfo.DOB)) BETWEEN Classification.MinimumAge AND Classification.MaximumAge
            AND ArcherInfo.Gender = Classification.Gender
        ORDER BY RAND()
        LIMIT 1
    ) AS ClassificationID, -- Classification determined by DOB
    2023 AS RegisterYear, -- Assuming register year is 2023
    FLOOR(RAND() * (SELECT MAX(ID) FROM Division)) + 1 AS DivisionID -- Random DivisionID
FROM 
    ArcherInfo;
