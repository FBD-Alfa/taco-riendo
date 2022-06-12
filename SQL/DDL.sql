DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Entidades ]---------------------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * =================================[ Tabla de persona ]===================================
 */
CREATE TABLE persona(
    idPersona BIGINT NOT NULL UNIQUE,
    idSucursal INT,
    nombre VARCHAR(100) NOT NULL,
    apellidoP VARCHAR(100) NOT NULL,
    apellidoM VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono CHAR(10) CHECK(telefono ~ '^[0-9]') NOT NULL,
    estado VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    cp CHAR(5) CHECK(cp ~ '^[0-9]') NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    esEmpleado BOOLEAN NOT NULL,
    edad INT,
    salario float,
    antiguedad INT,
    nss CHAR(10) CHECK(nss ~ '^[0-9]'), 
    esCliente BOOLEAN NOT NULL,
    curp CHAR(18),
    noPuntos INT,
    esProveedor BOOLEAN NOT NULL,
    esParrillero BOOLEAN NOT NULL,
    esTaquero BOOLEAN NOT NULL,
    esMesero BOOLEAN NOT NULL,
    esCajero BOOLEAN NOT NULL,
    esTortillero BOOLEAN NOT NULL,
    esRepartidor BOOLEAN NOT NULL,
    fechaIngreso DATE
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
    idSucursal BIGINT NOT NULL UNIQUE,
    nombreSucursal VARCHAR(40) NOT NULL,
    rfc VARCHAR(13) NOT NULL,
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
    noPlacas VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    esMotocicleta BOOLEAN NOT NULL,
	esBicicleta BOOLEAN NOT NULL,
    noLicencia VARCHAR(10)
);

/*
 * Documentación de transporte.
 */
COMMENT ON TABLE transporte IS 'Tabla que contiene informacion de los transportes';
COMMENT ON COLUMN transporte.noPlacas IS 'Identificador del transporte por medio de sus placas';
COMMENT ON COLUMN transporte.marca IS 'La marca del transporte'; 
COMMENT ON COLUMN transporte.modelo IS 'El modelo del transporte';
COMMENT ON COLUMN transporte.esMotocicleta IS 'True si el transporte es una motocicleta, false en otro caso';
COMMENT ON COLUMN transporte.esBicicleta IS 'True si el transporte es una bicicleta, false en otro caso';
COMMENT ON COLUMN transporte.noLicencia IS 'Número de licencia para manejar el transporte';

/*
 * =================================[ Tabla de ticket ]===================================
 */
CREATE TABLE ticket(
    idTicket VARCHAR(10) NOT NULL UNIQUE,
    idSucursal INT NOT NULL,
    idPersona BIGINT NOT NULL,
	idMesero BIGINT,
    fecha DATE NOT NULL,
    aDomicilio BOOLEAN NOT NULL,
    tipoPago VARCHAR(20) NOT NULL CHECK (tipoPago IN ('Efectivo','Tarjeta','Puntos'))
);

/*
 * Documentación de ticket.
 */
COMMENT ON TABLE ticket IS 'Tabla que contiene informacion de los tickets';
COMMENT ON COLUMN ticket.idTicket IS 'Identificador del ticket';
COMMENT ON COLUMN ticket.idSucursal IS 'Identificador de la sucursal';
COMMENT ON COLUMN ticket.idPersona IS 'Identificador de la persona';
COMMENT ON COLUMN ticket.fecha IS 'Fecha de expedición del ticket';
COMMENT ON COLUMN ticket.idMesero IS 'Identificador del mesero que atendió el ticket';
COMMENT ON COLUMN ticket.aDomicilio IS 'Tipo del consumo';
COMMENT ON COLUMN ticket.tipoPago IS 'El tipo de pago del cliente. Puede ser Efectivo, Tarjeta o Puntos';

/*
 * =================================[ Tabla de salsa ]===================================
 */
CREATE TABLE salsa(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    idPlatillo VARCHAR(12) NOT NULL,
    nivelPicor VARCHAR(30) NOT NULL,
    presentacion VARCHAR(50) NOT NULL
);

