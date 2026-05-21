USE CURSORES
GO

-- CURSOR --
DECLARE curCidade CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

-- Abre o cursor -- 
OPEN curCidade
GO

-- pega o nome da cidade atual --
FETCH curCidade
GO

-- Fecha o cursor --
CLOSE curCidade
GO

-- Desativa o cursor --
DEALLOCATE curCidade

-- Criando o cursor novamente --
DECLARE curCidade CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

-- variavel que vai conter o nome da cidade --
DECLARE @cidade CHAR(20)

-- Operaçoes com o cursor --
OPEN curCidade
FETCH curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade
GO