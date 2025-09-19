rollback;
--USE... SQLINES DEMO ***
--GO
--DRO... SQLINES DEMO ***
--GO
--CRE... SQLINES DEMO ***
--GO
-- DB... SQLINES DEMO ***


alter database kaironst set DateStyle to 'ISO, DMY';

drop table if exists tb010_clientes_antigos ;

drop table if exists tb016_prd_vestuarios ;

drop table if exists tb011_logins ;

drop table if exists tb015_prd_eletros ;

drop table if exists tb014_prd_alimentos ;

drop table if exists tb005_006_funcionarios_cargos ;

drop table if exists tb006_cargos ;

drop table if exists tb010_012_vendas ;

drop table if exists tb010_clientes ;

drop table if exists tb005_funcionarios ;

drop table if exists tb004_lojas ;

drop table if exists tb999_log ;

drop table if exists tb012_017_compras ;

drop table if exists tb017_fornecedores ;

drop table if exists tb003_enderecos ;

drop table if exists tb002_cidades ;

drop table if exists tb001_uf ;

drop table if exists tb012_produtos ;

drop table if exists tb013_categorias ;

-- SQLINES FOR EVALUATION USE ONLY (14 DAYS)
CREATE TABLE tb001_uf
( 
	tb001_sigla_uf       VARCHAR(2)  NOT NULL ,
	tb001_nome_estado    VARCHAR(255)  NOT NULL 
);

ALTER TABLE tb001_uf
	ADD CONSTRAINT XPKtb001_uf PRIMARY KEY (tb001_sigla_uf);

CREATE TABLE tb002_cidades
( 
	tb002_cod_cidade     BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb001_sigla_uf       VARCHAR(2)  NOT NULL ,
	tb002_nome_cidade    VARCHAR(255)  NOT NULL 
);

ALTER TABLE tb002_cidades
	ADD CONSTRAINT XPKtb002_cidades PRIMARY KEY (tb002_cod_cidade,tb001_sigla_uf);

CREATE TABLE tb003_enderecos
( 
	tb003_cod_endereco   BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb001_sigla_uf       VARCHAR(2)  NOT NULL ,
	tb002_cod_cidade     BIGINT  NOT NULL ,
	tb003_nome_rua       VARCHAR(255)  NOT NULL ,
	tb003_numero_rua     VARCHAR(10)  NOT NULL ,
	tb003_complemento    VARCHAR(255)  NULL ,
	tb003_ponto_referencia VARCHAR(255)  NULL ,
	tb003_bairro         VARCHAR(255)  NOT NULL ,
	tb003_CEP            VARCHAR(15)  NOT NULL 
);

ALTER TABLE tb003_enderecos
	ADD CONSTRAINT XPKtb003_enderecos PRIMARY KEY (tb003_cod_endereco);

CREATE TABLE tb004_lojas
( 
	tb004_cod_loja       BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb003_cod_endereco   BIGINT  NULL ,
	tb004_matriz         BIGINT  NULL ,
	tb004_cnpj_loja      VARCHAR(20)  NOT NULL ,
	tb004_inscricao_estadual VARCHAR(20)  NULL 
);

ALTER TABLE tb004_lojas
	ADD CONSTRAINT XPKtb004_lojas PRIMARY KEY (tb004_cod_loja);

CREATE TABLE tb005_006_funcionarios_cargos
( 
	tb005_matricula      BIGINT  NOT NULL ,
	tb006_cod_cargo      BIGINT  NOT NULL ,
	tb005_006_valor_cargo NUMERIC(10,2)  NOT NULL ,
	tb005_006_perc_comissao_cargo NUMERIC(5,2)  NOT NULL ,
	tb005_006_data_promocao timestamp(3)  NOT NULL 
);

ALTER TABLE tb005_006_funcionarios_cargos
	ADD CONSTRAINT XPKtb005_006_funcionarios_cargos PRIMARY KEY (tb005_matricula,tb006_cod_cargo);

CREATE TABLE tb005_funcionarios
( 
	tb005_matricula      BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb004_cod_loja       BIGINT  NOT NULL ,
	tb003_cod_endereco   BIGINT  NOT NULL ,
	tb005_nome_completo  VARCHAR(255)  NOT NULL ,
	tb005_data_nascimento timestamp(3)  NOT NULL ,
	tb005_CPF            VARCHAR(17)  NOT NULL ,
	tb005_RG             VARCHAR(15)  NOT NULL ,
	tb005_status         VARCHAR(20)  NOT NULL ,
	tb005_data_contratacao timestamp(3)  NOT NULL ,
	tb005_data_demissao  timestamp(3)  NULL 
);

ALTER TABLE tb005_funcionarios
	ADD CONSTRAINT XPKtb005_funcionarios PRIMARY KEY (tb005_matricula);

CREATE TABLE tb006_cargos
( 
	tb006_cod_cargo      BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb006_nome_cargo     VARCHAR(255)  NOT NULL 
);

ALTER TABLE tb006_cargos
	ADD CONSTRAINT XPKtb006_cargos PRIMARY KEY (tb006_cod_cargo);

CREATE TABLE tb010_012_vendas
( 
	tb010_012_cod_venda  BIGINT  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	tb010_cpf            NUMERIC(15)  NOT NULL ,
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb005_matricula      BIGINT  NOT NULL ,
	tb010_012_data       timestamp(3)  NOT NULL ,
	tb010_012_quantidade BIGINT  NOT NULL ,
	tb010_012_valor_unitario NUMERIC(12,4)  NOT NULL
);

ALTER TABLE tb010_012_vendas
	ADD CONSTRAINT XPKtb010_012_vendas PRIMARY KEY (tb010_012_cod_venda,tb005_matricula,tb010_cpf,tb012_cod_produto);

CREATE TABLE tb010_clientes
( 
	tb010_cpf            NUMERIC(15)  NOT NULL ,
	tb010_nome           VARCHAR(255)  NOT NULL ,
	tb010_fone_residencial VARCHAR(255)  NOT NULL ,
	tb010_fone_celular   VARCHAR(255)  NULL 
);

ALTER TABLE tb010_clientes
	ADD CONSTRAINT XPKtb010_clientes PRIMARY KEY (tb010_cpf);

CREATE TABLE tb010_clientes_antigos
( 
	tb010_cpf            NUMERIC(15,0)  NOT NULL ,
	tb010_nome           VARCHAR(255)  NULL 
);

ALTER TABLE tb010_clientes_antigos
	ADD CONSTRAINT XPKtb010_clientes_antigos PRIMARY KEY (tb010_cpf);

CREATE TABLE tb011_logins
( 
	tb011_logins         VARCHAR(255)  NOT NULL ,
	tb010_cpf            NUMERIC(15)  NOT NULL ,
	tb011_senha          VARCHAR(255)  NOT NULL ,
	tb011_data_cadastro  timestamp(3)  NULL 
);

ALTER TABLE tb011_logins
	ADD CONSTRAINT XPKtb011_logins PRIMARY KEY (tb011_logins);

CREATE TABLE tb012_017_compras
( 
	tb012_017_cod_compra BIGINT GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb017_cod_fornecedor BIGINT  NOT NULL ,
	tb012_017_data       timestamp(3)  NULL ,
	tb012_017_quantidade BIGINT  NULL ,
	tb012_017_valor_unitario NUMERIC(12,2)  NULL
);

ALTER TABLE tb012_017_compras
	ADD CONSTRAINT XPKtb017_compras PRIMARY KEY (tb012_017_cod_compra,tb012_cod_produto,tb017_cod_fornecedor);

CREATE TABLE tb012_produtos
( 
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb013_cod_categoria  BIGINT  NOT NULL ,
	tb012_descricao      VARCHAR(255)  NOT NULL 
);

ALTER TABLE tb012_produtos
	ADD CONSTRAINT XPKtb012_produtos PRIMARY KEY (tb012_cod_produto);

CREATE TABLE tb013_categorias
( 
	tb013_cod_categoria  BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb013_descricao      VARCHAR(255)  NOT NULL 
);


ALTER TABLE tb013_categorias
	ADD CONSTRAINT XPKtb013_categorias PRIMARY KEY (tb013_cod_categoria);

CREATE TABLE tb014_prd_alimentos
( 
	tb014_cod_prd_alimentos BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb014_detalhamento   VARCHAR(255)  NOT NULL ,
	tb014_unidade_medida VARCHAR(255)  NOT NULL ,
	tb014_num_lote       VARCHAR(255)  NULL ,
	tb014_data_vencimento timestamp(3)  NULL ,
	tb014_valor_sugerido numeric(10,2)  NULL 
);

ALTER TABLE tb014_prd_alimentos
	ADD CONSTRAINT XPKtb014_prd_alimentos PRIMARY KEY (tb014_cod_prd_alimentos,tb012_cod_produto);

CREATE TABLE tb015_prd_eletros
( 
	tb015_cod_prd_eletro BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb015_detalhamento   VARCHAR(255)  NOT NULL ,
	tb015_tensao         VARCHAR(255)  NULL ,
	tb015_nivel_consumo_procel char(1)  NULL ,
	tb015_valor_sugerido numeric(10,2)  NULL 
);

ALTER TABLE tb015_prd_eletros
	ADD CONSTRAINT XPKtb015_prd_tvs PRIMARY KEY (tb015_cod_prd_eletro,tb012_cod_produto);

