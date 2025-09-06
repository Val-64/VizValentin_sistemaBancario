/*
	Funciones.
    

*/


-- Funcion destinada a concatenar nombre y apellido de clientes.
DELIMITER //
CREATE FUNCTION FULLNAME(nombre VARCHAR(50), apellido VARCHAR(50)) 
RETURNS VARCHAR(102)
DETERMINISTIC
BEGIN
	RETURN CONCAT(nombre, ' ', apellido);
END//




