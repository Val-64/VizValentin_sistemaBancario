/*
	a. Cración de base de datos
    b. Creación de tablas
        1. Sucursales.
        2. Clientes.
        3. Cuentas.
        4. Movimientos.
*/

-- a. Creación de base de datos.
CREATE DATABASE IF NOT EXISTS proyecto_01;
USE proyecto_01;

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
	fecha_apertura DATE NOT NULL,
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

CREATE TABLE IF NOT EXISTS cliente_logs(
	log_id INT AUTO_INCREMENT,
    cliente_id INT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('Agregado', 'Eliminado', 'Modificado') NOT NULL,
    
	PRIMARY KEY(log_id),
    FOREIGN KEY(cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE IF NOT EXISTS cuenta_logs(
	log_id INT AUTO_INCREMENT,
    cuenta_id INT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('Agregado', 'Eliminado', 'Modificado') NOT NULL,
    
	PRIMARY KEY(log_id),
    FOREIGN KEY(cuenta_id) REFERENCES cuentas(cuenta_id)
);



