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
