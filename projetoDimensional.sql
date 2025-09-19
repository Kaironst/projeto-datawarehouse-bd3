alter database kaironst set DateStyle to 'ISO, DMY';

drop table if exists dimAno cascade;
drop table if exists dimMes cascade;
drop table if exists dimDia cascade;
drop table if exists dimCliente cascade;
drop table if exists dimProduto cascade;
drop table if exists dimUf cascade;
drop table if exists dimCidade cascade;
drop table if exists dimEndereco cascade;
drop table if exists dimLoja cascade;
drop table if exists dimFuncionario_cargo cascade;
drop table if exists dimFornecedor cascade;
drop table if exists fatoVenda cascade;
drop table if exists fatoCompra cascade;


--inicialização do projeto sql em postgres do banco de dados em modelo dimenional para a loja de varejo
--declaração das dimensões

create table dimAno (
	id serial primary key,
	ano int
);

create table dimMes (
	id serial primary key,
	mes int,
	ano int, --fk
	constraint fkanomes foreign key (ano) references dimAno(id)
);

create table dimDia (
	id serial primary key,
	dia int,
	mes int, --fk
	constraint fkmesdia foreign key (mes) references dimMes(id)
);

create table dimCliente (
	id serial primary key,
	cpf numeric(15), --  não sei se mudo isso ou não graças ao backup, mas o cpf aqui é numeric e o cpf do funcionário é varchar(17)
	fone_residencial varchar(255),
	fone_celular varchar(255)
);

create table dimProduto (
	id serial primary key,
	descricao varchar(255),
	detalhamento varchar(255),
	
	unidade_media varchar(255),
	num_lote varchar(255),
	data_vencimento date,

	tensao varchar(255),
	nivel_consumo_procel char(1),

	sexo char(1),
	tamanho varchar(255),
	numeracao int
);

create table dimUf (
	id serial primary key,
	nome_estado varchar(255),
	sigla_uf varchar(2)
);

create table dimCidade (
	id serial primary key,
	nome_cidade varchar(255),
	uf int, --fk
	constraint fkuf foreign key (uf) references dimUf (id)
);

create table dimEndereco (
	id serial primary key,
	nome_rua varchar(255),
	numero_rua varchar(10),
	complemento varchar(255),
	ponto_referencia varchar(255),
	bairro varchar(255),
	cep varchar(15),
	cidade int, --fk
	constraint fkcidade foreign key (cidade) references dimCidade (id)
);

create table dimLoja (
	id serial primary key,
	matriz numeric(10),
	cnpj_loja varchar(20),
	inscricao_estadual varchar(20),
	endereco int, --fk
	constraint fkenderecoloja foreign key (endereco) references dimEndereco(id)
);

create table dimFuncionario_cargo (
	id serial primary key,
	matricula int,
	nome_completo varchar(255),
	data_nascimento date,
	cpf varchar(17),
	rg varchar(15),
	status varchar(20),
	data_contratacao date,
	data_demissao date,
	valor_cargo numeric(10,2),
	perc_comissao_cargo numeric(5,2),
	loja int, --fk
	endereco int, --fk
	constraint fkloja foreign key (loja) references dimLoja(id),
	constraint fkenderecofuncionario foreign key (endereco) references dimEndereco(id)
);

create table dimFornecedor (
	id serial primary key,
	razao_social varchar(255),
	nome_fantasia varchar(255),
	fone varchar(15),
	endereco int, --fk
	constraint fkenderecofornecedor foreign key (endereco) references dimEndereco(id)
);


--declaração dos fatos

create table fatoVenda (
	quantidade int,
	valor int,
	fkCliente int,
	fkFuncionario int,
	fkDia int,
	fkProduto int,
	constraint fkclientevenda foreign key (fkCliente) references dimCliente(id),
	constraint fkfuncionariovenda foreign key (fkFuncionario) references dimFuncionario_cargo(id),
	constraint fkdiavenda foreign key (fkDia) references dimDia(id),
	constraint fkprodutovenda foreign key (fkProduto) references dimProduto(id)
);

create table fatoCompra (
	quantidade int,
	valor int,
	fkFornecedor int,
	fkDia int,
	fkProduto int,
	constraint fkfornecedorcompra foreign key (fkFornecedor) references dimFornecedor(id),
	constraint fkdiacompra foreign key (fkDia) references dimDia(id),
	constraint fkprodutocompra foreign key (fkProduto) references dimProduto(id)
);

