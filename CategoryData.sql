INSERT INTO Category (ArcherID,CompetitionID, RoundID, Classification, RegisterYear) VALUES ('10001','10006', '10001', 'Female Open','2013');
INSERT INTO Category (ArcherID,CompetitionID, RoundID, Classification,RegisterYear) VALUES ('10001','10003', '10009', 'Female Open','2021');

INSERT INTO Category (
    ArcherID,
    CompetitionID,
    RoundID,
    ClassificationID,
    RegisterYear,
    DivisionID
)
SELECT
    a.ID,
    1, -- Example CompetitionID
    1, -- Example RoundID
    (
        SELECT ID
        FROM Classification c
        WHERE 
            a.Gender = c.Gender
            AND (
                (TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= c.MinimumAge AND (c.MaximumAge IS NULL OR TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) <= c.MaximumAge))
            )
            AND (
                (c.Description = 'Under 14 Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 14) OR
                (c.Description = 'Under 14 Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 14) OR
                (c.Description = 'Under 16 Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 16) OR
                (c.Description = 'Under 16 Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 16) OR
                (c.Description = 'Under 18 Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 18) OR
                (c.Description = 'Under 18 Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 18) OR
                (c.Description = 'Under 21 Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 21) OR
                (c.Description = 'Under 21 Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 21) OR
                (c.Description = 'Male Open' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 21 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 50) OR
                (c.Description = 'Female Open' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 21 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 50) OR
                (c.Description = '50+ Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 50 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 60) OR
                (c.Description = '50+ Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 50 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 60) OR
                (c.Description = '60+ Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 60 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 70) OR
                (c.Description = '60+ Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 60 AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) < 70) OR
                (c.Description = '70+ Male' AND a.Gender = 'M' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 70) OR
                (c.Description = '70+ Female' AND a.Gender = 'F' AND TIMESTAMPDIFF(YEAR, a.DOB, CURDATE()) >= 70)
            )
        LIMIT 1
    ) AS ClassificationID,
    2024, -- Example RegisterYear
    1  -- Example DivisionID
FROM
    ArcherInfo a
WHERE
    a.ID = 1; -- Example ArcherID

