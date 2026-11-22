

CREATE TABLE Personas (
    NumeroDocumento TNumeroDocumento NOT NULL,
    TipoDocumento TipoDocumento NOT NULL,
    correo TCorreo NOT NULL,
    telefono TContacto NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Titulares (
    NumeroDocumento TNumeroDocumento NOT NULL,
    TipoDocumento TipoDocumento NOT NULL,
    correo TCorreo NOT NULL,
    telefono TContacto NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Veterinarios (
    NumeroDocumento TNumeroDocumento NOT NULL,
    TipoDocumento TipoDocumento NOT NULL,
    correo TCorreo NOT NULL,
    telefono TContacto NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    Especialidad TEspecialidad NOT NULL
);

CREATE TABLE Mascotas (
    Id INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    raza TRaza NOT NULL,
    especie TEspecie NOT NULL,
    genero TGenero NOT NULL,
    NumeroDocumentoTitular TNumeroDocumento NOT NULL,
    TipoDocumentoTitular TipoDocumento NOT NULL
);

CREATE TABLE Notificaciones (
    Id INTEGER NOT NULL,
    Mensaje VARCHAR(250) NOT NULL,
    FechaDeEnvio TIMESTAMP NOT NULL,
    TipoNotificacion TNotificacion NOT NULL,
    Estado TEstadoNotificacion NOT NULL,
    MedioEnvio TMedioEnvio NOT NULL
);

CREATE TABLE Servicios (
    Id INTEGER NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    PrecioBase TPrecio NOT NULL,
    Duracion INTEGER NOT NULL,
    IdMascota INTEGER NOT NULL
);

CREATE TABLE BañosServicios (
    Id INTEGER NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    PrecioBase TPrecio NOT NULL,
    Duracion INTEGER NOT NULL,
    IdMascota INTEGER NOT NULL,
    TipoPelo TPelo NOT NULL,
    IncluyeCorte BOOLEAN NOT NULL,
    IncluyeUñas BOOLEAN NOT NULL,
    Tamaño TTamaño NOT NULL
);

CREATE TABLE OperacionesServicios (
    Id INTEGER NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    PrecioBase TPrecio NOT NULL,
    Duracion INTEGER NOT NULL,
    IdMascota INTEGER NOT NULL,
    TipoOperacion TOperacion NOT NULL,
    RequiereAnestesia BOOLEAN NOT NULL,
    NivelComplejidad TNivelComplejidad NOT NULL
);

CREATE TABLE Consultas (
    Id INTEGER NOT NULL,
    Descripcion VARCHAR(200) NOT NULL,
    PrecioBase TPrecio NOT NULL,
    Duracion INTEGER NOT NULL,
    IdMascota INTEGER NOT NULL,
    Especialidad TEspecialidad NOT NULL,
    TipoConsulta TipoConsulta NOT NULL,
    RequiereControl BOOLEAN NOT NULL
);

CREATE TABLE HistorialesClinicos (
    Id INTEGER NOT NULL,
    fechaGeneracion DATE NOT NULL,
    fechaModificacion DATE NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    IdMascota INTEGER NOT NULL
);

CREATE TABLE FormulacionMedica (
    Id INTEGER NOT NULL,
    Fecha DATE NOT NULL,
    Descripcion VARCHAR(250) NOT NULL
);

CREATE TABLE ServicioPrestado (
    IdServicio INTEGER NOT NULL,
    NumeroDocumentoVeterinario TNumeroDocumento NOT NULL,
    TipoDocumentoVeterinario TipoDocumento NOT NULL
);

CREATE TABLE Citas (
    Id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    NumeroCita INTEGER NOT NULL,
    Estado TEstado NOT NULL,
    NumeroDocumentoTitular TNumeroDocumento NOT NULL,
    TipoDocumentoTitular TipoDocumento NOT NULL,
    IdMascota INTEGER NOT NULL,
    IdNotificacion INTEGER NULL, -- Atributo marcado con (!) permite NULL
    IdServicio INTEGER NOT NULL
);

CREATE TABLE Disponibilidades (
    Id INTEGER NOT NULL,
    FechaDeInicio TIMESTAMP NOT NULL,
    FechaFinal TIMESTAMP NOT NULL,
    Disponibilidad BOOLEAN NOT NULL,
    NumeroDocumentoVeterinario TNumeroDocumento NOT NULL,
    TipoDocumentoVeterinario TipoDocumento NOT NULL,
    IdCita INTEGER NOT NULL
);

CREATE TABLE Diagnosticos (
    Id INTEGER NOT NULL,
    Descripcion VARCHAR(250) NOT NULL,
    FechaGenerada DATE NOT NULL,
    Gravedad TGravedad NOT NULL,
    IdServicio INTEGER NOT NULL,
    IdMascota INTEGER NOT NULL,
    IdHistorialClinico INTEGER NOT NULL,
    IdFormulacionMedica INTEGER NULL -- Atributo marcado con (!) permite NULL
);
