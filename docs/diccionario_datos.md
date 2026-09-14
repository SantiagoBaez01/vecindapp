# Diccionario de Datos — Vecindapp

HASTA TENER LA VERSIÓN FINAL SE DEJA EN MARKDOWN Y LUEGO SE PASARÍA A PDF
Este documento describe la estructura, tipos de datos y restricciones de cada entidad en la base de datos relacional del sistema.

## 1. Tabla `usuario`
Entidad base para la autenticación y datos compartidos de todos los actores del sistema.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `id` | INT | PK, AUTO_INCREMENT | Identificador único del usuario. |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Correo electrónico, utilizado como credencial de acceso. |
| `password` | VARCHAR(255) | NOT NULL | Contraseña encriptada del usuario. |
| `telefono` | VARCHAR(50) | NOT NULL | Número de contacto telefónico general. |
| `rol` | ENUM | NOT NULL | Define los permisos: `'ADMIN'`, `'RESIDENTE'`, `'PRESTADOR'`. |
| `fecha_alta` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora exactas de registro en el sistema. |

## 2. Tabla `residente`
Perfil extendido de los usuarios que habitan en el barrio.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `usuario_id` | INT | PK, FK (usuario.id) | Relación 1 a 1 con la tabla `usuario` (DELETE CASCADE). |
| `nombre_completo` | VARCHAR(255) | NOT NULL | Nombre y apellido del residente. |
| `lote` | VARCHAR(50) | NOT NULL | Identificador físico de la propiedad en el barrio (ej. Lote 42). |
| `estado` | BOOLEAN | DEFAULT TRUE | Indica si el residente está activo en el padrón administrativo. |

## 3. Tabla `rubro`
Categorías de los oficios disponibles en el catálogo.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `id` | INT | PK, AUTO_INCREMENT | Identificador único del rubro. |
| `nombre` | VARCHAR(100) | UNIQUE, NOT NULL | Nombre descriptivo (ej. Plomería, Electricidad). |

## 4. Tabla `prestador`
Perfil extendido de los trabajadores que ofrecen sus servicios.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `usuario_id` | INT | PK, FK (usuario.id) | Relación 1 a 1 con la tabla `usuario` (DELETE CASCADE). |
| `nombre_completo` | VARCHAR(255) | NOT NULL | Nombre y apellido, o razón social del prestador. |
| `descripcion` | TEXT | NULL | Texto libre que el prestador publica en su ficha: servicios que ofrece, experiencia, matrícula. |
| `estado_verificacion` | ENUM | DEFAULT 'PENDIENTE' | Estado dictaminado por la administración: `'PENDIENTE'`, `'HABILITADO'`, `'RECHAZADO'`. |

## 5. Tabla `prestador_rubro`
Relación muchos a muchos entre prestadores y rubros. Permite que un mismo prestador ofrezca más de un oficio (por ejemplo, plomería y gas).

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `prestador_id` | INT | PK compuesta, FK (prestador.usuario_id) | Prestador que ofrece el oficio (DELETE CASCADE). |
| `rubro_id` | INT | PK compuesta, FK (rubro.id) | Oficio ofrecido. |

La clave primaria compuesta impide que se cargue dos veces el mismo rubro para un prestador.

## 6. Tabla `solicitud`
Transacción central del sistema que vincula a un residente con un prestador.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `id` | INT | PK, AUTO_INCREMENT | Identificador único de la solicitud. |
| `residente_id` | INT | FK (residente.usuario_id), NOT NULL | Residente que genera la solicitud. |
| `prestador_id` | INT | FK (prestador.usuario_id), NOT NULL | Prestador que recibe la solicitud. |
| `descripcion_tarea` | TEXT | NOT NULL | Detalle del problema o servicio que el residente necesita resolver. |
| `estado` | ENUM | DEFAULT 'PENDIENTE' | Ciclo de vida: `'PENDIENTE'`, `'PRESUPUESTADO'`, `'ACEPTADO'`, `'FINALIZADO'`, `'CANCELADO'`. |
| `fecha_creacion` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora en que se envió la solicitud. |
| `fecha_actualizacion` | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP| Fecha de la última transición de estado. |

## 7. Tabla `resena`
Evaluación del servicio brindado. Solo puede existir si la solicitud está finalizada.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---|---|---|---|
| `id` | INT | PK, AUTO_INCREMENT | Identificador único de la reseña. |
| `solicitud_id` | INT | UNIQUE, FK (solicitud.id), NOT NULL | Garantiza una única reseña por solicitud de trabajo. |
| `calificacion` | INT | NOT NULL, CHECK (1-5) | Puntaje obligatorio de 1 a 5 estrellas. |
| `comentario` | TEXT | NULL | Opinión o descargo textual opcional sobre el trabajo realizado. |
| `estado` | ENUM | NOT NULL, DEFAULT 'VISIBLE' | Visibilidad de la reseña: `'VISIBLE'` u `'OCULTA'`. La administración puede ocultarla sin borrar el registro. |
| `fecha_creacion` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha de publicación de la reseña. |