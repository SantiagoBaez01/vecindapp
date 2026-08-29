# 003 — Base de datos relacional MySQL 8

**Fecha:** 26/08/2026 · **Estado:** aceptada

## Contexto

El modelo de datos gira alrededor de entidades fuertemente vinculadas entre sí: residentes,
prestadores, solicitudes de servicio y reseñas. Una reseña solo es válida si corresponde a
una solicitud finalizada, de un prestador determinado, hecha por un residente del padrón. Hay
que elegir el tipo de motor y el motor concreto.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Relacional (MySQL / PostgreSQL)** | Integridad referencial y transaccional. Consultas con joins naturales sobre el modelo | Esquema rígido frente a cambios |
| **Documental (MongoDB)** | Flexibilidad de esquema, escalado horizontal | El modelo no es jerárquico sino relacional. Habría que resolver en la aplicación la integridad que el motor daría gratis |

Entre motores relacionales se evaluaron **MySQL** y **PostgreSQL**.

## Decisión

MySQL 8.

## Razones

- Los tres criterios que justifican un motor relacional se cumplen: la estructura de datos es
  estable y está bien definida, las relaciones entre entidades son centrales, y hace falta
  integridad transaccional.
- Un modelo documental no aportaría ventajas para este caso y trasladaría a la aplicación
  validaciones que el motor relacional resuelve por sí mismo.
- Entre MySQL y PostgreSQL la diferencia técnica es irrelevante a esta escala. Se elige MySQL
  por experiencia previa del equipo y porque cuenta con nivel gratuito en el proveedor de
  base gestionada elegido (ver decisión 007).

## Consecuencias

- El esquema se versiona en el repositorio como script DDL bajo `/db`, generado a partir del
  diagrama entidad-relación.
- Se descartó incorporar una herramienta de migraciones versionadas para no sumar una curva
  de aprendizaje adicional. A cambio, los cambios de esquema deben reflejarse manualmente en
  el script y coordinarse entre los dos integrantes.
