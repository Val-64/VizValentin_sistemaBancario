/*
	Creacion de vistas.
	
    1. Clientes.
    2. Cuentas.
    3. Clientes por sucursal.
    4. Cuentas por cliente.
    
    5. Depositos.
    6. Retiros.
    7. Transferencias.
    
    8. Cantidad de cuentas por cliente.
    9. Cantidad de clientes por sucursal.
*/

USE proyecto_01;

-- 1. muestra todos los clientes.
CREATE VIEW view_clientes AS
SELECT
	CONCAT(nombre, ' ', apellido) AS cliente,
    dni,
    YEAR(CURRENT_DATE()) - YEAR(fecha_nacimiento) AS edad,
    telefono,
    email
FROM clientes
ORDER BY nombre ASC;

-- 2. muestra todas las cuentas.
CREATE VIEW view_cuentas AS
SELECT 
	CONCAT(suc.sucursal_id, '-', cli.dni, ' ', cue.cuenta_id) AS no_cuenta,
    cue.fecha_apertura,
    cue.tipo,
	cue.moneda,
    cue.saldo
FROM cuentas cue
JOIN clientes cli ON cli.cliente_id = cue.cliente_id
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
ORDER BY suc.sucursal_id;

-- 3. muestra clientes por sucursal.
CREATE VIEW view_clientes_sucursales AS
SELECT 
	suc.nombre AS sucursal,
	CONCAT(suc.calle, ' ', altura) AS direccion,
    CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo,
    cli.dni,
    cli.telefono,
	cli.email
FROM sucursales suc
JOIN clientes cli ON suc.sucursal_id = cli.sucursal_id
ORDER BY sucursal, nombre_completo;

-- 4. muestra cuentas por cliente.
CREATE VIEW view_cuentas_clientes AS
SELECT 
	cli.dni, 
    CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo, 
    cue.tipo,
    cue.moneda,
    cue.fecha_apertura
FROM cuentas cue
RIGHT JOIN clientes cli ON cue.cliente_id = cli.cliente_id
ORDER BY cli.dni;

-- 5. muestra todos los depositos.
CREATE VIEW view_depositos AS
SELECT 
	CONCAT(suc.sucursal_id, '-', cli.dni, ' ', cue.cuenta_id) AS no_cuenta,
    mov.monto,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue ON cue.cuenta_id = mov.cuenta_destino
JOIN clientes cli ON cli.cliente_id = cue.cliente_id
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
WHERE tipo_movimiento = 'Deposito';

-- 6. muestra todos los retiros.
CREATE VIEW view_retiros AS
SELECT 
	CONCAT(suc.sucursal_id, '-', cli.dni, ' ', cue.cuenta_id) AS no_cuenta,
    mov.monto,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue ON cue.cuenta_id = mov.cuenta_origen
JOIN clientes cli ON cli.cliente_id = cue.cliente_id
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
WHERE tipo_movimiento = 'Retiro';

-- 7. muestra todas las transferencias.
CREATE VIEW view_transferencias AS
SELECT
	CONCAT(suc_ori.sucursal_id, '-', cli_ori.dni, ' ', cue_ori.cuenta_id) AS cuenta_origen,
    CONCAT(cli_ori.nombre, ' ', cli_ori.apellido) AS cliente_origen,
    mov.monto,
    mov.descripcion,
    CONCAT(suc_des.sucursal_id, '-', cli_des.dni, ' ', cue_des.cuenta_id) AS cuenta_destino,
	CONCAT(cli_des.nombre, ' ', cli_des.apellido) AS cliente_destino,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue_ori ON cue_ori.cuenta_id = mov.cuenta_origen
JOIN cuentas cue_des ON cue_des.cuenta_id = mov.cuenta_destino
JOIN clientes cli_ori ON cli_ori.cliente_id = cue_ori.cliente_id
JOIN clientes cli_des ON cli_des.cliente_id = cue_des.cliente_id
JOIN sucursales suc_ori ON suc_ori.sucursal_id = cli_ori.sucursal_id
JOIN sucursales suc_des ON suc_des.sucursal_id = cli_des.sucursal_id
ORDER BY mov.fecha DESC; 

-- 8. muestra cantidad de cuentas por cliente.
CREATE VIEW view_cantidad_cuentas AS
SELECT
	cli.dni,
    CONCAT(cli.nombre, " ", cli.apellido) AS nombre_completo,
    COUNT(cue.cuenta_id) AS cuentas
FROM clientes cli
LEFT JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
GROUP BY cli.dni
ORDER BY cuentas DESC;

-- 9. muestra cantidad de clientes por sucursal.
CREATE VIEW view_cantidad_clientes AS
SELECT 
	suc.nombre,
    COUNT(cli.cliente_id) AS clientes
FROM clientes cli
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
GROUP BY suc.nombre
ORDER BY clientes DESC;
    