IF DB_ID(N'EMPRESA_02') IS NULL
	CREATE DATABASE EMPRESA_02;
ELSE
	USE EMPRESA_02;
GO

CREATE TABLE FUNCIONARIOS (
    ID        INT            PRIMARY KEY,
    Nome      VARCHAR(25)    NOT NULL,
    Sexo      CHAR(1)        NULL,
    Admissao  DATE           NOT NULL,
    Salario   DECIMAL(10,2)  NOT NULL,
    Telefone  CHAR(10)       NOT NULL
);
GO

ALTER TABLE FUNCIONARIOS
    ADD Telefone    CHAR(10)
GO

CREATE TABLE DEPENDENTES(
	CodDependente  INT	       PRIMARY KEY,
    Nome           VARCHAR(35) NOT NULL,
    Sexo           CHAR(1)     NULL,
    DataNascimento DATE        NOT NULL,
    ID             INT         FOREIGN KEY
    REFERENCES FUNCIONARIOS (ID)
);
GO

SET DATEFORMAT DMY;

SELECT NAME FROM sys.tables

SELECT * FROM DEPENDENTES
SELECT * FROM FUNCIONARIOS

BULK INSERT DEPENDENTES
    FROM N'C:\Users\corde\Downloads\Dependentes.csv'
WITH (
    FIRSTROW = 2,
    DATAFILETYPE = 'widechar',
    FIELDTERMINATOR = ',',
    CODEPAGE = 65001
);
GO

BULK INSERT FUNCIONARIOS
    FROM N'C:\Users\corde\Downloads\funcionarios.csv'
WITH (
    FIRSTROW = 2,
    DATAFILETYPE = 'widechar',
    FIELDTERMINATOR = ',',
    CODEPAGE = 65001
);
GO

TRUNCATE TABLE FUNCIONARIOS;
GO

DROP TABLE DEPENDENTES;
GO

-- JOINS (Junções) --

-- CROSS JOIN --
SELECT * 
    FROM FUNCIONARIOS,
         DEPENDENTES;
GO

SELECT * 
    FROM FUNCIONARIOS CROSS JOIN 
         DEPENDENTES;
GO

-- NATURAL JOIN --
--SELECT * 
--    FROM FUNCIONARIOS NATURAL JOIN 
--         DEPENDENTES;
--GO

-- JOIN USING --
-- ORACOL --
--SELECT * 
--    FROM FUNCIONARIOS F JOIN 
--         DEPENDENTES D USING F.ID;
--GO

-- JOIN ON --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       F.Salario  AS 'Salário',
       D.Nome     AS 'Nome do Dependente',
       D.ID       AS 'Codigo do Responsavel'
FROM FUNCIONARIOS F JOIN DEPENDENTES D
    ON F.ID = D.ID;
GO

-- INNER JOIN --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       F.Salario  AS 'Salário',
       D.Nome     AS 'Nome do Dependente',
       D.DataNascimento AS 'Data de nascimento',
       D.ID       AS 'Codigo do Responsavel'
FROM FUNCIONARIOS F JOIN DEPENDENTES D
    ON F.ID = D.ID
WHERE YEAR(D.DataNascimento) >= 2000
ORDER BY F.Nome, D.Nome;
GO

--LEFT OUTER JOIN --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       F.Admissao AS 'Admissão',
       F.Salario  AS 'Salário',
       D.Nome     AS 'Nome do Dependente',
       D.DataNascimento AS 'Data de nascimento'
FROM FUNCIONARIOS F LEFT OUTER JOIN DEPENDENTES D
    ON F.ID = D.ID;
GO

-- RIGHT OUTER JOIN --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       F.Admissao AS 'Admissão',
       F.Salario  AS 'Salário',
       D.Nome     AS 'Nome do Dependente',
       D.DataNascimento AS 'Data de nascimento'
FROM FUNCIONARIOS F RIGHT OUTER JOIN DEPENDENTES D
    ON F.ID = D.ID;
GO

-- FULL OUTER JOIN --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       F.Admissao AS 'Admissão',
       F.Salario  AS 'Salário',
       D.Nome     AS 'Nome do Dependente',
       D.DataNascimento AS 'Data de nascimento'
FROM FUNCIONARIOS F FULL OUTER JOIN DEPENDENTES D
    ON F.ID = D.ID;
GO

-- Total de dependentes de cada funcionario --
SELECT F.ID       AS 'Código do Funcionário',
       F.Nome     AS 'Nome do Funcionário',
       COUNT(D.ID) AS 'Total de Dependentes'
FROM FUNCIONARIOS F INNER JOIN DEPENDENTES D
    ON F.ID = D.ID
GROUP BY F.ID, F.Nome;
GO

