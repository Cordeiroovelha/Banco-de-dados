-- Projeto final Banco de dados 2 --
-- Autoria de Murilo Juttel Cordeiro --

-- Acesso ao banco de dados --
IF(DB_ID(N'Hospital') IS NULL)
    CREATE DATABASE Hospital;
ELSE
    USE Hospital;
GO

--------------------------------------
-- Consultas que modificam a tabela --
--------------------------------------
-- 1. consulta que ira alterar o status de "Em atendimento" para "Atendido" 
--    na tabela "CONSULTA" apenas quando o id da consulta for 6, 7 ou 8.
UPDATE CONSULTA
SET Situacao = 'Atendido'
    WHERE ID IN (6, 7, 8);
GO

SELECT * FROM CONSULTA WHERE ID IN (6, 7, 8);


-- 2. faça uma consulta que adicione duas novas alas na tabela "ALA", elas sendo "Psiquiatria" e  "Ambulatório"
--    porem os dados da capacidade das alas deve ser nulo

INSERT INTO ALA (ID, ID_Hospital, Nome, Procedimento)
VALUES 
    (6, 1, 'Psiquiatria', 'Atendimento de saúde mental'),
    (7, 1, 'Ambulatório', 'Atendimento ambulatorial');

SELECT * FROM ALA;

-- 3. Consulta que altere as alas que alguns medicos da tabela "MEDICO" estão trabalhando, 
--    mude os medicos que estão na ala "2" para a nova ala "6" e os da ala "5" para a ala "7"

UPDATE MEDICO
SET Ala = 6
WHERE Ala = 2;
GO
UPDATE MEDICO
SET Ala = 7
WHERE Ala = 5;
GO
SELECT * FROM MEDICO WHERE Ala = 6 OR Ala = 7;
GO

-- 4. consulta que verifica quantas consultas ja foram atendidas e 
--    remova as linhas da tabela "CONSULTA" que estão com a situação de "atendido"
SELECT COUNT(*) AS 'Total de Atendidos'
FROM CONSULTA
WHERE Situacao = 'Atendido';
GO

DELETE FROM CONSULTA
WHERE Situacao = 'Atendido';

SELECT * FROM CONSULTA;

-- 5. consulta que cria uma tabela de copia da tabela "PACIENTES", 
--    verifica e em seguida remova os pacientes que não estão na tabela "CONSULTA"

SELECT * INTO PacienteCOPIA
FROM PACIENTES;

SELECT COUNT(*) AS 'Pacientes A Remover'
FROM PacienteCOPIA p
WHERE NOT EXISTS (
    SELECT 1 
    FROM CONSULTA c 
    WHERE c.ID_Paciente = p.ID
);

SELECT p.ID, p.Nome, p.Idade, p.Descricao
FROM PacienteCOPIA p
WHERE NOT EXISTS (
    SELECT 1 
    FROM CONSULTA c 
    WHERE c.ID_Paciente = p.ID
);

DELETE FROM PacienteCOPIA
WHERE ID NOT IN (
    SELECT DISTINCT ID_Paciente
    FROM CONSULTA
    WHERE ID_Paciente IS NOT NULL
);

SELECT * FROM PacienteCOPIA;

DROP TABLE PacienteCOPIA;

-- 6. consulta que altere o nível de prioridade dos pacientes da tabela "PACIENTE", 
--    caso a idade do paciente seja maior ou igual a 55 anos e 
--    sua prioridade for menor que 1, aumente o nivel de prioridade em -1

SELECT 
    ID, 
    Nome, 
    Idade, 
    Prioridade AS 'Prioridade Atual',
    Prioridade - 1 AS 'Nova Prioridade'
FROM PACIENTES
WHERE Idade >= 50 AND Prioridade <= 3;

UPDATE PACIENTES
SET Prioridade = Prioridade - 1  -- Diminui o número para aumentar a prioridade
WHERE Idade >= 50 AND Prioridade <= 3;

-- 7. consulta que aumente o numero de capacidade de todas as alas da tabela "ALA" em 10 menos na ala com o id 3

UPDATE ALA
SET Capacidade = ISNULL(Capacidade, 0) + 10
WHERE ID != 3;

SELECT 
    ID, 
    Nome, 
    Capacidade AS CapacidadeNova,
    CASE 
        WHEN ID = 3 THEN 'Não alterada'
        ELSE 'Aumentada em 10'
    END AS Status
FROM ALA
ORDER BY ID;

-- 8. consulta que mostre os nomes dos pacientes da tabela "PACIENTE", 
--    o id da consulta que eles estão associados da tabela "CONSULTA" e 
--    o nome do medico que esta atendendo da tabela "MEDICO", tudo ordenado pelo nome dos pacientes

SELECT 
    p.Nome AS 'Nome do Paciente',
    c.ID AS 'ID da Consulta',
    m.Nome AS 'Nome do Medico'
