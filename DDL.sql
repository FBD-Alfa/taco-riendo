DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE personaPiso(
    idPersona VARCHAR(10) NOT NULL,
    sucursal VARCHAR(10) NOT NULL,
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
    curp CHAR(18) NOT NULL UNIQUE,
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
 * Llaves de persona piso.
 */
 ALTER TABLE personaPiso ADD CONSTRAINT personaPiso_pkey PRIMARY KEY(idPersona);
 COMMENT ON CONSTRAINT personaPiso_pkey ON personaPiso IS 'La llave primaria del persona';