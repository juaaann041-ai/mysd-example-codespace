-- Caso ComponentesOK 1: Adicionar una nueva cita a través del servicio SV_CITAS.adicionar
SELECT SV_CITAS.adicionar(
    p_id := 10,
    p_fecha := '2026-11-25',
    p_hora := '09:00:00',
    p_numerocita := 1010,
    p_estado := 'Programada',
    p_numerodocumentotitular := 1012345001,
    p_tipodocumentotitular := 'CC',
    p_idmascota := 1,
    p_idservicio := 1,
    p_idnotificacion := NULL
);

-- Verificación de la cita y de la notificación generada por automatización
SELECT * FROM SV_CITAS.consultar(10);
SELECT * FROM SV_NOTIFICACIONES.co_notificaciones(10);


-- Caso ComponentesOK 2: Registrar formulación médica y diagnóstico clínico
SELECT SV_FORMULACIONESMEDICAS.adicionar(
    p_id := 10,
    p_fecha := '2026-11-25',
    p_descripcion := 'Suplemento vitamínico canino 1 tableta diaria con comida por 30 días'
);

SELECT SV_DIAGNOSTICOS.adicionar(
    p_id := 10,
    p_descripcion := 'Control preventivo satisfactorio, paciente en excelente condición corporal',
    p_fechagenerada := '2026-11-25',
    p_gravedad := 'Leve',
    p_idservicio := 1,
    p_idmascota := 1,
    p_idhistorialclinico := 1,
    p_idformulacionmedica := 10
);

-- Verificación del diagnóstico emitido y del historial clínico actualizado
SELECT * FROM SV_DIAGNOSTICOS.consultar(10);
SELECT * FROM SV_HISTORIALESCLINICOS.consultar(1);


-- Caso ComponentesOK 3: Consultas analíticas y de reporte mediante servicios de componentes
SELECT * FROM SV_MASCOTAS.co_mascotas_por_especie();
SELECT * FROM SV_SERVICIOS.co_tipo_servicios();
SELECT * FROM SV_CITAS.co_servicios_mas_solicitados();
SELECT * FROM SV_DIAGNOSTICOS.co_diagnosticos_gravedad();
