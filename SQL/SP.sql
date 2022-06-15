SELECT * FROM persona;

CREATE OR REPLACE PROCEDURE aumentarPuntos(idCliente IN BIGINT, precio IN FLOAT)
	AS $$
	BEGIN
		UPDATE persona SET noPuntos = noPuntos + FLOOR(precio * 0.1)::INT WHERE idPersona = idCliente;
	END;
	$$
	Language plpgsql;
    
CALL aumentarPuntos(1332119756,578.98);
	
