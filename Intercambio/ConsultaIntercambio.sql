---------------------------
-- Consultas INTERCAMBIO --
---------------------------

USE INTERCAMBIO;
GO

-- Exibe o nome das tabelas que existem no banco de dados em uso
SELECT TABLE_NAME AS 'Nome da Tabela'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND 
      TABLE_CATALOG = 'INTERCAMBIO';
GO

----------------------
-- União de tabelas --
----------------------

-- UNION --
-- Faz a união e exibe apenas os itens não duplicados --
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM ALUNOS
    UNION
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- UNION ALL --
-- Realiza a união e exibe or registros duplicados --
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM ALUNOS
    UNION ALL
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- INTERSECT --
-- MINUS em alguns SGBD --
-- Retorna apenas os registro que existem nas duas consultas --
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM ALUNOS
    INTERSECT
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-------------- Ex02 --------------

Select NomeAluno AS 'Nome do Aluno'
FROM ALUNOS
    INTERSECT
Select NomeAluno AS 'Nome do Aluno'
FROM AlunosCOPIA
ORDER BY NomeAluno;
GO

-------------- Ex03 --------------

SELECT NomeAluno AS 'Nome do Aluno'
FROM ALUNOS
WHERE NomeAluno IN
    (SELECT NomeAluno FROM AlunosCOPIA)
ORDER BY NomeAluno;
GO

-- EXCEPT --
-- Realiza somente os registro que existem na primeira consulta --
-- Excluindo da consulta os que também estão na segunda tabela  --
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM ALUNOS
    EXCEPT
Select CodAluno  AS 'Codigo do Aluno',
       NomeAluno AS 'Nome do Aluno',
       Genero    AS 'Genero do Aluno'
FROM AlunosCOPIA
ORDER BY CodAluno, NomeAluno;
GO

-- SubConsultas --
SELECT VIAGENS.CodViagem   AS 'Código',
       ALUNOS.NomeAluno    AS 'Nome do Aluno',
       ALUNOS.Telefone,
       ALUNOS.Genero       AS 'Gênero',
        (SELECT NomePais FROM PAISES WHERE CodPais =
ALUNOS.PaisOrigem)         AS 'Origem',
        (SELECT NomePais FROM PAISES WHERE CodPais =
VIAGENS.PaisDestino)       AS 'Destino',
       VIAGENS.DataSaida   AS 'Data de Saida',
       VIAGENS.DataRetorno AS 'Data de Retorno',
       VIAGENS.Valor       AS 'Preço da viagem R$'
FROM ALUNOS INNER JOIN VIAGENS
    ON ALUNOS.CodViagem = VIAGENS.CodViagem;
GO

-- Usando operador WHERE --
-- Viagens para USA --
SELECT CodPais  AS 'Codigo',
       NomePais AS 'Pais de Destino',
       IdiomaPais AS 'Idioma'
FROM PAISES
WHERE CodPais = (
    SELECT DISTINCT PaisDestino
    FROM VIAGENS
    WHERE PaisDestino = 'USA'
);
GO

-- Usando operador IN --
-- Destino nas viagens dos alunos cadastrados --
SELECT CodPais  AS 'Codigo',
       NomePais AS 'Pais de Destino',
       IdiomaPais AS 'Idioma'
FROM PAISES
WHERE CodPais IN (
    SELECT PaisDestino FROM VIAGENS
);
GO

-- Usando operador HAVING --
SELECT CodPais        AS 'Codigo',
       NomePais       AS 'Pais de Destino',
       COUNT(CodPais) AS 'Total de Viagens'
FROM PAISES P INNER JOIN VIAGENS V
    ON P.CodPais = V.PaisDestino
GROUP BY P.CodPais, P.NomePais
HAVING COUNT(P.CodPais) >= (
    SELECT COUNT(PaisDestino) FROM VIAGENS
    WHERE PaisDestino = 'MEX'
);
GO

-- Usando operador ANY --
SELECT CodPais  AS 'Codigo',
       NomePais AS 'Pais de Destino',
       IdiomaPais AS 'Idioma'
FROM PAISES
WHERE CodPais = ANY (
    SELECT DISTINCT PaisDestino
    FROM VIAGENS
    WHERE PaisDestino IN ('USA','MEX','BRA')
);
GO

