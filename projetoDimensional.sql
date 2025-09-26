-- alter database kaironst set DateStyle to 'ISO, DMY';

drop table if exists dimAno cascade;
drop table if exists dimMes cascade;
drop table if exists dimDia cascade;
drop table if exists dimCliente cascade;
drop table if exists dimProduto cascade;
drop table if exists dimEndereco_loja cascade;
drop table if exists dimFuncionario cascade;
drop table if exists fatoVenda cascade;


--inicialização do projeto sql em postgres do banco de dados em modelo dimenional para a loja de varejo
--declaração das dimensões

create table dimAno (
	id bigserial primary key,
	ano int, 
	constraint ukDataAno unique(ano)
);

create table dimMes (
	id bigserial primary key,
	mes int,
	ano bigint, --fk
	constraint fkanomes foreign key (ano) references dimAno(id),
	constraint ukDataMes unique(mes,ano)
);

create table dimDia (
	id bigserial primary key,
	dia int,
	mes bigint, --fk
	constraint fkmesdia foreign key (mes) references dimMes(id),
	constraint ukDataDia unique (dia,mes)
);

create table dimCliente (
	id bigserial primary key,
	cpf numeric(15),
	nome varchar(255)
);

create table dimProduto (
	id bigserial primary key,
	primary_key_origem bigint,
	descricao varchar(255),

	tipo varchar(50),
	detalhamento varchar(255),
	desc_categoria varchar(255)
);

create table dimEndereco_loja (
	id bigserial primary key,
	matriz numeric(10),
	cnpj_loja varchar(20),
	nome_rua varchar(255),
	numero_rua varchar(10),
	bairro varchar(255),
	cep varchar(15),
	nome_cidade varchar(255),
	sigla_uf varchar(255)
);

create table dimFuncionario (
	id bigserial primary key,
	matricula int,
	nome_completo varchar(255),
	loja bigint, --fk
	constraint fkFuncionarioLoja foreign key (loja) references dimEndereco_loja(id)
);

--declaração dos fatos

create table fatoVenda (
	quantidade int,
	valor int,
	fkCliente bigint,
	fkFuncionario bigint,
	fkLoja bigint,
	fkDia bigint,
	fkProduto bigint,
	constraint fkclientevenda foreign key (fkCliente) references dimCliente(id),
	constraint fkfuncionariovenda foreign key (fkFuncionario) references dimFuncionario(id),
	constraint fkdiavenda foreign key (fkDia) references dimDia(id),
	constraint fklojavenda foreign key (fkLoja) references dimEndereco_loja(id),
	constraint fkprodutovenda foreign key (fkProduto) references dimProduto(id)
);
