-- Índices sobre Mascotas
CREATE INDEX idx_mascotas_titular 
ON Mascotas (NumeroDocumentoTitular, TipoDocumentoTitular);

CREATE INDEX idx_mascotas_especie 
ON Mascotas (especie);

-- Índices sobre Citas
CREATE INDEX idx_citas_fecha_hora 
ON Citas (fecha, Hora);

CREATE INDEX idx_citas_estado 
ON Citas (Estado);

-- Índices sobre Disponibilidades
CREATE INDEX idx_disponibilidades_fechas 
ON Disponibilidades (FechaDeInicio, FechaFinal);

CREATE INDEX idx_disponibilidades_veterinario 
ON Disponibilidades (NumeroDocumentoVeterinario, TipoDocumentoVeterinario);

CREATE INDEX idx_disponibilidades_estado 
ON Disponibilidades (Disponibilidad);

-- Índices sobre Diagnosticos
CREATE INDEX idx_diagnosticos_mascota 
ON Diagnosticos (IdMascota);

CREATE INDEX idx_diagnosticos_fechagenerada 
ON Diagnosticos (FechaGenerada);

CREATE INDEX idx_diagnosticos_gravedad 
ON Diagnosticos (Gravedad);

-- Índice sobre ServicioPrestado 
CREATE INDEX idx_servicioprestado_veterinario 
ON ServicioPrestado (NumeroDocumentoVeterinario, TipoDocumentoVeterinario);

-- Índice sobre HistorialesClinicos
CREATE INDEX idx_historiales_mascota 
ON HistorialesClinicos (IdMascota);

-- Índice sobre Servicios
CREATE INDEX idx_servicios_preciobase 
ON Servicios (PrecioBase);