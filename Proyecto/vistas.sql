
-- 1. Vista de Historial Clínico Completo
CREATE VIEW v_historial_clinico_completo AS
SELECT 
    h.Id AS IdHistorial,
    m.Id AS IdMascota,
    m.nombre AS NombreMascota,
    m.especie AS Especie,
    m.raza AS Raza,
    t.NumeroDocumento AS DocumentoTitular,
    t.nombre AS NombreTitular,
    h.fechaGeneracion AS FechaAperturaHistorial,
    h.fechaModificacion AS UltimaModificacionHistorial,
    d.Id AS IdDiagnostico,
    d.FechaGenerada AS FechaDiagnostico,
    d.Gravedad,
    d.Descripcion AS DetalleDiagnostico,
    s.Id AS IdServicio,
    s.Descripcion AS ServicioRealizado,
    v.nombre AS MedicoVeterinario,
    v.Especialidad AS EspecialidadMedico,
    fm.Id AS IdFormulacion,
    fm.Descripcion AS MedicamentoFormulado
FROM HistorialesClinicos h
JOIN Mascotas m ON h.IdMascota = m.Id
JOIN Titulares t ON m.NumeroDocumentoTitular = t.NumeroDocumento 
                AND m.TipoDocumentoTitular = t.TipoDocumento
JOIN Diagnosticos d ON d.IdHistorialClinico = h.Id
JOIN Servicios s ON d.IdServicio = s.Id
LEFT JOIN ServicioPrestado sp ON sp.IdServicio = s.Id
LEFT JOIN Veterinarios v ON sp.NumeroDocumentoVeterinario = v.NumeroDocumento 
                        AND sp.TipoDocumentoVeterinario = v.TipoDocumento
LEFT JOIN FormulacionMedica fm ON d.IdFormulacionMedica = fm.Id;


-- 2. Vista de Citas Agendadas
CREATE VIEW v_citas_agendadas AS
SELECT 
    c.Id AS IdCita,
    c.NumeroCita,
    c.fecha AS FechaCita,
    c.Hora AS HoraCita,
    c.Estado AS EstadoCita,
    m.Id AS IdMascota,
    m.nombre AS NombreMascota,
    m.especie AS EspecieMascota,
    t.NumeroDocumento AS DocumentoTitular,
    t.TipoDocumento AS TipoDocTitular,
    t.nombre AS NombreTitular,
    t.telefono AS TelefonoTitular,
    s.Id AS IdServicio,
    s.Descripcion AS ServicioSolicitado,
    s.PrecioBase,
    s.Duracion AS DuracionMinutos,
    n.Id AS IdNotificacion,
    n.Estado AS EstadoNotificacion,
    n.MedioEnvio
FROM Citas c
JOIN Mascotas m ON c.IdMascota = m.Id
JOIN Titulares t ON c.NumeroDocumentoTitular = t.NumeroDocumento 
                AND c.TipoDocumentoTitular = t.TipoDocumento
JOIN Servicios s ON c.IdServicio = s.Id
LEFT JOIN Notificaciones n ON c.IdNotificacion = n.Id;


-- 3. Vista de Disponibilidad de Veterinarios
CREATE VIEW v_disponibilidad_veterinarios AS
SELECT 
    disp.Id AS IdDisponibilidad,
    disp.FechaDeInicio,
    disp.FechaFinal,
    disp.Disponibilidad AS EstaDisponible,
    v.NumeroDocumento AS DocumentoVeterinario,
    v.TipoDocumento AS TipoDocVeterinario,
    v.nombre AS NombreVeterinario,
    v.Especialidad,
    v.telefono AS TelefonoContacto,
    c.Id AS IdCitaAsociada,
    c.Estado AS EstadoCitaAsociada
FROM Disponibilidades disp
JOIN Veterinarios v ON disp.NumeroDocumentoVeterinario = v.NumeroDocumento 
                   AND disp.TipoDocumentoVeterinario = v.TipoDocumento
JOIN Citas c ON disp.IdCita = c.Id;


-- 4. Vista de Veterinarios sin Disponibilidad
CREATE VIEW v_veterinarios_sin_disponibilidad AS
SELECT 
    v.NumeroDocumento AS DocumentoVeterinario,
    v.TipoDocumento AS TipoDocVeterinario,
    v.nombre AS NombreVeterinario,
    v.Especialidad,
    v.correo AS CorreoContacto,
    v.telefono AS TelefonoContacto,
    COUNT(disp.Id) AS TotalTurnosOcupados
