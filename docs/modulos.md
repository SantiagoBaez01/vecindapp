# Módulos del sistema — Vecindapp

Listado de los módulos a desarrollar, con su responsabilidad, las funcionalidades que
incluyen, las entidades del modelo de datos que manipulan y su prioridad dentro del alcance.

El modelo de datos al que se hace referencia está documentado en
[`diccionario_datos.md`](diccionario_datos.md) y en el diagrama [`der-db.png`](der-db.png).
Los scripts del esquema están en [`/db`](../db).

**Criterio de prioridad.** Se corresponde con la política de recorte declarada en el
[README](../README.md#riesgos-y-mitigaciones): ante un desvío del cronograma, se recorta
primero lo marcado como baja y se preserva lo innegociable.

| Prioridad | Significado |
|---|---|
| **Alta** | Innegociable. Sin esto el sistema no cumple su propósito |
| **Media** | Necesario para la propuesta de valor, pero el flujo principal funciona sin ello |
| **Baja** | Recortable. Si falta, se resuelve por otra vía o se pospone |

---

## Resumen

| # | Módulo | Prioridad | Depende de |
|---|---|---|---|
| M1 | Seguridad y Padrón de Residentes | Alta | — |
| M2 | Prestadores y Circuito de Verificación | Alta | M1 |
| M3 | Catálogo de Oficios | Alta | M2 |
| M4 | Solicitudes de Servicio | Alta | M1, M2, M3 |
| M5 | Reseñas y Calificaciones | Media | M4 |
| M6 | Administración y Moderación | Baja | M1, M2, M5 |

El orden de desarrollo sigue la cadena de dependencias: M1 → M2 → M3 → M4 → M5 → M6.

---

## M1 · Seguridad y Padrón de Residentes

**Responsabilidad.** Controlar quién entra al sistema y con qué permisos, y mantener el
padrón de residentes habilitados por la administración del barrio.

Es la base de todo el sistema: el acceso al catálogo está restringido al padrón, y esa
restricción se resuelve acá.

**Funcionalidades**

- Registro e inicio de sesión con email y contraseña.
- Almacenamiento de contraseñas con hash.
- Autorización por rol: `ADMIN`, `RESIDENTE` y `PRESTADOR`, aplicada a nivel de ruta y de
  método.
- Alta, baja y modificación de residentes del padrón, a cargo de la administración.
- Baja lógica de un residente sin pérdida de su historial.

**Entidades**: `usuario`, `residente`

**Roles**: administración (gestiona el padrón) · residente y prestador (autenticación)

**Criterio de terminado**: un usuario fuera del padrón no accede al catálogo por ninguna
ruta, ni escribiendo la URL directamente.

---

## M2 · Prestadores y Circuito de Verificación

**Responsabilidad.** Registrar prestadores y gestionar el circuito por el cual la
administración los habilita. Es el módulo que sostiene la propuesta de valor: en el catálogo
solo aparece quien fue verificado.

**Funcionalidades**

- Alta del prestador con sus datos y el rubro al que pertenece.
- Estados de verificación: `PENDIENTE`, `HABILITADO` y `RECHAZADO`.
- Bandeja de prestadores pendientes para la administración.
- Habilitación y rechazo, con reflejo inmediato en la visibilidad del catálogo.
- Administración del listado de rubros.

**Entidades**: `prestador`, `rubro`, `usuario`

**Roles**: administración (verifica y habilita) · prestador (se registra y consulta su estado)

**Criterio de terminado**: un prestador en estado `PENDIENTE` o `RECHAZADO` no figura en el
catálogo, y al habilitarlo aparece sin intervención adicional.

---

## M3 · Catálogo de Oficios

**Responsabilidad.** Presentar al residente los prestadores habilitados y permitirle
encontrar al que necesita.

**Funcionalidades**

- Listado de prestadores habilitados.
- Filtro por rubro.
- Búsqueda por nombre del prestador.
- Ficha de detalle con los datos del prestador y sus reseñas.
- Promedio de calificación calculado a partir de las reseñas recibidas.

**Entidades**: `prestador`, `rubro`, `resena` (solo lectura)

**Roles**: residente

**Criterio de terminado**: un residente encuentra un prestador por rubro y accede a su ficha
con las reseñas visibles.

> Los filtros combinados y el ordenamiento avanzado quedan como mejora de prioridad baja. El
> filtro por rubro es lo innegociable.

---

## M4 · Solicitudes de Servicio

**Responsabilidad.** Gestionar el ciclo de vida de una contratación, desde que el residente
la genera hasta que se da por finalizada.

**Funcionalidades**

- Creación de una solicitud desde la ficha del prestador, con descripción de la tarea.
- Máquina de estados: `PENDIENTE` → `PRESUPUESTADO` → `ACEPTADO` → `FINALIZADO`, con
  `CANCELADO` como salida posible.
- Transiciones controladas según el rol: el prestador avanza el estado, el residente acepta o
  cancela.
- Listado de solicitudes propias, tanto para el residente como para el prestador.

**Entidades**: `solicitud`, `residente`, `prestador`

**Roles**: residente (crea, acepta, cancela) · prestador (presupuesta, finaliza)

**Criterio de terminado**: una solicitud recorre el ciclo completo y solo admite las
transiciones válidas para cada rol.

> El acuerdo económico ocurre fuera de la plataforma. El estado `PRESUPUESTADO` registra que
> el prestador ya respondió con una cotización, no el monto acordado.

---

## M5 · Reseñas y Calificaciones

**Responsabilidad.** Convertir cada trabajo finalizado en información reputacional
consultable por el resto del barrio. Es el módulo que diferencia la plataforma del boca a
boca.

**Funcionalidades**

- Carga de una reseña con calificación de 1 a 5 y comentario.
- Habilitada únicamente al residente que contrató, y solo sobre solicitudes finalizadas.
- Una sola reseña por solicitud.
- Visualización de las reseñas en la ficha del prestador.

**Entidades**: `resena`, `solicitud`

**Roles**: residente (reseña) · todos los residentes (consultan)

**Criterio de terminado**: solo quien contrató puede reseñar, solo sobre un trabajo
finalizado, y una única vez.

---

## M6 · Administración y Moderación

**Responsabilidad.** Reunir las vistas transversales de la administración y permitir moderar
el contenido que publican los usuarios.

Las funciones administrativas críticas —padrón y habilitación de prestadores— viven en M1 y
M2 respectivamente. Este módulo agrupa lo que queda: la visión de conjunto y la moderación.

**Funcionalidades**

- Vista general de residentes, prestadores y solicitudes.
- Moderación de reseñas: ocultar una reseña inapropiada sin eliminar el registro.
- Exportación del listado de prestadores habilitados.

**Entidades**: todas, en modo consulta · `resena` en modo edición

**Roles**: administración

**Criterio de terminado**: la administración puede ocultar una reseña y deja de verse en la
ficha del prestador.

> Es el módulo de prioridad más baja y el primero en recortarse ante un desvío. Si se recorta,
> la moderación se resuelve directamente sobre la base de datos, sin interfaz gráfica.

---

## Componentes transversales

No son módulos funcionales, pero son trabajo necesario y están planificados como tareas
propias en el tablero.

| Componente | Contenido |
|---|---|
| **Estructura base del proyecto** | Proyecto Spring Boot, dependencias, configuración por variables de entorno, conexión a la base de datos |
| **Capa de presentación** | Layout base de Thymeleaf, fragmentos comunes (cabecera, navegación, pie), hoja de estilos |
| **Rutas y permisos** | Mapa de rutas del sistema y matriz de permisos por rol |
| **Base de datos en la nube** | Instancia MySQL gestionada en Aiven y configuración de conexión de la aplicación |

---

## Ajustes pendientes sobre el modelo de datos

Cuestiones detectadas al definir los módulos, que afectan al esquema y deben resolverse antes
de comenzar el desarrollo:

| # | Situación | Módulo afectado |
|---|---|---|
| 1 | `prestador.rubro_id` admite un único rubro. Un prestador que ofrece más de un oficio requeriría una tabla intermedia `prestador_rubro` | M2, M3 |
| 2 | `resena` no tiene campo de estado o visibilidad, necesario para la moderación prevista en M6 | M6 |
| 3 | La ficha de detalle de M3 muestra solo nombre y rubro; falta decidir si el prestador lleva descripción o datos de contacto adicionales | M3 |

---

## Correspondencia con el tablero

Cada módulo de este documento tiene su tarjeta en la columna *Desarrollo* del tablero de
Trello, y los componentes transversales en la columna *Diseño*. El documento define el
alcance de cada módulo; el tablero refleja su estado de avance.
