/*
	Insertar registros en las tablas:
    
    1. Sucursales.
    2. Clientes.
    3. Cuentas.
*/

USE proyecto_01;

-- 1. Insertar registros en tabla -sucursales-.
INSERT INTO sucursales (nombre, telefono, calle, altura) VALUES
('Banco Santander', '15 0800-1251', 'Avenida Rivadavia', 10445),
('Banco Francés', '15 0800-6001', 'Mariano Acosta', 5423),
('Banco Nación', '15 0800-9961', 'Calle Mitre', 851);

-- 2. Insertar registros en tabla -clientes-.
INSERT INTO clientes (sucursal_id, nombre, apellido, dni, fecha_nacimiento, telefono, email) VALUES
(1, 'Ezequiel', 'Ibañez', 15437892, '1987-03-15', '11 6612-8012', 'eze.iba@gmail.com'),
(3, 'Federico', 'Rodriguez', 17300987, '1991-06-02', '15 8521-1206', 'federo@outlook.com'),
(2, 'Agustin', 'Perez', 24679801, '2004-11-23', '11 5125-1965', 'agus_pe@gmail.com'),
(1, 'Gustavo', 'Santo', 21345678, '2000-01-10', '11 2672-1112', 'gus@hotmail.com'),
(1, 'Federico', 'Sanchez', 18765432, '1994-08-05', '15 6125-9982', 'fed_sis@outlook.com'),
(3, 'Agostina', 'Pizzini', 30456789, '2000-07-19', '11 4518-7712', 'pizzini_ag@gmail.com'),
(2, 'Juan', 'Toledo', 33890123, '2003-12-01', '11 9052-2215', 'juan@outlook.com'),
(1, 'Joaquin', 'Alvear', 36547890, '2001-04-30', '11 1226-9910', 'joa@hotmail.com'),
(3, 'Agustina', 'Pixis', 40234567, '2000-09-09', '11 1151-7721', 'agus_tina@gmail.com'),
(2, 'Martina', 'Estefania', 10045678, '1976-11-14', '15 5123-4321', 'stefany@hotmail.com');

-- 4. Cuentas.
INSERT INTO cuentas (cliente_id, tipo, moneda, fecha_apertura) VALUES 
(1, 'Caja de ahorro', 'ARG', '2022-05-10'),
(2, 'Caja de ahorro', 'ARG', '2023-10-04'),
(3, 'Cuenta corriente', 'ARG', '2025-02-18'),
(4, 'Caja de ahorro', 'USD', '2020-07-20'),
(5, 'Cuenta corriente', 'USD', '2021-02-10'),
(2, 'Caja de ahorro', 'USD', '2024-10-06'),
(9, 'Cuenta corriente', 'ARG','2024-03-06'),
(10, 'Cuenta corriente', 'USD', '2021-07-15'),
(3, 'Caja de ahorro', 'ARG', '2025-02-19');