CREATE TABLE tb016_prd_vestuarios
( 
	tb016_cod_prd_vestuario BIGINT  GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb012_cod_produto    BIGINT  NOT NULL ,
	tb016_detalhamento   VARCHAR(255)  NOT NULL ,
	tb016_sexo           CHAR(1)  NOT NULL ,
	tb016_tamanho        VARCHAR(255)  NULL ,
	tb016_numeracao      BIGINT  NULL ,
	tb016_valor_sugerido numeric(10,2)  NULL 
);

ALTER TABLE tb016_prd_vestuarios
	ADD CONSTRAINT XPKtb016_refrigeradores PRIMARY KEY (tb016_cod_prd_vestuario,tb012_cod_produto);

CREATE TABLE tb017_fornecedores
( 
	tb017_cod_fornecedor BIGINT GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb017_razao_social   VARCHAR(255)  NULL ,
	tb017_nome_fantasia  VARCHAR(255)  NULL ,
	tb017_fone           VARCHAR(15)  NULL ,
	tb003_cod_endereco   BIGINT  NULL 
);

ALTER TABLE tb017_fornecedores
	ADD CONSTRAINT XPKtb017_fornecedor PRIMARY KEY (tb017_cod_fornecedor);

CREATE TABLE tb999_log
( 
	tb999_cod_log        BIGINT GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 ) ,
	tb099_objeto         VARCHAR(100)  NOT NULL ,
	tb999_dml            VARCHAR(25)  NOT NULL ,
	tb999_data           timestamp(3)  NOT NULL 
);

ALTER TABLE tb999_log
	ADD CONSTRAINT XPKtb999_log PRIMARY KEY (tb999_cod_log);



ALTER TABLE tb002_cidades
	ADD CONSTRAINT CONST_UF_CIDADE FOREIGN KEY (tb001_sigla_uf) REFERENCES tb001_uf(tb001_sigla_uf)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb003_enderecos
	ADD CONSTRAINT CONST_CIDADE_END FOREIGN KEY (tb002_cod_cidade,tb001_sigla_uf) REFERENCES tb002_cidades(tb002_cod_cidade,tb001_sigla_uf)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb004_lojas
	ADD CONSTRAINT CONST_END_LOJAS FOREIGN KEY (tb003_cod_endereco) REFERENCES tb003_enderecos(tb003_cod_endereco)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb005_006_funcionarios_cargos
	ADD CONSTRAINT CONST_FUNC_FUNCCARGO FOREIGN KEY (tb005_matricula) REFERENCES tb005_funcionarios(tb005_matricula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb005_006_funcionarios_cargos
	ADD CONSTRAINT CONST_CARGO_FUNCCARGO FOREIGN KEY (tb006_cod_cargo) REFERENCES tb006_cargos(tb006_cod_cargo)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb005_funcionarios
	ADD CONSTRAINT CONST_END_FUNC FOREIGN KEY (tb003_cod_endereco) REFERENCES tb003_enderecos(tb003_cod_endereco)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb005_funcionarios
	ADD CONSTRAINT CONST_LOJAS_FUNC FOREIGN KEY (tb004_cod_loja) REFERENCES tb004_lojas(tb004_cod_loja)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb010_012_vendas
	ADD CONSTRAINT CONST_FUNC_VENDAS FOREIGN KEY (tb005_matricula) REFERENCES tb005_funcionarios(tb005_matricula)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb010_012_vendas
	ADD CONSTRAINT CONST_CLI_VENDAS FOREIGN KEY (tb010_cpf) REFERENCES tb010_clientes(tb010_cpf)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb010_012_vendas
	ADD CONSTRAINT CONST_PRD_VENDAS FOREIGN KEY (tb012_cod_produto) REFERENCES tb012_produtos(tb012_cod_produto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb011_logins
	ADD CONSTRAINT CONST_CLI_LOGIN FOREIGN KEY (tb010_cpf) REFERENCES tb010_clientes(tb010_cpf)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb012_017_compras
	ADD CONSTRAINT CONST_PRD_COMPRAS FOREIGN KEY (tb012_cod_produto) REFERENCES tb012_produtos(tb012_cod_produto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb012_017_compras
	ADD CONSTRAINT CONST_FORN_COMPRAS FOREIGN KEY (tb017_cod_fornecedor) REFERENCES tb017_fornecedores(tb017_cod_fornecedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb012_produtos
	ADD CONSTRAINT CONST_CAT_PRD FOREIGN KEY (tb013_cod_categoria) REFERENCES tb013_categorias(tb013_cod_categoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb014_prd_alimentos
	ADD CONSTRAINT CONST_PRD_ALIM FOREIGN KEY (tb012_cod_produto) REFERENCES tb012_produtos(tb012_cod_produto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb015_prd_eletros
	ADD CONSTRAINT CONST_PRD_ELET FOREIGN KEY (tb012_cod_produto) REFERENCES tb012_produtos(tb012_cod_produto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb016_prd_vestuarios
	ADD CONSTRAINT CONST_PRD_VEST FOREIGN KEY (tb012_cod_produto) REFERENCES tb012_produtos(tb012_cod_produto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



ALTER TABLE tb017_fornecedores
	ADD CONSTRAINT CONST_END_FORN FOREIGN KEY (tb003_cod_endereco) REFERENCES tb003_enderecos(tb003_cod_endereco)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;



-- SQLINES DEMO *** ------
/* SET SCHEMA ' */;
DELETE FROM tb001_uf;
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('AC', 'Acre');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('AL', 'Alagoas');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('AP', 'Amapá');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('AM', 'Amazonas');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('BA', 'Bahia');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('CE', 'Ceará');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('DF', 'Distrito Federal');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('ES', 'Espírito Santo');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('GO', 'Goiás');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('MA', 'Maranhão');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('MT', 'Mato Grosso');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('MS', 'Mato Grosso do Sul');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('MG', 'Minas Gerais');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('PA', 'Pará');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('PB', 'Paraíba');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('PR', 'Paraná');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('PE', 'Pernambuco');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('PI', 'Piauí');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('RR', 'Roraima');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('RO', 'Rondônia');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('RJ', 'Rio de Janeiro');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('RN', 'Rio Grande do Norte');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('RS', 'Rio Grande do Sul');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('SC', 'Santa Catarina');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('SP', 'São Paulo');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('SE', 'Sergipe');
insert into tb001_uf (tb001_sigla_uf, tb001_nome_estado) VALUES('TO', 'Tocantins');


-- SQLINES DEMO *** ------
/* SET SCHEMA ' */;
DELETE FROM tb002_cidades;
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('AC', 'Rio Branco');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('AL', 'Maceió');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('AP', 'Macapá');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('AM', 'Manaus');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('BA', 'Salvador');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('CE', 'Fortaleza');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('DF', 'Brasília');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('ES', 'Vitória');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('GO', 'Goiânia');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('MA', 'São Luís');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('MT', 'Cuiabá');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('MS', 'Campo Grande');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('MG', 'Belo Horizonte');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('PA', 'Belém');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('PB', 'João Pessoa');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('PR', 'Curitiba');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('PE', 'Recife');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('PI', 'Teresina');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('RR', 'Boa Vista');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('RO', 'Porto Velho');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('RJ', 'Rio de Janeiro');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('RN', 'Natal');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('RS', 'Porto Alegre');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('SC', 'Florianópolis');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('SP', 'São Paulo');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('SE', 'Aracaju');
insert into tb002_cidades (tb001_sigla_uf, tb002_nome_cidade) VALUES('TO', 'Palmas');


-- SQLINES DEMO *** ------
/* SET SCHEMA ' */;
DELETE FROM  tb003_enderecos;
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '1.234',null,null, 'Centro', '80.345-432');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '234',null,null, 'Centro', '80.345-533');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '43', 'Bl 08 AP 30',null, 'Rebouças', '82.345-434');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. 1º de Maio', '34',null,null, 'Pampulha', '81.345-435');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Getúlio Vargas', '4.324',null,null, 'Água Verde', '80.345-634');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '23',null,null, 'Centro', '80.345-735');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '54', 'Casa 02',null, 'Centro', '82.345-435');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '345', 'Casa 20', 'Próx. Shopping Curitiba', 'Centro', '81.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Iguaçú', '11',null,null, 'Rebouças', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Manoel Ribas', '876',null,null, 'Santa Felicidade', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '467',null,null, 'Centro', '80.345-634');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '422',null,null, 'Centro', '80.345-735');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '376', 'Bl 08 AP 31',null, 'Rebouças', '82.345-435');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. 1º de Maio', '331',null,null, 'Pampulha', '81.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Getúlio Vargas', '285',null,null, 'Água Verde', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '240',null,null, 'Centro', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '194', 'Casa 38',null, 'Centro', '82.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Rua Brigadeiro Franco', '149', 'Casa 56', 'Próx. Vicente Machado', 'Centro', '81.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Iguaçú', '103',null,null, 'Rebouças', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Manoel Ribas', '331',null,null, 'Santa Felicidade', '82.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '285',null,null, 'Centro', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '240',null,null, 'Centro', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. Brasil', '331', 'Bl 08 AP 32',null, 'Rebouças', '82.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('MG', 13, 'Av. 1º de Maio', '285',null,null, 'Pampulha', '81.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('PR', 16, 'Av. Getúlio Vargas', '240',null,null, 'Água Verde', '80.345-038');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '43',null,null, 'Centro', '80.345-634');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '34',null,null, 'Centro', '80.345-735');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '4.324',null,null, 'Rebouças', '82.345-435');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '23', 'Casa 01',null, 'Rebouças', '81.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '54', 'Casa 23',null, 'Centro', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Joaquim Lima', '345', 'Casa 99',null, 'Centro', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '11',null,null, 'Ladeira', '82.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '876',null,null, 'Ladeira', '81.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '467',null,null, 'Ladeira', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '422',null,null, 'Ladeira', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '376',null,null, 'Ladeira', '80.345-634');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('RS', 23, 'Av. Das Nações', '331',null,null, 'Ladeira', '80.345-735');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Das Nações', '285',null,null, 'Ladeira', '82.345-436');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Das Nações', '240',null,null, 'Ladeira', '81.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Das Nações', '34',null,null, 'Ladeira', '80.345-156');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Paulista', '4.324',null,null, 'Centro', '80.345-199');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Washington Luiz', '23',null,null, 'Moema', '82.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Washington Luiz', '54',null,null, 'Moema', '81.345-438');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Washington Luiz', '345',null,null, 'Moema', '80.345-103');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Washington Luiz', '11',null,null, 'Moema', '80.345-123');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '34',null,null, 'Centro', '80.345-836');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '4.324',null,null, 'Centro', '80.345-937');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '23',null,null, 'Centro', '82.345-437');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '54',null,null, 'Centro', '81.345-438');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '345',null,null, 'Centro', '80.345-599');
insert into tb003_enderecos (tb001_sigla_uf, tb002_cod_cidade, tb003_nome_rua, tb003_numero_rua, tb003_complemento,tb003_ponto_referencia, tb003_bairro, tb003_CEP) VALUES('SP', 25, 'Av. Consolação', '11',null,null, 'Centro', '80.345-836');
-- SQLINES DEMO *** ------
/* SET SCHEMA ' */;
DELETE FROM tb004_lojas;
insert into tb004_lojas (tb003_cod_endereco, tb004_matriz, tb004_cnpj_loja, tb004_inscricao_estadual) VALUES(5,null, '99.555.000-0001/01', '234.655.765');
insert into tb004_lojas (tb003_cod_endereco, tb004_matriz, tb004_cnpj_loja, tb004_inscricao_estadual) VALUES(1,1, '99.555.000-0001/02', '567.655.766');
insert into tb004_lojas (tb003_cod_endereco, tb004_matriz, tb004_cnpj_loja, tb004_inscricao_estadual) VALUES(28,1, '99.555.000-0001/03', '888.655.767');
insert into tb004_lojas (tb003_cod_endereco, tb004_matriz, tb004_cnpj_loja, tb004_inscricao_estadual) VALUES(41,null, '99.555.000-0001/04', '234.655.768');
insert into tb004_lojas (tb003_cod_endereco, tb004_matriz, tb004_cnpj_loja, tb004_inscricao_estadual) VALUES(10,1, '99.555.000-0001/05', '234.567.769');


