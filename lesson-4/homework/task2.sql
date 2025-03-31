CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

SELECT *,
	CASE
		WHEN Max1<=Max2 AND Max2>=Max3 THEN Max2
		WHEN Max2<=Max3 AND Max3>=Max1 THEN Max3
		ELSE Max1
	END AS Abs_Max
FROM TestMax;
