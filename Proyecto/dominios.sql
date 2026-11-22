-- Dominio para correos electrónicos
CREATE DOMAIN TCorreo AS VARCHAR(100);

-- Dominio para las especialidades médico-veterinarias autorizadas
CREATE DOMAIN TEspecialidad AS VARCHAR(30)
CHECK (VALUE IN (
    'Medicina general',
    'Dermatología',
    'Cardiología',
    'Oftalmología',
    'Ortopedia',
    'Neurología',
    'Cirugía',
    'Odontología'
));

-- Dominio para tipos de procedimientos quirúrgicos
CREATE DOMAIN TOperacion AS VARCHAR(20)
CHECK (VALUE IN (
    'Esterilización',
    'Ortopédica',
    'Dental',
    'General',
    'Oftalmológica'
));

-- Dominio para niveles de complejidad quirúrgica y clínica
CREATE DOMAIN TNivelComplejidad AS VARCHAR(15)
CHECK (VALUE IN (
    'Baja',
    'Media',
    'Alta'
));

-- Dominio para clasificación del pelaje en servicios de estética
CREATE DOMAIN TPelo AS VARCHAR(20)
CHECK (VALUE IN (
    'Largo',
    'Mediano',
    'Corto'
));

-- Dominio para tamaños de pacientes en servicios de baño y estética
CREATE DOMAIN TTamaño AS VARCHAR(20)
CHECK (VALUE IN (
    'Grande',
    'Mediano',
    'Pequeño'
));

-- Dominio para niveles de gravedad diagnóstica
CREATE DOMAIN TGravedad AS VARCHAR(15)
CHECK (VALUE IN (
    'Leve',
    'Moderada',
    'Grave',
    'Crítica'
));

-- Dominio para el tipo de notificación emitida
CREATE DOMAIN TNotificacion AS VARCHAR(20)
CHECK (VALUE IN (
    'Recordatorio',
    'Confirmacion',
    'Cancelacion',
    'Reprogramacion'
));

-- Dominio para estados del ciclo de envío de notificaciones
CREATE DOMAIN TEstadoNotificacion AS VARCHAR(15)
CHECK (VALUE IN (
    'Pendiente',
    'Enviada',
    'Entregada',
    'Fallida'
));

-- Dominio para canales y medios de transmisión de mensajes
CREATE DOMAIN TMedioEnvio AS VARCHAR(15)
CHECK (VALUE IN (
    'Correo',
    'SMS',
    'WhatsApp'
));

-- Dominio para modalidades de consulta médica
CREATE DOMAIN TipoConsulta AS VARCHAR(20)
CHECK (VALUE IN (
    'Primera vez',
    'Control',
    'Urgencia',
    'Preventiva'
));

CREATE DOMAIN TConsulta AS VARCHAR(20)
CHECK (VALUE IN (
    'Primera vez',
    'Control',
    'Urgencia',
    'Preventiva'
));

-- Dominio para el estado del ciclo de vida de una cita médica
CREATE DOMAIN TEstado AS VARCHAR(20)
CHECK (VALUE IN (
    'Programada',
    'Confirmada',
    'Cancelada',
    'Atendida',
    'No asistió'
));

-- Dominio para números de documento de identificación (valores positivos)
CREATE DOMAIN TNumeroDocumento AS BIGINT
CHECK (VALUE > 0);

-- Dominio para números de contacto telefónico (valores positivos)
CREATE DOMAIN TContacto AS BIGINT
CHECK (VALUE > 0);

-- Dominio para tipos documentales permitidos
CREATE DOMAIN TipoDocumento AS VARCHAR(20)
CHECK (VALUE IN (
    'CC',
    'TI',
    'CE',
    'PASAPORTE'
));

CREATE DOMAIN TTipoDocumento AS VARCHAR(20)
CHECK (VALUE IN (
    'CC',
    'TI',
    'CE',
    'PASAPORTE'
));

-- Dominio para razas caninas y felinas frecuentes
CREATE DOMAIN TRaza AS VARCHAR(40)
CHECK (VALUE IN (
    'Labrador',
    'Golden Retriever',
    'Bulldog',
    'Pastor Alemán',
    'Poodle',
    'Beagle',
    'Persa',
    'Siamés',
    'Mestizo',
    'Otra'
));

-- Dominio para tarifas y precios base (no negativos)
CREATE DOMAIN TPrecio AS DECIMAL(10,2)
CHECK (VALUE >= 0);

-- Dominio para clasificación por especie
CREATE DOMAIN TEspecie AS VARCHAR(15)
CHECK (VALUE IN (
    'Perro',
    'Gato',
    'Otro'
));

-- Dominio para peso corporal de pacientes (estrictamente positivo)
CREATE DOMAIN TPeso AS DECIMAL(5,2)
CHECK (VALUE > 0);

-- Dominio para género de los pacientes
CREATE DOMAIN TGenero AS VARCHAR(10)
CHECK (VALUE IN (
    'Macho',
    'Hembra'
));
