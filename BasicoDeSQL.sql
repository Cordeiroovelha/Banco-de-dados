-- criação do banco de dados--
CREATE DATABASE Empresa;
GO
-- habilitar o contexto -- 
USE Empresa;
GO

-- Cria a tabela FUNCIONARIOS -- 
CREATE TABLE FUNCIONARIOS (
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

-- Adicionar o elemento Telefone --
ALTER TABLE FUNCIONARIOS
    ADD Telefone    CHAR(10)
GO

-- update de todos telefone --
UPDATE FUNCIONARIOS
    SET Telefone = NULL;
GO

UPDATE FUNCIONARIOS
    SET Telefone = '3668-0010'
    WHERE ID = 1;
GO

UPDATE FUNCIONARIOS SET Telefone = '3668-1550' WHERE ID = 2;
UPDATE FUNCIONARIOS SET Telefone = '3664-5000' WHERE ID = 3;
UPDATE FUNCIONARIOS SET Telefone = '3664-2001' WHERE ID = 4;
UPDATE FUNCIONARIOS SET Telefone = '3663-9000' WHERE ID = 5;
GO

-- Aumento --
UPDATE FUNCIONARIOS
    SET Salario = Salario * 1.10
    WHERE YEAR(Admissao) <= 2026;
GO

-- Tabela copia teste --
SELECT *
    INTO FuncionariosCOPIA
FROM FUNCIONARIOS;
GO

-- truncate DELETA todos os registros da tabela --
TRUNCATE TABLE FuncionariosCOPIA;
GO

-- DROP (Deleta a tabela) --
DROP TABLE [FuncionariosCOPIA];
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

-- <> = Operador de diferença --
SELECT * FROM FUNCIONARIOS
WHERE Sexo <> 'm';
GO

-- AND = Operador de add --
SELECT * FROM FUNCIONARIOS
WHERE Sexo <> 'm' AND Sexo = NULL;
GO

-- BETWEEM = Operador de entre --
SELECT * FROM FUNCIONARIOS
WHERE Salario BETWEEN 1000 AND 1800;
GO

-- IS NOT NULL = Seleciona quando não é nulo
SELECT * FROM FUNCIONARIOS
WHERE Sexo IS NOT NULL;
GO

-- Delete --
DELETE FROM FuncionariosCOPIA
WHERE Salario < 1500;
GO

-- EXISTS = Verifica se existe --

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
       COLUMN_NAME      AS 'Coluna',
       DATA_TYPE        AS 'Tipos de Dados',
       COLLATION_NAME   AS 'Idioma da Coluna',
       IS_NULLABLE      AS 'Aceita Nulo?'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO

Select TABLE_CATALOG     AS 'Banco de Dados',
       TABLE_NAME        AS 'Tabela',
       CONSTRAINT_TYPE   AS 'Tipo de Restrição',
       CONSTRAINT_NAME   AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'TESTE';
GO

Select TABLE_CATALOG    AS 'Banco de Dados',
       TABLE_NAME       AS 'Tabela'
       
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TESTE';
GO

-- Tabela temporaria Local --
CREATE TABLE #TabelaA (
	ID   INT         NOT NULL,
	Nome VARCHAR(25) NOT NULL,
	Sexo CHAR(1)     NULL,
	PRIMARY KEY(Id)
);
GO

INSERT INTO #TabelaA VALUES
    (1, 'Marcelo Algusto', 'm'),
    (2, 'Maria Cristina', 'f')
GO

INSERT INTO #TabelaA
    SELECT ID,
           Nome,
           Sexo
    FROM FUNCIONARIOS
    WHERE ID > 2;
GO

SELECT CONSTRAINT_CATALOG AS 'Banco de Dados',
       TABLE_NAME         AS 'Tabela',
       CONSTRAINT_TYPE    AS 'Tipo de Restrição',
       CONSTRAINT_NAME    AS 'Nome da Restrição'
FROM tempdb.INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME LIKE '#TabelaA%';
GO

SELECT * FROM #TabelaA;
GO

-- Tabela temporaria Global --
CREATE TABLE ##TabelaB (
	ID   INT         NOT NULL,
	Nome VARCHAR(25) NOT NULL,
	Sexo CHAR(1)     NULL,
	PRIMARY KEY(Id)
);
GO

INSERT INTO ##TabelaB VALUES
    (1, 'Marcelo Algusto', 'm'),
    (2, 'Maria Cristina', 'f')
GO

SELECT * FROM ##TabelaB;
GO

-- Copia de Tabelas --
SELECT *
    INTO FuncionariosCOPIA
FROM FUNCIONARIOS;
GO

Select TABLE_CATALOG     AS 'Banco de Dados',
       TABLE_NAME        AS 'Tabela',
       CONSTRAINT_TYPE   AS 'Tipo de Restrição',
       CONSTRAINT_NAME   AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('FUNCIONARIOS', 'FuncionariosCOPIA');
GO

ALTER TABLE FuncionariosCOPIA
  ADD CONSTRAINT pk_id PRIMARY KEY(ID);
GO

SELECT * FROM FuncionariosCOPIA
GO

-- Tabela Clientes --
CREATE TABLE CLIENTES (
	ID    INT		   PRIMARY KEY,
	Nome  VARCHAR(50)  NOT NULL,
	Sexo  CHAR(1)	   NULL,
	Idade INT		   NOT NULL CHECK (Idade > 18),
	CPF   CHAR(11)	   NOT NULL UNIQUE,
	Email VARCHAR(200) NOT NULL DEFAULT 'meu@email.com'
);
GO
