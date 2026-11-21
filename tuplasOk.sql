
INSERT INTO Cursos (codigo, nombre, detalle, metodologia, cerrado) VALUES
('CUR001', 'Programacion Python', 'Curso introductorio de programacion en Python', 'Virtual', FALSE),
('CUR002', 'Bases de Datos', 'Curso sobre bases de datos relacionales', 'Presencial', FALSE),
('CUR003', 'Programacion Java', 'Curso de programacion orientada a objetos', 'Mixta', FALSE),
('CUR004', 'SQL Avanzado', 'Curso avanzado de optimizacion SQL', 'Virtual', FALSE);

INSERT INTO Certificaciones (vigencia, valor, curso) VALUES
('2027-01-01', 250000.00, 'CUR001'),
('2027-06-15', 300000.00, 'CUR002'),
('2028-01-01', 350000.00, 'CUR003');

INSERT INTO Habilidades (nombreCorto, nombre) VALUES
('PY',   'Programacion Python'),
('BD',   'Bases de Datos Relacionales'),
('JAVA', 'Programacion Java Orientada a Objetos'),
('SQL',  'Lenguaje SQL y Procedimientos');

INSERT INTO Candidatos (correo, nombres, habilidad) VALUES
('ana@gmail.com',    'Ana Perez',       'PY'),
('juan@gmail.com',   'Juan Gomez',      'BD'),
('carlos@gmail.com', 'Carlos Rodriguez', 'JAVA'),
('maria@gmail.com',  'Maria Lopez',     'SQL');

INSERT INTO Candidatos_Candidatos (candidato1, candidato2) VALUES
('ana@gmail.com',    'juan@gmail.com'),
('juan@gmail.com',   'carlos@gmail.com'),
('carlos@gmail.com', 'ana@gmail.com');

INSERT INTO HabilidadesCandidatos (candidato, habilidad) VALUES
('ana@gmail.com',    'PY'),
('juan@gmail.com',   'BD'),
('carlos@gmail.com', 'JAVA'),
('maria@gmail.com',  'SQL');

INSERT INTO CursosHabilidades (curso, habilidad) VALUES
('CUR001', 'PY'),
('CUR002', 'BD'),
('CUR003', 'JAVA'),
('CUR004', 'SQL');

