-- Comandos DML (UPDATE/DELETE)

SET SQL_SAFE_UPDATES = 0;

delete from fornecedor_compra 
	where fornecedor_cnpj = '07.890.123/0001-07';

update fornecedor_compra 
	set Quantidade = 15 
	where fornecedor_cnpj = '01.234.567/0001-01'
		and compras_idcompras between 1 and 10;
  
update estoque
	set Quantidade = 120, Data_Saida = '2024-03-01'
		where ID_Produto = 10;

update produto
	set Cor = "Vermelho"
		where Cor = "Verde";

update loja.funcionario
	set Cargo = 'Supervisor'
		where Nome = 'Bruno Costa';

update produto 
	set Nome_Produto = "Camiseta"
		where ID_Categoria = 1;
        
update categoria 
	set Nome_Categoria = "Calça"
		where ID_Categoria = 2;
        
update categoria 
	set Nome_Categoria = "Casaco"
		where ID_Categoria = 3;
        
update categoria 
	set Nome_Categoria = "Sapato"
		where ID_Categoria = 4;
        
update categoria 
	set Nome_Categoria = "Acessório"
		where ID_Categoria = 5;
        
update categoria 
	set Nome_Categoria = "Roupa Esportiva"
		where ID_Categoria = 6;
        
update categoria 
	set Nome_Categoria = "Roupa Casual"
		where ID_Categoria = 7;
        
update categoria 
	set Nome_Categoria = "Roupa Formal"
		where ID_Categoria = 8;
        
update categoria 
	set Nome_Categoria = "Roupa de Inverno"
		where ID_Categoria = 9;

update categoria 
	set Nome_Categoria = "Roupa de Verão"
		where ID_Categoria = 10;

update venda
	set Status_Entrega = "Entregue"
		where Status_Entrega = "Pendente"
			and timestampdiff(month, Data_Venda, now()) > 1;
		
delete from venda
	where ID_Funcionario IN (3, 6, 9)
		and Data_Venda between '2024-01-01' and '2024-02-01';

-- Atribui à varável "media_quantidade" o resultado da média da quantidade
set @media_quantidade = (SELECT AVG(Quantidade) FROM item_compra);
-- deleta da tabela "item_compra" se a quantidade de compras for menor que a média
delete from item_compra
where Quantidade < @media_quantidade;


update compra
	set desconto = 0.5*valorFrete
		where valorFrete > (select avg(valorFrete));
        
update promocao
	set Desconto_Percentual = 50.00
		where ID_Promocao = 4;
        
delete from venda 
	where Status_Entrega = "Cancelada" 
		and ID_Funcionario in (1,4,9);

update produto
	set Nome_Produto = "Calça"
		where ID_Categoria = 2;
        
update produto
	set Nome_Produto = "Casaco"
		where ID_Categoria = 3;
        
update produto
	set Nome_Produto = "Sapato"
		where ID_Categoria = 4;
        
update produto
	set Nome_Produto = "Acessório"
		where ID_Categoria = 5;
        
update produto
	set Nome_Produto = "Roupa Esportiva"
		where ID_Categoria = 6;

update produto
	set Nome_Produto = "Roupa Casual"
		where ID_Categoria = 7;
        
update produto
	set Nome_Produto = "Roupa Formal"
		where ID_Categoria = 8;

update produto
	set Nome_Produto = "Roupa De Inverno"
		where ID_Categoria = 9;
        
update produto
	set Nome_Produto = "Roupa De Verão"
		where ID_Categoria = 10;