

-- 1. Eliminación de Triggers sobre Citas
DROP TRIGGER IF EXISTS TR_Citas_ValidarModificacion ON Citas;
DROP TRIGGER IF EXISTS TR_Citas_ValidarTransicionEstado ON Citas;
DROP TRIGGER IF EXISTS TR_Citas_AutomatizarNotificacion ON Citas;

-- 2. Eliminación de Triggers sobre Diagnosticos
DROP TRIGGER IF EXISTS TR_Diagnosticos_Inmutabilidad ON Diagnosticos;
DROP TRIGGER IF EXISTS TR_Diagnosticos_ActualizarHistorial ON Diagnosticos;

-- 3. Eliminación de Funciones de Disparador
DROP FUNCTION IF EXISTS FN_Citas_ValidarModificacion();
DROP FUNCTION IF EXISTS FN_Citas_ValidarTransicionEstado();
DROP FUNCTION IF EXISTS FN_Citas_AutomatizarNotificacion();
DROP FUNCTION IF EXISTS FN_Diagnosticos_Inmutabilidad();
DROP FUNCTION IF EXISTS FN_Diagnosticos_ActualizarHistorial();
