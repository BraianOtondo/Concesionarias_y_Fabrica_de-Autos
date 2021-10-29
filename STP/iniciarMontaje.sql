/*Se requiere crear un procedimiento que al recibir como parámetro la patente del
automóvil, se le dé inicio al montaje del mismo, es decir, que al ejecutar dicho
procedimiento el automóvil con la patente indicada es “posicionado” en la primer
estación de la línea de montaje que le fue asignada al crear el vehículo con el
procedimiento (8)
Nota: No puede ingresarse el vehículo en la estación de trabajo si es que hay otro
automóvil en dicho lugar. En caso de no ser posible la inserción del vehículo en la
primer estación por encontrarse ocupada, deberá retornar un resultado informando esta
situación, además del chasis del vehículo que está ocupando dicha estación.*/
use automotriz;
DELIMITER $$
create procedure iniciarMontaje(in _patente int,in _fecha_ingreso datetime,out mensaje varchar(70),out resultado int)begin
declare cantidadRepetida int default 0;
declare _disponible boolean;
select count(*) into cantidadRepetida from automovil where nro_chasis=_patente;
select disponible from estacion where id_estacion=1 into _disponible;
	if(cantidadRepetida>0)then
    
		if(_disponible = true)then
		insert into estacion_has_automovil(estacion_id_estacion,automovil_nro_chasis,fecha_ingreso) values(1,_patente,_fecha_ingreso);
        select "El automovil inició su montaje" into mensaje;
		else
        select "La estacion está ocupada" into mensaje;
        end if;
else
select "El automovil con esa patente no existe" into mensaje;
end if ;
end$$
DELIMITER ;