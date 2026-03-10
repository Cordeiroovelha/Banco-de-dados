-- criação do banco de dados--
CREATE DATABASE EmpresaCJ3034747;
GO
-- habilitar o contexto -- 
USE EmpresaCJ3034747;
GO

-- Cria a tabela FUNCIONARIOS -- 
CREATE TABLE FUNCIONARIOS01 (
    ID        INT            PRIMARY KEY,
    Nome      VARCHAR(25)    NOT NULL,
    Sexo      CHAR(1)        NULL,
    Admissao  DATE           NOT NULL,
    Salario   DECIMAL(10,2)  NOT NULL
);
GO

-- inserçao de dados --

-- altera o formato de data do SQL Server --
SET DATEFORMAT DMY;
GO

-- insere dados na tabela FUNCIONARIOS --
INSERT INTO FUNCIONARIOS (
    ID,
    Nome,
    Sexo,
    Admissao,
    Salario)
VALUES (1, 'Arthur Morgan', 'f', '10/01/2026', 2500.00);
GO
-- inserir dados cujo indentificador ja esteja cadastradoL -- 
INSERT INTO FUNCIONARIOS VALUES (2, 'John Marston', 'm', '05/03/2026', 5000.00);
GO

-- insersão em cadeia --
INSERT INTO FUNCIONARIOS VALUES (3, 'Hosea Matthews', 'm', '05/03/2026', 5000.00);
INSERT INTO FUNCIONARIOS VALUES (4, 'Sadie Adler', 'f', '05/03/2026', 5000.00);
INSERT INTO FUNCIONARIOS VALUES (5, 'Duch Van Der Linde', 'm', '05/03/2026', 5000.00);
GO

-- exibe os dados da tabela FUNCIONARISO --
SELECT * FROM FUNCIONARIOS;
GO

-------------------------------------------

-- SELECT --

SELECT Nome 'Name'
FROM FUNCIONARIOS;
GO

SELECT Nome[Name]
FROM FUNCIONARIOS;
GO

SELECT ID      AS 'Identificador',
       Nome,
       Sexo,
       Salario AS 'Salário'
FROM FUNCIONARIOS;
GO

SELECT * 
FROM FUNCIONARIOS;
GO

SELECT TOP 1 * 
FROM FUNCIONARIOS;
GO

SELECT TOP 1
    Id,
    Nome
FROM FUNCIONARIOS;
GO

-- Comandos de consulta --

-- WHERE--

SELECT * FROM FUNCIONARIOS
WHERE Sexo = 'm' AND
      Salario > 1000;
GO

-- ORDER BY crescente e decrescente --

SELECT * FROM FUNCIONARIOS
ORDER BY Nome;
GO

SELECT * FROM FUNCIONARIOS
ORDER BY Nome DESC;
GO

-- inserir valor com nome igual a um anterior --
INSERT INTO FUNCIONARIOS VALUES (6, 'Duch Van Der Linde', 'm', '05/03/2026', 5000.00);
GO

SELECT * FROM FUNCIONARIOS
WHERE Salario > 1000
ORDER BY Nome,
         Salario DESC;
GO

-- Alterar a estrutura da tabela --

-- tabela teste --

CREATE TABLE TESTE(
    ID INT,
    Nome CHAR(10)
);
GO

-- alterar uma coluna --
ALTER TABLE TESTE
    ALTER COLUMN Nome CHAR(50);
Go

-- Add uma coluna --
ALTER TABLE TESTE
    ADD DataNascimento DATE,
        Peso DECIMAL(5,2);
Go

-- Deleta uma coluna --
ALTER TABLE TESTE
    DROP COLUMN DataNascimento;
GO

-- Adiciona Rstrição --
ALTER TABLE TESTE
    ADD UNIQUE (Sexo);
Go

-- Altera restriçoes da coluno --
ALTER TABLE TESTE
 ALTER COLUMN ID INT NOT NULL;
GO

ALTER TABLE TESTE
 ADD CONSTRAINT pk_id PRIMARY KEY (ID)
GO

-- Deleta tabela --
DROP TABLE TESTE;
Go

-- Verificar todos os dados da tabela --
EXEC sp_columns TESTE;
Go

-- Verificar nome da restriçao --
EXEC sp_helpconstraint TESTE;
Go

-- Verificar alguns dados da tabela --
Select TABLE_CATALOG    AS 'Banco de Dados',
       TABLE_NAME       AS 'Tabela',
       ORDINAL_POSITION AS 'Posiçao',
       COLUMN_NAME       AS 'Coluna',
       DATA_TYPE        AS 'Tipos de Dados',
       COLLATION_NAME    AS 'Idioma da Coluna',
       IS_NULLABLE      AS 'Aceita Nulo?'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO


Select TABLE_CATALOG    AS 'Banco de Dados',
       TABLE_NAME       AS 'Tabela'
       
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO
