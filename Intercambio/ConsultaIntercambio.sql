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

--------------------------------
-- Criação da tabela AERONAVE --
--------------------------------
CREATE TABLE AERONAVES(
    -- IDENTITY faz um auto encremento
    CodAeronave INT IDENTITY PRIMARY KEY,
    Modelo VARCHAR(50) NOT NULL
);
GO

-- Inserir valores na tabela --
INSERT INTO AERONAVES VALUES
    ('Boeing 707'),
    ('Boeing 737'),
    ('Boeing 747'),
    ('Embraer ERJ-145'),
    ('Vickers VC-10');
GO

SELECT * FROM AERONAVES;
GO

-- Permitir a insersão de valores de campo IDENTITY --
SET IDENTITY_INSERT AERONAVES ON;
GO

-- Inserir com um Codigo especifico --
INSERT INTO AERONAVES (CodAeronave, Modelo) VALUES
    (6, 'Airbus A300');
GO

-- Desabilitar a insersão manual por  segurança --
SET IDENTITY_INSERT AERONAVES OFF;
GO

--------------------------------
-- Criação da tabela VEICULOS --
--------------------------------
CREATE TABLE VEICULOS (
    -- IDENTITY começa com 1 e com o incremento de 10
    Codigo INT IDENTITY(1,10) PRIMARY KEY,
    Modelo VARCHAR(50) NOT NULL
);
GO


-- Inserir Valores --
INSERT INTO VEICULOS VALUES
    ('ferrari'),
    ('Camaro'),
    ('Fusca');
GO

SELECT * FROM VEICULOS;
GO

-- Exibir o valor do incremento --
SELECT IDENT_INCR('AERONAVES') AS 'Inc. AERONAVE',
       IDENT_INCR('VEICULOS')  AS 'Inc. VEICULOS'
GO

-- ExIbir o ultimo valor incrementado --
SELECT @@IDENTITY AS 'Ultimo IDENTITY',
       IDENT_CURRENT('AERONAVES') AS 'IDENTITY (AERONAVES)',
       IDENT_CURRENT('VEICULOS')  AS 'IDENTITY (VEICULOS)';
GO

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

-- Tabela temporaria para teste de sequencias
CREATE TABLE #TestaSequencia (
    ID    INT,
    Nome  CHAR(20)
);
GO

-- Reinicia o valor de uma sequencia --
ALTER SEQUENCE Incrementa100
    RESTART WITH 10;
GO

INSERT INTO #TestaSequencia (ID, Nome) VALUES
    (NEXT VALUE FOR Incrementa100, 'Ana'),
    (NEXT VALUE FOR Incrementa100, 'Maria'),
    (NEXT VALUE FOR Incrementa100, 'João');
GO

SELECT * FROM #TestaSequencia;
GO

-- Remove a sequencia criada --
DROP SEQUENCE Incrementa100;
GO

-- Verifica se realmente foi excluido --
INSERT INTO #TestaSequencia (ID, Nome) VALUES
    (NEXT VALUE FOR Incrementa100, 'José');
GO

-----------------------
-- Declara variaveis --
-----------------------
DECLARE @nome AS VARCHAR(100) = 'Carlos Pereira';

SELECT CodAluno AS 'Codigo',
       NomeAluno AS 'Nome do Aluno',
       Endereco  AS 'Endereço'
FROM ALUNOS
WHERE NomeAluno LIKE @nome;
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

-- Procedimento Alunos Homens --
CREATE PROCEDURE uspAlunosMasculinos
AS
    Select CodAluno   AS 'Codigo do Aluno',
           NomeAluno  AS 'Nome do Aluno',
           DataNasc   AS 'Data de Nascimento',
           Endereco   AS 'Endereço',
           Telefone,
           Genero     AS 'Genero do Aluno',
           PaisOrigem AS 'Nacionalidade',
           CodViagem  AS 'Codigo da Viagem'
FROM ALUNOS
WHERE Genero = 'M';
GO

EXECUTE uspAlunosMasculinos;
GO

-- procedimento passando parametro --
CREATE PROCEDURE uspSaudacao
    @nome VARCHAR(200)
AS PRINT 'Ola ' + @nome + '!';
GO

EXEC uspSaudacao 'Paulo';
EXEC uspSaudacao 'Cris';
GO

