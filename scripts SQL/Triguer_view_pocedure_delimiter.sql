use sisaqua;
desc ocorrencia;
select now() as dataAtual;
select * from ocorrencia where idAtendimento = idAtendimento;
select count(idAtendimento),nomeVitima from ocorrencia group by idAtendimento;
SELECT a.descricao, count(a.descricao), o.complemento as qtd FROM ocorrencia o join usuario u on o.idUsuario = u.idUsuario join municipio m on o.idMunicipio = m.idMunicipio join atendimento a on o.idAtendimento = a.idAtendimento join cargo c on u.idCargo = c.idCargo
			 join postosgv p on o.idPosto = p.idPosto WHERE o.idAtendimento = 2;
select * from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento;
select IFNULL(o.complemento, 'dasd'), o.idOcorrencia from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento;
select count(o.idAtendimento) as qtd,a.descricao from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento group by o.idAtendimento;

create view view_relatorio as select count(o.idAtendimento) as qtd,a.descricao from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento group by o.idAtendimento;

select * from view_relatorio order by descricao;
select qtd from view_relatorio;

show tables;

drop view relatorio;

/* para criar um delimitador */
delimiter $
create procedure conta()
begin 
	select 10 + 10 "conta";
end
$
delimiter ;


/*para chamr uma procedure */
call conta;

/* para dropar um procedure */
drop procedure conta;




/* procedure com parametro */

delimiter $
create procedure conta(numero1 int, numero2 int)
begin 
	select numero1 + numero2 "caraca";
end
$
delimiter ;

call conta(50, 30);


create database udemy_sql;
use udemy_sql;
create table cursos(
	idcurso int primary key auto_increment,
    nome varchar(30) not null,
    horas int(3) not null,
    valor float(10,2) not null
);


delimiter $
create procedure cad_curso(p_nome varchar(30),p_horas int(3), p_preco float(10,2))
begin
	insert into cursos values(null, p_nome, p_horas, p_preco);
    end
    $
    delimiter ;
    
call cad_curso('sql','35',200.00);

call cad_curso('php','99',500.00);


select * from cursos;


delimiter $
create procedure sel_curso()
begin
	select idcurso, nome, horas, valor from cursos;
    end
    $
delimiter ;
    

call sel_curso();









