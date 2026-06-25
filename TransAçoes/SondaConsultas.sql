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
EXEC sp_helplogins 
  @LoginNamePattern = 'Supermercado_SONDA'
GO

-- 18/06
-- Criação de Usuário e Permissão
-- Cria o usuário CARREFULVIO_ADMIN
CREATE USER SONDA_Admin
FOR LOGIN Supermercado_SONDA
GO

-- Atribui permissão de leitura no banco de
-- dados CARREFULVIO
ALTER ROLE db_datareader
  ADD MEMBER SONDA_Admin
GO

-- Atribui permissão de leitura no banco de
-- dados CARREFULVIO
ALTER ROLE db_datawriter
  ADD MEMBER SONDA_Admin
GO

-- Exibe o usuário atual do banco de dados -> DBO
SELECT CURRENT_USER AS 'Usuário Atual'
GO

-- Altera o usuário do banco de dados
EXEC AS USER = 'SONDA_Admin'
GO

-- Exibe o usuário atual do banco de dados ->
-- CARREFULVIO_ADMIN
SELECT CURRENT_USER AS 'Usuário Atual'
GO

-- Exibe as permissões atribuídas ao usuário
EXEC sp_helprotect NULL, SONDA_Admin
GO

-- Insere mais um cliente no banco de dados
INSERT INTO CLIENTES VALUES
  (12, 'Chuck Norris', 1000000,00)
GO

-- Lista os dados de todos os clientes
SELECT * FROM CLIENTES
GO

-- Altera o usuário anterior ao atual do banco de dados
REVERT
GO

-- Cria o usuário FULVIO. Ele pode selecionar
-- inserir, deletar e atualizar
CREATE USER Fulvio WITHOUT LOGIN
GO

-- Atribui permissões para o usuário FULVIO
GRANT SELECT, INSERT, DELETE, UPDATE TO Fulvio
GO

-- Cria o usuário AOPA. Ele pode somente selecionar dados
CREATE USER Aopa WITHOUT LOGIN
GO

-- Atribui permissões para o usuário AOPA
GRANT SELECT TO Aopa
GO

-- Exibe informações sobre os 
-- usuários existentes no servidor
EXEC sp_helpuser
GO

-- 2. Exibe informações sobre os 
-- usuários existentes no servidor
SELECT * FROM sysusers
GO

-- 3. Exibe informações sobre os usuários 
-- existentes no banco de dados
SELECT name            AS 'Usuário',
       authentication_type_desc AS
'Tipo de Autenticação'
FROM sys.database_principals
WHERE type_desc = 'SQL_USER' AND
      defaut_schema_name = 'dbo'
GO

-- Altera o usuário do banco de dados -> AOPA
EXEC AS USER = 'Aopa'
GO

-- Exibe o usuário atual do banco de dados
SELECT CURRENT_USER AS 'Usuário Atual'
GO

-- Exibe as permissões atribuídas ao usuário AOPA
EXEC sp_helprotect NULL, Aopa
GO

-- Exibe os dados de todos os clientes
SELECT * FROM CLIENTES
GO

-- Tentativa de inserção de um cliente.
-- Gera um erro, pois o usuário AOPA não tem
-- essa permissão.
INSERT INTO CLIENTES VALUES
  (13, 'Maria Cristina', 1500.00)
GO

-- Tentativa de remover todos os produtos.
-- Gera um erro, pois o usuário AOPA não tem
-- essa permissão.
DELETE FROM PRODUTOS
GO

-- Altera o usuário anterior ao atual do banco de dados
REVERT
GO

-- Altera o usuário do banco de dados -> FULVIO
EXEC AS USER = 'Fulvio'
GO

-- Exibe o usuário atual do banco de dados
SELECT CURRENT_USER AS 'Usuário Atual'
GO

-- Exibe as permissões atribuídas ao usuário -> FULVIO
EXEC sp_helprotect NULL, Fulvio
GO

-- Lista os dados de todos os clientes
SELECT * FROM CLIENTES
GO

-- Tentativa de inserção de um cliente.
-- Gera um erro, pois o usuário FULVIO não tem
-- essa permissão.
INSERT INTO CLIENTES VALUES
  (13, 'Maria Cristina', 1500.00)
GO

-- Lista os dados de todos os clientes
SELECT * FROM CLIENTES
GO

