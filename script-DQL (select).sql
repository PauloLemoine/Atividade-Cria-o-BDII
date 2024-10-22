create view questao1 as 
select cli.Nome "Cliente", func.Nome "Vendedor", prod.Nome_Produto "Produto", prod.Marca "Marca",
	concat("R$ ", format(Total_Venda - Desconto, 2, "de_DE")) "Valor Real", Forma_Pagamento "Forma de Pagamento"
	from venda 
		inner join cliente cli on cli.ID_Cliente = venda.ID_Cliente
        inner join funcionario func on func.ID_Funcionario = venda.ID_Funcionario
        inner join item_venda on item_venda.ID_Venda = venda.ID_Venda
        inner join produto prod on prod.ID_Produto = item_venda.ID_Produto
         order by func.nome;

create view questao2 as
select func.Nome "Funcionário", count(venda.ID_Venda) "Quantidade de vendas", 
	concat("R$ ", format(sum(venda.Total_Venda - venda.Desconto), 2, "de_DE")) "Receita total"
	from funcionario func
		inner join venda on venda.ID_Funcionario = func.ID_Funcionario
        group by func.Nome
        order by sum(venda.Total_Venda - venda.Desconto) desc;


create view questao3 as
select cli.nome "Cliente", venda.Data_Venda "Data de Compra", prod.Nome_Produto "Produto",
	concat("R$ ", format(venda.Total_Venda - venda.Desconto, 2, "de_DE")) "Valor Pago"
	from cliente cli
		inner join venda on cli.ID_Cliente = venda.ID_Cliente
        inner join item_venda iv on iv.ID_Venda = venda.ID_Venda 
        inner join produto prod on prod.ID_Produto = iv.ID_Produto
			where venda.Data_Venda between "2024-01-15" and "2024-06-20"
            order by (venda.Total_Venda - venda.Desconto) desc;
            
    create view questao4 as
select prod.Nome_Produto "Produto", prod.Marca "Marca", estoque.Quantidade "Estoque abaixo da média",
	date_format(compra.dataComp, "%d/%m/%Y") "Data de Compra", 
    concat("R$ ", format(ic.valorComp - compra.desconto, 2, "de_DE")) "Valor Unitário"
	from produto prod
		inner join estoque on estoque.ID_Produto = prod.ID_Produto
        inner join categoria ctg on ctg.ID_Categoria = prod.ID_Categoria
        inner join item_compra ic on ic.produto_ID_Produto = prod.ID_Produto
        inner join compra on compra.idcompras = ic.compras_idcompras
			where estoque.Quantidade < (select avg(Quantidade) from estoque) 
				and estoque.Data_Saida between "2024-01-10" and "2024-02-10";
                
create view questao5 as
select prod.Nome_Produto "Produto", prod.Marca, iv.Quantidade,
	concat("R$ ", format(prod.Preco, 2, "de_DE"))"Preço Unitário", 
    concat("R$ ", format(venda.Desconto, 2, "de_DE")) "Desconto",
    concat("R$ ", format((prod.Preco - venda.Desconto)*iv.Quantidade, 2, "de_DE")) "Valor Total da Venda"
	from produto prod
		inner join item_venda iv on iv.ID_Produto = prod.ID_Produto
        inner join venda on venda.ID_Venda = iv.ID_Venda
			where iv.Quantidade > (select avg(Quantidade) from item_venda) and
				venda.Data_Venda < now()
                order by (prod.Preco - venda.Desconto)*iv.Quantidade desc;

create view questao6 as
select fornecedor.Nome "Fornecedor", group_concat(distinct c.Nome_Categoria separator ', ') "Categoria",
	concat("R$ ", format(sum(item_compra.valorComp*item_compra.Quantidade), 2, "de_DE")) "Valor da compra dos produtos",
	endereco.UF "Estado", endereco.cidade "Cidade"
    from fornecedor 
    inner join fornecedor_compra on fornecedor_compra.fornecedor_cnpj = fornecedor.cnpj
    inner join endereco on endereco.fornecedor_cnpj = fornecedor.cnpj
    inner join compra on compra.idcompras = fornecedor_compra.compras_idcompras
    inner join item_compra on item_compra.compras_idcompras = compra.idcompras
    inner join produto on produto.ID_Produto = item_compra.produto_ID_Produto
    inner join categoria c on c.ID_Categoria = produto.ID_Categoria
		group by fornecedor.Nome, c.Nome_Categoria, endereco.UF, 
			endereco.cidade, item_compra.valorComp;
    

