# Vecindapp

Aplicación web de catálogo de oficios para un barrio privado. Los residentes contratan
servicios de prestadores previamente **verificados y habilitados por la administración del
barrio**, con reseñas dejadas por vecinos que efectivamente contrataron.

> **Trabajo Final Integrador** — Tecnicatura Universitaria en Programación a Distancia
> Universidad Tecnológica Nacional (UTN)

---

## Integrantes

| Integrante | GitHub |
|---|---|
| Santiago Baez | [@SantiagoBaez01](https://github.com/SantiagoBaez01) |
| Santiago Arroquigaray | [@Pitdog192](https://github.com/Pitdog192) |

**Grupo:** Grupo119 · **Tutor:** Santiago Fonzo

---

## El problema

En un barrio privado, contratar un oficio tiene dos fricciones que no existen fuera del
barrio:

1. **No hay un registro de a quién contratar.** La recomendación circula de manera informal
   —grupo de mensajería, cartelera, boca a boca— y no acumula historial: se pierde en el
   scroll y cada contratación se resuelve como si fuera la primera.
2. **No hay forma de saber si el prestador es confiable.** El residente no conoce a quien va
   a entrar a su casa, y no tiene manera de evaluar trabajos anteriores.

El barrio genera esa información cada vez que alguien contrata un servicio, pero no la
capitaliza. Quién trabajó bien y quién no, hoy no queda registrado en ningún lado.

### Dimensionamiento del problema

> **Cómo leer estas cifras.** El proyecto es de inventiva propia y no cuenta con un cliente
> real, por lo que los valores siguientes son **estimaciones construidas sobre supuestos
> declarados**, no mediciones de campo. Se explicitan los parámetros para que puedan
> discutirse y corregirse, y funcionan como **línea de base** contra la cual medir la mejora
> una vez implementada la solución.

**Supuestos del modelo**

| Parámetro | Valor | Origen |
|---|---|---|
| Viviendas del barrio de referencia | 300 | Tamaño habitual de un barrio privado mediano |
| Contrataciones de oficio por vivienda al mes | 0,5 | Supuesto |
| Contrataciones mensuales en el barrio | ~150 | Derivado de los dos anteriores |
| Tiempo que dedica el residente a decidir a quién contratar | ~30 min | Supuesto: lectura del grupo, consultas y espera de respuestas |

**Línea de base: el problema hoy**

| Componente del problema | Indicador | Valor actual |
|---|---|---|
| La búsqueda es dispersa | Tiempo desde que surge la necesidad hasta decidir a quién contratar | ~30 min de dedicación, con esperas de horas |
| La reputación es volátil | Porcentaje de contrataciones que dejan un registro consultable por el resto del barrio | **0 %** |
| El canal se satura | Pedidos de oficio publicados por mes en el grupo de mensajería | ~150 |

El segundo indicador es el más relevante: es el único que **no mejora** por más personal
administrativo que se destine, porque el problema no es de capacidad sino de que la
información no se registra en ningún lado.

**Efecto esperado de la implementación**

| Indicador | Hoy | Con la plataforma |
|---|---|---|
| Tiempo hasta decidir a quién contratar | ~30 min y espera de respuestas | Búsqueda filtrada por rubro, en minutos |
| Contrataciones que dejan registro consultable | 0 % | ≥ 40 % (ver criterios de éxito) |
| Pedidos de oficio en el grupo de mensajería | ~150 por mes | Reducción estimada del 50 % |

**Cómo se validan estos supuestos.** Antes de comenzar la etapa de desarrollo se prevé
consultar a un grupo reducido de residentes de barrios privados sobre dos preguntas concretas:
cuántas veces al mes contratan un oficio, y cuánto tardan en conseguir a alguien de confianza.
Con esas respuestas los parámetros de la primera tabla dejan de ser supuestos y la línea de
base queda contrastada.

## La propuesta

Una aplicación web, provista por el barrio a sus residentes, donde:

- La **administración** mantiene un catálogo de prestadores verificados y habilitados.
- El **residente** busca por rubro, consulta las reseñas de sus vecinos y solicita el
  servicio.
- Al finalizar el trabajo, el residente **deja una reseña** que queda disponible para todo el
  barrio.

El valor no está en digitalizar la búsqueda, sino en que la reputación deja de ser volátil y
pasa a acumularse: cada contratación mejora la información disponible para la siguiente.

## Objetivos del Proyecto

- Reducir el tiempo que invierte un residente en encontrar un prestador confiable, pasando de esperar respuestas en un chat, tal vez por horas, a realizar una búsqueda filtrada en minutos.

- Centralizar la oferta de servicios exclusivamente en prestadores que ya pasaron por el filtro administrativo del barrio.

- Transformar las recomendaciones volátiles del boca a boca vecinal en un historial de reputación acumulativo y permanente.

## Criterios de Éxito
- 100% de los prestadores listados en el catálogo cuentan con estado verificado y habilitado por la administración del barrio.

- Al menos un 40% de los servicios finalizados a través de la plataforma generan una reseña, construyendo la base de confianza.

- Reducción estimada del 50% en la frecuencia de mensajes tipo "alguien conoce un plomero" en los grupos de mensajería del barrio, limpiando el ruido de los canales de comunicación informales.

---

## Alcance

### Incluido

- Gestión de usuarios y autenticación con tres roles: **residente**, **prestador** y
  **administración**.
- **Padrón de residentes**, administrado por el barrio. Solo los residentes del padrón
  acceden al catálogo.
- **Alta de prestadores** y circuito de **verificación y habilitación** a cargo de la
  administración.
- **Catálogo de oficios** con filtro por rubro, búsqueda y ficha de detalle del prestador.
- **Solicitudes de servicio** con seguimiento de estados: pendiente, presupuestado,
  aceptado, cancelado y finalizado.
- **Reseñas y calificaciones**, habilitadas únicamente al residente que contrató y solo
  sobre solicitudes finalizadas.
- **Panel de administración**: padrón, habilitación de prestadores y moderación de reseñas.
- **Base de datos alojada en un servicio en la nube.**

### Fuera de alcance

#### Posibles extensiones a futuro
- **Múltiples barrios.** La primera versión opera sobre un único barrio. Posible extensión a más barrios en el futuro.
- **Aplicación móvil nativa y PWA.** La solución es una aplicación web responsive. Posibilidad de extenderse a Aplicación móvil nativa para instalar desde Play Store o Apple Store (Generan más confianza que una PWA).
- **Pagos online.** El acuerdo económico entre residente y prestador ocurre fuera de la
  plataforma. En una posible extensión a futuro podría acordarse por la plataforma el método de pago que luego se utilizará por fuera de la plataforma, lo cual sería más cómodo para ambos usuarios la preparación del pago.
- **Mensajería en tiempo real** entre residente y prestador. En una posible extensión a futuro podría utilizarse un sistema de mensajería interno en tiempo real con websockets para tener centralizada la comunicación entre usuarios, para no tener que cambiar y/o utilizar distintas plataformas (Whatsapp, Telegram).

#### Descartado definitivamente
- **Gestión de accesos, validación de identidad y avisos a portería.** El barrio ya cuenta
  con sus propios mecanismos de control de ingreso; la plataforma no los reemplaza.
- **Verificación automática de matrículas o antecedentes.** La verificación es un acto
  administrativo humano; el sistema registra su resultado.

---
## Análisis de Competencia

En el contexto de un barrio privado, el competidor directo de esta plataforma no es una aplicación comercial externa, sino **los métodos y canales informales** que los vecinos utilizan actualmente para resolver el problema de contratación.

* **Grupos de mensajería vecinales como WhatsApp o Telegram**
  * *La ventaja:* Inmediatez y costumbre de uso.
  * *La desventaja:* La información es fugaz y se pierde rápidamente en el historial de chat. No existe un sistema de calificación objetivo, la recomendación de un mal trabajo es difícil de rastrear, y los pedidos constantes de oficios generan "ruido" en grupos que se saturan.
* **Cartelera física o boletín estático de la administración:**
  * *La ventaja:* Garantiza que los prestadores listados están autorizados.
  * *La desventaja:* Es una comunicación unidireccional. No hay métricas, no hay interacción y no existe manera de que un vecino se entere si el trabajo de ese prestador fue excelente o deficiente.
* **El boca a boca tradicional:**
  * *La ventaja:* Alta confianza personal.
  * *La desventaja:* Alcance extremadamente limitado, reduciendo las opciones del residente únicamente a sus vecinos más inmediatos.

**Ventaja competitiva de Vecindapp:**
La plataforma centraliza lo mejor de las alternativas actuales: mantiene la **seguridad** del control administrativo como la cartelera y captura la **confianza** de la recomendación vecinal, pero transformando ese dato en un activo digital persistente, filtrable y acumulativo para toda la comunidad.

----
## Análisis de Viabilidad

* **Viabilidad Técnica:** El riesgo tecnológico es bajo. Se va a usar el stack con Java 21, Spring Boot, Thymeleaf y MySQL 8, que ya manejamos gracias a la trayectoria en la tecnicatura. La decisión consciente de evitar arquitecturas distribuidas, APIs separadas del frontend y despliegues complejos en contenedores garantiza que el esfuerzo técnico se centre en resolver la lógica de negocio y no en la configuración de la infraestructura.
* **Viabilidad Temporal:** El cronograma proyectado es realista para un equipo de dos personas. Al haber acotado formalmente el alcance, los seis módulos entran en las 7 semanas de codificación y pruebas de la Etapa 3, a razón de un módulo por semana, con la última reservada para pruebas, informe y video. El margen para imprevistos lo da la política de recorte por prioridades definida más abajo, no la holgura del cronograma.
* **Viabilidad de Dominio:** El proyecto es de inventiva propia y no cuenta con un cliente real. Las reglas de negocio, el circuito de habilitaciones y los puntos de fricción descritos se apoyan en el funcionamiento observable de los barrios privados y en los supuestos declarados en [Dimensionamiento del problema](#dimensionamiento-del-problema), no en un relevamiento de campo ya realizado. Está previsto contrastarlos consultando a un grupo reducido de residentes antes de comenzar la etapa de desarrollo. Se considera una viabilidad razonable porque el dominio es accesible —no requiere conocimiento especializado ni acceso privilegiado a información— y porque ninguna decisión de diseño depende de un dato que hoy no se tenga.

----
## Riesgos y Mitigaciones

Para asegurar la entrega del Trabajo Final Integrador en la fecha pautada, se identificaron los siguientes riesgos y sus respectivas estrategias de mitigación. En caso de desvíos en el cronograma, se aplicará una política de recorte basada en prioridades.

### Priorización del Alcance
En caso de tener que reducir el alcance por falta de tiempo, el desarrollo se recortará de abajo hacia arriba según la siguiente lista de prioridades:
1. **Prioridad Alta (Innegociable):** Autenticación, padrón de residentes, ABM de prestadores y catálogo público. Creación de solicitudes de prestación de servicio.
2. **Prioridad Media:** Sistema de reseñas para trabajos finalizados.
3. **Prioridad Baja (Recortable):** Panel de moderación avanzado de reseñas para la administración y filtros complejos en el catálogo.

### Matriz de Riesgos

* **Atraso en el cronograma.**
  * *Impacto:* Alto.
  * *Probabilidad:* Media.
  * *Mitigación:* Se aplicará estrictamente la lista de prioridades definida arriba. Si el tiempo escasea, la moderación de reseñas se gestionará directamente a nivel de base de datos y se descartará su interfaz gráfica administrativa, garantizando que el flujo principal funcione para la presentación.
* **Curva de aprendizaje en la maquetación con Thymeleaf.**
  * *Impacto:* Medio, tecnología con experiencia parcial o nula.
  * *Probabilidad:* Alta.
  * *Mitigación:* Se priorizará la funcionalidad sobre la estética. Se utilizará un framework CSS estándar, evitando invertir tiempo en diseños personalizados.
* **Problemas con el nivel gratuito de la base de datos en Aiven.**
  * *Impacto:* Medio.
  * *Probabilidad:* Baja.
  * *Mitigación:* Si la instancia gestionada falla o se suspende, la demostración y evaluación del proyecto se realizará ejecutando el sistema contra una base de datos MySQL local sin que esto afecte el código ni el modelo de datos.

----

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| **Lenguaje de backend** | Java 21 (LTS) |
| **Framework de backend** | Spring Boot 3.x |
| **Persistencia** | Spring Data JPA / Hibernate |
| **Seguridad** | Spring Security |
| **Lenguajes de frontend** | HTML · CSS · JavaScript |
| **Motor de plantillas** | Thymeleaf (renderizado del lado del servidor) |
| **Base de datos** | MySQL 8 (relacional) |
| **Servicio en la nube** | Base de datos MySQL gestionada en Aiven |

### Por qué

- **Java y Spring Boot** son el lenguaje y el framework que el equipo maneja. El problema es
  una aplicación web transaccional con lógica de negocio, roles y permisos —no un sistema de
  alta concurrencia ni de procesamiento de datos—, que es el escenario donde Spring Boot es
  una opción sólida.
- **Thymeleaf** porque la aplicación son formularios, listados y vistas de detalle, sin
  interacción en tiempo real. El renderizado del lado del servidor resuelve ese perfil sin
  sumar un segundo runtime, un build aparte y una API REST que el alcance no requiere.
- **MySQL** porque los datos tienen estructura estable, las relaciones entre entidades son
  centrales (residente → solicitud → prestador → reseña) y se necesita integridad
  transaccional.
- **Aiven** provee MySQL gestionado con nivel gratuito, cubriendo el requisito de contar con
  un componente alojado en un servicio online.

La escala esperada es de un barrio, del orden de 500 usuarios. No se adopta una arquitectura
distribuida ni contenedores: para este volumen serían sobreingeniería.

---

## Arquitectura

**Aplicación monolítica organizada en capas, con el patrón MVC en la capa de presentación.**

| Capa | Responsabilidad |
|---|---|
| **Presentación** | Controladores Spring MVC y vistas Thymeleaf. Reciben la petición, validan el formato de la entrada y eligen la vista |
| **Servicios** | Reglas de negocio y límites de las transacciones. Es donde vive, por ejemplo, la regla de que solo el residente que contrató puede reseñar |
| **Persistencia** | Repositorios Spring Data JPA y entidades |
| **Seguridad** | Spring Security, de forma transversal: autenticación y autorización por rol sobre rutas y métodos |

Cada capa invoca únicamente a la inmediatamente inferior: un controlador nunca accede a un
repositorio de forma directa. Los paquetes se organizan por capa (`controller/`, `service/`,
`repository/`, `entity/`).

El documento completo —con los diagramas de capas, de dependencias entre módulos y del flujo
crítico de contratación— está en [`docs/arquitectura.md`](docs/arquitectura.md). La
justificación de la elección, con las alternativas evaluadas, en la
[decisión 010](docs/decisiones/010-arquitectura-en-capas.md).

---

## Herramientas de gestión del proyecto

| Herramienta | Uso |
|---|---|
| **GitHub** | Repositorio único del proyecto: código, base de datos y documentación |
| **Trello** | Tablero de tareas, asignación y seguimiento de avance |
| **Discord** | Comunicación del equipo y con el tutor |

---

## Documentación del proyecto

| Documento | Contenido |
|---|---|
| [Módulos del sistema](docs/modulos.md) | Listado de módulos a desarrollar, con responsabilidad, funcionalidades, entidades y prioridad |
| [Arquitectura de la aplicación](docs/arquitectura.md) | Estilo arquitectónico, capas, responsabilidades, organización del código y flujo crítico |
| [Diagrama de base de datos](docs/diagrama-base-de-datos.md) | Modelo físico de la base, con cardinalidades explícitas |
| [Diagrama de clases (UML)](docs/UML/diagrama_clases.md) | Modelo de dominio orientado a objetos del backend, en Mermaid |
| [Diccionario de datos](docs/diccionario_datos.md) | Detalle de cada tabla y columna |
| [Scripts de base de datos](db/) | `schema.sql` (DDL), `data.sql` (datos semilla) y la regla de sincronización del esquema |
| [Registro de decisiones](docs/decisiones/) | Cada decisión del proyecto con su contexto, alternativas evaluadas, opción elegida y consecuencias |

---

## Plan de trabajo

### Etapa 1 — Propuesta y repositorio · hasta el 30/08

| Tarea | Estimación |
|---|---|
| Definición del problema, la propuesta y el alcance | 4 días |
| Definición y justificación del stack tecnológico | 2 días |
| Creación del repositorio y documentación en el README | 1 día |

### Etapa 2 — Diseño y módulos · 31/08 al 27/09

| Tarea | Estimación |
|---|---|
| Modelo de datos: diagrama entidad-relación y diccionario de datos | 1 semana |
| Definición y documentación de los módulos del sistema | 1 semana |
| Script DDL del esquema y datos de prueba | 1 semana |
| Esqueleto del proyecto y entorno de desarrollo | 1 semana |

### Etapa 3 — Desarrollo, despliegue e informe · 28/09 al 14/11

| Tarea | Estimación |
|---|---|
| Autenticación, roles y padrón de residentes | 1 semana |
| Módulo de prestadores y circuito de verificación | 1 semana |
| Catálogo: listado, filtro por rubro y ficha de detalle | 1 semana |
| Solicitudes de servicio y seguimiento de estados | 1 semana |
| Reseñas, calificaciones y moderación | 1 semana |
| Panel de administración y base de datos en la nube | 1 semana |
| Pruebas, informe final y video explicativo | 1 semana |

### Seguimiento

Reunión con el tutor cada 15 días o luego de cada entregable. El avance de las tareas se
registra en el tablero de Trello, con acceso de lectura para el tutor.
