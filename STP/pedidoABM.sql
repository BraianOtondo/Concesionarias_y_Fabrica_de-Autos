USE automotriz ;
/*ALTA*/
DELIMITER $$
create procedure agregarPedido(in _id_pedido int,in _id_modelo int,in _cuit_concesionaria int,in _cantidad int,out mensaje varchar(70),out resultado int) begin
declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from pedido where id_pedido=_id_pedido;
select 0 into resultado;
if(cantidadRepetida>0)then
	select "Se agrego el detalle_pedido en el pedido correctamente" into mensaje; -- si ya existe el pedido solo agrega
    select 1 into resultado;

    insert into detalle_pedido values(_id_modelo,_id_pedido,_cantidad);
else
	select "Se creó el pedido y se agregó el detalle_pedido correctamente" into mensaje; -- si no existe, lo crea y luego lo agrega
    insert into pedido values(_id_pedido,_cuit_concesionaria);
	insert into detalle_pedido values(_id_modelo,_id_pedido,_cantidad);
end if;
end$$
DELIMITER ;
/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarPedido(in _id_pedido int, out mensaje varchar(70),out resultado int)
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from detalle_pedido where  pedido_id_pedido = _id_pedido;
	select 0 into resultado;												
    if(cantidadRepetida > 0) then
        delete from detalle_pedido where pedido_id_pedido = _id_pedido;
        delete from pedido where id_pedido =_id_pedido;
		select "El pedido se eliminó correctamente" into mensaje;
		select 1 into resultado;
    else
        select "El pedido que quiere eliminar no existe" into mensaje;
	end if;
END$$
DELIMITER ;
/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarPedido(in _id_pedido int,in _id_modelo int, in nueva_cantidad int, in nuevo_id_modelo int, out mensaje varchar(70),out resultado int)
BEGIN
	declare cantidadRepetida int default 0;
	select count(*) into cantidadRepetida from detalle_pedido where  pedido_id_pedido = _id_pedido and modelo_id_modelo=_id_modelo;
	select 0 into resultado;												    
    if(cantidadRepetida > 0) then
		if(nueva_cantidad <> (select cantidad from detalle_pedido where  pedido_id_pedido = _id_pedido and modelo_id_modelo=_id_modelo)) 
			and (nuevo_id_modelo <> (select modelo_id_modelo from detalle_pedido where  pedido_id_pedido = _id_pedido and modelo_id_modelo=_id_modelo)) then
            
            update detalle_pedido set cantidad = nueva_cantidad where pedido_id_pedido = _id_pedido and modelo_id_modelo=_id_modelo;
            update detalle_pedido set modelo_id_modelo=nuevo_id_modelo where pedido_id_pedido = _id_pedido and modelo_id_modelo=_id_modelo;
			select "El pedido se actulizo correctamente" into mensaje;
			select 1 into resultado;												
        else
            select "No Se Puede Modificar debido a que estan repitiendo uno o mas datos" into mensaje;
		end if;
        
	else 
        select "El Pedido que quiere modificar no existe" into mensaje;
	end if;
END$$
DELIMITER ;