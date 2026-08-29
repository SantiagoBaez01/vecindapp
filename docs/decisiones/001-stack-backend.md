# 001 — Java 21 y Spring Boot 3 para el backend

**Fecha:** 26/08/2026 · **Estado:** aceptada

## Contexto

El proyecto requiere un backend que resuelva autenticación, autorización por rol, un modelo
de datos con varias entidades relacionadas y una máquina de estados para las solicitudes de
servicio. El equipo tiene una fecha de entrega fija en noviembre y está formado por dos
personas.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Java + Spring Boot** | Es el lenguaje de la carrera y el equipo ya lo usó en proyectos anteriores. Ecosistema maduro para seguridad y persistencia | Más verboso que otras opciones |
| **Node.js + Express/NestJS** | Permitiría unificar el lenguaje con el frontend | El equipo tiene menos experiencia en backend con Node. Habría que resolver a mano lo que Spring trae integrado |
| **Python + Django** | Muy productivo, con panel de administración incluido | Ningún integrante lo domina; la curva competiría con el tiempo de desarrollo |

## Decisión

Java 21 (LTS) con Spring Boot 3.x.

## Razones

- Es el stack que el equipo maneja. Con un plazo fijo, el tiempo dedicado a aprender compite
  directamente con el tiempo dedicado a desarrollar.
- El problema es una aplicación web transaccional con lógica de negocio y permisos, no un
  sistema de alta concurrencia ni de procesamiento de datos. Es el escenario donde Spring
  Boot es una opción sólida.
- Spring Security y Spring Data JPA cubren de fábrica dos requisitos centrales —autorización
  por rol y persistencia relacional— que en otras opciones habría que resolver manualmente.

Se elige **Java 21** y no una versión anterior porque es LTS, con soporte extendido, y porque
Spring Boot 3 requiere Java 17 o superior. Se elige **Spring Boot 3.x** y no 2.7 porque esta
última dejó de recibir soporte en 2023: entregar en noviembre de 2026 sobre una versión sin
mantenimiento no sería defendible.

## Consecuencias

- El frontend queda condicionado a integrarse bien con Spring MVC (ver decisión 002).
- Se descartan librerías del ecosistema JavaScript para la capa de servidor.
