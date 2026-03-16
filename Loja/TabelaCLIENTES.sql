-- Criação/Uso de database --
IF DB_ID(N'Loja') IS NULL
	CREATE DATABASE Loja;
ELSE
	USE Loja;
GO

-- Consulta de elementos --
SELECT create_date AS 'Data de Criação',
	   name		   AS 'Nome da Tabela'
FROM sys.tables;
GO

-- criação da tabela CLIENTES --
CREATE TABLE CLIENTES (
	ID    INT PRIMARY KEY,
	Nome  VARCHAR(50) NOT NULL,
	Sexo  CHAR(1) NULL,
	Idade INT CHECK (Idade > 18) NOT NULL,
	CPF   CHAR(11) UNIQUE NOT NULL,
	Email VARCHAR(200) DEFAULT 'meu@email.com' NOT NULL
);
GO

-- Inserir dados corretamente para testar --
INSERT INTO CLIENTES VALUES
	(1, 'Ana Cristina', 'f', 20, '11111111111', 'ana@gmail.com');
GO

-- Inserir com erro no ID para teste --
INSERT INTO CLIENTES VALUES
	(1, 'Marcos Paulo', 'm', 45, '22222222222', 'marcos@gmail.com');
GO

-- Erro na Idade > 18 --
INSERT INTO CLIENTES VALUES
	(3, 'André Luis', 'm', 15, '33333333333', 'andre@gmail.com');
GO

-- Registro OK --
INSERT INTO CLIENTES VALUES
	(4, 'Maria Clara', NULL, 22, '44444444444', 'maria@gmail.com');
GO

-- Erro UNIQUE CPF --
INSERT INTO CLIENTES VALUES
	(5, 'Pedro Algusto', 'm', 45, '22222222222', 'pedro@gmail.com');
GO

-- Erro CPF NULO --
INSERT INTO CLIENTES VALUES
	(6, 'Ricardo Lima', 'm', 52, NULL, 'ricardo@gmail.com');
GO

-- Erro CHAVE PRIMARIA NULL --
INSERT INTO CLIENTES VALUES
	(NULL, 'Jose Pereira', 'm', 45, '77777777777', 'jose@gmail.com');
GO

-- Erro quantidade de caracteres em Sexo --
INSERT INTO CLIENTES VALUES
	(8, 'Marcelo Souza', 'masculino', 56, '88888888888', 'marcelo@gmail.com');
GO

-- Maneira de inserir campos com valor DEFAULT --
INSERT INTO CLIENTES (ID, Nome, Sexo, Idade, CPF)
	VALUES (9, 'Daphine Lima', 'f', 32, '99999999999');
GO

-- Erro meu que não envolve o exercicio :p --
UPDATE CLIENTES
SET CPF = '55555555555'
WHERE ID = 5;
GO

-- adicionar dados anteriores corrigidos --
INSERT INTO CLIENTES VALUES
	(2,  'Marcos Paulo',   'm',  45, '22222222222', 'paulo@gmail.com'),
	(3,  'André Luis',     'm',  25, '33333333333', 'andre@gmail.com'),
	(6,  'Ricardo Lima',   'm',  52, '66666666666', 'ricardo@gmail.com'),
	(7,  'Jose Pereira',   'm',  45, '77777777777', 'jose@gmail.com'),
	(10, 'Sheila Pereira', NULL, 21, '10101010101', 'sheila@yahoo.com.br'),
	(11, 'Tiago Algusto',  NULL, 70, '20202020202', 'tiago@yahoo.com.br'),
	(12, 'Maria Pereira',  'f',  45, '30303030303', 'maria@bol.com.br')
GO

-- inserir sem email --
INSERT INTO CLIENTES (ID, Nome, Sexo ,Idade, CPF)
	VALUES 
		(13, 'Lucas Silva',      'm', 19, '40404040404'),
		(14, 'Benedito Silva',  NULL, 44, '50505050505'),
		(15, 'Fernanda Pereira', 'f', 31, '60606060606')
GO

-- Consulta de elementos da tabela --
SELECT * FROM CLIENTES;
GO

-- Exibição de informações sobre a estrutura da tabela --
SELECT TABLE_CATALOG    AS 'Banco de Dados',
       TABLE_NAME       AS 'Tabela',
       ORDINAL_POSITION AS 'Posiçao',
       COLUMN_NAME      AS 'Coluna',
       DATA_TYPE        AS 'Tipos de Dados',
       COLLATION_NAME   AS 'Idioma da Coluna',
       IS_NULLABLE      AS 'Aceita Nulo?'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CLIENTES';
GO

-- Exibição de informações de restrição --
SELECT TABLE_CATALOG     AS 'Banco de Dados',
       TABLE_NAME        AS 'Tabela',
       CONSTRAINT_TYPE   AS 'Tipo de Restrição',
       CONSTRAINT_NAME   AS 'Nome da Restrição'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'CLIENTES';
GO

-- Verifica a estrutura da tabela usando SP_HELP
EXEC sp_help 'CLIENTES';
GO