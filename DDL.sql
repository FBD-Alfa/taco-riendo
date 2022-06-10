DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Entidades ]---------------------------------------
 *---------------------------------------------------------------------------------------*/
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

CREATE TABLE transporte(
    idTransporte VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(20) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    esMotocicleta BOOLEAN NOT NULL,
    esBicicleta BOOLEAN NOT NULL,
    noLicencia VARCHAR(10) NOT NULL
);

CREATE TABLE ticket();
/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Relaciones ]--------------------------------------
 *---------------------------------------------------------------------------------------*/
CREATE TABLE manejar(
    idPersona VARCHAR(10) NOT NULL UNIQUE,
    idTransporte VARCHAR(10) NOT NULL UNIQUE
);

/*-----------------------------------------------------------------------------------------
 *----------------------------------[ Llaves Primarias ]-----------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * Llave de persona piso.
 */
 ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_pkey PRIMARY KEY(idPersona);
 COMMENT ON CONSTRAINT personaPiso_pkey ON personaPiso IS 'La llave primaria de la persona';

/*
 * Llave de sucursal.
 */
 ALTER TABLE sucursal ADD CONSTRAINT sucursal_pkey PRIMARY KEY(idSucursal);
 COMMENT ON CONSTRAINT sucursal_pkey ON sucursal IS 'La llave primaria de la sucursal';

/*
 * Llave de transporte.
 */
 ALTER TABLE transporte ADD CONSTRAINT transporte_pkey PRIMARY KEY(idTransporte);
 COMMENT ON CONSTRAINT transporte_pkey ON transporte IS 'La llave primaria de transporte';
 
/*----------------------------------------------------------------------------------------
 *-----------------------------[ Llaves Foraneas Entidades ]------------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de persona piso.
 */
ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT personaPiso_fkeySucursal ON personaPiso IS 'La llave foranea de persona piso que hace referencia a la sucursal';


/*----------------------------------------------------------------------------------------
 *---------------------------[ Llaves Foraneas de Relaciones ]----------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de manejar.
 */
ALTER TABLE manejar ADD CONSTRAINT manejar_fkey1 FOREIGN KEY (idPersona) 
REFERENCES personaPiso(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkey1 ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idPersona de personaPiso';
ALTER TABLE manejar ADD CONSTRAINT manejar_fkey2 FOREIGN KEY (idTransporte) 
REFERENCES transporte(idTransporte) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkey2 ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idTransporte de transporte';