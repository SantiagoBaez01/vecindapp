# 007 — El componente en la nube es únicamente la base de datos

**Fecha:** 27/08/2026 · **Estado:** aceptada

## Contexto

El cursado exige que al menos un componente principal del proyecto esté alojado y funcionando
en un servicio en la nube o servidor online. Hay que decidir qué componente se despliega y con
qué herramientas, considerando que ningún integrante tiene experiencia previa en despliegue en
la nube ni en contenedores.

## Alternativas

| Opción | A favor | En contra |
|---|---|---|
| **Solo la base de datos gestionada** | Cumple el requisito. Es el componente cuya persistencia realmente importa. Se resuelve con una cadena de conexión | La aplicación no queda accesible públicamente |
| **Aplicación en un PaaS + base gestionada** | Demo accesible desde una URL pública | Suma una plataforma nueva que aprender, y en varios proveedores exige contenerizar |
| **Todo contenerizado con Docker** | Entorno reproducible entre los dos integrantes | Dos curvas de aprendizaje simultáneas (contenedores y despliegue) para un equipo de dos personas con fecha fija |

## Decisión

Se aloja la base de datos MySQL en un servicio gestionado (Aiven). La aplicación se ejecuta
localmente. No se adopta Docker ni despliegue en PaaS.

## Razones

- Cumple el requisito del cursado, que pide explícitamente al menos un componente en la nube
  y menciona la base de datos como una opción válida.
- Es el componente cuya persistencia importa: los datos sobreviven al entorno de desarrollo.
- No introduce una tecnología nueva sino una configuración. Crear el servicio y apuntar la
  cadena de conexión no requiere aprender una plataforma.
- Comprometer contenedores y PaaS implicaría dos aprendizajes simultáneos que competirían con
  el tiempo de desarrollo del MVP.

## Consecuencias

- La demostración del sistema se hace ejecutando la aplicación localmente contra la base
  gestionada.
- Cada integrante debe tener MySQL instalado localmente para desarrollar sin depender del
  servicio remoto.
- Desplegar la aplicación en un PaaS queda como mejora deseable si el cronograma lo permite.
- Si el nivel gratuito del servicio dejara de estar disponible, el sistema sigue siendo
  ejecutable contra una base local sin cambios en el código.
