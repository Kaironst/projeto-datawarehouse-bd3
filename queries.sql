-- inicializando as tabelas de datas.

insert into DimAno(ano) (
	select distinct extract(YEAR FROM tb010_012_data) from tb010_012_vendas
)
on conflict do nothing;
insert into DimMes(mes, ano) (
	select distinct extract(MONTH FROM v.tb010_012_data), d.id from tb010_012_vendas v, dimAno d
	where d.ano = extract(YEAR FROM tb010_012_data)
)
on conflict do nothing;
insert into DimDia(dia, mes) (
	select distinct extract(DAY FROM v.tb010_012_data), d.id from tb010_012_vendas v, dimMes d
	where d.mes = extract(MONTH FROM tb010_012_data)
)
on conflict do nothing;


insert into DimAno(ano) (
	select distinct extract(YEAR FROM tb012_017_data) from tb012_017_compras
)
on conflict do nothing;
insert into DimMes(mes, ano) (
	select distinct extract(MONTH FROM v.tb012_017_data), d.id from tb012_017_compras v, dimAno d
	where d.ano = extract(YEAR FROM tb012_017_data)
)
on conflict do nothing;
insert into DimDia(dia, mes) (
	select distinct extract(DAY FROM v.tb012_017_data), d.id from tb012_017_compras v, dimMes d
	where d.mes = extract(MONTH FROM tb012_017_data)
)
on conflict do nothing;

--inicializando as tabelas de localização

insert into dimuf(sigla_uf,nome_estado) (
	select distinct tb001_sigla_uf, tb001_nome_estado from tb001_uf
)
on conflict do nothing;
insert into dimcidade(nome_cidade, uf) (
	select distinct v.tb002_nome_cidade, d.id from tb002_cidades v, dimuf d
	where d.sigla_uf = v.tb001_sigla_uf
)
on conflict do nothing;
insert into dimendereco(nome_rua, numero_rua, complemento, ponto_referencia, bairro, cep, cidade) (
	select distinct v.tb003_nome_rua, v.tb003_numero_rua, tb003_complemento, tb003_ponto_referencia, tb003_bairro, tb003_cep, d.id from tb003_enderecos v
	full join tb002_cidades w on v.tb002_cod_cidade = w.tb002_cod_cidade
	full join dimcidade d on d.nome_cidade = w.tb002_nome_cidade
);

--inicializando as tabelas de loja

insert into dimLoja(matriz, cnpj_loja, inscricao_estadual, endereco) (
	select distinct v.tb004_matriz, v.tb004_cnpj_loja, v.tb004_inscricao_estadual, d.id from tb004_lojas v
	full join tb003_enderecos w on v.tb003_cod_endereco = w.tb003_cod_endereco
	full join dimEndereco d on d.nome_rua = w.tb003_nome_rua
		and d.numero_rua = w.tb003_numero_rua
		and d.cep = w.tb003_cep
);

--inicializando funcionário e fornecedor

insert into dimFuncionario_cargo (matricula, nome_completo, data_nascimento, cpf, rg, status, data_contratacao, data_demissao, valor_cargo, perc_comissao_cargo, loja, endereco) (
	select distinct v.tb005_matricula, v.tb005_nome_completo, v.tb005_data_nascimento, v.tb005_cpf, v.tb005_rg, v.tb005_status, v.tb005_data_contratacao, v.tb005_data_demissao, w.tb005_006_valor_cargo, w.tb005_006_perc_comissao_cargo, d.id, e.id from tb005_funcionarios v
	full join tb005_006_funcionarios_cargos w on v.tb005_matricula = w.tb005_matricula
	full join tb006_cargos ww on w.tb006_cod_cargo = ww.tb006_cod_cargo
	full join tb004_lojas x on v.tb004_cod_loja = x.tb004_cod_loja
	full join tb003_enderecos y on v.tb003_cod_endereco = y.tb003_cod_endereco
	full join dimLoja d on d.matriz = x.tb004_matriz and d.cnpj_loja = x.tb004_cnpj_loja and d.inscricao_estadual = x.tb004_inscricao_estadual
	full join dimEndereco e on e.nome_rua = y.tb003_nome_rua and e.numero_rua = y.tb003_numero_rua and e.cep = y.tb003_cep
	);

