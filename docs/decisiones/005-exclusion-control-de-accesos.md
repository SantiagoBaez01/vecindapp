# 005 — Exclusión del control de accesos y la validación de identidad

**Fecha:** 27/08/2026 · **Estado:** aceptada

## Contexto

El planteo inicial del problema incluía la fricción del ingreso de prestadores al barrio:
autorizaciones caso por caso, verificación en portería y avisos al personal de seguridad. Una
línea posible era que la plataforma gestionara ese circuito —pre-autorizaciones, avisos al
portero, validación de identidad—. Al revisarlo en la reunión de tutoría del 27/08/2026 se
señaló que los barrios privados ya cuentan con mecanismos propios para eso.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Incluir la gestión de accesos** | Cubriría el circuito completo de la contratación | Duplica funcionalidad que el barrio ya tiene resuelta. Amplía el alcance sobre un terreno con requisitos de seguridad propios |
| **Excluirla del alcance** | Concentra el esfuerzo en lo que hoy no existe: el catálogo verificado y la reputación | Deja fuera una parte visible del problema descrito |

## Decisión

La plataforma no gestiona accesos, no emite autorizaciones de ingreso, no avisa a portería y
no valida la identidad de los prestadores. El sistema registra que la administración habilitó
a un prestador; el control físico del ingreso permanece donde está hoy.

## Razones

- Es funcionalidad que el barrio ya resuelve, sea con un sistema propio o con registros en
  papel. Reimplementarla no agrega valor y sí agrega alcance.
- La validación de identidad y los antecedentes son un acto administrativo humano. El sistema
  registra su resultado, no lo produce.
- Concentra el proyecto en la parte del problema que efectivamente no tiene solución hoy: que
  la reputación de los prestadores no se acumula en ningún lado.

## Consecuencias

- La verificación de un prestador se modela como un estado que la administración fija, sin
  circuito de validación asociado.
- Integrar la plataforma con el control de accesos existente del barrio queda como una
  evolución posible, no comprometida.
