-- SEGUNDA ETAPA
-- 5)
select *from concesionaria;
select *from modelo;
select *from linea_de_montaje;
select *from automovil;
select*from pedido;
select*from detalle_pedido;
select*from automovil;
select*from estacion_has_automovil;
select*from estacion;
-- Concesionaria
-- Alta
call agregarConcesionaria(1,"TodoAutos Ezeiza",@mensaje,@resultado);  -- LISTO
select @mensaje;
select @resultado;
call agregarConcesionaria(2,"TodoAutos MonteGrande",@mensaje,@resultado);
-- Baja
call eliminarConcesionaria(2,@mensaje,@resultado);
call agregarConcesionaria(2,"TodoAutos MonteGrande",@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Modificar 
call modificarConcensionaria(2,3, "TodoAutos Canning",@mensaje,@resultad);
select @mensaje;
call eliminarConcesionaria(3,@mensaje,@resultado);

-- Alta 
call agregarModelo(10,"Ford AKA",1000,@mensaje,@resultado); -- LISTO
select @mensaje; -- El AgregarModelo crea una Linea de Montaje Con el ID actual +1 agregandole el modelo tambien como foranea
select @resultado;
-- TERCERA ETAPA 
-- 8)  
-- Alta 
call agregarPedido(2,10,1,2,@mensaje,@resultado); -- AgregarPedido crea el pedido y atravez del modelo y la cantidad tambien 
select @mensaje;								-- crea los automoviles agregandole la Linea asignada y nro de patente aleatorio
select @resultado;								-- usa el Procedimiento  generarAutomoviles(in _id_modelo int,in id_pedido int, in _cantidad int)
												-- usando el modelo por parametro y el id pedido 
-- (in _id_pedido int,in _id_modelo int,in _cuit_concesionaria int,in _cantidad int,out mensaje varchar(70),out resultado int)
select @mensaje;
select @resultado;
--  Crea la Estacion y tambien determina si va ser la primera Estacion o no, atravez de un booleano
 call agregarEstacion(10,1,@mensaje ,@resultado);
 select @mensaje;
select @resultado;
call iniciarMontaje(3032,'2021-01-01 00:00:00',@mensaje,@resultado);
select @mensaje;
select @resultado;
call continuarMontaje(3032,@Mensaje, @Resultado);
select @Mensaje;
select @Resultado;
