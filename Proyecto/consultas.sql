-- Consulta de personas registradas en el sistema ordenadas alfabéticamente
SELECT 
    p.NumeroDocumento,
    p.TipoDocumento,
    p.nombre,
    p.correo,
    p.telefono
FROM Personas p
ORDER BY p.nombre ASC;

-- Consulta de veterinarios y su especialidad médica
SELECT 
    v.NumeroDocumento,
    v.TipoDocumento,
    v.nombre,
    v.Especialidad,
    v.correo,
    v.telefono
FROM Veterinarios v
ORDER BY v.Especialidad ASC;

-- Consulta de mascotas junto con la información de sus titulares responsables
SELECT 
    m.Id AS IdMascota,
    m.nombre AS NombreMascota,
    m.especie,
    m.raza,
    m.genero,
    t.NumeroDocumento AS DocumentoTitular,
    t.TipoDocumento AS TipoDocTitular,
    t.nombre AS NombreTitular,
    t.telefono AS TelefonoTitular
FROM Mascotas m
JOIN Titulares t 
    ON m.NumeroDocumentoTitular = t.NumeroDocumento 
   AND m.TipoDocumentoTitular = t.TipoDocumento
ORDER BY m.Id ASC;

--Consulta de citas médicas agendadas con detalle de paciente, titular y servicio solicitado
SELECT 
    c.Id AS IdCita,
    c.NumeroCita,
    c.fecha,
    c.Hora,
    c.Estado,
    m.nombre AS Mascota,
    t.nombre AS Titular,
    s.Descripcion AS ServicioSolicitado
FROM Citas c
JOIN Mascotas m ON c.IdMascota = m.Id
JOIN Titulares t 
    ON c.NumeroDocumentoTitular = t.NumeroDocumento 
   AND c.TipoDocumentoTitular = t.TipoDocumento
JOIN Servicios s ON c.IdServicio = s.Id
ORDER BY c.fecha ASC, c.Hora ASC;

--Consulta de servicios y los profesionales veterinarios asignados para su atención
SELECT 
    sp.IdServicio,
    s.Descripcion AS DescripcionServicio,
    s.PrecioBase,
    s.Duracion AS DuracionMinutos,
    v.nombre AS NombreVeterinario,
    v.Especialidad AS EspecialidadVeterinario
FROM ServicioPrestado sp
JOIN Servicios s ON sp.IdServicio = s.Id
JOIN Veterinarios v 
    ON sp.NumeroDocumentoVeterinario = v.NumeroDocumento 
   AND sp.TipoDocumentoVeterinario = v.TipoDocumento
ORDER BY sp.IdServicio ASC;

-- Consulta detallada de servicios de baño y estética asociados a mascotas
SELECT 
    b.Id AS IdBañoServicio,
    b.Descripcion,
    b.PrecioBase,
    b.Duracion,
    b.TipoPelo,
    b.IncluyeCorte,
    b.IncluyeUñas,
    b.Tamaño,
    m.nombre AS Mascota
FROM BañosServicios b
JOIN Mascotas m ON b.IdMascota = m.Id
ORDER BY b.Id ASC;

-- Consulta de intervenciones quirúrgicas programadas y sus requerimientos técnicos
SELECT 
    o.Id AS IdOperacion,
    o.Descripcion,
    o.PrecioBase,
    o.Duracion,
    o.TipoOperacion,
    o.RequiereAnestesia,
    o.NivelComplejidad,
    m.nombre AS Mascota
FROM OperacionesServicios o
JOIN Mascotas m ON o.IdMascota = m.Id
ORDER BY o.Id ASC;

-- Consulta de consultas médicas y modalidades registradas
SELECT 
    con.Id AS IdConsulta,
    con.Descripcion,
    con.PrecioBase,
    con.Duracion,
    con.Especialidad,
    con.TipoConsulta,
    con.RequiereControl,
    m.nombre AS Mascota
FROM Consultas con
JOIN Mascotas m ON con.IdMascota = m.Id
ORDER BY con.Id ASC;

-- Consulta de diagnósticos clínicos emitidos, evolución e historial clínico
SELECT 
    d.Id AS IdDiagnostico,
    m.nombre AS Mascota,
    h.Id AS IdHistorial,
    h.fechaGeneracion AS FechaInicioHistorial,
    d.FechaGenerada AS FechaDiagnostico,
    d.Gravedad,
    d.Descripcion AS DetalleDiagnostico,
    fm.Id AS IdFormulacion,
    fm.Descripcion AS MedicamentoPrescrito
FROM Diagnosticos d
JOIN Mascotas m ON d.IdMascota = m.Id
JOIN HistorialesClinicos h ON d.IdHistorialClinico = h.Id
LEFT JOIN FormulacionMedica fm ON d.IdFormulacionMedica = fm.Id
ORDER BY d.Id ASC;

-- Consulta de disponibilidades horarias de los veterinarios y citas vinculadas
SELECT 
    disp.Id AS IdDisponibilidad,
    disp.FechaDeInicio,
    disp.FechaFinal,
    disp.Disponibilidad AS EstaDisponible,
    v.nombre AS Veterinario,
    c.Id AS IdCita,
    c.NumeroCita,
    c.Estado AS EstadoCita
FROM Disponibilidades disp
JOIN Veterinarios v 
    ON disp.NumeroDocumentoVeterinario = v.NumeroDocumento 
   AND disp.TipoDocumentoVeterinario = v.TipoDocumento
JOIN Citas c ON disp.IdCita = c.Id
ORDER BY disp.FechaDeInicio ASC;

-- Consulta de registro y seguimiento de notificaciones generadas
SELECT 
    n.Id AS IdNotificacion,
    n.TipoNotificacion,
    n.MedioEnvio,
    n.Estado,
    n.FechaDeEnvio,
    n.Mensaje
FROM Notificaciones n
ORDER BY n.FechaDeEnvio DESC;
