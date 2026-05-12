--------------------------------------------------------------
-- 01_Cria_Quitanda.sql
-- Cria o banco de dados QUITANDA
-- No caso, usei QUITANDA123
--------------------------------------------------------------


-- Habilita o contexto do banco de dados MASTER
USE Master
GO


--------------------------------------------------------------
-- Cria o banco de dados QUITANDA
--------------------------------------------------------------


-- Cria o banco de dados QUITANDA
IF DB_ID('QUITANDA123') IS NULL
    
    -- Cria uma pasta para armazenar o banco
    -- EXEC XP_CREATE_SUBDIR 'E:\Quitanda\'
    EXEC master.dbo.xp_create_subdir N'/var/opt/mssql/data/Quitanda123';
    
    -- Cria o banco de dados para o estudo de triggers
    CREATE DATABASE QUITANDA123
    ON PRIMARY
        (NAME = 'Dados_01_PRIMARY',
         -- FILENAME = 'E:\Quitanda\Dados_01.mdf',
         FILENAME = N'/var/opt/mssql/data/Quitanda123/Dados_01.mdf',
         SIZE = 30MB,
         FILEGROWTH = 10%),

    FILEGROUP [FG1]
        (NAME = 'Dados_02_FG1',
         -- FILENAME = 'E:\Quitanda\Dados_02.ndf',
         FILENAME = N'/var/opt/mssql/data/Quitanda123/Dados_02.ndf',
         SIZE = 10MB,
         FILEGROWTH = 10%)

    LOG ON
        (NAME = 'Dados_LOG',
         -- FILENAME = 'E:\Quitanda\Dados_LOG.ldf',
         FILENAME = N'/var/opt/mssql/data/Quitanda123/Dados_LOG.ldf',
         SIZE = 5MB,
         FILEGROWTH = 10%)
GO


-- Habilita o contexto do banco de dados QUITANDA
USE QUITANDA123
GO


--------------------------------------------------------------
-- Criação das tabelas do banco de dados QUITANDA
--------------------------------------------------------------


-- Tabela CLIENTES
CREATE TABLE CLIENTES (
    Cod_Cliente INT PRIMARY KEY,
    Nome        CHAR(20)
)
GO


-- Tabela PRODUTOS
CREATE TABLE PRODUTOS (
    Cod_Produto INT PRIMARY KEY,
    Descricao   CHAR(30),
    Qtd_Estoque INT
)
GO


-- Tabela COMPRAS
CREATE TABLE COMPRAS (
    Cod_Compra  INT PRIMARY KEY,
    Cod_Cliente INT FOREIGN KEY REFERENCES CLIENTES(Cod_Cliente),
    Data        DATE
)
GO


-- Tabela ITENS
-- Utiliza uma coluna computada para armazenar o total
-- referente ao valor de cada item comprado
CREATE TABLE ITENS (
    Cod_Compra     INT FOREIGN KEY REFERENCES COMPRAS(Cod_Compra),
    Cod_Produto    INT FOREIGN KEY REFERENCES PRODUTOS(Cod_Produto),
    Valor_Unitario DECIMAL(9,2),
    Quantidade     INT,
    Valor_Item     AS Valor_Unitario * Quantidade,
    PRIMARY KEY(Cod_Compra, Cod_Produto)
)
GO


-- Exibe o nome das tabelas no banco de dados em uso
SELECT name
FROM sys.tables
GO


--------------------------------------------------------------
-- Insere alguns dados nas tabelas
--------------------------------------------------------------


-- Insere alguns clientes
INSERT INTO CLIENTES VALUES
    (1, 'Ana'),
    (2, 'Maria'),
    (3, 'João'),
    (4, 'Pedro'),
    (5, 'Carlos'),
    (6, 'Renata'),
    (7, 'Tiago'),
    (8, 'Miriam'),
    (9, 'Hugo'),
    (10, 'Felipe')
GO


-- Insere alguns produtos
INSERT INTO PRODUTOS VALUES
    (1,'Arroz', 100),
    (2, 'Feijão', 100),
    (3, 'Milho', 100),
    (4, 'Batata', 100),
    (5, 'Café', 200),
    (6, 'Farinha', 50),
    (7, 'Tomate', 100),
    (8, 'Açúcar', 200),
    (9, 'Ervilha', 100),
    (10, 'Leite', 100)
GO


-- Altera o formato de entrada de data e hora
SET DATEFORMAT DMY
GO


-- Insere algumas compras
INSERT INTO COMPRAS VALUES
    (1, 1, '10/05/2018'),
    (2, 2, '10/05/2018'),
    (3, 3, '12/04/2018'),
    (4, 3, '15/05/2018'),
    (5, 5, '15/06/2018'),
    (6, 1, '11/04/2018'),
    (7, 1, '05/03/2018'),
    (8, 6, '05/03/2018'),
    (9, 6, '02/03/2018'),
    (10, 7, '02/02/2018')
GO


-- Altera o formato de entrada de data e hora
SET DATEFORMAT MDY
GO


-- Insere alguns itens
INSERT INTO ITENS VALUES
    (1, 1, 12.50, 5),
    (1, 2, 4.50, 7),
    (1, 3, 3, 2),
    (2, 1, 12.50, 10),
    (2, 2, 4.50, 3),
    (2, 3, 3, 2),
    (2, 4, 3, 2),
    (2, 5, 12.89, 10),
    (3, 6, 3.29, 2),
    (3, 9, 1.59, 7),
    (4, 1, 12.50, 2),
    (5, 8, 3.29, 2),
    (5, 10, 2.99, 5),
    (6, 2, 4.50, 8),
    (6, 4, 3, 7),
    (6, 6, 3.29, 2),
    (6, 7, 5, 5),
    (7, 6, 3.29, 2),
    (8, 1, 12.50, 1),
    (9, 5, 12.89, 12),
    (9, 6, 3.29, 5),
    (10, 1, 12.50, 2),
    (10, 2, 4.50, 3),
    (10, 3, 3, 7),
    (10, 4, 3, 5),
    (10, 5, 12.89, 5),
    (10, 6, 3.29, 4),
    (10, 7, 5, 4),
    (10, 8, 12.50, 2),
    (10, 9, 1.59, 7)
GO
