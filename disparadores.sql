
-- tg_codigo_candidato (Automatización de valores iniciales)
CREATE OR REPLACE FUNCTION fn_codigo_candidato() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.numero IS NULL THEN
        NEW.numero := nextval('planesformacion_numero_seq');
    END IF;
    IF NEW.fecha IS NULL THEN
        NEW.fecha := CURRENT_DATE;
    END IF;
    IF NEW.estado IS NULL THEN
        NEW.estado := 'En diseño';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_codigo_candidato
BEFORE INSERT ON PlanesFormacion
FOR EACH ROW EXECUTE FUNCTION fn_codigo_candidato();


-- tg_plan_evaluador_no_conexion (Restricción de integridad cruzada)

CREATE OR REPLACE FUNCTION fn_plan_evaluador_no_conexion() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.evaluador = NEW.candidato THEN
        RAISE EXCEPTION 'El evaluador no puede ser el mismo candidato (%).', NEW.candidato;
    END IF;

    IF EXISTS (
        SELECT 1 FROM Candidatos_Candidatos
         WHERE (candidato1 = NEW.candidato AND candidato2 = NEW.evaluador)
            OR (candidato2 = NEW.candidato AND candidato1 = NEW.evaluador)
    ) THEN
        RAISE EXCEPTION 'El evaluador (%) no puede ser una conexión del candidato (%).',
            NEW.evaluador, NEW.candidato;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_plan_evaluador_no_conexion
BEFORE INSERT OR UPDATE OF evaluador, candidato ON PlanesFormacion
FOR EACH ROW EXECUTE FUNCTION fn_plan_evaluador_no_conexion();



-- tg_actualizacion_planesformacion (Control de ciclo de vida)
CREATE OR REPLACE FUNCTION fn_actualizacion_planesformacion() RETURNS TRIGGER AS $$
BEGIN
    -- Transición a estado final desde En ejecución
    IF OLD.estado = 'En ejecución'
       AND NEW.estado IN ('Aprobado', 'No aprobado')
       AND NEW.estado <> OLD.estado THEN
        IF NEW.evaluador <> OLD.evaluador OR NEW.candidato <> OLD.candidato THEN
            RAISE EXCEPTION 'Solo se permite actualizar el estado en esta transición.';
        END IF;
        NEW.fechaFin := CURRENT_DATE;
        RETURN NEW;
    END IF;

    IF OLD.estado IN ('Aprobado', 'No aprobado') THEN
        RAISE EXCEPTION 'No se puede modificar un plan en estado final (%).', OLD.estado;
    END IF;

    IF OLD.estado = 'En diseño' AND NEW.estado = 'En diseño' THEN
        IF COALESCE(current_setting('agisworld.skip_month_check', true), 'false') <> 'true' THEN
            IF EXTRACT(MONTH FROM CURRENT_DATE) <> 1 AND EXTRACT(MONTH FROM NEW.fecha) <> 1 THEN
                RAISE EXCEPTION 'Solo se puede modificar un plan en enero.';
            END IF;
        END IF;
    END IF;

    IF OLD.estado = 'En diseño' AND NEW.estado = 'En ejecución' THEN
        IF NEW.candidato <> OLD.candidato OR NEW.evaluador <> OLD.evaluador THEN
            RAISE EXCEPTION 'No se pueden modificar datos del plan al pasar a ejecución.';
        END IF;
        RETURN NEW;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_actualizacion_planesformacion
BEFORE UPDATE ON PlanesFormacion
FOR EACH ROW EXECUTE FUNCTION fn_actualizacion_planesformacion();


-- tg_PlanesFormacion_TEstado (Máquina de estados finitos)
CREATE OR REPLACE FUNCTION fn_planesformacion_testado() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.estado <> OLD.estado THEN
        IF NOT (
               (OLD.estado = 'En diseño'    AND NEW.estado = 'En ejecución')
            OR (OLD.estado = 'En ejecución' AND NEW.estado IN ('Aprobado', 'No aprobado'))
        ) THEN
            RAISE EXCEPTION 'Transición de estado no permitida: % -> %',
                OLD.estado, NEW.estado;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_PlanesFormacion_TEstado
BEFORE UPDATE ON PlanesFormacion
FOR EACH ROW EXECUTE FUNCTION fn_planesformacion_testado();


-- trg_habilidades_plan_validar (Integridad de habilidades)

