-- Habilita o contexto do banco de dados MASTER
USE Master;
GO

-- Cria o banco de dados INTERCAMBIO, caso ele não exista
IF DB_ID(N'INTERCAMBIO') IS NULL
    CREATE DATABASE INTERCAMBIO;
GO

-- Habilita o contexto do banco de dados INTERCAMBIO
USE INTERCAMBIO;
GO

--------------------------------------------------------------------------------
-- Criação das tabelas
--------------------------------------------------------------------------------


-- Tabela PAISES (Código ISO3)
CREATE TABLE PAISES (
    CodPais CHAR(3) PRIMARY KEY,
    NomePais VARCHAR(255) NOT NULL,
    IdiomaPais VARCHAR(50) NULL
);
GO


-- Tabela VIAGENS
CREATE TABLE VIAGENS (
    CodViagem INT PRIMARY KEY,
    DataSaida DATE NOT NULL,
    DataRetorno DATE NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    PaisDestino CHAR(3) NOT NULL FOREIGN KEY REFERENCES PAISES(CodPais)
);
GO


-- Tabela ALUNOS
CREATE TABLE ALUNOS (
    CodAluno INT IDENTITY PRIMARY KEY,
    NomeAluno CHAR(20) NOT NULL,
    DataNasc DATE NOT NULL,
    Endereco VARCHAR(60) NOT NULL,
    Telefone CHAR(12) NOT NULL,
    Genero CHAR(1) NULL,
    PaisOrigem CHAR(3) NOT NULL FOREIGN KEY REFERENCES PAISES(CodPais),
    CodViagem INT NOT NULL FOREIGN KEY REFERENCES VIAGENS(CodViagem)
);
GO


-- Tabela AlunosCOPIA
-- Essa tabela será utilizada apenas para demonstrar os operadores do conjunto relacional
CREATE TABLE AlunosCOPIA (
    CodAluno INT IDENTITY PRIMARY KEY,
    NomeAluno CHAR(20) NOT NULL,
    DataNasc DATE NOT NULL,
    Endereco VARCHAR(60) NOT NULL,
    Telefone CHAR(12) NOT NULL,
    Genero CHAR(1),
    PaisOrigem CHAR(3) NOT NULL FOREIGN KEY REFERENCES PAISES(CodPais),
    CodViagem INT NOT NULL FOREIGN KEY REFERENCES VIAGENS(CodViagem)
);
GO


-- Exibe o nome das tabelas que existem no banco de dados em uso
SELECT name 
FROM sys.tables;
GO


-- Exibe o nome das tabelas que existem no banco de dados em uso
SELECT TABLE_NAME AS 'Nome da Tabela'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND 
      TABLE_CATALOG = 'INTERCAMBIO';
GO


--------------------------------------------------------------------------------
-- Inserção dos dados
--------------------------------------------------------------------------------


