IF DB_ID(N'Loja') IS NULL
	CREATE DATABASE Loja;
ELSE
	USE Loja;
GO

-- Ex01 --
SELECT * FROM CLIENTES;
GO

-- Ex02 --
SELECT * FROM CLIENTES
ORDER BY Nome;
GO

-- Ex03 --
SELECT * FROM CLIENTES
ORDER BY Idade;
GO

-- Ex04 --
SELECT * FROM CLIENTES
ORDER BY Idade DESC;
GO

-- Ex05 --
SELECT * FROM CLIENTES
ORDER BY Sexo DESC;
GO

-- Ex06 --
SELECT Nome, 
	   Idade,
	   Email
FROM CLIENTES
GO

-- Ex07 --
SELECT Nome, 
	   Idade,
	   Email
FROM CLIENTES
ORDER BY Nome;
GO

-- Ex08 --
SELECT ID	  AS 'Codigo do Cliente',
	   Nome, 
	   Idade,
	   Email
FROM CLIENTES
WHERE ID >= 10;
GO

-- Ex09 --
SELECT TOP 5
	   ID	  AS 'Codigo do Cliente',
	   Nome, 
	   Idade,
	   Email
FROM CLIENTES
ORDER BY Nome
GO

-- Ex10 --
SELECT ID	  AS 'Codigo do Cliente',
	   Nome,
	   Sexo,
	   Idade,
	   Email  AS 'E-mail'
FROM CLIENTES
WHERE Idade >= 30 AND
	  Sexo = 'm'
ORDER BY Nome;
GO

---------- Lista03 ----------
-- Ex01 --
ALTER TABLE FUNCIONARIOS
    ADD Telefone    CHAR(10)
GO

ALTER TABLE FUNCIONARIOS
    ADD DDD    CHAR(2)
GO
