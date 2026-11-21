
CREATE SCHEMA IF NOT EXISTS SV_PLANES;

-- 8.1 registrar_plan: Registra un nuevo plan en estado 'En diseño'
CREATE OR REPLACE FUNCTION SV_PLANES.registrar_plan(
    p_candidato VARCHAR,
    p_evaluador VARCHAR,
    p_fecha DATE DEFAULT CURRENT_DATE
)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
DECLARE
    v_numero INTEGER;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Candidatos WHERE correo = p_candidato) THEN
        RAISE EXCEPTION 'El candidato % no se encuentra registrado.', p_candidato;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Candidatos WHERE correo = p_evaluador) THEN
        RAISE EXCEPTION 'El evaluador % no se encuentra registrado como candidato.', p_evaluador;
    END IF;

    INSERT INTO PlanesFormacion (candidato, evaluador, fecha, estado)
    VALUES (p_candidato, p_evaluador, p_fecha, 'En diseño')
    RETURNING numero INTO v_numero;

    RETURN v_numero;
END;
$$;

-- 8.2 adicionar_habilidad: Asigna una habilidad y prioridad al plan
CREATE OR REPLACE FUNCTION SV_PLANES.adicionar_habilidad(
    p_plan INTEGER,
    p_habilidad VARCHAR,
    p_prioridad VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PlanesFormacion WHERE numero = p_plan) THEN
        RAISE EXCEPTION 'El plan de formación % no existe.', p_plan;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Habilidades WHERE nombreCorto = p_habilidad) THEN
        RAISE EXCEPTION 'La habilidad % no existe.', p_habilidad;
    END IF;

    INSERT INTO TienePrioridades (planFormacion, habilidad, prioridad)
    VALUES (p_plan, p_habilidad, p_prioridad::TPrioridad);
END;
$$;

-- 8.3 modificar_prioridad: Actualiza la prioridad de una habilidad en el plan
CREATE OR REPLACE FUNCTION SV_PLANES.modificar_prioridad(
    p_plan INTEGER,
    p_habilidad VARCHAR,
    p_nueva_prioridad VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM TienePrioridades WHERE planFormacion = p_plan AND habilidad = p_habilidad) THEN
        RAISE EXCEPTION 'La habilidad % no está asignada al plan %.', p_habilidad, p_plan;
    END IF;

    UPDATE TienePrioridades
       SET prioridad = p_nueva_prioridad::TPrioridad
     WHERE planFormacion = p_plan
       AND habilidad = p_habilidad;
END;
$$;

-- 8.4 eliminar_habilidad: Elimina una habilidad de un plan en diseño
CREATE OR REPLACE FUNCTION SV_PLANES.eliminar_habilidad(
    p_plan INTEGER,
    p_habilidad VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM TienePrioridades WHERE planFormacion = p_plan AND habilidad = p_habilidad) THEN
        RAISE EXCEPTION 'La habilidad % no está asignada al plan %.', p_habilidad, p_plan;
    END IF;

    DELETE FROM TienePrioridades
     WHERE planFormacion = p_plan
       AND habilidad = p_habilidad;
END;
$$;

