DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Entidades ]---------------------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * =================================[ Tabla de persona ]===================================
 */
CREATE TABLE persona(
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

/*
 * Documentación de persona.
 */
COMMENT ON TABLE persona IS 'Tabla que contiene informacion de las personas';
COMMENT ON COLUMN persona.idPersona IS 'Identificador de la persona';
COMMENT ON COLUMN persona.idSucursal IS 'Identificador de la sucursal';
COMMENT ON COLUMN persona.nombre IS 'Nombre de la persona';
COMMENT ON COLUMN persona.apellidoP IS 'Apellido paterno de la persona';
COMMENT ON COLUMN persona.apellidoM IS 'Apellido materno de la persona';
COMMENT ON COLUMN persona.correo IS 'Correo electronico de la persona';
COMMENT ON COLUMN persona.telefono IS 'Telefono de la persona';
COMMENT ON COLUMN persona.idSucursal IS 'Apellido paterno de la persona';
/*COMMENT ON COLUMN persona.direccion IS 'La dirección de la persona';*/
COMMENT ON COLUMN persona.estado IS 'Estado donde vive la persona';
COMMENT ON COLUMN persona.calle IS 'Calle donde vive la persona';
COMMENT ON COLUMN persona.municipio IS 'Municipio donde vive la persona';
COMMENT ON COLUMN persona.numero IS 'Numero de la casa donde vive la persona';
COMMENT ON COLUMN persona.cp IS 'Codigo postal de donde vive la persona';
COMMENT ON COLUMN persona.rfc IS 'rfc de la persona';
COMMENT ON COLUMN persona.esEmpleado IS 'True si la persona es empleado, falso en otro caso';
COMMENT ON COLUMN persona.edad IS 'Edad de la persona';
COMMENT ON COLUMN persona.salario IS 'Salario donde vive la persona';   
COMMENT ON COLUMN persona.antiguedad IS 'Cuanto tiempo a trabajado en la empresa la persona';
COMMENT ON COLUMN persona.nss IS 'Número del seguro social de la persona';
COMMENT ON COLUMN persona.esCliente IS 'True si la persona es cliente, falso en otro caso';    
COMMENT ON COLUMN persona.curp IS 'La CURP de la persona';
COMMENT ON COLUMN persona.noPuntos IS 'El número de puntos con los que cuenta la persona';
COMMENT ON COLUMN persona.esProveedor IS 'True si la persona es proveedor, falso en otro caso';
COMMENT ON COLUMN persona.pagoP IS 'El pago de la persona'; /* Tengo duda si es el pago resultante :(*/
COMMENT ON COLUMN persona.esParrillero IS 'True si la persona es Parrillero, falso en otro caso';
COMMENT ON COLUMN persona.esTaquero IS 'True si la persona es Taquero, falso en otro caso';
COMMENT ON COLUMN persona.esMesero IS 'True si la persona es Mesero, falso en otro caso';
COMMENT ON COLUMN persona.esCajero IS 'True si la persona es Cajero, falso en otro caso';
COMMENT ON COLUMN persona.esTortillero IS 'True si la persona es Tortillero, falso en otro caso';
COMMENT ON COLUMN persona.esRepartidor IS 'True si la persona es Repartidor, falso en otro caso';
COMMENT ON COLUMN persona.fechaIngreso IS 'La fecha de ingreso de la persona a la empresa';

/*
 * =================================[ Tabla de sucursal ]===================================
 */
CREATE TABLE sucursal(
    idSucursal VARCHAR(10) NOT NULL UNIQUE,
    nombreSucursal VARCHAR(40) NOT NULL,
    rfc VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono BIGINT NOT NULL,
    estado VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cp INT NOT NULL
);

/*
 * Documentación de sucursal.
 */
COMMENT ON TABLE sucursal IS 'Tabla que contiene informacion de las sucursales';
COMMENT ON COLUMN sucursal.idSucursal IS 'Identificador de la sucursal';
COMMENT ON COLUMN sucursal.nombreSucursal IS 'Nombre de la sucursal';
COMMENT ON COLUMN sucursal.rfc IS 'El RFC de la sucursal';
COMMENT ON COLUMN sucursal.correo IS 'El correo de la sucursal';
COMMENT ON COLUMN sucursal.telefono IS 'El telefono de la sucursal';
COMMENT ON COLUMN sucursal.estado IS 'Estado donde se encuentra la sucursal';
COMMENT ON COLUMN sucursal.calle IS 'Calle donde se encuentra la sucursal';
COMMENT ON COLUMN sucursal.municipio IS 'Municipio donde se encuentra la sucursal';
COMMENT ON COLUMN sucursal.numero IS 'Número donde se encuentra la sucursal';
COMMENT ON COLUMN sucursal.cp IS 'El codigo postal donde se encuentra la sucursal';

/*
 * =================================[ Tabla de transporte ]===================================
 */
CREATE TABLE transporte(
    idTransporte VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    esMotocicleta BOOLEAN NOT NULL,
    /* No creo que sea necesaria, podemos asumir 
     * que si el transporte no es una motocicleta es una bicicleta.
     * esBicicleta BOOLEAN NOT NULL,*/ 
    noLicencia VARCHAR(10) NOT NULL
);

/*
 * Documentación de transporte.
 */
COMMENT ON TABLE transporte IS 'Tabla que contiene informacion de los transportes';
COMMENT ON COLUMN transporte.idTransporte IS 'Identificador del transporte';
COMMENT ON COLUMN transporte.marca IS 'La marca del transporte'; 
COMMENT ON COLUMN transporte.modelo IS 'El modelo del transporte';
COMMENT ON COLUMN transporte.esMotocicleta IS 'True si el transporte es una motocicleta, false en otro caso';
/*COMMENT ON COLUMN transporte.esBicicleta IS 'True si el transporte es una bicicleta, false en otro caso';*/
COMMENT ON COLUMN transporte.noLicencia IS 'Número de licencia para manejar el transporte';

/*
 * =================================[ Tabla de ticket ]===================================
 */
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

/*
 * =================================[ Tabla de salsa ]===================================
 */
CREATE TABLE salsa(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idTicket VARCHAR(10) NOT NULL,
    nivelPicor VARCHAR(30) NOT NULL,
    platillo VARCHAR(40) NOT NULL,
    presentación VARCHAR(50) NOT NULL,
    precio INT NOT NULL,
    fecha DATE NOT NULL
);

/*
 * =================================[ Tabla de platillo ]===================================
 */
CREATE TABLE platillo(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idTicket VARCHAR(10) NOT NULL,
    tipoPlatillo VARCHAR(50) NOT NULL,
    precio INT NOT NULL,
    fecha DATE NOT NULL
);

/*
 * =================================[ Tabla de insumo ]===================================
 */
CREATE TABLE insumo(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    fechaCompra DATE NOT NULL,
    precio INT NOT NULL,
    /* La cantidad no sé si sea varchar o int porque podría medirse
     * las cantidades de forma distinta dependiendo del producto.*/
    cantidad INT NOT NULL, 
    marca VARCHAR(30) NOT NULL,
    caducidad DATE NOT NULL
);

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Relaciones ]--------------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * =================================[ Tabla de manejar ]===================================
 */
