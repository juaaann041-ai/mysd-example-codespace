-- Caso TuplasOK 1: Disponibilidad válida con FechaFinal estrictamente posterior a FechaDeInicio
INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (101, '2026-11-20 08:00:00', '2026-11-20 09:30:00', TRUE, 1098765001, 'CC', 1);

-- Caso TuplasOK 2: Historial clínico con fechaModificacion igual o posterior a fechaGeneracion
INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
VALUES (101, '2026-11-01', '2026-11-15', 'Historial clínico actualizado con evolución médica favorable', 5);

-- Caso TuplasOK 3: Citas en momentos distintos para la misma mascota
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (101, '2026-11-20', '08:00:00', 1051, 'Programada', 1012345001, 'CC', 1, 1, 1);

INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (102, '2026-11-20', '14:00:00', 1052, 'Programada', 1012345001, 'CC', 1, 1, 1);
