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

