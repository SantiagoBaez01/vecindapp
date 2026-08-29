# 002 — Interfaz renderizada en el servidor con Thymeleaf

**Fecha:** 26/08/2026 · **Estado:** aceptada

## Contexto

La aplicación se compone de formularios, listados con filtros y vistas de detalle. No tiene
requisitos de interacción en tiempo real ni de actualización continua de la pantalla. Hay que
decidir cómo se construye la capa de presentación sobre el backend elegido en la decisión 001.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Thymeleaf (renderizado en servidor)** | Se integra de forma nativa con Spring MVC y con Spring Security para mostrar u ocultar según el rol. Una sola aplicación que desplegar | Menos dinamismo en la interfaz. Un integrante lo conoce parcialmente y el otro no |
| **React como SPA + API REST** | Interfaz más fluida. Un integrante tiene experiencia en React | Obliga a construir y mantener una API REST, un segundo entorno de build, manejo de CORS y de tokens. Duplica la superficie del proyecto |
| **JSP** | Conocido y simple | Tecnología en desuso, sin ventajas sobre Thymeleaf |

## Decisión

Thymeleaf como motor de plantillas, con HTML, CSS y JavaScript sin framework para la
interactividad puntual (filtros y validaciones de formulario).

## Razones

- El perfil de la aplicación no justifica una SPA. Incorporar React implicaría sumar un
  segundo runtime, un pipeline de build separado y una API REST que el alcance actual no
  necesita.
- La autorización debe resolverse en el servidor. El sistema exige que un residente fuera del
  padrón no pueda acceder al catálogo por ninguna ruta, y eso no puede garantizarse en el
  navegador, que está bajo control del usuario. El renderizado en servidor alinea la interfaz
  con el lugar donde la decisión de acceso realmente se toma.
- La curva de aprendizaje de Thymeleaf es baja: es HTML con atributos (`th:text`, `th:each`,
  `th:if`), accesible para quien maneja HTML y CSS.

## Consecuencias

- Thymeleaf es el único elemento del stack fuera de la experiencia previa completa del
  equipo. Se asume como aprendizaje acotado.
- Permite una división de trabajo natural: plantillas y estilos por un lado, lógica de
  servidor por el otro.
- Si en el futuro se necesitara una interfaz más dinámica, habría que construir la API REST
  que ahora se evita.
