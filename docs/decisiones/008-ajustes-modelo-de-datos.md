# 008 — Ajustes al modelo de datos tras la definición de módulos

**Fecha:** 14/09/2026 · **Estado:** aceptada
**Modifica:** el esquema entregado el 10/09/2026

## Contexto

Al definir el alcance de cada módulo en [`modulos.md`](../modulos.md) se contrastó el esquema
de base de datos contra las funcionalidades comprometidas en el README. Aparecieron tres
desajustes entre lo que el modelo permite y lo que los módulos necesitan hacer.

Se resuelven ahora, antes de que el esquema pase a revisión del tutor y antes de comenzar el
desarrollo, para no arrastrar cambios estructurales con código ya escrito encima.

---

## 1. Un prestador podía ofrecer un solo rubro

**Situación.** `prestador.rubro_id` era una clave foránea simple, de modo que cada prestador
quedaba asociado a un único oficio. En el rubro de los servicios para el hogar es habitual que
una misma persona cubra más de uno: plomería y gas es la combinación más común.

**Alternativas**

| Opción | A favor | En contra |
|---|---|---|
| **Mantener un rubro único** | Modelo y consultas más simples | Obliga a cargar dos veces al mismo prestador, duplicando su ficha y partiendo sus reseñas entre ambos registros |
| **Tabla intermedia `prestador_rubro`** | Refleja la realidad del oficio. Una sola ficha por persona, con toda su reputación concentrada | Agrega una tabla y un join en el filtrado del catálogo |
| **Campo de texto con rubros separados por coma** | Sin tablas nuevas | Impide filtrar por rubro de forma confiable, que es la funcionalidad central de M3 |

**Decisión.** Tabla intermedia `prestador_rubro`, con clave primaria compuesta.

**Razones.** La duplicación de fichas rompería lo que da valor al producto: si un plomero-gasista
figura dos veces, sus reseñas quedan repartidas y ningún registro refleja su reputación real. El
costo del cambio es una tabla y un join; el costo de no hacerlo lo paga el usuario.

---

## 2. No había forma de moderar una reseña

**Situación.** El alcance del README incluye la moderación de reseñas y el módulo M6 la tiene
entre sus funcionalidades, pero la tabla `resena` no tenía ningún campo que permitiera retirar
una reseña inapropiada.

**Alternativas**

| Opción | A favor | En contra |
|---|---|---|
| **Borrar el registro** | Sin cambios en el esquema | Se pierde la evidencia. No queda constancia de qué se moderó ni por qué, y el residente podría volver a cargarla |
| **Campo de estado `VISIBLE` / `OCULTA`** | Conserva el registro y permite revertir la decisión | Obliga a filtrar por estado en toda consulta de reseñas |

**Decisión.** Campo `estado ENUM('VISIBLE','OCULTA')`, con `VISIBLE` por defecto.

**Razones.** Ocultar sin borrar mantiene la trazabilidad y hace reversible un error de
moderación. Además la restricción `UNIQUE` sobre `solicitud_id` sigue impidiendo que se cargue
una reseña nueva para reemplazar la ocultada.

---

## 3. La ficha del prestador no tenía contenido

**Situación.** El módulo M3 compromete una "ficha de detalle del prestador", pero la tabla solo
guardaba nombre y estado de verificación. Con eso la ficha no se distingue de una fila del
listado.

**Alternativas**

| Opción | A favor | En contra |
|---|---|---|
| **Campo `descripcion` de texto libre** | Simple; el prestador cuenta lo que ofrece con sus palabras | Sin estructura para filtrar por su contenido |
| **Campos estructurados** (años de experiencia, matrícula, zona) | Permite filtros más precisos | Amplía el alcance del módulo y obliga a decidir qué campos son obligatorios |

**Decisión.** Un campo `descripcion TEXT` opcional.

**Razones.** Es lo mínimo que vuelve útil la ficha sin ampliar el alcance. Los datos de contacto
ya están en `usuario.telefono`, y estructurar más campos no aporta al MVP: el filtro que importa
es por rubro, y ese ya está resuelto.

---

## Consecuencias

- Se actualizaron `db/schema.sql`, `db/data.sql` y `docs/diccionario_datos.md`.
- **El diagrama `docs/diagrama-base-de-datos.png` quedó desactualizado y debe regenerarse** para incorporar la
  tabla `prestador_rubro` y los campos nuevos.
- Cada integrante debe recrear su base local siguiendo la regla de [`db/README.md`](../../db/README.md):
  `DROP DATABASE`, crearla de nuevo y correr los scripts actualizados desde `main`.
- Los datos semilla incluyen ahora un prestador con dos rubros, para que el caso quede cubierto
  desde el primer arranque.
- El filtrado del catálogo en M3 pasa a resolverse con un join contra `prestador_rubro`.
