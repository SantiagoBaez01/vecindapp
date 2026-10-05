# 010 — Arquitectura monolítica en capas

**Fecha:** 04/10/2026 · **Estado:** aceptada

## Contexto

Antes de empezar a escribir código hay que definir cómo se organiza internamente la
aplicación: qué partes la componen, cómo se comunican y cómo se distribuye el código en
paquetes. La decisión condiciona todo el desarrollo de la Etapa 3 y es difícil de revertir una
vez que hay varios módulos escritos.

El contexto que la acota: un equipo de dos personas, siete semanas de desarrollo, un único
barrio de unos 500 usuarios, y un stack —Spring Boot con Thymeleaf— ya decidido en las
[decisiones 001](001-stack-backend.md) y [002](002-interfaz-en-servidor.md).

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Monolito en capas** (presentación / servicios / persistencia) | Es el modelo que Spring Boot asume por defecto. Separación clara de responsabilidades con poca ceremonia. El equipo ya trabajó así | Las capas pueden filtrarse entre sí si no se respeta la regla de dependencia |
| **Arquitectura hexagonal** (puertos y adaptadores) | Aísla el dominio de la infraestructura y facilita las pruebas | Mucha más estructura: interfaces y adaptadores por cada operación. El beneficio aparece cuando hay que intercambiar infraestructura, cosa que acá no va a pasar |
| **Microservicios** | Escalado y despliegue independientes por servicio | Sobreingeniería evidente para 500 usuarios y dos desarrolladores. Agrega red, orquestación y despliegues múltiples |
| **MVC sin capa de servicios** (lógica en los controladores) | Menos clases, más rápido al principio | La lógica queda atada a HTTP y se duplica entre controladores. Las reglas de negocio no se pueden probar sin levantar la web |

Para la organización de los paquetes se evaluaron además dos opciones:

| Opción | A favor | En contra |
|---|---|---|
| **Por capa** (`controller/`, `service/`, `repository/`) | Convención dominante en Spring. Ubicar una clase es inmediato | Los archivos de un mismo módulo quedan repartidos en varias carpetas |
| **Por módulo** (`prestador/` con su controller, service y repository adentro) | Cada módulo queda autocontenido; se corresponde con `modulos.md` | Menos convencional. Con seis módulos chicos el beneficio es marginal |

## Decisión

**Monolito en capas con MVC en la presentación**, y **paquetes organizados por capa**.

Las capas son: presentación (controladores y vistas Thymeleaf), servicios (reglas de negocio y
transacciones) y persistencia (repositorios y entidades), con la seguridad como componente
transversal. Rige la regla de que cada capa solo invoca a la inmediatamente inferior.

## Razones

- **Las capas resuelven el problema que tenemos.** El sistema necesita separar reglas de
  negocio de la entrega de páginas HTML, y eso es exactamente lo que da una arquitectura en
  capas. Agregar más estructura no resolvería ningún problema adicional del proyecto.
- **La capa de servicios no es opcional.** Reglas como "solo el residente que contrató puede
  reseñar, y solo sobre una solicitud finalizada" deben ser verificables de forma independiente
  de la interfaz. Poner esa lógica en los controladores la ataría a HTTP y la duplicaría.
- **Hexagonal no paga su costo acá.** Su ventaja es poder reemplazar infraestructura sin tocar
  el dominio. No está previsto cambiar de motor de base de datos ni de framework web, así que
  se pagaría la complejidad sin recibir el beneficio.
- **Paquetes por capa porque es la convención del framework.** Para dos personas que ya
  trabajaron así, la familiaridad pesa más que la prolijidad de agrupar por módulo. La
  correspondencia entre módulos y clases queda documentada en
  [`arquitectura.md`](../arquitectura.md), de modo que no se pierde la trazabilidad.

## Consecuencias

- Los archivos de un mismo módulo quedan repartidos entre `controller/`, `service/` y
  `repository/`. Se compensa con una convención de nombres consistente y con la tabla de
  correspondencia del documento de arquitectura.
- La regla de dependencia debe sostenerse de forma deliberada: un controlador que llame a un
  repositorio compila igual, pero rompe la arquitectura. Es un punto a revisar entre los dos.
- Si el proyecto creciera a varios barrios o a varios equipos, la organización por módulo pasaría
  a ser preferible. Se asume que esa migración, de ocurrir, sería un trabajo aparte.
