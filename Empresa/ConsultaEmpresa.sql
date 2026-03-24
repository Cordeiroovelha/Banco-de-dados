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
    Salario   DECIMAL(10,2)  NOT NULL
);
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


-- MySQL --
-- LOAD DATA INFILE '"C:\Users\corde\Downloads\Dependentes.csv"'
--    INTO TABLE DEPENDENTES


SELECT * 
    FROM FUNCIONARIOS CROSS JOIN 
         DEPENDENTES;
GO