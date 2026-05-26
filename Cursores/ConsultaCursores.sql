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

-- Fech Last --
DECLARE curCidade SCROLL CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH LAST FROM curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade -- Colombo --
GO

-- Fech Next --
DECLARE curCidade CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH NEXT FROM curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade -- Campos de Jordão --
GO

-- Fech Next com Loop WHILE --
DECLARE curCidade CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH NEXT FROM curCidade INTO @cidade

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @cidade
        FETCH NEXT FROM curCidade INTO @cidade
    END
GO

CLOSE curCidade
DEALLOCATE curCidade
GO

-- Cursor do tipo rolável --
DECLARE curCidade SCROLL CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH PRIOR FROM curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade -- Não Retorna nada --
GO

-- Ex 02 --
DECLARE curCidade SCROLL CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH RELATIVE 5 FROM curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade -- São Paulo --
GO

-- Fech Absolute --
DECLARE curCidade SCROLL CURSOR
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)

OPEN curCidade
FETCH ABSOLUTE 5 FROM curCidade INTO @cidade
CLOSE curCidade
DEALLOCATE curCidade

PRINT @Cidade -- Taubaté --
GO

-- FAST_FORWARD --
DECLARE curCidade CURSOR FAST_FORWARD
FOR
    SELECT Cidade FROM CIDADES
GO

DECLARE @cidade CHAR(20)
DECLARE @counter INT

OPEN curCidade

SET @counter = 1
WHILE @counter <= 3
    BEGIN
        FETCH curCidade INTO @cidade
        PRINT @cidade
        SET @counter = @counter + 1
    END 
GO

CLOSE curCidade
DEALLOCATE curCidade

-- For Update --
DECLARE curCidade CURSOR
FOR
    SELECT Codigo,
           Cidade
    FROM CIDADES
GO

OPEN curCidade
FETCH curCidade

UPDATE CIDADES
    SET Cidade = 'São José dos Campos'
    WHERE CURRENT OF curCidade
GO

CLOSE curCidade
DEALLOCATE curCidade
GO

SELECT * FROM CIDADES
GO

-- Tabela AUTORES --
CREATE TABLE AUTORES(
    Nome      CHAR(20),
    Sobrenome CHAR(30)
)
GO

INSERT INTO AUTORES VALUES
    ('Paulo','Giovani'),
    ('Michele','Lima'),
    ('Algusto','Manzano'),
    ('Ceila','Rodrigus'),
    ('Claudio','Farias'),
    ('Daphne','Magalhães')
GO

SELECT * FROM AUTORES
GO

CREATE TABLE DADOS_CURSOR (
    ID        INT IDENTITY,
    Nome      CHAR(20),
    Sobrenome CHAR(30)
)
GO
