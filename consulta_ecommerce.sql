-- drop --  	
-- select --
	SHOW TABLES;
	SELECT * FROM clientes;
	SELECT * FROM pedidos;
	SELECT * FROM itensPedidos;
	SELECT * FROM produtos; 
	SELECT * FROM entregas;
	SELECT * FROM pagamentos; 
	SELECT * FROM transportadoras;
	SELECT * FROM notaFiscal;

-- alter -- 
    ALTER TABLE pagamentos
    ADD constraint fk_itensPedidos_id 
    foreign key (fk_itensPedidos_id) REFERENCES itensPedidos(itensPedidos_id);
    alter table transportadoras
    drop column identificacao;
    insert into ECOMMERCE.pedidos (registro,fk_cliente_id, fk_itensPedidos_id)
    values ('h123', 1, 9);

-- Mentoria --
-- 4 Todos os pedidos feitos no primeiro e no último dia de cada mês --  
    select p.registro, pg.dataPagamento
	from pedidos p 
    inner join itensPedidos ip 	on ip.itensPedidos_id = p.fk_itensPedidos_id
    inner join pagamentos pg 	on (
    ip.itensPedidos_id = pg.fk_itensPedidos_id &&
    pg.pagamento_id = ip.fk_pagamento_id)
    where (
    day (pg.dataPagamento) = 01 ||
	day (pg.dataPagamento) = 31 && 
	(month(pg.dataPagamento) = 03 || month(pg.dataPagamento) = 05 || month(pg.dataPagamento) = 07 || month(pg.dataPagamento) = 08 || month(pg.dataPagamento) = 10 || month(pg.dataPagamento) = 12) ||
	day (pg.dataPagamento) = 30 && 
    (month(pg.dataPagamento) = 04 || month(pg.dataPagamento) = 06 || month(pg.dataPagamento) = 09 || month(pg.dataPagamento) = 11) ||
    day (pg.dataPagamento) = 28 && month(pg.dataPagamento) = 2)
	order by pg.dataPagamento; 

-- 5 Pedidos com valor total maior que 10.000 ordenados pelo valor total e pela data do pedido --
	select ip.itensPedidos_id, pg.valorPagamento, pg.dataPagamento
    from itensPedidos ip 
    inner join pagamentos pg on(
    pg.valorPagamento >= 1500 &&
    ip.fk_pagamento_id = pg.pagamento_id)
    order by pg.valorPagamento desc, pg.dataPagamento desc;

-- 6 O ranking dos 3 produtos mais vendidos por mês de cada ano --
	select month(pg.dataPagamento) as mes, pdt.modelo, count(modelo) as vendidos
    from produtos pdt
    inner join pagamentos pg
    inner join itensPedidos ip 	on pdt.produto_id = ip.fk_produto_id  && ip.itensPedidos_id = pg.fk_itensPedidos_id
    group by pdt.modelo , mes
    order by vendidos desc, mes limit 3;

-- 7 Os 5(3) nomes de clientes com o maior valor médio de pedidos realizados --
	select clientes.nomeCliente, count(*) as quant_pedidos
    from clientes 
    inner join pedidos on clientes.cliente_id = pedidos.fk_cliente_id 
    group by cliente_id 
    order by quant_pedidos desc limit 3; 

-- case use -- 
    -- Qual compra o cliente fez --
    select clientes.nomeCliente, produtos.*, pagamentos.*, entregas.*
    from   pedidos
    inner join clientes 	on clientes.cliente_id = pedidos.fk_cliente_id
    inner join itensPedidos on itensPedidos.itensPedidos_id = pedidos.fk_itensPedidos_id
	inner join produtos 	on produtos.produto_id = itensPedidos.fk_produto_id
    inner join pagamentos 	on pagamentos.pagamento_id = itensPedidos.fk_pagamento_id
    inner join entregas 	on entregas.entrega_id = itensPedidos.fk_entrega_id ;

    -- Como o cliente pagou a compra --
    select clientes.nomeCliente, pagamentos.*
    from pedidos
    inner join clientes 	on clientes.cliente_id = pedidos.fk_cliente_id
    inner join itensPedidos on itensPedidos.itensPedidos_id = pedidos.fk_itensPedidos_id 
	inner join pagamentos	on pagamentos.pagamento_id = itensPedidos.fk_pagamento_id;

    -- Quais produtos ele comprou --
    select clientes.nomeCliente,produtos.*
    from pedidos
    inner join clientes 	on clientes.cliente_id = pedidos.fk_cliente_id
    inner join itensPedidos on itensPedidos.itensPedidos_id = pedidos.fk_itensPedidos_id
    inner join produtos 	on produtos.produto_id = itensPedidos.fk_produto_id
    order by nomeCliente;

	-- Qual foi a entrega escolhida e qual transportadora --
    select clientes.nomeCliente, entregas.*, transportadoras.*
    from pedidos
    inner join clientes on clientes.cliente_id = pedidos.fk_cliente_id
    inner join itensPedidos on itensPedidos.itensPedidos_id = pedidos.fk_itensPedidos_id
    inner join entregas on entregas.entrega_id = itensPedidos.fk_entrega_id
    inner join transportadoras on transportadoras.transportadora_id = entregas.fk_transportadora_id
    order by nomeCliente;