-- Usando operador ALL --
SELECT CodViagem  AS 'Codigo da Viagem',
       DataSaida   AS 'Data de Saida',
       DataRetorno AS 'Data de Retorno',
       PaisDestino AS 'Destino'
FROM VIAGENS
WHERE CodViagem > ALL (
    SELECT CodViagem FROM ALUNOS
);
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

-- Exemplo Pratico --
SELECT V.CodViagem     AS 'Codigo da viagem',
       A.NomeAluno     AS 'Nome do Aluno',
       V.Valor         AS 'Preço da viagem',
       V.Valor * 0.05  AS 'Desconto de 5%',
       V.Valor * 0.95  AS 'Total a pagar',
       ROUND(V.Valor * 0.95, 1) AS 'Total Arredondoado'
FROM VIAGENS V INNER JOIN ALUNOS A
    ON V.CodViagem = A.CodViagem;
GO


-- Funções com precisão superior e inferior --
SELECT SYSDATETIME()        AS 'SYSDATETIME',
       SYSDATETIMEOFFSET()  AS 'SYSDATETIMEOFFSET',
       SYSUTCDATETIME()     AS 'SYSUTCDATETIME',
       CURRENT_TIMESTAMP    AS 'CURRENT_TIMESTAMP',
       GETDATE()            AS 'GETDATE',
       GETUTCDATE()         AS 'GETUTCDATE'
GO

-- Exemplo pratico --
SELECT CodAluno         AS 'Codigo do Aluno',
       DataNasc         AS 'Data de Nascimento',
       DAY(DataNasc)    AS 'Dia do Nascimento',
       MONTH(DataNasc) AS 'Mes do Nascimento',
       YEAR(DataNasc)   AS 'Ano do Nascimento',
       DATEPART(WEEK, DataNasc)    AS 'Semana do Nascimento',
       DATEPART(WEEKDAY, DataNasc) AS 'Dia da semana do Nascimento'
FROM ALUNOS;
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

-- Exemplo Pratico --
SELECT NomeAluno AS 'Nome do Aluno',
       DataNasc  AS 'Data de Nascimento',
       FORMAT(DataNasc, 'D', 'pt-br') AS 'Data de Nascimento'
FROM ALUNOS;
GO

-- CONCAT STUF REVERSE e REPLICATE --
SELECT CONCAT('Paulo', 'Giovani')                       AS 'CONCAT',
       CONCAT('Rua','João XXIII, ','15','- São Paulo')  AS 'Endereço',
       STUFF('Paulo Giovani', 2, 1, 'TEXTO')            AS 'STUFF',
       REVERSE('Paulo Giovani')                         AS 'REVERSE',
       REPLICATE('*', 10)                               AS 'REPLICATE 1',
       'Paulo' + REPLICATE('.', 5) + ':' + '6666-6666'  AS 'REPLICATE 2';
GO

-- Exemplo Geral de MANIPULAÇÂO DE STRING --
SELECT NomeAluno  AS 'Nome do Aluno',
       DATEPART(DAY,DataNasc)     AS 'Dia',
       DATENAME(DW, DataNasc)     AS 'Dia da semana',
       DATENAME(M, DataNasc)      AS 'Nome do mês',
       DATEPART(YEAR, DataNasc)   AS 'Ano',
       CONCAT( DATENAME(DW,DataNasc),    ',',
               DATEPART(DAY, DataNasc),  ' de ',
               DATENAME(M, DataNasc),    ' de ',
               DATEPART(YEAR, DataNasc), '.')  AS 'Data de Nascimento'
FROM ALUNOS
GO

-- manipulação de string 2 --
SELECT NomeAluno        AS 'Nome do aluno',
       SUBSTRING(NomeAluno, 1, 1) AS 'Inicial',
       LOWER(NomeAluno)           AS 'Minusculo',
       UPPER(NomeAluno)           AS 'Maiusculo',
       LEN(NomeAluno)             AS 'Quantidade de caracteres',
       LEFT(NomeAluno, 3)         AS 'LEFT',
       RIGHT(NomeAluno, 3)        AS 'RIGHT',
       RIGHT(RTRIM(NomeAluno), 3) AS 'RTRIM', 
       '    ' + NomeAluno         AS 'LTRIM 1',
       LTRIM('    ' + NomeAluno)  AS 'LTRIM 2'
FROM ALUNOS;
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




