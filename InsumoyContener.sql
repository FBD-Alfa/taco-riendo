DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;
CREATE TABLE insumo(
	id  idInsumo INT NOT NULL UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	fechaCompra DATE NOT NULL.
	precio INT NOT NULL,
	cantidad INT NOT NULL,
	marca VARCHAR(40),
	caducidad DATE NOT NULL
);
COMMENT ON TABLE insumo IS 'Tabla que contiene informacion sobre los insumos';
COMMENT ON COLUMN insumo.idInsumo IS 'El ID que identifica al consumo';
COMMENT ON COLUMN insumo.nombre IS 'El nombre del insumo';
COMMENT ON COLUMN insumo.fechaCompra IS 'La fecha de compra del insumo';
COMMENT ON COLUMN insumo.precio IS 'El precio del insumo';
COMMENT ON COLUMN insumo.cantidad IS 'La cantidad del insumo';
COMMENT ON COLUMN insumo.marca IS 'La marca del insumo';
COMMENT ON COLUMN insumo.caducidad IS 'La fecha de caducidad del insumo';

ALTER TABLE insumo CONSTRAINT insumo_pkey PRIMARY KEY (idInsumo);
COMMENT ON CONSTRAINT insumo_pkey ON insumo 'La  llave primaria de la tabla insumo ';
CREATE TABLE contenerPlatillo(
    producto VARCHAR(50) NOT NULL,
	idInsumo INT NOT NULL ,
	porcion VARCHAR(50) NOT NULL
);
COMMENT ON TABLE contenerPlatillo IS 'Tabla que contiene informacion de la relación contener';
COMMENT ON COLUMN contenerPlatillo.producto IS 'La llave primaria que identifica al producto dentro de la relación contener';
COMMENT ON COLUMN contenerPlatillo.idInsumo IS 'El ID que identifica al insumo dentro de la relación contener';
COMMENT ON COLUMN contenerPlatillo.porcion IS 'La porción del insumo contenido en el platillo';

ALTER TABLE contenerPlatillo ADD CONSTRAINT contenerPlatillo_fkey1 FOREIGN KEY (producto)
REFERENCES platillo (producto ) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE contenerPlatillo ADD CONSTRAINT contenerPlatillo_fkey2 FOREIGN KEY (idInsumo)
REFERENCES insumo (idInsumo ) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerPlatillo_fkey1 ON contenerPlatillo IS 'La primera llave foránea de la relación contenerPlatillo';
COMMENT ON CONSTRAINT contenerPlatillo_fkey2 ON contenerPlatillo IS 'La segunda y última llave foránea de la relación contenerPlatillo';


CREATE TABLE contenerSalsa(
    producto VARCHAR(50) NOT NULL,
	idInsumo INT NOT NULL ,
	porcion VARCHAR(50) NOT NULL
);
COMMENT ON TABLE contenerSalsa 'Tabla que contiene informacion de la relación contener';
COMMENT ON COLUMN contenerSalsa.producto IS 'La llave primaria que identifica al producto dentro de la relación contener';
COMMENT ON COLUMN contenerSalsa.idInsumo IS 'El ID que identifica al insumo dentro de la relación contener';
COMMENT ON COLUMN contenerSalsa.porcion IS 'La porción del insumo contenido en la salsa';

ALTER TABLE contenerSalsa ADD CONSTRAINT contenerSalsa_fkey1 FOREIGN KEY (producto)
REFERENCES platillo (producto ) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE contenerSalsa ADD CONSTRAINT contenerSalsa_fkey2 FOREIGN KEY (idInsumo)
REFERENCES insumo (idInsumo ) ON UPDATE CASCADE ON DELETE CASCADE;
COMMENT ON CONSTRAINT contenerSalsa_fkey1 ON contenerSalsa IS 'La primera llave foránea de la relación contenerSalsa';
COMMENT ON CONSTRAINT contenerSalsa_fkey2 ON contenerSalsa IS 'La segunda y última llave foránea de la relación contenerSalsa;
