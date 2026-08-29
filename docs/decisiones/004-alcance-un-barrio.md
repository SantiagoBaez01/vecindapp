# 004 — Alcance inicial limitado a un único barrio

**Fecha:** 27/08/2026 · **Estado:** aceptada

## Contexto

La idea original contemplaba que la plataforma sirviera a varios barrios privados. Al definir
el alcance del proyecto surgió la necesidad de distinguir dos cosas distintas: hasta dónde
podría llegar el producto como negocio, y qué va a construir el equipo en este cuatrimestre.
La distinción se planteó explícitamente en la reunión de tutoría del 27/08/2026.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Un único barrio** | Modelo de datos y desarrollo más simples. Alcance alcanzable en el tiempo disponible | No demuestra el potencial del producto como negocio |
| **Multi-inquilino (varios barrios en una instancia)** | Es la forma en que el producto crecería realmente. Actualizaciones centralizadas | Exige aislamiento de datos por barrio y resolver el direccionamiento de cada uno. Complejidad muy superior |
| **Una instancia parametrizable por barrio** | Permite replicar el producto sin rehacerlo | Las versiones se desincronizan entre instalaciones y hay que migrar cada una por separado |

## Decisión

La primera versión opera sobre un único barrio. El soporte multi-barrio queda fuera de
alcance.

## Razones

- El equipo son dos personas con fecha de entrega fija. El riesgo principal del proyecto es
  el sobredimensionamiento del alcance, no la dificultad técnica.
- El aislamiento de datos entre barrios es un problema de arquitectura que atraviesa todo el
  modelo. Incorporarlo desde el inicio afectaría cada entidad y cada consulta.
- Ninguna de las funcionalidades que dan valor al producto —catálogo verificado, reseñas de
  vecinos, circuito de habilitación— requiere más de un barrio para demostrarse.

## Consecuencias

- El modelo de datos se diseña para un barrio, sin identificador de barrio en las entidades.
- Extender a varios barrios más adelante implicaría revisar el modelo, no solo agregar una
  columna. Se asume conscientemente.
- Queda registrado como posible evolución posterior, junto con el modelo de negocio asociado.
