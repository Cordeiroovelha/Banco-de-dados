/* Lógico_1: */

CREATE TABLE AUTORES (
    CodAutor Inteiro PRIMARY KEY,
    Nome Char(50),
    Endereco char(200),
    Telefone Inteiro,
    Email char(200)
)

CREATE TABLE LIVRO (
    CodLivro Inteiro PRIMARY KEY,
    Titulo Char(50),
    Ano Char(50)
)

CREATE TABLE EDITORAS (
    CodEditoras Inteiro PRIMARY KEY,
    Endereco char(200),
    Site char(200),
    Nome Char(50)
)

CREATE TABLE ESCREVE (
    FK_LIVRO_CodLivro Inteiro,
    FK_AUTORES_CodAutor Inteiro
)

CREATE TABLE PUBLICA (
    FK_LIVRO_CodLivro Inteiro,
    FK_EDITORAS_CodEditoras Inteiro
)
 
ALTER TABLE ESCREVE ADD CONSTRAINT FK_ESCREVE_1
    FOREIGN KEY (FK_LIVRO_CodLivro)
    REFERENCES LIVRO (CodLivro)
    ON DELETE SET NULL
 
ALTER TABLE ESCREVE ADD CONSTRAINT FK_ESCREVE_2
    FOREIGN KEY (FK_AUTORES_CodAutor)
    REFERENCES AUTORES (CodAutor)
    ON DELETE SET NULL
 
ALTER TABLE PUBLICA ADD CONSTRAINT FK_PUBLICA_1
    FOREIGN KEY (FK_LIVRO_CodLivro)
    REFERENCES LIVRO (CodLivro)
    ON DELETE SET NULL
 
ALTER TABLE PUBLICA ADD CONSTRAINT FK_PUBLICA_2
    FOREIGN KEY (FK_EDITORAS_CodEditoras)
    REFERENCES EDITORAS (CodEditoras)
    ON DELETE SET NULL