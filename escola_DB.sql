CREATE DATABASE ESCOLA;
USE ESCOLA;

CREATE TABLE pessoa(
	pessoa_id int primary key auto_increment,
	nome varchar(30) not null,
	dataNasc date,
	email varchar(40),
	cpf varchar(11) not null
);

CREATE TABLE aluno(
	aluno_id int primary key  auto_increment,
	curso varchar(50),
	RA int,
	periodo int,
	fk_pessoa_id int,
	fk_turma_id int,
	foreign key (fk_pessoa_id) references pessoa (pessoa_id),
	foreign key (fk_turma_id) references turma(turma_id)
);

CREATE TABLE professor(
	professor_id int primary key auto_increment,
	registro int,
	formacao varchar(50),
	fk_pessoa_id int,
	fk_disciplina_id int,
	foreign key (fk_pessoa_id) references pessoa(pessoa_id),
	foreign key (fk_disciplina_id) references disciplina(disciplina_id)
);

CREATE TABLE professorTurma(
	fk_professor_id int,
	fk_turma_id int,
	foreign key (fk_professor_id) references professor(professor_id),
	foreign key (fk_turma_id) references turma(turma_id)
);

CREATE TABLE turma(
	turma_id int primary key  auto_increment,
	numeroTurma char(4),
	codPeriodoTurma int,
	quantidadeAluno int
);

CREATE TABLE alunoDisciplina(
	fk_aluno_id int,
	fk_disciplina_id int,
	foreign key (fk_aluno_id) references aluno(aluno_id),
	foreign key (fk_disciplina_id) references disciplina(disciplina_id)
);

CREATE TABLE avaliacao(
	avaliacao_id int primary key auto_increment,
	nomeProva varchar(50),
	inicioprova int,
	fimProva int,
	nota int,
	fk_turma_id int,
	fk_aluno_id int,
	fk_disciplina_id int,
	foreign key (fk_aluno_id) references aluno(aluno_id),
	foreign key (fk_disciplina_id) references disciplina(disciplina_id),
	foreign key (fk_turma_id) references turma(turma_id)
);

CREATE TABLE disciplina(
	disciplina_id int primary key auto_increment,
	nomeDisciplina varchar(50),
	cargaHoraria int
);