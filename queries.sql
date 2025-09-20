-- inicializando as tabelas de datas.

insert into DimAno(ano) (
	select distinct extract(YEAR FROM tb010_012_data) from tb010_012_vendas
);
insert into DimMes(mes, ano) (
	select distinct extract(MONTH FROM v.tb010_012_data), d.id from tb010_012_vendas v, dimAno d
	where d.ano = extract(YEAR FROM tb010_012_data)
);
insert into DimDia(dia, mes) (
	select distinct extract(DAY FROM v.tb010_012_data), d.id from tb010_012_vendas v, dimMes d
	where d.mes = extract(MONTH FROM tb010_012_data)
);


insert into DimAno(ano) (
	select distinct extract(YEAR FROM tb012_017_data) from tb010_012_compras
);
insert into DimMes(mes, ano) (
	select distinct extract(MONTH FROM v.tb012_017_data), d.id from tb010_012_compras v, dimAno d
	where d.ano = extract(YEAR FROM tb012_017_data)
);
insert into DimDia(dia, mes) (
	select distinct extract(DAY FROM v.tb012_017_data), d.id from tb010_012_compras v, dimMes d
	where d.mes = extract(MONTH FROM tb012_017_data)
);

--inicializando as tabelas de localização

insert into DimUf(sigla_uf,nome_estado) (
	select distinct tb001_sigla_uf, tb001_nome_estado from tb001_uf
);
insert into DimCidade(nome_cidade, uf) (
	select distinct v.tb002_nome_cidade, d.id from tb002_cidades v, DimUf d
	where d.sigla_uf = v.tb001_sigla_uf
);
insert into DimEndereco(nome_rua, numero_rua, complemento, ponto_referencia, bairro, cep, cidade) (
	select distinct v.tb003_nome_rua, v.tb003_numero_rua, tb003_complemento, tb003_ponto_referencia, tb003_bairro, tb003_cep, d.id from tb003_enderecos v, DimCidade d
	inner join tb002_cidades w on v.tb002_cod_cidade = w.tb002_cod_cidade
	where d.nome_cidade = w.tb002_nome_cidade
);

