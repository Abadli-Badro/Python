drop table classement;
drop table competition;
drop table skieur;
drop table station;

--table creation
create table Station(
	namestat varchar2(20),
	altstat varchar2(20),
	country varchar2(20),
	capstat varchar2(20),
	Constraint pk_stat primary key(namestat)
);
create Table Skieur(
	nameski varchar2(20),
	speciality varchar2(20),
	namestat varchar2(20),
	Constraint pk_ski primary key(nameski),
	Constraint fk__skieur_stat foreign key(namestat) references Station(namestat) on delete cascade
);
create table competition(
	refcomp varchar2(20),
	datecomp date,
	namestat varchar(20),
	Constraint pk_comp primary key(refcomp),
	Constraint fk_comptetion_stat foreign key(namestat) references Station(namestat) on delete cascade
);
create table ranking(
	refcomp varchar2(20),
	nameski varchar2(20),
	rang integer,
	Constraint pk_cla primary key(refcomp, nameski),
	Constraint fk_ranking_nom foreign key(nameski) references Skieur(nameski) on delete cascade,
	Constraint fk_comp foreign key(refcomp) references competition(refcomp) on delete cascade
);


-- showing the name and constraint type for the table 'skieur'
select constraint_name,constraint_type  from user_constraints where table_name = 'SKIEUR';



-- inserting data
insert into station values('Mont Blanc','1000','France','100');
insert into station values('parloup','2000','France','200');
insert into station values('Mont','3000','France','300');

insert into skieur values('Lionel','skier','Mont Blanc');
insert into skieur values('Amine','descente','parloup');
insert into skieur values('Sylvain','skier','Mont Blanc');


insert into competition values('comp1',to_date('01/01/2019','dd/mm/yyyy'),'Mont Blanc');
insert into competition values('comp2',to_date('02/01/2019','dd/mm/yyyy'),'parloup');
insert into competition values('comp3',to_date('03/01/2019','dd/mm/yyyy'),'Mont Blanc');


insert into ranking values('comp2','Lionel',2);
insert into ranking values('comp2','Amine',3);
insert into ranking values('comp2','Sylvain',1);


--showing the participants names
select nameski from skieur;
--showing Lionel's ranking
select rang from ranking where nameski='Lionel';
--comp2 ranking with each particpant's station
select rang, namestat from skieur s ,ranking c where s.nameski= c.nameski and refcomp = 'comp2' order by rang;
