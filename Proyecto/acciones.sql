-- Mascotas respecto a Titulares
ALTER TABLE Mascotas
    DROP CONSTRAINT IF EXISTS FK_Mascotas_Titulares,
    ADD CONSTRAINT FK_Mascotas_Titulares 
        FOREIGN KEY (NumeroDocumentoTitular, TipoDocumentoTitular)
        REFERENCES Titulares (NumeroDocumento, TipoDocumento)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- Servicios respecto a Mascotas
ALTER TABLE Servicios
    DROP CONSTRAINT IF EXISTS FK_Servicios_Mascotas,
    ADD CONSTRAINT FK_Servicios_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- Subtipos de Servicios respecto a Mascotas
ALTER TABLE BañosServicios
    DROP CONSTRAINT IF EXISTS FK_BañosServicios_Mascotas,
    ADD CONSTRAINT FK_BañosServicios_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE OperacionesServicios
    DROP CONSTRAINT IF EXISTS FK_OperacionesServicios_Mascotas,
    ADD CONSTRAINT FK_OperacionesServicios_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Consultas
    DROP CONSTRAINT IF EXISTS FK_Consultas_Mascotas,
    ADD CONSTRAINT FK_Consultas_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- HistorialesClinicos respecto a Mascotas
ALTER TABLE HistorialesClinicos
    DROP CONSTRAINT IF EXISTS FK_HistorialesClinicos_Mascotas,
    ADD CONSTRAINT FK_HistorialesClinicos_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- ServicioPrestado respecto a Servicios y Veterinarios
ALTER TABLE ServicioPrestado
    DROP CONSTRAINT IF EXISTS FK_ServicioPrestado_Servicios,
    ADD CONSTRAINT FK_ServicioPrestado_Servicios 
        FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ServicioPrestado
    DROP CONSTRAINT IF EXISTS FK_ServicioPrestado_Veterinarios,
    ADD CONSTRAINT FK_ServicioPrestado_Veterinarios 
        FOREIGN KEY (NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
        REFERENCES Veterinarios (NumeroDocumento, TipoDocumento)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- Citas respecto a Titulares, Mascotas, Notificaciones y Servicios
ALTER TABLE Citas
    DROP CONSTRAINT IF EXISTS FK_Citas_Titulares,
    ADD CONSTRAINT FK_Citas_Titulares 
        FOREIGN KEY (NumeroDocumentoTitular, TipoDocumentoTitular)
        REFERENCES Titulares (NumeroDocumento, TipoDocumento)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Citas
    DROP CONSTRAINT IF EXISTS FK_Citas_Mascotas,
    ADD CONSTRAINT FK_Citas_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Citas
    DROP CONSTRAINT IF EXISTS FK_Citas_Notificaciones,
    ADD CONSTRAINT FK_Citas_Notificaciones 
        FOREIGN KEY (IdNotificacion)
        REFERENCES Notificaciones (Id)
        ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Citas
    DROP CONSTRAINT IF EXISTS FK_Citas_Servicios,
    ADD CONSTRAINT FK_Citas_Servicios 
        FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- Disponibilidades respecto a Veterinarios y Citas
ALTER TABLE Disponibilidades
    DROP CONSTRAINT IF EXISTS FK_Disponibilidades_Veterinarios,
    ADD CONSTRAINT FK_Disponibilidades_Veterinarios 
        FOREIGN KEY (NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
        REFERENCES Veterinarios (NumeroDocumento, TipoDocumento)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Disponibilidades
    DROP CONSTRAINT IF EXISTS FK_Disponibilidades_Citas,
    ADD CONSTRAINT FK_Disponibilidades_Citas 
        FOREIGN KEY (IdCita)
        REFERENCES Citas (Id)
        ON UPDATE CASCADE ON DELETE CASCADE;

-- Diagnosticos respecto a Servicios, Mascotas, HistorialesClinicos y FormulacionMedica
ALTER TABLE Diagnosticos
    DROP CONSTRAINT IF EXISTS FK_Diagnosticos_Servicios,
    ADD CONSTRAINT FK_Diagnosticos_Servicios 
        FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Diagnosticos
    DROP CONSTRAINT IF EXISTS FK_Diagnosticos_Mascotas,
    ADD CONSTRAINT FK_Diagnosticos_Mascotas 
        FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Diagnosticos
    DROP CONSTRAINT IF EXISTS FK_Diagnosticos_HistorialesClinicos,
    ADD CONSTRAINT FK_Diagnosticos_HistorialesClinicos 
        FOREIGN KEY (IdHistorialClinico)
        REFERENCES HistorialesClinicos (Id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Diagnosticos
    DROP CONSTRAINT IF EXISTS FK_Diagnosticos_FormulacionMedica,
    ADD CONSTRAINT FK_Diagnosticos_FormulacionMedica 
        FOREIGN KEY (IdFormulacionMedica)
        REFERENCES FormulacionMedica (Id)
        ON UPDATE CASCADE ON DELETE SET NULL;