create view questao7 as 
select cli.Nome "Cliente", func.Nome "Funcionário", prod.Nome_Produto "Produto", prod.Descricao "Descrição",
	concat("R$ ", format((venda.Total_Venda - venda.Desconto), 2, "de_DE")) "Valor da compra"
	from cliente cli
    inner join venda on venda.ID_Cliente = cli.ID_Cliente
    inner join funcionario func on func.ID_Funcionario = venda.ID_Funcionario
    inner join item_venda iv on iv.ID_Venda = venda.ID_Venda
    inner join produto prod on prod.ID_Produto = iv.ID_Produto
     where venda.Desconto != 0 or venda.Desconto != null;
    
    
    
create view questao8 as
select cli.Nome "Cliente", cli.Endereco,cli.Telefone, cli.Email,prod.Nome_Produto "Produto" ,venda.Forma_Pagamento "Forma de Pagamento"
	from cliente cli
		inner join venda on venda.ID_Cliente = cli.ID_Cliente
        inner join item_venda iv on iv.ID_Venda = venda.ID_venda
        inner join produto prod on prod.ID_Produto = iv.ID_Produto
        where venda.Forma_Pagamento like "%inheiro" ;

create view questao9 as
    select 
    funcionario.ID_Funcionario "Id do Funcionário", funcionario.Nome "Funcionário", funcionario.Cargo "Cargo",
    funcionario.Contato "Telefone",
    format(avg(venda.Total_Venda),2, "de_DE") "Média de vendas"
from
    venda
inner join funcionario on venda.ID_Funcionario = funcionario.ID_Funcionario
group by
    funcionario.ID_Funcionario, 
    funcionario.Nome, 
    funcionario.Cargo, 
    funcionario.Contato;
    
create view questao_10 as 
    SELECT 
    produto.Nome_Produto "Produto",
    produto.Descricao,
    item_venda.Quantidade,
    item_venda.ID_Venda "Id da venda"
FROM
    item_venda
INNER JOIN produto ON item_venda.ID_Produto = produto.ID_Produto
WHERE
    item_venda.Quantidade > 4
   ORDER BY
    item_venda.Quantidade desc;
    
create view questao_11 as
    SELECT 
    cliente.ID_Cliente,
    produto.Nome_Produto,
    produto.Descricao,
    item_venda.Quantidade,
    cliente.Nome AS Nome_Cliente
FROM
    venda
INNER JOIN cliente ON venda.ID_Cliente = cliente.ID_Cliente
INNER JOIN item_venda ON venda.ID_Venda = item_venda.ID_Venda
INNER JOIN produto ON item_venda.ID_Produto = produto.ID_Produto
WHERE cliente.ID_Cliente = 2;


create view questao_12 as 
SELECT 
    'não vendidos' AS situação,
    p.Nome_Produto "Produto",
    p.Descricao,
    p.Preco,
    p.Tamanho,
    p.Cor,
    p.Marca,
    e.Quantidade

FROM 
    produto p
JOIN 
    estoque e ON p.ID_Produto = e.ID_Produto
LEFT JOIN 
    item_compra ic ON p.ID_Produto = ic.produto_ID_Produto
LEFT JOIN 
    compra c ON ic.compras_idcompras = c.idcompras 
        AND c.dataComp BETWEEN '2024-01-01' AND '2024-12-31'
WHERE 
    c.idcompras IS NULL 
    AND e.Quantidade > 0;
    
create view questao_13 as 
SELECT v.ID_Venda "Id da venda", p.Nome_Produto "Produto", iv.Quantidade , v.Data_Venda "Data da venda", concat("R$ ", format(v.Total_Venda, 2, "de_DE")) "Valor da Venda"
FROM loja.venda v
JOIN loja.item_venda iv ON v.ID_Venda = iv.ID_Venda
JOIN loja.produto p ON iv.ID_Produto = p.ID_Produto
WHERE v.Status_Entrega = 'Pendente';

create view questao_14 as 
SELECT c.Nome "Cliente", p.Nome_Produto "Produto", SUM(iv.Quantidade) "Quantidade comprada"
FROM loja.cliente c
JOIN loja.venda v ON c.ID_Cliente = v.ID_Cliente
JOIN loja.item_venda iv ON v.ID_Venda = iv.ID_Venda
JOIN loja.produto p ON iv.ID_Produto = p.ID_Produto
GROUP BY c.ID_Cliente, p.ID_Produto
ORDER BY SUM(iv.Quantidade) DESC;