-- Insere 244 registros na tabela PAISES
INSERT INTO PAISES VALUES 
    ('AFG', 'Afeganistão', 'Dari e Pashtu'),
    ('ZAF', 'África do Sul', 'Inglês'),
    ('ALA', 'Aland, Ilhas', 'Sueco'),
    ('ALB', 'Albânia', 'Albanês'),
    ('DEU', 'Alemanha', 'Alemão'),
    ('AND', 'Andorra', 'Catalão'),
    ('AGO', 'Angola', 'Português'),
    ('AIA', 'Anguilla', 'Inglês'),
    ('ATA', 'Antártida', NULL),
    ('ATG', 'Antigua e Barbuda', 'Inglês'),
    ('ANT', 'Antilhas Holandesas', 'Papiamento, Neerlandês e Inglês'),
    ('SAU', 'Arábia Saudita', 'Árabe'),
    ('DZA', 'Argélia', 'Árabe'),
    ('ARG', 'Argentina', 'Espanhol'),
    ('ARM', 'Armênia', 'Armênio'),
    ('ABW', 'Aruba', 'Neerlandês e Papiamento'),
    ('AUS', 'Austrália', 'Inglês'),
    ('AUT', 'Áustria', 'Alemão'),
    ('AZE', 'Azerbeijão', 'Azeri'),
    ('BHS', 'Bahamas', 'Inglês'),
    ('BHR', 'Bahrein', 'Árabe e Inglês'),
    ('BGD', 'Bangladesh', 'Bengali'),
    ('BRB', 'Barbados', 'Inglês'),
    ('BEL', 'Bélgica', 'Neerlandês, Francês e Alemão'),
    ('BLZ', 'Belize', 'Inglês'),
    ('BEN', 'Benin', 'Francês'),
    ('BMU', 'Bermudas', 'Inglês'),
    ('BLR', 'Bielo-Rússia', 'Russo'),
    ('BOL', 'Bolívia', 'Espanhol'),
    ('BIH', 'Bósnia-Herzegovina', 'Bósnio, Croata e Sérvio'),
    ('BWA', 'Botswana', 'Inglês'),
    ('BVT', 'Bouvet, Ilha', NULL),
    ('BRA', 'Brasil', 'Português'),
    ('BRN', 'Brunei', 'Malaio'),
    ('BGR', 'Bulgária', 'Búlgaro'),
    ('BFA', 'Burkina Faso', 'Francês'),
    ('BDI', 'Burundi', 'Francês'),
    ('BTN', 'Butão', 'Dzonka'),
    ('CPV', 'Cabo Verde', 'Português'),
    ('KHM', 'Cambodja', 'Khmer'),
    ('CMR', 'Camarões', 'Inglês e Francês'),
    ('CAN', 'Canadá', 'Inglês e Francês'),
    ('CYM', 'Cayman, Ilhas', 'Inglês'),
    ('KAZ', 'Cazaquistão', 'Russo'),
    ('CAF', 'Centro-africana, República', 'Francês e Sangho'),
    ('TCD', 'Chade', 'Francês'),
    ('CZE', 'Checa, República', 'Tcheco'),
    ('CHL', 'Chile', 'Espanhol'),
    ('CHN', 'China', 'Chinês'),
    ('CYP', 'Chipre', 'Grego'),
    ('CXR', 'Christmas, Ilha', 'Inglês, Chinês e Malaio'),
    ('CCK', 'Cocos, Ilhas', 'Inglês'),
    ('COL', 'Colômbia', 'Espanhol'),
    ('COM', 'Comores', 'Árabe'),
    ('COG', 'Congo, República do', 'Francês'),
    ('COD', 'Congo, República Democrática do (antigo Zaire),', 'Francês'),
    ('COK', 'Cook, Ilhas', 'Inglês e Maori'),
    ('KOR', 'Coréia do Sul', 'Coreano'),
    ('PRK', 'Coréia, República Democrática da (Coréia do Norte),', 'Coreano'),
    ('CIV', 'Costa do Marfim', 'Francês'),
    ('CRI', 'Costa Rica', 'Espanhol'),
    ('HRV', 'Croácia', 'Croata'),
    ('CUB', 'Cuba', 'Castelhano ou Espanhol'),
    ('DNK', 'Dinamarca', 'Dinamarquês'),
    ('DJI', 'Djibouti', 'Francês'),
    ('DMA', 'Dominica', 'Inglês'),
    ('DOM', 'Dominicana, República', 'Espanhol'),
    ('EGY', 'Egito', 'Árabe'),
    ('SLV', 'El Salvador', 'Espanhol'),
    ('ARE', 'Emirados Árabes Unidos', 'Árabe'),
    ('ECU', 'Equador', 'Espanhol'),
    ('ERI', 'Eritreia', 'Amárico'),
    ('SVK', 'Eslováquia', 'Eslovaco'),
    ('SVN', 'Eslovênia', 'Esloveno'),
    ('ESP', 'Espanha', 'Castelhano ou Espanhol'),
    ('USA', 'Estados Unidos da América', 'Inglês'),
    ('EST', 'Estônia', 'Estônio'),
    ('ETH', 'Etiópia', 'Amárico'),
    ('FRO', 'Faroe, Ilhas', 'Feroês e Dinamarquês'),
    ('FJI', 'Fiji', 'Inglês'),
    ('PHL', 'Filipinas', 'Inglês'),
    ('FIN', 'Finlândia', 'Finlandês'),
    ('FRA', 'França', 'Francês'),
    ('GAB', 'Gabão', 'Francês'),
    ('GMB', 'Gâmbia', 'Inglês'),
    ('GHA', 'Gana', 'Inglês'),
    ('GEO', 'Geórgia', 'Georgiano'),
    ('SGS', 'Geórgia do Sul e Sandwich do Sul, Ilhas', 'Inglês'),
    ('GIB', 'Gibraltar', 'Inglês'),
    ('GRC', 'Grécia', 'Grego'),
    ('GRD', 'Granada', 'Inglês'),
    ('GRL', 'Groenlândia', 'Groenlandês'),
    ('GLP', 'Guadalupe', 'Francês'),
    ('GUM', 'Guam', 'Inglês e Chamorro'),
    ('GTM', 'Guatemala', 'Espanhol'),
    ('GGY', 'Guernsey', 'Inglês e Francês'),
    ('GUY', 'Guiana', 'Inglês'),
    ('GUF', 'Guiana Francesa', 'Francês'),
    ('GNB', 'Guiné-Bissau', 'Português'),
    ('GIN', 'Guiné-Conacri', 'Francês'),
    ('GNQ', 'Guiné Equatorial', 'Espanhol'),
    ('HTI', 'Haiti', 'Francês e Crioulo'),
    ('HMD', 'Heard e McDonald, Ilhas', NULL),
    ('HND', 'Honduras', 'Espanhol'),
    ('HKG', 'Hong Kong', 'Chinês e Inglês'),
    ('HUN', 'Hungria', 'Húngaro'),
    ('YEM', 'Iêmen', 'Árabe'),
    ('IND', 'Índia', 'Inglês e Hindi'),
    ('IDN', 'Indonésia', 'Bahasa'),
    ('IRQ', 'Iraque', 'Árabe'),
    ('IRN', 'Irã', 'Persa'),
    ('IRL', 'Irlanda', 'Inglês'),
    ('ISL', 'Islândia', 'Inglês'),
    ('ISR', 'Israel', 'Hebraico'),
    ('ITA', 'Itália', 'Italiano'),
    ('JAM', 'Jamaica', 'Inglês'),
    ('JPN', 'Japão', 'Japonês'),
    ('JEY', 'Jérsei', 'Inglê, Francês e Jérriais'),
    ('JOR', 'Jordânia', 'Árabe'),
    ('KIR', 'Kiribati', 'Inglês'),
    ('KWT', 'Kuwait', 'Árabe'),
    ('LAO', 'Laos', 'Lao'),
    ('LSO', 'Lesoto', 'Inglês'),
    ('LVA', 'Letônia', 'Letão'),
    ('LBN', 'Líbano', 'Árabe'),
    ('LBR', 'Libéria', 'Inglês'),
    ('LBY', 'Líbia', 'Árabe'),
    ('LIE', 'Liechtenstein', 'Alemão'),
    ('LTU', 'Lituânia', 'Lituano'),
    ('LUX', 'Luxemburgo', 'Francês'),
    ('MAC', 'Macau', 'Chinês e Português'),
    ('MKD', 'Macedônia, República da', 'Macedónio'),
    ('MDG', 'Madagascar', 'Francês e Malgaxe'),
    ('MYS', 'Malásia', 'Malaio'),
    ('MWI', 'Malawi', 'Inglês'),
    ('MDV', 'Maldivas', 'Divehi'),
    ('MLI', 'Mali', 'Francês'),
    ('MLT', 'Malta', 'Inglês'),
    ('FLK', 'Malvinas, Ilhas', 'Inglês'),
    ('IMN', 'Man, Ilha de', 'Inglês e Manx'),
    ('MNP', 'Marianas Setentrionais', 'Inglês, Chamorro, Carolínio e Japonês'),
    ('MAR', 'Marrocos', 'Árabe'),
    ('MHL', 'Marshall, Ilhas', 'Inglês'),
    ('MTQ', 'Martinica', 'Francês'),
    ('MUS', 'Maurícia', 'Inglês'),
    ('MRT', 'Mauritânia', 'Árabe'),
    ('MYT', 'Maiote', 'Francês'),
    ('UMI', 'Menores Distantes dos Estados Unidos, Ilhas', NULL),
    ('MEX', 'México', 'Espanhol ou Castelhano'),
    ('MMR', 'Myanmar (antiga Birmânia),', 'Birmanês'),
    ('FSM', 'Micronésia, Estados Federados da', 'Inglês'),
    ('MOZ', 'Moçambique', 'Português'),
    ('MDA', 'Moldávia', 'Moldavo'),
    ('MCO', 'Mônaco', 'Francês'),
    ('MNG', 'Mongólia', 'Mongol'),
    ('MNE', 'Montenegro', 'Sérvio'),
    ('MSR', 'Montserrat', 'Inglês'),
    ('NAM', 'Namíbia', 'Inglês'),
    ('NRU', 'Nauru', 'Nauruano'),
    ('NPL', 'Nepal', 'Nepalês'),
    ('NIC', 'Nicarágua', 'Espanhol'),
    ('NER', 'Níger', 'Francês'),
    ('NGA', 'Nigéria', 'Inglês'),
    ('NIU', 'Niue', '    Niueano e Inglês'),
    ('NFK', 'Norfolk, Ilha', 'Inglês e Norfuk'),
    ('NOR', 'Noruega', 'Norueguês'),
    ('NCL', 'Nova Caledônia', 'Francês'),
    ('NZL', 'Nova Zelândia', 'Inglês'),
    ('OMN', 'Omã', 'Árabe'),
    ('NLD', 'Países Baixos (Holanda),', 'Neerlandês'),
    ('PLW', 'Palau', 'Inglês'),
    ('PSE', 'Palestina', NULL),
    ('PAN', 'Panamá', 'Espanhol'),
    ('PNG', 'Papua-Nova Guiné', 'Inglês'),
    ('PAK', 'Paquistão', 'Pumjabi'),
    ('PRY', 'Paraguai', 'Espanhol'),
    ('PER', 'Peru', 'Espanhol'),
    ('PCN', 'Pitcairn, Ilhas', 'Inglês'),
    ('PYF', 'Polinésia Francesa', 'Francês'),
    ('POL', 'Polônia', 'Polonês'),
    ('PRI', 'Porto Rico', 'Inglês'),
    ('PRT', 'Portugal', 'Português'),
    ('QAT', 'Qatar', 'Árabe'),
    ('KEN', 'Quênia', 'Quisvaili'),
    ('KGZ', 'Quirguistão', 'Quirguiz'),
    ('GBR', 'Reino Unido da Grã-Bretanha e Irlanda do Norte', 'Inglês'),
    ('REU', 'Reunião, Ilhas', 'Francês e Crioulo'),
    ('ROU', 'Romênia', 'Romeno'),
    ('RWA', 'Ruanda', 'Francês'),
    ('RUS', 'Rússia', 'Russo'),
    ('ESH', 'Saara Ocidental', 'Árabe e Espanhol'),
    ('ASM', 'Samoa Americana', 'Inglês'),
    ('WSM', 'Samoa (Samoa Ocidental),', 'Inglês e Samoano'),
    ('SPM', 'São Pedro e Miquelão', 'Francês'),
    ('SLB', 'Salomão, Ilhas', 'Inglês'),
    ('KNA', 'São Cristóvão e Névis', 'Inglês'),
    ('SMR', 'San Marino', 'Italiano'),
    ('STP', 'São Tomé e Príncipe', 'Português'),
    ('VCT', 'São Vicente e Granadinas', 'Inglês'),
    ('SHN', 'Santa Helena', 'Inglês'),
    ('LCA', 'Santa Lúcia', 'Inglês e Francês'),
    ('SEN', 'Senegal', 'Francês'),
    ('SLE', 'Serra Leoa', 'Inglês'),
    ('SRB', 'Sérvia', 'Sérvio'),
    ('SYC', 'Seichelles', 'Inglês'),
    ('SGP', 'Cingapura', 'Inglês'),
    ('SYR', 'Síria', 'Árabe'),
    ('SOM', 'Somália', 'Somali'),
    ('LKA', 'Sri Lanka', 'Inglês'),
    ('SWZ', 'Suazilândia', 'Inglês'),
    ('SDN', 'Sudão', 'Árabe'),
    ('SWE', 'Suécia', 'Sueco'),
    ('CHE', 'Suíça', 'Alemão e Francês'),
    ('SUR', 'Suriname', 'Holandês'),
    ('SJM', 'Svalbard e Jan Mayen', NULL),
    ('THA', 'Tailândia', 'Tai'),
    ('TWN', 'Taiwan', 'Mandarim'),
    ('TJK', 'Tadjiquistão', 'Tadjique'),
    ('TZA', 'Tanzânia', 'Inglês'),
    ('ATF', 'Terras Austrais e Antárticas Francesas (TAAF),', 'Francês'),
    ('IOT', 'Território Britânico do Oceano Índico', 'Inglês'),
    ('TLS', 'Timor-Leste', 'Português'),
    ('TGO', 'Togo', 'Francês'),
    ('TKL', 'Toquelau', 'Toquelauano e Inglês'),
    ('TON', 'Tonga', 'Inglês'),
    ('TTO', 'Trinidad e Tobago', 'Inglês'),
    ('TUN', 'Tunísia', 'Árabe'),
    ('TCA', 'Turcos e Caicos, Ilhas', 'Inglês'),
    ('TKM', 'Turcomenistão', 'Turcomano'),
    ('TUR', 'Turquia', 'Turco'),
    ('TUV', 'Tuvalu', 'Inglês'),
    ('UKR', 'Ucrânia', 'Ucraniano'),
    ('UGA', 'Uganda', 'Inglês'),
    ('URY', 'Uruguai', 'Espanhol'),
    ('UZB', 'Uzbequistão', 'Uzbequi'),
    ('VUT', 'Vanuatu', 'Francês e Inglês'),
    ('VAT', 'Vaticano', 'Italiano e Latim'),
    ('VEN', 'Venezuela', 'Espanhol'),
    ('VNM', 'Vietnã', 'Vietnamita'),
    ('VIR', 'Virgens Americanas, Ilhas', 'Inglês'),
    ('VGB', 'Virgens Britânicas, Ilhas', 'Inglês'),
    ('WLF', 'Wallis e Futuna, Ilhas', 'Francês e Wallisiano'),
    ('ZMB', 'Zâmbia', 'Inglês'),
    ('ZWE', 'Zimbabwe', 'Inglês');
