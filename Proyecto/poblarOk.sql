-- Inserción de Personas
INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345001, 'CC', 'carlos.gomez@email.com', 3001112233, 'Carlos Gomez');

INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345002, 'CC', 'laura.martinez@email.com', 3002223344, 'Laura Martinez');

INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345003, 'CE', 'andres.morales@email.com', 3003334455, 'Andres Morales');

INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345004, 'TI', 'sofia.castro@email.com', 3004445566, 'Sofia Castro');

-- Inserción de Titulares
INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345001, 'CC', 'carlos.titular@email.com', 3111112233, 'Carlos Gomez');

INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345002, 'CC', 'laura.titular@email.com', 3112223344, 'Laura Martinez');

INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345003, 'CE', 'andres.titular@email.com', 3113334455, 'Andres Morales');

INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
VALUES (1012345004, 'TI', 'sofia.titular@email.com', 3114445566, 'Sofia Castro');

-- Inserción de Veterinarios
INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
VALUES (1098765001, 'CC', 'juan.perez@veterinaria.com', 3201110001, 'Dr. Juan Camilo Perez', 'Medicina general');

INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
VALUES (1098765002, 'CC', 'maria.lopez@veterinaria.com', 3202220002, 'Dra. Maria Lopez', 'Cirugía');

INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
VALUES (1098765003, 'CE', 'santiago.rojas@veterinaria.com', 3203330003, 'Dr. Santiago Rojas', 'Dermatología');

INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
VALUES (1098765004, 'CC', 'ana.gutierrez@veterinaria.com', 3204440004, 'Dra. Ana Gutierrez', 'Odontología');

-- Inserción de Mascotas
INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (1, 'Max', 'Labrador', 'Perro', 'Macho', 1012345001, 'CC');

INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (2, 'Luna', 'Siamés', 'Gato', 'Hembra', 1012345002, 'CC');

INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (3, 'Rocky', 'Bulldog', 'Perro', 'Macho', 1012345003, 'CE');

INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (4, 'Mia', 'Persa', 'Gato', 'Hembra', 1012345001, 'CC');

INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
VALUES (5, 'Toby', 'Mestizo', 'Perro', 'Macho', 1012345004, 'TI');

-- Inserción de Notificaciones
INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
VALUES (1, 'Recordatorio de cita de control médico para su mascota Max', '2026-11-10 08:00:00', 'Recordatorio', 'Enviada', 'WhatsApp');

INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
VALUES (2, 'Confirmación de procedimiento de esterilización para Luna', '2026-11-11 09:30:00', 'Confirmacion', 'Entregada', 'Correo');

INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
VALUES (3, 'Aviso de reprogramación de consulta dermatológica para Rocky', '2026-11-12 14:00:00', 'Reprogramacion', 'Pendiente', 'SMS');

-- Inserción de Servicios generales
INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (1, 'Valoración médica general preventiva para canino', 50000.00, 30, 1);

INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (2, 'Procedimiento quirúrgico de esterilización felina', 180000.00, 60, 2);

INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (3, 'Sesión de baño medicado y corte higiénico canino', 45000.00, 45, 3);

INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
VALUES (4, 'Limpieza dental con ultrasonido para felino', 120000.00, 40, 4);

-- Inserción de Baños y Estética
INSERT INTO BañosServicios (Id, Descripcion, PrecioBase, Duracion, IdMascota, TipoPelo, IncluyeCorte, IncluyeUñas, Tamaño)
VALUES (101, 'Baño completo canino grande con corte y uñas', 65000.00, 60, 1, 'Largo', TRUE, TRUE, 'Grande');

INSERT INTO BañosServicios (Id, Descripcion, PrecioBase, Duracion, IdMascota, TipoPelo, IncluyeCorte, IncluyeUñas, Tamaño)
VALUES (102, 'Baño básico felino mediano sin corte de pelo', 40000.00, 35, 2, 'Corto', FALSE, TRUE, 'Mediano');

-- Inserción de Operaciones y Cirugías
INSERT INTO OperacionesServicios (Id, Descripcion, PrecioBase, Duracion, IdMascota, TipoOperacion, RequiereAnestesia, NivelComplejidad)
VALUES (201, 'Cirugía de esterilización ovárica felina programada', 220000.00, 90, 2, 'Esterilización', TRUE, 'Media');

