-- Proyecto: RetailPro
-- Módulo 4: Consultas SQL de negocio
-- Motor utilizado: SQL Server (SSMS)
-- Base de datos: Ventas_Tech_DB
-- Las consultas trabajan únicamente con la tabla ventas, según la consigna.

USE Ventas_Tech_DB;
GO

/* CONSULTA 1 — RESUMEN EJECUTIVO MENSUAL */
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
GO

/* CONSULTA 2 — RANKING DE PRODUCTOS */
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO

/* CONSULTA 3 — CLIENTES RECURRENTES */
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC, total_gastado DESC;
GO

/* CONSULTA 4 — PRODUCTOS POR ENCIMA / POR DEBAJO DEL PROMEDIO */
WITH TotalesPorProducto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_facturado)
            FROM TotalesPorProducto
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_con_promedio
FROM TotalesPorProducto
ORDER BY total_facturado DESC;
GO

/* HALLAZGOS */

-- 1. El producto 1 es el de mayor facturación, con $3.600,
--    aproximadamente el 55,9% del total vendido.

-- 2. Los productos 1 y 3 generan en conjunto $4.950,
--    aproximadamente el 76,8% de la facturación total.

-- 3. Los cinco clientes realizaron 2 pedidos cada uno.
--    El cliente 1 registra el mayor gasto acumulado, con $2.640.
