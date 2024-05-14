SELECT
    ArcherInfo.FirstName,
    ArcherInfo.LastName,
    SUM(EndScores.Score) AS OverallScore
FROM
    EndScores
INNER JOIN
    Category ON EndScores.CategoryID = Category.ID
INNER JOIN
    ArcherInfo ON Category.ArcherID = ArcherInfo.ID
GROUP BY
    ArcherInfo.ID,
    ArcherInfo.FirstName,
    ArcherInfo.LastName
ORDER BY
    OverallScore DESC;
