-- 1. CREACIÓN DE ROLES DEL SISTEMA

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rol_veterinario') THEN
        CREATE ROLE rol_veterinario;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rol_titular') THEN
        CREATE ROLE rol_titular;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rol_gerente') THEN
        CREATE ROLE rol_gerente;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rol_gerente_comercial') THEN
        CREATE ROLE rol_gerente_comercial;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rol_vendedor') THEN
        CREATE ROLE rol_vendedor;
    END IF;
END
$$;

-- 2. PERMISOS SOBRE ESQUEMAS

-- Esquema público
GRANT USAGE ON SCHEMA public TO rol_veterinario;
GRANT USAGE ON SCHEMA public TO rol_titular;
GRANT USAGE ON SCHEMA public TO rol_gerente;
GRANT USAGE ON SCHEMA public TO rol_gerente_comercial;
GRANT USAGE ON SCHEMA public TO rol_vendedor;

-- Esquemas de actores (especificación ASTA)
GRANT USAGE ON SCHEMA SV_TITULAR TO rol_titular;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA SV_TITULAR TO rol_titular;

GRANT USAGE ON SCHEMA SV_VETERINARIO TO rol_veterinario;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA SV_VETERINARIO TO rol_veterinario;

GRANT USAGE ON SCHEMA SV_GERENTE TO rol_gerente;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA SV_GERENTE TO rol_gerente;

GRANT USAGE ON SCHEMA SV_GERENTECOMERCIAL TO rol_gerente_comercial;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA SV_GERENTECOMERCIAL TO rol_gerente_comercial;

GRANT USAGE ON SCHEMA SV_VENDEDOR TO rol_vendedor;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA SV_VENDEDOR TO rol_vendedor;

-- 3. PERMISOS DETALLADOS SOBRE TABLAS Y VISTAS

-- Permisos para rol_veterinario
GRANT SELECT ON Personas TO rol_veterinario;
GRANT SELECT ON Titulares TO rol_veterinario;
GRANT SELECT ON Mascotas TO rol_veterinario;

GRANT SELECT, INSERT, UPDATE, DELETE ON Diagnosticos TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE, DELETE ON FormulacionMedica TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE, DELETE ON HistorialesClinicos TO rol_veterinario;

GRANT SELECT, INSERT, UPDATE ON Servicios TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE ON BañosServicios TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE ON OperacionesServicios TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE ON Consultas TO rol_veterinario;
GRANT SELECT, INSERT, UPDATE, DELETE ON ServicioPrestado TO rol_veterinario;

GRANT SELECT, INSERT, UPDATE, DELETE ON Disponibilidades TO rol_veterinario;
GRANT SELECT, UPDATE (Estado) ON Citas TO rol_veterinario;

GRANT SELECT ON v_historial_clinico_completo TO rol_veterinario;
GRANT SELECT ON v_citas_agendadas TO rol_veterinario;
GRANT SELECT ON v_disponibilidad_veterinarios TO rol_veterinario;
GRANT SELECT ON v_detalle_servicios TO rol_veterinario;
GRANT SELECT ON v_diagnosticos_por_gravedad TO rol_veterinario;
GRANT SELECT ON v_mascotas_titulares TO rol_veterinario;

-- Permisos para rol_titular
GRANT SELECT, UPDATE (telefono, correo) ON Personas TO rol_titular;
GRANT SELECT, UPDATE (telefono, correo) ON Titulares TO rol_titular;
GRANT SELECT, INSERT, UPDATE (nombre) ON Mascotas TO rol_titular;

GRANT SELECT, INSERT, UPDATE (Estado, fecha, Hora) ON Citas TO rol_titular;

GRANT SELECT ON Servicios TO rol_titular;
GRANT SELECT ON BañosServicios TO rol_titular;
GRANT SELECT ON OperacionesServicios TO rol_titular;
GRANT SELECT ON Consultas TO rol_titular;
GRANT SELECT ON Disponibilidades TO rol_titular;
GRANT SELECT ON Veterinarios TO rol_titular;
GRANT SELECT ON Notificaciones TO rol_titular;

GRANT SELECT ON v_citas_agendadas TO rol_titular;
GRANT SELECT ON v_disponibilidad_veterinarios TO rol_titular;
GRANT SELECT ON v_detalle_servicios TO rol_titular;
GRANT SELECT ON v_notificaciones_citas TO rol_titular;
GRANT SELECT ON v_mascotas_titulares TO rol_titular;

