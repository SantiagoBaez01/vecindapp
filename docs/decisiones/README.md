# Registro de decisiones

Cada archivo documenta una decisión del proyecto: el problema que la originó, las
alternativas consideradas, la opción elegida y sus consecuencias.

El objetivo es que cualquier decisión pueda reconstruirse más adelante sin depender de la
memoria del equipo, y que quede explícito el criterio detrás de cada elección.

| # | Decisión | Fecha |
|---|---|---|
| [001](001-stack-backend.md) | Java 21 y Spring Boot 3 para el backend | 26/08/2026 |
| [002](002-interfaz-en-servidor.md) | Interfaz renderizada en el servidor con Thymeleaf | 26/08/2026 |
| [003](003-base-de-datos-relacional.md) | Base de datos relacional MySQL 8 | 26/08/2026 |
| [004](004-alcance-un-barrio.md) | Alcance inicial limitado a un único barrio | 27/08/2026 |
| [005](005-exclusion-control-de-accesos.md) | Exclusión del control de accesos y la validación de identidad | 27/08/2026 |
| [006](006-aplicacion-web-sin-movil.md) | Aplicación web responsive, sin versión móvil ni PWA | 27/08/2026 |
| [007](007-nube-solo-base-de-datos.md) | El componente en la nube es únicamente la base de datos | 27/08/2026 |
| [008](008-ajustes-modelo-de-datos.md) | Ajustes al modelo de datos tras la definición de módulos | 14/09/2026 |
| [009](009-enumeraciones-vs-tablas.md) | Enumeraciones frente a tablas de referencia | 04/10/2026 |
| [010](010-arquitectura-en-capas.md) | Arquitectura monolítica en capas | 04/10/2026 |

## Formato

```
Contexto      El problema o la situación que obliga a decidir
Alternativas  Las opciones evaluadas, con lo que ofrece cada una
Decisión      La opción elegida
Razones       Por qué se eligió esa y no las otras
Consecuencias Qué implica, incluyendo lo que se resigna
```
