-- ETAPA 3 10) 
-- Se requiere crear un procedimiento que al recibir como parámetro la patente del
-- automóvil, se finaliza la labor de la estación en la que se encuentra y se le ingresa en
-- la estación siguiente.
DELIMITER $$
create procedure continuarMontaje(in _chasis int ,out mensaje varchar(100), out resultado int)BEGIN
	DECLARE cantidadRepetida int default 0;
    
    DECLARE i int default 0;
    DECLARE limite int default 0;
    DECLARE finished int default 0 ;
    
    DECLARE idEstacionTrabajoActual int;
	DECLARE idEstacionTrabajoSiguente int;
    
    DECLARE curEstacion CURSOR FOR SELECT id_linea from linea_de_montaje inner join estacion e on e.linea_de_montaje_id_linea = id_linea
									where id_linea in (select id_linea_asignada from automovil where nro_chasis = _chasis);
	DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET finished = 1;
        
    OPEN curEstacion;
    
    select count(*) into limite from estacion_has_automovil where automovil_nro_chasis = _chasis;
    WHILE i <= limite and finished != 1 DO
		FETCH curEstacion INTO idEstacionTrabajoSiguente;	
		set i = i + 1;
    end WHILE;
    
    CLOSE curEstacion; 
        SELECT max(estacion_id_estacion) into idEstacionTrabajoActual FROM estacion_has_automovil  where automovil_nro_chasis = _chasis ;
    
    IF(idEstacionTrabajoActual = (SELECT max(id_estacion) FROM estacion where 
									linea_de_montaje_id_linea = (select id_linea_asignada from automovil where nro_chasis = _chasis)) )then
                                    
            UPDATE estacion_has_automovil SET fecha_egreso = now() WHERE estacion_id_estacion = idEstacionTrabajoActual;
            UPDATE automovil SET fecha_finalizado = now() WHERE nro_chasis = _chasis;
    ELSE
    
		SELECT count(*) into cantidadRepetida from estacion_has_automovil
											where estacion_id_estacion = idEstacionTrabajoSiguente and fecha_egreso is null;
                                            
		if(cantidadRepetida > 0) then
			select -1 into resultado;
			select 'No Se Puede Agregar a la estacion debido a que esta siendo ocupada por otro automovil' into mensaje;
			
		else        
			UPDATE estacion_has_automovil SET fecha_egreso = now() WHERE estacion_id_estacion = idEstacionTrabajoActual;
			
			INSERT INTO estacion_has_automovil values(idEstacionTrabajoSiguente,_chasis,now() ,NULL);
			select 'El Automovil pasó a la siguiente Estacion' into mensaje;

		end if;
        
	END IF;
 END$$
DELIMITER ;