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

--LECT subtotalTicket('25795865')
             
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
	
	
CREATE OR REPLACE FUNCTION puntoValido() RETURNS TRIGGER
AS 
$$
BEGIN
  IF (SELECT 1 FROM persona WHERE idPersona=NEW.idPersona AND noPuntos < subtotalTicket(New.idTicket))THEN
      RAISE EXCEPTION 'La persona que se desea agregar a la tabla manejar no es un Repartidor';
  END IF;
  RETURN null;
  END;
  $$
LANGUAGE plpgsql;

--procedimiento que aumenta el sueldo en 1500 el salario a aprtir de 2 años

CREATE OR REPLACE PROCEDURE aumentarSueldo()
	AS $$
	BEGIN
		UPDATE persona
		SET salario=salario +1500 
		WHERE antiguedad > 2;
	END;
	$$
	Language plpgsql;
--ELECT salario , antiguedad,idPersona FROM persona WHERE idPersona=6063150911 OR idPersona=2359755788;
call aumentarSueldo();

CREATE OR REPLACE FUNCTION clientenull() RETURNS TRIGGER
 AS $$
 DECLARE 
 nombro varchar;
 rfcc varchar;
 correoo varchar;
 telefonoo int;
 estadoo varchar;
 callee varchar;
 municipioo varchar;
 numeroo int;
 cpp int;
 BEGIN
 SELECT nombreSucursal INTO nombro FROM sucursal;
  SELECT rfc INTO rfcc FROM sucursal;
   SELECT correo INTO correoo FROM sucursal;
    SELECT telefono INTO telefonoo FROM sucursal;
	 SELECT estado  INTO estadoo FROM sucursal;
	  SELECT calle INTO callee FROM sucursal;
	  SELECT municipio INTO municipioo FROM sucursal;
	  SELECT numero INTO numeroo FROM sucursal;
	  SELECT cp INTO cpp FROM sucursal;
	 UPDATE persona 
	 SET nombre = nombro,
	 rfc = rfcc,
	 correo = correoo,
	 telefono = telefonoo,
	 estado = estadoo,
	 calle= callee,
	 municipio = municipioo,
	 numero = numeroo,
	 cp = cpp
	 WHERE idPersona = 0;
	 END;
	 $$
	 Language plpgsql;
 select * FROM persona WHERE idPersona= 0;

CREATE OR REPLACE TRIGGER nullcliente
BEFORE INSERT ON persona
FOR EACH ROW
EXECUTE PROCEDURE clientenull();