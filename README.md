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

## La propuesta

Una aplicación web, provista por el barrio a sus residentes, donde:

- La **administración** mantiene un catálogo de prestadores verificados y habilitados.
- El **residente** busca por rubro, consulta las reseñas de sus vecinos y solicita el
  servicio.
- Al finalizar el trabajo, el residente **deja una reseña** que queda disponible para todo el
  barrio.

El valor no está en digitalizar la búsqueda, sino en que la reputación deja de ser volátil y
pasa a acumularse: cada contratación mejora la información disponible para la siguiente.

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

- **Múltiples barrios.** La primera versión opera sobre un único barrio.
- **Aplicación móvil nativa y PWA.** La solución es una aplicación web responsive.
- **Gestión de accesos, validación de identidad y avisos a portería.** El barrio ya cuenta
  con sus propios mecanismos de control de ingreso; la plataforma no los reemplaza.
- **Pagos online.** El acuerdo económico entre residente y prestador ocurre fuera de la
  plataforma.
- **Mensajería en tiempo real** entre residente y prestador.
- **Verificación automática de matrículas o antecedentes.** La verificación es un acto
  administrativo humano; el sistema registra su resultado.

---

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

## Herramientas de gestión del proyecto

| Herramienta | Uso |
|---|---|
| **GitHub** | Repositorio único del proyecto: código, base de datos y documentación |
| **Trello** | Tablero de tareas, asignación y seguimiento de avance |
| **Discord** | Comunicación del equipo y con el tutor |

---

## Registro de decisiones

Las decisiones del proyecto —contexto, alternativas evaluadas, opción elegida y consecuencias—
se documentan en [`docs/decisiones/`](docs/decisiones/).

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
