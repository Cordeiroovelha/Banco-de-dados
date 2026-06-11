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
