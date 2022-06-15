/* Consulta que regresa el nombre de la sucursal y la persona que atendió en el segundo trimistre
cuando el pago fue con Tarjeta y el consumo fue en la sucursal*/
SELECT nombresucursal, nombre,apellidop,apellidom,fecha
FROM ticket,persona,sucursal
WHERE persona.idpersona= ticket.idmesero and persona.idsucursal = sucursal.idsucursal 
and adomicilio=false and tipopago='Tarjeta' and date_part('year',fecha) in (2020) and date_part('quarter',fecha) in (2);

/* Los números de placas,el nombre de la sucursal  y el de todos los repartidores de todas las sucursales */
SELECT noplacas, nombre, nombresucursal
FROM manejar,persona,sucursal
WHERE persona.idpersona= manejar.idpersona and persona.idsucursal = sucursal.idsucursal ;

/* Regresa el tipo de platillo con sus porciones junto con el nivel de picor de las salsas y con su promedio de porción que tienen ingredientes en común*/
SELECT  tipoplatillo,contenerplatillo.porcion as porcion_platillo, nivelpicor, avg(contenersalsa.porcion) as porcion_salsa
FROM platillo,contenerplatillo, contenersalsa,salsa
WHERE contenerplatillo.idproducto= contenersalsa.idproducto and contenerplatillo.idproducto = platillo.idproducto and contenersalsa.idproducto = salsa.idproducto
GROUP BY tipoplatillo, contenerplatillo.porcion, nivelpicor ;