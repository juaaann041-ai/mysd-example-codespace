

-- Caso SeguridadOK 1: Rol Veterinario consulta historial clínico completo y servicios de actor
SET ROLE rol_veterinario;
SELECT IdHistorial, NombreMascota, DetalleDiagnostico, Gravedad 
FROM v_historial_clinico_completo 
LIMIT 3;

SELECT * FROM SV_VETERINARIO.consultar_citas_agendadas() LIMIT 3;
RESET ROLE;

-- Caso SeguridadOK 2: Rol Titular consulta el catálogo de servicios y sus citas agendadas
SET ROLE rol_titular;
SELECT IdServicio, NombreServicio, PrecioBase, DuracionEstimadaMinutos, CategoriaServicio 
FROM v_detalle_servicios 
LIMIT 3;

SELECT * FROM SV_TITULAR.consultar_detalle_servicio() LIMIT 3;
RESET ROLE;

-- Caso SeguridadOK 3: Rol Gerente consulta reportes estratégicos y servicios del actor Gerente
SET ROLE rol_gerente;
SELECT NombreVeterinario, Especialidad, TotalServiciosAtendidos, ValorTotalGenerado 
FROM v_productividad_veterinarios;

SELECT EstadoCita, TotalCitas, PorcentajeDelTotal 
FROM v_tasa_citas_estado;

SELECT * FROM SV_GERENTE.consultar_diagnosticos_gravedad();
SELECT * FROM SV_GERENTE.consultar_servicios_mas_solicitados();
RESET ROLE;

-- Caso SeguridadOK 4: Rol Vendedor consulta citas agendadas y gestiona titulares
SET ROLE rol_vendedor;
SELECT IdCita, NumeroCita, FechaCita, NombreMascota, EstadoCita 
FROM v_citas_agendadas 
LIMIT 3;

SELECT * FROM SV_VENDEDOR.consultar_citas_agendadas() LIMIT 3;
RESET ROLE;

-- Caso SeguridadOK 5: Rol Gerente Comercial consulta catálogo y métricas de servicios
SET ROLE rol_gerente_comercial;
SELECT * FROM v_servicios_por_categoria;
SELECT * FROM SV_GERENTECOMERCIAL.consultar_tipo_servicios();
RESET ROLE;