CREATE OR REPLACE FUNCTION fn_habilidades_plan_validar() RETURNS TRIGGER AS $$
DECLARE
    v_estado    TEstado;
    v_count     INTEGER;
    v_plan      INTEGER;
    v_habilidad VARCHAR(50);
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_plan      := OLD.planFormacion;
        v_habilidad := OLD.habilidad;
    ELSE
        v_plan      := NEW.planFormacion;
        v_habilidad := NEW.habilidad;
    END IF;

    SELECT estado INTO v_estado FROM PlanesFormacion WHERE numero = v_plan;
    IF v_estado <> 'En diseño' THEN
        RAISE EXCEPTION 'Solo se pueden modificar habilidades en estado "En diseño".';
    END IF;

    IF TG_OP <> 'DELETE' THEN
        SELECT COUNT(*) INTO v_count
          FROM CursosHabilidades ch
          JOIN Cursos c ON c.codigo = ch.curso
         WHERE ch.habilidad = v_habilidad
           AND c.cerrado = FALSE;
        IF v_count = 0 THEN
            RAISE EXCEPTION 'La habilidad % no está contemplada en ningún curso ofrecido abierto.', v_habilidad;
        END IF;
    END IF;

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_habilidades_plan_validar
BEFORE INSERT OR UPDATE OR DELETE ON TienePrioridades
FOR EACH ROW EXECUTE FUNCTION fn_habilidades_plan_validar();


-- tg_TienePrioridades_prioridad (Regla de prioridad Alta)

CREATE OR REPLACE FUNCTION fn_tieneprioridades_prioridad() RETURNS TRIGGER AS $$
DECLARE v_count INTEGER;
BEGIN
    IF NEW.prioridad = 'Alta' THEN
        SELECT COUNT(*) INTO v_count
          FROM TienePrioridades
         WHERE planFormacion = NEW.planFormacion
           AND prioridad = 'Alta'
           AND habilidad <> NEW.habilidad;
        IF v_count > 0 THEN
            RAISE EXCEPTION 'Solo puede existir una habilidad de prioridad Alta por plan.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_TienePrioridades_prioridad
BEFORE INSERT OR UPDATE ON TienePrioridades
FOR EACH ROW EXECUTE FUNCTION fn_tieneprioridades_prioridad();



-- tg_PlanesFormacion_eliminar (Restricción de eliminación)

CREATE OR REPLACE FUNCTION fn_plan_no_eliminar() RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'No está permitido eliminar planes de formación.';
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_PlanesFormacion_eliminar
BEFORE DELETE ON PlanesFormacion
FOR EACH ROW EXECUTE FUNCTION fn_plan_no_eliminar();


-- Disparadores de Notificaciones (Caso de Uso 2 - Bono)

CREATE OR REPLACE FUNCTION fn_notif_auto() RETURNS TRIGGER AS $$
DECLARE v_random INTEGER;
BEGIN
    NEW.fechaGeneracion := NOW();
    NEW.fechaLectura    := NULL;
    NEW.asunto  := NEW.evento || TO_CHAR(NEW.fechaGeneracion, 'YYYYMM') || 'AGISWorld';
    NEW.mensaje := 'Notificacion generada para el evento ' || NEW.evento ||
                   ' con accion ' || NEW.accion;
    IF NEW.canal IS NULL THEN
        v_random := FLOOR(RANDOM() * 3)::INTEGER;
        NEW.canal := CASE v_random
                        WHEN 0 THEN 'email' WHEN 1 THEN 'push' ELSE 'whatsapp'
                     END;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notif_auto
BEFORE INSERT ON Notificaciones
FOR EACH ROW EXECUTE FUNCTION fn_notif_auto();

CREATE OR REPLACE FUNCTION fn_notif_modificacion() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.fechaLectura IS NOT NULL THEN
        RAISE EXCEPTION 'No se puede modificar una notificación ya leída.';
    END IF;
    IF (NEW.detalleNotificacion <> OLD.detalleNotificacion OR
        NEW.tiempoLectura        <> OLD.tiempoLectura        OR
        NEW.correoDestino        <> OLD.correoDestino        OR
        NEW.asunto               <> OLD.asunto               OR
        NEW.mensaje              <> OLD.mensaje              OR
        NEW.accion               <> OLD.accion               OR
        NEW.evento               <> OLD.evento               OR
        NEW.canal                <> OLD.canal                OR
        NEW.avance               <> OLD.avance) THEN
        RAISE EXCEPTION 'El único campo modificable es la fecha de lectura.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notif_modificacion
BEFORE UPDATE ON Notificaciones
FOR EACH ROW EXECUTE FUNCTION fn_notif_modificacion();

CREATE OR REPLACE FUNCTION fn_notif_eliminar() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.fechaLectura IS NOT NULL THEN
        RAISE EXCEPTION 'No se puede eliminar una notificación que ya fue leída.';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notif_eliminar
BEFORE DELETE ON Notificaciones
FOR EACH ROW EXECUTE FUNCTION fn_notif_eliminar();

