/*
	a. Cración de base de datos
    b. Creación de tablas
        1. Sucursales.
        2. Clientes.
        3. Cuentas.
        4. Movimientos.
        5. Logs de clientes.
        6. Logs de cuentas.
*/
-- a. Creacion de base de datos
CREATE DATABASE IF NOT EXISTS sist_bancario;
USE sist_bancario;

-- b. Creacion de tablas.

-- 1. Sucursales.
CREATE TABLE IF NOT EXISTS sucursales(
	sucursal_id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    calle VARCHAR(80) NOT NULL,
    altura INT UNSIGNED NOT NULL,
    
    PRIMARY KEY(sucursal_id)
);

-- 2. Clientes.
CREATE TABLE IF NOT EXISTS clientes(
	cliente_id INT AUTO_INCREMENT,
    sucursal_id INT,
    
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    dni INT UNSIGNED UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    
	telefono VARCHAR(30) DEFAULT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    
	PRIMARY KEY(cliente_id),
    FOREIGN KEY(sucursal_id) REFERENCES sucursales(sucursal_id)
);

-- 3. Cuentas.
CREATE TABLE IF NOT EXISTS cuentas(
	cuenta_id INT AUTO_INCREMENT,
    cliente_id INT,
    tipo ENUM('Caja de ahorro', 'Cuenta corriente') NOT NULL,
    moneda ENUM('USD', 'ARG') NOT NULL,
    saldo DECIMAL(10, 2) UNSIGNED DEFAULT 0,
    
    PRIMARY KEY(cuenta_id),
    FOREIGN KEY(cliente_id) REFERENCES clientes(cliente_id)
);

-- 4. Movimientos.
CREATE TABLE IF NOT EXISTS movimientos(
	movimiento_id INT AUTO_INCREMENT,
	cuenta_origen INT,
    cuenta_destino INT,
    tipo_movimiento ENUM('Transferencia', 'Deposito', 'Retiro') NOT NULL DEFAULT ('Transferencia'),
    monto DECIMAL(12,2) UNSIGNED NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(100),
    
    PRIMARY KEY(movimiento_id),
    FOREIGN KEY(cuenta_origen) REFERENCES cuentas(cuenta_id),
    FOREIGN KEY(cuenta_destino) REFERENCES cuentas(cuenta_id)
);

-- 5. Logs de clientes.
CREATE TABLE IF NOT EXISTS cliente_logs(
	log_id INT AUTO_INCREMENT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('Agregado', 'Eliminado', 'Modificado') NOT NULL,
    cliente_id INT,
    nombre_completo VARCHAR(100),
    dni INT,
    
	PRIMARY KEY(log_id),
    FOREIGN KEY(cliente_id) REFERENCES clientes(cliente_id)
);

-- 6. Logs de cuentas.
CREATE TABLE IF NOT EXISTS cuenta_logs(
	log_id INT AUTO_INCREMENT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('Agregado', 'Eliminado', 'Modificado') NOT NULL,
    cuenta_id INT,
    tipo VARCHAR(50),
    moneda VARCHAR(10),
    cliente_id INT,
    cliente_dni INT,
    
	PRIMARY KEY(log_id),
    FOREIGN KEY(cuenta_id) REFERENCES cuentas(cuenta_id),
    FOREIGN KEY(cliente_id) REFERENCES clientes(cliente_id)
);



