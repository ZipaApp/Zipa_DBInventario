-- ========================
-- PRUEBAS AVANZADAS SQL
-- ========================

-- 1. Insertar datos válidos en todas las tablas
INSERT INTO "Clasificacion" ("Cat_nombre") VALUES ('Electrónica'), ('Ropa'), ('Alimentos');

INSERT INTO "Producto" ("Prod_codigo", "Prod_nombre", "Prod_tamaño", "Prod_precio", "Cat_id")
VALUES 
(1001, 'Laptop', 15, 2500.00, 1),
(1002, 'Camisa', NULL, 80.00, 2),
(1003, 'Manzana', 1, 2.50, 3);

INSERT INTO "Almacen" ("Alm_nombre", "Alm_direccion", "Alm_telefono")
VALUES 
('Bodega Central', 'Calle 123', '300111222'),
('Sucursal Norte', 'Av. Norte #45', '300333444');

INSERT INTO "Stock" ("Alm_id", "Prod_id", "Stk_cantidad")
VALUES 
(1, 1, 10),
(1, 2, 50),
(2, 3, 200);

INSERT INTO "Proveedor" ("Prov_razonSocial", "Prov_nit", "Prov_responsable", "Prov_correo", "Prov_telefono")
VALUES 
('TechWorld', 900123456, 'Carlos Pérez', 'ventas@techworld.com', '310000111'),
('ModaSA', 901234567, 'Ana Torres', 'contacto@modasa.com', '320000222');

INSERT INTO "Sede" ("Prov_id", "Sed_nombre", "Sed_direccion", "Sed_telefono")
VALUES 
(1, 'Oficina Principal', 'Cra 10 #20', '601234567'),
(2, 'Sucursal Moda Norte', 'Av. 45 #80', '604567890');

INSERT INTO "Comercia" ("Prod_id", "Prov_id", "Com_codigo", "Com_responsable")
VALUES 
(1, 1, 5001, 'Luis López'),
(2, 2, 5002, 'Marta Gómez');

-- ========================
-- 2. Pruebas de restricciones UNIQUE
-- ========================
-- Deben fallar
-- INSERT INTO "Producto" ("Prod_codigo", "Prod_nombre", "Prod_precio", "Cat_id")
-- VALUES (1001, 'Tablet', 1200.00, 1); -- Prod_codigo duplicado

-- INSERT INTO "Proveedor" ("Prov_razonSocial", "Prov_nit")
-- VALUES ('ProveedorX', 900123456); -- Prov_nit duplicado

-- ========================
-- 3. Pruebas de NOT NULL
-- ========================
-- Deben fallar
-- INSERT INTO "Producto" ("Prod_codigo", "Prod_precio", "Cat_id")
-- VALUES (2001, 999.99, 1); -- Falta Prod_nombre

-- INSERT INTO "Proveedor" ("Prov_nit")
-- VALUES (902345678); -- Falta Prov_razonSocial

-- ========================
-- 4. Pruebas de clave foránea
-- ========================
-- Deben fallar
-- INSERT INTO "Producto" ("Prod_codigo", "Prod_nombre", "Prod_precio", "Cat_id")
-- VALUES (2002, 'Impresora', 800.00, 99); -- Cat_id no existe

-- INSERT INTO "Stock" ("Alm_id", "Prod_id", "Stk_cantidad")
-- VALUES (99, 1, 20); -- Alm_id no existe

-- ========================
-- 5. Pruebas de valores por defecto
-- ========================
INSERT INTO "Producto" ("Prod_codigo", "Prod_nombre", "Prod_precio", "Cat_id")
VALUES (2003, 'Audífonos', 150.00, 1); -- Prod_cantidad debería ser 0 por defecto

INSERT INTO "Comercia" ("Prod_id", "Prov_id", "Com_codigo", "Com_responsable")
VALUES (3, 1, 5003, 'Sofía Duarte'); -- Com_fecha debería tomar now()

-- ========================
-- 6. Pruebas de relaciones N:M
-- ========================
-- Un mismo producto en varios almacenes
INSERT INTO "Stock" ("Alm_id", "Prod_id", "Stk_cantidad") VALUES (2, 1, 5);

-- Un mismo producto con varios proveedores
INSERT INTO "Comercia" ("Prod_id", "Prov_id", "Com_codigo", "Com_responsable")
VALUES (1, 2, 5004, 'Juan Ramírez');

-- ========================
-- 7. Consultas de verificación
-- ========================

-- Verificar categorías y productos
SELECT c."Cat_nombre", p."Prod_nombre", p."Prod_precio"
FROM "Producto" p
JOIN "Clasificacion" c ON p."Cat_id" = c."Cat_id";

-- Verificar stock por almacén
SELECT a."Alm_nombre", p."Prod_nombre", s."Stk_cantidad"
FROM "Stock" s
JOIN "Producto" p ON s."Prod_id" = p."Prod_id"
JOIN "Almacen" a ON s."Alm_id" = a."Alm_id";

-- Verificar proveedores de cada producto
SELECT p."Prod_nombre", pr."Prov_razonSocial", c."Com_fecha"
FROM "Comercia" c
JOIN "Producto" p ON c."Prod_id" = p."Prod_id"
JOIN "Proveedor" pr ON c."Prov_id" = pr."Prov_id";

-- Total de stock por producto
SELECT p."Prod_nombre", SUM(s."Stk_cantidad") AS total_stock
FROM "Stock" s
JOIN "Producto" p ON s."Prod_id" = p."Prod_id"
GROUP BY p."Prod_nombre";

-- Precio promedio por categoría
SELECT c."Cat_nombre", AVG(p."Prod_precio") AS precio_promedio
FROM "Producto" p
JOIN "Clasificacion" c ON p."Cat_id" = c."Cat_id"
GROUP BY c."Cat_nombre";
