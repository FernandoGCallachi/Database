-- drop --
  /*drop table pacientes;
	drop table medicos;
	drop table medicosPacientes;
	drop table prontuarios;
	drop table consultas;
	drop table setores;
	drop table exames;
	drop table receitas;
	drop table medicamentos;*/ 
-- select --
	SHOW TABLES;
    
	SELECT * FROM pessoas;
    SELECT * FROM pacientes;
	SELECT * FROM medicos;
    SELECT * FROM medicosPacientes;
    SELECT * FROM prontuarios;
    SELECT * FROM consultas;
    SELECT * FROM setores;
    SELECT * FROM exames;
    SELECT * FROM receitas;
    SELECT * FROM medicamentos;
    
-- alter --    
	insert into HOSPITAL.medicosPacientes (fk_medico_id, fk_paciente_id)
	VALUES (1 , 4);
    insert into HOSPITAL.medicosPacientes (fk_medico_id, fk_paciente_id)
    VALUES (2 , 3);
    insert into HOSPITAL.medicosPacientes (fk_medico_id, fk_paciente_id)
    VALUES (3 , 2);
	insert into HOSPITAL.medicosPacientes (fk_medico_id, fk_paciente_id)
    VALUES (4 , 1);
    insert into HOSPITAL.medicosPacientes (fk_medico_id, fk_paciente_id)
    VALUES (4 , 2);
   
	insert into HOSPITAL.prontuarios(observacao, fk_medico_id, fk_paciente_id)
	VALUES ('exemplo observacao', 1, 4);
    insert into HOSPITAL.prontuarios(observacao, fk_medico_id, fk_paciente_id)
	VALUES ('exemplo observacao', 2, 3);
    insert into HOSPITAL.prontuarios(observacao, fk_medico_id, fk_paciente_id)
	VALUES ('exemplo observacao', 3, 2);
    insert into HOSPITAL.prontuarios(observacao, fk_medico_id, fk_paciente_id)
	VALUES ('exemplo observacao', 4, 1);
	select * from medicamentos;
    insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('dorflex', 2, 'orientação...', 1);
    insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('rivotril', 1, 'orientação...', 2);
    insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('loratadina', 1, 'orientação...', 3);
    insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('loratadina', 1, 'orientação...', 4);
	insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('xelfrod', 1, 'orientação...', 5);
	insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('xelfrod', 1, 'orientação...', 6);
	insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('xelfrod', 1, 'orientação...', 7);
	insert into HOSPITAL.medicamentos(nome, quantidade, orientacao, fk_receita_id)
	VALUES ('dorflex', 1, 'orientação...', 8);
    alter table consultas add column data_consulta date;
    
-- MENTORIA --    
-- 8 O total de consultas realizadas de cada paciente--
	select p.nome, count(*) as total_de_consultas
    from consultas c
    join pacientes p
    on p.paciente_id = c.fk_paciente_id
    group by fk_paciente_id;

-- 9 O nome do paciente e as datas de consulta mais recente e mais antiga --
    select p.nome, min(c.data_consulta) as antiga, max(c.data_consulta) as recente
    from pacientes  p
    inner join consultas c
    on p.paciente_id = c.fk_paciente_id
    group by paciente_id;
    
-- 10 O medicamento receitado mais vezes por cada médico --
	select  medicos.nome as medico, medicamentos.nome as medicamento, count(*) as quantidade 
    from medicos 
    inner join receitas r 	on medicos.medico_id = r.fk_medico_id
    inner join medicamentos on medicamentos.fk_receita_id = r.receita_id
    group by medicamento, medico 
    order by quantidade desc ; 
    
-- filter case use -- 
-- O paciente foi atendido por qual medico?--
	select medicosPacientes.fk_medico_id, medicos.nome, medicosPacientes.fk_paciente_id,  pacientes.nome
	from  pacientes join medicos join  medicosPacientes
	on medicos.medico_id = medicosPacientes.fk_medico_id &&
	pacientes.paciente_id = medicosPacientes.fk_paciente_id ;

-- Quais pacientes fizeram exames--
	select pacientes.nome,exames.presente, exames.tipoExame, exames.jejum, exames.horaExame
	from pacientes join exames
	on exames.fk_paciente_id = pacientes.paciente_id;

-- Quais fizeram consultas --
	select pacientes.nome, consultas.horaConsulta, consultas.tipoConsulta
	from pacientes join consultas
	on consultas.fk_paciente_id = pacientes.paciente_id;

-- Quais pacientes estavam no setor --
	select pacientes.nome, setores.risco, setores.tipoSetor
	from pacientes join setores
	on setores.fk_paciente_id = pacientes.paciente_id;

-- O medico fez o prontuario de quais pacientes?--
	select medicos.nome , prontuarios.observacao , pacientes.nome
	from medicos join prontuarios join pacientes
	on prontuarios.fk_medico_id = medicos.medico_id &&
	prontuarios.fk_paciente_id = pacientes.paciente_id;

-- Quais receitas o medico indicou para o paciente--
	select medicos.nome , prontuarios.observacao , pacientes.nome
	from medicos join prontuarios join pacientes
	on prontuarios.fk_medico_id = medicos.medico_id &&
	prontuarios.fk_paciente_id = pacientes.paciente_id