/*
 * Documentación de salsa.
 */
COMMENT ON TABLE salsa IS 'Tabla que contiene informacion de las salsas';
COMMENT ON COLUMN salsa.idProducto IS 'Identificador de la salsa';
COMMENT ON COLUMN salsa.idPlatillo IS 'Identificador del platillo con el que se acompaña la salsa';
COMMENT ON COLUMN salsa.nivelPicor IS 'Que tan picosa es la salsa';
COMMENT ON COLUMN salsa.presentacion IS 'La presentación de la salsa';

CREATE TABLE precioSalsa(
    idProducto VARCHAR(12) NOT NULL,
    precio FLOAT NOT NULL,
    fecha DATE NOT NULL
);

/*
 * Documentación de precioSalsa.
 */
COMMENT ON TABLE precioSalsa IS 'Tabla que contiene el hitórico de precios de las salsas.';
COMMENT ON COLUMN precioSalsa.idProducto IS 'Identificador de la salsa';
COMMENT ON COLUMN precioSalsa.precio IS 'Un precio de la salsa';
COMMENT ON COLUMN precioSalsa.fecha IS 'Fecha en la que se moficó el precio';

/*
 * =================================[ Tabla de platillo ]===================================
 */
CREATE TABLE platillo(
    idProducto VARCHAR(12) NOT NULL UNIQUE,
    tipoPlatillo VARCHAR(50) NOT NULL
);

/*
 * Documentación de platillo.
 */
COMMENT ON TABLE platillo IS 'Tabla que contiene informacion de los platillos';
COMMENT ON COLUMN platillo.idProducto IS 'Identificador del platillo';
COMMENT ON COLUMN platillo.tipoPlatillo IS 'Tipo de platillo';

CREATE TABLE precioPlatillo(
    idProducto VARCHAR(12) NOT NULL,
    precio FLOAT NOT NULL,
    fecha DATE NOT NULL
);

/*
 * Documentación de precioSalsa.
 */
COMMENT ON TABLE precioPlatillo IS 'Tabla que contiene el hitórico de precios de los platillos.';
COMMENT ON COLUMN precioPlatillo.idProducto IS 'Identificador del platillo';
COMMENT ON COLUMN precioPlatillo.precio IS 'Un precio del platillo';
COMMENT ON COLUMN precioPlatillo.fecha IS 'Fecha en la que se moficó el precio';

/*
 * =================================[ Tabla de insumo ]===================================
 */
CREATE TABLE insumo(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    fechaCompra DATE NOT NULL,
    precio FLOAT NOT NULL,
    cantidad INT NOT NULL, 
    marca VARCHAR(100) NOT NULL,
    caducidad DATE NOT NULL
);

/*
 * Documentación de insumo.
 */
COMMENT ON TABLE insumo IS 'Tabla que contiene informacion de los insumos';
COMMENT ON COLUMN insumo.idInsumo IS 'Identificador del insumo';
COMMENT ON COLUMN insumo.nombre IS 'Nombre del insumo';
COMMENT ON COLUMN insumo.fechaCompra IS 'Fecha de compra del insumo';
COMMENT ON COLUMN insumo.precio IS 'Precio del insumo';
COMMENT ON COLUMN insumo.cantidad IS 'Cantidad del insumo';
COMMENT ON COLUMN insumo.marca IS 'La marca del insumo';
COMMENT ON COLUMN insumo.caducidad IS 'La caducidad del insumo';

/*-----------------------------------------------------------------------------------------
 *-------------------------------------[ Relaciones ]--------------------------------------
 *---------------------------------------------------------------------------------------*/
 
/*
 * =================================[ Tabla de manejar ]===================================
 */
CREATE TABLE manejar(
    idPersona INT NOT NULL UNIQUE,
    noPlacas VARCHAR(10) NOT NULL UNIQUE
);

/*
 * Documentación de la relación manejar.
 */
