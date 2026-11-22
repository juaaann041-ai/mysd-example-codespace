-- 1. Regla de negocio: No modificar datos esenciales de citas ya Atendidas o Canceladas
CREATE OR REPLACE FUNCTION FN_Citas_ValidarModificacion()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.Estado IN ('Atendida', 'Cancelada') THEN
        IF (NEW.fecha <> OLD.fecha OR NEW.Hora <> OLD.Hora OR 
            NEW.IdMascota <> OLD.IdMascota OR NEW.IdServicio <> OLD.IdServicio) THEN
            RAISE EXCEPTION 'No se pueden modificar los datos de una cita con estado %', OLD.Estado;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Citas_ValidarModificacion
BEFORE UPDATE ON Citas
FOR EACH ROW
EXECUTE FUNCTION FN_Citas_ValidarModificacion();


-- 2. Regla de negocio: Transiciones de estado válidas en citas médicas
CREATE OR REPLACE FUNCTION FN_Citas_ValidarTransicionEstado()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.Estado = 'Atendida' AND NEW.Estado <> 'Atendida' THEN
        RAISE EXCEPTION 'Operación inválida: Una cita atendida no puede cambiar a estado %', NEW.Estado;
    END IF;

    IF OLD.Estado = 'Cancelada' AND NEW.Estado = 'Atendida' THEN
        RAISE EXCEPTION 'Operación inválida: Una cita cancelada no puede pasar a Atendida';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Citas_ValidarTransicionEstado
BEFORE UPDATE ON Citas
FOR EACH ROW
EXECUTE FUNCTION FN_Citas_ValidarTransicionEstado();


-- 3. Regla de negocio: Inmutabilidad de la mascota y del historial en diagnósticos registrados
CREATE OR REPLACE FUNCTION FN_Diagnosticos_Inmutabilidad()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.IdMascota <> OLD.IdMascota THEN
        RAISE EXCEPTION 'Inconsistencia médica: No se permite cambiar la mascota de un diagnóstico ya registrado';
    END IF;

    IF NEW.IdHistorialClinico <> OLD.IdHistorialClinico THEN
        RAISE EXCEPTION 'Inconsistencia médica: No se permite cambiar el historial clínico de un diagnóstico';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Diagnosticos_Inmutabilidad
BEFORE UPDATE ON Diagnosticos
FOR EACH ROW
EXECUTE FUNCTION FN_Diagnosticos_Inmutabilidad();


-- 4. Automatización: Generar notificación automática al agendar una cita sin notificación asignada
CREATE OR REPLACE FUNCTION FN_Citas_AutomatizarNotificacion()
RETURNS TRIGGER AS $$
DECLARE
    v_siguiente_id INTEGER;
BEGIN
    IF NEW.IdNotificacion IS NULL THEN
        SELECT COALESCE(MAX(Id), 0) + 1 INTO v_siguiente_id FROM Notificaciones;
        
        INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
        VALUES (
            v_siguiente_id,
            'Recordatorio: Su cita médica ha sido programada con éxito.',
            CURRENT_TIMESTAMP,
            'Recordatorio',
            'Pendiente',
            'SMS'
        );
        
        NEW.IdNotificacion := v_siguiente_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Citas_AutomatizarNotificacion
BEFORE INSERT ON Citas
FOR EACH ROW
EXECUTE FUNCTION FN_Citas_AutomatizarNotificacion();


-- 5. Automatización: Actualizar fecha de modificación del historial clínico al registrar diagnóstico
CREATE OR REPLACE FUNCTION FN_Diagnosticos_ActualizarHistorial()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE HistorialesClinicos
    SET fechaModificacion = CURRENT_DATE
    WHERE Id = NEW.IdHistorialClinico;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Diagnosticos_ActualizarHistorial
AFTER INSERT ON Diagnosticos
FOR EACH ROW
EXECUTE FUNCTION FN_Diagnosticos_ActualizarHistorial();
