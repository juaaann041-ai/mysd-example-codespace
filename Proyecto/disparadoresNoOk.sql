

-- Caso DisparadoresNoOK 1: Intentar modificar fecha, hora o servicio de una cita ya 'Atendida'
-- Regla probada: FN_Citas_ValidarModificacion
-- Error esperado: ERROR: No se pueden modificar los datos de una cita con estado Atendida
UPDATE Citas
SET Hora = '16:00:00'
WHERE Id = 4;

-- Caso DisparadoresNoOK 2: Intentar modificar datos esenciales de una cita con estado 'Cancelada'
-- Regla probada: FN_Citas_ValidarModificacion
-- Error esperado: ERROR: No se pueden modificar los datos de una cita con estado Cancelada
UPDATE Citas
SET fecha = '2026-11-30'
WHERE Estado = 'Cancelada';

-- Caso DisparadoresNoOK 3: Intentar revertir el estado de una cita de 'Atendida' a 'Programada'
-- Regla probada: FN_Citas_ValidarTransicionEstado
-- Error esperado: ERROR: Operación inválida: Una cita atendida no puede cambiar a estado Programada
UPDATE Citas
SET Estado = 'Programada'
WHERE Id = 4;

-- Caso DisparadoresNoOK 4: Intentar cambiar el estado de una cita 'Cancelada' directamente a 'Atendida'
-- Regla probada: FN_Citas_ValidarTransicionEstado
-- Error esperado: ERROR: Operación inválida: Una cita cancelada no puede pasar a Atendida
UPDATE Citas
SET Estado = 'Atendida'
WHERE Estado = 'Cancelada';

-- Caso DisparadoresNoOK 5: Intentar reasignar la mascota asociada a un diagnóstico médico existente
-- Regla probada: FN_Diagnosticos_Inmutabilidad
-- Error esperado: ERROR: Inconsistencia médica: No se permite cambiar la mascota de un diagnóstico ya registrado
UPDATE Diagnosticos
SET IdMascota = 2
WHERE Id = 1;

-- Caso DisparadoresNoOK 6: Intentar modificar el historial clínico asociado a un diagnóstico
-- Regla probada: FN_Diagnosticos_Inmutabilidad
-- Error esperado: ERROR: Inconsistencia médica: No se permite cambiar el historial clínico de un diagnóstico
UPDATE Diagnosticos
SET IdHistorialClinico = 2
WHERE Id = 1;
