

-- 2. TABLAS


CREATE TABLE Cursos (
    codigo VARCHAR(20) NOT NULL,
    nombre TNombre NOT NULL,
    detalle VARCHAR(100),
    metodologia VARCHAR(100) NOT NULL,
    cerrado BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE Certificaciones (
    vigencia DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    curso VARCHAR(20) NOT NULL
);

CREATE TABLE Habilidades (
    nombreCorto VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Candidatos (
    correo TCorreo NOT NULL,
    nombres VARCHAR(150) NOT NULL,
    habilidad VARCHAR(50) NOT NULL
);

CREATE TABLE Candidatos_Candidatos (
    candidato1 VARCHAR(150) NOT NULL,
    candidato2 VARCHAR(150) NOT NULL
);

CREATE TABLE HabilidadesCandidatos (
    candidato VARCHAR(150) NOT NULL,
    habilidad VARCHAR(50) NOT NULL
);

CREATE TABLE CursosHabilidades (
    curso VARCHAR(20) NOT NULL,
    habilidad VARCHAR(50) NOT NULL
);

CREATE TABLE PlanesFormacion (
    numero SERIAL NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    estado TEstado NOT NULL DEFAULT 'En diseño',
    evaluador TCorreo NOT NULL,
    fechaFin DATE,
    candidato VARCHAR(150) NOT NULL
);

CREATE TABLE TienePrioridades (
    planFormacion INTEGER NOT NULL,
    habilidad VARCHAR(50) NOT NULL,
    prioridad TPrioridad NOT NULL
);

CREATE TABLE Avances (
    id SERIAL NOT NULL,
    fecha DATE NOT NULL,
    tipo TAvance NOT NULL,
    planFormacion INTEGER NOT NULL,
    curso VARCHAR(20) NOT NULL
);

CREATE TABLE Notificaciones (
    id SERIAL NOT NULL,
    detalleNotificacion VARCHAR(100) NOT NULL,
    tiempoLectura INTEGER NOT NULL,
    fechaGeneracion TIMESTAMP NOT NULL DEFAULT NOW(),
    fechaLectura TIMESTAMP,
    correoDestino TCorreo NOT NULL,
    asunto VARCHAR(200) NOT NULL,
    mensaje VARCHAR(1000) NOT NULL,
    accion TAccion NOT NULL,
    evento TAvance NOT NULL,
    canal TCanal NOT NULL,
    avance INTEGER NOT NULL
);

