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

-- LIKE para mostar registros semelhantes --
SELECT * FROM FUNCIONARIOS
WHERE Nome Like 'M%';
GO

-- LIKE de exclusão --
SELECT * FROM FUNCIONARIOS
WHERE Nome Like '[^M]%';
GO

-- AVG Media --
SELECT * FROM FUNCIONARIOS
WHERE AVG(Salario);
GO

-- UPPER Para deixar o registro todo em maiusculo para facilitar pesquisa --
SELECT * FROM FUNCIONARIOS
WHERE UPPER(Nome) Like 'M%'
ORDER BY Nome;
GO

-- Delete --
DELETE FROM FuncionariosCOPIA
WHERE Salario < 1500;
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

----------------------------------------
-- VIEW --
CREATE VIEW MaioresSalarios AS
    SELECT ID       AS 'Codigo do Funcionario',
           Nome,
           Sexo,
           Salario  AS 'Salário'
    FROM FUNCIONARIOS
GO

-- SELECT do VIEW --
SELECT * FROM MaioresSalarios;
GO

-- SELECT especifico --
SELECT [Codigo do Funcionario],
       Nome,
       [Salário]
FROM MaioresSalarios;
GO

-- ALTER VIEW --
ALTER VIEW MaioresSalarios AS
    SELECT ID       AS 'Codigo do Funcionario',
           Nome,
           Sexo     AS 'Genero do Funcionario',
           Salario  AS 'Salário'
    FROM FUNCIONARIOS
    ORDER BY Salario DESC
    OFFSET 0 ROWS;
GO

--SELECT após alteração --
SELECT [Codigo do Funcionario],
       Nome,
       "Genero do Funcionario",
       Salário
FROM MaioresSalarios
WHERE Salário > 2750;
GO

--Exibe informaçoes do VIEW --
EXEC sp_helptext MaioresSalarios;
GO

SELECT TABLE_NAME      AS 'Nome da View',
       VIEW_DEFINITION AS 'Código SQL'
FROM INFORMATION_SCHEMA.VIEWS;
GO

-- Excluir VIEW --
DROP VIEW MaioresSalarios;
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

-- CAST e CONVERT --
DECLARE @valor AS DECIMAL(5,2) = 156.90;

SELECT CAST(@valor AS CHAR(20))       AS 'CAST',
       CONVERT(DECIMAL(10,5), @valor) AS 'CONVERT'
GO

-- EXEMPLO 02 --
DECLARE @valor AS DECIMAL(5,2) = 156.90;

SELECT CAST(@valor AS CHAR(20))       AS 'CAST 1',
       CAST(@valor AS DECIMAL(10,5))  AS 'CAST 2',
       CONVERT(CHAR(20), @valor)      AS 'CONVERT 2',
       CONVERT(DECIMAL(10,5), @valor) AS 'CONVERT'
GO

-- EXEMPLO 03 --
DECLARE @data AS DATE = '25/01/2024';

SELECT CAST(@data AS CHAR(20))   AS 'CAST (PADRÃO)',
       CONVERT(CHAR(20), @data, 101)  AS 'CONVERT (usa) mm/dd/yyyy',
       CONVERT(CHAR(20), @data, 140)  AS 'CONVERT (pt-br) dd/mm/aaaa',
       CONVERT(CHAR(20), @data)  AS 'CONVERT (japão) yyyy/mm/dd'
GO

-- TRY_CONVERT TRY_PARSE --
DECLARE @data AS CHAR(10) = '25/01/2024';

----------------
-- Incremento --
----------------
-- Cria uma sequência que começa em 1, com incremento 1 --
CREATE SEQUENCE Incrementa1 AS INT
    START WITH 1
    INCREMENT BY 1;
GO

-- Cria uma sequência que começa em 10, com incremento 100 --
CREATE SEQUENCE Incrementa100 AS INT
    START WITH 10
    INCREMENT BY 100;
GO

-- Cria uma sequência que começa em 1000, com incremento -100 --
CREATE SEQUENCE Incrementa1000 AS INT
    START WITH 1000
    INCREMENT BY -100;
GO

-- Criar uma sequencia com mais parametros --
CREATE SEQUENCE IncrementaDecimal AS DECIMAL(3,0)
    START WITH 125
    INCREMENT BY 25
    MINVALUE 100
    MAXVALUE 200
    CYCLE
    CACHE 3;
