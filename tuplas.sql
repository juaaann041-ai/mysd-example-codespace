

ALTER TABLE Notificaciones
    ADD CONSTRAINT CK_Notificaciones_FechaLectura
    CHECK (fechaLectura IS NULL OR fechaLectura > fechaGeneracion);

ALTER TABLE PlanesFormacion
    ADD CONSTRAINT CK_PlanesFormacion_MesEnero
    CHECK (EXTRACT(MONTH FROM fecha) = 1);

CREATE UNIQUE INDEX uk_planesformacion_candidato_anio
ON PlanesFormacion (candidato, (EXTRACT(YEAR FROM fecha)));

