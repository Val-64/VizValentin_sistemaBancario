/*
	Triggers
	
	1. INSERSIONES.
		a. CLIENTES.
        b. CUENTAS.
    
*/

USE sist_bancario;

-- 1. INSERSIONES.

--    a. CLIENTES.
DELIMITER //
CREATE TRIGGER insertar_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN

	CALL registrar_cliente(
    NEW.cliente_id, 'Agregado', FULLNAME(NEW.nombre, NEW.apellido), NEW.dni);

END;//

--    a. CUENTAS.
DELIMITER //
CREATE TRIGGER insertar_cuenta
AFTER INSERT ON cuentas
FOR EACH ROW
BEGIN

	CALL registrar_cuenta(
		NEW.cuenta_id,
        'Agregado',
        NEW.tipo,
        NEW.moneda,
        NEW. cliente_id,
        (SELECT dni FROM clientes WHERE cliente_id = NEW.cliente_id)
    );

END;//