-- CHECKING WINNER FOR EACH ROUND IN A COMPETITION
SELECT
    ClubCompetition.CompetitionName,
    Rounds.RoundName,
    ArcherInfo.FirstName,
    ArcherInfo.LastName,
    SUM(EndScores.Score) AS TotalScore
FROM
    ClubCompetition
JOIN
    Category ON ClubCompetition.ID = Category.CompetitionID
JOIN
    ArcherInfo ON Category.ArcherID = ArcherInfo.ID
JOIN
    EndScores ON Category.ID = EndScores.CategoryID
JOIN
    Rounds ON Category.RoundID = Rounds.ID
GROUP BY
    ClubCompetition.CompetitionName,
    Rounds.RoundName,
    ArcherInfo.FirstName,
    ArcherInfo.LastName
ORDER BY
    ClubCompetition.CompetitionName,
    Rounds.RoundName,
    TotalScore DESC;
