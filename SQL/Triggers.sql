-- Funcion que es llamada por el trigger atendio_mesero.
CREATE OR REPLACE FUNCTION es_mesero() RETURNS TRIGGER
AS
$$
DECLARE
    idPosibleMesero BIGINT;
    esMeseroP BOOLEAN;
    BEGIN
    IF (TG_OP = 'INSERT') THEN
    SELECT idMesero INTO idPosibleMesero FROM ticket
    WHERE idTicket = NEW.idTicket;
    SELECT esMesero INTO esMeseroP FROM persona
    WHERE idPersona = idPosibleMesero;
       IF NOT esMeseroP THEN
          RAISE EXCEPTION 'El id no pertenece a un mesero.';
       END IF;
    END IF;
    IF (TG_OP = 'UPDATE') THEN
    SELECT idMesero INTO idPosibleMesero FROM ticket
    WHERE idTicket = NEW.idTicket;
    SELECT esMesero INTO esMeseroP FROM persona
    WHERE idPersona = idPosibleMesero;
       IF NOT esMeseroP THEN
          RAISE EXCEPTION 'El id no pertenece a un mesero';
       END IF;
    END IF;
RETURN null;
END
$$
LANGUAGE plpgsql;
-- Triger que verifica que los tickets sean atendidos por un mesero.
CREATE OR REPLACE TRIGGER atendio_mesero
BEFORE INSERT OR UPDATE ON ticket
FOR EACH ROW
EXECUTE PROCEDURE es_mesero();

-- Pruebas
INSERT INTO ticket(idTicket,idSucursal,idPersona,idMesero,fecha,aDomicilio,tipoPago) 
VALUES ('12247777',1,6063150911,1332119756,'2022-06-14',False,'Efectivo');
UPDATE ticket
SET idMesero = 1332119756
WHERE idTicket = '10094739'
--INTO ticket(idTicket,idSucursal,idPersona,idMesero,fecha,aDomicilio,tipoPago) 
--VALUES ('12247888',1,6063150911,3714859906,'2022-06-14',False,'Efectivo');