FROM PACIENTES p
INNER JOIN CONSULTA c ON p.ID = c.ID_Paciente
INNER JOIN MEDICO m ON c.ID_Medico = m.ID
ORDER BY p.Nome;

-- 9. consulta que apresente os nomes dos medicos da tabela "MEDICO"  e 
--    os nomes das alas que eles estão atuando da tabela "ALA", ordenado pelo nome dos medicos
--    mostrando tambem a capacidade das alas e os medicos que não estão alocados em nenhuma ala

SELECT 
    m.Nome AS 'Nome dos Medico',
    ISNULL(a.Nome, 'Sem ala designada') AS 'Nome da Ala',
    a.Capacidade   AS 'Capacidade da Ala',
    a.Procedimento AS 'Procedimentos da Ala'
FROM MEDICO m
    LEFT JOIN ALA a ON m.Ala = a.ID
ORDER BY m.Nome;

-- 10. consulta que mostre o nome do hospital da tabela "HOSPITAL" 
--     juntamente com os dados das alas que fazem parte dele,
--     isso é, a quantidade de alas e a capacidade total

SELECT 
    h.Nome AS 'Nome do Hospital',
    COUNT(a.ID) AS 'Quantidade de Alas',
    SUM(a.Capacidade) AS 'Capacidade Total do Hospital'
FROM HOSPITAL h
LEFT JOIN ALA a ON h.ID = a.ID_Hospital
GROUP BY h.ID, h.Nome;


-- 11. consulta para verificar todos os pacientes que possuem "silva" no nome

-- insersão de novos dados para melhor visualização --
INSERT INTO PACIENTES VALUES 
    (16, 'João Silva', 25, '(11)99999-1111', 'O+', 2, 'Dor de garganta'),
    (17, 'Maria Silva', 34, '(11)99999-2222', 'A+', 1, 'Febre e dor de cabeça'),
    (18, 'Pedro Silva', 42, '(11)99999-3333', 'B+', 2, 'Dores musculares');

-- consulta --
SELECT *
FROM PACIENTES
WHERE LOWER(Nome) LIKE '%silva%';

-- 12

SELECT 
    m.ID AS 'ID do Medico' ,
    m.Nome AS 'Nome do Medico',
    m.Especialidade,
    a.Nome AS 'Nome da ala Ala',
    h.Nome AS Hospital
FROM MEDICO m
INNER JOIN ALA a ON m.Ala = a.ID
INNER JOIN HOSPITAL h ON m.Hospital = h.ID
ORDER BY m.Nome;


-- 13. consulta mostra um relatório detalhado de todas as consultas, 
--     incluindo informações dos pacientes, médicos responsáveis e alas de atendimento

SELECT 
    c.ID AS 'ID da Consulta',
    c.Data,
    c.Situacao,
    p.Nome AS 'Nome do Paciente',
    p.Idade AS 'Idade do Paciente',
    p.Prioridade AS 'Nivel de Prioridade',
    p.TipoSanguinio,
    m.Nome AS 'Nome do Medico',
    a.Nome AS 'Ala de Atendimento',
    h.Nome AS 'Hospital'
FROM CONSULTA c
INNER JOIN PACIENTES p ON c.ID_Paciente = p.ID
INNER JOIN MEDICO m ON c.ID_Medico = m.ID
INNER JOIN ALA a ON c.Ala = a.ID
INNER JOIN HOSPITAL h ON m.Hospital = h.ID
ORDER BY c.Data DESC, p.Prioridade ASC;

-- 14. consulta mostra estatísticas agrupadas por ala,
--     incluindo quantidade de pacientes em atendimento, média de idade, prioridades e taxa de ocupação

SELECT 
    a.ID AS 'ID das Ala',
    a.Nome AS 'Nome da Ala',
    a.Capacidade,
    COUNT(c.ID) AS 'Total de Consultas',
    SUM(CASE WHEN c.Situacao = 'Em atendimento' THEN 1 ELSE 0 END) AS 'Consultas Em Andamento' ,
    SUM(CASE WHEN c.Situacao = 'Atendido' THEN 1 ELSE 0 END) AS 'Consultas Atendidas',
    ROUND(AVG(p.Idade), 0) AS 'Media Idade' ,
    MAX(p.Prioridade) AS 'Maior Prioridade',
    MIN(p.Prioridade) AS 'Menor Prioridade'
FROM ALA a
LEFT JOIN CONSULTA c ON a.ID = c.Ala
LEFT JOIN PACIENTES p ON c.ID_Paciente = p.ID
GROUP BY a.ID, a.Nome, a.Capacidade
ORDER BY a.Capacidade DESC;

-- 15. consulta mostra a carga de trabalho de cada médico

SELECT 
    m.ID AS ID_Medico,
    m.Nome AS NomeMedico,
    m.Especialidade,
    a.Nome AS AlaPrincipal,
    COUNT(c.ID) AS TotalAtendimentos,
    SUM(CASE WHEN c.Situacao = 'Em atendimento' THEN 1 ELSE 0 END) AS AtendimentosEmAndamento,
    SUM(CASE WHEN c.Situacao = 'Atendido' THEN 1 ELSE 0 END) AS AtendimentosConcluidos
