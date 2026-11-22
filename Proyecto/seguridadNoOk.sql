
-- Caso SeguridadNoOK 1: Un cliente ('rol_titular') intenta modificar directamente diagnósticos clínicos
-- Acción no autorizada: Modificar la tabla Diagnosticos o invocar servicios de SV_VETERINARIO
-- Error esperado: ERROR: permission denied for table diagnosticos
SET ROLE rol_titular;
UPDATE Diagnosticos SET Descripcion = 'Diagnóstico modificado por cliente' WHERE Id = 1;
RESET ROLE;

-- Caso SeguridadNoOK 2: Un cliente ('rol_titular') intenta acceder al esquema del Gerente
-- Acción no autorizada: Ejecutar funciones en schema SV_GERENTE
-- Error esperado: ERROR: permission denied for schema sv_gerente
SET ROLE rol_titular;
SELECT * FROM SV_GERENTE.consultar_diagnosticos_gravedad();
RESET ROLE;

-- Caso SeguridadNoOK 3: El 'rol_gerente' intenta insertar directamente una cita médica
-- Acción no autorizada: La gerencia solo tiene permisos de LECTURA (auditoría), no de operación directa.
-- Error esperado: ERROR: permission denied for table citas
SET ROLE rol_gerente;
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (99, '2026-12-01', '10:00:00', 9999, 'Programada', 1012345001, 'CC', 1, NULL, 1);
RESET ROLE;

-- Caso SeguridadNoOK 4: El 'rol_vendedor' intenta eliminar un médico veterinario del sistema
-- Acción no autorizada: Eliminar registros de la tabla Veterinarios o ejecutar SV_VETERINARIOS.eliminar
-- Error esperado: ERROR: permission denied for table veterinarios
SET ROLE rol_vendedor;
DELETE FROM Veterinarios WHERE NumeroDocumento = 1098765001;
RESET ROLE;

-- Caso SeguridadNoOK 5: El 'rol_titular' intenta acceder a los reportes de productividad veterinaria
-- Acción no autorizada: Consultar vistas reservadas a Gerencia
-- Error esperado: ERROR: permission denied for view v_productividad_veterinarios
SET ROLE rol_titular;
SELECT * FROM v_productividad_veterinarios;
RESET ROLE;

-- Caso SeguridadNoOK 6: El 'rol_veterinario' intenta modificar los precios del catálogo general
-- Acción no autorizada: Modificar tarifas en Servicios (responsabilidad del Gerente Comercial)
-- Error esperado: ERROR: permission denied for table servicios
SET ROLE rol_veterinario;
UPDATE Servicios SET PrecioBase = 1000.00 WHERE Id = 1;
RESET ROLE;

-- Caso SeguridadNoOK 7: El 'rol_vendedor' intenta acceder al esquema del Veterinario
-- Acción no autorizada: Ejecutar funciones en schema SV_VETERINARIO
-- Error esperado: ERROR: permission denied for schema sv_veterinario
SET ROLE rol_vendedor;
SELECT * FROM SV_VETERINARIO.consultar_diagnostico(1);
RESET ROLE;