CREATE TABLE manejar(
    idPersona VARCHAR(10) NOT NULL UNIQUE,
    idTransporte VARCHAR(10) NOT NULL UNIQUE
);

/*
 * =================================[ Tabla de proveer ]===================================
 */
CREATE TABLE proveer(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    idProveedor VARCHAR(10) NOT NULL UNIQUE
);

/*
 * ==============================[ Tabla de contenerSalsa ]==============================
 */
CREATE TABLE contenerSalsa(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    porcion INT NOT NULL
);

/*
 * ==============================[ Tabla de contenerPlatillo ]==============================
 */
CREATE TABLE contenerPlatillo(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    porcion INT NOT NULL
);

/*-----------------------------------------------------------------------------------------
 *----------------------------------[ Llaves Primarias ]-----------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * Llave de persona piso.
 */
 ALTER TABLE persona ADD CONSTRAINT persona_pkey PRIMARY KEY(idPersona);
 COMMENT ON CONSTRAINT persona_pkey ON persona IS 'La llave primaria de persona';

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
 * Llaves de persona.
 */
ALTER TABLE persona ADD CONSTRAINT persona_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT persona_fkeySucursal ON persona IS 'La llave foranea de persona que hace referencia a sucursal';

/*
 * Llaves de ticket.
 */
ALTER TABLE ticket ADD CONSTRAINT ticket_fkeySucursal FOREIGN KEY(idSucursal)
REFERENCES sucursal(idSucursal) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT ticket_fkeySucursal ON ticket IS 'La llave foranea de ticket que hace referencia a sucursal';
ALTER TABLE ticket ADD CONSTRAINT ticket_fkeyPersona FOREIGN KEY(idPersona)
REFERENCES persona(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT ticket_fkeyPersona ON ticket IS 'La llave foranea de ticket que hace referencia a persona';

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
REFERENCES persona(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyPersona ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idPersona de persona';
ALTER TABLE manejar ADD CONSTRAINT manejar_fkeyTransporte FOREIGN KEY (idTransporte) 
REFERENCES transporte(idTransporte) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyTransporte ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idTransporte de transporte';

/*
 * Llaves de proveer.
 */
ALTER TABLE proveer ADD CONSTRAINT proveer_fkeyInsumo FOREIGN KEY (idInsumo) 
REFERENCES insumo(idInsumo) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT proveer_fkeyInsumo ON proveer IS 'llave foranea de la tabla proveer que hace referencia a insumo';
ALTER TABLE proveer ADD CONSTRAINT proveer_fkeyProveedor FOREIGN KEY (idProveedor) 
REFERENCES persona(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT proveer_fkeyProveedor ON proveer IS 'llave foranea de la tabla proveer que hace referencia al id del proveedor';

/*
 * Llaves de contenerSalsa.
 */
ALTER TABLE contenerSalsa ADD CONSTRAINT contenerSalsa_fkeyProducto FOREIGN KEY (idProducto) 
REFERENCES salsa(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerSalsa_fkeyProducto ON contenerSalsa IS 'llave foranea de la tabla contenerSalsa que hace referencia al producto';
ALTER TABLE contenerSalsa ADD CONSTRAINT contenerSalsa_fkeyInsumo FOREIGN KEY (idInsumo) 
REFERENCES insumo(idInsumo) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerSalsa_fkeyInsumo ON contenerSalsa IS 'llave foranea de la tabla contenerSalsa que hace referencia a insumo';

/*
 * Llaves de contenerPlatillo.
 */
ALTER TABLE contenerPlatillo ADD CONSTRAINT contenerPlatillo_fkeyProducto FOREIGN KEY (idProducto) 
REFERENCES platillo(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerPlatillo_fkeyProducto ON contenerPlatillo IS 'llave foranea de la tabla contenerPlatillo que hace referencia al producto';
ALTER TABLE contenerPlatillo ADD CONSTRAINT contenerPlatillo_fkeyInsumo FOREIGN KEY (idInsumo) 
REFERENCES insumo(idInsumo) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerPlatillo_fkeyInsumo ON contenerPlatillo IS 'llave foranea de la tabla contenerPlatillo que hace referencia a insumo';
