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

-- RTRIM --
-- Remove espaçoes em Branco --
DECLARE cur_autores CURSOR
FOR
    SELECT RTRIM(Sobrenome),
           RTRIM(Nome)
    FROM AUTORES
    WHERE Sobrenome LIKE 'M%'
    ORDER BY Sobrenome, Nome
GO

DECLARE @sobrenome VARCHAR(30),
        @nome      VARCHAR(20)

OPEN cur_autores
FETCH FROM cur_autores
    INTO @nome, @sobrenome
SET NOCOUNT ON
WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Autor: ' + @nome + ' ' + @sobrenome
        INSERT INTO DADOS_CURSOR VALUES
        (@nome, @sobrenome)
        FETCH NEXT FROM cur_autores
            INTO  @sobrenome, @nome
    END
GO

SET NOCOUNT OFF
CLOSE cur_autores
DEALLOCATE cur_autores
GO

SELECT * FROM DADOS_CURSOR
GO

-- Tabela LIVROS --
CREATE TABLE LIVROS (
    Codigo   INT PRIMARY KEY,
    Titulo   VARCHAR(15),
    Situacao VARCHAR(12)
);
GO

INSERT INTO LIVROS VALUES
 (1, 'Livro A', 'Disponivel'),
 (2, 'Livro B', 'Disponivel'),
 (3, 'Livro C', 'Disponivel'),
 (4, 'Livro D', 'Disponivel'),
 (5, 'Livro E', 'Disponivel');
GO

SELECT * FROM LIVROS
GO

-- Tabela EMPRESTIMO --
CREATE TABLE EMPRESTIMO (
    Cod_Emprestimo INT PRIMARY KEY,
    Cod_Livro INT FOREIGN KEY REFERENCES LIVROS(Codigo)
);
GO

INSERT INTO EMPRESTIMO VALUES
    (1,1),
    (2,2),
    (3,3);
GO

SELECT * FROM EMPRESTIMO;
GO

SELECT E.Cod_Emprestimo AS 'Codigo do Emprestimo',
       E.Cod_Livro      AS 'Codigo do Livro',
       L.Titulo         AS 'Titulo'
FROM EMPRESTIMO E INNER JOIN LIVROS L
    ON L.Codigo = E.Cod_Emprestimo
GO

-- PROCEDURE --
-- Procedimento para alterar a disponibilidade de um ou mais Livro--
CREATE PROCEDURE ATUALIZA_LIVROS
AS
    SET NOCOUNT ON
    DECLARE cur_emprestimos CURSOR
    FOR 
        SELECT Cod_Livro FROM EMPRESTIMO
    DECLARE @cod_emprestado INT
    OPEN cur_emprestimos
    FETCH FROM cur_emprestimos INTO @cod_emprestado
    UPDATE LIVROS
        SET Situacao = 'Emprestado'
        WHERE Codigo = @cod_emprestado
    WHILE @@FETCH_STATUS = 0
        BEGIN
            FETCH NEXT FROM cur_emprestimos INTO @cod_emprestado
            UPDATE LIVROS
                SET Situacao = 'Emprestado'
                WHERE Codigo = @cod_emprestado
        END
    CLOSE cur_emprestimos
    DEALLOCATE cur_emprestimos
    SET NOCOUNT OFF
GO

SELECT Codigo   AS 'Codigo',
       Titulo   AS 'Titulo',
       Situacao AS 'Situação'
FROM LIVROS;
GO

EXEC ATUALIZA_LIVROS;
GO

INSERT INTO EMPRESTIMO VALUES (4,5)
GO

SELECT E.Cod_Emprestimo AS 'Codigo do Emprestimo',
       E.Cod_Livro      AS 'Codigo do Livro',
       L.Titulo         AS 'Titulo'
FROM EMPRESTIMO E INNER JOIN LIVROS L
    ON L.Codigo = E.Cod_Livro
GO
