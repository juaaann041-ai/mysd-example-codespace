-- Caso 1: ON UPDATE CASCADE en Titulares -> Mascotas y Citas
-- Modificar la clave primaria de un Titular propaga automáticamente el cambio a sus Mascotas y Citas
UPDATE Titulares
SET NumeroDocumento = 1012345999
WHERE NumeroDocumento = 1012345004 AND TipoDocumento = 'TI';

-- Verificación de cascada en Mascotas
SELECT Id, nombre, NumeroDocumentoTitular, TipoDocumentoTitular 
FROM Mascotas 
WHERE NumeroDocumentoTitular = 1012345999;

-- Revertir para mantener consistencia de datos base
UPDATE Titulares
SET NumeroDocumento = 1012345004
WHERE NumeroDocumento = 1012345999 AND TipoDocumento = 'TI';


-- Caso 2: ON DELETE SET NULL en Notificaciones -> Citas
-- Al eliminar una Notificación, la cita asociada conserva su registro pero con IdNotificacion en NULL
INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
VALUES (999, 'Notificación temporal para prueba de eliminación', CURRENT_TIMESTAMP, 'Recordatorio', 'Pendiente', 'SMS');

INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (999, '2026-12-15', '16:00:00', 2001, 'Programada', 1012345001, 'CC', 1, 999, 1);

-- Eliminación de la notificación
DELETE FROM Notificaciones WHERE Id = 999;

-- Verificación: la cita 999 ahora tiene IdNotificacion = NULL
SELECT Id, fecha, Hora, IdNotificacion FROM Citas WHERE Id = 999;

-- Limpieza
DELETE FROM Citas WHERE Id = 999;


-- Caso 3: ON DELETE RESTRICT (comportamiento protegido)
-- Intentar borrar un Titular con mascotas activas es bloqueado por la base de datos
DELETE FROM Titulares WHERE NumeroDocumento = 1012345001;
-- Error esperado: ERROR: update or delete on table "titulares" violates foreign key constraint "fk_mascotas_titulares"
