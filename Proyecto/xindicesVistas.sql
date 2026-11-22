
-- 1. Eliminación de Vistas
DROP VIEW IF EXISTS v_mascotas_titulares CASCADE;
DROP VIEW IF EXISTS v_notificaciones_citas CASCADE;
DROP VIEW IF EXISTS v_diagnosticos_por_gravedad CASCADE;
DROP VIEW IF EXISTS v_titulares_citas_frecuentes CASCADE;
DROP VIEW IF EXISTS v_tasa_citas_estado CASCADE;
DROP VIEW IF EXISTS v_servicios_mas_solicitados CASCADE;
DROP VIEW IF EXISTS v_mascotas_por_especie CASCADE;
DROP VIEW IF EXISTS v_productividad_veterinarios CASCADE;
DROP VIEW IF EXISTS v_servicios_por_categoria CASCADE;
DROP VIEW IF EXISTS v_detalle_servicios CASCADE;
DROP VIEW IF EXISTS v_veterinarios_sin_disponibilidad CASCADE;
DROP VIEW IF EXISTS v_disponibilidad_veterinarios CASCADE;
DROP VIEW IF EXISTS v_citas_agendadas CASCADE;
DROP VIEW IF EXISTS v_historial_clinico_completo CASCADE;

-- 2. Eliminación de Índices
DROP INDEX IF EXISTS idx_servicios_preciobase;
DROP INDEX IF EXISTS idx_historiales_mascota;
DROP INDEX IF EXISTS idx_servicioprestado_veterinario;
DROP INDEX IF EXISTS idx_diagnosticos_gravedad;
DROP INDEX IF EXISTS idx_diagnosticos_fechagenerada;
DROP INDEX IF EXISTS idx_diagnosticos_historial;
DROP INDEX IF EXISTS idx_diagnosticos_mascota;
DROP INDEX IF EXISTS idx_disponibilidades_estado;
DROP INDEX IF EXISTS idx_disponibilidades_veterinario;
DROP INDEX IF EXISTS idx_disponibilidades_fechas;
DROP INDEX IF EXISTS idx_citas_servicio;
DROP INDEX IF EXISTS idx_citas_titular;
DROP INDEX IF EXISTS idx_citas_mascota;
DROP INDEX IF EXISTS idx_citas_estado;
DROP INDEX IF EXISTS idx_citas_fecha_hora;
DROP INDEX IF EXISTS idx_mascotas_nombre;
DROP INDEX IF EXISTS idx_mascotas_especie;
DROP INDEX IF EXISTS idx_mascotas_titular;
