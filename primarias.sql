
ALTER TABLE Cursos ADD CONSTRAINT PK_Cursos PRIMARY KEY (codigo);
ALTER TABLE Certificaciones ADD CONSTRAINT PK_Certificaciones PRIMARY KEY (curso);
ALTER TABLE Habilidades ADD CONSTRAINT PK_Habilidades PRIMARY KEY (nombreCorto);
ALTER TABLE Candidatos ADD CONSTRAINT PK_Candidatos PRIMARY KEY (correo);
ALTER TABLE Candidatos_Candidatos ADD CONSTRAINT PK_Candidatos_Candidatos PRIMARY KEY (candidato1, candidato2);
ALTER TABLE HabilidadesCandidatos ADD CONSTRAINT PK_HabilidadesCandidatos PRIMARY KEY (candidato, habilidad);
ALTER TABLE CursosHabilidades ADD CONSTRAINT PK_CursosHabilidades PRIMARY KEY (curso, habilidad);
ALTER TABLE PlanesFormacion ADD CONSTRAINT PK_PlanesFormacion PRIMARY KEY (numero);
ALTER TABLE TienePrioridades ADD CONSTRAINT PK_TienePrioridades PRIMARY KEY (planFormacion, habilidad);
ALTER TABLE Avances ADD CONSTRAINT PK_Avances PRIMARY KEY (id);
ALTER TABLE Notificaciones ADD CONSTRAINT PK_Notificaciones PRIMARY KEY (id);
