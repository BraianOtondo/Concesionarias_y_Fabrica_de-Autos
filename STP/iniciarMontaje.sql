
use automotriz;
-- TERCERA ETAPA 
-- 9)  crear un procedimiento que al recibir como parámetro la patente del
-- automóvil, se le dé inicio al montaje del mismo, es decir, que al ejecutar dicho
-- procedimiento el automóvil con la patente indicada es “posicionado”
DELIMITER $$
create procedure iniciarMontaje(in _patente int,in _fecha_ingreso datetime,out mensaje varchar(70),out resultado int)begin
declare cantidadRepetida int default 0;
declare existe boolean;
declare _id_estacion int;
select count(*) into cantidadRepetida from automovil where nro_chasis=_patente;
-- select disponible from estacion where id_estacion=1 into _disponible;
	if(cantidadRepetida>0)then
    select retornarIdEstacion(_patente) into _id_estacion;
    select estaVaciaPrimerEstacion() into existe;
		if(existe= true)then
		insert into estacion_has_automovil(estacion_id_estacion,automovil_nro_chasis,fecha_ingreso) values(_id_estacion,_patente,_fecha_ingreso);
        select "El automovil inició su montaje" into mensaje;
		else
        select "La estacion está ocupada" into mensaje;
        end if;
else
select "El automovil con esa patente no existe" into mensaje;
end if ;
end$$
DELIMITER ;
DELIMITER $$
create function retornarIdEstacion(_patente int)returns int deterministic begin
declare linea int;
declare estacion_encontrada int;
select id_linea_asignada from automovil where nro_chasis=_patente into linea; -- listo 
select id_estacion from estacion e inner join linea_de_montaje li on e.linea_de_montaje_id_linea=li.id_linea where li.id_linea=linea and e.esPrimero=true into  estacion_encontrada;
return estacion_encontrada;
end$$ 
DELIMITER ;

select *from estacion;
select *from automovil;
select*from estacion_has_automovil;
		-- insert into concesionaria values(_cuit_concesionaria,nombre);
DELIMITER $$
create function estaVaciaPrimerEstacion()returns boolean deterministic begin
declare existe boolean default true;
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from estacion_has_automovil where fecha_egreso=null and fecha_ingreso!=null;
if(cantidadRepetida>0)then
set existe=false;
end if;
return existe;
end$$
DELIMITER ;
select estaVaciaPrimerEstacion(@mensaje);
select  retornarIdEstacion(2509);