-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb005_funcionarios;
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 8, 'Funcionário 01', '1/1/1975', '999.444.555-01', '543.765.234-8', 'Ativo', '1/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(2, 2, 'Funcionário 02', '2/3/1978', '999.444.555-02', '543.765.234-9', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3,24, 'Funcionário 03', '3/10/1982', '999.444.555-03', '543.765.234-10', 'Ativo', '3/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(4, 9, 'Funcionário 04', '4/3/1989', '999.444.555-04', '543.765.234-11', 'Ativo', '4/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(5, 8, 'Funcionário 05', '5/1/1979', '999.444.555-05', '543.765.234-12', 'Inativo', '5/6/2000', '1/1/2009');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 7, 'Funcionário 06', '1/1/1975', '999.444.555-06', '543.765.234-13', 'Ativo', '6/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(2, 4, 'Funcionário 07', '2/3/1978', '999.444.555-07', '543.765.234-14', 'Ativo', '7/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 1, 'Funcionário 08', '3/10/1982', '999.444.555-08', '543.765.234-15', 'Ativo', '8/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(4,28, 'Funcionário 09', '4/3/1989', '999.444.555-09', '543.765.234-16', 'Ativo', '9/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(5, 9, 'Funcionário 10', '5/1/1979', '999.444.555-10', '543.765.234-17', 'Inativo', '10/6/2000', '2/1/2009');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 8, 'Funcionário 11', '1/1/1975', '999.444.555-11', '543.765.234-18', 'Ativo', '11/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(2, 5, 'Funcionário 12', '2/3/1978', '999.444.555-12', '543.765.234-19', 'Ativo', '12/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 2, 'Funcionário 13', '3/10/1982', '999.444.555-13', '543.765.234-20', 'Ativo', '10/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(4, 9, 'Funcionário 14', '4/3/1989', '999.444.555-14', '543.765.234-21', 'Ativo', '11/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(5,10, 'Funcionário 15', '5/1/1979', '999.444.555-15', '543.765.234-22', 'Inativo', '12/6/2000', '3/1/2009');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 9, 'Funcionário 16', '1/1/1975', '999.444.555-16', '543.765.234-23', 'Ativo', '12/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1,15, 'Funcionário 17', '2/3/1978', '999.444.555-17', '543.765.234-24', 'Ativo', '7/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 9, 'Funcionário 18', '3/10/1982', '999.444.555-18', '543.765.234-25', 'Ativo', '11/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1,19, 'Funcionário 19', '4/3/1989', '999.444.555-19', '543.765.234-26', 'Ativo', '10/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 7, 'Funcionário 20', '5/1/1979', '999.444.555-20', '543.765.234-27', 'Inativo', '2/6/2000', '4/1/2008');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 7, 'Funcionário 21', '1/1/1975', '999.444.555-21', '543.765.234-28', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(2, 5, 'Funcionário 22', '2/3/1978', '999.444.555-22', '543.765.234-29', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 3, 'Funcionário 23', '3/10/1982', '999.444.555-23', '543.765.234-30', 'Ativo', '3/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 3, 'Funcionário 24', '4/3/1989', '999.444.555-24', '543.765.234-31', 'Ativo', '4/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 4, 'Funcionário 25', '5/1/1979', '999.444.555-25', '543.765.234-32', 'Inativo', '5/6/2000', '5/1/2005');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 5, 'Funcionário 26', '1/1/1975', '999.444.555-26', '543.765.234-33', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3, 6, 'Funcionário 27', '2/3/1978', '999.444.555-27', '543.765.234-34', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(3,25, 'Funcionário 28', '3/10/1982', '999.444.555-28', '543.765.234-35', 'Ativo', '2/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(4, 1, 'Funcionário 29', '4/3/1989', '999.444.555-29', '543.765.234-36', 'Ativo', '1/6/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(5, 1, 'Funcionário 30', '5/1/1979', '999.444.555-30', '543.765.234-37', 'Inativo', '3/6/2000', '6/1/2009');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 1, 'Funcionário 31', '1/1/1975', '999.444.555-31', '543.765.234-38', 'Ativo', '1/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(5, 2, 'Funcionário 32', '2/3/1978', '999.444.555-32', '543.765.234-39', 'Ativo', '2/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 6, 'Funcionário 33', '3/10/1982', '999.444.555-33', '543.765.234-40', 'Ativo', '3/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 7, 'Funcionário 34', '4/3/1989', '999.444.555-34', '543.765.234-41', 'Ativo', '4/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 8, 'Funcionário 35', '5/1/1979', '999.444.555-35', '543.765.234-42', 'Inativo', '5/7/2000', '7/1/2009');
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 9, 'Funcionário 36', '1/1/1975', '999.444.555-36', '543.765.234-43', 'Ativo', '6/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1,30, 'Funcionário 37', '2/3/1978', '999.444.555-37', '543.765.234-44', 'Ativo', '7/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 1, 'Funcionário 38', '3/10/1982', '999.444.555-38', '543.765.234-45', 'Ativo', '8/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 1, 'Funcionário 39', '4/3/1989', '999.444.555-39', '543.765.234-46', 'Ativo', '9/7/2000',null);
insert into tb005_funcionarios (tb004_cod_loja, tb003_cod_endereco, tb005_nome_completo, tb005_data_nascimento, tb005_CPF, tb005_RG, tb005_status, tb005_data_contratacao, tb005_data_demissao) VALUES(1, 4, 'Funcionário 40', '5/1/1979', '999.444.555-40', '543.765.234-47', 'Inativo', '10/7/2000', '8/1/2005');




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb006_cargos;
insert into tb006_cargos (tb006_nome_cargo) VALUES('Diretor');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Gerente Regional');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Caixa');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Auxiliar Administrativo');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Vendedor Júnior');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Vendedor Pleno');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Vendedor Senior');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Motorista');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Recursos Humanos');
insert into tb006_cargos (tb006_nome_cargo) VALUES('Contador');


-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb005_006_funcionarios_cargos;
INSERT INTO tb005_006_funcionarios_cargos VALUES(1, 1, 30000.00, 0.00, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(12, 2, 10000.00, 0.00, '3/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(13, 3, 1000.00, 0.00, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(14, 4, 500.00, 0.00, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(14, 5, 800.00, 0.05, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(16, 6, 1000.00, 0.07, '2/4/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(17, 7, 1300.00, 0.10, '2/5/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(18, 8, 1050.00, 0.00, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(19, 9, 1150.00, 0.00, '2/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(10, 3, 1050.99, 0.00, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(11, 5, 800.00, 0.06, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(12, 6, 1000.00, 0.06, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(13, 7, 1300.00, 0.11, '2/4/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(15, 5, 800.00, 0.04, '2/5/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(15, 6, 1000.00, 0.09, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(16, 7, 1300.00, 0.12, '2/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(17, 5, 800.00, 0.05, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(18, 6, 1000.00, 0.09, '12/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(4, 7, 1300.00, 0.12, '10/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(20, 3, 1000.00, 0.00, '2/4/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(11, 3, 1000.00, 0.00, '2/5/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(12, 3, 1000.00, 0.00, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(13, 8, 1050.00, 0.00, '5/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(14, 8, 1050.00, 0.00, '6/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(15, 8, 1050.00, 0.00, '7/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(16, 8, 1050.00, 0.00, '8/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(17, 2, 10000.00, 0.00, '2/4/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(18, 2, 10000.00, 0.00, '2/5/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(14, 2, 10000.00, 0.00, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(10, 5, 800.00, 0.04, '9/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(11, 6, 1000.00, 0.07, '6/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(12, 7, 1300.00, 0.12, '7/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(13, 5, 800.00, 0.04, '12/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(14, 6, 1000.00, 0.07, '2/4/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(15, 7, 1300.00, 0.11, '3/5/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(16, 3, 1000.00, 0.00, '1/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(17, 3, 1000.00, 0.00, '5/2/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(18, 7, 1300.00, 0.11, '5/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(3, 7, 1300.00, 0.11, '5/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(10, 7, 1300.00, 0.11, '8/3/2008');
INSERT INTO tb005_006_funcionarios_cargos VALUES(13, 6, 1000.00, 0.07, '9/3/2009');
INSERT INTO tb005_006_funcionarios_cargos VALUES(8, 7, 1300.00, 0.10, '2/4/2009');
INSERT INTO tb005_006_funcionarios_cargos VALUES(9, 2, 10000.00, 0.10, '2/5/2009');




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb010_clientes;
INSERT INTO tb010_clientes VALUES(10000000000, 'NOME Teste 01', '(41) 3333-0001', '(41) 9999-9001');
INSERT INTO tb010_clientes VALUES(10000000001, 'NOME Teste 02', '(41) 3333-0002', '(41) 9999-9002');
INSERT INTO tb010_clientes VALUES(10000000002, 'NOME Teste 03', '(41) 3333-0003', '(41) 9999-9003');
INSERT INTO tb010_clientes VALUES(10000000003, 'NOME Teste 04', '(41) 3333-0004', '(41) 9999-9004');
INSERT INTO tb010_clientes VALUES(10000000004, 'NOME Teste 05', '(41) 3333-0005', '(41) 9999-9005');
INSERT INTO tb010_clientes VALUES(10000000005, 'NOME Teste 06', '(41) 3333-0006', '(41) 9999-9006');
INSERT INTO tb010_clientes VALUES(10000000006, 'NOME Teste 07', '(41) 3333-0007', '(41) 9999-9007');
INSERT INTO tb010_clientes VALUES(10000000007, 'NOME Teste 08', '(41) 3333-0008', '(41) 9999-9008');
INSERT INTO tb010_clientes VALUES(10000000008, 'NOME Teste 09', '(41) 3333-0009', '(41) 9999-9009');
INSERT INTO tb010_clientes VALUES(10000000009, 'NOME Teste 10', '(41) 3333-0010', '(41) 9999-9010');
INSERT INTO tb010_clientes VALUES(10000000010, 'NOME Teste 11', '(11) 5333-0011', '(41) 9999-9011');
INSERT INTO tb010_clientes VALUES(10000000011, 'NOME Teste 12', '(41) 3333-0012', '(41) 9999-9012');
INSERT INTO tb010_clientes VALUES(10000000012, 'NOME Teste 13', '(41) 3333-0013', '(41) 9999-9013');
INSERT INTO tb010_clientes VALUES(10000000013, 'NOME Teste 14', '(41) 3333-0014', '(41) 9999-9014');
INSERT INTO tb010_clientes VALUES(10000000014, 'NOME Teste 15', '(41) 3333-0015', '(41) 9999-9015');
INSERT INTO tb010_clientes VALUES(10000000015, 'NOME Teste 16', '(48) 5333-8989', '(41) 9999-9016');
INSERT INTO tb010_clientes VALUES(10000000016, 'NOME Teste 17', '(41) 3333-0017', '(41) 9999-9017');
INSERT INTO tb010_clientes VALUES(10000000017, 'NOME Teste 18', '(41) 3333-0018', '(41) 9999-9018');
INSERT INTO tb010_clientes VALUES(10000000018, 'NOME Teste 19', '(41) 3333-0019', '(41) 9999-9019');
INSERT INTO tb010_clientes VALUES(10000000019, 'NOME Teste 20', '(41) 3333-0020', '(41) 9999-9020');
INSERT INTO tb010_clientes VALUES(10000000020, 'NOME Teste 21', '(41) 3333-0021', '(41) 9999-9021');
INSERT INTO tb010_clientes VALUES(10000000021, 'NOME Teste 22', '(41) 3333-0022', '(41) 9999-9022');
INSERT INTO tb010_clientes VALUES(10000000022, 'NOME Teste 23', '(11) 5333-0099', '(41) 9999-9023');
INSERT INTO tb010_clientes VALUES(10000000023, 'NOME Teste 24', '(41) 3333-0024', '(41) 9999-9024');
INSERT INTO tb010_clientes VALUES(10000000024, 'NOME Teste 25', '(41) 3333-0025', '(11) 8999-9025');
INSERT INTO tb010_clientes VALUES(10000000025, 'NOME Teste 26', '(41) 3333-0026', '(41) 9999-9026');
INSERT INTO tb010_clientes VALUES(10000000026, 'NOME Teste 27', '(41) 3333-0027', '(41) 9999-9027');
INSERT INTO tb010_clientes VALUES(10000000027, 'NOME Teste 28', '(41) 3333-0028', '(41) 9999-9028');
INSERT INTO tb010_clientes VALUES(10000000028, 'NOME Teste 29', '(41) 3333-0029', '(41) 9999-9029');
INSERT INTO tb010_clientes VALUES(10000000029, 'NOME Teste 30', '(41) 3333-0030', '(41) 9999-9030');
INSERT INTO tb010_clientes VALUES(10000000030, 'NOME Teste 31', '(41) 3333-0031', '(41) 9999-9031');
INSERT INTO tb010_clientes VALUES(10000000031, 'NOME Teste 32', '(41) 3333-0032', '(41) 9999-9032');
INSERT INTO tb010_clientes VALUES(10000000032, 'NOME Teste 33', '(41) 3333-0033', '(41) 9999-9033');
INSERT INTO tb010_clientes VALUES(10000000033, 'NOME Teste 34', '(41) 3333-0034', '(41) 9999-9034');
INSERT INTO tb010_clientes VALUES(10000000034, 'NOME Teste 35', '(41) 3333-0035', '(41) 9999-9035');
INSERT INTO tb010_clientes VALUES(10000000035, 'NOME Teste 36', '(41) 3333-0036', '(41) 9999-9036');
INSERT INTO tb010_clientes VALUES(10000000036, 'NOME Teste 37', '(41) 3333-0037', '(41) 9999-9037');
INSERT INTO tb010_clientes VALUES(10000000037, 'NOME Teste 38', '(41) 3333-0038', '(41) 9999-9038');
INSERT INTO tb010_clientes VALUES(10000000038, 'NOME Teste 39', '(41) 3333-0039', '(41) 9999-9039');
INSERT INTO tb010_clientes VALUES(10000000039, 'NOME Teste 40', '(41) 3333-0040', '(41) 9999-9040');
INSERT INTO tb010_clientes VALUES(10000000040, 'NOME Teste 41', '(41) 3333-0041', '(41) 9999-9041');
INSERT INTO tb010_clientes VALUES(10000000041, 'NOME Teste 42', '(41) 3333-0042', '(41) 9999-9042');
INSERT INTO tb010_clientes VALUES(10000000042, 'NOME Teste 43', '(41) 3333-0043', '(41) 9999-9043');
INSERT INTO tb010_clientes VALUES(10000000043, 'NOME Teste 44', '(41) 3333-0044', '(41) 9999-9044');
INSERT INTO tb010_clientes VALUES(10000000044, 'NOME Teste 45', '(41) 3333-0045', '(11) 8999-9325');
INSERT INTO tb010_clientes VALUES(10000000045, 'NOME Teste 46', '(41) 3333-0046', '(11) 8999-9089');
INSERT INTO tb010_clientes VALUES(10000000046, 'NOME Teste 47', '(41) 3333-0047', '(41) 9999-9047');
INSERT INTO tb010_clientes VALUES(10000000047, 'NOME Teste 48', '(41) 3333-0048', '(41) 9999-9048');
INSERT INTO tb010_clientes VALUES(10000000048, 'NOME Teste 49', '(41) 3333-0049', '(11) 8999-6464');
INSERT INTO tb010_clientes VALUES(10000000049, 'NOME Teste 50', '(41) 3333-0050', '(41) 9999-9050');
INSERT INTO tb010_clientes VALUES(10000000050, 'NOME Teste 51', '(41) 3333-0051', '(41) 9999-9051');




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb010_clientes_antigos;
INSERT INTO tb010_clientes_antigos VALUES(10000000000, 'NOME Teste 01');
INSERT INTO tb010_clientes_antigos VALUES(10000000001, 'NOME Teste 02');
INSERT INTO tb010_clientes_antigos VALUES(10000000002, 'NOME Teste 03');
INSERT INTO tb010_clientes_antigos VALUES(10000000003, 'NOME Teste 04');
INSERT INTO tb010_clientes_antigos VALUES(10000000004, 'NOME Teste 05');
INSERT INTO tb010_clientes_antigos VALUES(10000000005, 'NOME Teste 06');
INSERT INTO tb010_clientes_antigos VALUES(10000000006, 'NOME Teste 07');
INSERT INTO tb010_clientes_antigos VALUES(10000000007, 'NOME Teste 08');
INSERT INTO tb010_clientes_antigos VALUES(10000000008, 'NOME Teste 09');
INSERT INTO tb010_clientes_antigos VALUES(10000000009, 'NOME Teste 10');
INSERT INTO tb010_clientes_antigos VALUES(10000000010, 'NOME Teste 11');
INSERT INTO tb010_clientes_antigos VALUES(10000000011, 'NOME Teste 12');


-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb011_logins;
INSERT INTO tb011_logins VALUES('Teste_01',10000000000, 'Teste_01', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_02',10000000001, 'Teste_02', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_03',10000000002, 'Teste_03', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_04',10000000003, 'Teste_04', '11/1/2009');
INSERT INTO tb011_logins VALUES('Teste_05',10000000004, 'Teste_05', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_06',10000000005, 'Teste_06', '12/1/2009');
INSERT INTO tb011_logins VALUES('Teste_07',10000000006, 'Teste_07', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_08',10000000007, 'Teste_08', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_09',10000000008, 'Teste_09', '1/8/2009');
INSERT INTO tb011_logins VALUES('Teste_10',10000000009, 'Teste_10', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_11',10000000010, 'Teste_11', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_12',10000000011, 'Teste_12', '1/1/2008');
INSERT INTO tb011_logins VALUES('Teste_13',10000000012, 'Teste_13', '3/1/2009');
INSERT INTO tb011_logins VALUES('Teste_14',10000000013, 'Teste_14', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_15',10000000014, 'Teste_15', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_16',10000000015, 'Teste_16', '1/2/2009');
INSERT INTO tb011_logins VALUES('Teste_17',10000000016, 'Teste_17', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_18',10000000017, 'Teste_18', '5/1/2009');
INSERT INTO tb011_logins VALUES('Teste_19',10000000018, 'Teste_19', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_20',10000000019, 'Teste_20', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_21',10000000020, 'Teste_21', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_22',10000000021, 'Teste_22', '11/1/2009');
INSERT INTO tb011_logins VALUES('Teste_23',10000000022, 'Teste_23', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_24',10000000023, 'Teste_24', '5/1/2009');
INSERT INTO tb011_logins VALUES('Teste_25',10000000024, 'Teste_25', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_26',10000000025, 'Teste_26', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_27',10000000026, 'Teste_27', '1/8/2009');
INSERT INTO tb011_logins VALUES('Teste_28',10000000027, 'Teste_28', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_29',10000000028, 'Teste_29', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_30',10000000029, 'Teste_30', '1/1/2008');
INSERT INTO tb011_logins VALUES('Teste_31',10000000030, 'Teste_31', '8/1/2009');
INSERT INTO tb011_logins VALUES('Teste_32',10000000031, 'Teste_32', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_33',10000000032, 'Teste_33', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_34',10000000033, 'Teste_34', '1/2/2009');
INSERT INTO tb011_logins VALUES('Teste_35',10000000034, 'Teste_35', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_36',10000000035, 'Teste_36', '9/1/2009');
INSERT INTO tb011_logins VALUES('Teste_37',10000000036, 'Teste_37', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_38',10000000037, 'Teste_38', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_39',10000000038, 'Teste_39', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_40',10000000039, 'Teste_40', '11/1/2009');
INSERT INTO tb011_logins VALUES('Teste_41',10000000040, 'Teste_41', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_42',10000000041, 'Teste_42', '7/1/2009');
INSERT INTO tb011_logins VALUES('Teste_43',10000000042, 'Teste_43', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_44',10000000043, 'Teste_44', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_45',10000000044, 'Teste_45', '1/8/2009');
INSERT INTO tb011_logins VALUES('Teste_46',10000000045, 'Teste_46', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_47',10000000046, 'Teste_47', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_48',10000000047, 'Teste_48', '1/1/2008');
INSERT INTO tb011_logins VALUES('Teste_49',10000000048, 'Teste_49', '4/1/2009');
INSERT INTO tb011_logins VALUES('Teste_50',10000000049, 'Teste_50', '1/1/2009');
INSERT INTO tb011_logins VALUES('Teste_51',10000000050, 'Teste_51', '1/1/2009');




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb013_categorias;
insert into tb013_categorias (tb013_descricao) VALUES('Alimentos Perecíveis');
insert into tb013_categorias (tb013_descricao) VALUES('Alimentos Não Perecíveis');
insert into tb013_categorias (tb013_descricao) VALUES('Eletrodomésticos');
insert into tb013_categorias (tb013_descricao) VALUES('Eletrônicos');
insert into tb013_categorias (tb013_descricao) VALUES('CD e DVD');
insert into tb013_categorias (tb013_descricao) VALUES('Roupas Masculinas');
insert into tb013_categorias (tb013_descricao) VALUES('Roupas Femininas');
insert into tb013_categorias (tb013_descricao) VALUES('Roupas Infantis');




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb012_produtos;
INSERT INTO tb012_produtos VALUES(10, 1, 'Biscoito Recheado');
INSERT INTO tb012_produtos VALUES(11, 1, 'Pão-de-queijo Congelado');
INSERT INTO tb012_produtos VALUES(12, 1, 'Iogurte');
INSERT INTO tb012_produtos VALUES(13, 1, 'Barra de Chocolate');
INSERT INTO tb012_produtos VALUES(14, 1, 'Barra de Cereal');
INSERT INTO tb012_produtos VALUES(15, 1, 'Biscoito Água e Sal');
INSERT INTO tb012_produtos VALUES(16, 1, 'Biscoito Maizena');
INSERT INTO tb012_produtos VALUES(17, 1, 'Salgadinho');
INSERT INTO tb012_produtos VALUES(18, 1, 'Suco Ades');
INSERT INTO tb012_produtos VALUES(19, 1, 'Isotônico');
INSERT INTO tb012_produtos VALUES(20, 2, 'Acúcar');
INSERT INTO tb012_produtos VALUES(21, 2, 'Arroz');
INSERT INTO tb012_produtos VALUES(22, 2, 'Feijão');
INSERT INTO tb012_produtos VALUES(23, 2, 'Milho de Pipoca');
INSERT INTO tb012_produtos VALUES(30, 3, 'Geladeira');
INSERT INTO tb012_produtos VALUES(31, 3, 'Geladeira Duplex');
INSERT INTO tb012_produtos VALUES(32, 3, 'Fogão 4 Bocas');
INSERT INTO tb012_produtos VALUES(33, 3, 'Fogão 6 Bocas');
INSERT INTO tb012_produtos VALUES(34, 3, 'Batedeira');
INSERT INTO tb012_produtos VALUES(35, 3, 'Liquidificador');
INSERT INTO tb012_produtos VALUES(36, 3, 'Torradeira');
INSERT INTO tb012_produtos VALUES(37, 3, 'Sanduicheira');
INSERT INTO tb012_produtos VALUES(38, 3, 'Multiprocessador');
INSERT INTO tb012_produtos VALUES(39, 3, 'Forno Elétrico');
INSERT INTO tb012_produtos VALUES(40, 4, 'TV LCD');
INSERT INTO tb012_produtos VALUES(41, 4, 'TV Cubo de Imagens');
INSERT INTO tb012_produtos VALUES(42, 4, 'DVD');
INSERT INTO tb012_produtos VALUES(43, 4, 'DVD Karaoke');
INSERT INTO tb012_produtos VALUES(44, 4, 'Vídeo-Game');
INSERT INTO tb012_produtos VALUES(45, 4, 'Aparelho de Som');
INSERT INTO tb012_produtos VALUES(46, 4, 'Aparelho de Som Automotivo');
INSERT INTO tb012_produtos VALUES(47, 4, 'Auto-Falantes Automotivos');
INSERT INTO tb012_produtos VALUES(48, 4, 'Notebook');
INSERT INTO tb012_produtos VALUES(49, 4, 'Computador Desktop');
INSERT INTO tb012_produtos VALUES(50, 5, 'CD Rock');
INSERT INTO tb012_produtos VALUES(51, 5, 'CD POP');
INSERT INTO tb012_produtos VALUES(52, 5, 'CD Coletânea');
INSERT INTO tb012_produtos VALUES(53, 5, 'CD Caipira');
INSERT INTO tb012_produtos VALUES(54, 5, 'CD Virgem');
INSERT INTO tb012_produtos VALUES(55, 5, 'DVD Rock');
INSERT INTO tb012_produtos VALUES(56, 5, 'DVD POP');
INSERT INTO tb012_produtos VALUES(57, 5, 'DVD Coletânea');
INSERT INTO tb012_produtos VALUES(58, 5, 'DVD Caipira');
INSERT INTO tb012_produtos VALUES(59, 5, 'DVD Virgem');
INSERT INTO tb012_produtos VALUES(60, 6, 'Calça Jeans');
INSERT INTO tb012_produtos VALUES(61, 6, 'Calça Moleton');
INSERT INTO tb012_produtos VALUES(62, 6, 'Camisa Polo');
INSERT INTO tb012_produtos VALUES(63, 6, 'Camisa Manga Longa');
INSERT INTO tb012_produtos VALUES(64, 6, 'Camisa Manga Curta');
INSERT INTO tb012_produtos VALUES(65, 6, 'Camiseta');
INSERT INTO tb012_produtos VALUES(66, 6, 'Regata');
INSERT INTO tb012_produtos VALUES(67, 6, 'Meias');
INSERT INTO tb012_produtos VALUES(68, 6, 'Roupas de Baixo');
INSERT INTO tb012_produtos VALUES(69, 6, 'Gravatas');
INSERT INTO tb012_produtos VALUES(70, 7, 'Calça Jeans');
INSERT INTO tb012_produtos VALUES(71, 7, 'Calça Moleton');
INSERT INTO tb012_produtos VALUES(72, 7, 'Top');
INSERT INTO tb012_produtos VALUES(73, 7, 'Camisa Manga Longa');
INSERT INTO tb012_produtos VALUES(74, 7, 'Camisa Manga Curta');
INSERT INTO tb012_produtos VALUES(75, 7, 'Camiseta');
INSERT INTO tb012_produtos VALUES(76, 7, 'Regata');
INSERT INTO tb012_produtos VALUES(77, 7, 'Meias');
INSERT INTO tb012_produtos VALUES(78, 7, 'Roupas de Baixo');
INSERT INTO tb012_produtos VALUES(79, 7, 'Bolsas');
INSERT INTO tb012_produtos VALUES(80, 8, 'Camiseta');
INSERT INTO tb012_produtos VALUES(81, 8, 'Bermuda');
INSERT INTO tb012_produtos VALUES(82, 8, 'Tênis');
INSERT INTO tb012_produtos VALUES(83, 8, 'Bonés');


-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb014_prd_alimentos;
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(10, 'Trakinas', 'Kilogramas', '8887775456', '2/11/2024', 1.10);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(10, 'Pica-Pau', 'Kilogramas', '3457684345', '1/2/2024', 0.89);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(10, 'Gulosos', 'Kilogramas', '8276348762', '12/1/2024', 1.09);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(11, 'Quijo de Minas', 'Kilogramas', '5473545453', '1/6/2024', 3.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(11, '+ Pão', 'Kilogramas', '5473545453', '1/6/2024', 2.89);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(12, 'Batavo - Frutas', 'Litros', '5473545453', '1/5/2024', 1.09);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(12, 'Danone', 'Litros', '9768935983', '1/5/2024', 0.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(13, 'Garoto', 'Kilogramas', '9583495345', '1/5/2024', 3.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(13, 'Nestlé', 'Kilogramas', '5345662345', '1/3/2024', 4.19);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(13, 'Hersheys', 'Kilogramas', 'FRU4345GDA', '1/4/2024', 2.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(14, 'Nutri', 'Kilogramas', '5433145453', '1/6/2024', 0.79);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(14, 'Trill', 'Kilogramas', '8757689456', '1/6/2024', 0.69);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(15, 'Nestlé', 'Kilogramas', '2324345423', '1/4/2024', 2.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(15, 'Todeschini', 'Kilogramas', '7896532736', '5/1/2024', 1.39);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(15, 'Mabel', 'Kilogramas', '98475934hhg', '12/12/2024', 1.20);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(16, 'Nestlé', 'Kilogramas', '13468720049', '5/11/2024', 2.10);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(16, 'Todeschini', 'Kilogramas', '19040907362', '1/12/2024', 1.14);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(16, 'Mabel', 'Kilogramas', '46575934hhg', '1/12/2024', 1.18);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(17, 'Elma Chips', 'Kilogramas', '34174845745', '2/6/2024', 1.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(17, 'Tip-Top', 'Kilogramas', '77583275585', '1/8/2024', 1.49);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(17, 'Pipoteca', 'Kilogramas', '9283478gdy9', '8/10/2024', 0.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(18, 'Del Vale', 'Litros', '12874534549', '2/6/2024', 1.39);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(18, 'Ades', 'Litros', '120991705w34', '1/5/2024', 1.09);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(18, 'Minute Maid +', 'Litros', '164400135343frt', '8/10/2024', 2.99);
insert into tb014_prd_alimentos (tb012_cod_produto, tb014_detalhamento, tb014_unidade_medida, tb014_num_lote, tb014_data_vencimento, tb014_valor_sugerido) VALUES(19, 'Isotônico', 'Litros', '9283478gdy10', '10/6/2024', 3.99);




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb015_prd_eletros;
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(30, 'Consul', '110-220 volts', 'A', 999.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(30, 'Esmaltec', '110-220 volts', 'B', 999.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(31, 'Bosch', '110-220 volts', 'B', 1399.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(31, 'Consul', '110-220 volts', 'B', 1399.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(32, 'Continental', '110-220 volts', 'A', 559.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(32, 'Dako', '110-220 volts', 'A', 699.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(33, 'Bosch', '110-220 volts', 'A', 999.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(33, 'Esmaltec', '110 volts', 'B', 899.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(34, 'Arno', '110 volts', 'A', 49.90);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(34, 'Arno', '220 volts', 'A', 52.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(35, 'Britânia', '110 volts', 'A', 65.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(35, 'Arno', '110 volts', 'A', 59.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(36, 'Esmaltec', '110 volts', 'A', 38.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(36, 'Arno', '110 volts', 'A', 49.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(37, 'Britânia', '110 volts', 'B', 43.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(37, 'Arno', '110 volts', 'B', 59.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(38, 'Arno', '110-220 volts', 'C', 799.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(39, 'Brastemp', '110-220 volts', 'C', 599.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(40, 'LG 42 Polegadas', '110-220 volts', 'A', 2999.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(40, 'Philco 42 Polegadas', '110-220 volts', 'A', 2850.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(41, 'CCE 29 Polegadas', '110-220 volts', 'B', 899.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(41, 'Samsung 29 Polegadas', '110-220 volts', 'A', 1250.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(42, 'Philips', '110-220 volts', 'A', 299.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(42, 'Philco', '110-220 volts', 'A', 270.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(43, 'Philco', '110-220 volts', 'A', 299.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(43, 'LG', '110-220 volts', 'A', 312.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(44, 'Play Station 2', '110-220 volts', 'A', 499.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(44, 'X Box 360', '110-220 volts', 'A', 650.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(45, 'Sony', '12 volts', null, 519.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(45, 'Aiwa', '12 volts', null, 430.50);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(46, 'Sony', '12 volts', null, 249.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(46, 'Pioneer', '12 volts', null, 310.80);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(47, 'Booster', '12 volts', null, 130.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(47, 'Bravox', '12 volts', null, 129.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(48, 'Positivo', '110-220 volts', 'A', 2599.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(48, 'Intelbras', '110-220 volts', 'A', 1400.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(49, 'STI', '110-220 volts', 'A', 999.90);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(49, 'Positivo', '110-220 volts', 'A', 1235.89);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(50, 'AC-DC Collection', null, null, 35.00);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(50, 'Ultraje a Rigor', null, null, 21.89);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(51, 'Shakira', null, null, 19.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(51, 'Beyonce', null, null, 1.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(52, 'Melhores 80 Rocks', null, null, 23.89);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(52, 'Melhores 90 Rocks', null, null, 25.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(53, 'Pena Branca e Xavantinho', null, null, 15.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(53, 'Milhionário e José Rico', null, null, 26.34);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(54, 'EMTEC', null, null, 0.89);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(54, 'BULK', null, null, 0.73);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(55, 'Deep Purple', null, null, 49.90);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(55, 'Joe Satriani', null, null, 72.78);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(56, 'Shakira', null, null, 89.34);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(56, 'Beyonce', null, null, 1.99);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(57, 'Melhores 80 Rocks', null, null, 35.75);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(57, 'Melhores 90 Rocks', null, null, 32.58);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(58, 'Berenice Azambuja', null, null, 35.76);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(58, 'Tadeu e Tadando', null, null, 32.59);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(59, 'EMTEC', null, null, 1.23);
insert into tb015_prd_eletros (tb012_cod_produto, tb015_detalhamento, tb015_tensao, tb015_nivel_consumo_procel, tb015_valor_sugerido) VALUES(59, 'BULK', null, null, 0.99);




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb016_prd_vestuarios;
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(60, 'Lee', 'M', null, 52, 69.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(60, 'Malwe', 'M', null, 56, 89.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(61, 'Malwe', 'U', 'Grande', null, 22.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(61, 'Hering', 'U', 'Pequena', null, 22.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(62, 'Polo', 'M', 'Grande', null, 22.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(62, 'Lacoste', 'M', 'Grande', null, 35.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(63, 'Polo', 'M', 'Grande', null, 27.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(63, 'Lacoste', 'M', 'Grande', null, 38.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(64, 'Polo', 'M', 'Grande', null, 22.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(64, 'Lacoste', 'M', 'Grande', null, 35.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(65, 'Rip Curl', 'U', 'Grande', null, 28.09);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(65, 'Mormai', 'U', 'Grande', null, 32.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(66, 'Mormai', 'M', 'Grande', null, 10.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(66, 'Mormai', 'M', 'Pequena', null, 10.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(67, 'Social', 'M', null, 44, 9.90);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(67, 'Esporte', 'M', null, 44, 12.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(68, 'Cueca', 'M', 'Grande', null, 15.89);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(68, 'Samba Canção', 'M', 'Grande', null, 15.89);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(69, 'Armani', 'M', null, null, 19.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(70, 'Lee', 'F', null, 46, 99.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(70, 'Malwe', 'F', null, 48, 119.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(71, 'Malwe', 'F', 'Grande', null, 35.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(71, 'Hering', 'F', 'Pequena', null, 35.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(72, 'Polo', 'F', 'Média', null, 37.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(72, 'Meimalha', 'F', 'Média', null, 37.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(73, 'Polo', 'F', 'Média', null, 27.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(73, 'Meimalha', 'F', 'Média', null, 38.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(74, 'Polo', 'F', 'Média', null, 22.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(74, 'Meimalha', 'F', 'Média', null, 35.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(75, 'Rip Curl', 'F', 'Média', null, 28.09);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(75, 'Mormai', 'F', 'Média', null, 32.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(76, 'Mormai', 'F', 'Média', null, 10.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(76, 'Mormai', 'F', 'Pequena', null, 10.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(77, 'Social', 'F', null, 44, 9.90);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(77, 'Esporte', 'F', null, 44, 12.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(78, 'Calcinhas', 'F', 'Pequena', null, 19.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(78, 'Soutien', 'F', 'Pequena', null, 29.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(79, 'Renner', 'F', null, null, 139.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(79, 'C & A', 'F', null, null, 119.00);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(80, 'Malwe', 'I', 'Pequena', null, 19.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(80, 'Tigor T Tigre', 'I', 'Pequena', null, 25.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(81, 'Malwe', 'I', 'Pequena', null, 19.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(81, 'Tigor T Tigre', 'I', 'Pequena', null, 25.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(82, 'Klin', 'I', null, 25, 39.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(82, 'Pimpolho', 'I', null, 28, 59.99);
insert into tb016_prd_vestuarios (tb012_cod_produto, tb016_detalhamento, tb016_sexo, tb016_tamanho, tb016_numeracao, tb016_valor_sugerido) VALUES(83, 'Tigor T Tigre', 'I', null, null, 9.50);




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb017_fornecedores;
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 01', 'Nome Fantasia - Empresa 01', '(41) 3343-4545',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 02', 'Nome Fantasia - Empresa 02', '(41) 3343-4546',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 03', 'Nome Fantasia - Empresa 03', '(41) 3343-4547',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 04', 'Nome Fantasia - Empresa 04', '(41) 3343-4548',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 05', 'Nome Fantasia - Empresa 05', '(41) 3343-4549',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 06', 'Nome Fantasia - Empresa 06', '(41) 3343-4550',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 07', 'Nome Fantasia - Empresa 07', '(41) 3343-4551',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 08', 'Nome Fantasia - Empresa 08', '(41) 3343-4552',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 09', 'Nome Fantasia - Empresa 09', '(41) 3343-4553',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 10', 'Nome Fantasia - Empresa 10', '(41) 3343-4554',7);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 11', 'Nome Fantasia - Empresa 11', '(41) 3343-4555',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 12', 'Nome Fantasia - Empresa 12', '(41) 3343-4556',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 13', 'Nome Fantasia - Empresa 13', '(41) 3343-4557',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 14', 'Nome Fantasia - Empresa 14', '(41) 3343-4558',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 15', 'Nome Fantasia - Empresa 15', '(41) 3343-4559',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 16', 'Nome Fantasia - Empresa 16', '(41) 3343-4560',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 17', 'Nome Fantasia - Empresa 17', '(41) 3343-4561',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 18', 'Nome Fantasia - Empresa 18', '(41) 3343-4562',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 19', 'Nome Fantasia - Empresa 19', '(41) 3343-4563',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 20', 'Nome Fantasia - Empresa 20', '(41) 3343-4564',8);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 21', 'Nome Fantasia - Empresa 21', '(41) 3343-4565',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 22', 'Nome Fantasia - Empresa 22', '(41) 3343-4566',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 23', 'Nome Fantasia - Empresa 23', '(41) 3343-4567',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 24', 'Nome Fantasia - Empresa 24', '(41) 3343-4568',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 25', 'Nome Fantasia - Empresa 25', '(41) 3343-4569',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 26', 'Nome Fantasia - Empresa 26', '(41) 3343-4570',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 27', 'Nome Fantasia - Empresa 27', '(41) 3343-4571',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 28', 'Nome Fantasia - Empresa 28', '(41) 3343-4572',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 29', 'Nome Fantasia - Empresa 29', '(41) 3343-4573',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 30', 'Nome Fantasia - Empresa 30', '(41) 3343-4574',9);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 31', 'Nome Fantasia - Empresa 31', '(41) 3343-4575',10);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 32', 'Nome Fantasia - Empresa 32', '(41) 3343-4576',11);
insert into tb017_fornecedores (tb017_razao_social, tb017_nome_fantasia, tb017_fone, tb003_cod_endereco) VALUES('Empresa 33', 'Nome Fantasia - Empresa 33', '(41) 3343-4577',12);




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb010_012_vendas;
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000000, 10,  4, '03/11/2024', 2, 1.42);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000001, 10,  2, '03/12/2024', 3, 0.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000002, 10,  3, '03/13/2024', 1, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000003, 11,  5, '03/14/2024', 2, 2.46);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000004, 11,  5, '03/15/2024', 2, 2.62);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000005, 11,  6, '03/16/2024', 1, 3.22);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000006, 12,  8, '03/17/2024', 1, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000007, 12,  7, '03/18/2024', 1, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000008, 12,  7, '03/19/2024', 2, 0.83);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000009, 13,  9, '03/20/2024', 2, 3.76);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000010, 13, 10, '03/21/2024', 1, 3.54);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000011, 13, 11, '03/22/2024', 2, 3.34);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000012, 14, 13, '03/23/2024', 3, 0.51);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000013, 14, 12, '03/24/2024', 2, 0.51);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000014, 14, 13, '03/25/2024', 1, 0.45);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000015, 15, 14, '03/26/2024', 1, 1.42);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000016, 15, 15, '03/27/2024', 1, 1.55);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000017, 15, 16, '03/28/2024', 1, 1.42);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000018, 16, 17, '03/29/2024', 2, 2.22);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000019, 16, 18, '03/30/2024', 2, 1.58);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000020, 16, 19, '03/31/2024', 2, 1.63);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000021, 17, 20, '01/04/2024', 1, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000022, 17, 21, '02/04/2024', 3, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000023, 17, 22, '03/04/2024', 2, 0.83);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000024, 18, 23, '04/04/2024', 3, 1.58);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000025, 18, 24, '05/04/2024', 1, 1.63);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000026, 18, 25, '06/04/2024', 2, 1.10);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000027, 19, 26, '07/04/2024', 4, 2.22);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000028, 30,  1, '08/04/2024', 3, 1152.62);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000029, 30,  2, '09/04/2024', 2, 1137.58);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000030, 31,  3, '04/10/2024', 2, 1760.00);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000031, 31,  4, '04/11/2024', 1, 1600.00);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000032, 32,  5, '04/12/2024', 1, 574.40);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000033, 32,  6, '04/13/2024', 1, 577.79);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000034, 33,  7, '04/14/2024', 1, 894.40);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000035, 33,  8, '04/15/2024', 1, 737.79);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000036, 34,  9, '04/16/2024', 1, 24.00);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000037, 34, 10, '04/17/2024', 1, 27.20);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000038, 35, 11, '04/18/2024', 1, 35.20);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000039, 35, 12, '04/19/2024', 2, 49.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000040, 36, 14, '04/20/2024', 2, 43.20);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000041, 37, 15, '04/21/2024', 1, 52.80);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000042, 38, 17, '04/22/2024', 1, 43.20);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000043, 39, 18, '04/23/2024', 1, 52.80);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000044, 40, 20, '03/16/2024', 1, 1643.31);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000045, 41, 21, '03/17/2024', 1, 2949.74);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000046, 42, 24, '03/18/2024', 2, 203.31);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000047, 43, 25, '03/19/2024', 1, 229.74);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000048, 44, 28, '03/20/2024', 1, 660.91);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000049, 45, 29, '03/21/2024', 1, 732.14);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000050, 46, 32, '03/22/2024', 1, 340.91);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000015, 47, 33, '03/23/2024', 3, 143.34);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000016, 48, 36, '03/24/2024', 1, 1968.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000017, 49, 37, '03/25/2024', 2, 980.91);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000018, 50, 40, '03/26/2024', 1, 18.54);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000019, 51,  4, '03/27/2024', 1, 17.26);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000020, 52,  2, '03/28/2024', 4, 18.56);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000021, 53,  3, '03/29/2024', 1, 17.28);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000022, 54,  5, '03/30/2024', 3, 18.58);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000023, 55,  5, '03/31/2024', 1, 17.30);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000024, 56,  6, '01/04/2024', 2, 18.59);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000025, 57,  8, '02/04/2024', 1, 17.31);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000026, 58,  7, '03/04/2024', 1, 18.61);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000027, 59,  7, '04/04/2024', 2, 0.69);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000028, 60,  9, '05/04/2024', 2, 95.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000029, 60, 10, '06/04/2024', 1, 122.38);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000030, 61, 11, '03/16/2024', 2, 29.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000031, 61, 13, '03/17/2024', 1, 29.97);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000032, 62, 12, '03/18/2024', 2, 29.98);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000033, 62, 13, '03/19/2024', 1, 47.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000034, 63, 14, '03/20/2024', 2, 36.72);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000037, 63, 15, '03/21/2024', 1, 51.68);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000038, 64, 16, '03/22/2024', 2, 29.92);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000039, 64, 17, '03/23/2024', 1, 47.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000040, 65, 18, '03/24/2024', 2, 38.19);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000041, 65, 19, '03/25/2024', 1, 43.54);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000000, 66, 20, '03/26/2024', 1, 14.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000001, 66, 21, '03/27/2024', 2, 14.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000002, 67, 22, '03/28/2024', 1, 13.46);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000003, 67, 23, '03/29/2024', 2, 16.42);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000004, 68, 24, '03/30/2024', 1, 21.71);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000005, 68, 25, '03/31/2024', 3, 21.65);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000006, 69, 26, '01/04/2024', 1, 27.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000007, 70,  1, '02/04/2024', 3, 135.98);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000008, 70,  2, '03/04/2024', 1, 163.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000009, 71,  3, '04/04/2024', 1, 47.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000010, 71,  4, '05/04/2024', 2, 47.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000011, 72,  5, '06/04/2024', 1, 50.32);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000000, 72,  6, '03/16/2024', 1, 50.32);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000001, 73,  7, '03/17/2024', 2, 36.72);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000002, 73,  8, '03/18/2024', 1, 51.78);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000003, 74,  9, '03/19/2024', 1, 30.06);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000004, 74, 10, '03/20/2024', 1, 47.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000005, 75, 11, '03/21/2024', 1, 38.19);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000006, 75, 12, '03/22/2024', 2, 43.60);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000007, 76, 14, '03/23/2024', 1, 14.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000008, 76, 15, '03/24/2024', 2, 14.94);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000009, 77, 17, '03/25/2024', 1, 13.46);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000010, 77, 18, '03/26/2024', 1, 16.40);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000011, 78, 20, '03/27/2024', 1, 27.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000012, 78, 21, '03/28/2024', 3, 38.38);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000013, 79, 24, '03/29/2024', 1, 189.49);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000014, 79, 25, '03/30/2024', 1, 161.84);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000015, 80, 28, '03/31/2024', 2, 27.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000012, 80, 29, '01/04/2024', 1, 35.34);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000013, 81, 32, '02/04/2024', 1, 27.18);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000014, 81, 33, '03/04/2024', 1, 35.34);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000015, 82, 36, '04/04/2024', 2, 54.38);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000013, 82, 37, '05/04/2024', 1, 81.58);
insert into tb010_012_vendas (tb010_cpf, tb012_cod_produto, tb005_matricula, tb010_012_data, tb010_012_quantidade, tb010_012_valor_unitario) VALUES(10000000014, 83, 40, '06/04/2024', 1, 14.38);




-- SQLINES DEMO *** ------


/* SET SCHEMA ' */;
DELETE FROM tb012_017_compras;
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 10,  4, '01/01/2024', 3, 0.89);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 10,  2, '01/02/2024', 1, 0.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 10,  3, '01/03/2024', 2, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 11,  5, '01/04/2024', 3, 1.54);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 11,  5, '01/05/2024', 1, 1.64);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 11,  6, '01/06/2024', 2, 2.01);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 12,  8, '01/07/2024', 3, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 12,  7, '01/08/2024', 3, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 12,  7, '01/09/2024', 3, 0.52);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 13,  9, '01/10/2024', 3, 2.35);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 13, 10, '01/11/2024', 3, 2.21);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 13, 11, '01/12/2024', 4, 2.09);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 14, 13, '01/13/2024', 4, 0.32);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 14, 12, '01/14/2024', 4, 0.32);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 14, 13, '01/15/2024', 4, 0.28);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 15, 14, '01/16/2024', 5, 0.89);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 15, 15, '01/17/2024', 5, 0.97);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 15, 16, '01/18/2024', 5, 0.89);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 16, 17, '02/19/2024', 5, 1.39);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 16, 18, '02/20/2024', 6, 0.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 16, 19, '02/21/2024', 6, 1.02);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 17, 20, '02/22/2024', 3, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 17, 21, '02/23/2024', 4, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 17, 22, '02/24/2024', 2, 0.52);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 18, 23, '02/25/2024', 5, 0.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 18, 24, '02/26/2024', 3, 1.02);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 18, 25, '02/27/2024', 4, 0.69);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 19, 26, '02/28/2024', 3, 1.39);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 30,  1, '02/10/2024', 5, 720.39);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 30,  2, '02/11/2024', 5, 710.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 31,  3, '02/13/2024', 3, 1100.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 31,  4, '02/14/2024', 2, 1000.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 32,  5, '02/15/2024', 1, 359.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 32,  6, '02/16/2024', 3, 361.12);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 33,  7, '02/17/2024', 3, 559.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 33,  8, '02/18/2024', 3, 461.12);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 34,  9, '02/19/2024', 5, 15.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 34, 10, '02/20/2024', 2, 17.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 35, 11, '02/21/2024', 5, 22.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 35, 12, '02/22/2024', 3, 31.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 36, 14, '02/23/2024', 4, 27.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 37, 15, '02/24/2024', 5, 33.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 38, 17, '02/25/2024', 3, 27.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 39, 18, '01/26/2024', 5, 33.00);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 40, 20, '03/27/2024', 2, 1027.07);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 41, 21, '03/28/2024', 1, 1843.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 42, 24, '03/16/2024', 5, 127.07);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 43, 25, '03/17/2024', 6, 143.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 44, 28, '03/18/2024', 4, 413.07);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 45, 29, '03/19/2024', 3, 457.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 46, 32, '03/20/2024', 6, 213.07);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 47, 33, '03/16/2024', 6, 89.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 48, 16, '03/17/2024', 6, 1230.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 49, 27, '03/18/2024', 6, 613.07);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 50, 30, '03/19/2024', 6, 11.59);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 51,  4, '03/20/2024', 3, 10.79);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 52,  2, '03/03/2024', 6, 11.60);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 53,  3, '03/04/2024', 4, 10.80);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 54,  5, '03/05/2024', 6, 11.61);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 55,  5, '03/06/2024', 3, 10.81);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 56,  6, '01/07/2024', 2, 11.62);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 57,  8, '05/08/2024', 6, 10.82);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 58,  7, '05/09/2024', 6, 11.63);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 59,  7, '05/10/2024', 5, 0.43);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 60,  9, '05/24/2024', 4, 59.49);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 60, 10, '05/25/2024', 6, 76.49);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 61, 11, '05/26/2024', 5, 18.71);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 61, 13, '05/27/2024', 3, 18.73);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 62, 12, '05/28/2024', 5, 18.74);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 62, 13, '05/16/2024', 6, 29.75);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 63, 14, '05/17/2024', 6, 22.95);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 63, 15, '05/18/2024', 6, 32.30);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 64, 16, '05/19/2024', 6, 18.70);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 64, 17, '05/20/2024', 6, 29.75);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 65, 18, '05/16/2024', 6, 23.87);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 65, 19, '05/17/2024', 4, 27.21);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 66, 20, '05/18/2024', 6, 9.34);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 66, 21, '05/19/2024', 3, 9.34);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 67, 22, '05/20/2024', 8, 8.41);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 67, 23, '05/03/2024', 9, 10.26);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 68, 24, '05/04/2024', 6, 13.57);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 68, 25, '05/05/2024', 6, 13.53);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 69, 26, '01/06/2024', 9, 16.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 70,  1, '01/07/2024', 8, 84.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 70,  2, '08/08/2024', 6, 101.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 71,  3, '08/09/2024', 7, 29.75);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 71,  4, '08/10/2024', 6, 29.75);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 72,  5, '08/24/2024', 7, 31.45);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 72,  6, '08/25/2024', 6, 31.45);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 73,  7, '08/26/2024', 7, 22.95);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 73,  8, '08/27/2024', 5, 32.36);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 74,  9, '08/28/2024', 7, 18.79);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 74, 10, '08/16/2024', 4, 29.75);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 75, 11, '08/17/2024', 3, 23.87);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 75, 12, '08/18/2024', 7, 27.25);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 76, 14, '08/19/2024', 3, 9.34);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 76, 15, '08/20/2024', 7, 9.34);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 77, 17, '08/16/2024', 7, 8.41);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 77, 18, '08/17/2024', 2, 10.25);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 78, 20, '08/18/2024', 7, 16.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 78, 21, '08/19/2024', 4, 23.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 79, 24, '08/20/2024', 7, 118.43);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 79, 25, '08/03/2024', 3, 101.15);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 80, 28, '08/04/2024', 7, 16.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 80, 29, '08/05/2024', 7, 22.09);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 81, 32, '08/06/2024', 8, 16.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 81, 33, '08/07/2024', 4, 22.09);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 82, 16, '08/08/2024', 5, 33.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 82, 17, '01/09/2024', 8, 50.99);
insert into tb012_017_compras (tb012_cod_produto, tb017_cod_fornecedor, tb012_017_data, tb012_017_quantidade, tb012_017_valor_unitario) VALUES( 83, 10, '01/10/2024', 8, 8.99);
