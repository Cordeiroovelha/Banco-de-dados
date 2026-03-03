/* Logico_Fatura */

CREATE TABLE CLIENTES (
    Cod_cliente DOUBLE PRIMARY KEY,
    Sobrenome CHAR(50),
    Nome CHAR(50),
    Inicial CHAR,
    DDD DOUBLE,
    Telefone DOUBLE,
    Saldo FLOAT
);

CREATE TABLE FATURAS (
    Num_Fatura DOUBLE PRIMARY KEY,
    Data_Fatura CHAR(50),
    FK_CLIENTES_Cod_cliente DOUBLE
);

CREATE TABLE LINHAS (
    Num_Linhas DOUBLE PRIMARY KEY,
    Unidades INT,
    Valor DOUBLE,
    FK_FATURAS_Num_Fatura DOUBLE
);

CREATE TABLE PRODUTOS (
    Descricao CHAR(200),
    Data_Compra DOUBLE,
    Valor FLOAT,
    Desconto CHAR(200),
    Quantidade DOUBLE,
    Cod_Produto DOUBLE PRIMARY KEY,
    fk_FORNECEDORES_Cod_Fornecedor DOUBLE
);

CREATE TABLE FORNECEDORES (
    Cod_Fornecedor DOUBLE PRIMARY KEY,
    Nome CHAR(50),
    Contato CHAR(50),
    DDD INT,
    Telefone DOUBLE,
    Estado CHAR(100),
    Cidade CHAR(100)
);

CREATE TABLE encontra_se_em (
    fk_LINHAS_Num_Linhas DOUBLE,
    fk_Entidade_4_Cod_Produto DOUBLE
);
 
ALTER TABLE FATURAS ADD CONSTRAINT FK_FATURAS_2
    FOREIGN KEY (FK_CLIENTES_Cod_cliente)
    REFERENCES CLIENTES (Cod_cliente)
    ON DELETE CASCADE;
 
ALTER TABLE LINHAS ADD CONSTRAINT FK_LINHAS_2
    FOREIGN KEY (FK_FATURAS_Num_Fatura)
    REFERENCES FATURAS (Num_Fatura)
    ON DELETE RESTRICT;
 
ALTER TABLE PRODUTOS ADD CONSTRAINT FK_PRODUTOS_2
    FOREIGN KEY (fk_FORNECEDORES_Cod_Fornecedor)
    REFERENCES FORNECEDORES (Cod_Fornecedor)
    ON DELETE CASCADE;
 
ALTER TABLE encontra_se_em ADD CONSTRAINT FK_encontra_se_em_1
    FOREIGN KEY (fk_LINHAS_Num_Linhas)
    REFERENCES LINHAS (Num_Linhas)
    ON DELETE SET NULL;
 
ALTER TABLE encontra_se_em ADD CONSTRAINT FK_encontra_se_em_2
    FOREIGN KEY (fk_Entidade_4_Cod_Produto)
    REFERENCES PRODUTOS (Cod_Produto)

    ON DELETE SET NULL;
