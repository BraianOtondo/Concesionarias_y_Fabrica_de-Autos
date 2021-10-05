USE automotriz ;
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarConcecionaria ( in _cuit_concensionaria int, in nombre varchar(45), out mensaje varchar(30))
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concecionaria where cuit_concecionaria = _cuit_concensionaria;
    
    if (cantidadRepetida > 0 ) then
		-- select "La Concensionaria ya existe" into cMensaje;
        select "Esta Concesionariaya existe" into mensaje;
	else
		insert into concecionaria values(_cuit_concensionaria,nombre);
		select "Se agregó correctamente" into mensaje;
    end if;

END$$
DELIMITER ;
/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarConcecionaria( in _cuit_concecionaria int ,out mensaje varchar(100))
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadPedido int default 0;
    select count(*) into cantidadRepetida from concecionaria where cuit_concecionaria = _cuit_concecionaria;
    select count(*) into cantidadPedido from pedido where concecionaria_cuit_concecionaria = _cuit_concecionaria;
    
    if(cantidadRepetida > 0) then
		if(cantidadPedido > 0) then
            select "No Se Puede eliminar la concensionaria debido a que tiene uno o mas pedidos" into mensaje;
		else
            delete from concecionaria where cuit_concecionaria = _cuit_concecionaria;
            select"La concecionaria se eliminó correctamente" into mensaje;
		end if;
	else
        select "La Concensionaria que quiere eliminar no existe" into mensaje;
	end if;
END$$
DELIMITER ;
call agregarConcecionaria(4,"TodoAutos Temperley",@mensaje);
select @mensaje;
select*from concecionaria;
call eliminarConcecionaria(4,@mensaje);
select @mensaje;
