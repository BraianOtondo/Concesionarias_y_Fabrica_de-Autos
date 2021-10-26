use automotriz;
select*from modelo;
select*from concesionaria;

call agregarPedido(2,3,1,5,1000,@m,@r);
select @r;
select @m;
select*from automovil;