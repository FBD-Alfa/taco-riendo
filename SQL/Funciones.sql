--------------------------------------------------------
CREATE OR REPLACE FUNCTION precioActualPlatillo(idPlatillo varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		precio FLOAT;
	BEGIN
		RETURN(SELECT SUM(pp.precio) 
                  FROM precioPlatillo pp
                  WHERE idProducto = idPlatillo AND fecha = (SELECT MAX(fecha) FROM precioPlatillo WHERE idProducto=idPlatillo));
	END;
	$$
	Language plpgsql;

--SELECT precioActualPlatillo('1');


CREATE OR REPLACE FUNCTION subtotalTicket(idTicketP varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		sumaPlatillo FLOAT;
        sumaSalsa FLOAT;
	BEGIN
		RETURN( SELECT SUM(precio) FROM (SELECT sum(precioActualPlatillo(IP.idProducto)) AS precio 
                        FROM incluirPlatillo IP 
                        WHERE idTicket =idTicketP
          UNION 
                    SELECT sum(precioActualSalsa(IP.idProducto)) AS precio 
                        FROM incluirSalsa IP
                        WHERE idTicket =idTicketP) as subcons   
                        );
	END;
	$$
	Language plpgsql;

--SELECT subtotalTicket('25795865')
             
--------------------------------------
CREATE OR REPLACE FUNCTION precioActualSalsa(idSalsa varchar)
	RETURNS FLOAT
	AS $$
	DECLARE
		precio FLOAT;
	BEGIN
		RETURN( SELECT SUM(pp.precio)
                  FROM precioSalsa pp
                  WHERE idProducto = idSalsa AND fecha = (SELECT MAX(fecha) FROM precioSalsa WHERE idProducto=idSalsa));
	END;
	$$
	Language plpgsql;
    
--SELECT precioActualSalsa('1');