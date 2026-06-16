----------------
-- TRANSAÇOES --
----------------

USE SONDA
GO

-------------------------
-- Abrir uma transação --
-------------------------
BEGIN TRAN
GO

-- Insere mais um cliente --
INSERT INTO CLIENTES VALUES
	(9, 'Tião', 1000.00)
GO

SELECT  * FROM CLIENTES
GO

-- Termina a transação --
COMMIT TRAN
GO

-- Verifica os resultados --
SELECT  * FROM CLIENTES
GO

----------------------------
-- Transação com ROLLBACK --
----------------------------
BEGIN TRAN
GO

UPDATE CLIENTES
	SET RendaMensal = 500.00
GO

SELECT * FROM CLIENTES
GO

-- Desfaz a transação --
ROLLBACK TRAN
GO

-- Verifica se foi desfeito --
SELECT  * FROM CLIENTES
GO

---------------
-- SavePoint --
---------------
BEGIN TRAN
GO

PRINT 'Total de transações abertas: ' 
	+ CONVERT(VARCHAR, @@TRANCOUNT)
GO

INSERT INTO CLIENTES VALUES
	(10, 'Felipe' , 100.00)
GO

SELECT  * FROM CLIENTES
GO

-- SavePont em si --
SAVE TRAN Ponto01
GO

PRINT 'Total de transações abertas: ' 
	+ CONVERT(VARCHAR, @@TRANCOUNT)
GO

INSERT INTO CLIENTES VALUES
	(11, 'Ana Maria' , 1000.00),
	(12, 'Fernando Pagodeiro' , 5000.00)
GO

SELECT  * FROM CLIENTES
GO

-- Desfaz tudo desde o o ponto de salvamento --
ROLLBACK TRAN Ponto01
GO

SELECT  * FROM CLIENTES
GO

COMMIT TRAN
GO

---------------------------------------
-- Nivel de Isolamento de Transaçoes --
---------------------------------------
-- DBCC: Database Console Commands ----
---------------------------------------
DBCC USEROPTIONS
GO

-- Enquanto uma transação estiver aberta, outras sessoes        --
-- Com o mesmo nivel de permissão não poderam executar comandos --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

BEGIN TRAN
GO

PRINT 'Total de transações abertas: ' 
	+ CONVERT(VARCHAR, @@TRANCOUNT)
GO

SELECT  * FROM CLIENTES
GO

DELETE FROM CLIENTES
WHERE CodCliente IN (12, 13)
GO

COMMIT TRAN
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO

SELECT * FROM sys.sysprocesses
GO

-- Informa quais processos estão sendo executados --
EXEC SP_WHO2
GO

SELECT * 
FROM sys.dm_exec_sessions
WHERE DB_NAME(database_id) = 'SONDA'
GO

-- Mata uma sessão
KILL 52
GO

-------------
-- SCHEMAS --
-------------
-- Exibe os esquemas do banco de dados --
SELECT * FROM sys.schemas
GO

-- Cria um esquema teste e atribui como proprietario o usuario DBO --
CREATE SCHEMA TESTE AUTHORIZATION dbo
GO

-- Deçeta o esquema TESTE --
DROP SCHEMA TESTE
GO

-- View dentro do esquema --
CREATE SCHEMA TESTE AUTHORIZATION dbo
  CREATE VIEW Todos_Clientes AS
    SELECT CodCliente,
		   NomeCliente,
		   RendaMensal
FROM CLIENTES
GO

-- Seleciona os campos do View  Todos_Clientes
SELECT * FROM TESTE.Todos_Clientes
GO

-- O esquema não pode ser deletado caso haja elementos dentro dele --
DROP VIEW TESTE.Todos_Clientes
DROP SCHEMA TESTE
GO

-- Tabela de teste
CREATE TABLE TESTE_PRODUTOS (
	ID INT IDENTITY PRIMARY KEY,
	Item VARCHAR(15)
)
GO

INSERT INTO TESTE_PRODUTOS VALUES 
	('Cenoura'),
	('Cebola'),
	('Sabão')
GO

-- Criação do esquema
CREATE SCHEMA TESTE AUTHORIZATION dbo
GO

-- Modifica o esquema TESTE --
-- Tranfere os dados da tabela para o esquema --
ALTER SCHEMA TESTE
	TRANSFER dbo.Teste_Produtos
GO

-- Falha pois a tabela esta dentro do esquema --
SELECT * FROM TESTE_PRODUTOS
GO

-- Maneira Correta --
SELECT * FROM TESTE.TESTE_PRODUTOS
GO

------------
-- Logins --
------------

-- Exibe todos os logins do sistema --
EXEC sp_helplogins
GO

-- Exive os logins existentes no servidor
SELECT * FROM sys.server_principals
GO

-- Criar um Login SUPERMERCADO_SONDA
CREATE LOGIN Supermercado_SONDA
  WITH PASSWORD = 'Senha123'
GO

-- Altera as credenciais do login
ALTER LOGIN Supermercado_SONDA
	WITH DEFAULT_DATABASE = SONDA
GO

-- Habilita o Login
ALTER LOGIN Supermercado_SONDA ENABLE
GO

-- Exibe informaçoes sobre o Login especifico
EXEC sp_helplogins @LoginNamePattern = 'Supermercado_SONDA'
GO