insert into dimFornecedor (primary_key_origem, razao_social, nome_fantasia, fone, endereco) (
	select distinct v.tb017_cod_fornecedor, v.tb017_razao_social, v.tb017_nome_fantasia, v.tb017_fone, d.id from tb017_fornecedores v
	full join tb003_enderecos w on v.tb003_cod_endereco = w.tb003_cod_endereco
	full join dimEndereco d on d.nome_rua = w.tb003_nome_rua and d.numero_rua = w.tb003_numero_rua and d.cep = w.tb003_cep
);

--inicializando cliente

insert into dimCliente (cpf, nome, fone_residencial,fone_celular) (
	select distinct v.tb010_cpf, v.tb010_nome, v.tb010_fone_residencial, v.tb010_fone_celular from tb010_clientes v
);

--inicializando produtos

insert into dimProduto (
    primary_key_origem, descricao, tipo, detalhamento, valor_sugerido, unidade_medida, num_lote, data_vencimento, tensao, nivel_consumo_procel, sexo, tamanho, numeracao
)
(
    -- Alimentos
    select p.tb012_cod_produto, p.tb012_descricao, 'ALIMENTO', v.tb014_detalhamento, v.tb014_valor_sugerido, v.tb014_unidade_medida, v.tb014_num_lote, v.tb014_data_vencimento, cast(null as varchar), cast(null as char(1)), cast(null as char(1)), cast(null as varchar), cast(null as int) from tb012_produtos p
    full join tb014_prd_alimentos v on p.tb012_cod_produto = v.tb012_cod_produto
	union
    -- Eletros
    select p.tb012_cod_produto, p.tb012_descricao, 'ELETRO', v.tb015_detalhamento, v.tb015_valor_sugerido, cast(null as varchar), cast(null as varchar), cast(null as date), v.tb015_tensao, v.tb015_nivel_consumo_procel, cast(null as char(1)), cast(null as varchar), cast(null as int) from tb012_produtos p
    full join tb015_prd_eletros v on p.tb012_cod_produto = v.tb012_cod_produto
	union
	-- Vestuários
    select p.tb012_cod_produto, p.tb012_descricao, 'VESTUARIO', v.tb016_detalhamento, v.tb016_valor_sugerido, cast(null as varchar), cast(null as varchar), cast(null as date), cast(null as varchar), cast(null as char(1)), v.tb016_sexo, v.tb016_tamanho, v.tb016_numeracao from tb012_produtos p
    full join tb016_prd_vestuarios v on p.tb012_cod_produto = v.tb012_cod_produto
);

--inicializando tabelas fato
--tabela vendal
insert into FatoVenda (quantidade, valor, fkCliente, fkfuncionario, fkProduto, fkDia) (
	select distinct sum(v.tb010_012_quantidade), sum(v.tb010_012_quantidade * v.tb010_012_valor_unitario), d.id, e.id, f.id, g.id from tb010_012_vendas v
	full join dimCliente  d on d.cpf = v.tb010_cpf
	full join dimFuncionario_cargo e on e.matricula = v.tb005_matricula
	full join dimProduto f on f.primary_key_origem = v.tb012_cod_produto
	full join dimAno i on i.ano = extract(year from v.tb010_012_data)
	full join dimMes h on h.mes = extract(month from v.tb010_012_data)
		and h.ano = i.id
	full join dimDia g on g.dia = extract(day from v.tb010_012_data)
		and g.mes = h.id
	group by cube(d.id, e.id, f.id, g.id)
);

--tabela compra
insert into FatoCompra (quantidade, valor, fkFornecedor, fkProduto, FkDia) (
	select distinct sum(v.tb012_017_quantidade), sum(v.tb012_017_quantidade*v.tb012_017_valor_unitario), d.id, e.id, f.id from tb012_017_compras v
	full join dimFornecedor d on d.primary_key_origem = v.tb017_cod_fornecedor 
	full join dimProduto e on e.primary_key_origem = v.tb012_cod_produto
	full join dimAno h on h.ano = extract(year from v.tb012_017_data)
	full join dimMes g on g.mes = extract(month from v.tb012_017_data)
		and g.ano = h.id
	full join dimDia f on f.dia = extract(day from v.tb012_017_data)
		and f.mes = g.id
	group by cube(d.id, e.id, f.id)
);
