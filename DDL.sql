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
    /*direccion VARCHAR(70) NOT NULL,*/
    estado VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cp INT NOT NULL,
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
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    esMotocicleta BOOLEAN NOT NULL,
    esBicicleta BOOLEAN NOT NULL,
    noLicencia VARCHAR(10) NOT NULL
);

CREATE TABLE ticket(
    idTicket VARCHAR(10) NOT NULL UNIQUE,
    idSucursal VARCHAR(10) NOT NULL UNIQUE,
    idPersona VARCHAR(10) NOT NULL UNIQUE,
    fecha DATE NOT NULL,
    detalle VARCHAR(100) NOT NULL,
    total int NOT NULL,
    nombreSucursal VARCHAR(40) NOT NULL,
    rfcMesero VARCHAR(10) NOT NULL,
    /*tipoConsumo() NOT NULL;*/
    esConsumoPresencial BOOLEAN NOT NULL,
    tipoPago VARCHAR(20) NOT NULL
);

CREATE TABLE salsa(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idTicket VARCHAR(10) NOT NULL,
    nivelPicor VARCHAR(30) NOT NULL,
    platillo VARCHAR(40) NOT NULL,
    presentación VARCHAR(50) NOT NULL,
    precio INT NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE platillo(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idTicket VARCHAR(10) NOT NULL,
    tipoPlatillo VARCHAR(50) NOT NULL,
    precio INT NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE insumo(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    fechaCompra DATE NOT NULL,
    precio INT NOT NULL,
    cantidad VARCHAR(50) NOT NULL,
    marca VARCHAR(30) NOT NULL,
    caducidad DATE NOT NULL
);

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Relaciones ]--------------------------------------
 *---------------------------------------------------------------------------------------*/
CREATE TABLE manejar(
    idPersona VARCHAR(10) NOT NULL UNIQUE,
    idTransporte VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE proveer(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    idProveedor VARCHAR(10) NOT NULL UNIQUE
);

/*-----------------------------------------------------------------------------------------
 *----------------------------------[ Llaves Primarias ]-----------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * Llave de persona piso.
 */
 ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_pkey PRIMARY KEY(idPersona);
 COMMENT ON CONSTRAINT personaPiso_pkey ON personaPiso IS 'La llave primaria de personaPiso';

/*
 * Llave de sucursal.
 */
 ALTER TABLE sucursal ADD CONSTRAINT sucursal_pkey PRIMARY KEY(idSucursal);
 COMMENT ON CONSTRAINT sucursal_pkey ON sucursal IS 'La llave primaria de sucursal';

/*
 * Llave de transporte.
 */
 ALTER TABLE transporte ADD CONSTRAINT transporte_pkey PRIMARY KEY(idTransporte);
 COMMENT ON CONSTRAINT transporte_pkey ON transporte IS 'La llave primaria de transporte';

/*
 * Llave de ticket.
 */
 ALTER TABLE ticket ADD CONSTRAINT ticket_pkey PRIMARY KEY(idTicket);
 COMMENT ON CONSTRAINT ticket_pkey ON ticket IS 'La llave primaria de ticket';
 
/*
 * Llave de salsa.
 */
 ALTER TABLE salsa ADD CONSTRAINT salsa_pkey PRIMARY KEY(idProducto);
 COMMENT ON CONSTRAINT salsa_pkey ON salsa IS 'La llave primaria de salsa';
 
/*
 * Llave de platillo.
 */
 ALTER TABLE platillo ADD CONSTRAINT platillo_pkey PRIMARY KEY(idProducto);
 COMMENT ON CONSTRAINT platillo_pkey ON platillo IS 'La llave primaria de platillo';
 
 /*
 * Llave de insumo.
 */
 ALTER TABLE insumo ADD CONSTRAINT insumo_pkey PRIMARY KEY(idInsumo);
 COMMENT ON CONSTRAINT insumo_pkey ON insumo IS 'La llave primaria de insumo';

/*----------------------------------------------------------------------------------------
 *-----------------------------[ Llaves Foraneas Entidades ]------------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de personaPiso.
 */
ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT personaPiso_fkeySucursal ON personaPiso IS 'La llave foranea de personaPiso que hace referencia a sucursal';

/*
 * Llaves de ticket.
 */
ALTER TABLE ticket ADD CONSTRAINT ticket_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT ticket_fkeySucursal ON ticket IS 'La llave foranea de ticket que hace referencia a sucursal';
ALTER TABLE ticket ADD CONSTRAINT ticket_fkeyPersona FOREIGN KEY(idPersona)
REFERENCES personaPiso(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT ticket_fkeyPersona ON ticket IS 'La llave foranea de ticket que hace referencia a personaPiso';

/*
 * Llaves de salsa.
 */
ALTER TABLE salsa ADD CONSTRAINT salsa_fkeyTicket FOREIGN KEY(idTicket)
REFERENCES ticket(idTicket) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT salsa_fkeyTicket ON salsa IS 'La llave foranea de salsa que hace referencia a ticket';

/*
 * Llaves de platillo.
 */
ALTER TABLE platillo ADD CONSTRAINT platillo_fkeyTicket FOREIGN KEY(idTicket)
REFERENCES ticket(idTicket) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT platillo_fkeyTicket ON platillo IS 'La llave foranea de platillo que hace referencia a ticket';

/*----------------------------------------------------------------------------------------
 *---------------------------[ Llaves Foraneas de Relaciones ]----------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de manejar.
 */
ALTER TABLE manejar ADD CONSTRAINT manejar_fkeyPersona FOREIGN KEY (idPersona) 
REFERENCES personaPiso(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyPersona ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idPersona de personaPiso';
ALTER TABLE manejar ADD CONSTRAINT manejar_fkeyTransporte FOREIGN KEY (idTransporte) 
REFERENCES transporte(idTransporte) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyTransporte ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idTransporte de transporte';

/*
 * Llaves de Proveer.
 */
ALTER TABLE proveer ADD CONSTRAINT proveer_fkeyInsumo FOREIGN KEY (idInsumo) 
REFERENCES insumo(idInsumo) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT proveer_fkeyInsumo ON proveer IS 'llave foranea de la tabla proveer que hace referencia a insumo';
ALTER TABLE proveer ADD CONSTRAINT proveer_fkeyProveedor FOREIGN KEY (idProveedor) 
REFERENCES personaPiso(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT proveer_fkeyProveedor ON proveer IS 'llave foranea de la tabla proveer que hace referencia al id del proveedor';