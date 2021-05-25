CREATE DATABASE ECOMMERCE;
USE  ECOMMERCE;

CREATE TABLE clientes (
	cliente_id int primary key auto_increment,
	nomeCliente varchar(50),
	dataNascimento date, 
	telefonePrincipal char(11),
	CPF_Cliente char(11),
	emailCliente varchar(50),
	senha varchar(50) 
);

CREATE TABLE pedidos (
	registro varchar(10),
	fk_cliente_id int,
	fk_itensPedidos_id int,
	foreign key (fk_cliente_id) references clientes(cliente_id),
	foreign key (fk_itensPedidos_id) references itensPedidos(itensPedidos_id)
);

CREATE TABLE itensPedidos(
	itensPedidos_id int primary key auto_increment,
	observacao varchar(50),
	fk_produto_id int,
	fk_entrega_id int,
	fk_pagamento_id int,
	foreign key(fk_produto_id)references produtos(produto_id),
	foreign key(fk_entrega_id)references entregas(entrega_id),
	foreign key(fk_pagamento_id)references pagamentos(pagamento_id)
);
drop table pagamentos;
CREATE TABLE pagamentos(
	pagamento_id int primary key auto_increment,
	valorPagamento int,
	dataPagamento date,
	tipoPagamento varchar(30),
	confirmacao boolean 
);

CREATE TABLE entregas(
	entrega_id int primary key auto_increment,
	dataPrevista date,
	codRastrioProd int,
	dataEntrega date,
	enderecoEntrega varchar(50),
	tipoEntrega int,
	fk_transportadora_id int,
	foreign key (fk_transportadora_id) references transportadoras(transportadora_id)
);

CREATE TABLE transportadoras (
	transportadora_id int primary key auto_increment,
	nomeTransportadora varchar(50),
	tipoCarga int,
	telefoneTransportadora char (11),
	identificacao int,
	emailTransportadora varchar(50)
);

CREATE TABLE produtos (
	produto_id int primary key auto_increment,
	modelo varchar(50),
	pesoProduto int,
	quantidade int,
	preco int,
	dimensao int,
	fk_notaFiscal_id int,
	foreign key(fk_notaFiscal_id)references notaFiscal(notaFiscal_id) 
);

CREATE TABLE notaFiscal(
	notaFiscal_id int primary key auto_increment,
	prestador varchar (50),
	valorServico int,
	imposto int,
	valorNota int,
	informacaoAdicional varchar(50)
);