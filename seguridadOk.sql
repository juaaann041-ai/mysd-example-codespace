-- 6. PRUEBAS DEL ESQUEMA DE SEGURIDAD

-- SEGURIDAD OK (EXACTAMENTE 5 CASOS DE ÉXITO)
INSERT INTO Habilidades (nombreCorto, nombre) VALUES ('PY', 'Python') ON CONFLICT DO NOTHING;
SET ROLE student;
INSERT INTO Candidatos (correo, nombres, habilidad) VALUES
('test_cand@gmail.com', 'Candidato de Prueba', 'PY')
ON CONFLICT (correo) DO NOTHING;


-- SEGURIDAD ÉXITO 1
-- Actor: sv_candidato
-- Operación: Registrar un plan de formación mediante su servicio autorizado.
-- Resultado esperado: Ejecución exitosa y generación del plan.

SET ROLE sv_candidato;
SELECT SV_CANDIDATO.registrar_plan('maria@gmail.com', '2026-01-18', 'test_cand@gmail.com') AS plan_generado;


-- SEGURIDAD ÉXITO 2
-- Actor: sv_candidato
-- Operación: Adicionar una habilidad con prioridad a su propio plan.
-- Resultado esperado: Ejecución exitosa.
SET ROLE sv_candidato;
DO $$
DECLARE
    v_plan INTEGER;
BEGIN
    SELECT numero INTO v_plan FROM SV_CANDIDATO.consultar_mi_plan('test_cand@gmail.com') LIMIT 1;
    PERFORM SV_CANDIDATO.adicionar_habilidad(v_plan, 'PY', 'Alta', 'test_cand@gmail.com');
    RAISE NOTICE 'SEGURIDAD ÉXITO 2 OK: Habilidad añadida correctamente por el candidato.';
END $$;


-- SEGURIDAD ÉXITO 3
-- Actor: sv_candidato
-- Operación: Consultar sus propios planes formativos.
-- Resultado esperado: Consulta exitosa de su información sin exponer otros candidatos.
SET ROLE sv_candidato;
SELECT * FROM SV_CANDIDATO.consultar_mi_plan('test_cand@gmail.com');


-- SEGURIDAD ÉXITO 4
-- Actor: sv_junta
-- Operación: Consultar el estado de formación general por habilidades.
-- Resultado esperado: Consulta exitosa de la vista operativa de consolidación.
SET ROLE sv_junta;
SELECT * FROM SV_JUNTA.consultar_estado_formacion_por_habilidades();


-- SEGURIDAD ÉXITO 5
-- Actor: sv_junta
-- Operación: Evaluar y aprobar un plan formativo en ejecución.
-- Resultado esperado: Ejecución exitosa por parte de la Junta.



-- Primero el candidato inicia la ejecución de su plan
SET ROLE sv_candidato;
DO $$
DECLARE
    v_plan INTEGER;
BEGIN
    SELECT numero INTO v_plan FROM SV_CANDIDATO.consultar_mi_plan('test_cand@gmail.com') LIMIT 1;
    PERFORM SV_CANDIDATO.iniciar_ejecucion(v_plan, 'test_cand@gmail.com');
END $$;

SET ROLE sv_junta;
DO $$
DECLARE
    v_plan INTEGER;
BEGIN
    SELECT numero INTO v_plan FROM SV_JUNTA.consultar_planes('En ejecución') LIMIT 1;
    PERFORM SV_JUNTA.evaluar_plan(v_plan, TRUE);
    RAISE NOTICE 'SEGURIDAD ÉXITO 5 OK: Plan % evaluado y aprobado por la Junta.', v_plan;
END $$;

RESET ROLE;
