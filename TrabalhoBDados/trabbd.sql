create table Iris(
	sepal_length decimal(2,1),
	sepal_width decimal(2,1),
	petal_length decimal(2,1),
	petal_width decimal(2,1),
	species varchar(30)
);

COPY Iris FROM 'C:\Dataset_Iris.csv' USING DELIMITERS ',';

create table Iris_Normalizada(
	codigo serial,
	sepal_length decimal(4,3),
	sepal_width decimal(4,3),
	petal_length decimal(4,3),
	petal_width decimal(4,3)
);

create table Centroids (
	codigo serial,
	id_centroid int
);

create table Distancia(
	--codigo serial, --- codigo para diferenciar cada dado
	codigo int,
	distancia decimal(4,3), --- armazena a distancia em relação ao centroide do grupo
	x decimal(4,3), --- atributo length
	w decimal(4,3), --- atributo length
	y decimal(4,3), --- atributo width
	z decimal(4,3), --- atributo width
	grupo int --- grupo no qual tem a distancia do dado a esse centroide
);

create table Distancia2(
	--codigo serial, --- codigo para diferenciar cada dado
	codigo int,
	distancia decimal(4,3), --- armazena a distancia em relação ao centroide do grupo
	x decimal(4,3), --- atributo length
	w decimal(4,3), --- atributo length
	y decimal(4,3), --- atributo width
	z decimal(4,3), --- atributo width
	grupo int --- grupo no qual tem a distancia do dado a esse centroide
);

create table MenorDistancia(
	codigo int, --- codigo para diferenciar cada dado
	distancia decimal(4,3), --- armazena a menor distancia em relação ao centroide do grupo
	x decimal(4,3), --- atributo length
	w decimal(4,3), --- atributo length
	y decimal(4,3), --- atributo width
	z decimal(4,3), --- atributo width
	grupo int --- grupo ao qual tem a menor distancia do centroide
);
create table soma(
	codigo int,
	soma float,
	grupo int
);
--drop table MenorDistancia;
----- Função que faz a normalização dos dados Iris ------
create or replace function Normalizacao_DataIris(tupla Iris) returns text as $$
declare
	minimo Iris%ROWTYPE;
	maximo Iris%ROWTYPE;

begin

	select min(I.sepal_length),min(I.sepal_width),min(I.petal_length),min(I.petal_width) into minimo from Iris I;
	select max(I.sepal_length),max(I.sepal_width),max(I.petal_length),max(I.petal_width) into maximo from Iris I;

	insert into Iris_Normalizada values(default,
				(((tupla.sepal_length-minimo.sepal_length)/(maximo.sepal_length-minimo.sepal_length))*(1-0)+0),
			    (((tupla.sepal_width-minimo.sepal_width)/(maximo.sepal_width-minimo.sepal_width))*(1-0)+0),
			    (((tupla.petal_length-minimo.petal_length)/(maximo.petal_length-minimo.petal_length))*(1-0)+0),
			    (((tupla.petal_width-minimo.petal_width)/(maximo.petal_width-minimo.petal_width))*(1-0)+0));
			    
	return (((tupla.sepal_length-minimo.sepal_length)/(maximo.sepal_length-minimo.sepal_length))*(1-0)+0) || ' - ' ||
			    (((tupla.sepal_width-minimo.sepal_width)/(maximo.sepal_width-minimo.sepal_width))*(1-0)+0) || ' - ' ||
			    (((tupla.petal_length-minimo.petal_length)/(maximo.petal_length-minimo.petal_length))*(1-0)+0) || ' - ' ||
			    (((tupla.petal_width-minimo.petal_width)/(maximo.petal_width-minimo.petal_width))*(1-0)+0) ;
end;
$$ language plpgsql;

--select Normalizacao_DataIris(Iris.*) from Iris;

CREATE FUNCTION Pnt_Randon (qtd_clusters int) returns void as $$
declare 
	x int;
	i int;
BEGIN

ALTER SEQUENCE Centroids_codigo_seq RESTART WITH 1;

for i in 1..qtd_clusters

loop
	x := floor(random()*(150-1+1))+1;
	
	insert into Centroids (id_centroid) values (x);
		
