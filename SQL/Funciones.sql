CREATE OR REPLACE FUNCTION subtotalTicket(idTicketP varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		sumaPlatillo FLOAT;
        sumaSalsa FLOAT;
	BEGIN
		sumaPlatillo := SELECT SUM(precio)
                        FROM (incluirPlatillo, precioActualPlatillo(idProducto) AS precio)
                        WHERE idTicket = idTicketP;
        sumaSalsa := SELECT SUM(precio)
                        FROM (incluirPlatillo, precioActualSalsa(idProducto) AS precio)
                        WHERE idTicket = idTicketP;
		return resultado;
	END;
	$$
	Language plpgsql;

CREATE OR REPLACE FUNCTION precioActualPlatillo(idPlatillo varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		precio FLOAT;
	BEGIN
		precio := SELECT SUM(precio)
                  FROM precioPlatillo, 
                  WHERE idProducto = idPlatillo AND fecha = MAX(fecha);
		return resultado;
	END;
	$$
	Language plpgsql;

CREATE OR REPLACE FUNCTION precioActualSalsa(idSalsa varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		precio FLOAT;
	BEGIN
		precio := SELECT SUM(precio)
                  FROM precioPlatillo, 
                  WHERE idProducto = idPlatillo AND fecha = MAX(fecha);
		return resultado;
	END;
	$$
	Language plpgsql;