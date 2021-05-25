CREATE DATABASE HOSPITAL;
USE HOSPITAL;

CREATE TABLE pessoas(
pessoa_id int primary key auto_increment,
dataNasci date,
email varchar(50),
telefonePrincipal char(11),
CPF char(11)
);

CREATE TABLE pacientes(
paciente_id int primary key auto_increment,
nome varchar(50),
sintomas varchar(50),
convenio boolean,
altura float,
pressao varchar(5),
fk_pessoa_id int,
foreign key (fk_pessoa_id)references pessoas(pessoa_id) 
);

CREATE TABLE medicos(
medico_id int primary key auto_increment,
nome varchar(50),
fomacao varchar(50),
especializacao varchar(50),
CRM varchar(11),
cargaHoraria int,
fk_pessoa_id int,
foreign key (fk_pessoa_id) references pessoas(pessoa_id) 
);

CREATE TABLE medicosPacientes(
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE prontuarios(
observacao varchar(50),
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE consultas(
consulta_id int primary key auto_increment,
horaConsulta float,
tipoConsulta varchar(50),
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE setores(
setor_id int primary key auto_increment,
risco int, 
tipoSetor varchar(10),
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE exames(
exame_id int primary key auto_increment,
presente boolean,
tipoExame varchar(20),
jejum boolean,
horaExame int,
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE receitas(
receita_id int primary key auto_increment,
prescricao varchar(50),
fk_medico_id int,
fk_paciente_id int,
foreign key (fk_medico_id) references medicos(medico_id),
foreign key (fk_paciente_id) references pacientes(paciente_id)
);

CREATE TABLE medicamentos(
nome varchar(30),
quantidade int,
orientacao varchar(50),
fk_receita_id int,
foreign key (fk_receita_id) references receitas(receita_id)
);