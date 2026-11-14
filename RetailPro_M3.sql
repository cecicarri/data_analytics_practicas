/*
Proyecto: RetailPro
Base de datos: Ventas_Tech_DB
Motor: Microsoft SQL Server
Entrega: Pre-entrega 3 - Esquema normalizado y datos iniciales (DDL + DML)

IMPORTANTE:
- Este script crea la base Ventas_Tech_DB si todavía no existe.
- Para permitir volver a ejecutar el script, elimina y recrea las cinco tablas.
- Si ya tenés datos que quieras conservar en estas tablas, hacé una copia antes de ejecutarlo.
- Los datos incluidos son ficticios y se utilizan con fines académicos.
*/

-- =========================================================
-- 1. CREAR Y SELECCIONAR LA BASE DE DATOS
-- =========================================================
IF DB_ID(N'Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END;
GO

USE Ventas_Tech_DB;
GO

-- =========================================================
-- 2. ELIMINAR TABLAS ANTERIORES (si existen)
-- Se eliminan primero las tablas que tienen claves foráneas.
-- =========================================================
DROP TABLE IF EXISTS dbo.ventas;
DROP TABLE IF EXISTS dbo.productos;
DROP TABLE IF EXISTS dbo.clientes;
DROP TABLE IF EXISTS dbo.territorios;
DROP TABLE IF EXISTS dbo.categorias;
GO

-- =========================================================
-- 3. DDL: CREAR LAS TABLAS
-- =========================================================

-- Tabla independiente: categorías
CREATE TABLE dbo.categorias (
    id_categoria INT NOT NULL,
    nombre_categoria VARCHAR(100) NOT NULL,
    CONSTRAINT PK_categorias PRIMARY KEY (id_categoria)
);
GO

-- Tabla independiente: clientes
CREATE TABLE dbo.clientes (
    id_cliente INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NULL,
    ciudad VARCHAR(100) NOT NULL,
    segmento VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL,
    CONSTRAINT PK_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_clientes_email UNIQUE (email)
);
GO

-- Tabla independiente: territorios
CREATE TABLE dbo.territorios (
    id_territorio INT NOT NULL,
    region VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    zona VARCHAR(100) NOT NULL,
    CONSTRAINT PK_territorios PRIMARY KEY (id_territorio)
);
GO

-- Productos: cada producto pertenece a una categoría
CREATE TABLE dbo.productos (
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_productos PRIMARY KEY (id_producto),
    CONSTRAINT FK_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES dbo.categorias(id_categoria),
    CONSTRAINT CK_productos_precio CHECK (precio >= 0),
    CONSTRAINT CK_productos_costo CHECK (costo >= 0)
);
GO

-- Ventas: cada registro representa la venta de un producto.
-- Una venta referencia un cliente, un producto y un territorio.
CREATE TABLE dbo.ventas (
    id_venta INT NOT NULL,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_territorio INT NOT NULL,
    cantidad INT NOT NULL,
    total_venta DECIMAL(12,2) NOT NULL,
    canal VARCHAR(50) NOT NULL,
    CONSTRAINT PK_ventas PRIMARY KEY (id_venta),
    CONSTRAINT FK_ventas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES dbo.clientes(id_cliente),
    CONSTRAINT FK_ventas_productos
        FOREIGN KEY (id_producto)
        REFERENCES dbo.productos(id_producto),
    CONSTRAINT FK_ventas_territorios
        FOREIGN KEY (id_territorio)
        REFERENCES dbo.territorios(id_territorio),
    CONSTRAINT CK_ventas_cantidad CHECK (cantidad > 0),
    CONSTRAINT CK_ventas_total CHECK (total_venta >= 0)
);
GO

-- =========================================================
-- 4. DML: INSERTAR DATOS INICIALES
-- Se cargan primero las tablas referenciadas y luego Ventas.
-- =========================================================

INSERT INTO dbo.categorias (id_categoria, nombre_categoria) VALUES
(1, 'Computación'),
(2, 'Celulares'),
(3, 'Periféricos'),
(4, 'Audio');

INSERT INTO dbo.clientes
(id_cliente, nombre, email, ciudad, segmento, fecha_registro) VALUES
(1, 'María López', 'maria.lopez@mail.com', 'Buenos Aires', 'Minorista', '2025-01-05'),
(2, 'Carlos Ruiz', 'carlos.ruiz@mail.com', 'Córdoba', 'Mayorista', '2025-01-12'),
(3, 'Ana Gómez', 'ana.gomez@mail.com', 'Rosario', 'Minorista', '2025-02-03'),
(4, 'Pedro Sanz', 'pedro.sanz@mail.com', 'Mendoza', 'Corporativo', '2025-02-18'),
(5, 'Laura Torres', 'laura.torres@mail.com', 'Tucumán', 'Minorista', '2025-03-02'),
(6, 'Diego Fernández', 'diego.fernandez@mail.com', 'La Plata', 'Corporativo', '2025-03-15'),
(7, 'Sofía Castro', 'sofia.castro@mail.com', 'Mar del Plata', 'Mayorista', '2025-04-01');

INSERT INTO dbo.territorios (id_territorio, region, pais, zona) VALUES
(1, 'Buenos Aires', 'Argentina', 'Centro'),
(2, 'Córdoba', 'Argentina', 'Centro'),
(3, 'Litoral', 'Argentina', 'Noreste'),
(4, 'Cuyo', 'Argentina', 'Oeste'),
(5, 'NOA', 'Argentina', 'Noroeste');

INSERT INTO dbo.productos
(id_producto, nombre_producto, id_categoria, precio, costo) VALUES
(1, 'Notebook Lenovo IdeaPad', 1, 950000.00, 720000.00),
(2, 'Notebook Dell Inspiron', 1, 1120000.00, 860000.00),
(3, 'Smartphone Samsung A55', 2, 620000.00, 455000.00),
(4, 'Smartphone Motorola Edge', 2, 710000.00, 530000.00),
(5, 'Mouse inalámbrico Logitech', 3, 38000.00, 21000.00),
(6, 'Teclado mecánico Redragon', 3, 89000.00, 57000.00),
(7, 'Auriculares JBL Bluetooth', 4, 125000.00, 79000.00),
(8, 'Parlante portátil Sony', 4, 165000.00, 108000.00);

INSERT INTO dbo.ventas
(id_venta, fecha_venta, id_cliente, id_producto, id_territorio, cantidad, total_venta, canal) VALUES
(1,  '2025-03-03', 1, 1, 1, 1,  950000.00, 'Online'),
(2,  '2025-03-05', 2, 5, 2, 4,  152000.00, 'Presencial'),
(3,  '2025-03-08', 3, 3, 3, 1,  620000.00, 'Online'),
(4,  '2025-03-12', 1, 7, 1, 2,  250000.00, 'Online'),
(5,  '2025-03-15', 4, 2, 4, 1, 1120000.00, 'Corporativo'),
(6,  '2025-04-02', 5, 6, 5, 2,  178000.00, 'Presencial'),
(7,  '2025-04-06', 2, 4, 2, 1,  710000.00, 'Online'),
(8,  '2025-04-10', 6, 1, 1, 2, 1900000.00, 'Corporativo'),
(9,  '2025-04-14', 3, 8, 3, 1,  165000.00, 'Presencial'),
(10, '2025-04-20', 7, 5, 1, 5,  190000.00, 'Online'),
(11, '2025-05-04', 1, 3, 1, 1,  620000.00, 'Presencial'),
(12, '2025-05-09', 4, 6, 4, 3,  267000.00, 'Corporativo'),
(13, '2025-05-13', 5, 7, 5, 1,  125000.00, 'Online'),
(14, '2025-05-18', 6, 2, 1, 1, 1120000.00, 'Corporativo'),
(15, '2025-05-22', 7, 8, 2, 2,  330000.00, 'Presencial');

-- =========================================================
-- 5. VALIDACIÓN: COMPROBAR QUE SE CARGARON LOS REGISTROS
-- =========================================================
SELECT 'categorias' AS tabla, COUNT(*) AS cantidad_registros FROM dbo.categorias
UNION ALL
SELECT 'clientes', COUNT(*) FROM dbo.clientes
UNION ALL
SELECT 'territorios', COUNT(*) FROM dbo.territorios
UNION ALL
SELECT 'productos', COUNT(*) FROM dbo.productos
UNION ALL
SELECT 'ventas', COUNT(*) FROM dbo.ventas;
GO

-- =========================================================
-- 6. VALIDACIÓN: CONSULTA DE VENTAS CON SUS REFERENCIAS
-- Permite comprobar que las claves foráneas relacionan bien
-- las ventas con clientes, productos y territorios.
-- =========================================================
SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre AS cliente,
    p.nombre_producto,
    cat.nombre_categoria,
    t.region,
    v.cantidad,
    v.total_venta,
    v.canal
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat
    ON p.id_categoria = cat.id_categoria
INNER JOIN dbo.territorios AS t
    ON v.id_territorio = t.id_territorio
ORDER BY v.fecha_venta, v.id_venta;
GO

/*
Fin del script.

Resumen de registros esperados:
- categorias: 4
- clientes: 7
- territorios: 5
- productos: 8
- ventas: 15

Nota de granularidad:
Cada fila de ventas representa un producto vendido dentro de una operación.
Si una operación pudiera incluir varios productos distintos, en una versión
más avanzada se podría separar Ventas (cabecera) de Detalle_Venta.
*/
