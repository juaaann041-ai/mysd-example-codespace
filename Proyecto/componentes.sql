-- ESQUEMAS DE COMPONENTES DE NEGOCIO
CREATE SCHEMA IF NOT EXISTS SV_PERSONAS;
CREATE SCHEMA IF NOT EXISTS SV_TITULARES;
CREATE SCHEMA IF NOT EXISTS SV_VETERINARIOS;
CREATE SCHEMA IF NOT EXISTS SV_MASCOTAS;
CREATE SCHEMA IF NOT EXISTS SV_SERVICIOS;
CREATE SCHEMA IF NOT EXISTS SV_CITAS;
CREATE SCHEMA IF NOT EXISTS SV_DISPONIBILIDADES;
CREATE SCHEMA IF NOT EXISTS SV_HISTORIALESCLINICOS;
CREATE SCHEMA IF NOT EXISTS SV_FORMULACIONESMEDICAS;
CREATE SCHEMA IF NOT EXISTS SV_DIAGNOSTICOS;
CREATE SCHEMA IF NOT EXISTS SV_NOTIFICACIONES;

-- 1. COMPONENTE SV_PERSONAS

CREATE OR REPLACE FUNCTION SV_PERSONAS.adicionar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Personas WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'La persona con documento %-% ya se encuentra registrada.', p_tipodocumento, p_numerodocumento;
    END IF;

    INSERT INTO Personas (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
    VALUES (p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre);
END;
$$;

CREATE OR REPLACE FUNCTION SV_PERSONAS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT p.NumeroDocumento, p.TipoDocumento, p.correo, p.telefono, p.nombre
    FROM Personas p
    WHERE p.NumeroDocumento = p_numerodocumento AND p.TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_PERSONAS.modificar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe la persona con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    UPDATE Personas
    SET correo = p_correo,
        telefono = p_telefono,
        nombre = p_nombre
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_PERSONAS.eliminar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Personas WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe la persona con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    DELETE FROM Personas
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

-- 2. COMPONENTE SV_TITULARES

CREATE OR REPLACE FUNCTION SV_TITULARES.adicionar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Titulares WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'El titular con documento %-% ya se encuentra registrado.', p_tipodocumento, p_numerodocumento;
    END IF;

    INSERT INTO Titulares (NumeroDocumento, TipoDocumento, correo, telefono, nombre)
    VALUES (p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre);
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULARES.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT t.NumeroDocumento, t.TipoDocumento, t.correo, t.telefono, t.nombre
    FROM Titulares t
    WHERE t.NumeroDocumento = p_numerodocumento AND t.TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULARES.modificar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento,
    p_correo TCorreo,
    p_telefono TContacto,
    p_nombre VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Titulares WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe el titular con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    UPDATE Titulares
    SET correo = p_correo,
        telefono = p_telefono,
        nombre = p_nombre
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_TITULARES.eliminar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Titulares WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe el titular con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    IF EXISTS (SELECT 1 FROM Mascotas WHERE NumeroDocumentoTitular = p_numerodocumento AND TipoDocumentoTitular = p_tipodocumento) THEN
        RAISE EXCEPTION 'No se puede eliminar el titular: tiene mascotas registradas a su cargo.';
    END IF;

    DELETE FROM Titulares
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

-- 3. COMPONENTE SV_VETERINARIOS

CREATE OR REPLACE FUNCTION SV_VETERINARIOS.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Veterinarios WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'El veterinario con documento %-% ya se encuentra registrado.', p_tipodocumento, p_numerodocumento;
    END IF;

    INSERT INTO Veterinarios (NumeroDocumento, TipoDocumento, correo, telefono, nombre, Especialidad)
    VALUES (p_numerodocumento, p_tipodocumento, p_correo, p_telefono, p_nombre, p_especialidad);
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIOS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT v.NumeroDocumento, v.TipoDocumento, v.correo, v.telefono, v.nombre, v.Especialidad
    FROM Veterinarios v
    WHERE v.NumeroDocumento = p_numerodocumento AND v.TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIOS.modificar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Veterinarios WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe el veterinario con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    UPDATE Veterinarios
    SET correo = p_correo,
        telefono = p_telefono,
        nombre = p_nombre,
        Especialidad = p_especialidad
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

CREATE OR REPLACE FUNCTION SV_VETERINARIOS.eliminar(
    p_numerodocumento TNumeroDocumento,
    p_tipodocumento TipoDocumento
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Veterinarios WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento) THEN
        RAISE EXCEPTION 'No existe el veterinario con documento %-%.', p_tipodocumento, p_numerodocumento;
    END IF;

    DELETE FROM Veterinarios
    WHERE NumeroDocumento = p_numerodocumento AND TipoDocumento = p_tipodocumento;
END;
$$;

-- 4. COMPONENTE SV_MASCOTAS

CREATE OR REPLACE FUNCTION SV_MASCOTAS.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_id) THEN
        RAISE EXCEPTION 'La mascota con Id % ya se encuentra registrada.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Titulares WHERE NumeroDocumento = p_numerodocumentotitular AND TipoDocumento = p_tipodocumentotitular) THEN
        RAISE EXCEPTION 'El titular con documento %-% no existe.', p_tipodocumentotitular, p_numerodocumentotitular;
    END IF;

    INSERT INTO Mascotas (Id, nombre, raza, especie, genero, NumeroDocumentoTitular, TipoDocumentoTitular)
    VALUES (p_id, p_nombre, p_raza, p_especie, p_genero, p_numerodocumentotitular, p_tipodocumentotitular);
