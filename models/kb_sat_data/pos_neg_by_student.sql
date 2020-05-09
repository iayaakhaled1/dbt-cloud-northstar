WITH Positive_Count (ID, pos_count) AS
(SELECT External_ID, Count(*) 
FROM {{ source('kickboard','1819_KB Data')}}
WHERE Behavior_Category = 'Positive Behaviors'
GROUP BY External_ID),

Negative_Count (ID, neg_count) AS
(SELECT External_ID, Count(*)
FROM {{ source('kickboard','1819_KB Data')}}
WHERE Behavior_Category = 'Negative Behaviors'
GROUP BY External_ID),

SAT_Table_1 AS 
(SELECT Student_Number AS ID, Overall as SAT_SCORE_1
FROM {{ source('tableau','1819_SAT Data')}}
WHERE SAT_Name = 'Cycle 1 2018-19'),

SAT_Table_2 AS 
(SELECT Student_Number AS ID, Overall as SAT_SCORE_2
FROM {{ source('tableau','1819_SAT Data')}}
WHERE SAT_Name = 'Cycle 2 2018-19')

SELECT Positive_Count.ID, Positive_Count.pos_count, Negative_Count.neg_count, SAT_Table_1.SAT_SCORE_1, SAT_Table_2.SAT_SCORE_2
FROM Positive_Count
LEFT JOIN Negative_Count
ON Positive_Count.ID = Negative_Count.ID
LEFT JOIN SAT_Table_1
ON Positive_Count.ID = SAT_Table_1.ID
LEFT JOIN SAT_Table_2
ON Positive_Count.ID = SAT_Table_2.ID