FROM Veterinarios v
JOIN Disponibilidades disp ON disp.NumeroDocumentoVeterinario = v.NumeroDocumento 
                          AND disp.TipoDocumentoVeterinario = v.TipoDocumento
WHERE disp.Disponibilidad = FALSE
GROUP BY v.NumeroDocumento, v.TipoDocumento, v.nombre, v.Especialidad, v.correo, v.telefono;


-- 5. Vista de Detalle de Servicios con Especializaciones
CREATE VIEW v_detalle_servicios AS
SELECT 
    s.Id AS IdServicio,
    s.Descripcion AS NombreServicio,
    s.PrecioBase,
    s.Duracion AS DuracionEstimadaMinutos,
    m.Id AS IdMascotaAsignada,
    m.nombre AS MascotaAsignada,
    CASE 
        WHEN b.Id IS NOT NULL THEN 'Baño y Estética'
        WHEN o.Id IS NOT NULL THEN 'Cirugía / Operación'
        WHEN con.Id IS NOT NULL THEN 'Consulta Médica'
        ELSE 'Servicio General'
    END AS CategoriaServicio,
    b.TipoPelo,
    b.IncluyeCorte,
    b.Tamaño AS TamañoMascotaRequerido,
    o.TipoOperacion,
    o.NivelComplejidad,
    o.RequiereAnestesia,
    con.Especialidad AS EspecialidadConsulta,
    con.TipoConsulta,
    con.RequiereControl
FROM Servicios s
JOIN Mascotas m ON s.IdMascota = m.Id
LEFT JOIN BañosServicios b ON s.Id = b.Id
LEFT JOIN OperacionesServicios o ON s.Id = o.Id
LEFT JOIN Consultas con ON s.Id = con.Id;


-- 6. Vista de Estadísticas de Servicios por Categoría
CREATE VIEW v_servicios_por_categoria AS
SELECT 
    CASE 
        WHEN b.Id IS NOT NULL THEN 'Baños y Estética'
        WHEN o.Id IS NOT NULL THEN 'Operaciones y Cirugías'
        WHEN con.Id IS NOT NULL THEN 'Consultas Especializadas'
        ELSE 'Servicios Generales'
    END AS TipoCategoria,
    COUNT(s.Id) AS CantidadServicios,
    AVG(s.PrecioBase) AS PrecioPromedio,
    MIN(s.PrecioBase) AS PrecioMinimo,
    MAX(s.PrecioBase) AS PrecioMaximo,
    AVG(s.Duracion) AS DuracionPromedioMinutos
FROM Servicios s
LEFT JOIN BañosServicios b ON s.Id = b.Id
LEFT JOIN OperacionesServicios o ON s.Id = o.Id
LEFT JOIN Consultas con ON s.Id = con.Id
GROUP BY 
    CASE 
        WHEN b.Id IS NOT NULL THEN 'Baños y Estética'
        WHEN o.Id IS NOT NULL THEN 'Operaciones y Cirugías'
        WHEN con.Id IS NOT NULL THEN 'Consultas Especializadas'
        ELSE 'Servicios Generales'
    END;


-- 7. Vista de Productividad por Veterinario
CREATE VIEW v_productividad_veterinarios AS
SELECT 
    v.NumeroDocumento AS DocumentoVeterinario,
    v.TipoDocumento AS TipoDocVeterinario,
    v.nombre AS NombreVeterinario,
    v.Especialidad,
    COUNT(sp.IdServicio) AS TotalServiciosAtendidos,
    COALESCE(SUM(s.PrecioBase), 0.00) AS ValorTotalGenerado,
    COALESCE(AVG(s.PrecioBase), 0.00) AS PromedioPorServicio
FROM Veterinarios v
LEFT JOIN ServicioPrestado sp ON v.NumeroDocumento = sp.NumeroDocumentoVeterinario 
                             AND v.TipoDocumento = sp.TipoDocumentoVeterinario
LEFT JOIN Servicios s ON sp.IdServicio = s.Id
GROUP BY v.NumeroDocumento, v.TipoDocumento, v.nombre, v.Especialidad;


