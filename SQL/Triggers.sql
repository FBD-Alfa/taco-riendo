--ALE
---Borrar el TRIGGER
DROP TRIGGER persona_repartidor ON manejar
--Funcion que manda una excepcion si se agregar una persona que no es repartidor a la tabla manejar 
CREATE OR REPLACE FUNCTION preventins_man() RETURNS TRIGGER
AS $$
BEGIN
 IF (SELECT 1 FROM persona WHERE idPersona=NEW.idPersona AND esRepartidor='False') THEN
 RAISE EXCEPTION 'La persona que se desea agregar a la tabla manejar no es un Repartidor';
 END IF;
 RETURN null;
 END
 $$
LANGUAGE plpgsql;
--Trigger persona_repartidor
CREATE TRIGGER persona_repartidor
BEFORE INSERT OR UPDATE ON manejar
FOR EACH ROW
EXECUTE PROCEDURE preventins_man();


---Pruebas para ver que se mande la excepción cuando se inserten datos incorrectos
INSERT INTO manejar(idPersona,noPlacas) VALUES (6063150911,'744UZM6777');
---Pruebas para ver que se mande la excepción cuando se quiera actualizar con datos incorrectos
UPDATE manejar
SET idPersona = 6063150911

--Funcion que manda una excepcion si se agrega o actualiza un transporte que es motocicleta y no
-- tiene datos de la licencia que le debe acompañar 
---Borrar el TRIGGER
DROP TRIGGER motocicleta_licencia ON transporte
CREATE OR REPLACE FUNCTION preventinsup_trans() RETURNS TRIGGER
AS $$
BEGIN
 --IF transporte.esBicicleta='True' AND NEW.noLicencia IS NOT NULL THEN
 --IF (SELECT 1 FROM transporte WHERE esBicicleta='True' AND noLicencia=NEW.noLicencia) THEN
 IF NEW.noLicencia IS NULL AND New.esMotocicleta='True' THEN
   RAISE EXCEPTION 'Las motocicletas deben tener asociada una licencia';
 END IF;
 RETURN null;
 END
 $$
LANGUAGE plpgsql;
--Trigger persona_repartidor
CREATE TRIGGER motocicleta_licencia
BEFORE INSERT OR UPDATE ON transporte
FOR EACH ROW
EXECUTE PROCEDURE preventinsup_trans();

---Pruebas para ver que se mande una excepción si se inserten o actualizan datos de una 
---bicicleta que no viene acompañada de un no. de licencia
INSERT INTO transporte(noPlacas,marca,modelo,esMotocicleta,esBicicleta,noLicencia) 
VALUES ('078AAC','Subaru','italika',true,false,NULL);
---Pruebas para ver que se mande la excepción cuando se quiera actualizar asignando un no de licencia a los repartidores q usan bicicleta
UPDATE transporte
SET noLicencia =NULL WHERE noPlacas='069AMB' AND esMotocicleta='True';

select * from transporte
where esMotocicleta='true';

---GAEL---

--Monitoreo de pago con puntos cuando no es a domicilio
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
    END
    $$
LANGUAGE plpgsql;
--Creación del disparador
CREATE TRIGGER chequeo_puntos
AFTER INSERT ON ticket
FOR EACH ROW
EXECUTE PROCEDURE effective_payment();


--Monitoreo de que el ticket sea pagado por el cliente
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
    END
    $$
LANGUAGE plpgsql;
--Creación del disparador
CREATE TRIGGER comida_gratis
AFTER INSERT ON ticket
FOR EACH ROW
EXECUTE PROCEDURE free_meal();