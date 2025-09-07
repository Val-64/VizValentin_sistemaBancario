/*
	Creación de procedimientos almacenados, Stored Procedures.
    
    1. Insersiones Generales.
		a. SUCURSALES.
        b. CLIENTES.
        c. CUENTAS.
        d. MOVIMIENTOS.
			d-1. Transferencias.
            d-2. Depositos.
            d-3- Retiros.
	2. Búsquedas parametrizadas.
		a. SUCURSALES
			a-2. Buscar id por nombre.
			a-3. Listar clientes por sucursal.
		b. CLIENTES
			b-1. Buscar cliente por ID.
            b-2. Buscar cliente por DNI.
            b-3. Listar cuentas por cliente.
        c. CUENTAS
			c-1. Buscar cuenta por ID.
		d. MOVIMIENTOS
			d-1. Buscar movimientos por fecha.
	3. Insersiones a tablas LOGS
		a. CLIENTE
        b. CUENTA

*/
USE sist_bancario;

-- --------------------- 1. Insersiones generales. --------------------- --

-- a. SUCURSALES.
DELIMITER //
CREATE PROCEDURE insertar_sucursal(
	IN p_nombre VARCHAR(50),
	IN p_telefono VARCHAR(30),
	IN p_calle VARCHAR(80),
	IN p_altura INT
)BEGIN
	INSERT INTO sucursales VALUES 
    (DEFAULT, p_nombre, p_telefono, p_calle, p_altura);
    
    SELECT LAST_INSERT_ID() AS id_sucursal_insertada;
    
END //

-- b. CLIENTES.
DELIMITER //
CREATE PROCEDURE insertar_cliente(
	IN p_nombre_sucursal VARCHAR(50),
    IN p_nombre VARCHAR(40),
    IN p_apellido VARCHAR(40),
    IN p_dni INT,
    IN p_nacimiento DATE,
    IN p_telefono VARCHAR(30),
    IN p_email VARCHAR(80)
)BEGIN
	
    DECLARE var_sucursal_id INT;
    
    CALL buscar_id_sucursal(p_nombre_sucursal, var_sucursal_id);

	INSERT INTO clientes VALUES 
    (DEFAULT, var_sucursal_id, p_nombre, p_apellido, p_dni, p_nacimiento, p_telefono, p_email);
    
    SELECT LAST_INSERT_ID() AS id_cliente_insertado;
    
END //

-- c. CUENTAS.
DELIMITER //
CREATE PROCEDURE insertar_cuenta(
	IN p_cliente_id INT,
    IN p_tipo ENUM('Caja de ahorro', 'Cuenta corriente'),
    IN p_moneda ENUM('USD', 'ARG'),
    IN p_apertura DATE,
    IN p_saldo DECIMAL(10, 2)
)BEGIN
	INSERT INTO cuentas VALUES
    (DEFAULT, p_cliente_id, p_tipo, p_moneda, p_apertura, p_saldo);
    
	SELECT LAST_INSERT_ID() AS id_cuenta_insertada;

END //

-- d. MOVIMIENTOS

--    d-1. Transferencias
DELIMITER //
CREATE PROCEDURE insertar_transferencia(
	IN p_origen INT,
    IN p_destino INT,
    IN p_monto DECIMAL(10, 2),
    IN p_descrip VARCHAR(100)
)BEGIN
	DECLARE movimiento VARCHAR(20);
    SET movimiento = 'Transferencia';
    
    INSERT INTO movimientos VALUES
    (DEFAULT, p_origen, p_destino, movimiento, p_monto, CURRENT_TIMESTAMP, p_descrip);

	SELECT LAST_INSERT_ID() AS id_transferencia_realizada;
END//

--    d-1. Depositos
DELIMITER //
CREATE PROCEDURE insertar_deposito(
	IN p_destino INT,
	IN p_monto DECIMAL(12, 2)
)BEGIN
	DECLARE movimiento VARCHAR(20);
    SET movimiento = 'Deposito';
    
    INSERT INTO movimientos VALUES
    (DEFAULT, NULL, p_destino, movimiento, p_monto, CURRENT_TIMESTAMP, NULL);

END//

--    d-1. Retiros
DELIMITER //
CREATE PROCEDURE insertar_retiro(
	IN p_origen INT,
	IN p_monto DECIMAL(12, 2)
)BEGIN
	DECLARE movimiento VARCHAR(20);
    SET movimiento = 'Retiro';
    
    INSERT INTO movimientos VALUES
    (DEFAULT, p_origen, NULL, movimiento, p_monto, CURRENT_TIMESTAMP, NULL);

