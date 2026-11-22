-- Relación Mascotas -> Titulares
ALTER TABLE Mascotas
    ADD CONSTRAINT FK_Mascotas_Titulares FOREIGN KEY (NumeroDocumentoTitular, TipoDocumentoTitular)
        REFERENCES Titulares (NumeroDocumento, TipoDocumento);

-- Relación Servicios -> Mascotas
ALTER TABLE Servicios
    ADD CONSTRAINT FK_Servicios_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

-- Relación BañosServicios -> Mascotas
ALTER TABLE BañosServicios
    ADD CONSTRAINT FK_BañosServicios_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

-- Relación OperacionesServicios -> Mascotas
ALTER TABLE OperacionesServicios
    ADD CONSTRAINT FK_OperacionesServicios_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

-- Relación Consultas -> Mascotas
ALTER TABLE Consultas
    ADD CONSTRAINT FK_Consultas_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

-- Relación HistorialesClinicos -> Mascotas
ALTER TABLE HistorialesClinicos
    ADD CONSTRAINT FK_HistorialesClinicos_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

-- Relaciones ServicioPrestado -> Servicios y Veterinarios
ALTER TABLE ServicioPrestado
    ADD CONSTRAINT FK_ServicioPrestado_Servicios FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id);

ALTER TABLE ServicioPrestado
    ADD CONSTRAINT FK_ServicioPrestado_Veterinarios FOREIGN KEY (NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
        REFERENCES Veterinarios (NumeroDocumento, TipoDocumento);

-- Relaciones Citas -> Titulares, Mascotas, Notificaciones y Servicios
ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Titulares FOREIGN KEY (NumeroDocumentoTitular, TipoDocumentoTitular)
        REFERENCES Titulares (NumeroDocumento, TipoDocumento);

ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Notificaciones FOREIGN KEY (IdNotificacion)
        REFERENCES Notificaciones (Id);

ALTER TABLE Citas
    ADD CONSTRAINT FK_Citas_Servicios FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id);

-- Relaciones Disponibilidades -> Veterinarios y Citas
ALTER TABLE Disponibilidades
    ADD CONSTRAINT FK_Disponibilidades_Veterinarios FOREIGN KEY (NumeroDocumentoVeterinario, TipoDocumentoVeterinario)
        REFERENCES Veterinarios (NumeroDocumento, TipoDocumento);

ALTER TABLE Disponibilidades
    ADD CONSTRAINT FK_Disponibilidades_Citas FOREIGN KEY (IdCita)
        REFERENCES Citas (Id);

-- Relaciones Diagnosticos -> Servicios, Mascotas, HistorialesClinicos y FormulacionMedica
ALTER TABLE Diagnosticos
    ADD CONSTRAINT FK_Diagnosticos_Servicios FOREIGN KEY (IdServicio)
        REFERENCES Servicios (Id);

ALTER TABLE Diagnosticos
    ADD CONSTRAINT FK_Diagnosticos_Mascotas FOREIGN KEY (IdMascota)
        REFERENCES Mascotas (Id);

ALTER TABLE Diagnosticos
    ADD CONSTRAINT FK_Diagnosticos_HistorialesClinicos FOREIGN KEY (IdHistorialClinico)
        REFERENCES HistorialesClinicos (Id);

ALTER TABLE Diagnosticos
    ADD CONSTRAINT FK_Diagnosticos_FormulacionMedica FOREIGN KEY (IdFormulacionMedica)
        REFERENCES FormulacionMedica (Id);
