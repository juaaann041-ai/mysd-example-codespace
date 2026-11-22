

-- Caso ComponentesNoOK 1: Intentar registrar una mascota para un titular inexistente
-- Servicio probado: SV_MASCOTAS.adicionar
-- Error esperado: ERROR: El titular con documento CC-9999999999 no existe.
SELECT SV_MASCOTAS.adicionar(
p_id := 500,
p_nombre := 'Firulais',
p_raza := 'Criollo',
p_especie := 'Perro',
p_genero := 'Macho',
p_numerodocumentotitular := 9999999999,
p_tipodocumentotitular := 'CC'
);

-- Caso ComponentesNoOK 2: Intentar agendar una cita vinculando un servicio inexistente
-- Servicio probado: SV_CITAS.adicionar
-- Error esperado: ERROR: El servicio con Id 9999 no existe.
SELECT SV_CITAS.adicionar(
p_id := 501,
p_fecha := '2026-12-01',
p_hora := '10:00:00',
p_numerocita := 2050,
p_estado := 'Programada',
p_numerodocumentotitular := 1012345001,
p_tipodocumentotitular := 'CC',
p_idmascota := 1,
p_idservicio := 9999,
p_idnotificacion := NULL
);

-- Caso ComponentesNoOK 3: Intentar registrar un diagnóstico con historial clínico inexistente
-- Servicio probado: SV_DIAGNOSTICOS.adicionar
-- Error esperado: ERROR: El historial clínico con Id 9999 no existe.
SELECT SV_DIAGNOSTICOS.adicionar(
p_id := 502,
p_descripcion := 'Diagnóstico con historial inválido',
p_fechagenerada := '2026-11-25',
p_gravedad := 'Leve',
p_idservicio := 1,
p_idmascota := 1,
p_idhistorialclinico := 9999,
p_idformulacionmedica := NULL
);

-- Caso ComponentesNoOK 4: Intentar registrar un veterinario ya existente (clave duplicada controlada por servicio)
-- Servicio probado: SV_VETERINARIOS.adicionar
-- Error esperado: ERROR: El veterinario con documento CC-1098765001 ya se encuentra registrado.
SELECT SV_VETERINARIOS.adicionar(
p_numerodocumento := 1098765001,
p_tipodocumento := 'CC',
p_correo := 'otro.vet@veterinaria.com',
p_telefono := 3209999999,
p_nombre := 'Dr. Juan Perez Clon',
p_especialidad := 'Medicina general'
);

-- Caso ComponentesNoOK 5: Intentar modificar los datos de una cita con estado 'Atendida'
-- Servicio probado: SV_CITAS.modificar (disparador subyacente TR_Citas_ValidarModificacion)
-- Error esperado: ERROR: No se pueden modificar los datos de una cita con estado Atendida
SELECT SV_CITAS.modificar(
p_id := 4,
p_fecha := '2026-11-20',
p_hora := '16:00:00',
p_numerocita := 1004,
p_estado := 'Atendida',
p_numerodocumentotitular := 1012345001,
p_tipodocumentotitular := 'CC',
p_idmascota := 4,
p_idservicio := 4,
p_idnotificacion := 3
);