COMMENT ON TABLE manejar IS 'Tabla que contiene información sobre la relación de manejar entre personas y transportes';
COMMENT ON COLUMN manejar.idPersona IS 'Identificador de la persona que maneja';
COMMENT ON COLUMN manejar.noPlacas IS 'Identificador del transporte que es manejado';

/*
 * =================================[ Tabla de proveer ]===================================
 */
CREATE TABLE proveer(
    idInsumo VARCHAR(12) NOT NULL UNIQUE,
    idProveedor INT NOT NULL
);

/*
 * Documentación de la relación proveer.
 */
COMMENT ON TABLE proveer IS 'Tabla que contiene información sobre la relación de proveer entre insumos y proveedores';
COMMENT ON COLUMN proveer.idInsumo IS 'Identificador del insumo provisto';
COMMENT ON COLUMN proveer.idProveedor IS 'Identificador del proveedor que provee el insumo';

/*
 * ==============================[ Tabla de contenerSalsa ]==============================
 */
CREATE TABLE contenerSalsa(
    idProducto VARCHAR(12) NOT NULL,
    idInsumo VARCHAR(12) NOT NULL,
    porcion float NOT NULL
);

/*
 * Documentación de la contenerSalsa.
 */
COMMENT ON TABLE contenerSalsa IS 'Tabla que contiene información sobre la relación contenerSalsa';
COMMENT ON COLUMN contenerSalsa.idProducto IS 'Identificador del producto';
COMMENT ON COLUMN contenerSalsa.idInsumo IS 'Identificador del insumo';
COMMENT ON COLUMN contenerSalsa.porcion IS 'Porción de la salsa';

/*
 * ==============================[ Tabla de incluirSalsa ]==============================
 */
CREATE TABLE incluirSalsa(
    idProducto VARCHAR(12) NOT NULL,
    idTicket VARCHAR(10) NOT NULL
);

/*
 * Documentación de la incluirSalsa.
 */
COMMENT ON TABLE incluirSalsa IS 'Tabla que contiene información sobre las salsas vendidas.';
COMMENT ON COLUMN incluirSalsa.idProducto IS 'Identificador del producto';
COMMENT ON COLUMN incluirSalsa.idTicket IS 'Identificador del ticket';

/*
 * ==============================[ Tabla de contenerPlatillo ]==============================
 */
CREATE TABLE contenerPlatillo(
    idProducto VARCHAR(12) NOT NULL,
    idInsumo VARCHAR(12) NOT NULL,
    porcion INT NOT NULL
);

/*
 * Documentación de la contenerPlatillo.
 */
COMMENT ON TABLE contenerPlatillo IS 'Tabla que contiene información sobre la relación contenerPlatillo';
COMMENT ON COLUMN contenerPlatillo.idProducto IS 'Identificador del producto';
COMMENT ON COLUMN contenerPlatillo.idInsumo IS 'Identificador del insumo';
COMMENT ON COLUMN contenerPlatillo.porcion IS 'Porción del producto';

/*
 * ==============================[ Tabla de incluirPlatillo ]==============================
 */
CREATE TABLE incluirPlatillo(
    idProducto VARCHAR(12) NOT NULL,
    idTicket VARCHAR(10) NOT NULL
);

/*
 * Documentación de la incluirPlatillo.
 */
COMMENT ON TABLE incluirPlatillo IS 'Tabla que contiene información sobre los platillos vendidos.';
COMMENT ON COLUMN incluirPlatillo.idProducto IS 'Identificador del producto';
COMMENT ON COLUMN incluirPlatillo.idTicket IS 'Identificador del ticket';

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
 ALTER TABLE transporte ADD CONSTRAINT transporte_pkey PRIMARY KEY(noPlacas);
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
 * Llave de precioSalsa.
 */
 ALTER TABLE precioSalsa ADD CONSTRAINT precioSalsa_pkey PRIMARY KEY(idProducto,fecha,precio);
 COMMENT ON CONSTRAINT precioSalsa_pkey ON precioSalsa IS 'La llave primaria de precioSalsa';
 