-- 8. Vista de Distribución de Mascotas por Especie y Raza
CREATE VIEW v_mascotas_por_especie AS
SELECT 
    m.especie AS Especie,
    m.raza AS Raza,
    m.genero AS Genero,
    COUNT(m.Id) AS TotalMascotas,
    COUNT(DISTINCT m.NumeroDocumentoTitular) AS TotalDuenosUnicos
FROM Mascotas m
GROUP BY m.especie, m.raza, m.genero;


-- 9. Vista de Servicios Más Solicitados
CREATE VIEW v_servicios_mas_solicitados AS
SELECT 
    s.Id AS IdServicio,
    s.Descripcion AS NombreServicio,
    s.PrecioBase,
    COUNT(c.Id) AS TotalCitasSolicitadas,
    SUM(s.PrecioBase) AS IngresosTotalesEstimados
FROM Servicios s
JOIN Citas c ON s.Id = c.IdServicio
GROUP BY s.Id, s.Descripcion, s.PrecioBase;


-- 10. Vista de Tasa de Citas por Estado
CREATE VIEW v_tasa_citas_estado AS
SELECT 
    c.Estado AS EstadoCita,
    COUNT(c.Id) AS TotalCitas,
    ROUND(COUNT(c.Id) * 100.0 / (SELECT COUNT(*) FROM Citas), 2) AS PorcentajeDelTotal
FROM Citas c
GROUP BY c.Estado;


-- 11. Vista de Titulares con Mayor Frecuencia de Citas
CREATE VIEW v_titulares_citas_frecuentes AS
SELECT 
    t.NumeroDocumento AS DocumentoTitular,
    t.TipoDocumento AS TipoDocTitular,
    t.nombre AS NombreTitular,
    t.correo AS CorreoContacto,
    t.telefono AS TelefonoContacto,
    COUNT(c.Id) AS TotalCitasAgendadas,
    COUNT(DISTINCT c.IdMascota) AS TotalMascotasAtendidas
FROM Titulares t
JOIN Citas c ON t.NumeroDocumento = c.NumeroDocumentoTitular 
            AND t.TipoDocumento = c.TipoDocumentoTitular
GROUP BY t.NumeroDocumento, t.TipoDocumento, t.nombre, t.correo, t.telefono;


-- 12. Vista de Diagnósticos por Nivel de Gravedad
CREATE VIEW v_diagnosticos_por_gravedad AS
SELECT 
    d.Gravedad,
    COUNT(d.Id) AS TotalDiagnosticos,
    COUNT(DISTINCT d.IdMascota) AS TotalMascotasAfectadas
FROM Diagnosticos d
GROUP BY d.Gravedad;


-- 13. Vista de Notificaciones Vinculadas a Citas
CREATE VIEW v_notificaciones_citas AS
SELECT 
    n.Id AS IdNotificacion,
    n.TipoNotificacion,
    n.MedioEnvio,
    n.Estado AS EstadoEnvio,
    n.FechaDeEnvio,
    n.Mensaje,
    c.Id AS IdCita,
    c.NumeroCita,
    c.fecha AS FechaCita,
    t.nombre AS DestinatarioTitular,
    t.telefono AS TelefonoDestinatario,
    m.nombre AS NombreMascota
FROM Notificaciones n
LEFT JOIN Citas c ON c.IdNotificacion = n.Id
LEFT JOIN Titulares t ON c.NumeroDocumentoTitular = t.NumeroDocumento 
                     AND c.TipoDocumentoTitular = t.TipoDocumento
LEFT JOIN Mascotas m ON c.IdMascota = m.Id;


-- 14. Vista de Relación Mascotas y sus Titulares
CREATE VIEW v_mascotas_titulares AS
SELECT 
    m.Id AS IdMascota,
    m.nombre AS NombreMascota,
    m.especie AS Especie,
    m.raza AS Raza,
    m.genero AS Genero,
    t.NumeroDocumento AS DocumentoTitular,
    t.TipoDocumento AS TipoDocTitular,
    t.nombre AS NombreTitular,
    t.correo AS CorreoTitular,
    t.telefono AS TelefonoTitular
FROM Mascotas m
JOIN Titulares t ON m.NumeroDocumentoTitular = t.NumeroDocumento 
                AND m.TipoDocumentoTitular = t.TipoDocumento;
