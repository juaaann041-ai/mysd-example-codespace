
ALTER TABLE Certificaciones
    ADD CONSTRAINT FK_Certificaciones_Cursos
    FOREIGN KEY (curso) REFERENCES Cursos(codigo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Candidatos
    ADD CONSTRAINT FK_Candidatos_Habilidades
    FOREIGN KEY (habilidad) REFERENCES Habilidades(nombreCorto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Candidatos_Candidatos
    ADD CONSTRAINT FK_CandidatosCandidatos_Candidato1
    FOREIGN KEY (candidato1) REFERENCES Candidatos(correo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Candidatos_Candidatos
    ADD CONSTRAINT FK_CandidatosCandidatos_Candidato2
    FOREIGN KEY (candidato2) REFERENCES Candidatos(correo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE HabilidadesCandidatos
    ADD CONSTRAINT FK_HabilidadesCandidatos_Candidato
    FOREIGN KEY (candidato) REFERENCES Candidatos(correo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE HabilidadesCandidatos
    ADD CONSTRAINT FK_HabilidadesCandidatos_Habilidad
    FOREIGN KEY (habilidad) REFERENCES Habilidades(nombreCorto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE CursosHabilidades
    ADD CONSTRAINT FK_CursosHabilidades_Curso
    FOREIGN KEY (curso) REFERENCES Cursos(codigo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE CursosHabilidades
    ADD CONSTRAINT FK_CursosHabilidades_Habilidad
    FOREIGN KEY (habilidad) REFERENCES Habilidades(nombreCorto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PlanesFormacion
    ADD CONSTRAINT FK_PlanesFormacion_Candidato
    FOREIGN KEY (candidato) REFERENCES Candidatos(correo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE PlanesFormacion
    ADD CONSTRAINT FK_PlanesFormacion_Evaluador
    FOREIGN KEY (evaluador) REFERENCES Candidatos(correo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TienePrioridades
    ADD CONSTRAINT FK_TienePrioridades_PlanFormacion
    FOREIGN KEY (planFormacion) REFERENCES PlanesFormacion(numero) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE TienePrioridades
    ADD CONSTRAINT FK_TienePrioridades_Habilidad
    FOREIGN KEY (habilidad) REFERENCES Habilidades(nombreCorto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Avances
    ADD CONSTRAINT FK_Avances_PlanesFormacion
    FOREIGN KEY (planFormacion) REFERENCES PlanesFormacion(numero) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Avances
    ADD CONSTRAINT FK_Avances_Cursos
    FOREIGN KEY (curso) REFERENCES Cursos(codigo) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Notificaciones
    ADD CONSTRAINT FK_Notificaciones_Avance
    FOREIGN KEY (avance) REFERENCES Avances(id) ON UPDATE CASCADE ON DELETE RESTRICT;