/*
 * Llave de platillo.
 */
 ALTER TABLE platillo ADD CONSTRAINT platillo_pkey PRIMARY KEY(idProducto);
 COMMENT ON CONSTRAINT platillo_pkey ON platillo IS 'La llave primaria de platillo';
 
 /*
 * Llave de precioPlatillo.
 */
 ALTER TABLE precioPlatillo ADD CONSTRAINT precioPlatillo_pkey PRIMARY KEY(idProducto,fecha,precio);
 COMMENT ON CONSTRAINT precioPlatillo_pkey ON precioPlatillo IS 'La llave primaria de precioPlatillo';
 
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

ALTER TABLE ticket ADD CONSTRAINT ticket_fkeyMesero FOREIGN KEY(idMesero)
REFERENCES persona(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT ticket_fkeyMesero ON ticket IS 'La llave foranea de ticket que hace referencia al mesero';

/*
 * Llaves de salsa.
 */
ALTER TABLE salsa ADD CONSTRAINT salsa_fkeyPlatillo FOREIGN KEY(idPlatillo)
REFERENCES platillo(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT salsa_fkeyPlatillo ON salsa IS 'La llave foranea de salsa que hace referencia a Platillo';

ALTER TABLE precioSalsa ADD CONSTRAINT precioSalsa_fkeySalsa FOREIGN KEY(idProducto)
REFERENCES salsa(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT precioSalsa_fkeySalsa ON precioSalsa IS 'La llave foranea de precioSalsa que hace referencia a Salsa';

/*
 * Llaves de platillo.
 */
ALTER TABLE precioPlatillo ADD CONSTRAINT precioPlatillo_fkeyPlatillo FOREIGN KEY(idProducto)
REFERENCES platillo(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT precioPlatillo_fkeyPlatillo ON precioPlatillo IS 'La llave foranea de precioSalsa que hace referencia a Platillo';

/*----------------------------------------------------------------------------------------
 *---------------------------[ Llaves Foraneas de Relaciones ]----------------------------
 *---------------------------------------------------------------------------------------*/

/*
 * Llaves de manejar.
 */
ALTER TABLE manejar ADD CONSTRAINT manejar_fkeyPersona FOREIGN KEY (idPersona) 
REFERENCES persona(idPersona) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyPersona ON manejar IS 'llave foranea de la tabla manejar que hace referencia al idPersona de persona';
ALTER TABLE manejar ADD CONSTRAINT manejar_fkeyTransporte FOREIGN KEY (noPlacas) 
REFERENCES transporte(noPlacas) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT manejar_fkeyTransporte ON manejar IS 'llave foranea de la tabla manejar que hace referencia al noPlacas del transporte';

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

/*
 * Llaves de incluirSalsa.
 */
ALTER TABLE incluirSalsa ADD CONSTRAINT incluirSalsa_fkeyTicket FOREIGN KEY(idTicket)
REFERENCES ticket(idTicket) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT incluirSalsa_fkeyTicket ON incluirSalsa IS 'La llave foranea de incluirSalsa que hace referencia al ticket';

ALTER TABLE incluirSalsa ADD CONSTRAINT incluirSalsa_fkeySalsa FOREIGN KEY(idProducto)
REFERENCES salsa(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT incluirSalsa_fkeySalsa ON incluirSalsa IS 'La llave foranea de incluirSalsa que hace referencia a Salsa';

/*
 * Llaves de inlcuirPlatillo.
 */
ALTER TABLE incluirPlatillo ADD CONSTRAINT incluirPlatillo_fkeyTicket FOREIGN KEY(idTicket)
REFERENCES ticket(idTicket) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT incluirPlatillo_fkeyTicket ON incluirPlatillo IS 'La llave foranea de incluirPlatillo que hace referencia al ticket';

ALTER TABLE incluirPlatillo ADD CONSTRAINT incluirPlatillo_fkeyPlatillo FOREIGN KEY(idProducto)
REFERENCES platillo(idProducto) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT incluirPlatillo_fkeyPlatillo ON incluirPlatillo IS 'La llave foranea de incluirPlatillo que hace referencia a Platillo';