end loop;
END;
$$ LANGUAGE 'plpgsql';

create or replace function Distancia(qtd_clusters int) returns void as $$
declare
	tupla RECORD;
	tupla_centroid RECORD;
	
	d float;
	i int;
begin

	for i in 1..qtd_clusters loop

	select sepal_length, sepal_width, petal_length,petal_width into tupla_centroid
		from Iris_normalizada 
			where codigo = (select id_centroid from Centroids where codigo = i);
	--select codigo from iris_normalizada;
		for tupla in select * from Iris_Normalizada loop

			d:= sqrt(power(tupla.sepal_length - tupla_centroid.sepal_length,2) +
						power(tupla.sepal_width - tupla_centroid.sepal_width,2) +
						power(tupla.petal_length - tupla_centroid.petal_length,2) + 
					 	power(tupla.petal_width - tupla_centroid.petal_width,2));

			insert into Distancia values (tupla.codigo,d,tupla.petal_length,tupla.petal_width,
										  tupla.sepal_length,tupla.sepal_width,i);
			
		end loop;
	end loop;
	
end;

$$ language plpgsql;

create or replace function Clustering(qtd_clusters int) returns void as $$
declare
	aux RECORD;
	
	i int;
	
begin
		
	for i in 1..150  loop

		select codigo,distancia,x,w,y,z,grupo into aux
			from distancia
				where distancia = (select min(distancia) from Distancia where codigo = i) and codigo = i ;
				
				insert into Distancia2(codigo,distancia,x,w,y,z,grupo)
				values(aux.codigo,aux.distancia,aux.x,aux.w,aux.y,aux.z,aux.grupo);
			
	end loop;
end;

$$ language plpgsql;

create or replace function Menor_Distancia(qtd_clusters int) returns void as $$
declare
	tupla RECORD;
	tupla_c RECORD;
		
	d float;
	i int;
begin
	
		for tupla in select * from distancia2 loop
			
			for tupla_c in select * from distancia2 loop

			d:= sqrt(power(tupla.x - tupla_c.x,2) +
						power(tupla.w - tupla_c.w,2) +
						power(tupla.y - tupla_c.y,2) + 
					 	power(tupla.z - tupla_c.z,2));

			insert into MenorDistancia values (tupla.codigo,d,tupla.x,tupla.w,
										  tupla.y,tupla.z,tupla.grupo);
			end loop;
	end loop;
		
end;
$$ language plpgsql;

create or replace function Suma(qtd_clusters int) returns void as $$
declare
	sm RECORD;
	tupla_c RECORD;
	fb float;
	ff record;
		
	d float;
	i int;
begin
	for i in 1..150  loop 
	
	select sum(distancia) into fb from MenorDistancia where codigo = i;
	select codigo,grupo into sm from MenorDistancia where codigo = i group by codigo,grupo;

	insert into soma values (sm.codigo,fb,sm.grupo);
	end loop;
	
	delete from centroids;
	ALTER SEQUENCE Centroids_codigo_seq RESTART WITH 1;

	for i in 1..qtd_clusters  loop
	
		select codigo,soma,grupo into ff from soma where grupo = i and soma = (select min(soma) from soma where grupo = i);
		
		insert into centroids values (default,ff.codigo);
		
	end loop;
	
end;
$$ language plpgsql;
-----------
select Normalizacao_DataIris(Iris.*) from Iris;

--select * from iris_normalizada;

select Pnt_Randon(3);

select * from Centroids;
-----------

select Distancia(3);

select * from distancia;
-----------
--DELETE FROM distancia;
--drop table if exists distancia2,ff,soma,x,distancia, iris_normalizada, centroids,aux,menordistancia,px,iris;
--drop function if exists  Clustering(qtd_clusters int),Suma(qtd_clusters int),Menor_Distancia(qtd_clusters int),clustering(),Distancia(qtd_clusters int),Normalizacao_DataIris(tupla Iris),Pnt_Randon (qtd_clusters int);
-----------

select Clustering(3);

select * from distancia2;
-----------
select Menor_Distancia(3);
select * from MenorDistancia order by codigo;
-----------		
select suma(3);
select * from soma
select * from centroids;
--delete from menordistancia