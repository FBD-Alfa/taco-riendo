/* Consulta que regresa el nombre de la sucursal y la persona que atendió en el segundo trimestre
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

--Precio promedio anual por platillo y sucursal
SELECT a.idProducto, d.idSucursal, a.tipoPlatillo, avg(b.precio) as pprom, date_part('year', b.fecha) as anio
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
GROUP BY anio, a.idProducto, a.tipoPlatillo, d.idSucursal
ORDER BY d.idSucursal DESC;

--Precio promedio de los tacos vendidos en 2019 
SELECT a.idProducto, a.tipoPlatillo, date_part('year', b.fecha) as anio, avg(b.precio) as pprom
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
WHERE date_part('year', b.fecha) IN (2019) AND a.tipoPlatillo like 'Taco%'
GROUP BY anio, a.idProducto, a.tipoPlatillo
ORDER BY pprom DESC;

--Numero de tickets que compraron tacos por año
SELECT a.idProducto, a.tipoPlatillo, date_part('year', b.fecha) as anio, count(a.idProducto) as numplat
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
WHERE a.tipoPlatillo like 'Taco%'
GROUP BY anio, a.idProducto, a.tipoPlatillo
ORDER BY anio, numplat DESC;

-- El nombre de todos los empleados de Taco-Riendo y la sucursal donde trabajan.
SELECT nombre,apellidoP,apellidoM,idSucursal
FROM persona
WHERE esEmpleado = True;

-- Los meseros y los tickets que atendieron
SELECT nombre,apellidoP,apellidoM,idTicket,idMesero
FROM ticket cross join persona
WHERE esMesero = True and persona.idPersona=idMesero;

-- El nombre completo, la dirección y el número de ticket de los clientes que han pedido a domicilio
SELECT nombre,apellidoP,apellidoM,estado,calle,municipio,numero,cp,idTicket
FROM ticket cross join persona
WHERE aDomicilio = True and persona.idPersona = ticket.idPersona;

--Numero de tickets atendidos que compraron algun tipo de Huevos por año
SELECT a.idProducto, a.tipoPlatillo, date_part('year', b.fecha) as anio, count(a.idProducto) as numplat
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
WHERE a.tipoPlatillo like '%Huev%'
GROUP BY anio, a.idProducto, a.tipoPlatillo
ORDER BY anio, numplat DESC;

-- Total de ventas de las sucursales con menores ventas
select s.idSucursal, s.nombreSucursal, sum(round(w.precio)) as tot FROM (( SELECT  IP.idProducto, precioActualPlatillo(IP.idProducto) AS precio 
                        FROM incluirPlatillo IP 
                        UNION 
                        SELECT  IP.idProducto, precioActualSalsa(IP.idProducto) AS precio 
                        FROM incluirSalsa IP) p INNER JOIN incluirPlatillo a
                        ON p.idProducto=a.idProducto) as w
                        JOIN ticket t ON w.idTicket=t.idTicket
                        JOIN sucursal s ON s.idSucursal=t.idSucursal
                        GROUP BY s.idSucursal
                        ORDER BY tot 
                        LIMIT 15;
                        
---Platillos mas caros para todos los años
SELECT a.idProducto, a.tipoPlatillo, max(b.precio) as mpre
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
GROUP BY a.idProducto
ORDER BY mpre DESC;

--Platillos mas caros por años
SELECT a.idProducto, a.tipoPlatillo, date_part('year', b.fecha) as anio, max(b.precio) as mpre
FROM platillo a INNER JOIN precioPlatillo b ON a.idProducto=b.idProducto
JOIN incluirPlatillo c ON c.idProducto=b.idProducto
JOIN ticket d ON c.idTicket=d.idTicket
--WHERE a.tipoPlatillo like 'Taco%'
GROUP BY a.idProducto, anio
ORDER BY mpre DESC;
