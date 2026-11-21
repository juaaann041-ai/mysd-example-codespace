-- 9. SERVICIO DE ACTOR: JUNTA ADMINISTRADORA (SV_JUNTA)


CREATE SCHEMA IF NOT EXISTS SV_JUNTA;

CREATE OR REPLACE FUNCTION SV_JUNTA.evaluar_plan(
    p_plan INTEGER,
    p_aprobado BOOLEAN
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_PLANES.evaluar_plan(p_plan, p_aprobado);
END;
$$;

CREATE OR REPLACE FUNCTION SV_JUNTA.consultar_estado_formacion_por_habilidades(
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
SET search_path = SV_PLANES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_PLANES.consultar_estado_formacion_por_habilidades(p_habilidad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_JUNTA.consultar_planes(
    p_estado VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    numero INTEGER,
    fecha DATE,
    estado TEstado,
    evaluador TCorreo,
    fechaFin DATE,
    candidato VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, SV_PLANES, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT pf.numero, pf.fecha, pf.estado, pf.evaluador, pf.fechaFin, pf.candidato
      FROM PlanesFormacion pf
     WHERE (p_estado IS NULL OR pf.estado = p_estado::TEstado)
     ORDER BY pf.numero;
END;
$$;

CREATE OR REPLACE FUNCTION SV_JUNTA.consultar_detalle_plan(
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
SET search_path = SV_PLANES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_PLANES.consultar_plan(p_plan);
END;
$$;



-- 10. SERVICIO DE ACTOR: CANDIDATO (SV_CANDIDATO)


CREATE SCHEMA IF NOT EXISTS SV_CANDIDATO;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.registrar_plan(
    p_evaluador VARCHAR,
    p_fecha DATE DEFAULT CURRENT_DATE,
    p_candidato VARCHAR DEFAULT NULL
)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
DECLARE
    v_candidato VARCHAR;
    v_num INTEGER;
BEGIN
    v_candidato := COALESCE(p_candidato, current_user);
    v_num := SV_PLANES.registrar_plan(v_candidato, p_evaluador, p_fecha);
    RETURN v_num;
END;
$$;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.adicionar_habilidad(
    p_plan INTEGER,
    p_habilidad VARCHAR,
    p_prioridad VARCHAR,
    p_candidato VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
DECLARE
    v_cand_plan VARCHAR;
BEGIN
    SELECT candidato INTO v_cand_plan FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan % no existe.', p_plan;
    END IF;

    IF p_candidato IS NOT NULL AND v_cand_plan <> p_candidato THEN
        RAISE EXCEPTION 'No está autorizado para modificar un plan que no le pertenece.';
    END IF;

    PERFORM SV_PLANES.adicionar_habilidad(p_plan, p_habilidad, p_prioridad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.modificar_prioridad(
    p_plan INTEGER,
    p_habilidad VARCHAR,
    p_nueva_prioridad VARCHAR,
    p_candidato VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
DECLARE
    v_cand_plan VARCHAR;
BEGIN
    SELECT candidato INTO v_cand_plan FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan % no existe.', p_plan;
    END IF;

    IF p_candidato IS NOT NULL AND v_cand_plan <> p_candidato THEN
        RAISE EXCEPTION 'No está autorizado para modificar un plan que no le pertenece.';
    END IF;

    PERFORM SV_PLANES.modificar_prioridad(p_plan, p_habilidad, p_nueva_prioridad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.eliminar_habilidad(
    p_plan INTEGER,
    p_habilidad VARCHAR,
    p_candidato VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
DECLARE
    v_cand_plan VARCHAR;
BEGIN
    SELECT candidato INTO v_cand_plan FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan % no existe.', p_plan;
    END IF;

    IF p_candidato IS NOT NULL AND v_cand_plan <> p_candidato THEN
        RAISE EXCEPTION 'No está autorizado para modificar un plan que no le pertenece.';
    END IF;

    PERFORM SV_PLANES.eliminar_habilidad(p_plan, p_habilidad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.iniciar_ejecucion(
    p_plan INTEGER,
    p_candidato VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_PLANES, public, pg_temp
AS $$
DECLARE
    v_cand_plan VARCHAR;
BEGIN
    SELECT candidato INTO v_cand_plan FROM PlanesFormacion WHERE numero = p_plan;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El plan % no existe.', p_plan;
    END IF;

    IF p_candidato IS NOT NULL AND v_cand_plan <> p_candidato THEN
        RAISE EXCEPTION 'No está autorizado para iniciar la ejecución de un plan que no le pertenece.';
    END IF;

    PERFORM SV_PLANES.iniciar_ejecucion(p_plan);
END;
$$;

CREATE OR REPLACE FUNCTION SV_CANDIDATO.consultar_mi_plan(
    p_candidato VARCHAR
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
SET search_path = SV_PLANES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT pf.numero, pf.fecha, pf.estado, pf.evaluador, pf.fechaFin, pf.candidato,
           COUNT(DISTINCT tp.habilidad) AS total_habilidades,
           COUNT(DISTINCT av.id) AS total_avances
      FROM PlanesFormacion pf
      LEFT JOIN TienePrioridades tp ON tp.planFormacion = pf.numero
      LEFT JOIN Avances av ON av.planFormacion = pf.numero
     WHERE pf.candidato = p_candidato
     GROUP BY pf.numero, pf.fecha, pf.estado, pf.evaluador, pf.fechaFin, pf.candidato
     ORDER BY pf.numero DESC;
END;
$$;