INSERT INTO OperacionesServicios (Id, Descripcion, PrecioBase, Duracion, IdMascota, TipoOperacion, RequiereAnestesia, NivelComplejidad)
VALUES (202, 'Profilaxis y extracción de pieza dental canina', 150000.00, 50, 3, 'Dental', TRUE, 'Baja');

-- Inserción de Consultas Médicas
INSERT INTO Consultas (Id, Descripcion, PrecioBase, Duracion, IdMascota, Especialidad, TipoConsulta, RequiereControl)
VALUES (301, 'Consulta inicial por chequeo de rutina para cachorro', 55000.00, 30, 1, 'Medicina general', 'Primera vez', TRUE);

INSERT INTO Consultas (Id, Descripcion, PrecioBase, Duracion, IdMascota, Especialidad, TipoConsulta, RequiereControl)
VALUES (302, 'Consulta dermatológica por alergia y dermatitis en Bulldog', 70000.00, 40, 3, 'Dermatología', 'Control', TRUE);

-- Inserción de Historiales Clínicos
INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
VALUES (1, '2026-01-15', '2026-11-01', 'Historial médico del canino Max: vacunas completas, sin antecedentes alérgicos', 1);

INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
VALUES (2, '2026-03-20', '2026-11-02', 'Historial médico de la felina Luna: control de parásitos y peso adecuado', 2);

INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
VALUES (3, '2026-05-10', '2026-11-03', 'Historial médico de Rocky: cuadro recurrente de dermatitis atópica', 3);

-- Inserción de Formulación Médica
INSERT INTO FormulacionMedica (Id, Fecha, Descripcion)
VALUES (1, '2026-11-10', 'Amoxicilina suspensión 250mg cada 12 horas por 7 días');

INSERT INTO FormulacionMedica (Id, Fecha, Descripcion)
VALUES (2, '2026-11-11', 'Meloxicam gotas 0.5mg cada 24 horas por 3 días postquirúrgico');

INSERT INTO FormulacionMedica (Id, Fecha, Descripcion)
VALUES (3, '2026-11-12', 'Champú con clorhexidina 3% dos veces por semana durante 1 mes');

-- Inserción de ServicioPrestado
INSERT INTO ServicioPrestado (IdServicio, NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
VALUES (1, 1098765001, 'CC');

INSERT INTO ServicioPrestado (IdServicio, NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
VALUES (2, 1098765002, 'CC');

INSERT INTO ServicioPrestado (IdServicio, NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
VALUES (3, 1098765001, 'CC');

INSERT INTO ServicioPrestado (IdServicio, NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
VALUES (4, 1098765004, 'CC');

-- Inserción de Citas
INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (1, '2026-11-10', '08:30:00', 1001, 'Programada', 1012345001, 'CC', 1, 1, 1);

INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (2, '2026-11-11', '10:00:00', 1002, 'Confirmada', 1012345002, 'CC', 2, 2, 2);

INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (3, '2026-11-12', '14:30:00', 1003, 'Programada', 1012345003, 'CE', 3, NULL, 3);

INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
VALUES (4, '2026-11-13', '11:00:00', 1004, 'Atendida', 1012345001, 'CC', 4, 3, 4);

-- Inserción de Disponibilidades
INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (1, '2026-11-10 08:00:00', '2026-11-10 09:00:00', TRUE, 1098765001, 'CC', 1);

INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (2, '2026-11-11 09:30:00', '2026-11-11 11:00:00', FALSE, 1098765002, 'CC', 2);

INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (3, '2026-11-12 14:00:00', '2026-11-12 15:30:00', TRUE, 1098765001, 'CC', 3);

INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
VALUES (4, '2026-11-13 10:30:00', '2026-11-13 12:00:00', FALSE, 1098765004, 'CC', 4);

-- Inserción de Diagnósticos
INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
VALUES (1, 'Infección respiratoria leve en vías aéreas superiores', '2026-11-10', 'Leve', 1, 1, 1, 1);

INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
VALUES (2, 'Recuperación favorable postquirúrgica de esterilización', '2026-11-11', 'Moderada', 2, 2, 2, 2);

INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
VALUES (3, 'Brote alérgico dérmico en zona abdominal y patas', '2026-11-12', 'Moderada', 3, 3, 3, 3);

INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
VALUES (4, 'Control general sin patologías detectadas, estado de salud óptimo', '2026-11-13', 'Leve', 4, 4, 1, NULL);
