
-- Caso 1: Violación de Clave Primaria en Mascotas (PK_Mascotas)
-- Restricción probada: PK_Mascotas (Id)
-- Error esperado: ERROR: duplicate key value violates unique constraint "pk_mascotas"
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (1, 'Boby', 'Poodle', 'Perro', 'Macho', 1012345001, 'CC');

-- Caso 2: Violación de Clave Primaria compuesta en Titulares (PK_Titulares)
-- Restricción probada: PK_Titulares (NumeroDocumento, TipoDocumento)
-- Error esperado: ERROR: duplicate key value violates unique constraint "pk_titulares"
INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345001, 'CC', 'otro.correo@email.com', 3199998877, 'Carlos Gomez Duplicado');

-- Caso 3: Violación de Integridad Referencial en Mascotas (FK_Mascotas_Titulares)
-- Restricción probada: FK_Mascotas_Titulares
-- Error esperado: ERROR: insert or update on table "mascotas" violates foreign key constraint "fk_mascotas_titulares"
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (99, 'Fantasma', 'Mestizo', 'Perro', 'Macho', 9999999999, 'CC');

-- Caso 4: Violación de Integridad Referencial en Servicios (FK_Servicios_Mascotas)
-- Restricción probada: FK_Servicios_Mascotas
-- Error esperado: ERROR: insert or update on table "servicios" violates foreign key constraint "fk_servicios_mascotas"
INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (99, 'Servicio para mascota inexistente', 30000.00, 20, 9999);

-- Caso 5: Violación de Restricción de Unicidad en Correo de Titular (UK_Titulares_Correo)
-- Restricción probada: UK_Titulares_Correo
-- Error esperado: ERROR: duplicate key value violates unique constraint "uk_titulares_correo"
INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1055555555, 'CC', 'carlos.titular@email.com', 3155554433, 'Nuevo Titular Correo Repetido');

-- Caso 6: Violación de Restricción de Unicidad en Teléfono de Veterinario (UK_Veterinarios_Telefono)
-- Restricción probada: UK_Veterinarios_Telefono
-- Error esperado: ERROR: duplicate key value violates unique constraint "uk_veterinarios_telefono"
INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
VALUES (1077777777, 'CC', 'nuevo.vet@veterinaria.com', 3201110001, 'Dr. Repetido Telefono', 'Cirugía');

-- Caso 7: Violación de Restricción de Unicidad en Descripción de Servicios (UK_Servicios_Descripcion)
-- Restricción probada: UK_Servicios_Descripcion
-- Error esperado: ERROR: duplicate key value violates unique constraint "uk_servicios_descripcion"
INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (88, 'Valoración médica general preventiva para canino', 45000.00, 30, 1);

-- Caso 8: Violación de Not-Null en atributo obligatorio 'nombre' de Mascotas
-- Restricción probada: NOT NULL en columna 'nombre' de Mascotas
-- Error esperado: ERROR: null value in column "nombre" of relation "mascotas" violates not-null constraint
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (77, NULL, 'Labrador', 'Perro', 'Macho', 1012345001, 'CC');

-- Caso 9: Violación de Not-Null en clave foránea obligatoria 'IdServicio' de Citas
-- Restricción probada: NOT NULL en columna 'idservicio' de Citas
-- Error esperado: ERROR: null value in column "idservicio" of relation "citas" violates not-null constraint
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (66, '2026-11-20', '15:00:00', 1099, 'Programada', 1012345001, 'CC', 1, NULL, NULL);

-- Caso 10: Violación de Check en Dominio TEspecie
-- Restricción probada: CHECK de dominio TEspecie (VALUE IN ('Perro', 'Gato', 'Otro'))
-- Error esperado: ERROR: value for domain tespecie violates check constraint "tespecie_check"
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (55, 'Reptil', 'Otra', 'Iguana', 'Macho', 1012345001, 'CC');

-- Caso 11: Violación de Check en Dominio TGenero
-- Restricción probada: CHECK de dominio TGenero (VALUE IN ('Macho', 'Hembra'))
-- Error esperado: ERROR: value for domain tgenero violates check constraint "tgenero_check"
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (56, 'MascotaX', 'Mestizo', 'Perro', 'Desconocido', 1012345001, 'CC');

-- Caso 12: Violación de Check en Dominio TEstado
-- Restricción probada: CHECK de dominio TEstado (VALUE IN ('Programada', 'Confirmada', 'Cancelada', 'Atendida', 'No asistió'))
-- Error esperado: ERROR: value for domain testado violates check constraint "testado_check"
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (57, '2026-11-20', '09:00:00', 1050, 'En Espera', 1012345001, 'CC', 1, NULL, 1);

-- Caso 13: Violación de Check en Dominio TPrecio (precio negativo)
-- Restricción probada: CHECK (VALUE >= 0) del dominio TPrecio
-- Error esperado: ERROR: value for domain tprecio violates check constraint "tprecio_check"
INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (44, 'Servicio con precio negativo inválido', -25000.00, 30, 1);

-- Caso 14: Violación de Check en Dominio TNumeroDocumento (documento no positivo)
-- Restricción probada: CHECK (VALUE > 0) del dominio TNumeroDocumento
-- Error esperado: ERROR: value for domain tnumerodocumento violates check constraint "tnumerodocumento_check"
INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (-100, 'CC', 'documento.invalido@email.com', 3110001122, 'Persona Documento Negativo');
