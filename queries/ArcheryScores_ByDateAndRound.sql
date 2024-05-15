/* checks scores by filtering the date range and which rounds*/

SELECT
    ArcherInfo.FirstName,
    ArcherInfo.LastName,
    Rounds.RoundName,
    EndScores.ScoreDateTime,
    EndScores.Score
FROM
    EndScores
INNER JOIN
    Category ON EndScores.CategoryID = Category.ID
INNER JOIN
    ArcherInfo ON Category.ArcherID = ArcherInfo.ID
INNER JOIN
    Rounds ON Category.RoundID = Rounds.ID
WHERE
    EndScores.ScoreDateTime BETWEEN 'start_date' AND 'end_date'  -- Replace with actual dates
    AND Rounds.RoundName = 'specific_round'  -- Replace with actual round name
ORDER BY
    EndScores.ScoreDateTime DESC,
    EndScores.Score DESC;
