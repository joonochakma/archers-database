SELECT 
    ArcherInfo.FirstName AS FirstName,
    ArcherInfo.LastName AS LastName,
    SUM(EndScores.Score) AS OverallScore
FROM 
    ArcherInfo
INNER JOIN 
    Category ON ArcherInfo.ID = Category.ArcherID
INNER JOIN 
    EndScores ON EndScores.CategoryID = Category.ID
WHERE 
    ArcherInfo.FirstName = 'Archer_First_Name'
AND 
    ArcherInfo.LastName = 'Archer_Last_Name'
GROUP BY 
    ArcherInfo.FirstName, ArcherInfo.LastName;
