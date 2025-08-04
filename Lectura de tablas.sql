/*
	Lectura de tablas
    
*/

USE proyecto_01;

/*
	Lectura de tablas por separado:
	 - tabla sucursales,
     - tabla clientes,
     - tabla cuentas.
*/

SELECT * FROM sucursales;

SELECT * FROM clientes;

SELECT * FROM cuentas;

/*
	Lectura de tablas combinadas:
	 - sucursales & clientes,
     - clientes & cuentas,
     - sucursales & clientes & cuentas.
*/

-- sucursales & clientes.

-- selecciona todos los clientes asociados a todas las sucursales.
SELECT suc.nombre AS 'sucursal', cli.nombre, cli.apellido, cli.fecha_nacimiento, cli.email FROM clientes cli
INNER JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id;
 
-- selecciona la cantidad de clientes por sucursal.
SELECT suc.nombre AS 'sucursal', COUNT(*) AS 'cantidad_clientes' FROM clientes cli
INNER JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id
GROUP BY suc.nombre;


