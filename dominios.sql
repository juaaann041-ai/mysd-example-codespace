

CREATE DOMAIN TEstado AS VARCHAR(20)
CHECK (VALUE IN ('En diseño', 'En ejecución', 'Aprobado', 'No aprobado'));

CREATE DOMAIN TCorreo AS VARCHAR(100)
CHECK (VALUE LIKE '%@gmail.com');

CREATE DOMAIN TAccion AS CHAR(1)
CHECK (VALUE IN ('C', 'A', 'E'));

CREATE DOMAIN TAvance AS VARCHAR(30)
CHECK (VALUE IN (
    'Inscripcion', 'Finalizacion con exito',
    'Finalizacion con fracaso', 'Abandono'
));

CREATE DOMAIN TNombre AS VARCHAR(100)
CHECK (VALUE LIKE '% %');

CREATE DOMAIN TPrioridad AS VARCHAR(10)
CHECK (VALUE IN ('Alta', 'Media', 'Minima'));

CREATE DOMAIN TCanal AS VARCHAR(10)
CHECK (VALUE IN ('email', 'push', 'whatsapp'));