GO

----------------------------------------
-- Exibe as sequencias e seus valores --
----------------------------------------
SELECT * FROM sys.sequences;
GO

-- Melhor --
SELECT name          AS 'Nome',
       create_date   AS 'Data de Criação',
       start_value   AS 'Valor Inicial',
       increment     AS 'Incremento',
       minimum_value AS 'Valor Minimo',
       maximum_value AS 'Valor Maximo',
       current_value AS 'Valor Atual'
FROM sys.sequences;
GO

-- Exive o primeiro valor das sequencias --
SELECT NEXT VALUE FOR Incrementa1          AS 'Incrementa1',
       NEXT VALUE FOR Incrementa100        AS 'Incrementa100',
       NEXT VALUE FOR Incrementa1000       AS 'Incrementa1000',
       NEXT VALUE FOR IncrementaDecimar    AS 'IncrementaDecimal';
GO

-- Recupera o valor atual de uma sequencia --
SELECT current_value AS 'Valor Atual'
FROM sys.sequences
WHERE name = 'Incrementa100';
GO

-- Atribuição  de colunas --
DECLARE @row AS INT;

SET @row = (SELECT COUNT(*) FROM VIAGENS);

SELECT @row AS 'Total de Viagens';
GO

-- IF ELSE --
DECLARE @A AS INT = 10,
        @B AS INT = 100,
        @maior AS INT;

IF @A > @B
    SET @maior = @A;
ELSE
    SET @maior = @B;

PRINT 'O maior valor: ' + CAST(@maior AS VARCHAR);
GO

-- Par e Impar --
DECLARE @numero AS INT = 240;

IF ((@numero % 2) = 0)
    PRINT 'O numero ' + CAST(@numero AS VARCHAR) + ' é par!';
ELSE
    PRINT 'O numero ' + CAST(@numero AS VARCHAR) + ' é impar!';
GO

-- CASE --
SELECT CodAluno AS 'Codigo',
       NomeAluno AS 'Nome do Aluno',
       Endereco  AS 'Endereço',
       Genero    AS 'Genero',
       CASE Genero
            WHEN 'M' THEN 'Homem'
            WHEN 'F' THEN 'Mulher'
            ELSE 'Não declarado'
       END AS 'Homem | Mulher'
FROM ALUNOS;
GO

-- WHILE --
DECLARE @i AS INT;
SET @i = 1;

WHILE @i <= 10
    BEGIN
        PRINT CAST(@i AS CHAR);
        SET @i = @i + 1;
    END;
GO

-- Tabuada usando WHILE --
DECLARE @quantidade AS INT = 5,
        @total AS INT = 1,
        @contador AS INT,
        @limite AS INT = 5;

WHILE @total <= @quantidade
    BEGIN
        PRINT 'Tabuada do ' + CAST(@total AS VARCHAR(5));
        PRINT REPLICATE('-', 13);
        SET @contador = 0;
        WHILE @contador <= @limite
            BEGIN
                PRINT CAST(@total AS VARCHAR(5)) + ' X ' 
                    + CAST(@contador AS VARCHAR(5)) + ' = '
                    + CAST((@total * @contador) AS VARCHAR(5));
                        SET @contador += 1;
            END;
        SET @total += 1;
        PRINT '';
    END;
GO

-----------------------
-- Stored Procedures --
-----------------------
SELECT name
FROM sys.tables;
GO

-- Criação de um procedimento --
CREATE PROCEDURE AloMundo
AS
    PRINT 'Alô Mundo!';
GO

EXECUTE AloMundo;
GO

-- Informaçoes sobre os procedimentos --
SELECT * FROM sys.procedures;
GO

SELECT name      AS 'Procedimentos',
       create_date AS 'Data de Criação',
       modify_date AS 'Data de Alteração'
FROM sys.procedures;
GO

-- Alterear um procedimento --
ALTER PROCEDURE AloMundo
AS
    PRINT 'Hello World!';
GO

EXECUTE AloMundo;
GO

-- Exibe dados do diretorio C:\ --
EXEC XP_SUBDIRS 'C:\';
GO

-- Verifica a Existencia de um Arquivo --
EXECUTE XP_FILEEXIST '';

-- Lista de procedimentos do sistema --
EXECUTE sp_helpextendedproc;
GO


