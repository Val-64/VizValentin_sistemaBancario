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

-- mostrar todos los clientes asociados a todas las sucursales.
SELECT suc.nombre AS 'sucursal', cli.nombre, cli.apellido, cli.fecha_nacimiento, cli.email FROM clientes cli
INNER JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id;
 
-- mostrar la cantidad de clientes por sucursal.
SELECT suc.nombre AS 'sucursal', COUNT(*) AS 'cantidad_clientes' FROM clientes cli
INNER JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id
GROUP BY suc.nombre;

-- mostrar todos los clientes asociados a todas las sucursales ordenados por edad.
SELECT 
 suc.nombre AS 'sucursal',
 cli.nombre, cli.apellido,
 cli.fecha_nacimiento,
 ( YEAR(CURRENT_DATE()) - YEAR(cli.fecha_nacimiento) ) AS 'edad'
FROM clientes cli
INNER JOIN 
 sucursales suc ON cli.sucursal_id = suc.sucursal_id
ORDER BY 
 fecha_nacimiento DESC;


-- clientes && cuentas

-- muestra todas las cuentas y el usuario al que pertenece
SELECT cue.tipo, cue.moneda, cli.nombre, cli.apellido, cli.email FROM clientes cli
INNER JOIN cuentas cue ON cue.cliente_id = cli.cliente_id;

-- muestra todas los usuarios con y sin cuentas.
SELECT cue.tipo, cue.moneda, cli.nombre, cli.apellido, cli.email FROM clientes cli
LEFT JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
ORDER BY tipo;

-- cuenta la cantidad de clientes por tipo de cuenta
SELECT cue.tipo, COUNT(*) AS 'cantidad_clientes' FROM clientes cli
INNER JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
GROUP BY cue.tipo;

-- cuenta la cantidad de clientes por tipo de moneda
SELECT cue.moneda, COUNT(*) AS 'cantidad_clientes' FROM clientes cli
INNER JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
GROUP BY cue.moneda;

-- muestra el cliente con la cuenta más antigua.
SELECT cli.nombre, cli.apellido, cli.dni, cue.tipo, cue.moneda, cue.fecha_apertura 
FROM clientes cli
INNER JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
WHERE (SELECT MIN(fecha_apertura) FROM cuentas) = cue.fecha_apertura;

-- muestra el cliente con la cuenta más nueva.
SELECT cli.nombre, cli.apellido, cli.dni, cue.tipo, cue.moneda, cue.fecha_apertura 
FROM clientes cli
INNER JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
WHERE (SELECT MAX(fecha_apertura) FROM cuentas) = cue.fecha_apertura;

-- muestra la cantidad de cuentas abiertas por año
SELECT YEAR(fecha_apertura) as 'year', COUNT(*) as 'cuentas_abiertas' 
FROM cuentas
GROUP BY YEAR(fecha_apertura)
ORDER BY YEAR(fecha_apertura);

-- sucursales & clientes & cuentas.

-- muestra todas las cuentas con sus clientes y su sucursal.

SELECT 
 suc.nombre,
 cli.nombre,
 cli.apellido,
 cli.dni,
 cue.tipo,
 cue.moneda,
 cue.fecha_apertura
FROM cuentas cue
INNER JOIN clientes cli ON cue.cliente_id = cli.cliente_id
INNER JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id;




