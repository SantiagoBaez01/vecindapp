# Base de Datos — Vecindapp

Esta carpeta contiene los scripts necesarios para inicializar la base de datos relacional del proyecto.

* `schema.sql`: Estructura de las tablas (DDL).
* `data.sql`: Datos semilla para pruebas (DML).

## ⚠️ Regla de Actualización Manual del Esquema

Como se estableció en las decisiones de arquitectura, **no se utilizan herramientas de migración automatizadas** (como Flyway o Liquibase) para mantener la simplicidad del proyecto. 

Por lo tanto, el equipo acuerda el siguiente flujo de trabajo para cualquier cambio en la base de datos (agregar una columna, cambiar un tipo de dato, crear una tabla nueva):

1. **Actualizar los scripts:** El cambio no se hace solo en el motor local; debe escribirse explícitamente en `schema.sql` (y en `data.sql` si afecta a los datos semilla iniciales).
2. **Comunicación obligatoria:** Quien haga una modificación estructural debe avisar inmediatamente al otro integrante por Discord o Whatsapp.
3. **Recrear el entorno local:** Ante un aviso de cambio, el otro integrante debe hacer un `DROP DATABASE`, volver a crearla y correr los scripts `schema.sql` y `data.sql` actualizados desde la rama `main` para sincronizarse.