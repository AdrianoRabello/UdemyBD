use sisaqua;
desc ocorrencia;
select now() as dataAtual;
select * from ocorrencia where idAtendimento = idAtendimento;
select count(idAtendimento),nomeVitima from ocorrencia group by idAtendimento;
SELECT a.descricao, count(a.descricao), o.complemento as qtd FROM ocorrencia o join usuario u on o.idUsuario = u.idUsuario join municipio m on o.idMunicipio = m.idMunicipio join atendimento a on o.idAtendimento = a.idAtendimento join cargo c on u.idCargo = c.idCargo
			 join postosgv p on o.idPosto = p.idPosto WHERE o.idAtendimento = 2;
select * from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento;
select IFNULL(o.complemento, 'dasd'), o.idOcorrencia from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento;
select count(o.idAtendimento) as qtd, a.descricao from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento group by o.idAtendimento;

create view view_relatorio as select count(o.idAtendimento) as qtd,a.descricao from ocorrencia o join atendimento a on o.idAtendimento = a.idAtendimento group by o.data;

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



update vendedores set janeiro = 121000.15,fevereiro = 103100.15, marco = 111000.15 where idvendedor = 4;
/*avg max min sum  sessão 10 aula 35 */

use udemy_sql;
select * from vendedores;
select max(fevereiro) as maiorvalor from vendedores;
select min(fevereiro) as maiorvalor from vendedores;
select avg(fevereiro) as media_fevereiro from vendedores;
select truncate(avg(fevereiro),2) as media_fevereiro from vendedores; /*truncate(numero,qunatidade de cadas decimais)*/
select sum(janeiro)as total_janeiro,sum(fevereiro)as total_fev,sum(marco)as total_mar from vendedores;
select sexo,sum(marco) as total_marco from vendedores group by sexo;




/*subqueryes sessão 11*/

select nome,min(marco) from vendedores;
/*realiza uma progeção da subquery para poder pegar o nome do vendedor que vendey menos no mes de marco*/
select nome, marco from vendedores where marco = (select min(marco) from vendedores);
select nome, marco from vendedores where marco = (select max(marco) from vendedores);
select avg(marco) from vendedores;
select avg(fevereiro) from vendedores;
select nome, marco from vendedores where marco = (select avg(marco) from vendedores);
select nome, marco from vendedores where marco < (select avg(marco) from vendedores);
select nome, marco from vendedores where marco > (select avg(marco) from vendedores);
select nome, fevereiro from vendedores where fevereiro > (select avg(fevereiro) from vendedores);
/*a inner wuery tem que bater o numero de coluna junto com o filtro ou seja o where*/
select nome, fevereiro from vendedores where fevereiro < (select avg(fevereiro) from vendedores);

/* somando linhas */
select nome, janeiro, fevereiro, marco, truncate((janeiro+fevereiro+marco),2) as "total" , truncate((janeiro+fevereiro+marco)/3,2) as "MEDIA" from vendedores; /*Não exiset funções para somar linha tem que somar as colunas*/



/* SESSÃO 12 */

use udemy_sql;
desc vendedores;


create table tabela (
Coluna1 int(11) PRIMARY KEY AUTO_INCREMENT);


/* alterando tabela */

alter table tabela add column coluna2 int;
desc tabela;
alter table tabela modify coluna2 date not null;
alter table tabela rename pessoa;

/* erificando as chaves de uma tabela */

show create table pessoa;


/* padrão de criação de tabelas com chave estrangeira


** devemos seguir esse padrão pois assim conseguimos colocar o nome que quizermos na chave estrangeira 
*/

create table cliente(
idcliente int,
nome varchar(30));


create table telefone(
idtelefone int,
tipo char(3) not null,
numero varchar(10) not null,
id_cliente int);


alter table cliente add constraint PK_CLIENTE primary key (idcliente);

alter table telefone add constraint FK_CLIENTE_TELEFONE foreign key (ID_CLIENTE) references cliente(idcliente);
show create table telefone;
/*dropa a chave estrangeura da tabela telefone*/
alter table telefone drop foreign key FK_CLIENTE_TELEFONE; 



/*
	INTRODUÇÃO A TRIGER 
	
    TRIGUER é um gatilho para disparar uma ação no banco de dados 
    para fazer uma trigguer temos que mudar o delimitador, ou seja declarar delimiter $
    Não podemos colocar duas trigger monitrando um comando na mesma tabela
    
    Quando estamos criado uma trigger temos os conceitos de new e old
    new é o regitro novo que esta entradno na tabla 
    old é o registro velho da tabela 
    
    Temos essa divisão pois podemos relizar ações com trigger antes ou depois que uma ação é realizada, 
    por esse motivo, temos que definir qual registro queremos utilizar na trigger
*/


/*
estrutura de criação de triger
create trigger nome
before/after insert/delete/update on tabela
for each row (para cada linha)
begin -> inicio



end -> fim */

create table usuario(
idusuario int primary key auto_increment,
nome varchar(30),
login varchar(30),
senha varchar(100)
);
    
    
    
create table bkp_usuario(
idbackup int primary key auto_increment,
idusuario int,
nome varchar(30),
login varchar(30)
);



/*Ao criar essa trigger toda vez que realizar um delete da tabela usuario iremos realizar um inser na tabela de backup*/
 delimiter $
create trigger backup_user
before delete on usuario
for each row
begin
	insert into bkp_usuario values(NULL,old.idusuario,old.nome,old.login);
END 
$
delimiter ;


insert into usuario value(NULL,'adriano','adriano.rabello','123456');
drop trigger backup_user;
show tables;
desc usuario;
select * from usuario;
select * from bkp_usuario;
delete from usuario where idusuario = 4;





















