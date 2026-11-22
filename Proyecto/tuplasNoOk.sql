
-- Caso TuplasNoOK 1: Disponibilidad con FechaFinal anterior a FechaDeInicio
-- Restricción probada: CK_Disponibilidades_RangoFechas
-- Error esperado: ERROR: new row for relation "disponibilidades" violates check constraint "ck_disponibilidades_rangofechas"
INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (201, '2026-11-20 10:00:00', '2026-11-20 09:00:00', TRUE, 1098765001, 'CC', 1);

-- Caso TuplasNoOK 2: Disponibilidad con FechaFinal idéntica a FechaDeInicio (duración cero)
-- Restricción probada: CK_Disponibilidades_RangoFechas
-- Error esperado: ERROR: new row for relation "disponibilidades" violates check constraint "ck_disponibilidades_rangofechas"
INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (202, '2026-11-20 10:00:00', '2026-11-20 10:00:00', TRUE, 1098765001, 'CC', 1);

-- Caso TuplasNoOK 3: Historial clínico con fechaModificacion anterior a fechaGeneracion
-- Restricción probada: CK_HistorialesClinicos_Fechas
-- Error esperado: ERROR: new row for relation "historialesclinicos" violates check constraint "ck_historialesclinicos_fechas"
INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
VALUES (203, '2026-11-15', '2026-10-01', 'Historial con fecha de modificación inconsistente', 5);

-- Caso TuplasNoOK 4: Intentar agendar dos citas para la misma mascota en idéntica fecha y hora
-- Restricción probada: UK_Citas_Mascota_Momento (IdMascota, fecha, Hora)
-- Error esperado: ERROR: duplicate key value violates unique constraint "uk_citas_mascota_momento"
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (204, '2026-11-10', '08:30:00', 1099, 'Programada', 1012345001, 'CC', 1, 1, 1);