GO


-- Mostra os valores inseridos na tabela PAISES
SELECT CodPais    AS 'Código do País',
       NomePais   AS 'Nome',
       IdiomaPais AS 'Idioma Principal'
FROM PAISES;
GO


-- Insere 30 registros na tabela VIAGENS
INSERT INTO VIAGENS VALUES 
    (001, '2010-10-12', '2010-12-12', 5350.00, 'VGB'),
    (002, '2010-09-14', '2010-12-22', 8900.00, 'VNM'),
    (003, '2010-12-05', '2011-12-05', 18525.35, 'UKR'),
    (004, '2010-08-11', '2011-05-21', 12350.25, 'TUR'),
    (005, '2010-06-25', '2010-08-25', 7520.00, 'TKL'),
    (006, '2010-03-16', '2011-03-16', 14255.35, 'USA'),
    (007, '2010-12-01', '2010-12-30', 3250.00, 'TLS'),
    (008, '2010-10-12', '2010-12-30', 9500.00, 'THA'),
    (009, '2010-06-21', '2010-09-05', 9250.00, 'RUS'),
    (010, '2010-09-10', '2010-10-02', 6525.00, 'SEN'),
    (011, '2010-07-27', '2011-11-15', 12355.00, 'QAT'),
    (012, '2010-09-04', '2011-10-02', 14200.00, 'CHE'),
    (013, '2010-08-02', '2012-05-02', 16100.00, 'SYR'),
    (014, '2010-06-04', '2011-10-22', 15300.00, 'NZL'),
    (015, '2010-11-04', '2010-12-30', 6250.50, 'MRT'),
    (016, '2010-11-05', '2012-11-05', 22850.25, 'USA'),
    (017, '2010-12-02', '2012-12-30', 18600.10, 'MEX'),
    (018, '2010-11-10', '2012-03-02', 19000.50, 'DNK'),
    (019, '2010-11-11', '2010-12-20', 8200.00, 'GTM'),
    (020, '2010-08-19', '2010-10-20', 7500.00, 'COG'),
    (021, '2010-07-19', '2010-11-19', 8900.50, 'FRA'),
    (022, '2011-01-05', '2012-01-05', 15650.25, 'MEX'),
    (023, '2011-01-08', '2012-01-08', 11850.95, 'USA'),
    (024, '2011-01-10', '2012-01-10', 15850.95, 'USA'),
    (025, '2010-08-02', '2011-08-02', 16550.20, 'USA'),
    (026, '2010-09-05', '2011-03-20', 14750.25, 'USA'),
    (027, '2011-03-15', '2012-04-20', 13560.65, 'THA'),
    (028, '2010-08-15', '2012-10-20', 19500.80, 'USA'),
    (029, '2011-01-01', '2011-12-01', 12520.25, 'USA'),
    (030, '2011-02-20', '2012-02-20', 11950.65, 'IND');
