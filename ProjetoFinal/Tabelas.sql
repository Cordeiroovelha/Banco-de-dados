-- Projeto final Banco de dados 2 --
-- Autoria de Murilo Juttel Cordeiro --

IF(DB_ID(N'Hospital') IS NULL)
    CREATE DATABASE Hospital;
ELSE
    USE Hospital;
GO

CREATE TABLE PACIENTES(
	ID INT PRIMARY KEY,
	Nome		      VARCHAR(50),
	Idade		      INT,
    contatoEmergencia VARCHAR(15),
	TipoSanguinio     CHAR(3),
	Prioridade        INT,
	Descricao	      VARCHAR(250)
);

CREATE TABLE HOSPITAL(
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Endereco VARCHAR(75),
    Telefone VARCHAR(15),
    Email VARCHAR(50)
);

CREATE TABLE ALA(
    ID INT PRIMARY KEY,
    ID_Hospital INT,
    Nome VARCHAR(50),
    Capacidade INT,
    Procedimento VARCHAR(250),
    FOREIGN KEY (ID_Hospital) REFERENCES HOSPITAL(ID)
);

CREATE TABLE MEDICO(
    ID INT PRIMARY KEY,
    Nome           VARCHAR(50),
    Ala            INT,
    Especialidade  VARCHAR(50),
    Hospital       INT,
    FOREIGN KEY (Hospital) REFERENCES HOSPITAL(ID),
    FOREIGN KEY (Ala) REFERENCES ALA(ID)
);

CREATE TABLE CONSULTA(
    ID INT PRIMARY KEY,
    ID_Paciente INT,
    ID_Medico   INT,
    Data        DATE,
    Situacao    VARCHAR(15),
    Ala         INT,
    FOREIGN KEY (Ala) REFERENCES ALA(ID),
    FOREIGN KEY (ID_Paciente) REFERENCES PACIENTES(ID),
    FOREIGN KEY (ID_Medico) REFERENCES MEDICO(ID)    
);


INSERT INTO PACIENTES VALUES
--  (ID, Nome, Idade, contatoEmergencia, TipoSanguinio, Prioridade, Descricao)
    (1, 'Jose da Silva',    45, '(11)98765-4321', 'O-',  2, 'Dor de cabeça'),
    (2, 'Maria Oliveira',   32, '(11)91234-5678', 'A+',  1, 'Febre alta e tosse'),
    (3, 'Carlos Santos',    58, '(21)99876-5432', 'B+',  3, 'Dor no peito'),
    (4, 'Ana Paula Costa',  27, '(21)98765-1234', 'O+',  2, 'Fratura no braço direito'),
    (5, 'Roberto Lima',     63, '(21)99988-7766', 'AB-', 3, 'Dificuldade respiratória'),
    (6, 'Fernanda Souza',   41, '(11)97777-4444', 'A-',  2, 'Enxaqueca severa'),
    (7, 'Paulo Henrique',   35, '(21)98888-5555', 'O-',  1, 'Corte profundo na mão'),
    (8, 'Juliana Mendes',   29, '(11)95555-3333', 'B-',  2, 'Dor abdominal intensa'),
    (9, 'Marcos Vinicius',  72, '(21)94444-2222', 'A+',  3, 'Pressão alta e tontura'),
    (10, 'Patrícia Gomes',  38, '(21)93333-1111', 'O+',  1, 'Infecção na garganta'),
    (11, 'Ricardo Alves',   50, '(11)92222-8888', 'AB+', 2, 'Dores nas costas'),
    (12, 'Camila Rocha',    26, '(21)97777-6666', 'A+',  1, 'Alergia medicamentosa'),
    (13, 'Eduardo Campos',  47, '(21)96666-5555', 'O-',  2, 'Bronquite aguda'),
    (14, 'Tatiana Martins', 33, '(11)95555-4444', 'B+',  2, 'Enjoo e vômito'),
    (15, 'André Luiz',      55, '(21)98888-7777', 'A-',  3, 'Suspeita de infarto');

INSERT INTO HOSPITAL VALUES
--  (ID, Nome, Endereco, Telefone, Email)
    (1, 'Hospital Da Paz', 'Rua das Flores, 123, São Paulo', '(11)1234-5678', 'hospitaldapaz@gmail.com');

INSERT INTO ALA VALUES
--  (ID, ID_Hospital, Nome, Capacidade, Procedimento)
    (1, 1, 'Emergencia',       20, 'Casos Graves e Urgentes'),
    (2, 1, 'UTI',              10, 'Cuidados Intensivos e Monitoramento 24h'),
    (3, 1, 'Pediatria',        25, 'Atendimento Infantil e Neonatal'),
    (4, 1, 'Cirurgia',         30, 'Procedimentos Cirúrgicos Eletivos e Emergenciais'),
    (5, 1, 'Enfermaria Geral', 40, 'Internação para Pacientes Estáveis');

INSERT INTO MEDICO VALUES
--  (ID, Nome, Ala, Especialidade, Hospital)
    (1, 'Dr. Augusto Manzano',   3, 'Obstetrícia', 1),
    (2, 'Dra. Carla Menezes',    1, 'Clínica Médica', 1),
    (3, 'Dr. Ricardo Franco',    2, 'Medicina Intensiva', 1),
    (4, 'Dra. Beatriz Lima',     3, 'Pediatria Geral', 1),
    (5, 'Dr. Sergio Castelo',    1, 'Traumatologia', 1),
    (6, 'Dra. Vivian Noronha',   4, 'Cirurgia Geral', 1),
    (7, 'Dr. Otavio Rocha',      5, 'Cardiologia', 1),
    (8, 'Dra. Mariana Torres',   2, 'Pneumologia', 1),
    (9, 'Dr. Leonardo Campos',   4, 'Neurocirurgia', 1),
    (10, 'Dra. Patricia Mendes', 5, 'Ortopedia', 1);

INSERT INTO CONSULTA VALUES
--  (ID, ID_Paciente, ID_Medico, Data, Situação, Ala)
    (1, 3, 2, '2024-11-20', 'Atendido',  1),
    (2, 5, 3, '2024-11-20', 'Atendido', 2),
    (3, 1, 5, '2024-11-21','Em atendimento', 1),
    (4, 9, 7, '2024-11-21', 'Atendido', 5),
    (5, 4, 6, '2024-11-22', 'Atendido', 4),
    (6, 15, 3, '2024-11-22','Em atendimento', 2),
    (7, 2, 2, '2024-11-23','Em atendimento', 1),
    (8, 7, 5, '2024-11-23', 'Em atendimento',1),
    (9, 8, 1, '2024-11-24','Atendido', 3),
    (10, 13, 4, '2024-11-24','Em atendimento', 3),
    (11, 6, 2, '2024-11-25','Atendido', 1),
    (12, 10, 5, '2024-11-25','Em atendimento', 1),
    (13, 11, 9, '2024-11-26','Atendido', 4),
    (14, 12, 4, '2024-11-26','Em atendimento', 3),
    (15, 14, 10, '2024-11-27','Em atendimento', 5);

SELECT * FROM PACIENTES;

SELECT * FROM MEDICO;

SELECT * FROM ALA;

SELECT * FROM CONSULTA;

SELECT * FROM HOSPITAL;