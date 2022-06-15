SELECT * FROM persona;

CREATE OR REPLACE PROCEDURE aumentarPuntos(idCliente IN VARCHAR, precio IN FLOAT)
	AS $$
	BEGIN
		UPDATE persona SET cantidad = cantidad + FLOOR(precio * 0.1)::INT WHERE idPersona = idCliente;
	END;
	$$
	Language plpgsql;
	
