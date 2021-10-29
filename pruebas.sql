-- SEGUNDA ETAPA
-- 5)
-- Concesionaria
-- Alta
select *from concesionaria;
call agregarConcesionaria(1,"TodoAutos Ezeiza",@mensaje,@resultado);
call agregarConcesionaria(2,"TodoAutos Lanús",@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Baja
call eliminarConcesionaria(2,@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Modificación
call modificarConcensionaria(1,7,"TodoAutos Temperley",@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Modelo
select *from modelo;
select *from linea_de_montaje;
-- Alta
call agregarModelo(10,"Ford AKA",1000,@mensaje,@resultado);
select @mensaje;
select @resultado;
call agregarModelo(7,"Ford Zeus",2000,@mensaje,@resultado);
call agregarModelo(2,"Ford Raptor",100,@mensaje,@resultado);
call agregarLineaDeMontaje(1,0,7,@mensaje,@resultado);
-- Baja
call eliminarModelo(7,@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Modificación
call modificarModelo(10,4,"Ford Fox",100,@mensaje,@resultado);

-- Pedidos
-- Alta
call agregarPedido(2,2,7,2,@mensaje,@resultado);
-- (in _id_pedido int,in _id_modelo int,in _cuit_concesionaria int,in _cantidad int,out mensaje varchar(70),out resultado int)
select @mensaje;
select @resultado;
select*from pedido;
select*from detalle_pedido;
select*from automovil;
select @mensaje;
call eliminarPedido(2,@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Proveedor
-- Alta
select *from proveedor;
call agregarProveedor(1,"LimpiezaDot","42630323","pepetoño87@gmail.com",@mensaje,@resultado);
-- Baja
call eliminarProveedor(1,@mensaje,@resultado);
call agregarEstacion(1,@mensaje,@resultado);
call agregarEstacion(2,@mensaje,@resultado);

select @mensaje;
select @resultado;
select *from estacion;
call iniciarMontaje(1151,'2014-10-25 20:00:00',@mensaje,@resultado);
select*from estacion_has_automovil;
select id_estacion from estacion e inner join linea_de_montaje li on e.linea_de_montaje_id_linea=li.id_linea where li.id_linea=2;
