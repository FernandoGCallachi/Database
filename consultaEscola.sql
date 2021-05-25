-- drop --  
/*	drop database ESCOLA;
	drop table pessoa;
	drop table aluno;
	drop table professor;
	drop table turma;
	drop table avaliacao;
	drop table disciplina;
	drop table professorTurma; */

-- select --
	SHOW TABLES;
	SELECT * FROM pessoa;
	SELECT * FROM aluno;
	SELECT * FROM professor;
	SELECT * FROM professorTurma;
	SELECT * FROM turma;
	SELECT * FROM alunoDisciplina;
	SELECT * FROM avaliacao;
	SELECT * FROM disciplina;

-- alter -- 
    INSERT INTO professorTurma (fk_professor_id, fk_turma_id)
    VALUES (1 , 1);
    INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (1 , 2);
    INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (1 , 3);
    INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (2 , 1);
	INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (2 , 3);
	INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (3 , 1);
	INSERT INTO escola.professorTurma (fk_professor_id, fk_turma_id)
    VALUES (4 , 2);
	INSERT INTO escola.alunoDisciplina (fk_aluno_id, fk_disciplina_id)
    VALUES (9 , 4);
    
-- Mentoria --
-- 2 Os melhores alunos por média de nota de cada disciplina --
   select p.nome as nome_aluno, dc.nomeDisciplina, avg(av.nota) as nota 
   from pessoa p 
   inner join aluno al 		     	on p.pessoa_id = al.fk_pessoa_id
   inner join alunoDisciplina ad 	on al.aluno_id = ad.fk_aluno_id 
   inner join avaliacao av 			on al.aluno_id = av.fk_aluno_id 
   inner join disciplina dc 		on (
   dc.disciplina_id = ad.fk_disciplina_id &&
   dc.disciplina_id = av.fk_disciplina_id)
   group by nome_aluno, dc.nomeDisciplina
   order by nota desc;

-- 3 Todas as turmas cadastradas separadas por disciplina e o nome do professor --     
	select t.turma_id, d.nomeDisciplina, (p.nome)as nomeProfesor 
    from disciplina d 
    inner join professor pf 	on pf.fk_disciplina_id = d.disciplina_id
    inner join pessoa p 		on p.pessoa_id = pf.fk_pessoa_id
	inner join professorTurma pt on pf.professor_id = pt.fk_professor_id	
    inner join turma t 			on t.turma_id = pt.fk_turma_id
    order by p.nome, d.nomeDisciplina;
    
-- case use -- 
-- Aluno --
	-- Informações do aluno especifico --
		select  pessoa.*, aluno.curso, aluno.RA, aluno.periodo
        from pessoa join aluno
        on pessoa.pessoa_id = aluno.fk_pessoa_id &&
		aluno.RA = 2388216;
         
	-- Aluno faz qual curso --
		select pessoa.nome, aluno.curso, aluno.RA 
        from pessoa join aluno 
		on pessoa.pessoa_id = aluno.fk_pessoa_id;
        
    -- Aluno está em qual turma --   
		select pessoa.nome, aluno.RA, turma.numeroTurma 
        from  aluno join pessoa join  turma 
        on aluno.fk_turma_id = turma.turma_id && 
        pessoa.pessoa_id = aluno.fk_pessoa_id;
        
    -- Qual a nota que o aluno tirou na prova --    
		select pessoa.nome, disciplina.nomeDisciplina, avaliacao.nota
        from pessoa join disciplina join avaliacao join aluno
		on avaliacao.fk_disciplina_id = disciplina.disciplina_id &&
        pessoa.pessoa_id = aluno.fk_pessoa_id &&
        aluno.aluno_id = avaliacao.fk_aluno_id;
       
	-- Aluno tem quais disciplinas --   
		select pessoa.nome, disciplina.nomeDisciplina
        from pessoa join disciplina join aluno join alunoDisciplina 
        on pessoa.pessoa_id = aluno.fk_pessoa_id &&
        aluno.aluno_id = alunoDisciplina.fk_aluno_id &&
        disciplina.disciplina_id = alunoDisciplina.fk_disciplina_id;
  
-- Professor -- 
	-- Infomações do professor -- 
		select pessoa.*, professor.professor_id, professor.registro, professor.formacao,
		disciplina.nomeDisciplina from  pessoa join professor join disciplina
		on  pessoa.pessoa_id = professor.fk_pessoa_id  &&
        disciplina.disciplina_id = professor.fk_disciplina_id &&		  
		pessoa.nome = "jhony";
            
	-- Professor da aula para qual turma --
       select pessoa.nome, professorTurma.fk_turma_id
       from pessoa join professorTurma join professor join turma
       on pessoa.pessoa_id = professor.fk_pessoa_id  &&
       turma.turma_id = professorTurma.fk_turma_id &&
       professor.professor_id = professorTurma.fk_professor_id;
	       					
    -- Professor da qual diciplina -- 
        select pessoa.nome, professor.registro, disciplina.nomeDisciplina
        from pessoa join professor join disciplina
        on pessoa.pessoa_id = professor.fk_pessoa_id &&
        disciplina.disciplina_id = professor.fk_disciplina_id;