# 006 — Aplicación web responsive, sin versión móvil ni PWA

**Fecha:** 27/08/2026 · **Estado:** aceptada

## Contexto

El uso previsto —buscar un prestador, leer reseñas, generar una solicitud— es el tipo de
tarea que un residente haría desde el teléfono. En la reunión de tutoría del 27/08/2026 se
discutió si convenía encarar el proyecto como aplicación móvil o como Progressive Web App
(PWA), que permitiría instalarla desde el navegador y acceder a funcionalidades del
dispositivo.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Aplicación web responsive** | Un solo desarrollo, accesible desde cualquier dispositivo con navegador | No se instala como aplicación ni accede a funciones del dispositivo |
| **PWA** | Se instala desde el navegador y se comporta como una app. Reutiliza el mismo desarrollo web | Suma requisitos propios (service workers, manifiesto, comportamiento offline) que el equipo no maneja |
| **Aplicación móvil nativa** | Mejor experiencia en el dispositivo | Exigiría un desarrollo completamente separado y tecnologías que el equipo no conoce |

## Decisión

Aplicación web responsive, accesible desde el navegador de cualquier dispositivo. Sin
aplicación móvil nativa y sin PWA.

## Razones

- La experiencia de uso no depende de estar instalada: el residente entra, busca y solicita.
  Ninguna funcionalidad del alcance requiere acceso al dispositivo.
- Una PWA es una evolución razonable del mismo desarrollo web, no una decisión de arquitectura
  que haya que tomar al inicio. Puede incorporarse después sin rehacer lo construido.
- Un desarrollo móvil nativo implicaría un stack que el equipo no maneja, incompatible con el
  plazo disponible.

## Consecuencias

- El diseño de la interfaz debe ser responsive desde el inicio, no adaptado al final.
- Convertir la aplicación en PWA más adelante queda como una evolución de bajo costo, ya que
  parte del mismo desarrollo web.
