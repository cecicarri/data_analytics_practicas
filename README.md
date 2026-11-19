# RetailPro | Proyecto de Análisis de Datos

## Descripción del proyecto

RetailPro es un proyecto académico de análisis de datos aplicado a una distribuidora de tecnología. Su objetivo es transformar información de ventas, clientes, productos y categorías en indicadores que permitan comprender el desempeño comercial y acompañar la toma de decisiones.

El trabajo se desarrolla en distintas etapas: diseño de la base de datos, consultas SQL, integración de tablas, transformación de datos y construcción de un modelo analítico en Power BI.

## Objetivos

- Analizar la facturación y la cantidad de pedidos.
- Identificar los productos con mayor facturación y volumen de ventas.
- Explorar el comportamiento de las ventas por período, cliente y categoría.
- Integrar información de distintas tablas mediante consultas SQL.
- Preparar y transformar los datos para su análisis.
- Construir indicadores y visualizaciones para apoyar decisiones comerciales.

## Herramientas utilizadas

- **Microsoft SQL Server:** creación y administración de la base de datos.
- **SQL Server Management Studio (SSMS):** ejecución y validación de consultas SQL.
- **Power BI Desktop:** modelado y visualización de los datos.
- **Power Query:** limpieza y transformación de información.
- **DAX:** creación de medidas e indicadores.
- **GitHub:** almacenamiento, control de versiones y documentación del proyecto.

## Estructura del repositorio

```text
data_analytics_practicas/
├── ventas_tech_db.sql
├── m4_consultas_negocio.sql
├── m5_consultas_joins.sql
└── README.md
```

## Archivos SQL

| Archivo | Descripción |
|---|---|
| `ventas_tech_db.sql` | Crea la base `Ventas_Tech_DB`, define las tablas, claves y relaciones, e incorpora los datos iniciales. |
| `m4_consultas_negocio.sql` | Contiene consultas de análisis comercial: resumen mensual, ranking de productos, clientes recurrentes y comparación de productos contra el promedio. |
| `m5_consultas_joins.sql` | Incluye consultas con `INNER JOIN`, `LEFT JOIN` y `UNION ALL` para integrar información de ventas, clientes, productos y categorías. |

## Cómo ejecutar los scripts SQL

1. Abrir SQL Server Management Studio (SSMS).
2. Conectarse a una instancia de Microsoft SQL Server.
3. Abrir y ejecutar `ventas_tech_db.sql` para crear la base de datos y cargar las tablas con sus registros iniciales.
4. Abrir `m4_consultas_negocio.sql` y ejecutar las consultas de análisis comercial.
5. Abrir `m5_consultas_joins.sql` y ejecutar las consultas que relacionan las distintas tablas.
6. Revisar los resultados obtenidos en cada consulta.

**Importante:** ejecutar primero el script de creación de la base de datos. Los scripts M4 y M5 dependen de las tablas creadas en esa etapa.

## Modelo analítico en Power BI

El modelo utiliza una tabla de hechos y dimensiones relacionadas:

- `Fact_Ventas`: información de las transacciones.
- `Dim_Clientes`: datos de clientes.
- `Dim_Productos`: información de productos.
- `Dim_Categorias`: clasificación de productos.
- `Dim_Fechas`: calendario para el análisis temporal.

Se definieron relaciones activas de uno a varios (1:N) y medidas DAX para analizar la facturación, las ventas del canal online y las comparaciones entre períodos.

### Medidas principales

- `Total Ventas`
- `Ventas Online`
- `Ventas YTD`
- `Ventas LY`
- `% Crecimiento Anual`

## Resultados y alcance

Las consultas SQL permiten obtener indicadores de facturación, pedidos, ticket promedio y participación de productos.

Los resultados numéricos incluidos en las prácticas corresponden al conjunto de datos de prueba utilizado en cada etapa. Por lo tanto, sirven para validar las consultas y explorar el modelo, pero no deben interpretarse como tendencias históricas del negocio.

## Uso de inteligencia artificial

Se utilizó inteligencia artificial como herramienta de apoyo para revisar consultas SQL, proponer hallazgos comerciales y generar documentación técnica.

Las sugerencias fueron evaluadas críticamente y contrastadas con la estructura de las consultas y los resultados obtenidos. La validación final y las decisiones de implementación se realizaron considerando el criterio analítico del proyecto.

## Estado del proyecto

Proyecto académico desarrollado progresivamente como parte de la formación en análisis de datos. El repositorio reúne los scripts SQL y la documentación de las distintas etapas de RetailPro.
