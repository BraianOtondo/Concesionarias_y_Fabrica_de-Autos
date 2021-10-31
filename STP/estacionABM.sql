DELIMITER $$
CREATE FUNCTION traerUltimoIdEstacion() RETURNS int DETERMINISTIC begin
declare cant int;
select cantEstacion() into cant;
if(cant<>0)then
SELECT MAX(id_estacion) AS id FROM estacion into cant;
end if;
return cant;
end $$
DELIMITER ;
DELIMITER $$
create function cantEstacion()returns int deterministic begin
declare cant int default 0;
select count(*) into cant from estacion;
return cant;
end $$
DELIMITER ;
DELIMITER $$
create procedure agregarEstacion(in _id_estacion int,in _id_linea int, out mensaje varchar(100),out resultado int)begin
declare cantidadRepetida int default 0;
declare cantidadRepetidaEstacion int default 0;
declare existe boolean;
-- declare CantidadPrimero boolean;
-- select count(*) 
select count(*) into cantidadRepetidaEstacion from estacion where id_estacion=_id_estacion;-- estacion 
select count(*) into cantidadRepetida from linea_de_montaje where id_linea= _id_linea; -- linea
select 0 into resultado;
if(cantidadRepetida>0 and cantidadRepetidaEstacion=0)then
	select existePrimero(_id_linea) into existe; 
	if(existe=true)then
    insert into estacion values(_id_estacion,_id_linea,false);
    else
	insert into estacion values(_id_estacion,_id_linea,true);
	end if;
select 1 into resultado;
select "La Estacion se agregó correctamente" into mensaje;
else
select "No existe esta Linea de Montaje ingresada o Ya existe una Estacion con mismo ID" into mensaje;
end if;
end $$
DELIMITER ;
DELIMITER $$
create function existePrimero( id_linea int)returns boolean deterministic begin
declare existe boolean default false;
select esPrimero into existe from estacion where linea_de_montaje_id_linea=id_linea;
return existe;
end $$
DELIMITER ;
select existePrimero(1);
select*from linea_de_montaje;
DELIMITER $$
create procedure eliminarEstacion(in _id_estacion int ,out mensaje varchar(90), out resultado int)begin
declare cantidadRepetida int default 0;
select 0 into resultado;
select count(*) into cantidadRepetida from estacion where id_estacion=_id_estacion;
if(cantidadRepetida>0)then
	delete from estacion where id_estacion= _id_estacion;
	select "La Estacion se eliminó correctamente" into mensaje;
	select 1 into resultado;
else
select "La Estacion que quiere eliminar no existe" into mensaje;
end if;
end$$
DELIMITER ;