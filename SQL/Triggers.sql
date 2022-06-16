--ALE
--Borrar el TRIGGER
--DROP TRIGGER persona_repartidor ON manejar
--Funcion que manda una excepcion si se agregar una persona que no es repartidor a la tabla manejar 
CREATE OR REPLACE FUNCTION preventins_man() RETURNS TRIGGER
AS 
$$
BEGIN
  IF (SELECT 1 FROM persona WHERE idPersona=NEW.idPersona AND esRepartidor='False') THEN
      RAISE EXCEPTION 'La persona que se desea agregar a la tabla manejar no es un Repartidor';
  END IF;
  RETURN null;
  END;
  $$
LANGUAGE plpgsql;
--Trigger persona_repartidor
CREATE OR REPLACE TRIGGER persona_repartidor
BEFORE INSERT OR UPDATE ON manejar
FOR EACH ROW
EXECUTE PROCEDURE preventins_man();

--Funcion que manda una excepcion si se agrega o actualiza un transporte que es motocicleta y no
--tiene datos de la licencia que le debe acompañar 
--Borrar el TRIGGER
--DROP TRIGGER motocicleta_licencia ON transporte
CREATE OR REPLACE FUNCTION preventinsup_trans() RETURNS TRIGGER
AS
$$
BEGIN
 --IF (SELECT 1 FROM transporte WHERE esBicicleta='True' AND noLicencia=NEW.noLicencia) THEN
 IF NEW.noLicencia IS NULL AND New.esMotocicleta='True' THEN
   RAISE EXCEPTION 'Las motocicletas deben tener asociada una licencia';
 END IF;
 RETURN null;
 END;
 $$
LANGUAGE plpgsql;
--Trigger persona_repartidor
CREATE OR REPLACE TRIGGER motocicleta_licencia
BEFORE INSERT OR UPDATE ON transporte
FOR EACH ROW
EXECUTE PROCEDURE preventinsup_trans();

--GAEL---

--Monitoreo de pago con puntos cuando no es a domicilio
--DROP TRIGGER chequeo_puntos ON ticket
CREATE OR REPLACE FUNCTION effective_payment() RETURNS TRIGGER
AS
$$
DECLARE
    esadomicilio boolean;
    tipodepago varchar(50);
    BEGIN
    IF(TG_OP = 'INSERT') THEN
    SELECT adomicilio INTO esadomicilio FROM ticket
    WHERE idticket = NEW.idticket;
    SELECT tipopago INTO tipodepago FROM ticket
    WHERE idticket = NEW.idticket;
    IF esadomicilio = TRUE and tipodepago = 'Puntos' THEN
    RAISE EXCEPTION  'NO PUEDE PAGAR CON PUNTOS, TIENE QUE CONSUMIR EN LA SUCURSAL';
    END IF;
    END IF;
    RETURN null;
    END;
    $$
LANGUAGE plpgsql;
--Creación del disparador
CREATE OR REPLACE TRIGGER chequeo_puntos
AFTER INSERT ON ticket
FOR EACH ROW
EXECUTE PROCEDURE effective_payment();


--Monitoreo de que el ticket sea pagado por el cliente
--DROP TRIGGER comida_gratis ON ticket
CREATE OR REPLACE FUNCTION free_meal() RETURNS TRIGGER
AS
$$
DECLARE
    persona bigint;
    mesero bigint;
    pago varchar(50);
    BEGIN
    IF(TG_OP = 'INSERT') THEN
    SELECT idpersona INTO persona FROM ticket
    WHERE idticket = NEW.idticket;
    SELECT idmesero INTO mesero FROM ticket
    WHERE idticket = NEW.idticket;
    SELECT tipopago INTO pago FROM ticket
    WHERE idticket = NEW.idticket;
    IF persona = mesero and pago != NULL THEN
    RAISE EXCEPTION  'EL TRABAJADOR NO PAGA POR SUS ALIMENTOS';
    END IF;
    END IF;
    RETURN null;
    END;
    $$
LANGUAGE plpgsql;
--Creación del disparador
CREATE OR REPLACE TRIGGER comida_gratis
AFTER INSERT ON ticket
FOR EACH ROW
EXECUTE PROCEDURE free_meal();

-- LIZ
-- Función es_mesero, manda una excepción en caso de que la persona que se quiere agregar como
-- mesero al ticket no este registrado como tal.
CREATE OR REPLACE FUNCTION es_mesero() RETURNS TRIGGER
AS
$$
BEGIN
  IF (SELECT 1 FROM persona WHERE idPersona=NEW.idMesero AND esMesero='False') THEN
      RAISE EXCEPTION 'La persona que se desea agregar al ticket no es un mesero';
  END IF;   
RETURN null;
END
$$
LANGUAGE plpgsql;
-- Triger que verifica que los tickets sean atendidos por un mesero llamdo
-- a la función es_mesero.
CREATE OR REPLACE TRIGGER atendio_mesero
AFTER INSERT OR UPDATE ON ticket
FOR EACH ROW
EXECUTE PROCEDURE es_mesero();
 -- Funcion que es llamada por proveido_proveedor, se encarga de que la 
 -- persona que se agregue a la relación proveer sea un proveedor, en 
 -- caso contrario lanza una excepción.
CREATE OR REPLACE FUNCTION es_proveedor() RETURNS TRIGGER
AS 
$$
BEGIN
  IF (SELECT 1 FROM persona WHERE idPersona=NEW.idProveedor AND esProveedor='False') THEN
      RAISE EXCEPTION 'La persona que se desea agregar o actualizar no es un proveedor';
  END IF;
  RETURN null;
  END;
  $$
LANGUAGE plpgsql;
-- Triger que verifica que los insumos sean vendidos por un proveedor,
-- manda a llamar a la función es_proveedor.
CREATE OR REPLACE TRIGGER proveido_proveedor
BEFORE INSERT OR UPDATE ON proveer
FOR EACH ROW
EXECUTE PROCEDURE es_proveedor();

 -- Funcion que es llamada por el trigger empleado_sucursal, se encarga de que 
 -- solo los empleados tengan una sucursal asignada.
CREATE OR REPLACE FUNCTION es_empleado() RETURNS TRIGGER
AS 
$$
BEGIN
  IF NEW.idSucursal IS NOT NULL AND New.esEmpleado='False' THEN
   RAISE EXCEPTION 'Solo los empleados pueden tener una sucursal asociada';
 END IF;
  RETURN null;
  END;
  $$
LANGUAGE plpgsql;
-- Triger que verifica que solo los empleados tengan sucursal, 
-- manda a llamar a la función es_empleado.
CREATE OR REPLACE TRIGGER empleado_sucursal
BEFORE INSERT OR UPDATE ON persona
FOR EACH ROW
EXECUTE PROCEDURE es_empleado();

--trigger que dispara la funcion de clienenull();
CREATE OR REPLACE TRIGGER nullcliente
BEFORE INSERT ON persona
FOR EACH ROW
EXECUTE PROCEDURE clientenull();