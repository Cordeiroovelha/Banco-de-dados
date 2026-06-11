-------------------------------------------------------------------------------
-- 01_Cria_Banco_CARREFULVIO.sql
-- Demonstra a utilização de transações
-- Demonstra a utilização de logins, usuáios e permissões
-- Demonstra a utilização de rotinas de backup
-------------------------------------------------------------------------------


USE Master
GO


-- Cria o banco de dados
CREATE DATABASE SONDA
GO


-- Habilita o contexto
USE SONDA
GO


-------------------------------------------------------------------------------
-- Tabela CLIENTES
-------------------------------------------------------------------------------
CREATE TABLE CLIENTES (
  CodCliente INT PRIMARY KEY,
  NomeCliente VARCHAR(30),
  RendaMensal DECIMAL(9,2)
)
GO


-------------------------------------------------------------------------------
-- Tabela PRODUTOS
-------------------------------------------------------------------------------
CREATE TABLE PRODUTOS (
  CodProduto INT PRIMARY KEY,
  NomeProduto CHAR(30),
  ValorUnitario DECIMAL(9,2),
  CodCliente INT FOREIGN KEY REFERENCES CLIENTES (CodCliente)
)
GO


-- Exibe o nome das tabelas existentes no banco de dados em uso
SELECT name FROM sys.tables
GO


-------------------------------------------------------------------------------
-- Insere os dados de alguns clientes
-------------------------------------------------------------------------------
INSERT INTO CLIENTES VALUES	
  (1, 'Alison Mineiro', 5000.00),
  (2, 'Walter Paraía', 15000.00),
  (3, 'Helton Tiozão', 15000.00),
  (4, 'Wesley Safadão', 50000.00),
  (5, 'Maria Bonita', 2000.00),
  (6, 'Scarlett Johansson', 90000.00),
  (7, 'Renato Tadashi', 1.00),
  (8, 'Luiz Aopa', 1200.00)
GO


-- Exibe todos os dados dos clientes
SELECT * FROM CLIENTES
GO


-------------------------------------------------------------------------------
-- Insere os dados de alguns produtos
-------------------------------------------------------------------------------
INSERT INTO PRODUTOS VALUES	
  (1, 'XBox 360', 999.99, NULL),
  (2, 'Pão de Queijo 1kg', 21.50, 1),
  (3, 'Cachaça Ypióca', 14.50, 1),
  (4, 'Carne Seca', 19.25, 2),
  (5, 'Creme de Mandioquinha', 15.90, 2),
  (6, 'Whey Protein', 45.56, 3),
  (7, 'iPhone', 9999.00, 4),
  (8, 'MacBook Pro', 21799.00, 6),
  (9, 'Toddynho', 2.36, 7),
  (10, 'Bezerro', 750.00, 1),
  (11, 'Ferrari 458', 1390000.00, 6),
  (12, 'Peixeira', 24.70, 2),
  (13, 'Queijo', 29.00, 1),
  (14, 'Colônia Jequiti', 69.00, 5),
  (15, 'Peruca', 10.20, 3),
  (16, 'Sanfona', 400.00, 8),
  (17, 'Foto do Max', 1.00, 8),
  (18, 'DVD Um Maluco no Pedaço', 12.00, 8)
GO


-- Exibe todos os dados dos produtos
SELECT * FROM PRODUTOS
GO


-------------------------------------------------------------------------------
-- Exemplos de JOINS
-------------------------------------------------------------------------------


-- INNER JOIN

-- Seleciona todos os clientes e os produtos que eles compraram
SELECT CLIENTES.CodCliente AS 'Cóigo do Cliente',
       NomeCliente         AS 'Nome do Cliente',
       NomeProduto         AS 'Nome do Produto'	
FROM CLIENTES INNER JOIN PRODUTOS
  ON CLIENTES.CodCliente = PRODUTOS.CodCliente
ORDER BY CLIENTES.CodCliente
GO


-- LEFT JOIN

-- Seleciona todos os produtos que ninguém comprou
SELECT CodProduto          AS 'Código do Produto',
       NomeProduto         AS 'Nome do Produto',
       PRODUTOS.CodCliente AS 'Código do Cliente'
FROM PRODUTOS LEFT JOIN CLIENTES
  ON PRODUTOS.CodCliente = CLIENTES.CodCliente
WHERE PRODUTOS.CodCliente IS NULL
GO

