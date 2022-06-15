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