GO


-- Mostra os valores inseridos na tabela VIAGENS
SELECT * FROM VIAGENS;
GO


-- Insere 50 registros na tabela ALUNOS
INSERT INTO ALUNOS VALUES 
    ('Maria Cristina', '1985-10-12', 'Rua João XXIII, 15 - São Paulo', '1155686899', 'F', 'BRA', 001),
    ('Ana Paula Lima', '1980-12-01', 'Rua Mauro Silva, 1908 - São Paulo', '1156923232', 'F', 'BRA', 002),
    ('Carlos Renato', '1979-05-10', 'Av. Faria Lima, 347 - São Paulo', '1156121010', 'M', 'BRA', 003),
    ('Hugo Silva', '1975-10-02', 'Av. da Consolação, 1216 - São Paulo', '1154788901', 'M', 'BRA', 004),
    ('Marcos Antônio', '1985-10-23', 'Rua Agripino Lopes, 100 - São Paulo', '1156010201', 'M', 'BRA', 005),
    ('Gislaine Silva', '1983-11-06', 'Av. Nelson Dávila, 2345 - São José dos Campos', '1234598910', 'F', 'BRA', 006),
    ('Antônio Pereira', '1979-06-18', 'Rua Joaquim Nabuco, 18 - Jacareí', '1234966852', 'M', 'BRA', 007),
    ('Jair Lopes', '1982-12-14', 'Rua Pedro XIII, Santa Isabel', '1236691857', 'M', 'BRA', 008),
    ('Miguel Firmino', '1982-05-12', 'Av. Colinas, 2340 - São José dos Campos', '1234581212', 'M', 'BRA', 009),
    ('Marta da Silva', '1982-06-15', 'Rua Alfredo Miragaia, 321 - Taubaté', '1234568989', 'F', 'BRA', 010),
    ('Jorge Augusto', '1985-06-19', 'Rua Califórnia, 3451 - São Paulo', '1158988810', 'M', 'BRA', 011),
    ('Renato César', '1981-10-22', 'Rua Cafezal, 10 - Cafezal do Sul', '4488562323', 'M', 'BRA', 012),
    ('Júlio Antunes', '1981-11-23', 'Rua do Descanso, 99 - Camaçari', '7196521010', 'M', 'BRA', 013),
    ('Márcio Gomes', '1986-11-24', 'Rua Miguel Pereira, 15 - São Paulo', '1156451212', 'M', 'BRA', 014),
    ('Carlos Pereira', '1986-12-24', 'Rua Maria Augusta, 290 - São Paulo', '1158457525', 'M', 'BRA', 015),
    ('Carlos Barreto', '1986-02-21', 'Rua Augusta, 90 - São Paulo', '1156322558', 'M', 'BRA', 016),
    ('Simone Gomes', '1985-02-20', 'Rua A, 18 - Campos do Jordão', '1296895959', 'F', 'BRA', 017),
    ('José Aurélio', '1987-03-26', 'Rua Canarinho, 789 - São Paulo', '1186574512', 'M', 'BRA', 018),
    ('Juliana Marcondes', '1988-07-27', 'Av. da Consolação, 3450 - São Paulo', '1155125566', 'F', 'BRA', 019),
    ('Jezebel Lima', '1983-07-29', 'Av. Califórnia, 2553 - São Paulo', '1154332332', 'F', 'BRA', 020),
    ('Geisa Lima', '1982-09-29', 'Rua Constantino Pereira, 130 - São Paulo', '1155847889', 'F', 'BRA', 020),
    ('Ana Mara da Silva', '1985-10-30', 'Av. Costa e Silva, 109 - Cruzeiro', '1236658956', 'F', 'BRA', 015),
    ('Pedro Costa', '1985-12-30', 'Av. Francisco Teixeira, 1218 - Campos do Jordão', '1236631225', 'M', 'BRA', 005),
    ('Miriam Pereira', '1986-01-30', 'Av. Matheus da Costa Pinto, 1801 - Campos do Jordão', '1236621515', 'F', 'BRA', 002),
    ('Marcos Manuel', '1977-01-12', 'Rua Anísio Teixeira, 555 - Campos do Jordão', '1236621859', 'M', 'BRA', 001),
    ('Jairo Pereira', '1977-03-13', 'Rua Pedro Augusto, 318 - Cruzeiro', '1236661518', 'M', 'BRA', 001),
    ('Cristina Rocha', '1979-08-14', 'Av. Nelson Lima, 347 - São Paulo', '1153212102', 'F', 'BRA', 009),
    ('Ágatha Silva', '1975-08-15', 'Av. Faria Lima, 448 - São Paulo', '1156020303', 'F', 'BRA', 015),
    ('Mariana Lopes', '1975-09-18', 'Rua Califórnia, 1009 - São Paulo', '1154121111', 'F', 'BRA', 015),
    ('César Augusto', '1975-10-19', 'Rua Augusta, 235 - São Paulo', '1154189898', 'M', 'BRA', 019),
    ('Melissa Pereira', '1975-10-21', 'Rua Américo Vespúcio, 56 - São Paulo', '1156887110', 'F', 'BRA', 012),
    ('Jéssica Patrícia', '1985-10-12', 'Rua Brigadeiro Jordão, 199 - Campos do Jordão', '1236625307', 'F', 'BRA', 011),
    ('Patrícia Silva', '1982-11-12', 'Rua Periquito, 24 - Campos do Jordão', '1236620181', 'F', 'BRA', 011),
    ('Maria Duarte', '1982-12-10', 'Rua F, 341 - Campos do Jordão', '1236631118', 'F', 'BRA', 011),
    ('Marcelo Augusto', '1984-09-22', 'Av. Frei Orestes Girardi, 899 - Campos do Jordão', '1236635696', 'M', 'BRA', 013),
    ('Cristiano Leite', '1984-08-25', 'Rua Gumercindo Lopes, 566 - São Paulo', '1158871771', 'M', 'BRA', 016),
    ('Alberto Carlos', '1983-07-26', 'Av. Jorge Aparecido, 641 - Rio de Janeiro', '2124565353', 'M', 'BRA', 018),
    ('Jaime Augusto', '1983-05-15', 'Rua São Leopoldo, 11 - Rio de Janeiro', '2125896060', 'M', 'BRA', 003),
    ('Leandro Leite', '1982-06-15', 'Av. do Povo, 3489 - Rio de Janeiro', '2156894510', 'M', 'BRA', 009),
    ('Mônica Silva', '1978-04-17', 'Rua Americana, 5200 - Rio de Janeiro', '2189562121', 'F', 'BRA', 009),
    ('Marília dos Santos', '1984-04-15', '', '2134588585', 'F', 'BRA', 004),
    ('Guilherme dos Santos', '1978-10-11', 'Av. Brasil, 1008 - São Paulo', '1155661010', 'M', 'BRA', 001),
    ('Heidi Lima', '1978-08-11', 'Rua César Conceição, 12 - Santo Antônio do Pinhal', '1236645605', 'F', 'BRA', 002),
    ('Amílcar Júnior', '1976-04-10', 'Rua Senador Kennedy, 901 - São Paulo', '1155640290', 'M', 'BRA', 008),
    ('Alexandro Duarte', '1974-05-29', 'Rua Maria Cíntia - Cruzeiro', '1236661515', 'M', 'BRA', 011),
    ('Maurício dos Santos', '1988-04-13', 'Rua Marta Silva - Jacareí', '1236665650', 'M', 'BRA', 016),
    ('Mary Ann Duarte', '1989-04-13', 'Av. Brasil, 6320 - São Paulo', '1158854516', 'F', 'BRA', 017),
    ('Gabriela Pereira', '1983-07-29', 'Rua Franco Silva, 1599 - São Paulo', '1159404014', 'F', 'BRA', 018),
    ('André César', '1984-12-30', 'Rua Militar, 349 - Rio de Janeiro', '2128002525', 'M', 'BRA', 014),
    ('Edson Lopes', '1979-01-11', 'Av. Pedro Silva, 3047 - Rio de Janeiro', '2126900099', 'M', 'BRA', 014);
