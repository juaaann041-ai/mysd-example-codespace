
-- Caso DisparadoresOK 1: FN_Citas_AutomatizarNotificacion
-- Al insertar una Cita sin especificar IdNotificacion (NULL), el disparador TR_Citas_AutomatizarNotificacion
-- debe generar un nuevo registro en Notificaciones y vincular automáticamente su Id.
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (10, '2026-11-25', '09:00:00', 1010, 'Programada', 1012345001, 'CC', 1, NULL, 1);

-- Verificación de la notificación generada automáticamente
SELECT Id, Mensaje, Estado, MedioEnvio 
FROM Notificaciones 
WHERE Id = (SELECT IdNotificacion FROM Citas WHERE Id = 10);


-- Caso DisparadoresOK 2: FN_Diagnosticos_ActualizarHistorial
-- Al insertar un Diagnóstico médico, el disparador TR_Diagnosticos_ActualizarHistorial
-- actualiza de forma automática el campo fechaModificacion del Historial Clínico correspondiente.
INSERT INTO FormulacionMedica (Id, Fecha, Descripcion)
VALUES (10, '2026-11-25', 'Suplemento vitamínico canino 1 tableta diaria con comida por 30 días');

INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
VALUES (10, 'Control preventivo satisfactorio, paciente en excelente condición corporal', '2026-11-25', 'Leve', 1, 1, 1, 10);

-- Verificación de la fecha de modificación actualizada en el historial clínico
SELECT Id, fechaGeneracion, fechaModificacion 
FROM HistorialesClinicos 
WHERE Id = 1;
