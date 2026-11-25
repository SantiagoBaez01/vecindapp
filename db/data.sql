-- Insertar Rubros Base
INSERT INTO rubro (nombre) VALUES ('Plomería'), ('Electricidad'), ('Jardinería'), ('Pintura'), ('Gas');

-- Insertar Usuario Administrador
INSERT INTO usuario (email, password, telefono, rol) VALUES ('admin@vecindapp.com', 'admin123', '1234567892', 'ADMIN');

-- Insertar Usuario Residente y su perfil
INSERT INTO usuario (email, password, telefono, rol) VALUES ('residente1@correo.com', 'res123', '1234567891', 'RESIDENTE');
SET @residente_id = LAST_INSERT_ID();
INSERT INTO residente (usuario_id, nombre_completo, lote, estado)
VALUES (@residente_id, 'Juan Pérez', 'Lote 42', TRUE);

-- Insertar Usuario Prestador y su perfil.
-- Ofrece dos rubros (Plomería y Gas) para cubrir el caso de un prestador con varios oficios.
INSERT INTO usuario (email, password, telefono, rol) VALUES ('plomero@correo.com', 'plom123', '1234567893', 'PRESTADOR');
SET @prestador_id = LAST_INSERT_ID();
INSERT INTO prestador (usuario_id, nombre_completo, descripcion, estado_verificacion)
VALUES (@prestador_id, 'Mario Rossi', 'Plomero y gasista matriculado. Destapaciones, reparación de pérdidas e instalación de termotanques.', 'HABILITADO');
INSERT INTO prestador_rubro (prestador_id, rubro_id) VALUES
    (@prestador_id, (SELECT id FROM rubro WHERE nombre = 'Plomería')),
    (@prestador_id, (SELECT id FROM rubro WHERE nombre = 'Gas'));

-- Solicitud finalizada (habilita reseña según reglas de negocio)
INSERT INTO solicitud (residente_id, prestador_id, descripcion_tarea, estado)
VALUES (@residente_id, @prestador_id, 'Pérdida de agua debajo de la pileta de la cocina. Revisar sifón y conexiones.', 'FINALIZADO');
SET @solicitud_id = LAST_INSERT_ID();

-- Reseña visible del trabajo finalizado (1:1 con la solicitud)
INSERT INTO resena (solicitud_id, calificacion, comentario, estado)
VALUES (@solicitud_id, 5, 'Excelente servicio. Llegó puntual, explicó el problema y dejó todo en orden.', 'VISIBLE');
