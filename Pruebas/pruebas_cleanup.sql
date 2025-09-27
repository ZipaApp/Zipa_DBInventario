-- ========================
-- ELIMINAR DATOS DE PRUEBA
-- ========================

-- 1. Eliminar datos en tablas hijas primero (para no romper FKs)
DELETE FROM "Comercia";
DELETE FROM "Sede";
DELETE FROM "Stock";

-- 2. Eliminar datos en tablas principales
DELETE FROM "Producto";
DELETE FROM "Almacen";
DELETE FROM "Proveedor";
DELETE FROM "Clasificacion";

-- 3. Opcional: reiniciar contadores de IDs (secuencias)
ALTER SEQUENCE "Clasificacion_Cat_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Producto_Prod_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Almacen_Alm_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Proveedor_Prov_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Sede_Sed_id_seq" RESTART WITH 1;
ALTER SEQUENCE "Comercia_Com_id_seq" RESTART WITH 1;

-- ========================
-- VERIFICAR QUE QUEDÓ LIMPIO
-- ========================
SELECT 'Clasificacion', COUNT(*) FROM "Clasificacion"
UNION ALL
SELECT 'Producto', COUNT(*) FROM "Producto"
UNION ALL
SELECT 'Almacen', COUNT(*) FROM "Almacen"
UNION ALL
SELECT 'Proveedor', COUNT(*) FROM "Proveedor"
UNION ALL
SELECT 'Sede', COUNT(*) FROM "Sede"
UNION ALL
SELECT 'Comercia', COUNT(*) FROM "Comercia"
UNION ALL
SELECT 'Stock', COUNT(*) FROM "Stock";