-- Procedimento retornando um valor --
CREATE PROCEDURE uspSoma
    @valor1 INT,
    @valor2 INT,
    @soma INT OUTPUT
AS
    SET @soma = @valor1 + @valor2;
GO

DECLARE @saida INT;
EXEC uspSoma 100, 50, @saida OUTPUT;
PRINT @saida
GO

-- retorna um pais e seu codigo --
CREATE PROCEDURE uspDescobreCodigoPais
    @Pais VARCHAR(255)
AS 
    SET NOCOUNT ON;
    SELECT CodPais  AS 'Codigo',
           NomePais AS 'Pais'
    FROM PAISES
    WHERE NomePais = @Pais;
    SET NOCOUNT OFF;
GO

EXEC uspDescobreCodigoPais 'Brasil';
EXEC uspDescobreCodigoPais 'Japão';
EXEC uspDescobreCodigoPais 'Turquia';
GO

-- Informa informaçoes de paises com um idioma --
CREATE PROCEDURE uspInfoIdiomaPais
    @idioma VARCHAR(50)
AS
    SET NOCOUNT ON;
    SELECT * FROM PAISES
    WHERE IdiomaPais LIKE ('%' + @IDIOMA + '%');
    SET NOCOUNT OFF;
GO

EXEC uspInfoIdiomaPais 'Português';
EXEC uspInfoIdiomaPais 'hin';
GO

-- Dados dos aulos --
CREATE PROCEDURE uspBuscaDadosAlunos
    @nomeAluno AS VARCHAR(20)
AS
    SET NOCOUNT ON;
    SELECT VIAGENS.CodViagem                    AS 'Código da Viagem',
           ALUNOS.NomeAluno                     AS 'Nome',
           ALUNOS.Telefone,
           ALUNOS.Genero                        AS 'Gênero',
           (SELECT NomePais FROM PAISES 
           WHERE CodPais = ALUNOS.PaisOrigem)   AS 'Origem',
           (SELECT NomePais FROM PAISES
           WHERE CodPais = VIAGENS.PaisDestino) AS 'Destino',
           VIAGENS.DataSaida                    AS 'Data de Saída',
           VIAGENS.DataRetorno                  AS 'Data de Retorno',
           VIAGENS.Valor                        AS 'Preço da Viagem R$'
           FROM ALUNOS INNER JOIN VIAGENS
                ON ALUNOS.CodAluno = VIAGENS.CodViagem
           WHERE ALUNOS.NomeAluno LIKE '%' + @nomeAluno + '%'
           ORDER BY ALUNOS.NomeAluno, VIAGENS.PaisDestino;
    SET NOCOUNT OFF;
GO

EXEC uspBuscaDadosAlunos 'Ana';
EXEC uspBuscaDadosAlunos 'P';
EXEC uspBuscaDadosAlunos 'Silva';
GO

-- Informaçoes sobre o procedure --
EXEC SP_HELP uspBuscaDadosAlunos;
GO

-- Informaçoes Mais Especificadas --
SELECT name        AS 'Nome',
       create_date AS 'Data de criação',
       modify_date AS 'Data da ultima modificação'
FROM sys.procedures
GO

-- Exemplo 2 --
SELECT name    AS 'Nome Do Procedimento',
       definition AS 'definição',
       type_desc  AS 'Tipo'
FROM sys.sql_modules M INNER JOIN sys.objects O
    ON M.object_id = O.object_id
WHERE type_desc LIKE '%procedure%';
GO

-- Procedimento volta o maior valor --
CREATE PROCEDURE uspAchaMaior
    @valor1 FLOAT,
    @valor2 FLOAT
AS
    DECLARE @maior FLOAT;

    IF (@valor1  > @valor2)
        SET @maior = @valor1;
    ELSE
        SET @maior = @valor2;
    PRINT 'Maior valor entre ' + CAST(@valor1 AS VARCHAR) +
          ' e ' + CAST(@valor2 AS VARCHAR) +
          ' é ' + CAST(@maior AS VARCHAR);
GO

EXEC uspAchaMaior 60, 70;
EXEC uspAchaMaior 60, 60.1;
GO

-- Conta a quantidade que o idioma aparece --
CREATE PROCEDURE uspCOntaIdiomas
    @idioma VARCHAR(50)
