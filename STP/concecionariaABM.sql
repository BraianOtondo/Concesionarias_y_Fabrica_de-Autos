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
call agregarConcesionaria(3,"TODOAUTOS MONTE",@mensaje);
select @mensaje;
call eliminarConcecionaria(1,@mensaje);
select @mensaje;
call modificarConcensionaria(1,4,"TodoAutos Luis Guillon",@mensaje);
select @mensaje;
-- (in _id_pedido int,in _id_modelo int,in _cuit_concesionaria int,in _cantidad int,out mensaje varchar(50))
insert into modelo values(27,"FORD RANGER");
insert into modelo values(77,"KANGOO");
select*from modelo;
call agregarPedido(6,27,1,2,@mensaje);
select @mensaje;
select *from pedido;
select*from detalle_pedido;
call agregarPedido(1,77,1,6,@mensaje);

select @mensaje;
-- CREATE PROCEDURE eliminarPedido(in _id_pedido int, out mensaje varchar(70))
call eliminarPedido(43,@mensaje);
select @mensaje;
-- CREATE PROCEDURE modificarPedido(in _id_pedido int,in _id_modelo int, in nueva_cantidad int, in nuevo_id_modelo int, out mensaje varchar(70))
call modificarPedido(6,27,10,77,@mensaje);
select @mensaje;