USE QUITANDA
GO

-- Visualiza os itens que voce apagou --
DELETE ITENS OUTPUT DELETED.*
GO

DELETE ITENS 
OUTPUT deleted.Cod_Compra,
	   deleted.Cod_Produto
GO

SELECT * FROM ITENS;
GO

-- OUTPUT para visualização imediata --
UPDATE PRODUTOS
	SET Qtd_Estoque += 10
	OUTPUT INSERTED.*
GO

UPDATE PRODUTOS
	SET Qtd_Estoque += 10
	OUTPUT deleted.*
GO

SELECT * FROM PRODUTOS;
GO

UPDATE PRODUTOS
	SET Qtd_Estoque += 10
	OUTPUT deleted.*,
	REPLICATE(' ', 16) + '>>>' + REPLICATE(' ', 10)
	AS '<<< Antes -- Depois >>>',
	inserted.*
GO

-------------
-- TRIGGER --
-------------

-- Trigger de INSERT --
CREATE TRIGGER trg_INSERT ON PRODUTOS
	FOR INSERT
AS
	SELECT 'Produto(s) cadastrado(s) com sucesso: '
	SELECT * FROM INSERTED
GO

INSERT INTO PRODUTOS VALUES (11, 'Biscoito', 100);
GO

INSERT INTO PRODUTOS VALUES (12, 'Uva', 110);
INSERT INTO PRODUTOS VALUES (13, 'Melancia', 120);
INSERT INTO PRODUTOS VALUES (14, 'Laranja', 150);
GO

-- trigger de DELETE --
CREATE TRIGGER trg_DELETA ON PRODUTOS
	FOR DELETE
AS
	DECLARE @total AS INT
	SET @total = (SELECT COUNT(*) FROM DELETED)
	PRINT ' Registro(s) excluido(s) com sucesso: ' + CAST(@total AS CHAR)
GO

SELECT TOP 2 *
FROM PRODUTOS
ORDER BY Cod_Produto DESC
GO

DELETE FROM PRODUTOS
WHERE Cod_Produto IN (SELECT TOP 2 Cod_Produto
					  FROM PRODUTOS
					  ORDER BY Cod_Produto DESC)
GO

-- Trigger UPDATE --
CREATE TRIGGER trg_ATUALIZA ON PRODUTOS
	FOR UPDATE
AS
	BEGIN
		DECLARE @num_atualizados INT
		SELECT @num_atualizados = COUNT(*) FROM DELETED
		SELECT 'Numero de Registro(s) atualizado(s) com sucesso: ' +
		CONVERT(VARCHAR(03), @num_atualizados)
		SELECT * FROM INSERTED
		END
GO

SELECT TOP 3 *
FROM PRODUTOS
ORDER BY Cod_Produto DESC
GO

UPDATE PRODUTOS
	SET Qtd_Estoque = 120
	WHERE Cod_Produto = 1
GO

UPDATE PRODUTOS
	SET Qtd_Estoque = 100
	WHERE Cod_Produto != 100
GO


-- Trigger que altera varias tabelas --
CREATE TRIGGER trg_ATUALIZA_ESTOQUE ON ITENS
	AFTER INSERT
AS
	BEGIN
		UPDATE PRODUTOS
			SET Qtd_Estoque -= inserted.Quantidade
			FROM PRODUTOS INNER JOIN INSERTED
			ON PRODUTOS.Cod_Produto = inserted.Cod_Produto
	END
GO

SET DATEFORMAT DMY
GO

INSERT INTO COMPRAS VALUES (11,1, '22/08/2018')
GO

SELECT * FROM ITENS
GO

INSERT INTO ITENS VALUES (11,1, 12.5, 5)
GO

INSERT INTO ITENS VALUES 
(11,5, 12.89, 20),
(11,7, 5, 10),
(11, 10, 2.99, 10)
GO


-- NOVA TABELA --
CREATE TABLE AUDITORIA_ITENS (
	Date           SMALLDATETIME DEFAULT GETDATE(),
	Nome_Usuario   VARCHAR(20)   DEFAULT USER_NAME(),
	Computador     VARCHAR(20)   DEFAULT HOST_NAME(),
	Tabela         CHAR(15),
	Cod_Compra     INT,
	Cod_Produto    INT,
	Valor_Unitario DECIMAL(9,2),
	Quantidade     INT,
	Valor_Item     DECIMAL(9,2)
)
GO

SELECT * FROM sys.triggers
GO

-- Trigger para AUDITORIA --
CREATE TRIGGER trg_AUDITORIA_COMPRAS ON ITENS
	FOR DELETE
AS
	SET NOCOUNT ON
	INSERT INTO AUDITORIA_ITENS (Tabela, Cod_Compra, Cod_Produto,
	Valor_Unitario, Quantidade, Valor_Item)
	SELECT 'ITENS',
		   Cod_Compra,
		   Cod_Produto,
		   Valor_Unitario,
		   Quantidade,
		   Valor_Item
	FROM DELETED
	SET NOCOUNT OFF
GO

SELECT * FROM ITENS
GO

DELETE FROM ITENS
WHERE Cod_Compra = 11
GO

DELETE FROM ITENS
WHERE Cod_Compra = 1
GO

SELECT * FROM AUDITORIA_ITENS
GO

-- Atualiza um trigger --
CREATE TRIGGER trg_AUDITORIA_ITENS_DELETA_ATUALIZA ON AUDITORIA_ITENS
	INSTEAD OF DELETE, UPDATE
AS
	BEGIN
		PRINT 'Você não tem permissão para excluir dados da tabela AUDITORIA_ITENS'
		PRINT 'Procure o responsavel pela aplicação'
	END
GO

DELETE FROM AUDITORIA_ITENS
GO

SELECT name FROM sys.triggers
GO

-- Trigger de permissão de criação de tabela --
CREATE TRIGGER trg_CONTROLE ON DATABASE
	FOR CREATE_TABLE
AS
	PRINT 'Tentativa de criação de uma nova tabela!'
	RAISERROR ('A criação de novas tabelas não é permitida nesse banco', 16, 1)
	ROLLBACK
GO

CREATE TABLE CATEGORIA (
	ID INT PRIMARY KEY
	Nome CHAR(20)
)
GO

-- remover banco de dados --
USE master
GO

DROP DATABASE QUITANDA
GO

-- Remove o diretorio onde o banco foi criado --
DECLARE @comando AS NVARCHAR(200)
DECLARE @diretorio AS NVARCHAR(200)
SET @diretorio = 'C:\Documentos\BANCO-DE-DADOS\Quintanda'
SET @comando = N'RMDIR ' + @diretorio
EXEC MASTER.DBO.XP_CMDSHELL @comando, no_output
GO

