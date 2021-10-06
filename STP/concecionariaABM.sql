USE automotriz ;
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarConcesionaria ( in _cuit_concesionaria int, in nombre varchar(45), out mensaje varchar(30))
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria = _cuit_concesionaria;
    
    if (cantidadRepetida > 0 ) then
        select "Esta Concesionariaya existe" into mensaje;
	else
		insert into concesionaria values(_cuit_concesionaria,nombre);
		select "Se agregó correctamente" into mensaje;
    end if;

END$$
DELIMITER ;
/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarConcecionaria( in _cuit_concesionaria int ,out mensaje varchar(100))
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadPedido int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria=_cuit_concesionaria;
    select count(*) into cantidadPedido from pedido where concesionaria_cuit_concesionaria= _cuit_concesionaria;
    
    if(cantidadRepetida > 0) then
		if(cantidadPedido > 0) then
            select "No Se Puede eliminar la concensionaria debido a que tiene uno o mas pedidos" into mensaje;
		else
            delete from concesionaria where cuit_concesionaria = _cuit_concesionaria;
            select"La concecionaria se eliminó correctamente" into mensaje;
		end if;
	else
        select "La Concensionaria que quiere eliminar no existe" into mensaje;
	end if;
END$$
DELIMITER ;
/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarConcensionaria( in _cuit_concesionaria int, in nuevo_cuit_concesionaria int, in nuevo_nombre varchar(45), out mensaje varchar(50))
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concesionaria where cuit_concesionaria =_cuit_concesionaria;
    
    if(cantidadRepetida > 0) then
		if(nuevo_cuit_concesionaria <> (select cuit_concesionaria from concesionaria where cuit_concesionaria=_cuit_concesionaria) 
			and nuevo_nombre <> (select nombre from concesionaria where cuit_concesionaria=_cuit_concesionaria) ) then
            
			UPDATE concesionaria set cuit_concesionaria= nuevo_cuit_concesionaria, nombre = nuevo_nombre where cuit_concesionaria= _cuit_concesionaria;
            select "La concesionaria se acutalizó correctamente" into mensaje;
		
        else 
            select "Error al Modificar debido a que esta ingresando uno o mas datos repetidos" into mensaje;
		end if;
    else
		select "La Concensionaria que quiere modificar no existe" into mensaje;
	
    end if;
END$$
DELIMITER ;
select *from concesionaria;
call agregarConcesionaria(1,"TodoAutos Temperley",@mensaje);
select @mensaje;
call eliminarConcecionaria(1,@mensaje);
select @mensaje;
call modificarConcensionaria(1,4,"TodoAutos Luis Guillon",@mensaje);
select @mensaje;
