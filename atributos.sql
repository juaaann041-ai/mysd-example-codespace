
ALTER TABLE Certificaciones
    ADD CONSTRAINT CK_Certificaciones_Valor CHECK (valor >= 0);

ALTER TABLE Certificaciones
    ADD CONSTRAINT CK_Certificaciones_Vigencia CHECK (vigencia IS NOT NULL);

ALTER TABLE Notificaciones
    ADD CONSTRAINT CK_Notificaciones_TiempoLectura CHECK (tiempoLectura >= 0);