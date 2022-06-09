DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE personaPiso(
    idPersona VARCHAR(10) NOT NULL UNIQUE,
    idSucursal VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidoP VARCHAR(50) NOT NULL,
    apellidoM VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono BIGINT NOT NULL,
    direccion VARCHAR(70) NOT NULL,
    rfc VARCHAR(10) NOT NULL,
    esEmpleado INT NOT NULL,
    edad INT NOT NULL,
    salario INT NOT NULL,
    antiguedad INT NOT NULL,
    nss BIGINT NOT NULL,
    esCliente BOOLEAN NOT NULL,
    curp CHAR(18) NOT NULL,
    noPuntos INT NOT NULL,
    esProveedor BOOLEAN NOT NULL,
    pagoP INT NOT NULL,
    esParrillero BOOLEAN NOT NULL,
    esTaquero BOOLEAN NOT NULL,
    esMesero BOOLEAN NOT NULL,
    esCajero BOOLEAN NOT NULL,
    esTortillero BOOLEAN NOT NULL,
    esRepartidor BOOLEAN NOT NULL,
    fechaIngreso DATE NOT NULL
);

CREATE TABLE sucursal(
    idSucursal VARCHAR(10) NOT NULL UNIQUE,
    rfc VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono BIGINT NOT NULL,
    estado VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cp INT NOT NULL
);



/*-----------------------------------------------------------------------------------------
 *----------------------------------[ Llaves Primarias ]-----------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * Llave de persona piso.
 */
 ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_pkey PRIMARY KEY(idPersona);
 COMMENT ON CONSTRAINT personaPiso_pkey ON personaPiso IS 'La llave primaria del persona';
/*
 * Llave de sucursal.
 */
 ALTER TABLE sucursal ADD CONSTRAINT sucursal_pkey PRIMARY KEY(idSucursal);
 COMMENT ON CONSTRAINT sucursal_pkey ON sucursal IS 'La llave primaria del sucursal';
 
/*----------------------------------------------------------------------------------------
 *----------------------------------[ Llaves Foraneas ]-----------------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de persona piso.
 */
ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT personaPiso_fkeySucursal ON personaPiso IS 'La llave foranea de la mascota que hace referencia a la sucursal';