-- Proyecto: RetailPro
-- Módulo 5: Consultas con JOINs para el proyecto
-- Motor utilizado: SQL Server (SSMS)
-- Base de datos: Ventas_Tech_DB
--
-- Esquema utilizado: categorias, clientes, productos y ventas.
-- clientes contiene ciudad y productos se relaciona con categorias,
-- por lo que hay campos descriptivos para agrupar y filtrar.

USE Ventas_Tech_DB;
GO

/* CONSULTA 1 — VISTA BASE DEL PROYECTO (INNER JOIN)
   Propósito: reunir cada venta con los datos del cliente,
   producto y categoría para utilizarla como fuente en Power BI. */

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-- Hallazgo: las 10 ventas quedan enriquecidas con cliente, producto,
-- categoría y ciudad. Permite analizar ventas por ciudad y categoría.
GO

/* CONSULTA 2 — CLIENTES SIN VENTAS (LEFT JOIN)
   Propósito: detectar clientes registrados que todavía no compraron,
   para que CRM pueda evaluar acciones de contacto. */

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;

-- Hallazgo: no se encontraron clientes sin compras (0 registros).
-- Los cinco clientes registrados tienen al menos una venta.
GO

/* CONSULTA 3 — PRODUCTOS SIN VENTAS (LEFT JOIN)
   Propósito: detectar artículos del catálogo sin movimientos,
   para que el área de Producto revise su situación. */

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;

-- Hallazgo: no se encontraron productos sin ventas (0 registros).
-- Los seis productos del catálogo tuvieron movimiento en esta muestra.
GO

/* CONSULTA 4 — CONSOLIDADO POR ORIGEN (UNION ALL)
   Propósito: practicar la consolidación de dos grupos de ventas.
   Como no hay un canal real y todas las ventas son de marzo,
   se separan de forma ilustrativa por ID: 1 a 5 y 6 a 10.
   Estos grupos no representan canales comerciales reales. */

SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Grupo de ventas 1 (IDs 1 a 5)' AS canal
    FROM ventas
    WHERE id_venta BETWEEN 1 AND 5

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Grupo de ventas 2 (IDs 6 a 10)' AS canal
    FROM ventas
    WHERE id_venta BETWEEN 6 AND 10
) AS consolidado
GROUP BY canal
ORDER BY canal;

-- Hallazgo: el Grupo 1 suma $3.620 y el Grupo 2 suma $2.824.
-- El primero concentra $796 más; esta división es didáctica y no
-- permite concluir qué canal comercial vende más.
GO
