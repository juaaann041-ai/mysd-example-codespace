
-- 1. Consulta sobre v_historial_clinico_completo filtrando por mascota (aprovecha idx_diagnosticos_mascota)
SELECT 
    IdHistorial,
    NombreMascota,
    Especie,
    NombreTitular,
    FechaDiagnostico,
    Gravedad,
    DetalleDiagnostico,
    ServicioRealizado,
    MedicoVeterinario,
    MedicamentoFormulado
FROM v_historial_clinico_completo
WHERE IdMascota = 1
ORDER BY FechaDiagnostico DESC;

-- 2. Consulta sobre v_citas_agendadas por estado de cita (aprovecha idx_citas_estado y idx_citas_fecha_hora)
SELECT 
    IdCita,
    NumeroCita,
    FechaCita,
    HoraCita,
    EstadoCita,
    NombreMascota,
    NombreTitular,
    ServicioSolicitado,
    EstadoNotificacion
FROM v_citas_agendadas
WHERE EstadoCita = 'Programada'
ORDER BY FechaCita ASC, HoraCita ASC;

-- 3. Consulta sobre v_disponibilidad_veterinarios filtrando por estado disponible
SELECT 
    IdDisponibilidad,
    FechaDeInicio,
    FechaFinal,
    NombreVeterinario,
    Especialidad,
    TelefonoContacto
FROM v_disponibilidad_veterinarios
WHERE EstaDisponible = TRUE;

-- 4. Consulta sobre v_productividad_veterinarios ordenada por ingresos generados
SELECT 
    DocumentoVeterinario,
    NombreVeterinario,
    Especialidad,
    TotalServiciosAtendidos,
    ValorTotalGenerado,
    PromedioPorServicio
FROM v_productividad_veterinarios
ORDER BY ValorTotalGenerado DESC;

-- 5. Consulta sobre v_servicios_mas_solicitados
SELECT 
    IdServicio,
    NombreServicio,
    PrecioBase,
    TotalCitasSolicitadas,
    IngresosTotalesEstimados
FROM v_servicios_mas_solicitados
ORDER BY TotalCitasSolicitadas DESC;

-- 6. Consulta sobre v_tasa_citas_estado
SELECT 
    EstadoCita,
    TotalCitas,
    PorcentajeDelTotal
FROM v_tasa_citas_estado
ORDER BY TotalCitas DESC;

-- 7. Consulta sobre v_titulares_citas_frecuentes
SELECT 
    DocumentoTitular,
    NombreTitular,
    TelefonoContacto,
    TotalCitasAgendadas,
    TotalMascotasAtendidas
FROM v_titulares_citas_frecuentes
ORDER BY TotalCitasAgendadas DESC;

-- 8. Consulta sobre v_mascotas_titulares filtrando por especie canina (aprovecha idx_mascotas_especie)
SELECT 
    IdMascota,
    NombreMascota,
    Raza,
    NombreTitular,
    TelefonoTitular
FROM v_mascotas_titulares
WHERE Especie = 'Perro'
ORDER BY NombreMascota ASC;
