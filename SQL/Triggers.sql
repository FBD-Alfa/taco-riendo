/*------------------------------------------------------------------------
 --------------------------[ Triggers Ticket ]----------------------------
 -----------------------------------------------------------------------*/
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
AFTER INSERT OR UPDATE ON ticket
FOR EACH ROW
EXECUTE PROCEDURE es_mesero();

-- Pruebas
/*INSERT INTO ticket(idTicket,idSucursal,idPersona,idMesero,fecha,aDomicilio,tipoPago) 
VALUES ('12247777',1,6063150911,1332119756,'2022-06-14',False,'Efectivo');*/
/*UPDATE ticket
SET idMesero = 1332119756
WHERE idTicket = '10094739'*/
/*INTO ticket(idTicket,idSucursal,idPersona,idMesero,fecha,aDomicilio,tipoPago) 
VALUES ('12247888',1,6063150911,3714859906,'2022-06-14',False,'Efectivo');*/

/*------------------------------------------------------------------------
 -------------------------[ Triggers Proveer ]----------------------------
 -----------------------------------------------------------------------*/
-- Funcion que es llamada por el trigger proveido_proveedor.
CREATE OR REPLACE FUNCTION es_proveedor() RETURNS TRIGGER
AS
$$
DECLARE
    idPosibleProveedor BIGINT;
    esProveedorP BOOLEAN;
    BEGIN
    IF (TG_OP = 'INSERT') THEN
    SELECT idProveedor INTO idPosibleProveedor FROM proveer
    WHERE idInsumo = NEW.idInsumo;
    SELECT esProveedor INTO esProveedorP FROM persona
    WHERE idPersona = idPosibleProveedor;
       IF NOT esProveedorP THEN
          RAISE EXCEPTION 'El id no pertenece a un proveedor.';
       END IF;
    END IF;
    IF (TG_OP = 'UPDATE') THEN
    SELECT idProveedor INTO idPosibleProveedor FROM proveer
    WHERE idInsumo = NEW.idInsumo;
    SELECT esProveedor INTO esProveedorP FROM persona
    WHERE idPersona = idPosibleProveedor;
       IF NOT esProveedorP THEN
          RAISE EXCEPTION 'El id no pertenece a un proveedor.';
       END IF;
    END IF;
RETURN null;
END
$$
LANGUAGE plpgsql;
-- Triger que verifica que los insumos sean vendidos por un proveedor.
CREATE OR REPLACE TRIGGER proveido_proveedor
AFTER INSERT OR UPDATE ON proveer
FOR EACH ROW
EXECUTE PROCEDURE es_proveedor();
-- Pruebas de trigger proveer
INSERT INTO proveer(idInsumo,idProveedor) VALUES ('IO7037725',59055071);