END//

-- --------------------- 2. Búsquedas parametrizadas --------------------- --

-- a. SUCURSALES.
--    a-1. Buscar id por nombre.
DELIMITER //
CREATE PROCEDURE buscar_id_sucursal(
	IN p_nombre VARCHAR(50),
    OUT p_id INT
)BEGIN

	SELECT sucursal_id
	INTO p_id
    FROM sucursales	
    WHERE nombre = p_nombre
    LIMIT 1;

END//
--    a-2. Listar clientes por sucursal.

DELIMITER //
CREATE PROCEDURE listar_clientes_por_sucursal(
	p_sucursal_id INT
)BEGIN
	SELECT
		sucursal, id, cliente, dni, telefono, email
    FROM view_clientes 
    WHERE sucursal_id = p_sucursal_id;
END//

-- b. CLIENTES.
--    b-1. Buscar cliente por ID.
DELIMITER //
CREATE PROCEDURE buscar_cliente_por_id(
	p_cliente_id INT
)BEGIN

	SELECT 
		suc.sucursal_id AS no_sucursal,
        suc.nombre AS sucursal,
        FULLNAME(cli.nombre, cli.apellido) AS cliente,
        cli.telefono,
        cli.email
	FROM clientes cli
    JOIN sucursales suc ON cli.sucursal_id = suc.sucursal_id
    WHERE cli.cliente_id = p_cliente_id;
    
END//

--    b-2. Buscar cliente por DNI.
DELIMITER //
CREATE PROCEDURE buscar_cliente_por_dni(
	p_dni INT
)BEGIN
	
    SELECT 
		cliente_id AS id,
		FULLNAME(nombre, apellido) AS cliente,
        telefono,
        email
	FROM clientes
    WHERE dni = p_dni;
    
END//

--    b-3. Listar cuentas por cliente.
DELIMITER //
CREATE PROCEDURE listar_cuentas_cliente(
	p_cliente_id INT
)BEGIN
	SELECT
		dni,
		cliente,
        id,
        tipo,
        moneda
	FROM view_cuentas
    WHERE cliente_id = p_cliente_id;
    
END//

-- c. CUENTAS
--    c-1. Buscar cuenta por ID.
DELIMITER //
CREATE PROCEDURE buscar_cuenta_por_id(
	p_cuenta_id INT
)BEGIN
	SELECT
		cli.cliente_id,
		FULLNAME(cli.nombre, cli.apellido) AS cliente,
        cue.tipo,
        cue.moneda,
        cue.saldo
	FROM cuentas cue
    JOIN clientes cli ON cue.cliente_id = cli.cliente_id
    WHERE cue.cuenta_id = p_cuenta_id;
		
END//


-- d. MOVIMIENTOS
--    d-1. Buscar movimientos por fecha.
DELIMITER //
CREATE PROCEDURE buscar_movs_por_fecha(
	p_fecha DATE 
)BEGIN
     SELECT * FROM view_movimientos
     WHERE fecha LIKE CONCAT(p_fecha,'%');
		
END//

-- 3. Insersiones a tablas LOGS

--    a. Tabla de clientes.
DELIMITER //
CREATE PROCEDURE registrar_cliente(
	p_cliente_id INT,
    p_accion ENUM('Agregado', 'Eliminado', 'Modificado'),
	p_nombre_completo VARCHAR(100),
    p_dni INT
)BEGIN
	INSERT INTO cliente_logs VALUES
    (DEFAULT, CURRENT_TIMESTAMP, p_accion, p_cliente_id, p_nombre_completo, p_dni);
    
END//

-- b. Tabla de cuentas
DELIMITER //
CREATE PROCEDURE registrar_cuenta(
	p_cuenta_id INT,
    p_accion ENUM('Agregado', 'Eliminado', 'Modificado'),
	p_tipo VARCHAR(50),
    p_moneda VARCHAR(10),
    p_cliente_id INT,
    p_dni INT
)BEGIN
	INSERT INTO cuenta_logs VALUES
    (DEFAULT, CURRENT_TIMESTAMP, p_accion, p_cuenta_id, p_tipo, p_moneda, p_cliente_id, p_dni);
    
END//