create view questao_15 as 
SELECT v.ID_Venda "Id da venda", f.Nome "Funcionário", date_format(v.Data_Venda, "%d/%m/%Y") "Data da venda", concat("R$ ", format(v.Total_Venda, 2, "de_DE")) "Valor da Venda"
FROM loja.venda v
JOIN loja.funcionario f ON v.ID_Funcionario = f.ID_Funcionario
ORDER BY f.Nome, v.Data_Venda;

create view questao_16 as
SELECT 
    c.Nome_Categoria "Categoria", 
    p.Nome_Produto "Produto", 
    SUM(iv.Quantidade) "Quantidade Vendida", 
    CONCAT("R$ ", FORMAT(SUM(iv.Quantidade * p.Preco), 2, "de_DE")) "Receita Gerada"
FROM 
    loja.produto p
JOIN 
    loja.categoria c ON p.ID_Categoria = c.ID_Categoria
JOIN 
    loja.item_venda iv ON p.ID_Produto = iv.ID_Produto
GROUP BY 
    c.Nome_Categoria, p.Nome_Produto
ORDER BY 
    c.Nome_Categoria, SUM(iv.Quantidade) DESC;


create view questao_17 as
SELECT 
    v.ID_Venda "Id da venda", 
    date_format(v.Data_Venda, "%d/%m/%Y") "Data da venda", 
    c.Nome "Cliente", 
    p.Nome_Produto "Produto", 
    iv.Quantidade, 
    concat("R$ ", format(v.Total_Venda, 2, "de_DE")) "Valor da Venda"
FROM 
    loja.venda v
JOIN 
    loja.cliente c ON v.ID_Cliente = c.ID_Cliente
JOIN 
    loja.item_venda iv ON v.ID_Venda = iv.ID_Venda
JOIN 
    loja.produto p ON iv.ID_Produto = p.ID_Produto
WHERE 
    v.Data_Venda BETWEEN '2024-02-02' AND '2024-07-02' 
ORDER BY 
    v.Data_Venda;
    
  
create view questao_18 as  
    SELECT 
    c.Nome AS "Cliente", 
    p.Nome_Produto AS "Produto", 
    p.Marca, 
    SUM(iv.Quantidade) AS "Quantidade comprada", 
    CONCAT("R$ ", FORMAT(SUM(iv.Quantidade*v.Total_Venda), 2, "de_DE")) AS "Valor total das compras"
FROM 
    loja.cliente c
JOIN 
    loja.venda v ON c.ID_Cliente = v.ID_Cliente
JOIN 
    loja.item_venda iv ON v.ID_Venda = iv.ID_Venda
JOIN 
    loja.produto p ON iv.ID_Produto = p.ID_Produto
WHERE 
    p.Marca IN ('Nike', 'Puma')
GROUP BY 
    c.Nome, p.Nome_Produto, p.Marca
ORDER BY 
    SUM(v.Total_Venda) DESC;


create view questao_19 as  
SELECT 
    v.ID_Venda "Id da venda", 
    date_format(v.Data_Venda, "%d/%m/%Y") "Data da venda", 
    c.Nome "Cliente", 
    p.Nome_Produto "Produto", 
    iv.Quantidade, 
    concat("R$ ", format(v.Total_Venda, 2, "de_DE")) "Valor da venda", 
    concat("R$ ", format(v.Desconto, 2, "de_DE")) "Valor do desconto", 
    CONCAT(ROUND((v.Desconto / v.Total_Venda) * 100, 2), '%') "Percentual do desconto"
FROM 
    loja.venda v
JOIN 
    loja.cliente c ON v.ID_Cliente = c.ID_Cliente
JOIN 
    loja.item_venda iv ON v.ID_Venda = iv.ID_Venda
JOIN 
    loja.produto p ON iv.ID_Produto = p.ID_Produto
WHERE 
    (v.Desconto / v.Total_Venda) * 100 > "20" 
ORDER BY 
    "Percentual do desconto" DESC;
    

CREATE VIEW questao_20 AS
SELECT 
    c.Nome_Categoria "Categoria", 
    p.Nome_Produto "Produto", 
    SUM(iv.Quantidade) "Quantidade Vendida", 
    CONCAT("R$ ", FORMAT(SUM(iv.Quantidade * p.Preco), 2, "de_DE"))  "Receita Gerada"
FROM 
    loja.produto p
JOIN 
    loja.categoria c ON p.ID_Categoria = c.ID_Categoria
JOIN 
    loja.item_venda iv ON p.ID_Produto = iv.ID_Produto
GROUP BY 
    c.Nome_Categoria, p.Nome_Produto
ORDER BY 
    c.Nome_Categoria, SUM(iv.Quantidade) DESC;