FROM MEDICO m
LEFT JOIN CONSULTA c ON m.ID = c.ID_Medico
LEFT JOIN PACIENTES p ON c.ID_Paciente = p.ID
LEFT JOIN ALA a ON m.Ala = a.ID
GROUP BY m.ID, m.Nome, m.Especialidade, a.Nome
ORDER BY TotalAtendimentos DESC, m.Nome;
GO

-- 16. procedimento chamado "uspCalcIdadePaciente" no qual 
--     quando executado calcula a idade media de todos os pacientes da tabela "PACIENTE"

CREATE PROCEDURE uspCalcIdadePacientes
    @media DECIMAL(5,2) OUTPUT
AS
BEGIN
    SELECT @media = AVG(Idade)
    FROM PACIENTES;
    SELECT @media as 'Idade Media';
END;
GO

DECLARE @Media DECIMAL(5,2);
EXEC uspCalcIdadePacientes @media = @Media OUTPUT;
PRINT 'A idade média dos pacientes é: ' + CAST(@Media AS VARCHAR(10));


-- 17. procedimento que mostre a capacidade das alas da tabela "ALA" 
--     subtraindo do total a quantidade de consultas da tabela "CONSULTA" que estão acontecendo naquelas alas

CREATE PROCEDURE uspCapacidadeDisponivelAlas
AS
BEGIN
    SELECT 
        a.ID AS 'ID_Ala',
        a.Nome AS 'Nome da Ala',
        a.Capacidade AS 'Capacidade Total',
        COUNT(c.ID) AS 'Consultas Em Andamento',
        (a.Capacidade - COUNT(c.ID)) AS 'Capacidade Disponivel'
    FROM ALA a
    LEFT JOIN CONSULTA c ON a.ID = c.Ala AND c.Situacao = 'Em atendimento'
    GROUP BY a.ID, a.Nome, a.Capacidade
    ORDER BY a.ID;
END;
GO

EXEC uspCapacidadeDisponivelAlas;

-- 18. procedimento que calcula a quantidade de consultas da tabela "CONSULTA" que cada medico participa

CREATE PROCEDURE uspQuantConsultasPorMedico
AS
BEGIN
    SELECT 
        m.ID AS 'ID Medico',
        m.Nome AS 'Nome do Medico',
        m.Especialidade,
        COUNT(c.ID) AS 'Total Consultas'
    FROM MEDICO m
    LEFT JOIN CONSULTA c ON m.ID = c.ID_Medico
    GROUP BY m.ID, m.Nome, m.Especialidade
    ORDER BY 'Total Consultas' DESC, m.Nome;
END;

EXEC uspQuantConsultasPorMedico;
GO

-- 19. trigger com o nome "TRG_ATUALIZA_CONSULTAS" no qual remove as consultas que estão com a situação "Atendido" 
--     toda vez que algum novo dado for inserido na tabela "CONSULTA"
CREATE TRIGGER TRG_ATUALIZA_CONSULTAS
ON CONSULTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @QuantidadeRemovida INT;
    
    DELETE FROM CONSULTA
    WHERE Situacao = 'Atendido';
    
    SET @QuantidadeRemovida = @@ROWCOUNT;
    
    IF @QuantidadeRemovida > 0
    BEGIN
        PRINT 'Trigger executado: ' + CAST(@QuantidadeRemovida AS VARCHAR(10)) + 
              ' consulta(s) com situação "Atendido" foram removidas da tabela CONSULTA.';
    END
END;
GO

INSERT INTO CONSULTA (ID, ID_Paciente, ID_Medico, Data, Situacao, Ala)
VALUES (20, 1, 2, GETDATE(), 'Em atendimento', 1);

-- 20. Trigger que insere os dados de todas as consultas que foram realizadas em uma tabela
--     de registro chamada "CONSULTA_LOG"

CREATE TABLE CONSULTA_LOG (
    ID_Registro INT IDENTITY(1,1) PRIMARY KEY,
    ID_Consulta INT,
    ID_Paciente INT,
    ID_Medico INT,
    Data_Consulta DATE,
    Situacao VARCHAR(15),
    Ala INT,
    Data_Insercao DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER TRG_REGISTRA_CONSULTAS_INSERT
ON CONSULTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO CONSULTA_LOG (ID_Consulta, ID_Paciente, ID_Medico, Data_Consulta, Situacao, Ala)
    SELECT 
        ID, 
        ID_Paciente, 
        ID_Medico, 
        Data, 
        Situacao, 
        Ala
    FROM inserted;
    
    PRINT 'Trigger executado: Nova consulta registrada com sucesso!';
END;
GO

INSERT INTO CONSULTA (ID, ID_Paciente, ID_Medico, Data, Situacao, Ala)
VALUES (21, 1, 2, GETDATE(), 'Em atendimento', 1);