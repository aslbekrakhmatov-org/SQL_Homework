use lesson4;

CREATE TABLE TestMultipleZero
(
    A int NULL,
    B int NULL,
    C int NULL,
    D int NULL
);
GO

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT * FROM TestMultipleZero
WHERE NOT (A=0 AND B=0 AND C=0 AND D=0);