-- Declaração de variaveis em MySQL --
DECLARE @dia    AS INT,
        @mes    AS CHAR(20),
        @ano    AS INT,
        @data1  AS DATE,
        @data2  AS DATETIME;

--Atribuindo Valores --
SET @dia = DAY(GETDATE());
SET @mes = MONTH(GETDATE());
SET @ano = YEAR(GETDATE());
SET @data1 = DATEFROMPARTS(@ano, @mes, @dia);
SET @data2 = DATETIMEFROMPARTS(@ano, @mes, @dia, 0, 0, 0, 0);

-- Select --
-- Do modo que foi feito precisa selecionar tudo para funcionar --
SELECT @dia    AS 'Dia',
       @mes    AS 'Mes',
       @ano    AS 'Ano',
       @data1  AS 'Data 1',
       @data2  AS 'Data 2';
GO

-- Diferença entre datas e horas --
DECLARE @data1 AS DATE,
        @data2 AS DATE;
SET DATEFORMAT DMY;
SET @data1 = '01/01/2024';
SET @data2 = GETDATE();

SELECT @data1 AS 'Data Inicial',
       @data2 AS 'Data Hoje',
       DATEDIFF(DAY, @data1, @data2)  AS 'Qtd. Dias',
       DATEDIFF(HOUR, @data1, @data2) AS 'Qtd. Horas';
GO

-- Modificação de data e valores da hora --
SELECT GETDATE() AS 'Data atual',
       DATEADD(MONTH, 5, GETDATE()) AS 'Proximos 5 meses',
       EOMONTH(GETDATE(), 5)        AS 'Final do mes (5 meses)',
       SWITCHOFFSET(GETDATE(), '+10:00') AS 'Alteração do fuso (+10 horas)';
GO

-- Exibe a configuração atual idioma e o primeiro dia da semana --
SELECT @@LANGUAGE  AS 'Idioma Utilizado',
       @@DATEFIRST AS 'Primeiro dia da semana';
GO

-- Demostra a utilização do comando SELECT... CASE --
SELECT @@LANGUAGE  AS 'Idioma Utilizado',
    CASE
        WHEN @@DATEFIRST = 1 THEN 'Segundo-Feira'
        WHEN @@DATEFIRST = 2 THEN 'Terça-Feira'
        WHEN @@DATEFIRST = 3 THEN 'Quarta-Feira'
        WHEN @@DATEFIRST = 4 THEN 'Quinta-Feira'
        WHEN @@DATEFIRST = 5 THEN 'Sexta-Feira'
        WHEN @@DATEFIRST = 6 THEN 'Sabado'
        WHEN @@DATEFIRST = 7 THEN 'Domingo'
    END AS 'Primeiro Dia da semana';
GO

-- Exibe os idiomas disponiveis --
SELECT langid       AS 'Id do idioma',
       dateformat   AS 'Formato de ddata',
       datefirst    AS 'Primeiro dia da semana',
       name         AS 'Nome do idioma',
       alias        AS 'Nome alternativo',
       months       AS 'Nome dos meses',
       shortmonths  AS 'Abreviação dos meses',
       days         AS 'Nome dos dias'
FROM sys.syslanguages
WHERE alias IN ('English','Brazilian','German','Japonese','Russian');
GO

-- expecificações de um idioma --
Exec SP_HELPLANGUAGE [Brazilian];
GO

---------------------------
-- estilo de data e hora --
---------------------------

-- Define o idioma a ser utilizado --
SET LANGUAGE Brazilian;
GO

-- declara uma variavel para armazenar a data atual --
DECLARE @data DATETIME;

-- atribui o valor da data atual --
SET @data = GETDATE();

-- Exibe as informações da data --
SELECT @@LANGUAGE  AS 'Idioma Utilizado',
       @data            AS 'Data Atual',
       DATEPART(DAY,@data)     AS 'Dia do mês',
       DATENAME(DW, @data)     AS 'Dia da semana',
       DATEPART(MONTH, @data)  AS 'Mês',
       DATENAME(MONTH, @data)  AS 'Nome do mês',
       DATEPART(YEAR, @data)   AS 'Ano',
       DATENAME(DW,@data)      AS 'Dia da semana',
       DATENAME(WK, @data)     AS 'Semana do Ano',
       DATENAME(M, @data)      AS 'Nome do mês',
       DATENAME(D, @data)      AS 'Dia do mês',
       DATENAME(DY, @data)     AS 'Dia do ano';