AS
    DECLARE @mensagemOK VARCHAR(100)
    DECLARE @mensagemErro VARCHAR(100);
    DECLARE @total INT

    SET @mensagemOK = 'Quantidade de registros 
    encontrados para o idioma ' + @idioma + ' : ';
    SET @mensagemErro = 'Nenhuma ocorrencia com o idioma ' +
    @idioma + '!';

    SET @total = (SELECT COUNT(*) FROM PAISES 
    WHERE IdiomaPais LIKE ('%' + @idioma + '%'));

    IF (@total > 0)
        PRINT @mensagemOK + CAST(@total AS VARCHAR);
    ELSE
        PRINT @mensagemErro;
GO

EXEC uspCOntaIdiomas 'Inglês';
EXEC uspCOntaIdiomas 'Japonês';
EXEC uspCOntaIdiomas 'Malgaxe';
EXEC uspCOntaIdiomas 'Latin';
GO

--------------------
-- Aula dia 04/05 --
--------------------

-- Calcula a idade do alundo --
CREATE PROCEDURE uspCalculaIdadeAluno
    @nome AS CHAR(20)
AS
    SET NOCOUNT ON;

    DECLARE @data_nascimento DATETIME;
    DECLARE @idade INT;
    DECLARE @data_atual DATETIME;

    SET @data_atual = (SELECT GETDATE());
    SET @data_nascimento = (SELECT DataNasc FROM ALUNOS
        WHERE NomeAluno = @nome);
    SET @idade = DATEDIFF(YEAR, @data_nascimento, @data_atual) - CASE WHEN @data_atual <
        DATEADD(YEAR, DATEDIFF(YEAR, @data_nascimento, @data_atual), @data_nascimento)
            THEN 1
            ELSE 0
    END;
    SELECT @nome  AS 'Nome do Aluno',
           @idade AS 'Idade do Aluno';
    SET NOCOUNT OFF;
GO


EXEC uspCalculaIdadeAluno 'Maria Cristina';
EXEC uspCalculaIdadeAluno 'Jair Lopes';
EXEC uspCalculaIdadeAluno 'Miguel Firmino';


-- Valor Medio das viagens --
CREATE PROCEDURE uspMediaViagens
    @pais AS VARCHAR(50),
    @media MONEY OUTPUT
AS
    SET @media = (SELECT AVG(Valor) AS 'Media dos Valores'
        FROM VIAGENS
        WHERE PaisDestino = (SELECT CodPais FROM PAISES
            WHERE NomePais = @pais));
GO

DECLARE @pais VARCHAR(50) = 'Estados Unidos da América';
DECLARE @resultado MONEY;

EXEC uspMediaViagens @pais, @resultado OUTPUT;
PRINT 'Custo Médio das viagens realizadas para o ' + @pais + ': R$ ' + CAST(@resultado AS VARCHAR);
GO

-- Exclui o stored procedure --
DROP PROCEDURE uspSaudacao;
GO

-- Não Existe mais
EXEC uspSaudacao 'Paulo';
GO

-------------
-- Funções --
-------------
CREATE FUNCTION fatorial (@N INT)
    RETURNS BIGINT
AS
    BEGIN
        DECLARE @fat BIGINT,
                @i   INT;
        SET @fat = 1;
        SET @i = 1;
        IF (@N <= 1)
            RETURN @fat;
        ELSE
            WHILE (@i < @N)
                BEGIN
                    SET @fat = @fat * @i;
                    SET @i = @i + 1;
                END
            RETURN @fat;
    END;
GO

SELECT dbo.fatorial(20) AS 'Fatorial de 20',
       dbo.fatorial(5)  AS 'Fatorial de 5';
GO

PRINT dbo.fatorial(10);
GO

-- Todos os dados das viagens dos alunos --
SELECT A.CodAluno    AS 'Codigo Aluno',
       A.NomeAluno   AS 'Nome Aluno',
       A.Genero      AS 'Genero Aluno',
       A.Endereco    AS 'Endereço Aluno',
       A.PaisOrigem  AS 'Pais de Origem Aluno',
       V.PaisDestino AS 'Pais de Destino Aluno',
       V.Valor       AS 'Valor da viagem'
FROM ALUNOS A INNER JOIN VIAGENS V
    ON A.CodAluno = V.CodViagem;
GO

