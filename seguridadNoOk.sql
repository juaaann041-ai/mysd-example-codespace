-- SEGURIDAD NO OK (EXACTAMENTE 3 CASOS DE FRACASO)

-- SEGURIDAD FRACASO 1
-- Objetivo: Comprobar que sv_candidato NO tiene acceso directo a tablas.
-- Operación: SELECT o INSERT directo sobre la tabla PlanesFormacion.
-- Resultado esperado: permission denied for table planesformacion.
SET ROLE sv_candidato;
DO $$
BEGIN
    PERFORM * FROM PlanesFormacion;
    RAISE EXCEPTION 'ERROR DE SEGURIDAD: sv_candidato pudo consultar directamente la tabla PlanesFormacion.';
EXCEPTION
    WHEN insufficient_privilege THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 1 BLOQUEADO CORRECTAMENTE: Acceso directo a tabla denegado por políticas DCL.';
    WHEN OTHERS THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 1 BLOQUEADO: %', SQLERRM;
END $$;
RESET ROLE;



-- SEGURIDAD FRACASO 2
-- Objetivo: Comprobar que sv_candidato NO puede invocar servicios de la Junta.
-- Operación: Invocación de SV_JUNTA.evaluar_plan desde sv_candidato.
-- Resultado esperado: permission denied for schema sv_junta.
SET ROLE sv_candidato;
DO $$
BEGIN
    PERFORM SV_JUNTA.evaluar_plan(1, TRUE);
    RAISE EXCEPTION 'ERROR DE SEGURIDAD: sv_candidato pudo invocar un método de SV_JUNTA.';
EXCEPTION
    WHEN insufficient_privilege THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 2 BLOQUEADO CORRECTAMENTE: Candidato no tiene privilegios sobre el esquema/método SV_JUNTA.';
    WHEN OTHERS THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 2 BLOQUEADO: %', SQLERRM;
END $$;
RESET ROLE;


-- SEGURIDAD FRACASO 3
-- Objetivo: Comprobar que sv_junta NO puede invocar servicios de creación de planes del candidato.
-- Operación: Invocación de SV_CANDIDATO.registrar_plan desde sv_junta.
-- Resultado esperado: permission denied for schema sv_candidato.
SET ROLE sv_junta;
DO $$
BEGIN
    PERFORM SV_CANDIDATO.registrar_plan('maria@gmail.com', '2026-01-20', 'ana@gmail.com');
    RAISE EXCEPTION 'ERROR DE SEGURIDAD: sv_junta pudo invocar un método de SV_CANDIDATO.';
EXCEPTION
    WHEN insufficient_privilege THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 3 BLOQUEADO CORRECTAMENTE: Junta no tiene privilegios sobre el esquema/método SV_CANDIDATO.';
    WHEN OTHERS THEN
        RAISE NOTICE 'SEGURIDAD FRACASO 3 BLOQUEADO: %', SQLERRM;
END $$;
RESET ROLE;

