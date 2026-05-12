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

-- TRIGGER --
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
