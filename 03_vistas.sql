/*
	Creacion de vistas.
	
    1. CLIENTES.
    1. CUENTAS.
    
    3. MOVIMIENTOS
    4. DEPOSITOS.
    5. RETIROS.
    6. TRANSFERENCIAS.
    
    7. Cantidad de cuentas por cliente.
    8. Cantidad de clientes por sucursal.
*/

USE sist_bancario;

-- 1. CLIENTES: Ver todos los clientes.
CREATE OR REPLACE VIEW view_clientes AS
SELECT
	suc.sucursal_id AS sucursal_id,
	suc.nombre AS sucursal,
	cli.cliente_id AS id,
	FULLNAME(cli.nombre, cli.apellido) AS cliente,
	cli.dni,
	cli.telefono,
	cli.email
FROM sucursales suc
JOIN clientes cli ON suc.sucursal_id = cli.sucursal_id;

-- 2. CUENTAS: Ver todas las cuentas.
CREATE OR REPLACE VIEW view_cuentas AS
SELECT 
	cli.cliente_id,
	cli.dni, 
    FULLNAME(cli.nombre, cli.apellido) AS cliente, 
    cue.cuenta_id AS id,
    cue.tipo,
    cue.moneda
FROM clientes cli
JOIN cuentas cue ON cue.cliente_id = cli.cliente_id;

-- 3. MOVIMIENTOS: Ver todos los movimientos.
CREATE OR REPLACE VIEW view_movimientos AS
SELECT
	movimiento_id AS id,
    tipo_movimiento AS tipo,
    monto,
    fecha,
    descripcion
FROM movimientos;

-- 4. DEPOSITOS: Ver todos los depositos.
CREATE OR REPLACE VIEW view_depositos AS
SELECT 
	FULLNAME(cli.nombre, cli.apellido) AS cliente,
    cli.dni,
    cue.cuenta_id,
    mov.monto,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue ON cue.cuenta_id = mov.cuenta_destino
JOIN clientes cli ON cli.cliente_id = cue.cliente_id
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
WHERE tipo_movimiento = 'Deposito';


-- 5. RETIROS: Ver todos los retiros.
CREATE OR REPLACE VIEW view_retiros AS
SELECT 
	FULLNAME(cli.nombre, cli.apellido) AS cliente,
    cli.dni,
    cue.cuenta_id,
    mov.monto,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue ON cue.cuenta_id = mov.cuenta_origen
JOIN clientes cli ON cli.cliente_id = cue.cliente_id
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
WHERE tipo_movimiento = 'Retiro';

-- 6. TRANSFERENCIAS muestra todas las transferencias.
CREATE OR REPLACE VIEW view_transferencias AS
SELECT
	FULLNAME(cli_ori.nombre, cli_ori.apellido) AS cliente_origen,
    cli_ori.dni AS dni_origen,
	cue_ori.cuenta_id AS cuenta_origen,
    mov.monto,
    mov.descripcion,
    FULLNAME(cli_des.nombre, cli_des.apellido) AS cliente_destino,
    cli_des.dni AS dni_destino,
	cue_des.cuenta_id AS cuenta_destino,
    mov.fecha
FROM movimientos mov
JOIN cuentas cue_ori ON cue_ori.cuenta_id = mov.cuenta_origen
JOIN cuentas cue_des ON cue_des.cuenta_id = mov.cuenta_destino
JOIN clientes cli_ori ON cli_ori.cliente_id = cue_ori.cliente_id
JOIN clientes cli_des ON cli_des.cliente_id = cue_des.cliente_id
ORDER BY mov.fecha DESC; 


-- 7. muestra cantidad de cuentas por cliente.
CREATE OR REPLACE VIEW view_cantidad_cuentas AS
SELECT
	cli.dni,
    FULLNAME(cli.nombre, cli.apellido) AS nombre_completo,
    COUNT(cue.cuenta_id) AS cuentas
FROM clientes cli
LEFT JOIN cuentas cue ON cue.cliente_id = cli.cliente_id
GROUP BY cli.dni
ORDER BY cuentas DESC;

-- 8. muestra cantidad de clientes por sucursal.
CREATE OR REPLACE VIEW view_cantidad_clientes AS
SELECT 
	suc.nombre,
    COUNT(cli.cliente_id) AS clientes
FROM clientes cli
JOIN sucursales suc ON suc.sucursal_id = cli.sucursal_id
GROUP BY suc.nombre
ORDER BY clientes DESC;
