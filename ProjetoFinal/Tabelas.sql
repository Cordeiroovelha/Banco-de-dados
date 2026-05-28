-- Projeto final Banco de dados 2 --
-- Autoria de Murilo Juttel Cordeiro --

CREATE TABLE PACIENTES(
	ID INT PRIMARY KEY,
	Nome		  VARCHAR(50),
	Idade		  INT,
	TipoSanguinio CHAR(3),
	Prioridade    INT,
	Descricao	  VARCHAR(250)
);

CREATE TABLE MEDICO(
    ID INT PRIMARY KEY,
    Nome           VARCHAR(50),
    Consultorio    INT,
    Especialidade  VARCHAR(50)
);

CREATE TABLE CONSULTA(
    ID INT PRIMARY KEY,
    ID_Paciente INT,
    ID_Medico   INT,
    Data        DATE,
    Procedimento VARCHAR(250),
    FOREIGN KEY (ID_Paciente) REFERENCES PACIENTES(ID),
    FOREIGN KEY (ID_Medico) REFERENCES MEDICO(ID)    
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

INSERT INTO PACIENTES VALUES
    (1, 'Jose da Silva',    45, 'O-',  2, 'Dor de cabeça'),
    (2, 'Maria Oliveira',   32, 'A+',  1, 'Febre alta e tosse'),
    (3, 'Carlos Santos',    58, 'B+',  3, 'Dor no peito'),
    (4, 'Ana Paula Costa',  27, 'O+',  2, 'Fratura no braço direito'),
    (5, 'Roberto Lima',     63, 'AB-', 4, 'Dificuldade respiratória'),
    (6, 'Fernanda Souza',   41, 'A-',  2, 'Enxaqueca severa'),
    (7, 'Paulo Henrique',   35, 'O-',  1, 'Corte profundo na mão'),
    (8, 'Juliana Mendes',   29, 'B-',  3, 'Dor abdominal intensa'),
    (9, 'Marcos Vinicius',  72, 'A+',  4, 'Pressão alta e tontura'),
    (10, 'Patrícia Gomes',  38, 'O+',  2, 'Infecção na garganta'),
    (11, 'Ricardo Alves',   50, 'AB+', 3, 'Dores nas costas'),
    (12, 'Camila Rocha',    26, 'A+',  1, 'Alergia medicamentosa'),
    (13, 'Eduardo Campos',  47, 'O-',  2, 'Bronquite aguda'),
    (14, 'Tatiana Martins', 33, 'B+',  3, 'Enjoo e vômito'),
    (15, 'André Luiz',      55, 'A-',  4, 'Suspeita de infarto');