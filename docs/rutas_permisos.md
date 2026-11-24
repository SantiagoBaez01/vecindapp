# Definición de rutas

## Públicas

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| / | GET | Cualquiera | Landing page de bienvenida |
| /login | GET, POST | Cualquiera | Pantalla de inicio de sesión y procesamiento del formulario |
| /registro/prestador | GET, POST | Cualquiera | Alta de prestador (queda en estado PENDIENTE) — M2 |
| /css/**, /js/**, /images/** | GET | Cualquiera | Archivos estáticos |

## Comunes (autenticados)

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| /home | GET | ADMIN, RESIDENTE, PRESTADOR | Dashboard; redirige según rol |
| /perfil | GET, POST | ADMIN, RESIDENTE, PRESTADOR | Ver y actualizar teléfono o contraseña |
| /logout | POST | Autenticados | Cierre de sesión |

## Catálogo

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| /catalogo | GET | RESIDENTE | Listado de prestadores habilitados con filtros |
| /catalogo/prestador/{id} | GET | RESIDENTE | Ficha de detalle, descripción y reseñas |

## Solicitudes (residente)

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| /mis-pedidos | GET | RESIDENTE | Listado de solicitudes generadas |
| /mis-pedidos/nueva/{prestadorId} | GET, POST | RESIDENTE | Formulario para pedir un trabajo |
| /mis-pedidos/{id}/aceptar | POST | RESIDENTE | Aceptar presupuesto |
| /mis-pedidos/{id}/cancelar | POST | RESIDENTE | Cancelar solicitud |
| /mis-pedidos/{id}/resenar | GET, POST | RESIDENTE | Reseña solo si la solicitud está FINALIZADO |

## Solicitudes (prestador)

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| /mis-trabajos | GET | PRESTADOR | Listado de solicitudes recibidas |
| /mis-trabajos/{id}/presupuestar | POST | PRESTADOR | Marcar como presupuestada |
| /mis-trabajos/{id}/finalizar | POST | PRESTADOR | Marcar trabajo como terminado |
| /mi-estado | GET | PRESTADOR | Consultar estado de verificación |

## Administración

| Ruta (URL) | Método | Rol permitido | Descripción |
| --- | --- | --- | --- |
| /admin | GET | ADMIN | Panel general |
| /admin/residentes | GET, POST | ADMIN | Padrón: listado y alta |
| /admin/residentes/{id}/editar | GET, POST | ADMIN | Modificar residente |
| /admin/residentes/{id}/desactivar | POST | ADMIN | Baja lógica del padrón |
| /admin/residentes/{id}/activar | POST | ADMIN | Reactivar residente |
| /admin/prestadores | GET | ADMIN | Listado y bandeja de pendientes |
| /admin/prestadores/{id}/habilitar | POST | ADMIN | Habilitar prestador |
| /admin/prestadores/{id}/rechazar | POST | ADMIN | Rechazar prestador |
| /admin/prestadores/export | GET | ADMIN | Exportar CSV de habilitados |
| /admin/rubros | GET, POST | ADMIN | Listado y alta de rubros |
| /admin/solicitudes | GET | ADMIN | Vista de todas las solicitudes |
| /admin/resenas | GET | ADMIN | Moderación de reseñas |
| /admin/resenas/{id}/ocultar | POST | ADMIN | Ocultar reseña |
| /admin/resenas/{id}/mostrar | POST | ADMIN | Volver a mostrar reseña |
