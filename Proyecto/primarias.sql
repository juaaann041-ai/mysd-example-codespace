ALTER TABLE Personas 
    ADD CONSTRAINT PK_Personas PRIMARY KEY (NumeroDocumento, TipoDocumento);

ALTER TABLE Titulares 
    ADD CONSTRAINT PK_Titulares PRIMARY KEY (NumeroDocumento, TipoDocumento);

ALTER TABLE Veterinarios 
    ADD CONSTRAINT PK_Veterinarios PRIMARY KEY (NumeroDocumento, TipoDocumento);

ALTER TABLE Mascotas 
    ADD CONSTRAINT PK_Mascotas PRIMARY KEY (Id);

ALTER TABLE Notificaciones 
    ADD CONSTRAINT PK_Notificaciones PRIMARY KEY (Id);

ALTER TABLE Servicios 
    ADD CONSTRAINT PK_Servicios PRIMARY KEY (Id);

ALTER TABLE BañosServicios 
    ADD CONSTRAINT PK_BañosServicios PRIMARY KEY (Id);

ALTER TABLE OperacionesServicios 
    ADD CONSTRAINT PK_OperacionesServicios PRIMARY KEY (Id);

ALTER TABLE Consultas 
    ADD CONSTRAINT PK_Consultas PRIMARY KEY (Id);

ALTER TABLE HistorialesClinicos 
    ADD CONSTRAINT PK_HistorialesClinicos PRIMARY KEY (Id);

ALTER TABLE FormulacionMedica 
    ADD CONSTRAINT PK_FormulacionMedica PRIMARY KEY (Id);

ALTER TABLE ServicioPrestado 
    ADD CONSTRAINT PK_ServicioPrestado PRIMARY KEY (IdServicio, NumeroDocumentoVeterinario, TipoDocumentoVeterinario);

ALTER TABLE Citas 
    ADD CONSTRAINT PK_Citas PRIMARY KEY (Id);

ALTER TABLE Disponibilidades 
    ADD CONSTRAINT PK_Disponibilidades PRIMARY KEY (Id);

ALTER TABLE Diagnosticos 
    ADD CONSTRAINT PK_Diagnosticos PRIMARY KEY (Id);
