-- Insertar Rubros Base
INSERT INTO rubro (nombre) VALUES ('Plomería'), ('Electricidad'), ('Jardinería'), ('Pintura');

-- Insertar Usuario Administrador
INSERT INTO usuario (email, password, telefono, rol) VALUES ('admin@vecindapp.com', 'admin123', '1234567892', 'ADMIN');

-- Insertar Usuario Residente y su perfil
INSERT INTO usuario (email, password, telefono, rol) VALUES ('residente1@correo.com', 'res123', '1234567891', 'RESIDENTE');
INSERT INTO residente (usuario_id, nombre_completo, lote, estado) VALUES (LAST_INSERT_ID(), 'Juan Pérez', 'Lote 42', TRUE);

-- Insertar Usuario Prestador (Plomero en este caso) y su perfil
INSERT INTO usuario (email, password, telefono, rol) VALUES ('plomero@correo.com', 'plom123', '1234567893', 'PRESTADOR');
INSERT INTO prestador (usuario_id, rubro_id, nombre_completo, estado_verificacion) VALUES (LAST_INSERT_ID(), 1, 'Mario Rossi', 'HABILITADO');