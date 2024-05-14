/*
This query retrieves detailed information about archers, including:
- First name and last name.
- Classification of the archer.
- Default equipment for the archer's classification and round.
- Registration year of the archer.
- Name of the competition.
*/

    --
SELECT
    ArcherInfo.FirstName,
    ArcherInfo.LastName,
    Category.Classification AS Class,
    DefaultEquipment.Equipment,
    Category.RegisterYear,
    ClubCompetition.CompetitionName
FROM
    Category
INNER JOIN
    ArcherInfo ON Category.ArcherID = ArcherInfo.ID
INNER JOIN
    ClubCompetition ON Category.CompetitionID = ClubCompetition.ID
INNER JOIN
    DefaultEquipment ON Category.RoundID = DefaultEquipment.RoundID
WHERE
    DefaultEquipment.Category = Category.Classification;
