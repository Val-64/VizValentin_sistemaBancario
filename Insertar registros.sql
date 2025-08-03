/*
	Inicialización de tablas:
    
	1. Direcciones.
    2. Sucursales.
    3. Clientes.
    4. Cuentas.
*/

USE proyecto_01;

-- 1. Direcciones.

INSERT INTO direcciones(calle, altura, localidad, ciudad) VALUES
('Avenida Rivadavia', 45012, 'Morón', 'Buenos Aires'),
('Tel Aviv', 4401, 'Ituzaingó', 'Buenos Aires'),
('Mariano Acosta', 961, 'Villa Fatima', 'Buenos Aires'),
('C11', 9951, 'Rio Negro', 'Cordoba');

INSERT INTO direcciones (calle, altura, localidad, ciudad) VALUES
('Almte. Guillermo Brown', 851, 'Morón', 'Buenos Aires'),
('Av. Mitre', 5510, 'Caseros', 'Buenos Aires');

INSERT INTO direcciones (calle, altura, localidad, ciudad) VALUES
('Av. Rivadavia', 1234, 'Caballito', 'Buenos Aires'),
('Calle 25 de Mayo', 885, 'Centro', 'Rosario'),
('Av. San Martín', 456, 'Godoy Cruz', 'Mendoza'),
('Calle Belgrano', 1020, 'Centro', 'Córdoba'),
('Av. Libertador', 3201, 'Núñez', 'Buenos Aires'),
('Calle Mitre', 789, 'Microcentro', 'San Miguel de Tucumán'),
('Av. Alem', 2345, 'Centro', 'Bahía Blanca'),
('Calle Sarmiento', 567, 'Centro', 'Santa Fe'),
('Av. Colón', 1580, 'Nueva Córdoba', 'Córdoba'),
('Calle Lavalle', 910, 'Centro', 'Mar del Plata');

-- 2. Sucursales.

INSERT INTO sucursales (direccion, nombre, telefono) VALUES
(1, 'Banco Galicia', '15 0800-1251'),
(5, 'Banco Nación', '15 0800-9961');

-- 3. Clientes,
INSERT INTO clientes (sucursal, direccion, nombre, apellido, dni, fecha_nacimiento, telefono, email) VALUES
(1, 2, 'Ezequiel', 'Ibañez', 38012992, '1994-10-22', '11 6612-8012', 'ezequiel@gmail.com'),
(1, 3, 'Federico', 'Rodriguez', 36051661, '1992-08-12', '15 8521-1206', 'federo@outlook.com'),
(2, 4, 'Agustin', 'Perez', 42551882, '2000-11-29', '11 5125-1965', 'agus_pe@gmail.com');

INSERT INTO clientes (sucursal, direccion, nombre, apellido, dni, fecha_nacimiento, telefono, email) VALUES
(2, 6, 'Gustavo', 'Sisemo', 35072512, '1993-06-04', '11 2672-1112', 'gus@hotmail.com'),
(1, 6, 'Federico', 'Sisemo', 40112151, '2000-04-12', '15 6125-9982', 'fed_sis@outlook.com'),
(2, 7, 'Agostina', 'Perez', 39061221, '1999-07-02', '11 4518-7712', 'agos_perez@gmail.com');

-- 4. Cuentas.
INSERT INTO cuentas (cliente, tipo, moneda, fecha_apertura) VALUES 
(1, 'Caja de ahorro', 'ARG', '2022-05-10'),
(2, 'Caja de ahorro', 'ARG', '2023-10-04'),
(3, 'Cuenta corriente', 'ARG', '2025-02-18'),
(4, 'Caja de ahorro', 'USD', '2020-07-20'),
(5, 'Cuenta corriente', 'USD', '2021-02-10');

/*
UPDATE cuentas 
SET saldo = 50000.17
WHERE cuenta_id = 1;

UPDATE cuentas 
SET saldo = 24861.25
WHERE cuenta_id = 2;

UPDATE cuentas 
SET saldo = 560.10
WHERE cuenta_id = 3;

UPDATE cuentas 
SET saldo = 1050.00
WHERE cuenta_id = 4;

UPDATE cuentas 
SET saldo = 3200.50
WHERE cuenta_id = 5;
*/

/*
DELETE FROM cuentas WHERE cuenta_id > 5
*/