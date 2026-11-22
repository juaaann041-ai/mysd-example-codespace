
ALTER TABLE Personas 
    ADD CONSTRAINT UK_Personas_Correo UNIQUE (correo);

ALTER TABLE Personas 
    ADD CONSTRAINT UK_Personas_Telefono UNIQUE (telefono);

ALTER TABLE Titulares 
    ADD CONSTRAINT UK_Titulares_Correo UNIQUE (correo);

ALTER TABLE Titulares 
    ADD CONSTRAINT UK_Titulares_Telefono UNIQUE (telefono);

ALTER TABLE Veterinarios 
    ADD CONSTRAINT UK_Veterinarios_Correo UNIQUE (correo);

ALTER TABLE Veterinarios 
    ADD CONSTRAINT UK_Veterinarios_Telefono UNIQUE (telefono);

ALTER TABLE Servicios 
    ADD CONSTRAINT UK_Servicios_Descripcion UNIQUE (Descripcion);

ALTER TABLE BañosServicios 
    ADD CONSTRAINT UK_BañosServicios_Descripcion UNIQUE (Descripcion);

ALTER TABLE OperacionesServicios 
    ADD CONSTRAINT UK_OperacionesServicios_Descripcion UNIQUE (Descripcion);

ALTER TABLE Consultas 
    ADD CONSTRAINT UK_Consultas_Descripcion UNIQUE (Descripcion);
