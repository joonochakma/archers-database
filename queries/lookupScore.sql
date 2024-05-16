SELECT 
    ArcherInfo.FirstName AS FirstName,
    ArcherInfo.LastName AS LastName,
    EndScores.ScoreDateTime AS ScoreDateTime,
    Rounds.RoundName AS RoundName,
    EndScores.Score AS Score
FROM 
    ArcherInfo
INNER JOIN 
    Category ON ArcherInfo.ID = Category.ArcherID
INNER JOIN 
    Rounds ON Rounds.ID = Category.RoundID
INNER JOIN 
    EndScores ON EndScores.CategoryID = Category.ID
WHERE 
    ArcherInfo.FirstName = 'Archer_First_Name' 
AND 
    ArcherInfo.LastName = 'Archer_Last_Name'; 
