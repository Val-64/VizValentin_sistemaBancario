/*
	Lectura de tablas
*/

SELECT cue.cuenta_id AS "No. Cuenta", suc.nombre AS "sucursal", cli.nombre, cli.apellido, cli.dni, cli.email, cli.telefono, cue.tipo AS 'tipo_cuenta', cue.moneda, cue.saldo 
FROM clientes cli
INNER JOIN sucursales suc ON suc.sucursal_id = cli.sucursal
INNER JOIN cuentas cue ON cue.cliente = cli.cliente_id;
