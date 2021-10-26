USE automotriz ;
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarConcesionaria ( in _cuit_concesionaria int, in nombre varchar(45), out mensaje varchar(70),out resultado int)
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria = _cuit_concesionaria;
    select 0 into resultado;
    if (cantidadRepetida > 0 ) then
        select "Esta Concesionaria ya existe" into mensaje;
	else
		insert into concesionaria values(_cuit_concesionaria,nombre);
		select "La Concesionaria se agregó correctamente" into mensaje;
        select 1 into resultado;
    end if;

END$$
DELIMITER ;
/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarConcesionaria( in _cuit_concesionaria int ,out mensaje varchar(100),out resultado int)
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadPedido int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria=_cuit_concesionaria;
    select count(*) into cantidadPedido from pedido where concesionaria_cuit_concesionaria= _cuit_concesionaria;
	select 0 into resultado;
    if(cantidadRepetida > 0) then
		if(cantidadPedido > 0) then
            select "No Se Puede eliminar la concensionaria debido a que tiene uno o mas pedidos" into mensaje;
		else
            delete from concesionaria where cuit_concesionaria = _cuit_concesionaria;
            select"La concesionaria se eliminó correctamente" into mensaje;
                    select 1 into resultado;

		end if;
	else
        select "La Concensionaria que quiere eliminar no existe" into mensaje;
	end if;
END$$
DELIMITER ;
/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarConcensionaria(in _cuit_concesionaria int, in nuevo_cuit_concesionaria int, in nuevo_nombre varchar(45), out mensaje varchar(50),out resultado int)
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria =_cuit_concesionaria;
    select 0 into resultado;

    if(cantidadRepetida > 0) then
		if(nuevo_cuit_concesionaria <> (select cuit_concesionaria from concesionaria where cuit_concesionaria=_cuit_concesionaria) 
			and nuevo_nombre <> (select nombre from concesionaria where cuit_concesionaria=_cuit_concesionaria) ) then
            
			UPDATE concesionaria set cuit_concesionaria= nuevo_cuit_concesionaria, nombre = nuevo_nombre where cuit_concesionaria= _cuit_concesionaria;
            select "La concesionaria se acutalizó correctamente" into mensaje;
            select 1 into resultado;

        else 
            select "Error al Modificar debido a que esta ingresando uno o mas datos repetidos" into mensaje;
		end if;
    else
		select "La Concensionaria que quiere modificar no existe" into mensaje;
	
    end if;
END$$
DELIMITER ;
