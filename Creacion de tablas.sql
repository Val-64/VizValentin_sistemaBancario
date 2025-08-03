/*
	a. Cración de base de datos
    b. Creación de tablas
		1. Direcciones.
        2. Sucursales.
        3. Clientes.
        4. Cuentas.
*/

-- (a). Creación de base de datos.
CREATE DATABASE IF NOT EXISTS proyecto_01;
USE proyecto_01;

-- (b). Creacion de tablas.
-- (1). Direcciones.
CREATE TABLE IF NOT EXISTS direcciones(
	direccion_id INT AUTO_INCREMENT,
    calle VARCHAR(80) NOT NULL,
    edificio VARCHAR(50) DEFAULT NULL,
    piso VARCHAR(4) DEFAULT NULL,
    altura INT UNSIGNED NOT NULL,
    localidad VARCHAR(80) NOT NULL,
    ciudad VARCHAR(80) NOT NULL,

	PRIMARY KEY(direccion_id)
);

-- (2). Sucursales.
CREATE TABLE IF NOT EXISTS sucursales(
	sucursal_id INT AUTO_INCREMENT,
    direccion INT,
    nombre VARCHAR(50),
    telefono VARCHAR(30),
    
    PRIMARY KEY(sucursal_id),
    FOREIGN KEY(direccion) REFERENCES direcciones(direccion_id)
);

-- (3). Clientes.
CREATE TABLE IF NOT EXISTS clientes(
	cliente_id INT AUTO_INCREMENT,
    sucursal INT,
    direccion INT,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    dni INT UNSIGNED UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
	telefono VARCHAR(30) DEFAULT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    
	PRIMARY KEY(cliente_id),
    FOREIGN KEY(sucursal) REFERENCES sucursales(sucursal_id),
    FOREIGN KEY(direccion) REFERENCES direcciones(direccion_id)
);

-- (4). Cuentas.
CREATE TABLE IF NOT EXISTS cuentas(
	cuenta_id INT AUTO_INCREMENT,
    cliente INT,
    tipo ENUM('Caja de ahorro', 'Cuenta corriente', 'Cuenta sueldo') NOT NULL,
    moneda ENUM('USD', 'ARG') NOT NULL,
	fecha_apertura DATE NOT NULL,
    
    PRIMARY KEY(cuenta_id),
    FOREIGN KEY(cliente) REFERENCES clientes(cliente_id)
);

ALTER TABLE cuentas ADD saldo DECIMAL(10,2) UNSIGNED DEFAULT 0;