GO


-- verificação de validez de data --
SET DATEFORMAT DMY;
GO

IF ISDATE('20/01/2015 00:10:50.000') = 1
    PRINT 'Data válida!';
ELSE
    PRINT 'Data inválida!';
GO

-- Exemplo de teclados --
SELECT ASCII('A')     AS 'ASCII: A',
       UNICODE('A')   AS 'UNICODE: A',
       CHAR(65)      AS 'CHAR: 65',
       NCHAR(65)     AS 'NCHAR: 65',
       ASCII(N'私')    AS 'ASCII: 私',
       UNICODE(N'私')  AS 'UNICODE: 私',
       CHAR(31169)   AS 'CHAR: 31169',
       NCHAR(31169)  AS 'NCHAR: 31169',
       CHARINDEX('S', 'Microsoft SQL') AS 'CHARINDEX: S',
       CHARINDEX('SQL', 'Microsoft SQL') AS 'CHARINDEX: SQL';
GO

-- Uso do SPACE QUOTENAME STR E LEN --
SELECT 'Paulo' + 'Giovani'             AS 'SPACE 1',
       'Paulo' + ' ' + 'Giovani'       AS 'SPACE 2',
       'Paulo' + SPACE(10) + 'Giovani' AS 'SPACE 3',
       QUOTENAME('Paulo Giovani', '{') AS 'QUOTENAME 1',
       QUOTENAME('Paulo Giovani', '"') AS 'QUOTENAME 2',
       QUOTENAME('Paulo Giovani', '[') AS 'QUOTENAME 3',
       STR(100)                        AS 'STR 1',
       STR(100.0)                      AS 'STR 2',
       STR(100.45, 6, 2)               AS 'STR 3',
       LEN('Paulo Giovani')            AS 'LEM 1';
GO

-- PATINDEX --
SELECT PATINDEX('soft', 'Microsoft SQL')   AS 'PATINDEX 1',
       PATINDEX('%soft%', 'Microsoft SQL') AS 'PATINDEX 2';
GO

-- SOUNDEX e DIFFERENCE --
SELECT SOUNDEX('Paulo')            AS 'SOUNDEX: Paulo',
       SOUNDEX('Paul')             AS 'SOUNDEX: Paul',
       SOUNDEX('Cris')             AS 'SOUNDEX: Cris',
       DIFFERENCE('Paulo', 'Paul') AS 'DIFF 1',
       DIFFERENCE('Paulo', 'Cris') AS 'DIFF 2';
GO

-- data em diferentes idiomas --
DECLARE @d DATETIME = GETDATE();

SELECT FORMAT(@d, 'D', 'en-US') AS 'Inglês Americano',
       FORMAT(@d, 'D', 'en-gb') AS 'Inglês Britânico',
       FORMAT(@d, 'D', 'de-de') AS 'Alemão',
       FORMAT(@d, 'D', 'zh-cn') AS 'Chinês Simplificado',
       FORMAT(@d, 'D', 'pt-br') AS 'Portugês Brasileiro';
GO

-- CONCAT STUF REVERSE e REPLICATE --
SELECT CONCAT('Paulo', 'Giovani')                       AS 'CONCAT',
       CONCAT('Rua','João XXIII, ','15','- São Paulo')  AS 'Endereço',
       STUFF('Paulo Giovani', 2, 1, 'TEXTO')            AS 'STUFF',
       REVERSE('Paulo Giovani')                         AS 'REVERSE',
       REPLICATE('*', 10)                               AS 'REPLICATE 1',
       'Paulo' + REPLICATE('.', 5) + ':' + '6666-6666'  AS 'REPLICATE 2';
GO

-- MATH --

SELECT '3.1415'        AS 'PI',
       PI()            AS 'PI',
       ABS(-3.1415)    AS 'ABS',
       CEILING(3.1415) AS 'CEILING',
       FLOOR(3.1415)   AS 'FLOOR',
       EXP(1.0)        AS 'EXP',
       POWER(2,3.0)    AS 'POWER',
       RAND(5)         AS 'RAND',
       ROUND(PI(), 2)  AS 'ROUND',
       SQRT(100)       AS 'SQRT',
       SIGN(-1)        AS 'SIGN',
       SQUARE(3)       AS 'SQUARE'
GO
