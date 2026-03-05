-- criação do banco de dados--
CREATE DATABASE EmpresaCJ3034747;
GO
-- habilitar o contexto -- 
USE EmpresaCJ3034747;
GO

-- Cria a tabela FUNCIONARIOS -- 
CREATE TABLE FUNCIONARIOS01 (
    ID        INT            PRIMARY KEY,
    Nome      VARCHAR(25)    NOT NULL,
    Sexo      CHAR(1)        NULL,
    Admissao  DATE           NOT NULL,
    Salario   DECIMAL(10,2)  NOT NULL
);
GO

-- inserçao de dados --

-- altera o formato de data do SQL Server --
SET DATEFORMAT DMY;
GO

-- insere dados na tabela FUNCIONARIOS --
INSERT INTO FUNCIONARIOS (
    ID,
    Nome,
    Sexo,
    Admissao,
    Salario)
VALUES (1, 'Arthur Morgan', 'f', '10/01/2026', 2500.00);
GO
-- inserir dados cujo indentificador ja esteja cadastradoL -- 
INSERT INTO FUNCIONARIOS VALUES (2, 'John Marston', 'm', '05/03/2026', 5000.00);
GO

-- insersão em cadeia --
INSERT INTO FUNCIONARIOS VALUES (3, 'Hosea Matthews', 'm', '05/03/2026', 5000.00);
INSERT INTO FUNCIONARIOS VALUES (4, 'Sadie Adler', 'f', '05/03/2026', 5000.00);
INSERT INTO FUNCIONARIOS VALUES (5, 'Duch Van Der Linde', 'm', '05/03/2026', 5000.00);
GO

-- exibe os dados da tabela FUNCIONARISO --
SELECT * FROM FUNCIONARIOS;
GO