--checks the personal best score
SELECT
    ArcherInfo.FirstName,
    ArcherInfo.LastName,
    MAX(EndScores.Score) AS PersonalBest
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
    PersonalBest DESC;
