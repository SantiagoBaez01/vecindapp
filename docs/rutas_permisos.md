# Definición de rutas 

## *Públicas*
| Ruta (URL)                  | Método    | Rol permitido     | Descripción                                                       |
| ---                         | ---       | ---               | ---                                                               |
| /                           | GET       | Cualquiera        | Landing page de bienvenida                                        |
| /login                      | GET, POST | Cualquiera        | Pantalla de inicio de sesión y procesamiento del formulario       |
| /css/**, /js/**, /images/** | GET       | Cualquiera        | Archivos estáticos de Thymeleaf.                                  |


## *Comunes (Autenticados)*
| Ruta (URL)    | Método           | Rol permitido                | Descripción                                                       |
| ---           | ---              | ---                          | ---                                                               |
| /home         | GET              | ADMIN, RESIDENTE, PRESTADOR  | Dashboard principal, redirecciona o muestra info según el rol.    |
| /perfil       | GET, POST        | ADMIN, RESIDENTE, PRESTADOR  | Ver y actualizar datos personales como teléfono o contraseña.     |


## *Módulo: Catálogo*
| Ruta (URL)               | Método           | Rol permitido   | Descripción                                             |
| ---                      | ---              | ---             | ---                                                     |
| /catalogo                | GET              | RESIDENTE       | Listado de prestadores habilitados con filtros.         |
| /catalogo/prestador/{id} | GET              | RESIDENTE       | Ficha de detalle, descripción y reseñas del prestador.  |


## *Módulo: Solicitudes (Residente)*
| Ruta (URL)                         | Método     | Rol permitido   | Descripción                                                     |
| ---                                | ---        | ---             | ---                                                             |
| /mis-pedidos                       | GET        | RESIDENTE       | Listado de las solicitudes que generó el residente.             |
| /mis-pedidos/nueva/{prestadorId}   | GET, POST  | RESIDENTE       | Formulario para pedir un trabajo a un prestador específico.     |
| /mis-pedidos/{id}/aceptar          | POST       | RESIDENTE       | Aceptar el presupuesto enviado por el prestador.                |
| /mis-pedidos/{id}/cancelar         | POST       | RESIDENTE       | Cancelar la solicitud antes de que finalice.                    |


## *Módulo: Solicitudes (Prestador)*
| Ruta (URL)                      | Método     | Rol permitido   | Descripción                                                     |
| ---                             | ---        | ---             | ---                                                             |
| /mis-trabajo                    | GET        | PRESTADOR       | Listado de solicitudes recibidas.                               |
| /mis-trabajos/{id}/presupuestar | POST       | PRESTADOR       | Enviar una cotización/respuesta al residente.                   |
| /mis-trabajos/{id}/finalizar    | POST       | PRESTADOR       | Marcar el trabajo como terminado.                               |


## *Módulo: Reseñas*
| Ruta (URL)                 | Método     | Rol permitido  | Descripción                                                                   |
| ---                        | ---        | ---            | ---                                                                           |
| /mis-pedidos/{id}/resenar  | GET, POST  | RESIDENTE      | Formulario para dejar calificación y comentario, solo si está **FINALIZADO**. |


## *Módulo: Administración*
| Ruta (URL)                 | Método     | Rol permitido  | Descripción                                                                   |
| ---                        | ---        | ---            | ---                                                                           |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
| /             | GET              | Cualquiera                   | Landing page de bienvenida                                        |
