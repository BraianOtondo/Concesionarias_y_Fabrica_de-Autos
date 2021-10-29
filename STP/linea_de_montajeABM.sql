DELIMITER $$
create procedure agregarLineaDeMontaje(in _id_linea int, in _capacidad int, in _id_modelo int, out mensaje varchar(70),out resultado int)begin
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from linea_de_montaje where id_linea= _id_linea;
select 0 into resultado;
if (cantidadRepetida>0)then
	select "Esta Linea de montaje ya existe" into mensaje;
else 
	insert into linea_de_montaje values(_id_linea,_capacidad,_id_modelo);
    select 1 into resultado;
	select "La Linea de montaje se agregó correctamente" into mensaje;
end if;

end $$
DELIMITER ;
DELIMITER $$
create procedure eliminarLineaDeMontaje(in _id_linea int, out mensaje varchar(100),out resultado int)begin
declare cantidadRepetida int default 0;
declare cantidadLinea int default 0;

    select count(*) into cantidadRepetida from linea_de_montaje where id_linea=_id_linea;
    select count(*) into cantidadLinea from automovil where id_linea_asignada= _id_linea;
	select 0 into resultado;
    if(cantidadRepetida > 0) then
		if(cantidadLinea > 0) then
            select "No Se Puede eliminar la Linea de Montaje, debido a que tiene uno o más automoviles" into mensaje;
		else
            delete from linea_de_montaje where id_linea = _id_linea;
            select"La Linea de montaje se eliminó correctamente" into mensaje;
                    select 1 into resultado;

		end if;
	else
        select "La Linea de montaje que quiere eliminar no existe" into mensaje;
	end if;
end$$
DELIMITER ;
DELIMITER $$
create procedure modificarLineaDeMontaje(in _id_linea int, in nueva_capacidad int, out mensaje varchar(100),out resultado int)begin
declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from linea_de_montaje where id_linea =_id_linea;
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
