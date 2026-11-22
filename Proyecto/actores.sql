CREATE SCHEMA IF NOT EXISTS SV_TITULAR;
CREATE SCHEMA IF NOT EXISTS SV_VETERINARIO;
CREATE SCHEMA IF NOT EXISTS SV_GERENTE;
CREATE SCHEMA IF NOT EXISTS SV_GERENTECOMERCIAL;
CREATE SCHEMA IF NOT EXISTS SV_VENDEDOR;

-- 1. SERVICIOS DEL ACTOR: TITULAR (SV_TITULAR)

CREATE OR REPLACE FUNCTION SV_TITULAR.adicionar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_TITULARES.adicionar(p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS TABLE (
    NumeroDocumento TNumeroDocumento,
    TipoDocumento TipoDocumento,
    correo TCorreo,
    telefono TContacto,
    nombre VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_TITULARES.consultar(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.modificar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_TITULARES.modificar(p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.eliminar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_TITULARES.eliminar(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.adicionar_mascota(
    p_id INTEGER,
    p_nombre VARCHAR,
    p_raza TRaza,
    p_especie TEspecie,
    p_genero TGenero,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_MASCOTAS.adicionar(p_id, p_nombre, p_raza, p_especie, p_genero, p_numerodocumentotitular, p_tipodocumentotitular);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_mascota(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    nombre VARCHAR,
    raza TRaza,
    especie TEspecie,
    genero TGenero,
    NumeroDocumentoTitular TNumeroDocumento,
    TipoDocumentoTitular TipoDocumento
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_MASCOTAS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.modificar_mascota(
    p_id INTEGER,
    p_nombre VARCHAR,
    p_raza TRaza,
    p_especie TEspecie,
    p_genero TGenero,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_MASCOTAS.modificar(p_id, p_nombre, p_raza, p_especie, p_genero, p_numerodocumentotitular, p_tipodocumentotitular);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.eliminar_mascota(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_MASCOTAS.eliminar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.adicionar_cita(
    p_id INTEGER,
    p_fecha DATE,
    p_hora TIME,
    p_numerocita INTEGER,
    p_estado TEstado,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento,
    p_idmascota INTEGER,
    p_idservicio INTEGER,
    p_idnotificacion INTEGER DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_CITAS.adicionar(p_id, p_fecha, p_hora, p_numerocita, p_estado, p_numerodocumentotitular, p_tipodocumentotitular, p_idmascota, p_idservicio, p_idnotificacion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_cita(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    fecha DATE,
    Hora TIME,
    NumeroCita INTEGER,
    Estado TEstado,
    NumeroDocumentoTitular TNumeroDocumento,
    TipoDocumentoTitular TipoDocumento,
    IdMascota INTEGER,
    IdNotificacion INTEGER,
    IdServicio INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.modificar_cita(
    p_id INTEGER,
    p_fecha DATE,
    p_hora TIME,
    p_numerocita INTEGER,
    p_estado TEstado,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento,
    p_idmascota INTEGER,
    p_idservicio INTEGER,
    p_idnotificacion INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_CITAS.modificar(p_id, p_fecha, p_hora, p_numerocita, p_estado, p_numerodocumentotitular, p_tipodocumentotitular, p_idmascota, p_idservicio, p_idnotificacion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_estado_cita(
    p_id INTEGER
)
RETURNS TABLE (
    IdCita INTEGER,
    NumeroCita INTEGER,
    Fecha DATE,
    Hora TIME,
    Estado TEstado,
    NombreMascota VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_estado_cita(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_detalle_servicio(
    p_id INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    DuracionEstimadaMinutos INTEGER,
    IdMascotaAsignada INTEGER,
    MascotaAsignada VARCHAR,
    CategoriaServicio TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_detalle_servicio(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_notificaciones(
    p_idcita INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdNotificacion INTEGER,
    TipoNotificacion TNotificacion,
    MedioEnvio TMedioEnvio,
    EstadoEnvio TEstadoNotificacion,
    FechaDeEnvio TIMESTAMP,
    Mensaje VARCHAR,
    IdCita INTEGER,
    NumeroCita INTEGER,
    FechaCita DATE,
    DestinatarioTitular VARCHAR,
    TelefonoDestinatario TContacto,
    NombreMascota VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_NOTIFICACIONES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_NOTIFICACIONES.co_notificaciones(p_idcita);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULAR.consultar_disponibilidades(
    p_fechainicio TIMESTAMP DEFAULT NULL,
    p_fechafinal TIMESTAMP DEFAULT NULL
)
RETURNS TABLE (
    IdDisponibilidad INTEGER,
    FechaDeInicio TIMESTAMP,
    FechaFinal TIMESTAMP,
    EstaDisponible BOOLEAN,
    NombreVeterinario VARCHAR,
    Especialidad TEspecialidad,
    TelefonoContacto TContacto
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DISPONIBILIDADES.co_disponibilidades_veterinarios(p_fechainicio, p_fechafinal);
END;
$$;

-- 2. SERVICIOS DEL ACTOR: VETERINARIO (SV_VETERINARIO)

CREATE OR REPLACE FUNCTION SV_VETERINARIO.adicionar_veterinario(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR,
    p_especialidad TEspecialidad
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_VETERINARIOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_VETERINARIOS.adicionar(p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre, p_especialidad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_veterinario(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS TABLE (
    NumeroDocumento TNumeroDocumento,
    TipoDocumento TipoDocumento,
    correo TCorreo,
    telefono TContacto,
    nombre VARCHAR,
    Especialidad TEspecialidad
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_VETERINARIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_VETERINARIOS.consultar(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.modificar_veterinario(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR,
    p_especialidad TEspecialidad
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_VETERINARIOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_VETERINARIOS.modificar(p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre, p_especialidad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.eliminar_veterinario(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_VETERINARIOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_VETERINARIOS.eliminar(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.adicionar_diagnostico(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_fechagenerada DATE,
    p_gravedad TGravedad,
    p_idservicio INTEGER,
    p_idmascota INTEGER,
    p_idhistorialclinico INTEGER,
    p_idformulacionmedica INTEGER DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DIAGNOSTICOS.adicionar(p_id, p_descripcion, p_fechagenerada, p_gravedad, p_idservicio, p_idmascota, p_idhistorialclinico, p_idformulacionmedica);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_diagnostico(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    Descripcion VARCHAR,
    FechaGenerada DATE,
    Gravedad TGravedad,
    IdServicio INTEGER,
    IdMascota INTEGER,
    IdHistorialClinico INTEGER,
    IdFormulacionMedica INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DIAGNOSTICOS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.modificar_diagnostico(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_fechagenerada DATE,
    p_gravedad TGravedad,
    p_idservicio INTEGER,
    p_idmascota INTEGER,
    p_idhistorialclinico INTEGER,
    p_idformulacionmedica INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DIAGNOSTICOS.modificar(p_id, p_descripcion, p_fechagenerada, p_gravedad, p_idservicio, p_idmascota, p_idhistorialclinico, p_idformulacionmedica);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.eliminar_diagnostico(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DIAGNOSTICOS.eliminar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_diagnosticos(
    p_idmascota INTEGER
)
RETURNS TABLE (
    IdDiagnostico INTEGER,
    NombreMascota VARCHAR,
    DescripcionDiagnostico VARCHAR,
    FechaGenerada DATE,
    Gravedad TGravedad
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DIAGNOSTICOS.co_diagnosticos(p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.adicionar_historial_clinico(
    p_id INTEGER,
    p_fechageneracion DATE,
    p_fechamodificacion DATE,
    p_descripcion VARCHAR,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_HISTORIALESCLINICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_HISTORIALESCLINICOS.adicionar(p_id, p_fechageneracion, p_fechamodificacion, p_descripcion, p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_historial_clinico(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    fechaGeneracion DATE,
    fechaModificacion DATE,
    descripcion VARCHAR,
    IdMascota INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_HISTORIALESCLINICOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_HISTORIALESCLINICOS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.modificar_historial_clinico(
    p_id INTEGER,
    p_fechamodificacion DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_HISTORIALESCLINICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_HISTORIALESCLINICOS.modificar(p_id, p_fechamodificacion, p_descripcion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.eliminar_historial_clinico(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_HISTORIALESCLINICOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_HISTORIALESCLINICOS.eliminar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_historial_completo(
    p_idmascota INTEGER
)
RETURNS TABLE (
    IdHistorial INTEGER,
    NombreMascota VARCHAR,
    Especie TEspecie,
    NombreTitular VARCHAR,
    FechaDiagnostico DATE,
    Gravedad TGravedad,
    DetalleDiagnostico VARCHAR,
    ServicioRealizado VARCHAR,
    MedicoVeterinario VARCHAR,
    MedicamentoFormulado VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_HISTORIALESCLINICOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_HISTORIALESCLINICOS.co_historial_clinico(p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.adicionar_formulacion_medica(
    p_id INTEGER,
    p_fecha DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_FORMULACIONESMEDICAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_FORMULACIONESMEDICAS.adicionar(p_id, p_fecha, p_descripcion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_formulacion_medica(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    Fecha DATE,
    Descripcion VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_FORMULACIONESMEDICAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_FORMULACIONESMEDICAS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.modificar_formulacion_medica(
    p_id INTEGER,
    p_fecha DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_FORMULACIONESMEDICAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_FORMULACIONESMEDICAS.modificar(p_id, p_fecha, p_descripcion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.eliminar_formulacion_medica(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_FORMULACIONESMEDICAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_FORMULACIONESMEDICAS.eliminar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_citas_agendadas(
    p_fecha DATE DEFAULT NULL,
    p_estado VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    IdCita INTEGER,
    NumeroCita INTEGER,
    FechaCita DATE,
    HoraCita TIME,
    EstadoCita TEstado,
    NombreMascota VARCHAR,
    NombreTitular VARCHAR,
    ServicioSolicitado VARCHAR,
    EstadoNotificacion TEstadoNotificacion
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_citas_agendadas(p_fecha, p_estado);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.adicionar_disponibilidad(
    p_id INTEGER,
    p_fechainicio TIMESTAMP,
    p_fechafinal TIMESTAMP,
    p_disponibilidad BOOLEAN,
    p_numerodocumentoveterinario TNumeroDocumento,
    p_tipodocumentoveterinario TipoDocumento,
    p_idcita INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DISPONIBILIDADES.adicionar(p_id, p_fechainicio, p_fechafinal, p_disponibilidad, p_numerodocumentoveterinario, p_tipodocumentoveterinario, p_idcita);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_disponibilidad(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    FechaDeInicio TIMESTAMP,
    FechaFinal TIMESTAMP,
    Disponibilidad BOOLEAN,
    NumeroDocumentoVeterinario TNumeroDocumento,
    TipoDocumentoVeterinario TipoDocumento,
    IdCita INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DISPONIBILIDADES.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.modificar_disponibilidad(
    p_id INTEGER,
    p_fechainicio TIMESTAMP,
    p_fechafinal TIMESTAMP,
    p_disponibilidad BOOLEAN,
    p_numerodocumentoveterinario TNumeroDocumento,
    p_tipodocumentoveterinario TipoDocumento,
    p_idcita INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DISPONIBILIDADES.modificar(p_id, p_fechainicio, p_fechafinal, p_disponibilidad, p_numerodocumentoveterinario, p_tipodocumentoveterinario, p_idcita);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.eliminar_disponibilidad(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_DISPONIBILIDADES.eliminar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIO.consultar_detalle_servicio(
    p_id INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    DuracionEstimadaMinutos INTEGER,
    IdMascotaAsignada INTEGER,
    MascotaAsignada VARCHAR,
    CategoriaServicio TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_detalle_servicio(p_id);
END;
$$;

-- 3. SERVICIOS DEL ACTOR: GERENTE (SV_GERENTE)

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_diagnosticos_gravedad()
RETURNS TABLE (
    Gravedad TGravedad,
    TotalDiagnosticos BIGINT,
    TotalMascotasAfectadas BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DIAGNOSTICOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DIAGNOSTICOS.co_diagnosticos_gravedad();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_tipo_servicios()
RETURNS TABLE (
    TipoCategoria TEXT,
    CantidadServicios BIGINT,
    PrecioPromedio NUMERIC,
    PrecioMinimo TPrecio,
    PrecioMaximo TPrecio,
    DuracionPromedioMinutos NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_tipo_servicios();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_servicios_por_veterinario(
    p_numerodocumento TNumeroDocumento DEFAULT NULL,
    p_tipodocumento TipoDocumento DEFAULT NULL
)
RETURNS TABLE (
    DocumentoVeterinario TNumeroDocumento,
    TipoDocVeterinario TipoDocumento,
    NombreVeterinario VARCHAR,
    Especialidad TEspecialidad,
    TotalServiciosAtendidos BIGINT,
    ValorTotalGenerado NUMERIC,
    PromedioPorServicio NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_servicios_por_veterinario(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_mascotas_por_especie()
RETURNS TABLE (
    Especie TEspecie,
    Raza TRaza,
    Genero TGenero,
    TotalMascotas BIGINT,
    TotalDuenosUnicos BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_MASCOTAS.co_mascotas_por_especie();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_servicios_mas_solicitados()
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    TotalCitasSolicitadas BIGINT,
    IngresosTotalesEstimados NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_servicios_mas_solicitados();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_tasa_inasistencia_cancelacion()
RETURNS TABLE (
    EstadoCita TEstado,
    TotalCitas BIGINT,
    PorcentajeDelTotal NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_tasa_inasistencia_cancelacion();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_titulares_mayor_citas()
RETURNS TABLE (
    DocumentoTitular TNumeroDocumento,
    TipoDocTitular TipoDocumento,
    NombreTitular VARCHAR,
    CorreoContacto TCorreo,
    TelefonoContacto TContacto,
    TotalCitasAgendadas BIGINT,
    TotalMascotasAtendidas BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_titulares_mayor_citas();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_veterinarios_sin_disponibilidad(
    p_fecha DATE DEFAULT NULL
)
RETURNS TABLE (
    DocumentoVeterinario TNumeroDocumento,
    TipoDocVeterinario TipoDocumento,
    NombreVeterinario VARCHAR,
    Especialidad TEspecialidad,
    CorreoContacto TCorreo,
    TelefonoContacto TContacto,
    TotalTurnosOcupados BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DISPONIBILIDADES.co_veterinarios_sin_disponibilidad(p_fecha);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTE.consultar_disponibilidades_veterinarios(
    p_fechainicio TIMESTAMP DEFAULT NULL,
    p_fechafinal TIMESTAMP DEFAULT NULL
)
RETURNS TABLE (
    IdDisponibilidad INTEGER,
    FechaDeInicio TIMESTAMP,
    FechaFinal TIMESTAMP,
    EstaDisponible BOOLEAN,
    NombreVeterinario VARCHAR,
    Especialidad TEspecialidad,
    TelefonoContacto TContacto
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_DISPONIBILIDADES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_DISPONIBILIDADES.co_disponibilidades_veterinarios(p_fechainicio, p_fechafinal);
END;
$$;

-- 4. SERVICIOS DEL ACTOR: GERENTE COMERCIAL (SV_GERENTECOMERCIAL)

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.adicionar_servicio(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_preciobase TPrecio,
    p_duracion INTEGER,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_SERVICIOS.adicionar(p_id, p_descripcion, p_preciobase, p_duracion, p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_servicio(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    Descripcion VARCHAR,
    PrecioBase TPrecio,
    Duracion INTEGER,
    IdMascota INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.modificar_servicio(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_preciobase TPrecio,
    p_duracion INTEGER,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_SERVICIOS.modificar(p_id, p_descripcion, p_preciobase, p_duracion, p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_detalle_servicio(
    p_id INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    DuracionEstimadaMinutos INTEGER,
    IdMascotaAsignada INTEGER,
    MascotaAsignada VARCHAR,
    CategoriaServicio TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_detalle_servicio(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_tipo_servicios()
RETURNS TABLE (
    TipoCategoria TEXT,
    CantidadServicios BIGINT,
    PrecioPromedio NUMERIC,
    PrecioMinimo TPrecio,
    PrecioMaximo TPrecio,
    DuracionPromedioMinutos NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_tipo_servicios();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_servicios_mas_solicitados()
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    TotalCitasSolicitadas BIGINT,
    IngresosTotalesEstimados NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_servicios_mas_solicitados();
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_servicios_por_veterinario(
    p_numerodocumento TNumeroDocumento DEFAULT NULL,
    p_tipodocumento TipoDocumento DEFAULT NULL
)
RETURNS TABLE (
    DocumentoVeterinario TNumeroDocumento,
    TipoDocVeterinario TipoDocumento,
    NombreVeterinario VARCHAR,
    Especialidad TEspecialidad,
    TotalServiciosAtendidos BIGINT,
    ValorTotalGenerado NUMERIC,
    PromedioPorServicio NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_servicios_por_veterinario(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_GERENTECOMERCIAL.consultar_tasa_citas_estado()
RETURNS TABLE (
    EstadoCita TEstado,
    TotalCitas BIGINT,
    PorcentajeDelTotal NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_tasa_inasistencia_cancelacion();
END;
$$;

-- 5. SERVICIOS DEL ACTOR: VENDEDOR (SV_VENDEDOR)

CREATE OR REPLACE FUNCTION SV_VENDEDOR.adicionar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_TITULARES.adicionar(p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_titular(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS TABLE (
    NumeroDocumento TNumeroDocumento,
    TipoDocumento TipoDocumento,
    correo TCorreo,
    telefono TContacto,
    nombre VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_TITULARES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_TITULARES.consultar(p_numerodocumento, p_tipodocumento);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.adicionar_mascota(
    p_id INTEGER,
    p_nombre VARCHAR,
    p_raza TRaza,
    p_especie TEspecie,
    p_genero TGenero,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_MASCOTAS.adicionar(p_id, p_nombre, p_raza, p_especie, p_genero, p_numerodocumentotitular, p_tipodocumentotitular);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_mascota(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    nombre VARCHAR,
    raza TRaza,
    especie TEspecie,
    genero TGenero,
    NumeroDocumentoTitular TNumeroDocumento,
    TipoDocumentoTitular TipoDocumento
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_MASCOTAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_MASCOTAS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.adicionar_cita(
    p_id INTEGER,
    p_fecha DATE,
    p_hora TIME,
    p_numerocita INTEGER,
    p_estado TEstado,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento,
    p_idmascota INTEGER,
    p_idservicio INTEGER,
    p_idnotificacion INTEGER DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_CITAS.adicionar(p_id, p_fecha, p_hora, p_numerocita, p_estado, p_numerodocumentotitular, p_tipodocumentotitular, p_idmascota, p_idservicio, p_idnotificacion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_cita(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    fecha DATE,
    Hora TIME,
    NumeroCita INTEGER,
    Estado TEstado,
    NumeroDocumentoTitular TNumeroDocumento,
    TipoDocumentoTitular TipoDocumento,
    IdMascota INTEGER,
    IdNotificacion INTEGER,
    IdServicio INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.modificar_cita(
    p_id INTEGER,
    p_fecha DATE,
    p_hora TIME,
    p_numerocita INTEGER,
    p_estado TEstado,
    p_numerodocumentotitular TNumeroDocumento,
    p_tipodocumentotitular TipoDocumento,
    p_idmascota INTEGER,
    p_idservicio INTEGER,
    p_idnotificacion INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    PERFORM SV_CITAS.modificar(p_id, p_fecha, p_hora, p_numerocita, p_estado, p_numerodocumentotitular, p_tipodocumentotitular, p_idmascota, p_idservicio, p_idnotificacion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_citas_agendadas(
    p_fecha DATE DEFAULT NULL,
    p_estado VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    IdCita INTEGER,
    NumeroCita INTEGER,
    FechaCita DATE,
    HoraCita TIME,
    EstadoCita TEstado,
    NombreMascota VARCHAR,
    NombreTitular VARCHAR,
    ServicioSolicitado VARCHAR,
    EstadoNotificacion TEstadoNotificacion
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_CITAS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_CITAS.co_citas_agendadas(p_fecha, p_estado);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.adicionar_notificacion(
    p_id INTEGER,
    p_mensaje VARCHAR,
    p_fechadeenvio TIMESTAMP,
    p_tiponotificacion TNotificacion,
    p_estado TEstadoNotificacion,
    p_medioenvio TMedioEnvio
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_NOTIFICACIONES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_NOTIFICACIONES.adicionar(p_id, p_mensaje, p_fechadeenvio, p_tiponotificacion, p_estado, p_medioenvio);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_notificacion(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    Mensaje VARCHAR,
    FechaDeEnvio TIMESTAMP,
    TipoNotificacion TNotificacion,
    Estado TEstadoNotificacion,
    MedioEnvio TMedioEnvio
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_NOTIFICACIONES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_NOTIFICACIONES.consultar(p_id);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.modificar_notificacion(
    p_id INTEGER,
    p_mensaje VARCHAR,
    p_estado TEstadoNotificacion
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_NOTIFICACIONES, public, pg_temp
AS $$
BEGIN
    PERFORM SV_NOTIFICACIONES.modificar(p_id, p_mensaje, p_estado);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_notificaciones(
    p_idcita INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdNotificacion INTEGER,
    TipoNotificacion TNotificacion,
    MedioEnvio TMedioEnvio,
    EstadoEnvio TEstadoNotificacion,
    FechaDeEnvio TIMESTAMP,
    Mensaje VARCHAR,
    IdCita INTEGER,
    NumeroCita INTEGER,
    FechaCita DATE,
    DestinatarioTitular VARCHAR,
    TelefonoDestinatario TContacto,
    NombreMascota VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_NOTIFICACIONES, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_NOTIFICACIONES.co_notificaciones(p_idcita);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VENDEDOR.consultar_detalle_servicio(
    p_id INTEGER DEFAULT NULL
)
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    DuracionEstimadaMinutos INTEGER,
    IdMascotaAsignada INTEGER,
    MascotaAsignada VARCHAR,
    CategoriaServicio TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = SV_SERVICIOS, public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM SV_SERVICIOS.co_detalle_servicio(p_id);
END;
$$;
