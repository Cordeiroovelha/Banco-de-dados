USE Master
GO

IF DB_ID('CURSORES') IS NULL
    CREATE DATABASE CURSORES
GO

USE CURSORES
GO

CREATE TABLE CIDADES(
    Codigo INT PRIMARY KEY,
    Estado CHAR(2),
    Cidade CHAR(20)
)
GO

INSERT INTO CIDADES VALUES
    (1,'SP', 'Campos do Jordão'),
    (2,'SP', 'Taubate'),
    (3,'SP','São Paulo'),
    (4,'RJ','Rio de Janeiro'),
    (5,'RJ','Resende'),
    (6,'DF','Brasilia'),
    (7,'MG', 'Belo Horizonte'),
    (8,'MG','Itajuba'),
    (9,'PR','Marilia'),
    (10,'SP','Colombo')
GO