GO


-- Mostra os valores inseridos na tabela ALUNOS, exceto a data de nascimento e o telefone
SELECT CodAluno   AS 'Código',
       NomeAluno  AS 'Nome do Aluno',
       Endereco   AS 'Endereço',
       Genero     AS 'Gênero',
       PaisOrigem AS 'Origem',
       CodViagem  AS 'Código da Viagem'
FROM ALUNOS;
GO


-- Insere 20 registros na tabela ALUNOSCOPIA
INSERT INTO AlunosCOPIA VALUES 
    ('Maria Cristina', '1985-10-12', 'Rua João XXIII, 15 - São Paulo', '1155686899', 'F', 'BRA', 001),
    ('Ana Paula Lima', '1980-12-01', 'Rua Mauro Silva, 1908 - São Paulo', '1156923232', 'F', 'BRA', 002),
    ('Felipe Neto', '1975-11-23', 'Rua da Preguiça, 70 - São Paulo', '8996521919', 'M', 'BRA', 015),
    ('Carlos Eduardo', '1966-11-24', 'Rua Miguel Pereira, 150 - São Paulo', '1156651210', 'M', 'BRA', 015),
    ('Carlos Pereira', '1986-12-24', 'Rua Maria Augusta, 290 - São Paulo', '1158457525', 'M', 'BRA', 015),
    ('Cristiano Leite', '1984-08-25', 'Rua Gumercindo Lopes, 566 - São Paulo', '1158871771', 'M', 'BRA', 016),
    ('Alberto Carlos', '1983-07-26', 'Av. Jorge Aparecido, 641 - Rio de Janeiro', '2124565353', 'M', 'BRA', 018),
    ('Maria Rita', '1993-05-15', 'Av. Marcos Lima, 110 - Florianópolis', '4825906066', 'F', 'BRA', 003),
    ('Leandro Leite', '1982-06-15', 'Av. do Povo, 3489 - Rio de Janeiro', '2156894510', 'M', 'BRA', 009),
    ('Mônica Silva', '1978-04-17', 'Rua Americana, 5200 - Rio de Janeiro', '2189562121', 'F', 'BRA', 009),
    ('Emerson Soares', '1994-04-15', '', '4834588585', 'M', 'BRA', 018),
    ('Melissa Lima', '1988-10-11', 'Rua da Cegonha, 124 - São Paulo', '1155661010', 'F', 'BRA', 001),
    ('Jéssica Santos', '1968-08-20', 'Rua do Periquito, 99 - Florianópolis', '4846685615', 'F', 'BRA', 015),
    ('Edson Renato', '1966-04-10', 'Rua da Gaivota, 1501 - São Paulo', '1155640290', 'M', 'BRA', 011),
    ('Alex Silva', '1984-05-29', 'Rua do Xarope - Cruzeiro', '1236661515', 'M', 'BRA', 012),
    ('Maurício dos Santos', '1988-04-13', 'Rua Marta Silva - Jacareí', '1236665650', 'M', 'BRA', 016),
    ('Avelino Júnior', '1985-04-13', 'Rua da Relíquia, 24 - Tremembé', '1258854516', 'M', 'BRA', 017),
    ('Gabriela Pereira', '1983-07-29', 'Rua Franco Silva, 1599 - São Paulo', '1159404014', 'F', 'BRA', 018),
    ('André César', '1984-12-30', 'Rua Militar, 349 - Rio de Janeiro', '2128002525', 'M', 'BRA', 014),
    ('Edson Lopes', '1979-01-11', 'Av. Pedro Silva, 3047 - Rio de Janeiro', '2126900099', 'M', 'BRA', 014);
GO


-- Mostra os valores inseridos na tabela AlunosCOPIA, exceto a data de nascimento e o telefone
SELECT CodAluno   AS 'Código',
       NomeAluno  AS 'Nome do Aluno',
       Endereco   AS 'Endereço',
       Genero     AS 'Gênero',
       PaisOrigem AS 'Origem',
       CodViagem  AS 'Código da Viagem'
FROM AlunosCOPIA;
GO


--------------------------------------------------------------------------------
-- FIM!
--------------------------------------------------------------------------------