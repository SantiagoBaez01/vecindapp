# Diagrama de base de datos

Representación del **modelo físico** de la base: las tablas tal como existen en MySQL, con sus
columnas, claves y cardinalidades.

> **Sobre la denominación.** Este diagrama no es un *diagrama entidad-relación* en el sentido
> estricto del término. Un DER describe el modelo conceptual —entidades y relaciones del
> dominio, sin comprometerse con una implementación— mientras que acá se representan tablas,
> columnas y claves foráneas, es decir el modelo físico ya resuelto para un motor relacional.
> El modelo orientado a objetos del dominio está en el [diagrama de clases](UML/diagrama_clases.md),
> que sí es UML.

---

## Diagrama

```mermaid
erDiagram
    usuario ||--o| residente : "tiene perfil de"
    usuario ||--o| prestador : "tiene perfil de"
    prestador ||--o{ prestador_rubro : "se asocia en"
    rubro ||--o{ prestador_rubro : "se asocia en"
    residente ||--o{ solicitud : "genera"
    prestador ||--o{ solicitud : "recibe"
    solicitud ||--o| resena : "puede tener"

    usuario {
        INT id PK
        VARCHAR email UK
        VARCHAR password
        VARCHAR telefono
        ENUM rol
        TIMESTAMP fecha_alta
    }
    residente {
        INT usuario_id PK_FK
        VARCHAR nombre_completo
        VARCHAR lote
        BOOLEAN estado
    }
    prestador {
        INT usuario_id PK_FK
        VARCHAR nombre_completo
        TEXT descripcion
        ENUM estado_verificacion
    }
    rubro {
        INT id PK
        VARCHAR nombre UK
    }
    prestador_rubro {
        INT prestador_id PK_FK
        INT rubro_id PK_FK
    }
    solicitud {
        INT id PK
        INT residente_id FK
        INT prestador_id FK
        TEXT descripcion_tarea
        ENUM estado
        TIMESTAMP fecha_creacion
        TIMESTAMP fecha_actualizacion
    }
    resena {
        INT id PK
        INT solicitud_id FK_UK
        INT calificacion
        TEXT comentario
        ENUM estado
        TIMESTAMP fecha_creacion
    }
```

---

## Cardinalidades

| Relación | Cardinalidad | Lectura |
|---|---|---|
| `usuario` — `residente` | 1 : 0..1 | Un usuario tiene como máximo un perfil de residente. Un perfil de residente pertenece a exactamente un usuario |
| `usuario` — `prestador` | 1 : 0..1 | Igual que el anterior. Un usuario es residente **o** prestador **o** administrador, nunca dos a la vez |
| `prestador` — `rubro` | N : M | Un prestador ofrece uno o más rubros; un rubro es ofrecido por cero o más prestadores. Se resuelve con la tabla intermedia `prestador_rubro` |
| `residente` — `solicitud` | 1 : N | Un residente genera cero o más solicitudes; cada solicitud pertenece a un único residente |
| `prestador` — `solicitud` | 1 : N | Un prestador recibe cero o más solicitudes; cada solicitud va dirigida a un único prestador |
| `solicitud` — `resena` | 1 : 0..1 | Una solicitud puede tener como máximo una reseña. La restricción `UNIQUE` sobre `resena.solicitud_id` es lo que garantiza ese máximo |

---

## Decisiones reflejadas en el modelo

- La relación N a M entre prestador y rubro, y los campos `prestador.descripcion` y
  `resena.estado`, provienen de la [decisión 008](decisiones/008-ajustes-modelo-de-datos.md).
- El criterio por el cual algunos conjuntos cerrados se modelan como `ENUM` y el rubro como
  tabla propia está en la [decisión 009](decisiones/009-enumeraciones-vs-tablas.md).
- La elección de un motor relacional está justificada en la
  [decisión 003](decisiones/003-base-de-datos-relacional.md).

## Archivos relacionados

| Archivo | Contenido |
|---|---|
| [`db/schema.sql`](../db/schema.sql) | Definición de las tablas (DDL) |
| [`db/data.sql`](../db/data.sql) | Datos semilla |
| [`diccionario_datos.md`](diccionario_datos.md) | Detalle de cada columna, tipo y restricción |
| [`diagrama-base-de-datos.png`](diagrama-base-de-datos.png) | Exportación del mismo modelo como imagen |
