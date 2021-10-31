USE automotriz ;
DELIMITER $$
create procedure agregarProveedor(in _id_proveedor int,in _nombre varchar(45),in _telefono varchar(30),in _mail varchar(40),out mensaje varchar(70), out resultado int)begin
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from proveedor where id_proveedor=_id_proveedor;
	select 0 into resultado;												
if(cantidadRepetida>0)then
      select "Este Proveedor ya existe" into mensaje;
else
insert into proveedor values(_id_proveedor,_nombre,_telefono,_mail);
select "El Proveedor se agregó correctamente" into mensaje;
select 0 into resultado;												
end if;
end$$
DELIMITER ;
DELIMITER $$
create procedure eliminarProveedor(in _id_proveedor int ,out mensaje varchar(90), out resultado int)begin
declare cantidadRepetida int default 0;
declare cantidadProveedor int default 0;
select 0 into resultado;
select count(*) into cantidadRepetida from proveedor where id_proveedor=_id_proveedor;
select count(*) into cantidadProveedor from insumo_has_proveedor where proveedor_id_proveedor=_id_proveedor;
if(cantidadRepetida>0)then
	if(cantidadProveedor>0)then
		select "No se puede eliminar Proveedor porque se está usardo como llave Foranea en Linea De Montaje" into mensaje;
	else
	delete from proveedor where id_proveedor= _id_proveedor;
	select "El Proveedor se eliminó correctamente" into mensaje;
	select 1 into resultado;
    end if;
else
select "El Proveedor que quiere eliminar no existe" into mensaje;
end if;
end$$
DELIMITER ;
DELIMITER $$

create procedure modificarProveedor(in _id_proveedor int, in nuevo_nombre varchar(45),nuevo_telefono varchar(30), out mensaje varchar(100),out resultado int)begin
declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from proveedor where id_linea =_id_linea;
    select 0 into resultado;

    if(cantidadRepetida > 0) then
		if(nueva_capacidad <> (select capacidad from linea_de_montaje where id_linea=_id_linea)) then
            
			UPDATE linea_de_montaje set capacidad= nueva_capacidad where id_linea= _id_linea;
            select "La Linea de montaje se acutalizó correctamente" into mensaje;
            select 1 into resultado;

        else 
            select "Error al Modificar debido a que esta ingresando uno o mas datos repetidos" into mensaje;
		end if;
    else
		select "La Linea de montaje que quiere modificar no existe" into mensaje;
	
    end if;
end$$
DELIMITER ;