-- Permisos para rol_gerente (Auditoría integral y vistas gerenciales)
GRANT SELECT ON v_historial_clinico_completo TO rol_gerente;
GRANT SELECT ON v_citas_agendadas TO rol_gerente;
GRANT SELECT ON v_disponibilidad_veterinarios TO rol_gerente;
GRANT SELECT ON v_veterinarios_sin_disponibilidad TO rol_gerente;
GRANT SELECT ON v_detalle_servicios TO rol_gerente;
GRANT SELECT ON v_servicios_por_categoria TO rol_gerente;
GRANT SELECT ON v_productividad_veterinarios TO rol_gerente;
GRANT SELECT ON v_mascotas_por_especie TO rol_gerente;
GRANT SELECT ON v_servicios_mas_solicitados TO rol_gerente;
GRANT SELECT ON v_tasa_citas_estado TO rol_gerente;
GRANT SELECT ON v_titulares_citas_frecuentes TO rol_gerente;
GRANT SELECT ON v_diagnosticos_por_gravedad TO rol_gerente;
GRANT SELECT ON v_notificaciones_citas TO rol_gerente;
GRANT SELECT ON v_mascotas_titulares TO rol_gerente;

GRANT SELECT ON Personas TO rol_gerente;
GRANT SELECT ON Titulares TO rol_gerente;
GRANT SELECT ON Veterinarios TO rol_gerente;
GRANT SELECT ON Mascotas TO rol_gerente;
GRANT SELECT ON Citas TO rol_gerente;
GRANT SELECT ON Servicios TO rol_gerente;
GRANT SELECT ON BañosServicios TO rol_gerente;
GRANT SELECT ON OperacionesServicios TO rol_gerente;
GRANT SELECT ON Consultas TO rol_gerente;
GRANT SELECT ON ServicioPrestado TO rol_gerente;
GRANT SELECT ON Disponibilidades TO rol_gerente;
GRANT SELECT ON HistorialesClinicos TO rol_gerente;
GRANT SELECT ON Diagnosticos TO rol_gerente;
GRANT SELECT ON FormulacionMedica TO rol_gerente;
GRANT SELECT ON Notificaciones TO rol_gerente;

-- Permisos para rol_vendedor
GRANT SELECT, INSERT, UPDATE ON Notificaciones TO rol_vendedor;
GRANT SELECT, INSERT ON Personas TO rol_vendedor;
GRANT SELECT, INSERT ON Titulares TO rol_vendedor;
GRANT SELECT, INSERT ON Mascotas TO rol_vendedor;
GRANT SELECT, UPDATE (Estado) ON Citas TO rol_vendedor;
GRANT SELECT ON Servicios TO rol_vendedor;

GRANT SELECT ON v_citas_agendadas TO rol_vendedor;
GRANT SELECT ON v_notificaciones_citas TO rol_vendedor;
GRANT SELECT ON v_detalle_servicios TO rol_vendedor;
GRANT SELECT ON v_mascotas_titulares TO rol_vendedor;

-- Permisos para rol_gerente_comercial
GRANT SELECT, INSERT, UPDATE ON Servicios TO rol_gerente_comercial;
GRANT SELECT, INSERT, UPDATE ON BañosServicios TO rol_gerente_comercial;
GRANT SELECT, INSERT, UPDATE ON OperacionesServicios TO rol_gerente_comercial;
GRANT SELECT, INSERT, UPDATE ON Consultas TO rol_gerente_comercial;
GRANT SELECT ON Veterinarios TO rol_gerente_comercial;

GRANT SELECT ON v_detalle_servicios TO rol_gerente_comercial;
GRANT SELECT ON v_servicios_por_categoria TO rol_gerente_comercial;
GRANT SELECT ON v_servicios_mas_solicitados TO rol_gerente_comercial;
GRANT SELECT ON v_productividad_veterinarios TO rol_gerente_comercial;
GRANT SELECT ON v_tasa_citas_estado TO rol_gerente_comercial;

-- 4. PERMISOS SOBRE FUNCIONES DE DISPARADOR

GRANT EXECUTE ON FUNCTION FN_Citas_ValidarModificacion() 
TO rol_veterinario, rol_titular, rol_vendedor;

GRANT EXECUTE ON FUNCTION FN_Citas_ValidarTransicionEstado() 
TO rol_veterinario, rol_vendedor;

GRANT EXECUTE ON FUNCTION FN_Diagnosticos_Inmutabilidad() 
TO rol_veterinario;

GRANT EXECUTE ON FUNCTION FN_Citas_AutomatizarNotificacion() 
TO rol_veterinario, rol_titular, rol_vendedor;

GRANT EXECUTE ON FUNCTION FN_Diagnosticos_ActualizarHistorial() 
TO rol_veterinario;
