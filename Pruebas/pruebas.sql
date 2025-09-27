-- =====================================
-- PRUEBAS PARA MODELO DE INVENTARIO
-- =====================================

-- 1. Limpiar tablas (cuidado: borra datos previos)
TRUNCATE TABLE "Comercia" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Sede" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Stock" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Producto" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Clasificacion" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Proveedor" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Almacen" RESTART IDENTITY CASCADE;

-- 2. Insertar clasificaciones
INSERT INTO "Clasificacion" ("Cat_nombre") VALUES
('Electrónica'),
('Ropa'),
('Alimentos');

-- 3. Insertar productos
INSERT INTO "Producto" ("Prod_codigo", "Prod_nombre", "Prod_tamaño", "Prod_precio", "Prod_cantidad", "Cat_id") VALUES
(1001, 'Laptop', 15, 2500.00, 10, 1),
(1002, 'Teléfono', 6, 1200.00, 20, 1),
(2001, 'Camiseta', 40, 50.00, 100, 2),
(3001, 'Leche', 1, 5.00, 200, 3);

-- 4. Insertar almacenes
INSERT INTO "Almacen" ("Alm_nombre", "Alm_direccion", "Alm_telefono") VALUES
('Central', 'Calle 123', '111111'),
('Sucursal Norte', 'Av. Norte 45', '222222');

-- 5. Insertar stock por almacén
INSERT INTO "Stock" ("Alm_id", "Prod_id", "Stk_cantidad") VALUES
(1, 1, 5),    -- Central tiene 5 Laptops
(1, 2, 10),   -- Central tiene 10 Teléfonos
(2, 3, 50),   -- Sucursal Norte tiene 50 Camisetas
(2, 4, 100);  -- Sucursal Norte tiene 100 Leches

-- 6. Insertar proveedores
INSERT INTO "Proveedor" ("Prov_razonSocial", "Prov_nit", "Prov_responsable", "Prov_correo", "Prov_telefono") VALUES
('TechCorp', 900123, 'Ana Pérez', 'ana@techcorp.com', '3001111111'),
('Moda SA', 900456, 'Luis Gómez', 'luis@moda.com', '3002222222');

-- 7. Insertar sedes de proveedores
INSERT INTO "Sede" ("Prov_id", "Sed_nombre", "Sed_direccion", "Sed_telefono") VALUES
(1, 'TechCorp Central', 'Zona Industrial 12', '555111'),
(2, 'Moda SA Principal', 'Calle de la Moda 34', '555222');

-- 8. Insertar registros de comercialización
INSERT INTO "Comercia" ("Prod_id", "Prov_id", "Com_codigo", "Com_responsable") VALUES
(1, 1, 5001, 'Carlos Ruiz'),   -- Laptop de TechCorp
(3, 2, 5002, 'María López');   -- Camiseta de Moda SA

-- 9. Consultas de prueba

-- 9.1 Ver productos con su clasificación
SELECT p."Prod_nombre", p."Prod_precio", c."Cat_nombre"
FROM "Producto" p
JOIN "Clasificacion" c ON p."Cat_id" = c."Cat_id";

-- 9.2 Ver stock en cada almacén
SELECT a."Alm_nombre", p."Prod_nombre", s."Stk_cantidad"
FROM "Stock" s
JOIN "Almacen" a ON s."Alm_id" = a."Alm_id"
JOIN "Producto" p ON s."Prod_id" = p."Prod_id";

-- 9.3 Ver proveedores y sus sedes
SELECT pr."Prov_razonSocial", s."Sed_nombre", s."Sed_direccion"
FROM "Proveedor" pr
JOIN "Sede" s ON pr."Prov_id" = s."Prov_id";

-- 9.4 Ver productos comercializados con sus proveedores
SELECT p."Prod_nombre", pr."Prov_razonSocial", c."Com_fecha", c."Com_responsable"
FROM "Comercia" c
JOIN "Producto" p ON c."Prod_id" = p."Prod_id"
JOIN "Proveedor" pr ON c."Prov_id" = pr."Prov_id";

-- =====================================
-- FIN DE PRUEBAS
-- =====================================

