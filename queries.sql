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

--inicializando as tabelas de loja

insert into dimEndereco_loja(matriz, cnpj_loja, nome_rua, numero_rua, bairro, cep, nome_cidade, sigla_uf) (
	select distinct v.tb004_matriz, v.tb004_cnpj_loja, w.tb003_nome_rua, w.tb003_numero_rua, w.tb003_bairro, w.tb003_cep, x.tb002_nome_cidade, w.tb001_sigla_uf from tb004_lojas v
	full join tb003_enderecos w on v.tb003_cod_endereco = w.tb003_cod_endereco
	full join tb002_cidades x on w.tb002_cod_cidade = x.tb002_cod_cidade
);

--inicializando funcionário e fornecedor

insert into dimFuncionario (matricula, nome_completo, loja) (
	select distinct v.tb005_matricula, v.tb005_nome_completo, d.id from tb005_funcionarios v
	full join tb004_lojas x on v.tb004_cod_loja = x.tb004_cod_loja
	full join dimEndereco_Loja d on d.matriz = x.tb004_matriz and d.cnpj_loja = x.tb004_cnpj_loja
);

--inicializando cliente

insert into dimCliente (cpf, nome) (
	select distinct v.tb010_cpf, v.tb010_nome from tb010_clientes v
);

--inicializando produtos

insert into dimProduto ( primary_key_origem, descricao, tipo, detalhamento, desc_categoria ) (
    -- alimentos
    select p.tb012_cod_produto, p.tb012_descricao, 'alimento', v.tb014_detalhamento, w.tb013_descricao from tb012_produtos p
    full join tb014_prd_alimentos v on p.tb012_cod_produto = v.tb012_cod_produto
	full join tb013_categorias w on p.tb013_cod_categoria = w.tb013_cod_categoria
	union
    -- eletros
    select p.tb012_cod_produto, p.tb012_descricao, 'eletro', v.tb015_detalhamento, w.tb013_descricao from tb012_produtos p
    full join tb015_prd_eletros v on p.tb012_cod_produto = v.tb012_cod_produto
	full join tb013_categorias w on p.tb013_cod_categoria = w.tb013_cod_categoria
	union
	-- vestuários
    select p.tb012_cod_produto, p.tb012_descricao, 'vestuario', v.tb016_detalhamento, w.tb013_descricao from tb012_produtos p
    full join tb016_prd_vestuarios v on p.tb012_cod_produto = v.tb012_cod_produto
	full join tb013_categorias w on p.tb013_cod_categoria = w.tb013_cod_categoria
);

--inicializando tabelas fato
--tabela compra
insert into FatoVenda (quantidade, valor, fkCliente, fkfuncionario, fkProduto, fkDia, fkLoja) (
	select distinct sum(v.tb010_012_quantidade), sum(v.tb010_012_quantidade * v.tb010_012_valor_unitario), d.id, e.id, f.id, g.id, j.id from tb010_012_vendas v
	full join dimCliente  d on d.cpf = v.tb010_cpf
	full join dimFuncionario e on e.matricula = v.tb005_matricula
	full join dimProduto f on f.primary_key_origem = v.tb012_cod_produto
	full join dimAno i on i.ano = extract(year from v.tb010_012_data)
	full join dimMes h on h.mes = extract(month from v.tb010_012_data)
		and h.ano = i.id
	full join dimDia g on g.dia = extract(day from v.tb010_012_data)
		and g.mes = h.id
	full join dimEndereco_loja j on j.id = e.loja 
	group by cube(d.id, e.id, f.id, g.id, j.id)
);
