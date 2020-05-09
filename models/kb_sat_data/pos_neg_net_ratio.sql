WITH positive_values (Staff, Pos_Net) AS (SELECT Staff, SUM(CONVERT(Int,Merit_Value))
FROM {{ source('kickboard','1819_KB Data')}}
WHERE Behavior_Category = 'Positive Behaviors'	AND Staff LIKE 'Student%'
GROUP BY Staff),

negative_values (Staff, Neg_Net) AS (SELECT Staff, SUM(CONVERT(Int,Merit_Value))
FROM {{ source('kickboard','1819_KB Data')}}
WHERE Behavior_Category = 'Negative Behaviors'	AND Staff LIKE 'Student%'
GROUP BY Staff)

SELECT positive_values.Staff, positive_values.pos_net, negative_values.neg_net, positive_values.pos_net + negative_values.neg_net AS 'Net', CONVERT(float,positive_values.pos_net) / convert(float,abs(negative_values.neg_net)) AS pos_neg_ratio
FROM positive_values
LEFT JOIN negative_values
ON positive_values.Staff = negative_values.Staff