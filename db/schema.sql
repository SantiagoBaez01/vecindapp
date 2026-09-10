CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    rol ENUM('ADMIN', 'RESIDENTE', 'PRESTADOR') NOT NULL,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE residente (
    usuario_id INT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    lote VARCHAR(50) NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE rubro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE prestador (
    usuario_id INT PRIMARY KEY,
    rubro_id INT NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    estado_verificacion ENUM('PENDIENTE', 'HABILITADO', 'RECHAZADO') DEFAULT 'PENDIENTE',
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (rubro_id) REFERENCES rubro(id)
);

CREATE TABLE solicitud (
    id INT AUTO_INCREMENT PRIMARY KEY,
    residente_id INT NOT NULL,
    prestador_id INT NOT NULL,
    descripcion_tarea TEXT NOT NULL,
    estado ENUM('PENDIENTE', 'PRESUPUESTADO', 'ACEPTADO', 'FINALIZADO', 'CANCELADO') DEFAULT 'PENDIENTE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (residente_id) REFERENCES residente(usuario_id),
    FOREIGN KEY (prestador_id) REFERENCES prestador(usuario_id)
);

CREATE TABLE resena (
    id INT AUTO_INCREMENT PRIMARY KEY,
    solicitud_id INT UNIQUE NOT NULL,
    calificacion INT NOT NULL CHECK (calificacion >= 1 AND calificacion <= 5),
    comentario TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (solicitud_id) REFERENCES solicitud(id)
);