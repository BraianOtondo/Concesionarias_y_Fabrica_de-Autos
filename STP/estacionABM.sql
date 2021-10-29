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
create procedure agregarEstacion(in _id_linea int, out mensaje varchar(70),out resultado int)begin
declare cantidadRepetida int default 0;
declare id int;
select count(*) into cantidadRepetida from linea_de_montaje where id_linea= _id_linea;
select 0 into resultado;
if(cantidadRepetida>0)then
    select traerUltimoIdEstacion() into id;
	insert into estacion values(id+1,true,_id_linea);
    select 1 into resultado;
    select "La Estacion se agregó correctamente" into mensaje;

else
select "No existe esta Linea de Montaje ingresada" into mensaje;
end if;
end $$
DELIMITER ;