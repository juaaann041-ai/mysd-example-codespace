

-- En Disponibilidades: la fecha y hora final debe ser posterior al inicio
ALTER TABLE Disponibilidades
    ADD CONSTRAINT CK_Disponibilidades_RangoFechas 
    CHECK (FechaFinal > FechaDeInicio);

-- En HistorialesClinicos: la fecha de modificación debe ser mayor o igual a la de apertura
ALTER TABLE HistorialesClinicos
    ADD CONSTRAINT CK_HistorialesClinicos_Fechas 
    CHECK (fechaModificacion >= fechaGeneracion);

-- En Citas: una mascota no puede tener más de una cita agendada en la misma fecha y hora
ALTER TABLE Citas
    ADD CONSTRAINT UK_Citas_Mascota_Momento 
    UNIQUE (IdMascota, fecha, Hora);
