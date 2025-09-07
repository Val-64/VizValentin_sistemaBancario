/*
	Insertar registros en las tablas:
    
    1. Sucursales.
    2. Clientes.
    3. Cuentas.
    4. Movimientos.
        a. Depositos.
        b. Retiros.
        c. Transferencias.
*/

USE sist_bancario;

-- 1. Insertar registros en tabla -sucursales-.
INSERT INTO sucursales (nombre, telefono, calle, altura) VALUES
('Suc. Rivadavia Norte', '15 0800-1251', 'Avenida Rivadavia', 10445),
('Suc. Regional Acosta', '15 0800-6001', 'Mariano Acosta', 5423),
('Suc. Eva Perón', '15 0800-9961', 'Av. Eva Perón', 5512);

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

-- 3. Cuentas.
INSERT INTO cuentas (cliente_id, tipo, moneda) VALUES 
(1, 'Caja de ahorro', 'ARG'),
(2, 'Caja de ahorro', 'ARG'),
(3, 'Cuenta corriente', 'ARG'),
(4, 'Caja de ahorro', 'USD'),
(5, 'Cuenta corriente', 'USD'),
(2, 'Caja de ahorro', 'USD'),
(9, 'Cuenta corriente', 'ARG'),
(10, 'Cuenta corriente', 'USD'),
(3, 'Caja de ahorro', 'ARG');

-- 4. Movimientos.
--  a. Depositos.
INSERT INTO movimientos (cuenta_destino, tipo_movimiento, monto) VALUES
(1, 'Deposito', 10000.00),
(3, 'Deposito', 5500.00),
(4, 'Deposito', 500.00);

-- b. Extracciones.
INSERT INTO movimientos (cuenta_origen, tipo_movimiento, monto) VALUES
(1, 'Retiro', 1000),
(1, 'Retiro', 100);

-- c. Tranferencias.
INSERT INTO movimientos (cuenta_origen, cuenta_destino, monto, descripcion) VALUES
(1, 2, 3500, 'Varios'),
(2, 7, 1000, 'Expensas'),
(4, 5, 50, 'Varios'),
(1, 9, 3000, 'Comercial');















