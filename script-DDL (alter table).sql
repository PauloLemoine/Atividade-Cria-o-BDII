drop database loja;
-- Destruindo todas as tabelas
drop table categoria, cliente, produto, estoque, fornecedor, funcionario, 
venda, item_venda, promocao, compras, item_compra, fornecedor_compra, endereco;

-- Comandos DDL- Alterando tabelas:
alter table produto
	change Valor Preco DECIMAL(10,2) not null;
    
desc produto;
alter table cliente
	add pontuacao int default null;
    
alter table compras 
	rename to compra;
    
alter table venda
	add LocalVenda text;

alter table venda
	drop column LocalVenda;
    
alter table cliente
	drop column pontuacao;

alter table cliente
	modify Nome VARCHAR(100) not null;
    
alter table item_compra
	change qtd Quantidade int(11);
    
alter table item_compra
	modify Quantidade int(11) not null;