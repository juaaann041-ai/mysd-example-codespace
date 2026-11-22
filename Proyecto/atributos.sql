-- Restricción para la duración de servicios generales (estrictamente positiva)
ALTER TABLE Servicios
    ADD CONSTRAINT CK_Servicios_Duracion CHECK (Duracion > 0);

-- Restricción para la duración de servicios de baño y estética
ALTER TABLE BañosServicios
    ADD CONSTRAINT CK_BañosServicios_Duracion CHECK (Duracion > 0);

-- Restricción para la duración de intervenciones quirúrgicas
ALTER TABLE OperacionesServicios
    ADD CONSTRAINT CK_OperacionesServicios_Duracion CHECK (Duracion > 0);

-- Restricción para la duración de consultas médicas
ALTER TABLE Consultas
    ADD CONSTRAINT CK_Consultas_Duracion CHECK (Duracion > 0);

-- Restricción para el consecutivo de la cita médica del día
ALTER TABLE Citas
    ADD CONSTRAINT CK_Citas_NumeroCita CHECK (NumeroCita > 0);