-- 8.5 iniciar_ejecucion: Pasa el plan de 'En diseño' a 'En ejecución'
CREATE OR REPLACE FUNCTION SV_PLANES.iniciar_ejecucion(
    p_plan INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
DECLARE
    v_estado TEstado;
    v_total_habilidades INTEGER;
BEGIN
    SELECT estado INTO v_estado FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan de formación % no existe.', p_plan;
    END IF;

    IF v_estado <> 'En diseño' THEN
        RAISE EXCEPTION 'Solo un plan en estado "En diseño" puede pasar a "En ejecución". Estado actual: %', v_estado;
    END IF;

    SELECT COUNT(*) INTO v_total_habilidades FROM TienePrioridades WHERE planFormacion = p_plan;
    IF v_total_habilidades = 0 THEN
        RAISE EXCEPTION 'No se puede iniciar la ejecución de un plan sin habilidades configuradas.';
    END IF;

    UPDATE PlanesFormacion
       SET estado = 'En ejecución'
     WHERE numero = p_plan;
END;
$$;

-- 8.6 evaluar_plan: Dictamina la aprobación o no aprobación del plan
CREATE OR REPLACE FUNCTION SV_PLANES.evaluar_plan(
    p_plan INTEGER,
    p_aprobado BOOLEAN
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
DECLARE
    v_estado TEstado;
    v_nuevo_estado TEstado;
BEGIN
    SELECT estado INTO v_estado FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan de formación % no existe.', p_plan;
    END IF;

    IF v_estado <> 'En ejecución' THEN
        RAISE EXCEPTION 'Solo un plan "En ejecución" puede ser evaluado. Estado actual: %', v_estado;
    END IF;

    v_nuevo_estado := CASE WHEN p_aprobado THEN 'Aprobado' ELSE 'No aprobado' END;

    UPDATE PlanesFormacion
       SET estado = v_nuevo_estado,
           fechaFin = CURRENT_DATE
     WHERE numero = p_plan;
END;
$$;

-- 8.7 consultar_plan: Consulta integral de los datos de un plan
CREATE OR REPLACE FUNCTION SV_PLANES.consultar_plan(
    p_plan INTEGER
)
RETURNS TABLE (
    numero INTEGER,
    fecha DATE,
    estado TEstado,
    evaluador TCorreo,
    fechaFin DATE,
    candidato VARCHAR,
    total_habilidades BIGINT,
    total_avances BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT pf.numero,
           pf.fecha,
           pf.estado,
           pf.evaluador,
           pf.fechaFin,
           pf.candidato,
           COUNT(DISTINCT tp.habilidad) AS total_habilidades,
           COUNT(DISTINCT av.id) AS total_avances
      FROM PlanesFormacion pf
      LEFT JOIN TienePrioridades tp ON tp.planFormacion = pf.numero
      LEFT JOIN Avances av ON av.planFormacion = pf.numero
     WHERE pf.numero = p_plan
     GROUP BY pf.numero, pf.fecha, pf.estado, pf.evaluador, pf.fechaFin, pf.candidato;
END;
$$;

-- 8.8 consultar_habilidades_plan: Consulta las habilidades y prioridades de un plan
CREATE OR REPLACE FUNCTION SV_PLANES.consultar_habilidades_plan(
    p_plan INTEGER
)
RETURNS TABLE (
    plan_numero INTEGER,
    habilidad_codigo VARCHAR,
    habilidad_nombre VARCHAR,
    prioridad TPrioridad
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT tp.planFormacion,
           h.nombreCorto,
           h.nombre,
           tp.prioridad
      FROM TienePrioridades tp
      JOIN Habilidades h ON h.nombreCorto = tp.habilidad
     WHERE tp.planFormacion = p_plan
     ORDER BY CASE tp.prioridad WHEN 'Alta' THEN 1 WHEN 'Media' THEN 2 ELSE 3 END, h.nombre;
END;
$$;

-- 8.9 consultar_estado_formacion_por_habilidades
-- Consulta requerida explícitamente en el enunciado del laboratorio
CREATE OR REPLACE FUNCTION SV_PLANES.consultar_estado_formacion_por_habilidades(
    p_habilidad VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    habilidad_codigo VARCHAR,
    habilidad_nombre VARCHAR,
    candidato_correo TCorreo,
    candidato_nombre VARCHAR,
    plan_numero INTEGER,
    plan_estado TEstado,
    prioridad TPrioridad,
    cursos_disponibles BIGINT,
    avances_registrados BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT h.nombreCorto AS habilidad_codigo,
           h.nombre AS habilidad_nombre,
           c.correo AS candidato_correo,
           c.nombres AS candidato_nombre,
           pf.numero AS plan_numero,
           pf.estado AS plan_estado,
           tp.prioridad,
           (SELECT COUNT(*) FROM CursosHabilidades ch
              JOIN Cursos cur ON cur.codigo = ch.curso
             WHERE ch.habilidad = h.nombreCorto AND cur.cerrado = FALSE) AS cursos_disponibles,
           (SELECT COUNT(*) FROM Avances a
             WHERE a.planFormacion = pf.numero) AS avances_registrados
      FROM Habilidades h
      JOIN TienePrioridades tp ON tp.habilidad = h.nombreCorto
      JOIN PlanesFormacion pf ON pf.numero = tp.planFormacion
      JOIN Candidatos c ON c.correo = pf.candidato
     WHERE (p_habilidad IS NULL OR h.nombreCorto = p_habilidad)
     ORDER BY h.nombreCorto, pf.numero;
END;
$$;


-- 11. CASO DE USO 2 (BONO): SV_NOTIFICACIONES


CREATE SCHEMA IF NOT EXISTS SV_NOTIFICACIONES;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.registrar_notificacion(
    p_avance INTEGER,
    p_correo_destino TCorreo,
    p_evento TAvance,
    p_accion TAccion,
    p_detalle VARCHAR,
    p_tiempo_lectura INTEGER,
    p_canal TCanal DEFAULT NULL
)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_NOTIFICACIONES, pg_temp
AS $$
DECLARE
    v_id INTEGER;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Avances WHERE id = p_avance) THEN
        RAISE EXCEPTION 'El avance % no existe.', p_avance;
    END IF;

    INSERT INTO Notificaciones (
        detalleNotificacion, tiempoLectura, correoDestino,
        accion, evento, canal, avance
    )
    VALUES (
        p_detalle, p_tiempo_lectura, p_correo_destino,
        p_accion, p_evento, p_canal, p_avance
    )
    RETURNING id INTO v_id;

    RETURN v_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.marcar_leida(
    p_id INTEGER,
    p_fecha_lectura TIMESTAMP DEFAULT NOW()
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_NOTIFICACIONES, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Notificaciones WHERE id = p_id) THEN
        RAISE EXCEPTION 'La notificación % no existe.', p_id;
    END IF;

    UPDATE Notificaciones
       SET fechaLectura = p_fecha_lectura
     WHERE id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.consultar_notificaciones(
    p_correo TCorreo DEFAULT NULL
)
RETURNS TABLE (
    id INTEGER,
    detalleNotificacion VARCHAR,
    correoDestino TCorreo,
    asunto VARCHAR,
    mensaje VARCHAR,
    accion TAccion,
    evento TAvance,
    canal TCanal,
    fechaGeneracion TIMESTAMP,
    fechaLectura TIMESTAMP,
    avance INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_NOTIFICACIONES, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT n.id, n.detalleNotificacion, n.correoDestino, n.asunto, n.mensaje,
           n.accion, n.evento, n.canal, n.fechaGeneracion, n.fechaLectura, n.avance
      FROM Notificaciones n
     WHERE (p_correo IS NULL OR n.correoDestino = p_correo)
     ORDER BY n.id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.eliminar_notificacion(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_NOTIFICACIONES, pg_temp
AS $$
BEGIN
    DELETE FROM Notificaciones WHERE id = p_id;
END;
$$;