-- Altera o usuário do banco de dados -> FULVIO
REVERT
GO

-- Nega a permissão INSERT, para o usuário FULVIO.
DENY INSERT ON CLIENTES TO Fulvio
GO

-- Altera o usuário do banco de dados -> FULVIO
EXEC AS USER = 'Fulvio'
GO

-- Exibe as permissões atribuídas ao usuário -> FULVIO
EXEC sp_helprotect NULL, Fulvio
GO

-- Tentativa de inserção de um novo cliente. Não
-- funciona, pois a permissão para o usuário FULVIO
-- inserir clientes foi negada.
INSERT INTO CLIENTES VALUES
  (14, 'Carlton Banks', 5000.00)
GO

-- Altera para o usuário anterior ao atual -> DBO
REVERT
GO

-- Remove a permissão DENY, relativa ao
-- comando INSERT, atribuida ao usuário FULVIO
REVOKE INSERT ON CLIENTES TO Fulvio
GO

-- Altera o usuário do banco de dados -> FULVIO
EXEC AS USER = 'Fulvio'
GO

-- Exibe as permissões atribuídas ao usuário -> FULVIO
EXEC sp_helprotect NULL, Fulvio
GO

-- Tentativa de inserção de um novo cliente.
-- Funciona, pois a permissão DENY, sobre o INSERT
-- realizados pelo usuario FULVIO foi revogada.
INSERT INTO CLIENTES VALUES
  (14, 'Carlton Banks', 5000.00)
GO

-- Lista os dados de todos os clientes
SELECT * FROM CLIENTES
GO

-- Exibe o usuário atual do banco de dados
SELECT CURRENT_USER AS 'Usuário Atual'
GO

-- Determinando em que tabelas o usuário atual tem
-- a permissão SELECT
SELECT has_perms_by_name(name, 'OBJECT',
'SELECT') AS 'SELECT',
      *
FROM sys.tables
GO

-- Determinando em que tabelas o usuário atual tem
-- a permissões SELECT e INSERT
SELECT has_perms_by_name(name, 'OBJECT',
'SELECT') AS 'SELECT',
      has_perms_by_name(name, 'OBJECT',
'INSERT') AS 'INSERT',
        name AS 'Nome da Tabela'
FROM sys.tables
GO

-- Altera para o usuário anterior ao atual -> DBO
REVERT
GO

-- Exibe informações sobre os usuários 
-- existentes no banco de dados
SELECT name            AS 'Usuário',
       authentication_type_desc AS
'Tipo de Autenticação'
FROM sys.database_principals
WHERE type_desc = 'SQL_USER' AND
      defaut_schema_name = 'dbo'
GO

-- Deleta o usuário AOPA
DROP USER AOPA
GO

-- Deleta o login SUPERMERCADO_CARREFULVIOCJ3032299
DROP LOGIN [SONDA_admin]
GO

----------------
-- 22/06/2026 --
----------------
--   BackUp   --
----------------

-- Precisa estar no master para fazer seguintes açoes --
USE MASTER
GO

-- Verifica o modelo de backup do banco --
SELECT name					AS 'Banco de dados',
	   recovery_model_desc  AS 'Modelo de Backup'
FROM sys.databases
where name = 'SONDA'
GO

-- Backup Completo --
BACKUP DATABASE SONDA
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Backup\SONDA.bak'
WITH INIT, STATS = 10;
GO

-- Backup diferencial --
BACKUP DATABASE SONDA
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Backup\SONDA.bak'
WITH DIFFERENTIAL, INIT, STATS = 10;
GO

-- BackUp do log de transação --
BACKUP LOG SONDA
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Log\SONDALogs.trn'
WITH INIT, STATS = 10;
GO

-- Verifica os backups existentes --
SELECT * FROM
sys.dm_os_enumerate_filesystem('C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Backup\', '*');
GO

-- Exibe os nomes e caminhos corretos para realizar
-- A restauração do backup --
RESTORE FILELISTONLY
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Backup\SONDA.bak';
GO

-- Altera o banco para o modo SINGLE_USER --
ALTER DATABASE SONDA
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

--
RESTORE DATABASE SONDA
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\Backup\SONDA.bak'
WITH
  MOVE 'SONDA' TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS01\MSSQL\DATA\SONDA.mdf',
REPLACE,
RECOVERY;
GO