-- Função de Alinhamento --
CREATE FUNCTION AlinhaCampo(@texto VARCHAR(255), @tamanho TINYINT, @caractere CHAR(1))
    RETURNS VARCHAR(255)
AS
    BEGIN
        DECLARE @resultado VARCHAR(255);
        SET @resultado = REPLICATE(@caractere, @tamanho - LEN(@texto)) + @texto;
        RETURN @resultado;
    END;
GO

SELECT dbo.AlinhaCampo(A.CodAluno, 2, 0)                 AS 'Codigo Aluno',
       A.NomeAluno   AS 'Nome Aluno',
       A.Genero      AS 'Genero Aluno',
       A.Endereco    AS 'Endereço Aluno',
       A.PaisOrigem  AS 'Pais de Origem Aluno',
       V.PaisDestino AS 'Pais de Destino Aluno',
       dbo.AlinhaCampo(CAST(V.Valor AS VARCHAR), 10, 0)  AS 'Valor da viagem'
FROM ALUNOS A INNER JOIN VIAGENS V
    ON A.CodAluno = V.CodViagem;
GO

-- Funçao que recebe a sigla de um pais e retorna o nome --
CREATE FUNCTION DescobreNomePais (@sigla CHAR(3))
    RETURNS VARCHAR(50)
AS
    BEGIN
        DECLARE @resposta VARCHAR(50);
        SET @resposta = (
            SELECT NomePais FROM PAISES
            WHERE CodPais = @sigla);
        RETURN @resposta;
    END
GO

SELECT dbo.DescobreNomePais('BRA') AS 'Pais',
       dbo.DescobreNomePais('CHN') AS 'Pais',
       dbo.DescobreNomePais('RUS') AS 'Pais'
GO

SELECT A.CodAluno    AS 'Codigo Aluno',
       A.NomeAluno   AS 'Nome Aluno',
       A.Genero      AS 'Genero Aluno',
       A.Endereco    AS 'Endereço Aluno',
       A.PaisOrigem  AS 'Codigo da Origem Aluno',
       dbo.DescobreNomePais(A.PaisOrigem) AS 'Origem',
       V.PaisDestino AS 'Codigo do Destino Aluno',
       dbo.DescobreNomePais(V.PaisDestino) AS 'Origem',
       V.Valor       AS 'Valor da viagem'
FROM ALUNOS A INNER JOIN VIAGENS V
    ON A.CodAluno = V.CodViagem;
GO

-- Função que retorna os dados das viagens para um pais --
CREATE FUNCTION ExibeViagensPais (@sigla CHAR(3))
    RETURNS TABLE
AS
    RETURN
        SELECT V.CodViagem AS 'Codigo da Viagem',
        P.NomePais + ' (' + V.PaisDestino + ') ' AS 'Destino',
        P.IdiomaPais       AS 'Idioma',
        V.DataSaida        AS 'Data de Saida',
        V.DataRetorno      AS 'Data de Retorno',
        V.Valor            AS 'Valor'
        FROM PAISES P INNER JOIN VIAGENS V
            ON P.CodPais = V.PaisDestino
        WHERE V.PaisDestino = @sigla;
GO

SELECT * FROM dbo.ExibeViagensPais('USA');
GO

SELECT [Codigo da VIagem],
       Destino,
       [Valor]
FROM dbo.ExibeViagensPais('MEX');
GO

-- Função que retorna dados de viagens futuras --
CREATE FUNCTION ViagensFuturas (@data DATE)
    RETURNS @viagens_futuras TABLE (Codigo INT, SAIDA DATE,
Retorno DATE, Destino VARCHAR(50))
AS
    BEGIN
        INSERT INTO @viagens_futuras
        SELECT V.CodViagem, V.DataSaida, V.DataRetorno, P.NomePais
        FROM VIAGENS V INNER JOIN PAISES P
            ON V.PaisDestino = P.CodPais
        WHERE V.DataSaida > @data;
        RETURN;
    END;
GO

SELECT * FROM dbo.ViagensFuturas('31/12/2010')
GO

-- Informações sobre as UDFs em uso --
SELECT name       AS 'Nome da função',
       definition AS 'Definição',
       type_desc  AS 'Tipo'
FROM sys.sql_modules M INNER JOIN sys.objects O
    ON M.object_id = O.object_id
WHERE type_desc LIKE '%function%';
GO
