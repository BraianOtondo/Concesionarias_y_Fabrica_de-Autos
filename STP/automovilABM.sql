use automotriz;
DELIMITER $$
create procedure agregarAutomovil(in _nro_chasis int,in _precio decimal, in _id_modelo int, in _id_pedido int,in _id_linea_asignada int,out mensaje varchar(50)) begin
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from automovil where nro_chasis=_nro_chasis;
if(cantidadRepetida>0)then
        select "Este automovil ya existe" into mensaje;
else
insert into automovil values(_nro_chasis,_precio,_id_modelo,_id_pedido,_id_linea_asignada);
select "El automovil se agregó correctamente" into mensaje;
end if;

end$$
DELIMITER ;
DELIMITER $$
create procedure eliminarAutomovil(in _nro_chasis int, out mensaje varchar(70))begin
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from automovil where nro_chasis=_nro_chasis;
if(cantidadRepetida>0)then
           -- delete from concesionaria where cuit_concesionaria = _cuit_concesionaria;
	delete from automovil where nro_chasis=_nro_chasis;
    select "El automovil se eliminó correctamente" into mensaje;
else
	select "El automovil no existe" into mensaje;
end if;
end $$
DELIMITER ;
DELIMITER $$
create procedure modificarAutomovil(in _nro_chasis int,in nuevo_nro_chasis int,in nuevo_precio decimal, out mensaje varchar(70))begin
declare cantidadRepetida int default 0;

if(cantidadRepetida>0)then
update automovil set nro_chasis=nuevo_nro_chasis, precio=nuevo_precio where nro_chasis=_nro_chasis;
	select "El automovil se actualizó correctamente" into mensaje;
else
	select "El automovil no existe" into mensaje;
end if;
end $$
DELIMITER ;
