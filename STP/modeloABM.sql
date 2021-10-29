USE automotriz ;
DELIMITER $$
create procedure agregarModelo(in _id_modelo int, in _nombre varchar(30),in _precio decimal, out mensaje varchar(70), out resultado int)begin
declare cantidadRepetida int default 0;
declare id int;
select count(*) into cantidadRepetida from modelo where id_modelo=_id_modelo or nombre=_nombre;
select 0 into resultado;
if(cantidadRepetida>0)then
	select "Este modelo ya existe" into mensaje;
else
	insert into modelo values(_id_modelo, _nombre,_precio);
    select "El Modelo se agregó correctamente" into mensaje;
    select traerUltimoIdLinea() into id;
    insert into linea_de_montaje values(id+1,0,_id_modelo);
    select 1 into resultado;
end if;
end $$
DELIMITER ;
DELIMITER $$
create procedure eliminarModelo(in _id_modelo int ,out mensaje varchar(90), out resultado int)begin
declare cantidadRepetida int default 0;
declare cantidadModelo int default 0;
select 0 into resultado;
select count(*) into cantidadRepetida from modelo where id_modelo=_id_modelo;
select count(*) into cantidadModelo from linea_de_montaje where modelo_id_modelo=_id_modelo;
if(cantidadRepetida>0)then
	if(cantidadModelo>0)then
		select "No se puede eliminar Modelo porque se está usardo como llave Foranea en Linea De Montaje" into mensaje;
	else
	delete from modelo where id_modelo= _id_modelo;
	select "El modelo se eliminó correctamente" into mensaje;
	select 1 into resultado;
    end if;
else
select "El modelo que quiere eliminar no existe" into mensaje;
end if;
end$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE modificarModelo(in _id_modelo int, in nuevo_id_modelo int, in nuevo_nombre varchar(45),in nuevo_precio decimal, out mensaje varchar(70),out resultado int)BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from modelo where id_modelo =_id_modelo;
    select 0 into resultado;
    if(cantidadRepetida > 0) then
		if(nuevo_id_modelo <> (select id_modelo from modelo where id_modelo=_id_modelo) 
			or nuevo_nombre <> (select nombre from modelo where id_modelo=_id_modelo)
            or (nuevo_precio <>(select precio from modelo where id_modelo=_id_modelo))) then
            
			UPDATE modelo set id_modelo= nuevo_id_modelo, nombre = nuevo_nombre, precio=nuevo_precio 
            where id_modelo=_id_modelo;
            select "El Modelo se actalizó correctamente" into mensaje;
            select 1 into resultado;

        else 
            select "Error al Modificar debido a que está ingresando los datos existentes" into mensaje;
		end if;
    else
		select "El Modelo que quiere modificar no existe" into mensaje;
	
    end if;
END$$
DELIMITER ;