END;
$$;

CREATE OR REPLACE FUNCTION SV_MASCOTAS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT m.Id, m.nombre, m.raza, m.especie, m.genero, m.NumeroDocumentoTitular, m.TipoDocumentoTitular
    FROM Mascotas m
    WHERE m.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_MASCOTAS.modificar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la mascota con Id %.', p_id;
    END IF;

    UPDATE Mascotas
    SET nombre = p_nombre,
        raza = p_raza,
        especie = p_especie,
        genero = p_genero,
        NumeroDocumentoTitular = p_numerodocumentotitular,
        TipoDocumentoTitular = p_tipodocumentotitular
    WHERE Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_MASCOTAS.eliminar(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la mascota con Id %.', p_id;
    END IF;

    DELETE FROM Mascotas WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_MascotasporEspecie
CREATE OR REPLACE FUNCTION SV_MASCOTAS.co_mascotas_por_especie()
RETURNS TABLE (
    Especie TEspecie,
    Raza TRaza,
    Genero TGenero,
    TotalMascotas BIGINT,
    TotalDuenosUnicos BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT m.especie, m.raza, m.genero, COUNT(m.Id), COUNT(DISTINCT m.NumeroDocumentoTitular)
    FROM Mascotas m
    GROUP BY m.especie, m.raza, m.genero;
END;
$$;

-- 5. COMPONENTE SV_SERVICIOS

CREATE OR REPLACE FUNCTION SV_SERVICIOS.adicionar(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_preciobase TPrecio,
    p_duracion INTEGER,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Servicios WHERE Id = p_id) THEN
        RAISE EXCEPTION 'El servicio con Id % ya se encuentra registrado.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_idmascota) THEN
        RAISE EXCEPTION 'La mascota asociada con Id % no existe.', p_idmascota;
    END IF;

    INSERT INTO Servicios (Id, Descripcion, PrecioBase, Duracion, IdMascota)
    VALUES (p_id, p_descripcion, p_preciobase, p_duracion, p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_SERVICIOS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT s.Id, s.Descripcion, s.PrecioBase, s.Duracion, s.IdMascota
    FROM Servicios s
    WHERE s.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_SERVICIOS.modificar(
    p_id INTEGER,
    p_descripcion VARCHAR,
    p_preciobase TPrecio,
    p_duracion INTEGER,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Servicios WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe el servicio con Id %.', p_id;
    END IF;

    UPDATE Servicios
    SET Descripcion = p_descripcion,
        PrecioBase = p_preciobase,
        Duracion = p_duracion,
        IdMascota = p_idmascota
    WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_DetalleServicio
CREATE OR REPLACE FUNCTION SV_SERVICIOS.co_detalle_servicio(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        v.IdServicio, 
        v.NombreServicio, 
        v.PrecioBase, 
        v.DuracionEstimadaMinutos, 
        v.IdMascotaAsignada, 
        v.MascotaAsignada, 
        v.CategoriaServicio
    FROM v_detalle_servicios v
    WHERE (p_id IS NULL OR v.IdServicio = p_id);
END;
$$;

-- Consulta especializada: Co_TipoServicios
CREATE OR REPLACE FUNCTION SV_SERVICIOS.co_tipo_servicios()
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM v_servicios_por_categoria;
END;
$$;

-- Consulta especializada: Co_#ServiciosPorVeterinario
CREATE OR REPLACE FUNCTION SV_SERVICIOS.co_servicios_por_veterinario(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM v_productividad_veterinarios v
    WHERE (p_numerodocumento IS NULL OR v.DocumentoVeterinario = p_numerodocumento)
      AND (p_tipodocumento IS NULL OR v.TipoDocVeterinario = p_tipodocumento);
END;
$$;

-- 6. COMPONENTE SV_CITAS

CREATE OR REPLACE FUNCTION SV_CITAS.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Citas WHERE Id = p_id) THEN
        RAISE EXCEPTION 'La cita con Id % ya existe.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Titulares WHERE NumeroDocumento = p_numerodocumentotitular AND TipoDocumento = p_tipodocumentotitular) THEN
        RAISE EXCEPTION 'El titular con documento %-% no existe.', p_tipodocumentotitular, p_numerodocumentotitular;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_idmascota) THEN
        RAISE EXCEPTION 'La mascota con Id % no existe.', p_idmascota;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Servicios WHERE Id = p_idservicio) THEN
        RAISE EXCEPTION 'El servicio con Id % no existe.', p_idservicio;
    END IF;

    INSERT INTO Citas (Id, fecha, Hora, NumeroCita, Estado, NumeroDocumentoTitular, TipoDocumentoTitular, IdMascota, IdNotificacion, IdServicio)
    VALUES (p_id, p_fecha, p_hora, p_numerocita, p_estado, p_numerodocumentotitular, p_tipodocumentotitular, p_idmascota, p_idnotificacion, p_idservicio);
END;
$$;

CREATE OR REPLACE FUNCTION SV_CITAS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT c.Id, c.fecha, c.Hora, c.NumeroCita, c.Estado, c.NumeroDocumentoTitular, c.TipoDocumentoTitular, c.IdMascota, c.IdNotificacion, c.IdServicio
    FROM Citas c
    WHERE c.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_CITAS.modificar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Citas WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la cita con Id %.', p_id;
    END IF;

    UPDATE Citas
    SET fecha = p_fecha,
        Hora = p_hora,
        NumeroCita = p_numerocita,
        Estado = p_estado,
        NumeroDocumentoTitular = p_numerodocumentotitular,
        TipoDocumentoTitular = p_tipodocumentotitular,
        IdMascota = p_idmascota,
        IdServicio = p_idservicio,
        IdNotificacion = p_idnotificacion
    WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_CitasAgendadas
CREATE OR REPLACE FUNCTION SV_CITAS.co_citas_agendadas(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        v.IdCita, v.NumeroCita, v.FechaCita, v.HoraCita, v.EstadoCita,
        v.NombreMascota, v.NombreTitular, v.ServicioSolicitado, v.EstadoNotificacion
    FROM v_citas_agendadas v
    WHERE (p_fecha IS NULL OR v.FechaCita = p_fecha)
      AND (p_estado IS NULL OR v.EstadoCita::VARCHAR = p_estado);
END;
$$;

-- Consulta especializada: Co_EstadoCita
CREATE OR REPLACE FUNCTION SV_CITAS.co_estado_cita(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT c.Id, c.NumeroCita, c.fecha, c.Hora, c.Estado, m.nombre
    FROM Citas c
    JOIN Mascotas m ON c.IdMascota = m.Id
    WHERE c.Id = p_id;
END;
$$;

-- Consulta especializada: Co_Servicios+Solicitados
CREATE OR REPLACE FUNCTION SV_CITAS.co_servicios_mas_solicitados()
RETURNS TABLE (
    IdServicio INTEGER,
    NombreServicio VARCHAR,
    PrecioBase TPrecio,
    TotalCitasSolicitadas BIGINT,
    IngresosTotalesEstimados NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM v_servicios_mas_solicitados;
END;
$$;

-- Consulta especializada: Co_TasaInasistencia&Cancelacion
CREATE OR REPLACE FUNCTION SV_CITAS.co_tasa_inasistencia_cancelacion()
RETURNS TABLE (
    EstadoCita TEstado,
    TotalCitas BIGINT,
    PorcentajeDelTotal NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM v_tasa_citas_estado;
END;
$$;

-- Consulta especializada: Co_TitularesConMayor#Citas
CREATE OR REPLACE FUNCTION SV_CITAS.co_titulares_mayor_citas()
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM v_titulares_citas_frecuentes;
END;
$$;

-- 7. COMPONENTE SV_DISPONIBILIDADES

CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Disponibilidades WHERE Id = p_id) THEN
        RAISE EXCEPTION 'La disponibilidad con Id % ya existe.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Veterinarios WHERE NumeroDocumento = p_numerodocumentoveterinario AND TipoDocumento = p_tipodocumentoveterinario) THEN
        RAISE EXCEPTION 'El veterinario con documento %-% no existe.', p_tipodocumentoveterinario, p_numerodocumentoveterinario;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Citas WHERE Id = p_idcita) THEN
        RAISE EXCEPTION 'La cita con Id % no existe.', p_idcita;
    END IF;

    INSERT INTO Disponibilidades (Id, FechaDeInicio, FechaFinal, Disponibilidad, NumeroDocumentoVeterinario, TipoDocumentoVeterinario, IdCita)
    VALUES (p_id, p_fechainicio, p_fechafinal, p_disponibilidad, p_numerodocumentoveterinario, p_tipodocumentoveterinario, p_idcita);
END;
$$;

CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT d.Id, d.FechaDeInicio, d.FechaFinal, d.Disponibilidad, d.NumeroDocumentoVeterinario, d.TipoDocumentoVeterinario, d.IdCita
    FROM Disponibilidades d
    WHERE d.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.modificar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Disponibilidades WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la disponibilidad con Id %.', p_id;
    END IF;

    UPDATE Disponibilidades
    SET FechaDeInicio = p_fechainicio,
        FechaFinal = p_fechafinal,
        Disponibilidad = p_disponibilidad,
        NumeroDocumentoVeterinario = p_numerodocumentoveterinario,
        TipoDocumentoVeterinario = p_tipodocumentoveterinario,
        IdCita = p_idcita
    WHERE Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.eliminar(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Disponibilidades WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la disponibilidad con Id %.', p_id;
    END IF;

    DELETE FROM Disponibilidades WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_DisponibilidadesVeterinarios
CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.co_disponibilidades_veterinarios(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        v.IdDisponibilidad, v.FechaDeInicio, v.FechaFinal, v.EstaDisponible,
        v.NombreVeterinario, v.Especialidad, v.TelefonoContacto
    FROM v_disponibilidad_veterinarios v
    WHERE (p_fechainicio IS NULL OR v.FechaDeInicio >= p_fechainicio)
      AND (p_fechafinal IS NULL OR v.FechaFinal <= p_fechafinal);
END;
$$;

-- Consulta especializada: Co_VeterinarioSinDisponobilidad
CREATE OR REPLACE FUNCTION SV_DISPONIBILIDADES.co_veterinarios_sin_disponibilidad(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM v_veterinarios_sin_disponibilidad;
END;
$$;

-- 8. COMPONENTE SV_HISTORIALESCLINICOS

CREATE OR REPLACE FUNCTION SV_HISTORIALESCLINICOS.adicionar(
    p_id INTEGER,
    p_fechageneracion DATE,
    p_fechamodificacion DATE,
    p_descripcion VARCHAR,
    p_idmascota INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM HistorialesClinicos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'El historial clínico con Id % ya existe.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_idmascota) THEN
        RAISE EXCEPTION 'La mascota con Id % no existe.', p_idmascota;
    END IF;

    INSERT INTO HistorialesClinicos (Id, fechaGeneracion, fechaModificacion, descripcion, IdMascota)
    VALUES (p_id, p_fechageneracion, p_fechamodificacion, p_descripcion, p_idmascota);
END;
$$;

CREATE OR REPLACE FUNCTION SV_HISTORIALESCLINICOS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT h.Id, h.fechaGeneracion, h.fechaModificacion, h.descripcion, h.IdMascota
    FROM HistorialesClinicos h
    WHERE h.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_HISTORIALESCLINICOS.modificar(
    p_id INTEGER,
    p_fechamodificacion DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM HistorialesClinicos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe el historial clínico con Id %.', p_id;
    END IF;

    UPDATE HistorialesClinicos
    SET fechaModificacion = p_fechamodificacion,
        descripcion = p_descripcion
    WHERE Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_HISTORIALESCLINICOS.eliminar(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM HistorialesClinicos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe el historial clínico con Id %.', p_id;
    END IF;

    DELETE FROM HistorialesClinicos WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_HistorialClinico
CREATE OR REPLACE FUNCTION SV_HISTORIALESCLINICOS.co_historial_clinico(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        v.IdHistorial, v.NombreMascota, v.Especie, v.NombreTitular,
        v.FechaDiagnostico, v.Gravedad, v.DetalleDiagnostico,
        v.ServicioRealizado, v.MedicoVeterinario, v.MedicamentoFormulado
    FROM v_historial_clinico_completo v
    WHERE v.IdMascota = p_idmascota
    ORDER BY v.FechaDiagnostico DESC;
END;
$$;

-- 9. COMPONENTE SV_FORMULACIONESMEDICAS

CREATE OR REPLACE FUNCTION SV_FORMULACIONESMEDICAS.adicionar(
    p_id INTEGER,
    p_fecha DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM FormulacionMedica WHERE Id = p_id) THEN
        RAISE EXCEPTION 'La formulación médica con Id % ya existe.', p_id;
    END IF;

    INSERT INTO FormulacionMedica (Id, Fecha, Descripcion)
    VALUES (p_id, p_fecha, p_descripcion);
END;
$$;

CREATE OR REPLACE FUNCTION SV_FORMULACIONESMEDICAS.consultar(
    p_id INTEGER
)
RETURNS TABLE (
    Id INTEGER,
    Fecha DATE,
    Descripcion VARCHAR
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT f.Id, f.Fecha, f.Descripcion
    FROM FormulacionMedica f
    WHERE f.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_FORMULACIONESMEDICAS.modificar(
    p_id INTEGER,
    p_fecha DATE,
    p_descripcion VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM FormulacionMedica WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la formulación médica con Id %.', p_id;
    END IF;

    UPDATE FormulacionMedica
    SET Fecha = p_fecha,
        Descripcion = p_descripcion
    WHERE Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_FORMULACIONESMEDICAS.eliminar(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM FormulacionMedica WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la formulación médica con Id %.', p_id;
    END IF;

    DELETE FROM FormulacionMedica WHERE Id = p_id;
END;
$$;

-- 10. COMPONENTE SV_DIAGNOSTICOS

CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Diagnosticos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'El diagnóstico con Id % ya existe.', p_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Servicios WHERE Id = p_idservicio) THEN
        RAISE EXCEPTION 'El servicio con Id % no existe.', p_idservicio;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Mascotas WHERE Id = p_idmascota) THEN
        RAISE EXCEPTION 'La mascota con Id % no existe.', p_idmascota;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM HistorialesClinicos WHERE Id = p_idhistorialclinico) THEN
        RAISE EXCEPTION 'El historial clínico con Id % no existe.', p_idhistorialclinico;
    END IF;

    INSERT INTO Diagnosticos (Id, Descripcion, FechaGenerada, Gravedad, IdServicio, IdMascota, IdHistorialClinico, IdFormulacionMedica)
    VALUES (p_id, p_descripcion, p_fechagenerada, p_gravedad, p_idservicio, p_idmascota, p_idhistorialclinico, p_idformulacionmedica);
END;
$$;

CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT d.Id, d.Descripcion, d.FechaGenerada, d.Gravedad, d.IdServicio, d.IdMascota, d.IdHistorialClinico, d.IdFormulacionMedica
    FROM Diagnosticos d
    WHERE d.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.modificar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Diagnosticos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe el diagnóstico con Id %.', p_id;
    END IF;

    UPDATE Diagnosticos
    SET Descripcion = p_descripcion,
        FechaGenerada = p_fechagenerada,
        Gravedad = p_gravedad,
        IdServicio = p_idservicio,
        IdMascota = p_idmascota,
        IdHistorialClinico = p_idhistorialclinico,
        IdFormulacionMedica = p_idformulacionmedica
    WHERE Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.eliminar(
    p_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Diagnosticos WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe el diagnóstico con Id %.', p_id;
    END IF;

    DELETE FROM Diagnosticos WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_Diagnosticos
CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.co_diagnosticos(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT d.Id, m.nombre, d.Descripcion, d.FechaGenerada, d.Gravedad
    FROM Diagnosticos d
    JOIN Mascotas m ON d.IdMascota = m.Id
    WHERE d.IdMascota = p_idmascota
    ORDER BY d.FechaGenerada DESC;
END;
$$;

-- Consulta especializada: Co_#DiagnosticosGravedad
CREATE OR REPLACE FUNCTION SV_DIAGNOSTICOS.co_diagnosticos_gravedad()
RETURNS TABLE (
    Gravedad TGravedad,
    TotalDiagnosticos BIGINT,
    TotalMascotasAfectadas BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY SELECT * FROM v_diagnosticos_por_gravedad;
END;
$$;

-- 11. COMPONENTE SV_NOTIFICACIONES

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.adicionar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Notificaciones WHERE Id = p_id) THEN
        RAISE EXCEPTION 'La notificación con Id % ya existe.', p_id;
    END IF;

    INSERT INTO Notificaciones (Id, Mensaje, FechaDeEnvio, TipoNotificacion, Estado, MedioEnvio)
    VALUES (p_id, p_mensaje, p_fechadeenvio, p_tiponotificacion, p_estado, p_medioenvio);
END;
$$;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.consultar(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT n.Id, n.Mensaje, n.FechaDeEnvio, n.TipoNotificacion, n.Estado, n.MedioEnvio
    FROM Notificaciones n
    WHERE n.Id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.modificar(
    p_id INTEGER,
    p_mensaje VARCHAR,
    p_estado TEstadoNotificacion
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Notificaciones WHERE Id = p_id) THEN
        RAISE EXCEPTION 'No existe la notificación con Id %.', p_id;
    END IF;

    UPDATE Notificaciones
    SET Mensaje = p_mensaje,
        Estado = p_estado
    WHERE Id = p_id;
END;
$$;

-- Consulta especializada: Co_Notificaciones
CREATE OR REPLACE FUNCTION SV_NOTIFICACIONES.co_notificaciones(
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
SET search_path = public, pg_temp
AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM v_notificaciones_citas v
    WHERE (p_idcita IS NULL OR v.IdCita = p_idcita);
END;
$$;
