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

-- Baja
call eliminarModelo(2,@mensaje,@resultado);
select @mensaje;
select @resultado;
-- Pedidos
-- Alta


